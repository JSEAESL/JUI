package core {
	import BaseRes.JBaseResManager;

	import flash.display.Sprite;

	import mvc.core.Combus;
	import mvc.core.InsEventDispatcher;

	public class AppInit extends Combus
	{
		public function AppInit(Main:Sprite)
		{
			InsEventDispatcher.getInstance().setStage(Main.stage);
			NativePathHelper.Trace();

			//Config.uiPath
			//配置
			JBaseResManager.getInstance().firstLoad(next,Main.stage);
			//Config.uiPath = ResourceSystem.GenerateResourcePath("assets/ui.swf");
			function next():void
			{
				MornUIManager.getInsance().init(Main,start);
			}
		}
		
		public function start():void
		{
			
		}
	}
}