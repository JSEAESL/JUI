/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework
{
	import jp.live2d.ALive2DModel;
	import jp.live2d.Live2D;
	import jp.live2d.motion.AMotion;
	import jp.live2d.motion.Live2DMotion;
	import jp.live2d.util.UtSystem;
	
	public class L2DBaseModel
	{
		protected var live2DModel:ALive2DModel;
		protected var mainMotionManager:L2DMotionManager;
		protected var expressionManager:L2DMotionManager; // 表情の管理
		protected var eyeBlink:L2DEyeBlink; // 自動目パチ
		protected var physics:L2DPhysics;
		protected var pose:L2DPose; // ポーズ。腕の切り替えなど。
		
		// モーション
		protected var expressions:Array /*of AMotion*/; // 表情
		protected var motions:Array /*of AMotion*/; // あらかじめ読み込んでおくモーション
		
		protected var modelMatrix:L2DModelMatrix;
		
		// 状態
		protected var debugMode:Boolean = false;
		protected var _initialized:Boolean = false; // 初期化状態
		protected var _updating:Boolean = false; // 読み込み中ならtrue
		protected var _alpha:Number = 1;
		protected var accAlpha:Number = 0;
		protected var lipSync:Boolean = false; // リップシンクが有効かどうか
		protected var lipSyncValue:Number; // 基本は0～1
		
		protected var startTimeMSec:Number = 0;
		protected var dragMgr:L2DTargetPoint;
		
		public function L2DBaseModel()
		{
			mainMotionManager = new L2DMotionManager(); // MotionQueueManagerクラスからの継承なので、使い方は同一
			expressionManager = new L2DMotionManager();
			motions = new Array();
			expressions = new Array();
			startTimeMSec = UtSystem.getUserTimeMSec();
			dragMgr = new L2DTargetPoint();
		}
		
		
		public function setDrag(x:Number, y:Number):void
		{
			dragMgr.setPoint(x, y);
		}
		
		
		public function getModelMatrix():L2DModelMatrix
		{
			return modelMatrix;
		}
		
		
		public function get alpha():Number
		{
			return _alpha;
		}
		
		
		public function set alpha(value:Number):void
		{
			_alpha = value;
		}
		
		
		public function get initialized():Boolean
		{
			return _initialized;
		}
		
		
		public function set initialized(value:Boolean):void
		{
			_initialized = value;
		}
		
		
		public function get updating():Boolean
		{
			return _updating;
		}
		
		
		public function set updating(value:Boolean):void
		{
			_updating = value;
		}
		
		
		public function loadModelData(path:String):void
		{
			var pm:IPlatformManager = Live2DFramework.getPlatformManager();
			
			if (debugMode)
				pm.log("Load model : " + path);
			
			live2DModel = pm.loadLive2DModel(path);
			live2DModel.update(); // 最初に更新しないと腕の切り替えがうまくいかない
			live2DModel.saveParam();
			
			if (Live2D.getError() != Live2D.L2D_NO_ERROR)
			{
				pm.log("Error : Failed to loadModelData().");
				return;
			}
			
			modelMatrix = new L2DModelMatrix(live2DModel.getCanvasWidth(), live2DModel.getCanvasHeight());
			modelMatrix.setWidth(2);
			modelMatrix.setCenterPosition(0, 0); // 中心に配置
		}
		
		
		public function loadTexture(no:int, path:String):void
		{
			var pm:IPlatformManager = Live2DFramework.getPlatformManager();
			
			if (debugMode)
				pm.log("Load Texture : " + path);
			
			pm.loadTexture(live2DModel, no, path);
		}
		
		
		public function loadMotion(name:String, path:String):AMotion
		{
			var pm:IPlatformManager = Live2DFramework.getPlatformManager();
			
			if (debugMode)
				pm.log("Load Motion : " + path);
			
			var motion:AMotion = Live2DMotion.loadMotion(pm.loadString(path));
			
			if ( name !=null)
			{
				motions[name] = motion; 
			}
			return motion;
		}
		
		
		public function loadExpression(name:String, path:String):void
		{
			var pm:IPlatformManager = Live2DFramework.getPlatformManager();
			
			if (debugMode)
				pm.log("Load Expression : " + path);
			
			expressions[name] = L2DExpressionMotion.loadJsonStr(pm.loadString(path));
		}
		
		
		public function loadPose(path:String):void
		{
			var pm:IPlatformManager = Live2DFramework.getPlatformManager();
			
			if (debugMode)
				pm.log("Load Pose : " + path);
			
			pose = L2DPose.loadJsonStr(pm.loadString(path));
		}
		
		
		public function loadPhysics(path:String):void
		{
			var pm:IPlatformManager = Live2DFramework.getPlatformManager();
			
			if (debugMode)
				pm.log("Load Physics : " + path);
			
			physics = L2DPhysics.loadJsonStr(pm.loadString(path));
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
		public function hitTestSimple(drawID:String, testX:Number, testY:Number):Boolean
		{
			var drawIndex:int = live2DModel.getDrawDataIndex(drawID);
			if (drawIndex < 0)
				return false; // 存在しない場合はfalse
			var points:Vector.<Number> = live2DModel.getTransformedPoints(drawIndex);
			
			var left:Number = live2DModel.getCanvasWidth();
			var right:Number = 0;
			var top:Number = live2DModel.getCanvasHeight();
			var bottom:Number = 0;
			
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
			//var mtx:Vector.<Number> = live2DModel.getMatrix();
			//mtx.transformVector(
			
			var tx:Number = modelMatrix.invertTransformX(testX);
			var ty:Number = modelMatrix.invertTransformY(testY);
			if (debugMode)
				trace("hit test " + drawID + " l:" + left + " r:" + right + " b:" + bottom + " t:" + top + " ( x:" + tx + " y:" + ty + " )");
			return (left <= tx && tx <= right && top <= ty && ty <= bottom);
		}
	}
}