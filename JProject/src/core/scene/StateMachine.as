package core.scene
{
	import flash.utils.Dictionary;
	import core.IState;
	
	/**
	 *  状态机;
	 * 
	 */	
	public class StateMachine
	{
		protected var states:Dictionary;
		protected var _currentState:IState;
		
		private var _target:*;
		
		/**
		 * 状态机 
		 * @param target 状态机控制的对像;
		 * 
		 */		
		public function StateMachine(target:*)
		{
			states=new Dictionary();
			_target =target;
		}
		
		public function get target():*{
			return _target;
		}
		
		
		/**
		 * 添加不同的状态; 
		 * @param value
		 * @return 
		 * 
		 */		
		public function addState(value:IState):Boolean{
			if(states[value.type]){
				return false;
			}
			value.setStateMachine(this);
			states[value.type]=value;
			return true;
		}
		
		/**
		 * 删除状态; 
		 * @param value
		 * @return 
		 * 
		 */		
		public function removeState(value:IState):Boolean{
			if(hasState(value.type)==false)return false;
			
			value.setStateMachine(null);
			states[value.type]=null;
			delete states[value.type];
			return true;
		}
		
		/**
		 * 是否存在状态; 
		 * @param key
		 * @return 
		 * 
		 */		
		public function hasState(key:String):Boolean{
			return states.hasOwnProperty(key);
		}
		
		/**
		 * 取得状态 
		 * @param key
		 * @return 
		 * 
		 */		
		public function getState(key:String):IState{
			return states[key];
		}
		
		/**
		 * 当前状态; 
		 * @return 
		 * 
		 */		
		public function get currentState():IState{
			return _currentState;
		}
		
		/**
		 * 设置当前状态 
		 * @param key
		 * 
		 */		
		public function set state(key:String):void{
			if(_currentState){
				_currentState.exit();
			}
			
			_currentState=getState(key);
			if(_currentState){
				if(_currentState.initialized==false)_currentState.initialize();
				_currentState.enter();
			}
		}
	}
}