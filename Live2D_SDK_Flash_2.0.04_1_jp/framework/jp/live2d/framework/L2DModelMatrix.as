/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework
{
	
	public class L2DModelMatrix extends L2DMatrix44
	{
		protected var width:Number;
		protected var height:Number;
		
		
		public function L2DModelMatrix(w:Number, h:Number)
		{
			width = w;
			height = h;
		}
		
		
		public function setPosition(x:Number, y:Number):void
		{
			translate(x, y);
		}
		
		
		public function setCenterPosition(x:Number, y:Number):void
		{
			var w:Number = width * getScaleX();
			var h:Number = height * getScaleY();
			translate(x - w / 2, y - h / 2);
		}
		
		
		public function top(y:Number):void
		{
			setY(y);
		}
		
		
		public function bottom(y:Number):void
		{
			var h:Number = height * getScaleY();
			translateY(y - h);
		}
		
		
		public function left(x:Number):void
		{
			setX(x);
		}
		
		
		public function right(x:Number):void
		{
			var w:Number = width * getScaleX();
			translateX(x - w);
		}
		
		
		public function centerX(x:Number):void
		{
			var w:Number = width * getScaleX();
			translateX(x - w / 2);
		}
		
		
		public function centerY(y:Number):void
		{
			var h:Number = height * getScaleY();
			translateY(y - h / 2);
		}
		
		
		public function setX(x:Number):void
		{
			translateX(x);
		}
		
		
		public function setY(y:Number):void
		{
			translateY(y);
		}
		
		
		public function setHeight(h:Number):void
		{
			var scaleX:Number = h / height;
			var scaleY:Number = -scaleX;
			scale(scaleX, scaleY);
		}
		
		
		/*
		 * 横幅をもとにしたサイズ変更
		 * 縦横比はもとのまま
		 * @param w
		 */
		public function setWidth(w:Number):void
		{
			var scaleX:Number = w / width;
			var scaleY:Number = -scaleX;
			scale(scaleX, scaleY);
		}
	
	}

}