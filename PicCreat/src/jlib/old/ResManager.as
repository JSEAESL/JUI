package jlib.old
{
	import jlib.I.Cache;
	import jlib.I.SwfCache;
	
	import flash.utils.Dictionary;

	public class ResManager
	{
		static public const KEY:Object = {
			SWF:"swf" , XML:"xml" , IMG:"img" , JSON:"json" , BINARY:"binary", DAT:"dat"};
		
		
		private static var _instance:ResManager;
		public static function get instance():ResManager
		{
			if(_instance == null)
			{
				_instance = new ResManager(new instanceClass());
			}
			return _instance;
		}
		
		
		private var cachesDic:Dictionary = new Dictionary();
		public function ResManager(insClass:instanceClass)
		{

			cachesDic["swf"] = new SwfCache();
		}
	
		public function setRes(type:String,key:String,data:*):void
		{
			var dim:Cache  = cachesDic[type];
			dim.setData(key,data);
		}
		
		public function getSwfMC(key:String,className:String):*
		{
			var dim:SwfCache  = cachesDic["swf"];
			if(key)
			{
				return dim.getMC(key,className);
			}
			return null
		}
		
		
	}
}
class instanceClass{}