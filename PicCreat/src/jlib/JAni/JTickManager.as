package jlib.JAni
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	

	public class JTickManager
	{
		
		public var nextTime:int;
		public var preTime:int;
		public static var MAX_INTERVAL:int = 3000;
		public var JTickList:Vector.<JTickInfo>;
		
		private var Dim:Sprite;
		private static var _instance:JTickManager;
		public static function getInstance():JTickManager
		{
			if(_instance == null)
			{
				_instance = new JTickManager();
			}
			return _instance;
		}
		public function JTickManager()
		{
			initClass();
		}
		
		private function initClass():void
		{
			JTickList = new Vector.<JTickInfo>();
			Dim = new Sprite();
			
			Dim.addEventListener(Event.ENTER_FRAME,doTick);
		}
		
		private var nowInterval:int;
		private function doTick(e:Event):void
		{
			nextTime = getTimer();
			
			if(preTime==0)
			{
				nowInterval = 0;
			}else
			{
				nowInterval = Math.min(nextTime - preTime,MAX_INTERVAL)
			}
			preTime = nextTime;
			for each (var ticker:JTickInfo in JTickList)
			{
					ticker.doTick(nowInterval);
			}
			
		}
		public function addJTick(JTick:JTickInfo):void
		{
			JTickList.push(JTick)
		}
		
		public function removeJTick(JTick:JTickInfo):void
		{
			var index:int = JTickList.indexOf(JTick);
			if(index)
			{
				JTickList.splice(index,1)
			}
		}
		
	}	
}