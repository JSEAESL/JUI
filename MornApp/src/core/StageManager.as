package core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;

	public class StageManager extends EventDispatcher
	{
		private static var _ins:StageManager;
		public static function getInstance():StageManager
		{
			if(null == _ins)
			{
				_ins = new StageManager()
			}
			return _ins
		}

		public function StageManager()
		{

		}

		private var _stage:Stage;
		public function setStage(stage:Stage):void
		{
			if(_stage)
			{
				return;
			}
			_stage = stage;
			init();
		}

		public function getStage():Stage
		{
			return _stage;
		}

		private var guideLayer:Sprite;
		private var topLayer:Sprite;

		private function init():void
		{
			Config.uiPath = "assets/ui.swf";
			ResizeMananger.getInstance().bindStage(_stage);
			facadeInit();
			topLayer = new Sprite();
			//App.addDialog();
			_stage.addChild(topLayer);
		}

		private function facadeInit():void
		{

		}



		public function remove(ob:DisplayObject):void
		{
			if(ob.parent)
			{
				ob.parent.removeChild(ob);
			}
		}

	}
}