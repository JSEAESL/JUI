package jlib.ui
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import jlib.ui.component.box.JBox;
	
	public class JMapBox extends JBox
	{
		public function JMapBox(boxWight:int=233, boxHeight:int=233, bgColor:uint=0x666666 )
		{
			super(boxWight, boxHeight,bgColor, 50);
			
			initBar();
		}
		
		private var titleBar:JTitleBar;
		private function initBar():void
		{
			titleBar = new JTitleBar(this,50);
			super.serTitleBar(titleBar);
			titleBar.addElement(JCloseBtn.creat(this));
		}
		
		public function addTitleEle(ele:Sprite):void
		{
			titleBar.addElement(ele);
		}
		
		public function addLine(line:DisplayObject):void
		{
			line.y = titleBar.titleHeight;
			addChild(line);
		}
	}
}