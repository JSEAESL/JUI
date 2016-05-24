/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.sample
{
	import flash.display.Bitmap;
	import flash.display3D.Context3D;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import jp.live2d.framework.*;
	import jp.live2d.utils.FileManager;
	import jp.live2d.utils.MatrixStack;
	import jp.live2d.utils.ModelSetting;
	import jp.live2d.utils.ModelSettingJson;
	import jp.live2d.utils.OffscreenImage;
	import jp.live2d.utils.Stage3DUtil;
	import jp.live2d.Live2DModelAs3;
	import jp.live2d.motion.AMotion;
	import jp.live2d.motion.Live2DMotion;
	import jp.live2d.util.UtSystem;
	
	public class LAppModel extends L2DBaseModel
	{
		
		private var modelHomeDir:String;
		private var modelSetting:ModelSetting;
		
		private var tmpMatrix:Vector.<Number> ;
		
		// 音声
		private var voice:Sound;
		
		public function LAppModel()
		{
			if (LAppDefine.DEBUG_LOG) 
			{
				debugMode = true;
			}
		}
		
		/*
		 * モデルを初期化する
		 * @param gl
		 */
		internal function load(context3D:Context3D, modelSettingPath:String):void
		{
			updating = true;
			initialized = false;
			
			modelHomeDir = modelSettingPath.substring(0, modelSettingPath.lastIndexOf("/") + 1); //live2d/model/xxx/
			
			var data:Object = FileManager.openEmbedFile(modelSettingPath);
			modelSetting = new ModelSettingJson(String(data));
			
			if (LAppDefine.DEBUG_LOG)
				trace("Load Live2D Model.");
			
			loadModelData(modelHomeDir + modelSetting.getModelFile());
			
			var texPaths:Vector.<String> = new Vector.<String>;
			for (var i:int = 0; i < modelSetting.getTextureNum(); i++)
			{
				loadTexture(i,modelHomeDir + modelSetting.getTextureFile(i));
			}
			
			// 表情
			if (modelSetting.getExpressionNum() > 0)
			{
				var expPaths:Vector.<String> = new Vector.<String>;
				for (i = 0; i < modelSetting.getExpressionNum(); i++)
				{
					loadExpression(modelSetting.getExpressionName(i),modelHomeDir + modelSetting.getExpressionFile(i));
				}
			}
			else
			{
				expressionManager = null;
				expressions = null;
			}
			
			// 自動目パチ
			if (eyeBlink == null)
			{
				eyeBlink = new L2DEyeBlink();
			}
			
			// 物理演算
			if (modelSetting.getPhysicsFile() != null)
			{
				loadPhysics(modelHomeDir + modelSetting.getPhysicsFile());
			}
			else
			{
				physics = null;
			}
			
			// パーツ切り替え
			if (modelSetting.getPoseFile() != null)
			{
				loadPose(modelHomeDir + modelSetting.getPoseFile());
			}
			else
			{
				pose = null;
			}
			
			// レイアウト
			if (modelSetting.getLayout() != null)
			{
				var layout:Object = modelSetting.getLayout();
				if (layout["width"] != null)
					modelMatrix.setWidth(layout["width"]);
				if (layout["height"] != null)
					modelMatrix.setHeight(layout["height"]);
				
				if (layout["x"] != null)
					modelMatrix.setX(layout["x"]);
				if (layout["y"] != null)
					modelMatrix.setY(layout["y"]);
				if (layout["center_x"] != null)
					modelMatrix.centerX(layout["center_x"]);
				if (layout["center_y"] != null)
					modelMatrix.centerY(layout["center_y"]);
				if (layout["top"] != null)
					modelMatrix.top(layout["top"]);
				if (layout["bottom"] != null)
					modelMatrix.bottom(layout["bottom"]);
				if (layout["left"] != null)
					modelMatrix.left(layout["left"]);
				if (layout["right"] != null)
					modelMatrix.right(layout["right"]);
			}
			
			for (i = 0; i < modelSetting.getInitParamNum(); i++)
			{
				live2DModel.setParamFloat(modelSetting.getInitParamID(i), modelSetting.getInitParamValue(i));
			}
			
			for (i = 0; i < modelSetting.getInitPartsVisibleNum(); i++)
			{
				live2DModel.setPartsOpacity(modelSetting.getInitPartsVisibleID(i), modelSetting.getInitPartsVisibleValue(i));
			}
			live2DModel.saveParam();
			(live2DModel as Live2DModelAs3).setGraphicsContext(context3D);
			
			// アイドリングはあらかじめ読み込んでおく。
			preloadMotionGroup(LAppDefine.MOTION_GROUP_IDLE);
			mainMotionManager.stopAllMotions();
			
			updating = false; // 更新状態の完了
			initialized = true; // 初期化完了
		}
		
		
		/*
		 * GCだけで解放されないメモリを解放
		 */
		public function release():void
		{
			(live2DModel as Live2DModelAs3).deleteTextures();
		}
		
		
		/*
		 * モーションファイルをあらかじめ読み込む
		 * @param	name
		 */
		internal function preloadMotionGroup(name:String):void
		{
			for (var i:int = 0; i < modelSetting.getMotionNum(name); i++)
			{
				var file:String = modelSetting.getMotionFile(name, i);
				var motion:AMotion = loadMotion(file,modelHomeDir + file);
				motion.setFadeIn(modelSetting.getMotionFadeIn(name, i));
				motion.setFadeOut(modelSetting.getMotionFadeOut(name, i));
			}
		}
		
		
		internal function update():void
		{
			if (live2DModel == null)
			{
				if (LAppDefine.DEBUG_LOG)
					trace("Failed to update.");
				return;
			}
			
			var timeMSec:Number = UtSystem.getUserTimeMSec() - startTimeMSec;
			var timeSec:Number = timeMSec / 1000.0;
			var t:Number = timeSec * 2 * Math.PI; // 2πt
			
			// 待機モーション判定
			if (mainMotionManager.isFinished())
			{
				// モーションの再生がない場合、待機モーションの中からランダムで再生する
				startRandomMotion(LAppDefine.MOTION_GROUP_IDLE, LAppDefine.PRIORITY_IDLE);
				
			}
			//-----------------------------------------------------------------		
			live2DModel.loadParam(); // 前回セーブされた状態をロード
			
			var update:Boolean = mainMotionManager.updateParam(live2DModel); // モーションを更新
			if (!update)
			{
				// メインモーションの更新がないとき
				eyeBlink.updateParam(live2DModel); // 目パチ
			}
			
			live2DModel.saveParam(); // 状態を保存
			//-----------------------------------------------------------------
			
			if (expressionManager != null)
				expressionManager.updateParam(live2DModel); //  表情でパラメータ更新（相対変化）
			
			dragMgr.update(); // ドラッグ用パラメータの更新
				
			// ドラッグによる顔の向きの調整
			live2DModel.addToParamFloat(L2DStandardID.PARAM_ANGLE_X, dragMgr.getX() * 30, 1); // -30から30の値を加える
			live2DModel.addToParamFloat(L2DStandardID.PARAM_ANGLE_Y, dragMgr.getY() * 30, 1);
			live2DModel.addToParamFloat(L2DStandardID.PARAM_ANGLE_Z, (dragMgr.getX() * dragMgr.getY()) * -30, 1);
			
			// ドラッグによる体の向きの調整
			live2DModel.addToParamFloat(L2DStandardID.PARAM_BODY_ANGLE_X, dragMgr.getX()*10, 1); // -10から10の値を加える
			
			// ドラッグによる目の向きの調整
			live2DModel.addToParamFloat(L2DStandardID.PARAM_EYE_BALL_X, dragMgr.getX(), 1); // -1から1の値を加える
			live2DModel.addToParamFloat(L2DStandardID.PARAM_EYE_BALL_Y, dragMgr.getY(), 1);
			
			// 呼吸など
			live2DModel.addToParamFloat(L2DStandardID.PARAM_ANGLE_X, Number((15 * Math.sin(t / 6.5345))), 0.5);
			live2DModel.addToParamFloat(L2DStandardID.PARAM_ANGLE_Y, Number((8 * Math.sin(t / 3.5345))), 0.5);
			live2DModel.addToParamFloat(L2DStandardID.PARAM_ANGLE_Z, Number((10 * Math.sin(t / 5.5345))), 0.5);
			live2DModel.addToParamFloat(L2DStandardID.PARAM_BODY_ANGLE_X, Number((4 * Math.sin(t / 15.5345))), 0.5);
			live2DModel.setParamFloat(L2DStandardID.PARAM_BREATH, Number((0.5 + 0.5 * Math.sin(t / 3.2345))), 1);
			
			if (physics != null)
				physics.updateParam(live2DModel); // 物理演算でパラメータ更新
			
			// リップシンクの設定
			if (lipSync)
			{
				live2DModel.setParamFloat(L2DStandardID.PARAM_MOUTH_OPEN_Y, lipSyncValue);
			}
			
			// ポーズの設定
			if (pose != null)
				pose.updateParam(live2DModel);
			live2DModel.update();
			
			_alpha += accAlpha;
			if (_alpha < 0)
			{
				_alpha = 0;
				accAlpha = 0;
			}
			if (_alpha > 1)
			{
				_alpha = 1;
				accAlpha = 0;
			}
		}
		
		
		/*
		 * 表情をランダムに切り替える
		 */
		internal function setRandomExpression():void
		{
			var tmp:Vector.<String> = new Vector.<String>;
			for (var name:String in expressions)
			{
				tmp.push(name);
			}
			
			var no:int = Math.random() * tmp.length;
			
			setExpression(tmp[no]);
		}
		
		
		/*
		 * モーションをランダムで再生する
		 * @param	name
		 * @param	priority
		 */
		internal function startRandomMotion(name:String, priority:int):void
		{
			var max:int = modelSetting.getMotionNum(name);
			var no:int = Math.random() * max;
			startMotion(name, no, priority);
		}
		
		
		/*
		 * モーションの開始。
		 * 再生できる状態かチェックして、できなければ何もしない。
		 * 再生出来る場合は自動でファイルを読み込んで再生。
		 * 音声付きならそれも再生。
		 * フェードイン、フェードアウトの情報があればここで設定。なければ初期値。
		 */
		internal function startMotion(name:String, no:int, priority:int):void
		{
			var motionName:String = modelSetting.getMotionFile(name, no);
			
			if (motionName == null || motionName == "")
			{
				if (LAppDefine.DEBUG_LOG)
					trace("Failed to motion.");
				return;
			}
			
			if (priority == LAppDefine.PRIORITY_FORCE) 
			{
				mainMotionManager.setReservePriority(priority);
			}
			else if (!mainMotionManager.reserveMotion(priority))
			{
				if (LAppDefine.DEBUG_LOG)
					trace("Failed to motion.")
				return;
			}
			
			var motion:AMotion;
			
			if (motions[name]==null) 
			{
				motion = loadMotion(null, modelHomeDir + motionName);
			}
			else 
			{
				motion = motions[name];
			}
			
			// フェードイン、フェードアウトの設定
			motion.setFadeIn(modelSetting.getMotionFadeIn(name, no));
			motion.setFadeOut(modelSetting.getMotionFadeOut(name, no));
			
			if (LAppDefine.DEBUG_LOG)
					trace("Start motion : " + motionName);
					
			if (modelSetting.getMotionSound(name, no) == null)
			{
				mainMotionManager.startMotionPrio(motion, priority);
			}
			else
			{
				var soundName:String = modelSetting.getMotionSound(name, no);
				var player:Sound = Sound(FileManager.openEmbedFile(modelHomeDir + soundName));
				
				if (LAppDefine.DEBUG_LOG)
					trace("Start sound : " + soundName);
				player.play();
				mainMotionManager.startMotionPrio(motion, priority);
			}
		}
		
		
		/*
		 * 表情を設定する
		 * @param motion
		 */
		internal function setExpression(name:String):void
		{
			var motion:AMotion = expressions[name];
			if (LAppDefine.DEBUG_LOG)
				trace("Expression : " + name);
			expressionManager.startMotion(motion, false);
		}
		
		
		/*
		 * 描画
		 * @param	context3D
		 */
		public function draw(context3D:Context3D):void
		{
			if (_alpha < 0.001)
			{
				return;
			}
			if (LAppDefine.DEBUG_DRAW_ALPHA_MODEL && _alpha < 0.999)
			{
				// 半透明
				// オフスクリーンに描画
				OffscreenImage.setOffscrern(context3D);
				MatrixStack.push();
				{
					MatrixStack.multMatrix(modelMatrix.getArray());
					
					live2DModel.setMatrix(MatrixStack.getMatrix());
					live2DModel.draw();
					
					if (LAppDefine.DEBUG_DRAW_HIT_AREA)
					{
						drawHitArea(context3D);
					}
				}
				MatrixStack.pop();
				
				// 画面に描画
				OffscreenImage.setOnscrern(context3D);
				
				OffscreenImage.drawDisplay(context3D, _alpha);
				
			}
			else
			{
				// 通常
				MatrixStack.push();
				{
					MatrixStack.multMatrix(modelMatrix.getArray());
					
					tmpMatrix=MatrixStack.getMatrix()
					live2DModel.setMatrix(tmpMatrix);
					live2DModel.draw();
					
					if (LAppDefine.DEBUG_DRAW_HIT_AREA)
					{
						drawHitArea(context3D);
					}
				}
				MatrixStack.pop();
			}
		
		}
		
		
		/*
		 * 当たり判定との簡易テスト。
		 * 指定IDの頂点リストからそれらを含む最大の矩形を計算し、点がそこに含まれるか判定
		 *
		 * @param id
		 * @param testX
		 * @param testY
		 * @return
		 */
		public function hitTest(id:String, testX:Number, testY:Number):Boolean
		{
			var len:int = modelSetting.getHitAreaNum();
			for (var i:int = 0; i < len; i++)
			{
				if (id == modelSetting.getHitAreaName(i))
				{
					var drawID:String = modelSetting.getHitAreaID(i);
					return hitTestSimple(drawID, testX, testY);
				}
			}
			return false; // 存在しない場合はfalse
		}
		
		
		/*
		 * 当たり判定を表示
		 * @param	context3D
		 */
		public function drawHitArea(context3D:Context3D):void
		{
			// Live2Dモデル描画時に以下の設定を使用しているため、初期化する必要があります。
			context3D.setTextureAt(0, null);
			context3D.setVertexBufferAt(0, null);
			context3D.setVertexBufferAt(1, null);
			
			var len:int = modelSetting.getHitAreaNum();
			for (var i:int = 0; i < len; i++)
			{
				var drawID:String = modelSetting.getHitAreaID(i);
				var drawIndex:int = live2DModel.getDrawDataIndex(drawID);
				if (drawIndex < 0)
					continue; // 存在しない場合はfalse
				var points:Vector.<Number> = live2DModel.getTransformedPoints(drawIndex);
				
				var left:Number = live2DModel.getCanvasWidth();
				var right:Number = 0;
				var top:Number = live2DModel.getCanvasHeight();
				var bottom:Number = 0;
				var size:Number = 10;
				for (var j:int = 0; j < points.length; j = j + jp.live2d.Def.VERTEX_STEP)
				{
					var x:Number = points[j + jp.live2d.Def.VERTEX_OFFSET];
					var y:Number = points[j + jp.live2d.Def.VERTEX_OFFSET + 1];
					if (x < left)
						left = x; //  最小のx
					if (x > right)
						right = x; //  最大のx
					if (y < top)
						top = y; //  最小のy
					if (y > bottom)
						bottom = y; //  最大のy
				}
				var r:Number = 1;
				var g:Number = 0;
				var b:Number = 0;
				
				Stage3DUtil.drawLineBox(context3D, size, left, right, bottom, top, tmpMatrix, r, g, b);
			}
		}
		
		
		/*
		 * 半透明になりながら表示する
		 */
		public function feedIn():void
		{
			alpha = 0;
			accAlpha = 0.05;
		}
	}
}
