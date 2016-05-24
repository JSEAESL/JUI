package jlib.load
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	
	import jlib.jevent.JEvent;

	public class PicLoader extends EventDispatcher
	{
		
		public var isComplete:Boolean = false;
		
		private var url:String
		private  var load:Loader;
		private var urlReq:URLRequest;
		
		private var _byteLoEd:int = 0;
		private var _byteloTo:int = 0;
		
		public function PicLoader(url:String)
		{
			this.url = url;
			this.urlReq = new URLRequest(url);
		}
		
		public function toLoad():void
		{
			load = new Loader();
			load.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loading);
			load.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			load.load(urlReq);
		}
		
		private function loading(e:ProgressEvent):void
		{
			_byteLoEd = e.bytesLoaded;
			_byteloTo = e.bytesTotal;
			dispatchEvent(new JEvent(JEvent.PRO_CHANGE,[_byteLoEd,_byteloTo]))
		}
		public function get byteLoEd():int
		{
			return _byteLoEd;
		}
		
		public function get byteloTo():int
		{
			return _byteloTo;
		}
		
		public function get Pro():int
		{
			return _byteLoEd/_byteloTo;
		}

		
		private var ob:Object;
		private function onComplete(e:Event):void
		{
			ob = load.contentLoaderInfo.content;
		
						
			load.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loading);
			load.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			
			isComplete = true;
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE,ob));
		}
	}
}