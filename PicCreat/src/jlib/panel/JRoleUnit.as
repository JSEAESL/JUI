package jlib.panel
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	
	import jlib.old.JFile;
	import jlib.ui.JAButton;
	import jlib.ui.JButtonDeco;
	import jlib.ui.JButtonValue;
	import jlib.ui.JMapBox;
	import jlib.ui.component.box.JBox;
	
	public class JRoleUnit extends Sprite
	{
		
		private var _boc:JMapBox;
		private var _sou:BitmapData;
		
		private var _isMore:Boolean = false;
		public function JRoleUnit(sou:BitmapData, isMore:Boolean = false)
		{
			_sou = sou;
			_isMore = isMore;
			initUI();
		}
		
		private var widthValue:JButtonValue;
		private var heightValue:JButtonValue;
		
		
		
		private var reStarBtn:JButtonDeco;
		private var saveBtn:JButtonDeco;
		
		private var Jb:JButtonDeco;
		private function initUI():void
		{
			_boc = new JMapBox(_sou.width,_sou.height,0xFFFFFF);
			addChild(_boc);
			
			
			widthValue = new JButtonValue(200,0,500);
			heightValue = new JButtonValue(200,0,500);
			reStarBtn = new JButtonDeco("切",new JAButton(reStar));
			saveBtn = new JButtonDeco("保存",new JAButton(toSave));
			
			
			
			_boc.addTitleEle(widthValue);
			_boc.addTitleEle(heightValue);
	
			_boc.addTitleEle(saveBtn);
			if(_isMore)
			{
				_boc.addTitleEle(reStarBtn);
			}
			_boc.addElement(new Bitmap(_sou));
		//	Jb = new JMapBox("JSEA",new JAButton()  ) ;
		//	boc.addElement(Jb);
		
		}
		
	
		private function cut():void
		{
			
		}
		
		private function reStar():void
		{
			
		}
		
		private function toSave():void
		{
			
		}
	}
}