package jlib.panel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.filesystem.File;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import I.Cache;
	import jlib.old.JButton;
	import jlib.old.JFile;
	import jlib.old.JImageCode;
	import jlib.old.Jbytes;
	import jlib.ui.JAButton;
	import jlib.ui.JButtonDeco;
	import jlib.ui.JButtonValue;
	import jlib.ui.JMapBox;
	import jlib.unit.JCallManager;
	
	public class JMapUnit extends Sprite
	{
		
		private var box:JMapBox;
		private var _sou:BitmapData
		public function JMapUnit(sou:BitmapData)
		{
			_sou = sou
			//var b:ByteArray = new ByteArray();
			//b.position =0;
			////_sou.copyPixelsToByteArray(new Rectangle(0,0,_sou.width,_sou.height),b);
			
			initUI();
		}
		
		private var widthValue:JButtonValue;
		private var heightValue:JButtonValue;
		
		
		
		private var reStarBtn:JButtonDeco;
		private var saveBtn:JButtonDeco;
		private var goBtn:JButtonDeco;
		
		private var cutWidth:int;
		private var cutHeight:int;
		
		private function initUI():void
		{
			box = new JMapBox(_sou.width,_sou.height,0xffffff)
			addChild(box);
			
			
			widthValue = new JButtonValue(200,0,500);
			heightValue = new JButtonValue(200,0,500);
			reStarBtn = new JButtonDeco("切",new JAButton(reStar));
			saveBtn = new JButtonDeco("保存",new JAButton(toSave));
			
			goBtn = new JButtonDeco("GO",new JAButton(go));
			cutWidth = widthValue.Value;
			cutHeight = heightValue.Value;
			
			box.addTitleEle(widthValue);
			box.addTitleEle(heightValue);
			box.addTitleEle(reStarBtn);
			box.addTitleEle(saveBtn);
			box.addTitleEle(goBtn);
			box.addElement(new Bitmap(_sou));
			draw();
		}
		
		private function reStar():void
		{
			cutWidth = widthValue.Value;
			cutHeight = heightValue.Value;
			draw();
		}
		
		private var line:Shape = new Shape();
		private var nodes:Vector.<BitmapData>;
		private var dataConfig:Array;
		
		private var _miniMap:BitmapData;
		private function draw():void
		{
			
			nodes = new Vector.<BitmapData>();
			
			line.graphics.clear();
			var rect:Rectangle = new Rectangle(0,0,cutWidth,cutHeight);
			line.graphics.lineStyle(1,getColour() );
			for(var height:int = 0; height < _sou.height; height += cutHeight)
			{
				for(var width:int = 0; width < _sou.width; width += cutWidth)
				{
					rect.x = width;
					rect.y = height;
					var node:BitmapData = new BitmapData(Math.min(cutWidth,_sou.width - width),Math.min(cutHeight,_sou.height - height));
					node.copyPixels(_sou,rect,new Point());
					nodes.push(node);
					//line.graphics.lineStyle(1,getColour() );
					//trace(node.width,node.height);
					
					line.graphics.moveTo(width,0);
					line.graphics.lineTo(width,_sou.height);
					
				}
				//line.graphics.lineStyle(1,getColour() );
				line.graphics.moveTo(0,height);
				line.graphics.lineTo(_sou.width,height);
			}
		
			_miniMap	=	new BitmapData(Math.round(_sou.width / 5),	Math.round(_sou.height / 5),	false,	0x0);		//	黑底小图
			_miniMap.draw(_sou,	new Matrix(1 / 5, 0, 0, 1 / 5, 0, 0));
			
			
			box.addLine(line);
			saveMiniMap();
			dataConfig = [_sou.width,_sou.height,cutWidth,cutHeight,Math.ceil(_sou.width/cutWidth),Math.ceil(_sou.height/cutHeight)];
		
			//box.addElement(new Bitmap(_sou));
		}
		
		private function saveMiniMap():void
		{
			JFile.creat.saveTo("miniMap.jpg",	JImageCode.getJPG(_miniMap, 50));
		}
		
		private function toSave():void
		{
			if(dataConfig && nodes)
			{
				var _resData:ByteArray	=	new ByteArray();
				//var _miniJPG:ByteArray	=	PImageCode.getJPG(_miniMap, 50);//	 _valQuality.value);	小地图固定压缩率 50
				
				_resData.writeBytes(Jbytes.StringToBytes("REG_TYPE",	10));	//	文件类型
				
				//_resData.writeDouble(_miniJPG.length);
				//_resData.writeBytes(_miniJPG,	0,	_miniJPG.length);
				//_resData.writeUTFBytes(PByteJSON.encode(_data));
					JFile.creat.saveAs(_resData,	"保存资源文档 *.res",	toSaveEd);
			}
		}
		
		private function toSaveEd(_file:File):void
		{
			var _url:String	=	_file.url.replace(_file.type, "");	//	保存文件名
			for (var i:uint = 0; i < nodes.length; i++ ) {
	
				JFile.creat.saveTo(_url + "_" + i + ".jpg",	JImageCode.getJPG(nodes[i], 50));
			}
		}
		
		
		
		private function getColour():uint
		{
			var result:uint = Math.random() *0xffffff;
			return result;
		}
		
		private function go():void
		{
			if(!nodes.length)
			{
				return
			}
			
			JCallManager.getInstance().callFun("getBitData",[nodes])
			
		}
	}
}