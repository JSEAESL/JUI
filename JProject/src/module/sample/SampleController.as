package module.sample
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	
	import module.sample.command.SampleCommand;
	import module.sample.model.SampleModel;
	import module.sample.view.SampleView;
	
	import mvc.CommandEvent;
	import mvc.Controller;
	
	public class SampleController extends Controller
	{
		public function SampleController()
		{
			super();
		}
		
		private var _view:SampleView;
		private var _model:SampleModel;
		override protected function init():void
		{
			_model = new SampleModel();
			_view = new SampleView();
		}
		
		override protected function setView(view:*):void
		{
			_view = view;
		}
		
		
		override protected function initListeners():void
		{
			addCommand(SampleCommand.SAMPLE_COMMAND_TEST,onSampleCommandTest);
		}
		
		private function onSampleCommandTest(e:CommandEvent):void
		{
			show()
		}
		
		override public function show():void
		{
			dispatcher.addView(_view);
		}
		
		override public function hide():void
		{
			dispatcher.remove(_view);
		}
	}
}