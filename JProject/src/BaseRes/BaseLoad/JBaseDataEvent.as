package BaseRes.BaseLoad
{
	import flash.events.Event;

	public class JBaseDataEvent extends Event 
	{
		public static var BaseData:String = "BaseData"//简单数据
		public static var BaseComplete:String = "basecomplete"//简单数据
		public static var HasView:String = "HasView"//简单数据


		private var _data:*;
		public function JBaseDataEvent(type:String, data:* =null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;

		}
		public function get data():*
		{
			return _data;
		}
	}
}