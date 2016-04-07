package old.scene
{
	import old.scene.mode.SceneList;
	public class JSceneStateMachine
	{
		
		private static var _instance:JSceneStateMachine
		public static function getInstance():JSceneStateMachine
		{
			if(_instance == null)
			{
				_instance = new JSceneStateMachine(new instanceClass())
			}
			return _instance;
		}
		
		private var CurScene:IScene;
		private var PreSceneList:SceneList;
		public function JSceneStateMachine(insClass:instanceClass)
		{
			PreSceneList = new SceneList();
		}
		
		public function changeScene(dimScene:IScene):void
		{
			if(CurScene)
			{
			CurScene.LeaveScence();				
			}
			
			PreSceneList.push(dimScene);
			CurScene = dimScene;
			
			CurScene.initScence();
			CurScene.EnterScene();
		}
		
		
		public function outCurScene():void
		{
			CurScene.LeaveScence();
		}
		
		public function backProScene():void
		{
			if( PreSceneList.length() )
			{
				changeScene( PreSceneList.getLastScene() );				
			}
		}
		
	}
}

class  instanceClass{}