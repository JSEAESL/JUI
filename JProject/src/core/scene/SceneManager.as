package core.scene
{
	import scene.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import core.IState;
	
	public class SceneManager extends StateMachine implements IEventDispatcher
	{
		private var eventDispatcher:EventDispatcher;
		private var _currentScene:SceneBase
		private var container:DisplayObjectContainer;
		
		public function SceneManager(target:DisplayObjectContainer)
		{
			eventDispatcher=new EventDispatcher(this);
			container=target
			super(container);
		}
		
		public function setContainer(container:DisplayObjectContainer):void
		{
			if (!container){
				return;
			}
			this.container = container;
		}
		
		/**
		 * 是否存在场景
		 * @param sceneName
		 *
		 */
		public function hasScene(sceneName:String):Boolean
		{
			return hasState(sceneName);
		}

		public function checkNowCheckScene(sceneName:String):Boolean
		{
			return (currentScene.sceneName == sceneName);
		}
		
		
		/**
		 * 注册场景
		 * @param scene
		 *
		 */
		public function regScene(scene:SceneBase):void
		{
			if (!scene){
				return;
			}
			addState(scene);
		}
		
		public function removeScene(sceneName:String):void
		{
			var state:IState=getState(sceneName);
			if(state){
				removeState(state);
			}
		}
		
		public function showScene(sceneName:String):void
		{
			if (sceneName == null){
				return;
			}
			currentScene = getState(sceneName) as SceneBase;
		}
		
		public function get currentScene():SceneBase
		{
			return _currentScene;
		}
		
		public function set currentScene(value:SceneBase):void
		{
			if (!value || _currentScene == value){
				return;
			}
			
			if (_currentScene)
			{
				_currentScene.removeEventListener(SceneEvent.SLEEP, sceneEndHandler);
				_currentScene.sleep();
				endEffect(_currentScene);
			}
			
			startEffect(value);
			
			
			_currentScene = value;
			if (!_currentScene.initialized)
			{
				_currentScene.initialize();
			}
			
			_currentScene.addEventListener(SceneEvent.SLEEP, sceneEndHandler);
			
			_currentScene.start();
		}
		
		private function startEffect(scene:SceneBase):void
		{
			if (!scene)
			{
				return;
			}
			container.addChild(scene);
		}
		
		private function endEffect(scene:SceneBase):void
		{
			if (container.contains(scene))
			{
				container.removeChild(scene);
			}
		}
		
		
		private function sceneEndHandler(event:SceneEvent):void
		{
			var scene:SceneBase = SceneBase(event.target)
			if (_currentScene == scene)
			{
				_currentScene.removeEventListener(SceneEvent.SLEEP, sceneEndHandler);
				endEffect(_currentScene);
				_currentScene=null;
				
				showScene(scene.nextScene)
				if (scene)
					scene.nextScene = null
			}
		}
		
		
		
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = true) : void{
			eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
		}
		public function dispatchEvent (event:Event) : Boolean{
			return eventDispatcher.dispatchEvent(event);
		}
		public function hasEventListener (type:String) : Boolean{
			return eventDispatcher.hasEventListener(type);
		}
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false) : void{
			eventDispatcher.removeEventListener(type,listener,useCapture);
		}
		public function willTrigger (type:String) : Boolean{
			return eventDispatcher.willTrigger(type);
		}
	}
}