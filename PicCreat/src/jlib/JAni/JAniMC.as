package jlib.JAni
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;

	public class JAniMC extends Sprite
	{
		private var assteList:Vector.<BitmapData>;

		private var bg:Sprite;

		private var Jbit:JBitFrameCase;
		private var timerTick:JTimerTick;
		public function JAniMC()
		{
			super();
			initClass();
		}
		private function initClass():void
		{
			Jbit = new JBitFrameCase();
			addChild(Jbit);
		}
		private function initTick(delay:int):void
		{
			timerTick = new JTimerTick(delay,0,Jbit.timerAction,null)
		}
		
		private function toShow():void
		{
			initTick(30);
			Jbit.pause = false;
			timerTick.start();
		}

		public function stop():void
		{
			Jbit.pause = true;
			timerTick.stop();
		}
		
		public function start():void
		{
			Jbit.pause = false
			timerTick.start();
		}
		
		public function setAsstes(asstes:Vector.<BitmapData>):void
		{
			Jbit.setCaseList(asstes)
			toShow();
		}
	}
}