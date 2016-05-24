package jlib.panel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.ConvolutionFilter;
	
	import jlib.ui.JMapBox;
	
	public class ColorMatrixFilterTest extends JMapBox
	{
		public function ColorMatrixFilterTest(boxWight:int=233, boxHeight:int=233, bgColor:uint=0xffffff)
		{
			super(boxWight, boxHeight,bgColor);
		}
		
		private var _bitMap:Bitmap;
		
		public function creatPic(data:Loader):void
		{
			var bit:Bitmap = data.content as Bitmap;
			
			
			var filters:Array = [];
			filters.push(getCMF(1,0,0,0,0,
								0,1,0,0,0,
								0,0,0,0,0,
								0,0,0,1,0
				));
			//filters.push(getCF());
			
			bit.filters =filters ;
			addElement(bit);
		}
		
		public static function getCMF(
							   r0:Number = 1,r1:Number = 0,r2:Number = 0,r3:Number = 0,offR:Number = 0,
							   g0:Number = 0,g1:Number = 1,g2:Number = 0,g3:Number = 0,offG:Number = 0,
							   b0:Number = 0,b1:Number = 0,b2:Number = 1,b3:Number = 0,offB:Number = 0,
							   a0:Number = 0,a1:Number = 0,a2:Number = 0,a3:Number = 1,offA:Number = 0):ColorMatrixFilter
		{		
			var arr:Array = [r0,r1,r2,r3,offR,
							 g0,g1,g2,g3,offG,
							 b0,b1,b2,b3,offB,
							 a0,a1,a2,a3,offA];
			
			var cmf:ColorMatrixFilter = new ColorMatrixFilter(arr);
		
			return cmf;
		}
		
		/*public static function getCF(matrixX:Number=0, matrixY:Number=0, matrix:Array=null, divisor:Number=1.0, bias:Number=0.0, preserveAlpha:Boolean=true, clamp:Boolean=true, color:uint=0, alpha:Number=0.0):ConvolutionFilter 
		{
			var cf:ConvolutionFilter  = new ConvolutionFilter(3,3,new Array(1,0,-10,-2,3,1,6,1,-1),0);
			
			return cf;
		}*/
	}
}