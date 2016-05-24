package jlib.load.slow
{
	import jlib.old.JStrUnti;

	public class ResNodeConfig
	{
		
		private var _name:String;
		private var _type:String;
		private var _url:String;
		public function ResNodeConfig(url:String, name:String, type:String = null)
		{
			this.url = url;
			_name = name;
		
			if(type)
			{
				setType(type);
			}
		}
		
		public function set url(str:String):void
		{
			_url = str;
			_type = JStrUnti.getUrlSuffixStr(str);
		}
		
		public function setType(str:String):void
		{
			_type = str;	
		}
		
		public function get name():String
		{
			return _name;
		}
		
		public function get type():String
		{
			return _type;
		}
		
		public function get url():String
		{
			return _url;
		}
	}
}