/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework
{
	import jp.live2d.util.UtSystem;
	
	public class L2DTargetPoint
	{
		public static const FRAME_RATE:int = 30; // ドラッグの距離計算にのみ使う擬似フレームレート
		
		protected var faceTargetX:Number = 0; // 顔の向きの目標値（この値に近づいていく）
		protected var faceTargetY:Number = 0;
		
		protected var faceX:Number = 0; // 顔の向き -1..1
		protected var faceY:Number = 0;
		
		protected var faceVX:Number = 0; // 顔の向きの変化速度
		protected var faceVY:Number = 0;
		
		protected var lastTimeSec:int = 0;
		
		

		public function setPoint(x:Number, y:Number):void
		{
			faceTargetX = x;
			faceTargetY = y;
		}
		
		
		/*
		 * 横方向の値。
		 * @return -1から1の値
		 */
		public function getX():Number
		{
			if (Math.abs(faceX) < 0.01)
			{
				return 0;
			}
			return faceX;
		}
		
		
		/*
		 * 縦方向の値。
		 * @return -1から1の値
		 */
		public function getY():Number
		{
			if (Math.abs(faceY) < 0.01)
			{
				return 0;
			}
			return faceY;
		}
		
		
		/*
		 * 更新
		 * 首を中央から左右に振るときの平均的な早さは  秒程度。加速・減速を考慮して、その２倍を最高速度とする
		 * 顔のふり具合を、中央（０）から、左右は（±１）とする
		 */
		public function update():void
		{
			// 計算用の設定
			const TIME_TO_MAX_SPEED:Number = 0.15; // 最高速度になるまでの時間
			const FACE_PARAM_MAX_V:Number = 40.0 / 7.5; // 7.5秒間に40分移動（5.3/sc)
			
			const MAX_V:Number = FACE_PARAM_MAX_V / FRAME_RATE; // 1frameあたりに変化できる速度の上限
			
			if (lastTimeSec == 0)
			{
				lastTimeSec = UtSystem.getUserTimeMSec();
				return;
			}
			var curTimeSec:int = UtSystem.getUserTimeMSec();
			
			var deltaTimeWeight:Number = Number((curTimeSec - lastTimeSec)) * FRAME_RATE / 1000.0;
			lastTimeSec = curTimeSec;
			
			const FRAME_TO_MAX_SPEED:Number = TIME_TO_MAX_SPEED * FRAME_RATE; // sec*frame/sec
			const MAX_A:Number = deltaTimeWeight * MAX_V / FRAME_TO_MAX_SPEED; //  1frameあたりの加速度
			
			var dx:Number = (faceTargetX - faceX);
			var dy:Number = (faceTargetY - faceY);
			
			if (dx == 0 && dy == 0)
				return;
			var d:Number = Number(Math.sqrt(dx * dx + dy * dy));
			
			var vx:Number = MAX_V * dx / d;
			var vy:Number = MAX_V * dy / d;
			
			var ax:Number = vx - faceVX;
			var ay:Number = vy - faceVY;
			
			var a:Number = Number(Math.sqrt(ax * ax + ay * ay));
			
			if (a < -MAX_A || a > MAX_A)
			{
				ax *= MAX_A / a;
				ay *= MAX_A / a;
				a = MAX_A;
			}
			
			faceVX += ax;
			faceVY += ay;
			
			{
				//           2  6         2          3
				//      sqrt(a  t  + 16 a h t  - 8 a h) - a t
				// v = --------------------------------------
				//                   2
				//                 4 t  - 2
				//(t=1)
				var max_v:Number = 0.5 * (Number(Math.sqrt(MAX_A * MAX_A + 16 * MAX_A * d - 8 * MAX_A * d)) - MAX_A);
				var cur_v:Number = Number(Math.sqrt(faceVX * faceVX + faceVY * faceVY));
				
				if (cur_v > max_v)
				{
					faceVX *= max_v / cur_v;
					faceVY *= max_v / cur_v;
				}
			}
			
			faceX += faceVX;
			faceY += faceVY;
		}
	
	}
}
