package {
	

	public class JStrUnti
	{
		public function JStrUnti()
		{
		}

		public static  function getDimProUrl(str:String):String
		{
			var LastStr:String= getUrlLastStr(str);
			var end:int = str.lastIndexOf(LastStr);
			var dim:String = str.slice(0,end);
			return dim;
		}

		//获取最后文件除后缀
		public static function getDimStr(str:String):String
		{
			var start:int = str.lastIndexOf("/");
			var end:int = str.lastIndexOf(".");
			var dim:String = str.slice(++start,end);
			return dim;
		}

		//获取最后文件名
		public static function getUrlLastStr(str:String):String
		{
			var index:int = str.lastIndexOf("/");
			var dim:String = str.slice(++index);
			return dim;
		}

		//获取后缀
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

		public static function replaceLastStr(str:String,newSuf:String):String
		{
			var dim:String =  str.replace(JStrUnti.getUrlLastStr(str),newSuf);
			return dim;
		}
		
		
	}
}