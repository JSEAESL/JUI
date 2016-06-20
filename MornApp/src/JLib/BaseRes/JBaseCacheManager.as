package JLib.BaseRes
{
	import flash.utils.Dictionary;

	public class JBaseCacheManager
	{
		private static var _instance:JBaseCacheManager;
		public static function getInatsnce():JBaseCacheManager
		{
			if(null == _instance)
			{
				_instance = new JBaseCacheManager();
			}
			
			return _instance;
		}
		public function JBaseCacheManager()
		{
			loadEdDic = new Dictionary();
			bitmapDataDic = new Dictionary();
		}
		
		private var loadEdDic:Dictionary;
		public function isLoad(object:*,key:*):Boolean
		{
			if(!loadEdDic[key])
			{
				loadEdDic[key] = object;
				return false;
			}
			return true;	
		}
		
		private var bitmapDataDic:Dictionary;
		public function pushNewBitmapData(key:*,data:*):Boolean
		{
			if(!bitmapDataDic[key])
			{
				bitmapDataDic[key] = data;
				return false;
			}
			return true;	
		}
		
		public function hasBimapData(key:*):Boolean
		{
			return bitmapDataDic[key];	
		}

	}
}