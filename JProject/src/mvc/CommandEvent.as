package mvc
{
	import flash.events.Event;
	
	public class CommandEvent extends Event
	{
		public var _data:*
		public function CommandEvent(type:String,data:*=null,bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		override public function clone():Event
		{
			return new CommandEvent(type,_data,bubbles,cancelable)
		}
	}
}