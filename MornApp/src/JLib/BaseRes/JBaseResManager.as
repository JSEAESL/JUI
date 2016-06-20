package JLib.BaseRes
{
	import JLib.BaseMusic.JSoundManager;
	import JLib.BaseRes.BaseLoad.JBaseLoad;
	import JLib.BaseRes.BaseLoad.JBaseLoadInfo;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;

	public class JBaseResManager
	{
		private static var _instance:JBaseResManager;
		public static function getInstance():JBaseResManager
		{
			if(null == _instance)
			{
				_instance = new JBaseResManager();
			}
			return _instance;
		}

		public function JBaseResManager()
		{
			initClass();
		}

		private var BaseLoad:JBaseLoad; 
		private function initClass():void
		{
			BaseLoad = new JBaseLoad();

		}

		private var edCallBack:Function;
		public function firstLoad(allCallback:Function = null,proFun:Function = null):void
		{
			edCallBack = allCallback;
			BaseLoad.setLoadData(JBaseLoadInfo.creatInfo("config/baseRes.xml",JBaseLoadInfo.XML_TYPE,"1",this,fristComFun,proFun));
			BaseLoad.load();
		}

		private function fristComFun(data:Object,type:String,load:*):void
		{
			var xml:XML = data as XML;
			getAttributesXml(xml,xml);
		}

		private function getAttributesXml(xml:XML,orgXml:XML):void
		{
			var xmlname:String = xml.@xmlName;
			var isRes:Boolean = Number(xml.@isRes);
			var hasRes:Boolean = Number(xml.@hasRes);
			var newXml:XML;
			if(xmlname)
			{
				var dimXml:XML = hasRes? xml:orgXml;
				var resNode:XMLList = dimXml.elements(xmlname);
				for each(var i:XML in resNode)
				{
					trace("getAttributesXml");
					trace(xmlname);
					trace(isRes);
					trace(newXml);
					getAttributesXml(i,orgXml);
				}
			}
			if(isRes)
			{
				loadResXml(xml)
			}
		}

		private var loadCount:int = 0;
		private function loadResXml(xml:XML):void
		{
			var id:String = xml.@id;
			var url:String = xml.@url;
			var type:String = xml.@type;
			trace("loadResXml")
			trace(id)
			trace(url)
			trace(type)
			var boo:Boolean  = BaseLoad.setLoadData(JBaseLoadInfo.creatInfo(url,type,id,this,getCallBackFun(type) ));

			if(boo)
			{
				BaseLoad.load();
				loadCount++;
			}

		}

		public function getCallBackFun(type:String):Function
		{
			var result:Function;
			switch(type)
			{
				case JBaseLoadInfo.TEST_TYPE:
					result = testFun;
					break;
				case JBaseLoadInfo.REG_CONFIG_TYPE:
					result = regConfigFun;
					break;
				case JBaseLoadInfo.CONFIG_TYPE:
					result = configLoadComFun;
				break;
				case JBaseLoadInfo.XML_TYPE:
					result = xmlLoadComFun;
				break;
				case JBaseLoadInfo.IMG_TYPE:
					result = imgLoadComFun;
				break;
				case JBaseLoadInfo.MP3_TYPE:
					result = map3LoadComFun;
				break;


			}
			return result
		}

		private function testFun(data:Object,type:String,load:*):void
		{
			
		}
		
		private function regConfigFun(data:Object,type:String,load:*):void
		{
			var xml:XML = data as XML;
			JResXmlCache.Instance.regConfigInit(xml);
			endCheck();
		}
		
		private function configLoadComFun(data:Object,type:String,load:*):void
		{
			var xml:XML = data as XML;
			JResXmlCache.Instance.regXml(load.id,xml);
			endCheck();
		}
		
		private function xmlLoadComFun(data:Object,type:String,load:*):void
		{
			var xml:XML = data as XML;
			trace("xmlLoadComFun");
			trace(data)
			trace(type)
			trace(load)
			getAttributesXml(xml,xml);
			endCheck();
		}

		private function map3LoadComFun(data:Object,type:String,load:*):void
		{
			JSoundManager.getInstance().saveCaseSound(load.id,data as ByteArray);
			endCheck();
		}

		private function imgLoadComFun(data:BitmapData,type:String,load:*):void
		{
			JBaseCacheManager.getInatsnce().pushNewBitmapData(load.id,data);
			endCheck();
		}

		private function endCheck():void
		{		
			loadCount--;
			if(loadCount == 0)
			{
				edCallBack.apply(null,null);
				edCallBack = null;	
			}
		}

	}
}