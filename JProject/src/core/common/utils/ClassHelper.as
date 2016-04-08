package core.common.utils
{
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class ClassHelper
	{
		private static var _ins:ClassHelper;
		public static function get Instance():ClassHelper
		{
			if(_ins == null)
			{
				_ins = new ClassHelper(new InsClass());
			}
			return _ins;
		}
		private var _caseDic:Dictionary;
		public function ClassHelper(insClass:InsClass)
		{
			_caseDic = new Dictionary();
		}
		
		public function createClassName(className:String):*
		{
			var ret:* = null;
			var ClassReference:Class = getDefinitionByName(className) as Class;
			ret = createClass(ClassReference);
			
			return ret;
		}
		public function createClass(cls:Class):*
		{
			var ret:* = null;
			ret = getCaseClass(cls);
			if(!ret)
			{
				if(cls != null)
				{
					ret = new cls();
				}
				saveCase(ret);
			}
			return ret;
		}
		
		private function saveCase(Case:*):void
		{
			_caseDic[getQualifiedClassName(Case)] = Case;
		}
		
		private function getCase(className:String):*
		{
			return _caseDic[className]
		}
		
		public function getCaseClass(cls:Class):*
		{
			var className:String = getQualifiedClassName(cls);
			return getCase(className);
		}
	}
}
class InsClass{}