package jlib.old
{
	import com.adobe.images.JPGEncoder;
	import com.adobe.images.PNGEncoder;
	
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class JImageCode
	{
		public function JImageCode()
		{
		}
		
		static public function getJPG(src:BitmapData, _quality:uint = 50):ByteArray {
			var _jpgCode:ByteArray	=	new JPGEncoder(_quality).encode(src);
			return _jpgCode;
			//	PFile.create.saveAs(_pngCode);
		}
		
		static public function getPng(src:BitmapData):ByteArray
		{
			var _pngCode:ByteArray = PNGEncoder.encode(src);
			return _pngCode;
		}
		
		/*static public function PngByte_TO_Bit(src:ByteArray):BitmapData
		{
			var result:BitmapData = new BitmapData(480, 360,true,0x00);
			result.draw(src);
			return result;
		}*/
		
		static public function buildAlphaJPG(jpgData:BitmapData,alphaData:ByteArray):BitmapData
		{
			var result:BitmapData = new BitmapData(jpgData.width,jpgData.height,true,0xffffffff);
			alphaData.position = 0;
			for(var y:int = 0; y < jpgData.height; y++)
			{
				for(var x:int = 0; x < jpgData.width; x++)
				{
					var pix:uint = jpgData.getPixel32(x,y) + alphaData.readByte() << 24;
					//trace(pix)
					result.setPixel32(x,y,pix);
					
				}
			}
			return result;
		}
		
		static public function getAlphaData(dim:BitmapData):ByteArray
		{
			
			var result:ByteArray = new ByteArray();
			for(var y:int = 0; y<dim.height; y++)
			{
				for(var x:int = 0; x<dim.width; x++)
				{
					var alpha:uint = dim.getPixel32(x,y) >>24 & 0xFF;
					result.writeByte(alpha);
				}	
			}
			result.position	=	0;
			trace("通道处理完毕");
			return result;
		}
		
		static public function getRedData(dim:BitmapData):ByteArray
		{
			var result:ByteArray = new ByteArray();
			for(var y:int = 0; y<dim.height; y++)
			{
				for(var x:int = 0; x<dim.width; x++)
				{
					
					var red:uint = dim.getPixel32(x,y) >>16 & 0xFF;
					//if(alpha != 0)
					//{
					//	trace (dim.getPixel32(x,y),alpha)
					//}
					result.writeByte(red);
				}	
			}
			result.position	=	0;
			trace("通道处理完毕");
			
			//return buildAlphaJPG(dim,result);
			return result;
		}
		
		static public function getBlueData(dim:BitmapData):ByteArray
		{
			var result:ByteArray = new ByteArray();
			for(var y:int = 0; y<dim.height; y++)
			{
				for(var x:int = 0; x<dim.width; x++)
				{
					var blue:uint = dim.getPixel32(x,y) >>8 & 0xFF;
					result.writeByte(blue);
				}	
			}
			result.position	=	0;
			trace("通道处理完毕");
			return result;
		}
		
		static public function getGreeData(dim:BitmapData):ByteArray
		{
			var result:ByteArray = new ByteArray();
			for(var y:int = 0; y<dim.height; y++)
			{
				for(var x:int = 0; x<dim.width; x++)
				{
					var gree:uint = dim.getPixel32(x,y);
					result.writeByte(gree);
				}	
			}
			result.position	=	0;
			trace("通道处理完毕");
			return result;
		}
		
		static public function getAlpha(dim:BitmapData):BitmapData
		{
			var alphas:Array = [];
			var result:BitmapData = new BitmapData(dim.width,dim.height,true,0xffffffff);
			for(var y:int = 0; y<dim.height; y++)
			{
				for(var x:int = 0; x<dim.width; x++)
				{
					
					var alpha:uint = dim.getPixel32(x,y) >>24 &0xFF;
					//trace(alpha)
					var colour:uint = dim.getPixel32(x,y) <<8 ;
					alphas.push( alpha.toString(16) );
					//trace(dim.getPixel32(x,y),colour)
					//if(alpha != 0)
					//{
						//trace(alpha);	
					//}
					//result.setPixel32(x,y,alpha << 24);
					//trace(colour >>8)
					result.setPixel32(x,y,colour >>8);
				}
				//alphas.push("\n");
			}
			var str :String = alphas.join();
		//	trace(str);
			trace("通道处理完毕");

			return result;
		}
		
	}
}