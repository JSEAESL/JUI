package jlib.old 
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	public class JButton extends Sprite
	{
		private var skin:MovieClip
		public function JButton(skin:MovieClip)
		{
			this.skin = skin;
			bindCompoent();
		}
		
		private function bindCompoent():void
		{
			skin.addEventListener(MouseEvent.CLICK,onClick);
			skin.addEventListener(MouseEvent.MOUSE_OVER,onOver);
			skin.addEventListener(MouseEvent.MOUSE_OUT,onOut);
		}
		
		private function onClick(e:MouseEvent):void
		{
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function onOver(e:MouseEvent):void
		{
			skin.gotoAndStop(2);
		}
		
		private function  onOut(e:MouseEvent):void
		{
			skin.gotoAndStop(1);
		}
		
		
	}
}