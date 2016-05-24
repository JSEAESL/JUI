package jlib.unit
{


	public class JRegCall
	{
		public function JRegCall()
		{
		}
		private static var CallList:Vector.<Function> = new Vector.<Function>();
		private static var CallParList:Vector.<Array> = new Vector.<Array>();
		public static function regCallBack(key:String,fun:Function,funpar:Array = null):Boolean
		{
			CallList[key] = fun;
			if(funpar)
			{
			CallParList[key] = funpar;				
			}
		}
		
		public static function runCallBack(key:String,par:Array = null):Boolean
		{
			if(CallList[key])
			{
				if(CallParList[key])
				{
				CallList[key].apply(null,CallParList[key])					
				}else
				{
					CallList[key].apply(null,par)
				}
				return true;
			}
			
			return false
		}
	}
}