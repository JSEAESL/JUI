package jlib.load.slow
{
	import jlib.unit.JXmlUnit;
	public class JXmlConfigUnit
	{
		private static var _instance:JXmlConfigUnit

		public static function get instance():JXmlConfigUnit
		{
			if (_instance == null)
			{
				_instance=new JXmlConfigUnit(new instanceClass());
			}

			return _instance;
		}

		public function JXmlConfigUnit(insClass:instanceClass)
		{
			_nodeList=[];
		}

		private var _nodeList:Array;

		public function setConfigAsXml(config:XML):void
		{
			
			var nodes:XMLList=config.children();
			for each (var i:XML in nodes)
			{
				var node:XMLList=i.attributes();
				var nod:ResNodeConfig=new ResNodeConfig(i.@url, i.@name, i.@type);
				_nodeList.push(nod);

				if (i.name() == "res")
				{
					initResConfig(i);
				}
			}

		}

		private function initResConfig(xml:XML):void
		{
			var nodes:XMLList=xml.children();
			for each (var i:XML in nodes)
			{
				if(i.name() == "Sounds")
				{
					initSoundConfig(i);
				}
			
				if (i.name() == "Pics")
				{
					initPicConfig(i);
				}
			}
		}

		private function initSoundConfig(xml:XML):void
		{

			
			JXmlUnit.getXmltoArr(xml.children());
			trace(xml);
		}
		
		private function initPicConfig(xml:XML):void
		{
			trace(xml)
		}
	}
}

class instanceClass
{
}
