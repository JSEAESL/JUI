package core.common.utils.manager
{
	import flash.display.DisplayObject;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;

	public class UImanager
	{
		public function UImanager()
		{
		}
		
		public function getUIbyClassName(className:String):DisplayObject
		{
			return _uiDic[className];
		}
		
		public function getUIbyClass(uiclass:Class):DisplayObject
		{
			var className:String = getQualifiedClassName(uiclass);
			return getUIbyClassName(className);
		}
		
		public function setUI(displayObject:DisplayObject):void
		{
			_uiDic[getQualifiedClassName(displayObject)] = displayObject;
		}
		
		public function createUIByClassName(className:String):*
		{
			var ret:* = null;
			var ClassReference:Class = getDefinitionByName(className) as Class;
			ret = createUIBYClass(ClassReference);
			
			return ret;
		}
		
		public function createUIBYClass(uiClass:Class):*
		{
			var ret:* = null;
			ret = getUIbyClass(uiClass);
			if(!ret)
			{
				if(uiClass != null)
				{
					ret = new uiClass();
				}
				setUI(ret);
			}
			
			return ret;
		}
		
		public static function getInstance():UImanager
		{
			if(_instance == null)
			{
				_instance = new UImanager;
			}
			return _instance;
		}
		
		public function cleanUI(displayObject:DisplayObject):Boolean
		{
			if(_uiDic[getQualifiedClassName(displayObject)])
			{
				_uiDic[getQualifiedClassName(displayObject)] = null;
				delete _uiDic[getQualifiedClassName(displayObject)];
			}
			
			if(displayObject && displayObject.parent)
			{
				displayObject.parent.removeChild(displayObject);
				return true

			}
			return false
		}
		
		private var _uiDic:Dictionary = new Dictionary();
		private static var _instance:UImanager;
	}
}