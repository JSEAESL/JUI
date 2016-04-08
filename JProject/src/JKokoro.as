package
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	import core.AppInit;
	
	public class JKokoro extends Sprite
	{
		public function JKokoro()
		{
			if(stage)
			{
				onAddedToStage()
			}else
			{
				addEventListener(Event.ADDED_TO_STAGE,onAddedToStage);
			}
		}
		
		private function onAddedToStage(e:Event = null):void
		{
			new AppInit(this)
		}
	}
}