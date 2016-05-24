package jlib.load  
{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	
	import jevent.JEvent;
	

	/**
	 * ...
	 * @author J_SEA
	 */
	public class SwfLoader extends EventDispatcher
	{
		public var applican:ApplicationDomain;
		
		public var isComplete:Boolean = false;
		
		private var url:String;
		private var urlReq:URLRequest;
		private  var load:Loader;
		
		private var _byteLoEd:int = 0;
		private var _byteloTo:int = 0;
		
		public var mc:MovieClip;
		private var isClass:Boolean = true;
		public function SwfLoader(url:String, isClass:Boolean)
		{
			this.isClass = isClass
			this.url = url;
			this.urlReq = new URLRequest(url);
		}
		
		public function toLoad():void
		{
			load = new Loader();
			load.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS,loading);
			if(isClass)
			{
 			load.contentLoaderInfo.addEventListener(Event.COMPLETE, onClassComplete);				
			}else
			{
				load.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);	
			}
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

		private function onClassComplete(e:Event):void
		{
			//mc = e.target.content;
			applican = e.target.applicationDomain
			
			load.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loading);
			load.contentLoaderInfo.removeEventListener(Event.COMPLETE, onClassComplete);
			
			isComplete = true;
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE,applican));
		}
		
		private function onComplete(e:Event):void
		{
			
			//mc = e.target.content;
			//applican = e.target.applicationDomain
			
			load.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS,loading);
			load.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			
			isComplete = true;
			dispatchEvent(new JEvent(JEvent.LOAD_COMPELETE,load));
		}
		
	}

}