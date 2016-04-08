package core.scene
{
	import core.scene.StateMachine;

	public interface IState
	{
		/**
		 * 是否初始化完成 
		 * @return 
		 * 
		 */		
		function get initialized():Boolean;
		
		/**
		 * 只做一次调用; 
		 * 
		 */		
		function initialize():void
		
		/**
		 * 状态机;
		 * @param value
		 * 
		 */		
		function setStateMachine(value:StateMachine):void;
		
		/**
		 * 状态标识; 
		 * @return 
		 * 
		 */		
		function get type():String;
		
		/**
		 * 退出当前状态时; 
		 * @return 
		 * 
		 */		
		function exit():void
		
		/**
		 * 进入当前状态; 
		 * @param data
		 * 
		 */		
		function enter():void;
	}
}