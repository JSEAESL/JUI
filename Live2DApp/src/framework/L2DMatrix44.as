/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package framework
{
	import flash.geom.Matrix3D;
	
	
	public class L2DMatrix44
	{
		protected var tr:Vector.<Number> = new Vector.<Number>(16);
		
		
		public function L2DMatrix44()
		{
			identity();
		}
		
		
		public function identity():void 
		{
			for (var i:int = 0; i < 16; i++)
				tr[i] = ((i % 5) == 0) ? 1 : 0;
		}
		
		
		/*
		 * 行列配列を取得
		 * @return
		 */
		public function getMatrix():Vector.<Number>
		{
			return tr;
		}
		
		
		/*
		 * 行列を設定
		 * 長さ16の配列でないときは何もしない
		 * @param tr
		 */
		public function setMatrix(tr:Vector.<Number>):void
		{
			if (tr == null || this.tr.length != tr.length)
				return;
			
			for (var i:int = 0; i < 16; i++)
				this.tr[i] = tr[i];
		}
		
		
		public function getScaleX():Number
		{
			return tr[0];
		}
		
		
		public function getScaleY():Number
		{
			return tr[5];
		}
		
		
		/*
		 * xの値を現在の行列で計算する。
		 * @param src
		 * @return
		 */
		public function transformX(src:Number):Number
		{
			return tr[0] * src + tr[12];
		}
		
		
		/*
		 * yの値を現在の行列で計算する。
		 * @param src
		 * @return
		 */
		public function transformY(src:Number):Number
		{
			return tr[5] * src + tr[13];
		}
		
		
		/*
		 * xの値を現在の行列で逆計算する。
		 * @param src
		 * @return
		 */
		public function invertTransformX(src:Number):Number
		{
			return (src - tr[12]) / tr[0];
		}
		
		
		/*
		 * yの値を現在の行列で逆計算する。
		 * @param src
		 * @return
		 */
		public function invertTransformY(src:Number):Number
		{
			return (src - tr[13]) / tr[5];
		}
		
		
		/*
		 * 受け取った2つの行列の掛け算を行う。
		 * @param a 入力1
		 * @param b 入力2
		 * @param dst 出力
		 */
		protected static function mul(a:Vector.<Number>, b:Vector.<Number>, dst:Vector.<Number>):void
		{
			var c:Vector.<Number> = new <Number>[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
			var n:int = 4;
			var i:int, j:int, k:int;
			
			for (i = 0; i < n; i++)
			{
				for (j = 0; j < n; j++)
				{
					for (k = 0; k < n; k++)
					{
						c[i + j * 4] += a[i + k * 4] * b[k + j * 4];
					}
				}
			}
			for (i = 0; i < 16; i++)
			{
				dst[i] = c[i];
			}
		}
		
		
		/*
		 * 移動量の計算。
		 * @param shiftX
		 * @param shiftY
		 */
		public function multTranslate(shiftX:Number, shiftY:Number):void
		{
			var tr1:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, shiftX, shiftY, 0, 1];
			mul(tr1, tr, tr);
		}
		
		
		public function translate(x:Number, y:Number):void
		{
			tr[12] = x;
			tr[13] = y;
		}
		
		
		public function translateX(x:Number):void
		{
			tr[12] = x;
		}
		
		
		public function translateY(y:Number):void
		{
			tr[13] = y;
		}
		
		
		/*
		 * 拡大率の計算。
		 * @param scaleX
		 * @param scaleY
		 */
		public function multScale(scaleX:Number, scaleY:Number):void
		{
			var tr1:Vector.<Number> = new <Number>[scaleX, 0, 0, 0, 0, scaleY, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
			mul(tr1, tr, tr);
		}
		
		
		public function scale(scaleX:Number, scaleY:Number):void
		{
			tr[0] = scaleX;
			tr[5] = scaleY;
		}
		
		
		public function ortho(left:Number, right:Number, bottom:Number, top:Number):void
		{
			var tx:Number = -(right + left) / (right - left);
			var ty:Number = -(top + bottom) / (top - bottom);
			
			tr[0] = 2.0 / (right - left);
			tr[1] = 0;
			tr[2] = 0;
			tr[3] = 0;
			
			tr[4] = 0;
			tr[5] = 2.0 / (top - bottom);
			tr[6] = 0;
			tr[7] = 0;
			
			tr[8] = 0;
			tr[9] = 0;
			tr[10] = 0;
			tr[11] = 0;
			
			tr[12] = tx;
			tr[13] = ty;
			tr[14] = 0;
			tr[15] = 1;
		}
		
		
		public function getArray():Vector.<Number>
		{
			return tr;
		}
	}
}
