package old
{
	import flash.text.TextFormat;

	public class JStrUnti
	{
		public function JStrUnti()
		{
		}
		public static function getDimStr(str:String):String
		{
			var start:int = str.lastIndexOf("/");
			var end:int = str.lastIndexOf(".");
			var dim:String = str.slice(++start,end);
			return dim;
		}
		public static function getUrlLastStr(str:String):String
		{
			var index:int = str.lastIndexOf("/");
			var dim:String = str.slice(++index);
			return dim;
		}
		public static function getUrlSuffixStr(str:String):String
		{
			var index:int = str.lastIndexOf(".");
			var dim:String = str.slice(++index);
			return dim;
		}
		
		public static function replaceSuffixStr(str:String,newSuf:String):String
		{
			var dim:String =  str.replace(JStrUnti.getUrlSuffixStr(str),newSuf);
			return dim;
		}
		
		
	}
}