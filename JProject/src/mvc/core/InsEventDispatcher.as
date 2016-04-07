package mvc.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	
	public class InsEventDispatcher extends EventDispatcher
	{
		private static var Ins:InsEventDispatcher


		public static function getInstance():InsEventDispatcher
		{
			if(null == Ins)
			{
				Ins= new InsEventDispatcher(new InsClass())
			}
			return Ins
		}
		
		public function InsEventDispatcher(insClass:InsClass)
		{
		}
		
		private var _stage:Stage
		public function setStage(stage:Stage):void
		{
			if(!stage) return;
			_stage = stage;
			init();
		}
	
		public function get stage():Stage
		{
			return _stage;
		}

		private var topLayer:Sprite;
		private var uiLayer:Sprite;
		private var viewLayer:Sprite;
		private function init():void
		{
			viewLayer = new Sprite();
			uiLayer = new Sprite();
			topLayer  = new Sprite();
			_stage.addChild(viewLayer)
			_stage.addChild(uiLayer)
			_stage.addChild(topLayer)
		}
		
		public function addView(child:DisplayObject):void
		{
			viewLayer.addChild(child)
		}
		public function addUI(child:DisplayObject):void
		{
			uiLayer.addChild(child)

		}
		public function addTop(child:DisplayObject):void
		{
			topLayer.addChild(child)
		}
		
		public function remove(child:DisplayObject):void
		{
			if(!child.parent)return;
			child.parent.removeChild(child);
		}
	}
}
class InsClass{}

	
