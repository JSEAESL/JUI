package core.facade.command
{

	import core.facade.HallFacade;
	import core.facade.UiFacade;
	import core.mvc.BaseSimpleCommand;

	import org.puremvc.as3.multicore.interfaces.INotification;

	public class HallUpCommand extends BaseSimpleCommand
	{
		public function HallUpCommand()
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
				case HallFacade.HALL_START_UP:
					startup(body,type);
					break;
				case HallFacade.HALL_END:
					destroy();
					break;
				
			}
		}

		private function destroy():void
		{
			facade.removeProxy(packProxy.NAME);
			//facade.removeProxy(EquipGropProxy.NAME);
			facade.removeProxy(WantedProxy.NAME);
			facade.removeProxy(DailyTasksProxy.NAME);
		}


		private function startup(body:Object,type:String):void
		{

			(facade.retrieveMediator("HallViewMeditor") as HallViewMeditor).show();
			(facade.retrieveMediator("RoleHeadMeditor") as RoleHeadMeditor).delayShow();

			UiFacade.getInstance().sendNotification(UiFacade.TALK_WINDOW,null,UiFacade.TALK_WINDOW);

			facade.registerProxy(new packProxy(null));
			//facade.registerProxy(new EquipGropProxy(null,EquipGropProxy.NAME));
			facade.registerProxy(new WantedProxy(null));
			facade.registerProxy(new DailyTasksProxy(null));
			facade.registerProxy(new OptionProxy(null));

		}
		
	}
}