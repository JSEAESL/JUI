package core.facade.command
{
	import core.facade.UiFacade;
	import core.mvc.UIBaseMediator;

	import flash.utils.Dictionary;

	import org.puremvc.as3.multicore.interfaces.INotification;
	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class CommonDlgCommand extends SimpleCommand
	{
		public static var SHOW_DLG:String = "show_dlg";
		public static var HIDE_DLG:String = "hide_dlg";

		public static var SEND_TO_DLG:String = "SEND_TO_DLG";


		public static var COM_SHOW_DLG:String = "com_show_dlg";
		public static var COM_HIDE_DLG:String = "com_hide_dlg";

		public function CommonDlgCommand()
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
				case UiFacade.COMMON_DLG_UP:
					start_Up_Dlg();
					break;
				case CommonDlgCommand.SEND_TO_DLG:
					sendNotification(body);
					break;
				case CommonDlgCommand.SHOW_DLG:
					showDlg(body);
					break;
				case CommonDlgCommand.HIDE_DLG:
					hideDlg(body);
					break;
				case CommonDlgCommand.COM_SHOW_DLG:
					comShow(body as ComDlgData);
					break;
				case CommonDlgCommand.COM_HIDE_DLG:
					comHide(body);
					break;
			}
		}

		private function comHide(body):void
		{
			var init:Boolean = initMed(body.DimName);
			if(!init)
			{
				return;
			}
			var med:ComDlgMed = UiFacade.getInstance().retrieveMediator(body.DimName) as ComDlgMed;
			med.hide();
		}

		private function comShow(body:ComDlgData):void
		{
			var init:Boolean = initMed(body.DimName);
			if(!init)
			{
				return;
			}
			var med:ComDlgMed = UiFacade.getInstance().retrieveMediator(body.DimName) as ComDlgMed;
			med.upData(body);
			med.show();
		}

		private function showDlg(body):void
		{
			if(body == null) {
				return;
			}
			var init:Boolean = initMed(body.DimName);
			var med:*;
			med = UiFacade.getInstance().retrieveMediator(body.DimName);
			if(med)
			{
				med.showById(body);
			}
		}
		
		private function hideDlg(body):void
		{
			var init:Boolean = initMed(body.DimName);
			var med :UIBaseMediator = UiFacade.getInstance().retrieveMediator(body.DimName) as UIBaseMediator;
			if(med)
			{
				med.hide()
			}
		}
		
		private function sendNotification(body:Object):void
		{
			var init:Boolean = initMed(body.DimName);
			UiFacade.getInstance().sendNotification(body.Name,body.Data,body.Type);
		}
		
		public static function initMed(Name:String):Boolean
		{
			if(regFunDic[Name])
			{
				(regFunDic[Name] as Function).apply();
				regFunDic[Name] = null;
				delete regFunDic[Name];
				return true;
			}
			return true;
		}
		
		private function hide_dlg(body:Object):void
		{
			
		}
		
		public var Facade:UiFacade = UiFacade.getInstance();
		public static var regFunDic:Dictionary;
		private function start_Up_Dlg():void
		{
			var This:Object = this;
			CommonDlgCommand.regFunDic = new Dictionary();
			/*JResXmlCache.Instance.forEachRegDlg(regFun);
			function regFun(regConfig:Object):void
			{
				CommonDlgCommand.regFunDic[String(regConfig.id)] = waitFun;
				function waitFun():void
				{
					var viewClass:* = ClassHelper.Instance.createClassName(regConfig.viewName);
					var medClass:* = ClassHelper.Instance.createClassName(regConfig.MedName);
					(medClass as UIBaseMediator).setViewComponent(viewClass);
					Facade.registerMediator(medClass)
				}
			}
			return*/
			var regConfig:Object = new Object();
			var tOb:Object = {};

			tOb.id = DlgSelectMediator.NAME;
			tOb.viewName = DlgSelectUIView;
			tOb.MedName = DlgSelectMediator;
			regConfig[tOb.id] = tOb;

			tOb = {};
			tOb.id = DlgInputMediator.NAME;
			tOb.viewName = DlgInputUIView;
			tOb.MedName = DlgInputMediator;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = DlgMsgMediator.NAME;
			tOb.viewName = DlgMsgUIView;
			tOb.MedName = DlgMsgMediator;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = ComDlgChooseMed.NAME;
			tOb.viewName = ComDlgChoose;
			tOb.MedName = ComDlgChooseMed;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = ComDlgMsgMed.NAME;
			tOb.viewName = ComDlgMsg;
			tOb.MedName = ComDlgMsgMed;
			regConfig[tOb.id] = tOb;


			tOb = {};

			tOb.id = ComInputMed.NAME;
			tOb.viewName = ComDlgInput;
			tOb.MedName = ComInputMed;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = ComDlgSetValueMed.NAME;
			tOb.viewName = ComDlgSetValue;
			tOb.MedName = ComDlgSetValueMed;
			regConfig[tOb.id] = tOb;

			/////////////////
			tOb = {};

			tOb.id = SoulUpCreatDlgMediator.NAME;
			tOb.viewName = SoulUpCreatDlgView;
			tOb.MedName = SoulUpCreatDlgMediator;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = SoulCostSellDlgMediator.NAME;
			tOb.viewName = SoulCostSellDlgView;
			tOb.MedName = SoulCostSellDlgMediator;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = SoulResonateDlgMediator.NAME;
			tOb.viewName = SoulResonateDlgView;
			tOb.MedName = SoulResonateDlgMediator;
			regConfig[tOb.id] = tOb;

			tOb = {};

			tOb.id = SoulCreatDlgMediator.NAME;
			tOb.viewName = SoulCreatDlgView;
			tOb.MedName = SoulCreatDlgMediator;
			regConfig[tOb.id] = tOb;


			tOb = {};

			tOb.id = SoulTransferDlgMeditor.NAME;
			tOb.viewName = SoulTransferDlgView;
			tOb.MedName = SoulTransferDlgMeditor;
			regConfig[tOb.id] = tOb;
			////////////////
			for each (var i:Object in regConfig)
			{
				reg(i)
			}

			function reg(i:Object):void
			{
				CommonDlgCommand.regFunDic[String(i.id)] = waitFun;
				function waitFun():void
				{
					var viewClass:* = ClassHelper.Instance.createClass(i.viewName);
					var medClass:* = ClassHelper.Instance.createClass(i.MedName);
					(medClass as UIBaseMediator).setViewComponent(viewClass);
					Facade.registerMediator(medClass);
				}
			}

		}
	}
}