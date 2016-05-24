package jlib.load
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	
	import jlib.jevent.JEvent;
	
	public class JURLloader extends EventDispatcher
	{
		
		static public const TEXT:String		=	URLLoaderDataFormat.TEXT;
		static public const BINARY:String	=	URLLoaderDataFormat.BINARY;
		
		public var isComplete:Boolean = false;
		
		private var url:String;
		private var urlReq:URLRequest;
		private  var load:URLLoader;
		
		private var _byteLoEd:int = 0;
		private var _byteloTo:int = 0;
		
		//public var mc:MovieClip;
		private var isClass:Boolean = true;
		public function JURLloader(url:String)
		{
			this.url = url;
			this.urlReq = new URLRequest(url);
		}
		
		public function toLoad(DataFormat:String = TEXT):void
		{
			load = new URLLoader();
			load.dataFormat=DataFormat ;
			load.addEventListener(Event.COMPLETE,loadED);
		/*	if(isClass)
			{
				load.contentLoaderInfo.addEventListener(Event.COMPLETE, onClassComplete);				
			}else
			{
				load.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);	
			}*/
			load.load(urlReq);
		}
		
		private function loadED(e:Event):void
		{
			isComplete = true;
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE,load.data));			
	
		}
		
		
		
		
	}
}