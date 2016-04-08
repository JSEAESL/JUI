package core {
	import BaseRes.JBaseResManager;

	import flash.display.Sprite;

	import mvc.core.Combus;
	import mvc.core.InsEventDispatcher;

	public class AppInit extends Combus
	{
		public function AppInit(Main:Sprite)
		{
			NativePathHelper.Trace();
			InsEventDispatcher.getInstance().setStage(Main.stage);
			JBaseResManager.getInstance().firstLoad(next,Main.stage);
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