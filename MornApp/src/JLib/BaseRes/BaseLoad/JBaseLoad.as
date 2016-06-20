package JLib.BaseRes.BaseLoad
{
	import JLib.BaseRes.JBaseCacheManager;


	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	

	public class JBaseLoad extends EventDispatcher
	{
		public function JBaseLoad()
		{
			initClass()
		}
		private function initClass():void
		{
			proLoadList = [];
		}
		
		private var m_loadInfo:JBaseLoadInfo;
		private var proLoadList:Array;
		public function setLoadData(loadInfo:JBaseLoadInfo):Boolean
		{
			if( JBaseCacheManager.getInatsnce().isLoad(loadInfo,loadInfo.url) )
			{
				return false;
			}
			if(null == m_loadInfo)
			{
				m_loadInfo = loadInfo;				
			}else
			{
				proLoadList.push(loadInfo);
			}
			return true;
		}
		
		private var m_byte:ByteArray;
		private var m_urlLoad:URLLoader;
		private var m_loading:Boolean = false;
		public function load():void
		{
			if( m_loadInfo == null || m_loading   )
			{
				return;
			}
			trace(m_loadInfo.url)
			m_urlLoad= new URLLoader();
			m_urlLoad.dataFormat = URLLoaderDataFormat.BINARY;
			addEvent();
			var urlReq:URLRequest = new URLRequest(m_loadInfo.url);
			m_urlLoad.load(urlReq);
		}

		private function addEvent():void
		{
			m_urlLoad.addEventListener(Event.COMPLETE, onDataLoaded);
			m_urlLoad.addEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_urlLoad.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_urlLoad.addEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}

		private function removeEvent():void
		{
			m_urlLoad.removeEventListener(Event.COMPLETE, onDataLoaded);
			m_urlLoad.removeEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_urlLoad.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_urlLoad.removeEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}

		private function onDataLoaded(e:Event):void
		{
			m_byte = e.currentTarget.data as ByteArray;
			m_byte.position = 0;
			trace(m_loadInfo.url  + "二进制加载完成");
			trace(m_byte.length)
			var byteLoad:JBaseByteLoad =  JBaseByteLoad.creatByteLoad(m_byte,m_loadInfo);
			byteLoad.toLoad();

			m_loading = false;
			if(proLoadList.length == 0)
			{
				//m_loadInfo = null;
				//JSceneStateMachine.getInstance().changeScene(StartScene.getInstance());
				removeEvent();
			}else
			{
				m_loadInfo = proLoadList.shift();
				load();
			}


		}

		private function onDataProgress(e:ProgressEvent):void
		{

		}

		private function onDataSecurityError(e:SecurityErrorEvent):void
		{

		}
		private function onDataFailed(e:IOErrorEvent):void
		{

		}
	}
}