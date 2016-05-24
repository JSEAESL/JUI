package jlib.ui.component.other
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;


	public class TextFieldHaNaSi extends Sprite
	{

		//private var rect:Rectangle;
		private var _width:int;
		private var _height:int;

		private var text:TextField;
		private var _format:TextFormat;

		private var timer:Timer;
		private var nowStr:String="这是一个演示文本这是一个演示文本.";
		private var nextStr:String="這是第二個演示文本 ,.;/,.432432這是         第二個演示文本這是第二個演   演示文本這是第二個演示文本"
		private var num:Number;

		private var showEd:Boolean=false;

		//private var showIng:Boolean = true;
		public function TextFieldHaNaSi(w:int, h:int)
		{

			super();
			addEventListener(BoxEvent.HANASI_OWALI, next);


			_width=w;
			_height=h

			text=creatTF();
			text.width=_width;
			text.height=_height
			addChild(text);

			draw();
			timerInit();

			addEvent();

			timer.start();
		}

		private function addEvent():void
		{
			timer.addEventListener(TimerEvent.TIMER, onShow);
		}


		private function creatTF():TextField
		{
			var _text:TextField=new TextField();


			_text.multiline=true;
			_text.wordWrap=true;
			_text.selectable=false;

			_format=new TextFormat("宋体", 32, 0xff0000);
			_text.defaultTextFormat=_format;

			return _text;

		}

		private function onShow($evt:TimerEvent):void
		{
			var count:Number=(($evt.currentTarget) as Timer).currentCount;
			var tempStr:String;
			trace(count, num)
			if (count < num)
			{

				tempStr=nowStr.substr(0, count);
				text.htmlText=tempStr;
					//trace(tempStr)
			}
			else if (count >= num)
			{

				tempStr=nowStr.substr(0, count);
				text.htmlText=tempStr;
				showEd=true
				dispatchEvent(new BoxEvent(BoxEvent.HANASI_OWALI));


			}


		}

		private function next($evt:BoxEvent):void
		{

			showEd=false;
			nowStr=nextStr;
			timerInit();

			timer.start();
			addEvent();
		}

		private function timerInit():void
		{
			num=nowStr.length;
			trace(num);
			timer=new Timer(50, num);
		}

		private function draw():void
		{
			graphics.clear();
			graphics.lineStyle(0, 0x000000)
			graphics.beginFill(0x0000ff, 0.5)
			graphics.drawRect(0, 0, _width, _height);
			graphics.endFill();

		}


	}
}