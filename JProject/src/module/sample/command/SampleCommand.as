package module.sample.command
{
	import mvc.CommandEvent;
	
	public class SampleCommand extends CommandEvent
	{
		public static const SAMPLE_COMMAND_TEST:String = "sampleCommandTest";

		public function SampleCommand(type:String, data:*=null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, data, bubbles, cancelable);
		}
	}
}