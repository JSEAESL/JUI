package jlib.unit
{

	public class JXmlUnit
	{
		public function JXmlUnit()
		{
		}

		

		
		public static function getXmltoArr(xml:XMLList):Array
		{
			var result:Array=[];

			for each (var t:XML in xml)
			{

				var List:XMLList=t.attributes();
				result.push(XmlToObject(List));

			}

			return result;

		}


		public static function XmlToObject(list:XMLList):Object
		{
			var result:Object=new Object();
			for each (var t:XML in list)
			{
				var str:String=t.name();
				result[str]=t.toString();

			}
			return result
		}


	}
}
