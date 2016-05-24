package jlib.JAni
{
	import I.IDestroy;
	import I.ITick;

	public class JTickInfo implements IDestroy
	{
		private var id:int;
		//private var pasue;Boolean = false;
		
		public var completeFun:Function;
		public var timerFun:Function;
		
		//public var running:Boolean;
		public var tickCount:int;
		public var delay:Number;

		public function JTickInfo(CompleteFun:Function, TimerFun:Function)
		{
			completeFun = CompleteFun;
			timerFun = TimerFun;
		}
		
		
		
		public function start():void
		{
			JTickManager.getInstance().addJTick(this);
		}
		public function stop():void
		{
			JTickManager.getInstance().removeJTick(this);
		}
		
		public function doTick(dtime:Number):void
		{
			
		}
		
		public function destroy():void
		{
			
		}
		
	}
}