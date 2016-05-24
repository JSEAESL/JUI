package jlib.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	
	
	public class JCloseBtn extends Sprite
	{
		private var _skin:Sprite;			
		private var _button:JAButton;
		private var txt:TextField;
		private var dim:Sprite;
		
		
		public static function creat(dim:Sprite):JCloseBtn
		{
			var o:JCloseBtn = new JCloseBtn();
			o.setDim(dim);
			return o;
		}
		
		public function setDim(dim:Sprite):void
		{
			this.dim = dim;	
		}
		public function JCloseBtn()
		{
			
			_button = new JAButton(closeHandler);
			//_button.argArr = arg;
			
			txt  = creatLabelSkin("关闭");
			this.addChild(_button);
			
			_button.addChild( creatButtonSkin() );
			addChild(txt);
			
		}
		private var wighth:int;
		private function creatLabelSkin(label:String):TextField
		{
			var labText:TextField = new TextField();
			labText.mouseEnabled = false;
			labText.text = label;
			wighth = label.length * 20;
			return labText;
		}
		private function creatButtonSkin():Sprite
		{
			return Draw.creatRect(0,0,wighth,20,0x666666,1);
		}
		
		private function closeHandler():void
		{
			if(dim.parent)
			{
				dim.parent.removeChild(dim);
			}
		}
	}
}