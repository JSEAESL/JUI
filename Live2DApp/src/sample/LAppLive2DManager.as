/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package sample
{
	import flash.display3D.Context3D;

	import framework.Live2DFramework;

	import jp.live2d.Live2D;
	
	public class LAppLive2DManager
	{
		// モデルデータ
		private var models:Vector.<LAppModel>;
		
		//  サンプル機能
		private var count:int = -1;
		private var reloadFlg:Boolean; // モデル再読み込みのフラグ
		
		
		public function LAppLive2DManager()
		{
			Live2D.init();
			Live2DFramework.setPlatformManager(new PlatformManager);
			
			models = new Vector.<LAppModel>();
		}
		
		
		internal function createModel():LAppModel
		{
			var model:LAppModel = new LAppModel;
			models.push(model);
			return model;
		}
		
		
		/*
		 * モデルの管理状態などの更新。
		 * モデルのパラメータなどの更新はdrawで行う。
		 * @param context
		 */
		internal function update(context3D:Context3D):void
		{
			if (reloadFlg)
			{
				// モデル切り替えボタンが押された時、モデルを再読み込みする
				reloadFlg = false;
				var no:int = count % 4;
				var model:LAppModel;
				
				switch (no)
				{
					case 0: // ハル
						releaseModel(1);
						releaseModel(0);
						createModel();
						models[0].load(context3D, LAppDefine.MODEL_HARU);
						models[0].feedIn();
						break;
					case 1: // しずく
						releaseModel(0);
						createModel();
						models[0].load(context3D, LAppDefine.MODEL_SHIZUKU);
						models[0].feedIn();
						
						break;
					case 2: // わんこ
						releaseModel(0);
						createModel();
						models[0].load(context3D, LAppDefine.MODEL_WANKO);
						models[0].feedIn();
						break;
					case 3: // 複数モデル
						releaseModel(0);
						createModel();
						models[0].load(context3D, LAppDefine.MODEL_HARU_A);
						models[0].feedIn();
						
						createModel();
						models[1].load(context3D, LAppDefine.MODEL_HARU_B);
						models[1].feedIn();
						break;
					default:
						
						break;
				}
			}
		}
		
		
		/*
		 * モデルを解放する
		 * ないときはなにもしない
		 * @param	no
		 */
		public function releaseModel(no:int):void
		{
			if (models.length <= no)
				return;
			
			models[no].release();
			models.splice(no, 1);
		}
		
		
		/*
		 * ドラッグしたとき、その方向を向く設定する
		 * @param	x
		 * @param	y
		 */
		public function setDrag(x:Number, y:Number):void
		{
			for (var i:int = 0; i < models.length; i++)
			{
				models[i].setDrag(x, y);
			}
		}
		
		
		/*
		 * 画面が最大になったときのイベント
		 */
		internal function maxScaleEvent():void
		{
			if (LAppDefine.DEBUG_LOG)
				trace("Max scale event.");
			for (var i:int = 0; i < models.length; i++)
			{
				models[i].startRandomMotion(LAppDefine.MOTION_GROUP_PINCH_IN, LAppDefine.PRIORITY_NORMAL);
			}
		}
		
		
		/*
		 * 画面が最小になったときのイベント
		 */
		internal function minScaleEvent():void
		{
			if (LAppDefine.DEBUG_LOG)
				trace("Min scale event.");
			for (var i:int = 0; i < models.length; i++)
			{
				models[i].startRandomMotion(LAppDefine.MOTION_GROUP_PINCH_OUT, LAppDefine.PRIORITY_NORMAL);
			}
		}
		
		
		/*
		 * タップしたときのイベント
		 * @param tapCount
		 * @return
		 */
		public function tapEvent(x:Number, y:Number):Boolean
		{
			if (LAppDefine.DEBUG_LOG)
				trace("tapEvent view x:" + x + " y:" + y);
			
			for (var i:int = 0; i < models.length; i++)
			{
				if (models[i].hitTest(LAppDefine.HIT_AREA_HEAD, x, y))
				{
					// 顔をタップしたら表情切り替え
					if (LAppDefine.DEBUG_LOG)
						trace("Tap face.");
					
					models[i].setRandomExpression();
				}
				else if (models[i].hitTest(LAppDefine.HIT_AREA_BODY, x, y))
				{
					// 体をタップしたらモーション
					if (LAppDefine.DEBUG_LOG)
						trace("Tap body.");
					
					models[i].startRandomMotion(LAppDefine.MOTION_GROUP_TAP_BODY, LAppDefine.PRIORITY_NORMAL);
				}
			}
			return true;
		}
		
		
		/*
		 * サンプル
		 * ボタンを押した時のイベント。
		 * モデルの切り替え
		 */
		internal function changeModel():void
		{
			if (LAppDefine.DEBUG_LOG)
				trace("onClickBtn1");
			
			reloadFlg = true; // フラグだけ立てて次回update時に切り替え
			count++;
		}
		
		
		/*
		 * モデルを取得する
		 * @param	no
		 * @return
		 */
		public function getModel(no:int):LAppModel
		{
			if (no >= models.length)
				return null;
			return models[no];
		}
		
		
		/*
		 * モデルの数
		 * @return
		 */
		public function numModels():int
		{
			return models.length;
		}
	}
}
