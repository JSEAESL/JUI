package core.scene
{
	import flash.utils.Dictionary;
	import morn.SideHelper;

	public class LanguageManager
	{
		public static function get Inatance():LanguageManager
		{
			if(null == _ins)
			{
				_ins= new LanguageManager(new insClass())
			}
			return _ins

		}
		private static var _ins:LanguageManager;
		public function LanguageManager(InsClass:insClass)
		{

		}
		private var config:Object;

		private var language:Dictionary;
		private var endCall:Function;
		public function init(back:Function,proFun:Function = null):void
		{
			endCall = back;
			//config = JResXmlCache.Instance.getConfigBykey("DB");
			language = new Dictionary();
			Continue();
		}

		private var count:int = 0;
		private function Continue():void
		{

		}

		private function endCheck():void
		{
			if(count == 0)
			{
				SideHelper.regFun(SideHelper.Language_CallBack,getStr);
				if(endCall)
				{
					endCall.apply();
				}
			}
		}


		public function getStr(name:String,key:String):String
		{
			if(null == language[name])
			{
				return "nil_nil_nil";
			}
			if(language[name][key])
			{
				return language[name][key];
			}
			return "nil_nil_nil"
		}

		private var SAMPLE_LANGUAGE:String = "sampleLanguage_";
		public function getSampleLanguagetr(key:String):String
		{
			return getStr(InitClass.SAMPLE_LANGUAGE,key)
		}

		public function getSampleLanguageByAdd(strArr:Array):String{
			var result:String = ""
			for(var i:int = 0; i < strArr.length; i++){
				if(getStr(InitClass.SAMPLE_LANGUAGE,strArr[i]) == null){
					continue;
				}
				result += getSampleLanguagetr(strArr[i]);
			}
			return result;
		}
		private var ERROR_CODE:String = "errorCode_";
		public function getErrorCodeStr(code:String):String
		{
			return getStr(InitClass.ERROR_CODE,(ERROR_CODE + code))
		}
		
		
	}
}
class insClass{}