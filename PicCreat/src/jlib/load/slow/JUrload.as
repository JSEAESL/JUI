package jlib.load.slow
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	
	import jlib.jevent.JEvent;
	public class JUrload extends EventDispatcher
	{
		public static const BINARY:String=URLLoaderDataFormat.BINARY;
		
		public static const TEXT:String=URLLoaderDataFormat.TEXT;
		public static const VARIABLES:String=URLLoaderDataFormat.VARIABLES;
		
		public function get url():String
		{
			return _url;
		}
		
		public static function creat():JUrload
		{
			return new JUrload();
		}
		
		public function JUrload()
		{
			_urload=new URLLoader();
		}
		
		private var _callBack:Function;
		private var _url:String;
		
		private var _urload:URLLoader;
		
		
		private var isComplete:Boolean=false;
		
		public function toLoad(url:String,callBack:Function = null,dataFormat:String=TEXT):void
		{
			_callBack = callBack;
			_url=url;
			_urload.dataFormat=dataFormat;
			addEvent()
			
			_urload.load(new URLRequest(_url));
		}
		
		
		private function addEvent():void
		{
			_urload.addEventListener(Event.COMPLETE, onComplete);
		}
		
		private function onComplete(e:Event):void
		{
			isComplete=true;
			if(_callBack)
			{
				_callBack.call(null,_urload);
			}
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE, _urload));
		}
		
		
	}
}
