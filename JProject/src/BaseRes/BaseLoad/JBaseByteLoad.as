package BaseRes.BaseLoad
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	public class JBaseByteLoad extends EventDispatcher
	{
		public function JBaseByteLoad()
		{
		}

		private var m_byte:ByteArray;
		private var m_load:Loader;
		
		private var comCaller:Object;
		private var comFunction:Function;

		private var m_loadInfo:JBaseLoadInfo;
		public static function creatByteLoad(byte:ByteArray,loadInfo:JBaseLoadInfo):JBaseByteLoad
		{
			var result:JBaseByteLoad = new JBaseByteLoad();
			result.m_byte = byte;
			result.m_loadInfo = loadInfo;
			//result.m_type = loadInfo.type;
			result.m_load = new Loader();
			result.comCaller = loadInfo.caller;
			result.comFunction = loadInfo.callBack;
			return result;
		}

		private static var i:int = 0;
	
		private function onFileError(e:IOErrorEvent):void
		{
		}
		
		public function toLoad():void
		{
			if(!m_byte)
			{
				return;
			}
			trace("loadEnd  Count"  + m_loadInfo.url);

			switch(m_loadInfo.type)
			{
				case JBaseLoadInfo.XML_TYPE:
					byteLoadXML();
					break;
				case JBaseLoadInfo.MP3_TYPE:
					byteLoadMp3();
					break;
				case JBaseLoadInfo.IMG_TYPE:
					byteLoadImg();
					break;
				/*case JBaseLoadInfo.BMP_TYPE:
					byteLoadBMP();
					break;*/
				
				case JBaseLoadInfo.CONFIG_TYPE:
					byteLoadXML();
					break;
				case JBaseLoadInfo.REG_CONFIG_TYPE:
					byteLoadXML();
					break;
				default:
					break;
			}
		}

		private function addEvent():void
		{
			m_load.contentLoaderInfo.addEventListener(Event.COMPLETE, onDataLoaded);
			m_load.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_load.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_load.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}

		private function removeEvent():void
		{
			m_load.contentLoaderInfo.removeEventListener(Event.COMPLETE, onDataLoaded);
			m_load.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onDataProgress);
			m_load.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onDataSecurityError);
			m_load.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onDataFailed);
		}
		private function onDataLoaded(e:Event):void
		{
			comFunction.apply(comCaller,[e.currentTarget.content.bitmapData,m_loadInfo.type,m_loadInfo]);
			removeEvent();
			destroy();

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

		private function byteLoadTF():void
		{

		}

		private function byteLoadXML():void
		{
			m_byte.position = 0;
			var xml:XML = XML(m_byte.readUTFBytes(m_byte.length));
			comFunction.apply(comCaller,[xml,m_loadInfo.type,m_loadInfo]);
			destroy();
		}

		private function byteLoadMp3():void
		{
			comFunction.apply(comCaller,[m_byte,m_loadInfo.type,m_loadInfo]);
			destroy();
		}

		private function byteLoadImg():void
		{
			addEvent();
			var lC:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			lC.allowCodeImport = true;
			m_load.loadBytes(m_byte, lC);
		}

		public var isCom:Boolean = false;
		public function destroy():void
		{
			m_loadInfo = null;
			m_byte = null;
			m_load = null;
			comCaller = null;
			comFunction = null;
			isCom = true;
		}
	}
}