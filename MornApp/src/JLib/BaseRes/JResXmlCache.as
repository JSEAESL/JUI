package JLib.BaseRes
{
	import flash.utils.Dictionary;

	public class JResXmlCache
	{
		private static var _ins:JResXmlCache
		public static function get Instance():JResXmlCache
		{
			if(null == _ins)
			{
				_ins = new JResXmlCache(new InsClass())
			}
			return _ins;
		}

		private var _xmlDic:Dictionary
		public function JResXmlCache(insClass:InsClass)
		{
			_xmlDic = new Dictionary();
			configDic = new Dictionary();
			regConfig = new Dictionary();
		}

		public function getXML(key:String):XML
		{
			if(! _xmlDic[key]) return null;
			return  _xmlDic[key]
		}

		private var configDic:Dictionary;
		private var regConfig:Dictionary;
		public function getConfigBykey(key:*):*
		{
			if(!configDic[key]) return;
			return configDic[key];
		}
		public function regXml(key:String,xml:XML):void
		{
			_xmlDic[key] = xml;

			var ob:Object = {};
			parseXML(xml,xml,ob)
			configDic[key] =ob
		}

		private  function parseXML(xml:XML,orgXml:XML,ob:Object):void
		{
			var nodeName:String = xml.@nodeName;
			var id:String =  xml.@id;
			var sideNode:Boolean = Number(xml.@inside)

			var newOb:Object;
			if(id)
			{
				if(!ob[xml.name()])
				{
					ob[xml.name()] = new Dictionary();
				}
				newOb = ob[xml.name()][id] = 	creatOB(xml);
			}

			if(nodeName)
			{
				var dimXml:XML = sideNode? xml:orgXml;
				var nodes:XMLList = dimXml.elements(nodeName);
				for each(var i:XML in nodes)
				{
					parseXML(i,orgXml,newOb?newOb:ob);
				}
			}

		}

		private  function creatOB(xml:XML):Object
		{
			var result:Object = {};
			var list:XMLList = xml.attributes()
			for each(var i:XML in list)
			{
				result[String(i.name())] = i.valueOf()
			}

			return result;

		}


		public function unRegXml(key:String):Boolean
		{
			if(_xmlDic[key])
			{
				_xmlDic[key] = null;
				delete _xmlDic[key];
				return true;
			}
			return false;
		}

		public function regConfigInit(xml:XML):void
		{
			//_xmlDic[key] = xml;

			var ob:Object = {};
			parseXML(xml,xml,ob)
			regConfig[String(ob.dlgList.dlg.id)] = ob.dlgList.dlg.dlgConfig;
			/*forEachRegDlg(testFun)
			 function testFun(dim:*):void
			 {
			 }*/

		}

		public function forEachRegDlg(regFun:Function):void
		{
			for (var key:String in regConfig["dlg"] )
			{
				regFun( regConfig["dlg"][key] );
			}
		}

		/*public function getDlgRegConfig(id:Number):Dictionary
		 {
		 return regConfig["dlg"]
		 }*/

		private function encodeXml(xml:XML):void
		{
		}



	}
}
class InsClass{}