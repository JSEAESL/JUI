package core
{

import BaseRes.BaseLoad.JBaseDataEvent;

	import core.common.CreatUtil;

	import core.manager.MornUIManager;
	import core.module.fight.fightTeamView.FightTeamView;
	import core.module.hall.backpack.BackPackExtra.View.ExtraChestView;
	import core.module.hall.backpack.BackPackExtra.View.ExtraSpendNumView;
	import core.module.hall.backpack.view.BackPackView;
	import core.module.hall.equipStreng.view.EnchantPanelView;
	import core.module.hall.equipStreng.view.EquipStrengView;
	import core.module.createHeroScene.view.CreateHeroView;
	import core.module.hall.equipStreng.view.GemSynView;
	import core.module.hall.roleClickPanel.RoleClickPanelView;
	import core.module.hall.roleInfoPanel.RoleInfoPanelView;
	import core.module.hall.task.smalltaskpanel.SmallTaskPanelView;
	import core.module.hall.task.taskJournal.TaskJournalView;
	import core.module.hall.task.taskPanel.TaskPanelView;

	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import core.common.utils.manager.UImanager;
	import core.module.common.miniMap.MiniMapView;
	import core.module.fight.SystemMenu.view.SystemMenuView;
	import core.module.login.view.LoginView;
	import core.module.selectMap.SelectMapView;
	import core.module.settle.view.SettleGetItemView;
	import core.module.settle.view.SettlementView;
	import core.module.talkWindow.view.TalkWindowView;

	import flash.utils.Dictionary;


	public class UIFactory extends EventDispatcher
	{
		public function UIFactory(target:IEventDispatcher=null)
		{
			super(target);
		}

		public static function getInstance():UIFactory
		{
			if(_instance == null)
			{
				_instance = new UIFactory();
				SwfUrlDic = new Dictionary();
				loadedDic = new Dictionary();

				initUrlDic();
				init();
			}
			return _instance;
		}

		private static var callBackDic:Dictionary;
		private static function init():void
		{
			UIFactory.getInstance().addEventListener(JBaseDataEvent.BaseComplete,getView);
			UIFactory.getInstance().addEventListener(JBaseDataEvent.HasView,getCheckEdMed);
			callBackDic = new Dictionary();
		}

		private  static function getCheckEdMed(e:JBaseDataEvent):void
		{
			var callBack:Function =	callBackDic[e.data.viewClass];
			if(callBack)
			{
				callBack.apply(null,[e.data.view.Med]);
				callBackDic[e.data.viewClass] = null;
				delete callBackDic[e.data.viewClass];
			}

		}

		private static function getView(e:JBaseDataEvent):void
		{
			e.data.show();
			CreatUtil.showAni(e.data);
		}

		public function getGemSynView():GemSynView
		{
			return getView(GemSynView) as GemSynView;
		}

		public function getEnchantResultView():EnchantPanelView
		{
			return getView(EnchantPanelView) as EnchantPanelView;
		}
		
		public function getSettleView():SettlementView
		{
			return getView(SettlementView) as SettlementView;
 		}

		public function getExtraChestView():ExtraChestView
		{
			return getView(ExtraChestView) as ExtraChestView;
		}

		public function getTalkWindowView():TalkWindowView
		{
			return getView(TalkWindowView) as TalkWindowView;
		}

		public function getEquipStrengthenView():EquipStrengView
		{
			return getView(EquipStrengView) as EquipStrengView;
		}

		public function getBackPackView():BackPackView
		{
			return getView(BackPackView) as BackPackView;
		}

		public function getSystemMenuView():SystemMenuView
		{
			return getView(SystemMenuView) as SystemMenuView;
		}

		public function getSelectMapView():SelectMapView
		{
			return getView(SelectMapView) as SelectMapView;
		}

	//public function getSettleItemView():SettleItemView
	//{
	//	return getView(SettleItemView) as SettleItemView;
	//}
	/*	public function getFightStateView():FightStateView
		{
			return getView(FightStateView) as FightStateView
		}

		public function getPopAniView():FightAniView
		{
			return getView(FightAniView) as FightAniView
		}
*/
/*		public function cleanView(ob:DisplayObject):void
		{
			UImanager.getInstance().cleanUI(ob);
		}
		
		public function getHallView():HallViewUIView
		{
			return getView(HallViewUIView) as HallViewUIView
		}*/
		public function getTaskPanel():TaskPanelView
		{
			return getView(TaskPanelView) as TaskPanelView;
		}

		public function getTaskjournal():TaskJournalView
		{
			return getView(TaskJournalView) as TaskJournalView;
		}
		public function getMiniMapView():MiniMapView
		{
			return getView(MiniMapView) as MiniMapView;
		}

		public function getCreateHeroScene():CreateHeroView
		{
			return getView(CreateHeroView) as CreateHeroView;
		}

		public function getFightTeamView():FightTeamView
		{
			return getView(FightTeamView) as FightTeamView;
		}


		public function hasView(classRef:Class):*
		{
			var view:* = UImanager.getInstance().getUIbyClass(classRef) as classRef;
			if(view == null)
			{
				return null;
			}
			return view
		}

		public function initView(classRef:Class):void
		{
			var view:* = hasView(classRef);
			if(view)
			{
				view.show();
			}
			getDealyLoadView(classRef,getSwfUrl(classRef) );
		}

		public function getMed(viewClass:Class,callFun:Function = null):void
		{
			if(callFun)
			{
				callBackDic[viewClass] = callFun;
			}

			var This:Object = this;
			var view:* = hasView(viewClass);
			if(view)
			{
				dispatchEvent(new JBaseDataEvent(JBaseDataEvent.HasView,{"view":view,"viewClass":viewClass}));
			}else
			{
				getDealyLoadView(viewClass,getSwfUrl(viewClass),JBaseDataEvent.HasView );
			}

		}


		public function checkView(classRef:Class):Boolean
		{
			var view:* = hasView(classRef);
				if(view)
				{
					return true;
				}
			return false;
		}


		public function getView(classRef:Class):*
		{
			var view:* = hasView(classRef);
			if(view == null)
			{
				view = UImanager.getInstance().createUIBYClass(classRef) as classRef;
			}
			return view;
		}


		public function getLoginView():LoginView
		{
			return getView(LoginView) as LoginView;
		}
		public function initLoginView():void
		{
			getDealyLoadView(LoginView,"assets/newFla/LoginView.swf");
		}




		//共享
		public function getExtraSpendView():ExtraSpendNumView
		{
			return getView(ExtraSpendNumView) as ExtraSpendNumView;
		}
		public function getSettleGetItemView():SettleGetItemView
		{
			return getView(SettleGetItemView) as SettleGetItemView;
		}

		public function getSmallTaskView():SmallTaskPanelView
		{
			return getView(SmallTaskPanelView) as SmallTaskPanelView;
		}

		private static var SwfUrlDic:Dictionary;
		private static function initUrlDic():void
		{
			//JResXmlCache.Instance.initUrlDic(SwfUrlDic);
			//trace("over");
			//SwfUrlDic
			//共享
			SwfUrlDic[ExtraSpendNumView] = "assets/newFla/BackPackView.swf";
			SwfUrlDic[SmallTaskPanelView] = "assets/newFla/BackPackView.swf";
			SwfUrlDic[SettleGetItemView] = "assets/newFla/BackPackView.swf";
			SwfUrlDic[LoginView] = "assets/newFla/LoginView.swf";
			SwfUrlDic[GemSynView] = "assets/newFla/GemSynView.swf";
			SwfUrlDic[SettlementView] = "assets/newFla/SettlementView.swf";
			SwfUrlDic[ExtraChestView] = "assets/newFla/ExtraChestView.swf";
			SwfUrlDic[TalkWindowView] = "assets/newFla/TalkWindowView.swf";
			SwfUrlDic[EquipStrengView] = "assets/newFla/EquipGrowView.swf";
			SwfUrlDic[BackPackView] = "assets/newFla/BackPackView.swf";
			SwfUrlDic[SystemMenuView] = "assets/newFla/SystemMenuView.swf";
			SwfUrlDic[TaskPanelView] = "assets/newFla/TaskPanelView.swf";
			//SwfUrlDic[TaskJournalView] = "assets/newFla/TaskJournalView.swf";
			SwfUrlDic[MiniMapView] = "assets/newFla/MiniMapView.swf";
			SwfUrlDic[RoleInfoPanelView] = "assets/newFla/RoleInfoPanelView.swf";
			SwfUrlDic[CreateHeroView] = "assets/newFla/CreateHeroScene.swf";
			SwfUrlDic[SelectMapView] = "assets/newFla/CreatPlayerView.swf";
			SwfUrlDic[FightTeamView] = "assets/newFla/FightTeamView.swf";
			SwfUrlDic[RoleClickPanelView] = "assets/newFla/RoleClickPanelView.swf";
			SwfUrlDic[EnchantPanelView] = "assets/newFla/EquipGrowView.swf";
		
			//无效
			//SwfUrlDic[SettleItemView] = "assets/newFla/SettleItemView.swf";
		}

		private function getSwfUrl(classRef:Class):String
		{
			return SwfUrlDic[classRef];
		}

		private static var loadedDic:Dictionary;
		private function getDealyLoadView(classRef:Class,url:String,EventType:String = null):void
		{
			var This:* = this;


			if(!loadedDic[url])
			{
				trace("延时首次加载SWF 路径：" + url )

				MornUIManager.getInsance().loadSwf(url,completeFun);
			}else
			{
				trace("该路径有缓存 直接回调" + url )

				completeFun();
			}
			function completeFun():void
			{
				loadedDic[url] = url;
				if(!EventType)
				{
					EventType = JBaseDataEvent.BaseComplete;
				}
				var view:* =  getView(classRef);
				if(EventType == JBaseDataEvent.HasView)
				{
					This.dispatchEvent(new JBaseDataEvent(EventType,{"view":view,"viewClass":classRef}));
				}else
				{
					This.dispatchEvent(new JBaseDataEvent(EventType,view));
				}
			}
		}

		public function getRoleClickPanel():RoleClickPanelView
		{
			return getView(RoleClickPanelView) as RoleClickPanelView;
		}

		public function getRoleInfoPanel():RoleInfoPanelView
		{
			return getView(RoleInfoPanelView) as RoleInfoPanelView;
		}
		private static var _instance:UIFactory = null;
	}
}