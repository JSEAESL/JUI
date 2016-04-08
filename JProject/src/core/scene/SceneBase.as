package core.scene
{

	import BaseRes.JResXmlCache;

	import core.MornUIManager;


	import flash.display.DisplayObject;
	
	import flash.utils.getDefinitionByName;

	public class SceneBase extends AbstractViewState implements IResizeable
	{
		private var _isStarting:Boolean;
		
		private var _width:int = -1;
		
		private var _height:int = -1;
		
		/**
		 * 是否随场景大小变化而变化; 
		 */		
		protected var resizeEnabled:Boolean = true;
		
		
		private var _panes:Array;
		
		private var _nextScene:String;
		
		protected var manager:SceneManager;
		

		private var NAME:String = "";

		private var loadListloadList:Array;
		public function SceneBase(Name:String)
		{
			NAME = Name;
			super(NAME);
		}

		override public function get height():Number
		{
			return _height;
		}

		override public function set height(value:Number):void
		{
			_height = value;
		}

		override public function get width():Number
		{
			return _width;
		}

		override public function set width(value:Number):void
		{
			_width = value;
		}

		/**
		 * 设置控制器
		 * @param manager
		 * 
		 */		
		override public function setStateMachine(value:StateMachine):void
		{
			this.manager = value as SceneManager;
			super.setStateMachine(value);
		}
		
		
		/**
		 * 获取是否已经在运行状态 
		 * @return 
		 * 
		 */		
		public function get isStarting():Boolean
		{
			return _isStarting;
		}
		
		/**
		 * 获取scene名字
		 * @return 
		 * 
		 */		
		public function get sceneName():String
		{
			return name;
		}
		
		/**
		 * Scene开始运行 
		 */		
		public function start():void
		{
			if (_isStarting)
			{
				return;
			}
			
			doStart();
			
			if (resizeEnabled)
			{
				ResizeMananger.getInstance().add(this);
			}
			
			layoutPanes(_width, _height);
			
			
			_isStarting = true;
			this.dispatchEvent(new SceneEvent(SceneEvent.START));
			//this.addEventListener(SceneEvent.JUMP, jumpHandler);
		}
		
		public function sleep():void
		{
			if (!_isStarting)
			{
				return;
			}
			
			doSleep();
			if (resizeEnabled)
			{
				ResizeMananger.getInstance().remove(this);
			}
			
			_isStarting = false;
			this.dispatchEvent(new SceneEvent(SceneEvent.SLEEP));
		}
		
		/**
		 *  设置获取下一Scene名称
		 * @return 
		 * 
		 */		
		public function set nextScene(name:String):void
		{
			_nextScene = name;
		}
		public function get nextScene():String
		{
			return _nextScene;
		}
		
		/**
		 * 
		 * @param width
		 * @param height
		 * 
		 */		
		public function resize(width:int, height:int):void
		{

			_width=width;
			_height=height;
			layoutPanes(width, height);
			for each (var pane:PaneDefine in _panes)
			 {
				 pane.resize(width,height);
			 }

		}

		public var needDestroy:Boolean = true;
		public function destroy():void
		{
			/*if(needDestroy)
			{
				for each (var pane:PaneDefine in _panes)
				{
					if(pane.Med)
					{
						facade.removeMediator(pane.Med.getMediatorName());
					}
					pane.destroy();
				}

				_panes = [];
			}*/
		}
		
		/**
		 * 在scene执行start前执行的操作
		 * 
		 */		
		protected function doStart():void
		{
			var node:Array =  JResXmlCache.Instance.getSceneNode(this.type);
			for(var index:int = 0;index<node.length;index++)
			{
				trace(node[index]);
				try
				{
					switch(uint(node[index].loadMode))
					{
						case 0:
							regPanel(getDefinitionByName(String(node[index].viewClass)) as Class);
							break;
						case 1:
							//regUI(getDefinitionByName(String(node[index].medClass)) as Class,getDefinitionByName(String(node[index].viewClass)) as Class,node[index].url);
							break;
						case 2:
							//onlyRegMed(getDefinitionByName(String(node[index].medClass)) as Class,getDefinitionByName(String(node[index].viewClass)) as Class,node[index].url);
							break;
						default:
							trace("检查 ProSwfList.xml 配置是否正确");
							break;
					}
				}
				catch(err:Error)
				{
					//LogSystem.Error("exception:" + err.message + "\nstack:\n" + err.getStackTrace());
				}
			}
		}
		/**
		 * 在scene执行sleep后 执行的操作 
		 * 
		 */		
		protected function doSleep():void
		{
		}
		
		/**
		 * 显示面板 
		 * @param width
		 * @param height
		 * 
		 */		
		protected function layoutPanes(width:int = -1, height:int = -1):void
		{
			if (width == -1)
			{
				width = stage.stageWidth;
			}
			
			if (height == -1)
			{
				height =stage.stageHeight;
			}

			for each (var vo:PaneDefine in _panes)
			{
				vo.init();

				//layoutPane(vo.getView(),width, height,vo.x,vo.y,vo.halign, vo.valign);
				//regMed();
			}
		}
		
		/*private var _medList:Array;
		protected function regMed(med:UIBaseMediator):void
		{
			if( (0 > _medList.indexOf(med))  && med)
			{
				_medList.push(med)
			}
		}*/
		
		/**
		 *  面板进自动布局  
		 * @param panel
		 * @param width
		 * @param height
		 * @param padX
		 * @param padY
		 * @param halign
		 * @param valign
		 * 
		 */				
		protected function layoutPane(pane:DisplayObject, width:int, height:int, padX:int,padY:int,halign:String = null, valign:String = null):void
		{
			if (halign != null)
			{
				switch (halign)
				{
					case LayoutType.LEFT:
						pane.x = 0;
						break;
					case LayoutType.CENTER:
						pane.x = (width - pane.width)>>1;
						break;
					case LayoutType.RIGHT:
						pane.x = int(width - pane.width);
						break;
				}
				pane.x += padX;
			}
			if (valign != null)
			{
				switch (valign)
				{
					case LayoutType.TOP:
						pane.y = 0;
						break;
					case LayoutType.MIDDLE:
						pane.y = (height - pane.height)>>1;
						break;
					case LayoutType.BOTTOM:
						pane.y = int(height - pane.height);
						break;
				}
				pane.y += padY;
			}
		}

		/*protected function regUI(medCls:Class,panel:Object,swfUrl:String):void
		{
			var med:UIBaseMediator =  onlyRegMed(medCls,panel,swfUrl);
			med.regSwfUrl(swfUrl,panel,null);
			loadSwf(swfUrl,panel);
		}

		protected function onlyRegMed(medCls:Class,panel:Object,swfUrl:String):UIBaseMediator
		{
			var med:UIBaseMediator = new medCls(null);
			facade.registerMediator(med);
			med.regSwfUrl(swfUrl,panel,loadSwf);
			return med;
		}*/

		private function loadSwf(url:String,pane:Object,callBack:Function = null):void
		{
			MornUIManager.getInsance().loadSwf(url,regView);
			function regView():void
			{
				MornUIManager.getInsance().saveDic(url);
				regPanel(pane);
				layoutPanes();
				if(null != callBack)
				{
					callBack.apply();
				}
			}
		}

		/**
		 * 注册面板
		 * 如果面板为swf中得到的MC，则只做一次注册
		 * @param panel			可以注册一个基于DisplayObject的类，或者一个基于DisplayObject的实例
		 * @param x
		 * @param y
		 * @param halign
		 * @param valign
		 *
		 */
		protected function regPanel(pane:Object, x:int = 0, y:int = 0, halign:String = null, valign:String = null):void
		{
			var cls:Class;
			if (pane is Class)
			{
				cls = pane as Class;
			}
			else
			{
				cls = pane.constructor as Class;
				
				if (pane is DisplayObject)
				{
					var define:PaneDefine = getPanelDefine(DisplayObject(pane));
					if (define)
					{
						define.update(x, y, halign, valign);
						return;
					}
				}
			}
			
			define = new PaneDefine(cls, x, y, halign, valign);
			define.currentView = define.getView();
			_panes.push(define);
		}
		
		public function removePanel(pane:DisplayObject):void
		{
			var len:int = _panes.length;
			var vo:PaneDefine;
			for(var i:int = 0;i<len;i++)
			{
				vo = _panes[i];
				if (vo.currentView == pane)
				{
					break;
				}
			}
			_panes.splice(i,1);
		}
		
		/**
		 * 获取面板定义
		 * @param panel
		 * @return 
		 * 
		 */		
		private function getPanelDefine(panel:DisplayObject):PaneDefine
		{
			for each (var vo:PaneDefine in _panes)
			{
				if (vo.currentView == panel)
				{
					return vo;
				}
			}
			
			return null
		}
		
		/*private function jumpHandler(event:SceneEvent):void
		{
			nextScene = String(event.data)
			this.sleep();
		}*/

		public function disponse():void
		{
			var vo:PaneDefine;
			while(_panes.length>0)
			{
				vo = _panes[1];
				_panes.splice(vo,1);
			}
		}
	}
}


