package jlib.ui
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	public class JButtonValue extends Sprite
	{
		private var txt:TextField;
		
		private var _Value:int;
		private var _min:int;
		private var _max:int;
		public function JButtonValue(now:int, min:int, max:int)
		{
			_Value = now;
			_min = min;
			_max = max;
			
			txt = new TextField();
			txt.text = _Value.toString();
			txt.width = 40;
			txt.height = 20;
			txt.border=true;
			txt.borderColor=0x9900ff;
			txt.type=TextFieldType.INPUT;
			
			txt.restrict = "0-9";
			txt.addEventListener(MouseEvent.CLICK,onClick);
			txt.addEventListener(Event.CHANGE,onChange);
			addChild(txt);
		}
		
		private function onClick(e:MouseEvent):void
		{
			trace("click");
		}
		
		private function onChange(e:Event):void
		{
			Value = int(txt.text);
		}
		
		public function set Value(val:int):void	
		{
			if(val<_min)
			{
				val = _min;
			}
			
			if(val>_max)
			{
				val = _max;
			}
			txt.text = val.toString();
			_Value = val;
		}
		
		public  function get Value():int
		{
			return _Value;
		}
	}
}