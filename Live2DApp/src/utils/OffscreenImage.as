/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package utils
{
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.Texture;
	
	public class OffscreenImage
	{
		static private var texture:Texture;
		static private var drawImage:SimpleImage;
		
		
		public function OffscreenImage()
		{
		
		}
		
		
		static public function init(context3D:Context3D):void
		{
			texture = context3D.createTexture(512, 512, Context3DTextureFormat.BGRA, true);
			
			drawImage = new SimpleImage(context3D);
			drawImage.setTexture(texture);
			drawImage.setDrawRect(-1, 1, -1, 1);
		}
		
		
		static public function setOnscrern(context3D:Context3D):void
		{
			context3D.setRenderToBackBuffer();
		
		}
		
		
		static public function setOffscrern(context3D:Context3D):void
		{
			
			context3D.setRenderToTexture(texture);
			context3D.clear(0, 0, 0, 0); // バッファはクリアしなければならない。
		}
		
		
		static public function drawDisplay(context3D:Context3D, alpha:Number):void
		{
			drawImage.alpha = alpha;
			drawImage.drawImage(context3D);
		}
		
		
		static public function release():void
		{
			texture.dispose();
		}
	}

}