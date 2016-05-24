package jlib.panel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import jlib.ui.JCloseBtn;
	import jlib.ui.JTitleBar;
	import jlib.ui.component.box.JBox;
	
	public class JLineBox extends Sprite
	{
		private var _box:JBox;
		
		private var JTitle:JTitleBar;
		public function JLineBox(boxWight:int=233, boxHeight:int=233, bgColor:uint=0x666666, titleHeight:int = 20)
		{
			_box = new JBox(boxWight,boxHeight,bgColor, titleHeight);
			JTitle = new JTitleBar(_box);
			_box.serTitleBar(JTitle)
			
			_box.addElementBtn(JCloseBtn.creat(_box));
			addChild(_box);
			getRandomLine()
		}
		
		
		private var lineList:Array;
		private var mc:Sprite ;
		private function getRandomLine():void
		{
			mc = new Sprite();
			var count:int = -400;
			var maxlen:int = _box.height * 0.1;
			var minLen:int = _box.height * 0.05;
			while(count < 0)
			{
				var starPointx:int = Math.random() * _box.width;
				var starPointy:int = Math.random() * _box.height;
				var endPointx:int= starPointx + (Math.random()>0.5 ? 1:-1);
				var endPointy:int= Math.random() * _box.height;
				
				if(test(starPointx,starPointy,endPointx,endPointy,maxlen,minLen))
				{
					var sp:Shape = new Shape();
					sp.graphics.lineStyle(1,0x66666,0.3);
					sp.graphics.moveTo(starPointx,starPointy);
					sp.graphics.lineTo(endPointx,endPointy);
					mc.addChild(sp);
				
					count++
				}else
				{
					continue;
				}
				//_box.addChild(mc);
				
			
			}
			
			var data:BitmapData = new BitmapData(_box.width,_box.height,true,0xffffff);
		
			data.draw(mc);
			saveData(data);
			//clean();
		}
		
		public function clean():void
		{
			_box.clean();
		}
		
		private var a:Array = [];
		private function saveData(data:BitmapData):void
		{
			if(a.length<5)
			{
				a.push(data);
				getRandomLine();
			}else
			{
				showData();
			}
		}
		
		private var sTime:Timer = new Timer(60,0);
		private function showData():void
		{
		
			sTime.addEventListener(TimerEvent.TIMER,onTimer);
			sTime.start();
		}
		
		private var index:int = 0;
		private var dim:Bitmap = new Bitmap();
		private function onTimer(e:TimerEvent):void
		{
			if(index<5)
			{
				clean();
				dim.bitmapData = a[index];
			}else
			{
				index = 0;
				clean();
				dim.bitmapData = a[index];
			}
			_box.addChild(dim);
			index++
			
		}
		
		private function test(Sx:int,Sy:int,Ex:int,Ey:int,maxlen:int,minLen:int):Boolean
		{
			var lineLen:int;
		
			var dx:int = Sx - Ex;
			var dy:int = Sy - Ey;
			lineLen = Math.sqrt(dx * dx + dy * dy); 
			if(lineLen < maxlen && lineLen > minLen )
			{
				return false;
			}
			
			var lineRad:int = getDegrees(Sx,Sy,Ex,Ey)
			
			
			return true
		}
		
		
		public function getDegrees(Sx:int,Sy:int,Ex:int,Ey:int):int
		{
			
			var result:int;
			
			var dx:int = Sx - Ex;
			var dy:int = Sy - Ey;
			
			return result;
		}
			
		
		
	}
}