import flash.display.DisplayObject;


class PaneDefine
{
	public function PaneDefine(viewCls:Class, x:int = 0, y:int = 0, halign:String = null, valign:String = null)
	{
		this.cls = viewCls;
		this.x = x;
		this.y = y;
		this.halign = halign;
		this.valign = valign;
	}
	
	private var view:DisplayObject;
	private var med:*;
	public var cls:Class;
	
	public var x:Number;
	
	public var y:Number;
	
	/**
	 * 水平对齐 方式 
	 */	
	public var halign:String;
	
	/**
	 * 垂直对齐方式 
	 */	
	public var valign:String;
	
	public function update(x:int = 0, y:int = 0, halign:String = null, valign:String = null):void
	{
		this.x = x;
		this.y = y;
		this.halign = halign;
		this.valign = valign;
	}

	public function init():void
	{
		getView();
	}
	public function getView():DisplayObject
	{
		if (!view)
		{
			view = new cls();
		}
		return view;
	}
	
	/*public function get Med():UIBaseMediator
	{
		if((view is IMed))
		{
			med = (view as IMed).Med;
			return med

		}
		return null
	}*/
	
	public function get currentView():DisplayObject
	{
		return view;
	}
	
	public function set currentView(value:DisplayObject):void
	{
		view=value;
	}

	public function destroy():void
	{
		if(view.parent)
		{
			view.parent.removeChild(view)
		}
		if(med)
		{
			med.destroy();
		}
		med = null;
		view = null;
	}

	public function resize(width:int, height:int):void
	{
		/*if(Med)
		{
			med.resize(width, height);
		}*/
	}
}