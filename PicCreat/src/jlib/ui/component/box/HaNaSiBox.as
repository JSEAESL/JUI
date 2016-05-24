package jlib.ui.component.box
{
	import jlib.ui.component.other.TextFieldHaNaSi;
	

	public class HaNaSiBox extends JBox
	{
		
		
		public var hanasiBox:TextFieldHaNaSi;
		public function HaNaSiBox(bgColor:uint, boxWight:int, boxHeight:int )
		{
			super(bgColor, boxHeight, boxWight);
			hanasiBox = new TextFieldHaNaSi(boxWight-40,boxHeight-60);
			addElement(hanasiBox,20,30);	
			
			
		}
		
		
		
		
	}
}