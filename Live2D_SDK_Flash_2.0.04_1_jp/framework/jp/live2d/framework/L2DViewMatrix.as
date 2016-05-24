/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework
{
	
	/*
	 * 画面の操作による行列を扱う。
	 *
	 */
	public class L2DViewMatrix extends L2DMatrix44
	{
		protected var max:Number;
		protected var min:Number;
		
		protected var screenLeft:Number; // デバイスに対応する論理座標上の範囲
		protected var screenRight:Number;
		protected var screenTop:Number;
		protected var screenBottom:Number;
		protected var maxLeft:Number; // 論理座標上の移動可能範囲（ここからははみ出さない）
		protected var maxRight:Number;
		protected var maxTop:Number;
		protected var maxBottom:Number;
		
		
		public function L2DViewMatrix()
		{
			max = int.MAX_VALUE;
			min = 0;
		}
	
		
		public function getMaxScale():Number
		{
			return max;
		}
		
		
		public function getMinScale():Number
		{
			return min;
		}
		
		
		public function setMaxScale(v:Number):void
		{
			max = v;
		}
		
		
		public function setMinScale(v:Number):void
		{
			min = v;
		}
		
		
		public function isMaxScale():Boolean
		{
			return getScaleX() == max;
		}
		
		
		public function isMinScale():Boolean
		{
			return getScaleX() == min;
		}
		
		
		/*
		 * 移動量の計算。
		 * 移動後の座標が最大範囲をはみ出さないようにする
		 * @param shiftX
		 * @param shiftY
		 */
		public function adjustTranslate(shiftX:Number, shiftY:Number):void
		{
			if (tr[0] * maxLeft + (tr[12] + shiftX) > screenLeft)
				shiftX = screenLeft - tr[0] * maxLeft - tr[12];
			if (tr[0] * maxRight + (tr[12] + shiftX) < screenRight)
				shiftX = screenRight - tr[0] * maxRight - tr[12];
			
			if (tr[5] * maxTop + (tr[13] + shiftY) < screenTop)
				shiftY = screenTop - tr[5] * maxTop - tr[13];
			if (tr[5] * maxBottom + (tr[13] + shiftY) > screenBottom)
				shiftY = screenBottom - tr[5] * maxBottom - tr[13];
			
			var tr1:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, shiftX, shiftY, 0, 1];
			mul(tr1, tr, tr);
		}
		
		
		/*
		 * 拡大率の計算。
		 * 設定された範囲をはみ出さないようにする。
		 */
		public function adjustScale(centerX:Number, centerY:Number, scale:Number):void
		{
			var MAX_SCALE:Number = getMaxScale();
			var MIN_SCALE:Number = getMinScale();
			var targetScale:Number = scale * tr[0];
			if (targetScale < MIN_SCALE)
			{
				if (tr[0] > 0)
					scale = MIN_SCALE / tr[0];
			}
			else if (targetScale > MAX_SCALE)
			{
				if (tr[0] > 0)
					scale = MAX_SCALE / tr[0];
			}
			
			var tr1:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, -centerX, -centerY, 0, 1];
			var tr2:Vector.<Number> = new <Number>[scale, 0, 0, 0, 0, scale, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
			var tr3:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, centerX, centerY, 0, 1];
			mul(tr1, tr, tr);
			mul(tr2, tr, tr);
			mul(tr3, tr, tr);
		}
		
		
		/*
		 * デバイスに対応する論理座標上の範囲の設定
		 * @param left
		 * @param right
		 * @param bottom
		 * @param top
		 */
		public function setScreenRect(left:Number, right:Number, bottom:Number, top:Number):void
		{
			screenLeft = left;
			screenRight = right;
			screenTop = top;
			screenBottom = bottom;
		}
		
		
		/*
		 * 論理座標上の移動可能範囲の設定
		 * @param left
		 * @param right
		 * @param bottom
		 * @param top
		 */
		public function setMaxScreenRect(left:Number, right:Number, bottom:Number, top:Number):void
		{
			maxLeft = left;
			maxRight = right;
			maxTop = top;
			maxBottom = bottom;
		}
		
		
		public function getScreenLeft():Number
		{
			return screenLeft;
		}
		
		
		public function getScreenRight():Number
		{
			return screenRight;
		}
		
		
		public function getScreenBottom():Number
		{
			return screenBottom;
		}
		
		
		public function getScreenTop():Number
		{
			return screenTop;
		}
		
		
		public function getMaxLeft():Number
		{
			return maxLeft;
		}
		
		
		public function getMaxRight():Number
		{
			return maxRight;
		}
		
		
		public function getMaxBottom():Number
		{
			return maxBottom;
		}
		
		
		public function getMaxTop():Number
		{
			return maxTop;
		}
		
		
		public function appendTranslateX(x:Number):void 
		{
			tr[12] += x;
		}
		
		
		public function appendTranslateY(y:Number):void 
		{
			tr[13] += y;
		}
	}
}
