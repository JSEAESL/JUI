package mvc
{
	import flash.display.Stage;
	
	import mvc.core.Combus;
	import mvc.core.InsEventDispatcher;
	
	public class AppInit extends Combus
	{
		public function AppInit(stage:Stage)
		{
			InsEventDispatcher.getInstance().setStage(stage);
		}
		
		public function start():void
		{
			
		}
	}
}