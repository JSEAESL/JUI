package jlib.ui
{
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	
	public class JButtonDeco extends Sprite
	{
		private var _skin:Sprite;			
		private var _button:JAButton;
		private var txt:TextField;
		//var Jb:JButtonDeco = new JButtonDeco("JSEA",new JAButton(JFile.creat.browOpen),null,    onOpenMapFile, JFile.FILE_IMAGE);
		//var Jb:JButtonDeco = new JButtonDeco("JSEA",new JAButton(JFile.creat.browOpen),null);
		//this.addChild(Jb);		
		public function JButtonDeco(lable:String, button:JAButton, skin:Sprite = null, ...arg)
		{
			_button = button;
			_button.argArr = arg;
			
			txt  = creatLabelSkin(lable);
			this.addChild(_button);
			
			_skin = skin;
			if(_skin == null)
			{
				_skin = creatButtonSkin(_skin);
			}
			_button.addChild(_skin);
		
			
			addChild(txt);
			
			
		}
		
		private var wighth:int;
		private function creatLabelSkin(label:String):TextField
		{
			var labText:TextField = new TextField();
			labText.mouseEnabled = false;
			//labText.autoSize = TextFieldAutoSize.CENTER;
			labText.text = label;
			labText.setTextFormat(new TextFormat("Arial",15,null,true));
			wighth = label.length * 20;
			return labText;
		}
		private function creatButtonSkin(_skin:Sprite):Sprite
		{
			return Draw.creatRoundRect(0,0,wighth,20,10,10,0x666666,1);
		}
	}
}