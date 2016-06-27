package core.facade.command
{

	import core.facade.UiFacade;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class UiUpCommand extends SimpleCommand
	{
		public function UiUpCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			var type:String = notification.getType();
			switch(name)
			{
				case UiFacade.UI_START_UP:
					startup(body,type);
					break;
			}
		}
		
		private function startupSubModule():void
		{
			//sendNotification(PopupType.STARTUP_POPUP_MODULE);
		}
		
		private function registSubMoudleStartupCommands():void
		{
			//facade.registerCommand(PopupType.STARTUP_POPUP_MODULE,PopupStartupCommand);
		}

		private function registProxy():void
		{
			//facade.registerProxy(new MiniMapProxy(null));
		}



		private function startup(body:Object,type:String):void
		{
			var Body:Array = body as Array;
			registProxy();
			registSubMoudleStartupCommands();
			startupSubModule();

		}
	}
}