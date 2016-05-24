package jlib.unit
{
	import flash.utils.Dictionary;

	public class JCallManager
	{
			
		private static var _instance:JCallManager;
		public static function getInstance():JCallManager
		{
			if (_instance == null)
			{
				_instance=new JCallManager()
			}
			return _instance;
		}
		private var FunDic:Dictionary;
		public function JCallManager()
		{
			initClass();
		}
		
		
		private function initClass():void
		{
			FunDic = new Dictionary();
		}
		
		public function regFun(key:*, fun:Function):void
		{
			FunDic[key] = fun
		}
		public function callFun(key:*,arg:Array = null)
		{
			if (FunDic[key])
			{
				(FunDic[key] as Function).apply(null, arg);
				return true;
			}
			return false;
		}
		
		public function deletFun(key:*):Boolean
		{
			if(FunDic[key])
			{
				FunDic[key] = null;
				delete FunDic[key];
				return true;
			}
			return false;
		}
		
	}
}
