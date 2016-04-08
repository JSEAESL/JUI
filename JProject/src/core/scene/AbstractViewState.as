package core.scene
{
	import scene.*;
	import flash.display.Sprite;
	import core.IState;
	
	/**
	 * 视图状态; 
	 * 
	 */	
	public class AbstractViewState extends Sprite implements IState
	{
		/**
		 * 是否已完成初始化; 
		 */		
		private var _initialized:Boolean;
		
		/**
		 * 状态管理器; 
		 */		
		protected var stateMachine:StateMachine;
		
		/**
		 * 
		 * @param type 当前状态名称;
		 * 
		 */		
		public function AbstractViewState(name:String)
		{
			this.name=name;
		}
		
		/**
		 * 是否初始化完成 
		 * @return 
		 * 
		 */		
		public function get initialized():Boolean
		{
			return _initialized;
		}
		
		/**
		 * 初始化 
		 * 
		 */		
		public function initialize():void
		{
			_initialized=true;
		}
		
		/**
		 * 设置当前状态由哪个状态机管理 
		 * @param value
		 * 
		 */		
		public function setStateMachine(value:StateMachine):void
		{
			stateMachine=value;
		}
		
		/**
		 * 当前状态名称; 
		 * @return 
		 * 
		 */		
		public function get type():String
		{
			return name;
		}
		
		/**
		 * 退出当前状态; 
		 * 
		 */		
		public function exit():void
		{
		}
		
		/**
		 * 进入当前状态; 
		 * 
		 */		
		public function enter():void
		{
		}
	}
}