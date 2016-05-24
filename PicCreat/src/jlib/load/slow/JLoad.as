package jlib.load.slow
{
	import JGAL.sound.VoiceInfo;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import jlib.jevent.JEvent;
	import jlib.old.JStrUnti;

	public class JLoad extends EventDispatcher
	{
		
		public static  function creat():JLoad
		{
			return new JLoad();
		}
		
		public function JLoad()
		{
			_load = new JloaderDeco();
			_context = new LoaderContext();
			_context.allowCodeImport = true;
			//_context.applicationDomain = ApplicationDomain.currentDomain;
		}
		
		private var _callBack:Function;
		private var _context:LoaderContext;
		private var _load:JloaderDeco;
		private var _url:String;
		
		private var isComplete:Boolean = false;
		
		
		public function toLoad(url:String,callback:Function = null):void
		{
			_callBack = callback;
			_url = url;
			addEvent()
			_load.key = JStrUnti.getDimStr(_url);
			_load.load(new URLRequest(url),_context);
		}
		
		public function toLoadBytes(byte:ByteArray,callback:Function = null,key:String = null):void
		{
			_callBack = callback;
			addEvent()
			_load.key = key;
			_load.loadBytes(byte,_context);
		}
		
		
		
		private function addEvent():void
		{
			_load.contentLoaderInfo.addEventListener(Event.COMPLETE,onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			isComplete = true;
			if(_callBack)
			{
				_callBack.call(null,_load);
			}
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE,_load));
		}
	}
}