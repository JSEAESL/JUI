package jlib.ui
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import jlib.old.JFilter;
	
	public class JAButton extends Sprite
	{

		public function set argArr(value:Array):void
		{
			_argArr = value;
		}

		public function get enable():Boolean
		{
			return _enable;
		}

		public function set enable(value:Boolean):void
		{
			if(value == false)
			{
				this.removeEventListener(MouseEvent.CLICK,onClick);
				this.removeEventListener(MouseEvent.MOUSE_MOVE,onMove);
				this.removeEventListener(MouseEvent.MOUSE_OUT,onOut);
				this.filters = [JFilter.COLOR_MATRIX_BW];
			}else
			{
				this.addEventListener(MouseEvent.CLICK,onClick);
				this.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
				this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
				this.filters = [];
			}
			
			_enable = value;
		}

		protected var cFun:Function;
		protected var _argArr:Array;
		protected var _enable:Boolean	=	true;
		
		public function JAButton(callFun:Function = null)
		{
			this.cFun = callFun;
			this.addEventListener(MouseEvent.CLICK,onClick);
			this.addEventListener(MouseEvent.MOUSE_MOVE,onMove);
			this.addEventListener(MouseEvent.MOUSE_OUT,onOut);
		}
		
		private function onClick(e:MouseEvent):void
		{
			if(cFun)
			{
				cFun.apply(null,_argArr);
			}
		}
		
		private function onMove(e:MouseEvent):void
		{
			if(!_enable)
			{
				return;
			}
			
			this.filters = [JFilter.COLOR_MATRIX_SELECT];
			
		}
		
		private function onOut(e:MouseEvent):void
		{
			if(!_enable)
			{
				return;
			}
			this.filters = [];
		}
	}
}