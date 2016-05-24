package jlib.load.slow
{
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	
	import jlib.jevent.JEvent;
	import jlib.load.JURLloader;
	import jlib.load.Jload;

	public class JResourceConfig 
	{
		
		public static const PATH:String = "asstes/config/message.xml";


		private var xmlConfig:XML;
		public function JResourceConfig()
		{
		}
		
		public static function init():void
		{
			 JUrload.creat().toLoad(PATH,setConfig);	
		}
		
		private static function setConfig(dim:URLLoader):void
		{
			JXmlConfigUnit.instance.setConfigAsXml(XML(dim.data));
		}
	}
}