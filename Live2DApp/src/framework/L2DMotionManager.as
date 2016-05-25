/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package framework
{
	import jp.live2d.ALive2DModel;
	import jp.live2d.motion.AMotion;
	import jp.live2d.motion.MotionQueueManager;
	
	public class L2DMotionManager extends MotionQueueManager
	{
		
		//  メインモーションの優先度
		//  標準設定 0:再生してない 1:アイドリング(割り込んで良い) 2:通常(基本割り込みなし) 3:強制で開始
		protected var currentPriority:int; //  現在再生中のモーションの優先度
		protected var reservePriority:int; //  再生予定のモーションの優先度。再生中は0になる。モーションファイルを別スレッドで読み込むときの機能。
		
		
		/*
		 * 再生中のモーションの優先度
		 * @return
		 */
		public function getCurrentPriority():int
		{
			return currentPriority;
		}
		
		
		/*
		 * 予約中のモーションの優先度
		 * @return
		 */
		public function getReservePriority():int
		{
			return reservePriority;
		}
		
		
		/*
		 * モーションを予約する
		 * @param val
		 */
		public function setReservePriority(val:int):void
		{
			reservePriority = val;
		}
		
		
		public function reserveMotion(priority:int):Boolean
		{
			if (reservePriority >= priority)
			{
				return false; // 再生予約がある(別スレッドで準備している)
			}
			if (currentPriority >= priority)
			{
				return false; // 再生中のモーションがある
			}
			reservePriority = priority; // モーション再生が非同期の場合は優先度を先に設定して予約しておく
			return true;
		}
		
		
		override public function updateParam(model:ALive2DModel):Boolean
		{
			var updated:Boolean = super.updateParam(model);
			if (isFinished())
			{
				currentPriority = 0; // 再生中モーションの優先度を解除
			}
			
			return updated;
		}
		
		
		public function startMotionPrio(motion:AMotion, priority:int):int
		{
			if (priority == reservePriority)
			{
				reservePriority = 0; // 予約を解除
			}
			
			currentPriority = priority; // 再生中モーションの優先度を設定
			return super.startMotion(motion, false); //  第二引数はモーションデータを自動で削除するかどうか。Flashでは関係なし
		}
	
	}
}
