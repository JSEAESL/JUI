package jlib.load
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import jlib.jevent.JEvent;
	
	public class Jloader extends EventDispatcher
	{
		
		private var _load:Loader;
		
		private var _context:LoaderContext;
		
		private var isCompele:Boolean = false;
		
		public function Jloader()
		{
			_load = new Loader();
			_context = new LoaderContext();
			_context.allowCodeImport = true;
		}
		
		public function toLoadBy(data:ByteArray):void
		{
			_load.contentLoaderInfo.addEventListener(Event.COMPLETE, onBytesLoaded);
			_load.loadBytes(data,_context);	
			
			
			
		}
		
		private function onBytesLoaded(e:Event):void
		{
			isCompele = true;
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE,_load));
		}
		
	}
}