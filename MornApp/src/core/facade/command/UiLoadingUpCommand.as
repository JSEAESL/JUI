package core.facade.command
{
	import core.facade.UiLoadingFacade;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class UiLoadingUpCommand extends SimpleCommand
	{
		public function UiLoadingUpCommand()
		{
			super();
		}
		
		override public function execute(notification:INotification):void
		{
			var name:String = notification.getName();
			var body:Object = notification.getBody();
			var type:String = notification.getType();
			switch(type)
			{
				case UiLoadingFacade.UILOADING_START_UP:
					startup(body,type);
					break;
				case UiLoadingFacade.DELAY_TIME_SHOW:
					DelayShow(body);
					break;
			}
		}
		
		private function startup(body:Object,type:String):void
		{
			this.facade.registerProxy(new CommandLineProxy());
			CharaterTitleCommand.Instance().loadNameMesh();
		}
		
		private function DelayShow(body:Object):void
		{
			var UiLoading:UiLoadingMeditor = (facade.retrieveMediator("UiLoadingMeditor") as UiLoadingMeditor);
			if(UiLoading)
			{
				UiLoading.DelayShow(body);
			}
		}

	}
}