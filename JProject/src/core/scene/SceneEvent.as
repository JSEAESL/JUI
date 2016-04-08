package core.scene
{
	import flash.events.Event;

	public class SceneEvent extends Event
	{
		public var data:Object
		public function SceneEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			this.data = data;
			super(type, bubbles, cancelable);
		}
		
		
		public static const START:String = "scene_start";
		public static const SLEEP:String = "scene_sleep";
		
		public static const JUMP:String = "scene_jump";
		public static const PANEL_INITIALIZED:String = "scene_panel_initialized";
		
		public static const HIDE:String = "scene_hide";
		
		public static const SHOW:String = "scene_show";
		
		
		override public function clone():Event{
			return new SceneEvent(type,data,bubbles,cancelable);
		}
	}
}