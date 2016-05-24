package jlib.old
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import jlib.ui.JCloseBtn;
	import jlib.ui.JTitleBar;
	import jlib.ui.component.box.JBox;
	
	public class JPanelBox extends Sprite
	{
		private var _box:JBox;
		
		private var JTitle:JTitleBar;
		public function JPanelBox(boxWight:int=233, boxHeight:int=233, bgColor:uint=0x666666, titleHeight:int = 20)
		{
			_box = new JBox(boxWight,boxHeight,bgColor, titleHeight);
			JTitle = new JTitleBar(_box);
			_box.serTitleBar(JTitle)
				
			_box.addElementBtn(JCloseBtn.creat(_box));
			addChild(_box);
		}
		
	
		
		public function addElementBtn(obj:DisplayObject):void
		{
			
			_box.addElementBtn(obj);
		}
		
		public function addElement(obj:DisplayObject):void
		{
			_box.addElement(obj);
		}

	}
}