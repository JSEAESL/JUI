package jlib.JAni
{
	public class JTimerTick extends JTickInfo
	{
		public var repeatCount:int;
		public var tickTime:Number;
		public function JTimerTick(DealTime:Number = 1000, RepeatCount:int = 0, TimerFun:Function = null, CompleteFun:Function = null)
		{
			super(CompleteFun, TimerFun);
			repeatCount = RepeatCount;
			delay = DealTime;
			reset();
		}
		
		override  public function doTick(dtime:Number):void
		{
			tickTime +=dtime;
			
			if(tickTime>delay)
			{
				tickTime -=delay
				++tickCount;
				if(timerFun)
				{
					if (timerFun != null)
					{
						timerFun();
					}
				}
					
				if(repeatCount>0 && tickCount>repeatCount)
				{
					if (completeFun != null)
					{
						completeFun();
					}
					this.destroy()
					return;
				}
					
			}
			
			
		}
		public function reset():void
		{
			tickCount = 0;
			tickTime = 0;
		}
	}
}