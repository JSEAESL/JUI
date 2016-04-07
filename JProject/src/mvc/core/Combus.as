package mvc.core
{
	import flash.display.Stage;
	
	import mvc.CommandEvent;

	public class Combus
	{
		public static var  dispatcher:InsEventDispatcher = InsEventDispatcher.getInstance(); 
		public function Combus()
		{
		}
		
		public function get stage():Stage
		{
			return dispatcher.stage;
		}
		
		public function addCommand(type:String,callBack:Function,useCapture = false,priority:int=0,useWeakReference = false):void
		{
			dispatcher.addEventListener(type,callBack,useCapture,priority,useWeakReference)
		}
		
		public function removeCommand(type:String,callBack:Function):void
		{
			dispatcher.removeEventListener(type,callBack)
		}

		public function hasCommand(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}

		public function dispatch(command:CommandEvent):Boolean
		{
			return dispatcher.dispatchEvent(command);
		}
	}
}