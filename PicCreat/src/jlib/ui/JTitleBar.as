package jlib.ui
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class JTitleBar extends Sprite
	{
		
		
		private var _dim:Sprite;
		
		private var _titleHeight:int = 20;
		private var _colour:uint = 0x000000;
		private var _titleBar:Sprite;
		public function JTitleBar(dim:Sprite, titleHeight:int = 20 , colour:uint = 0x000000)
		{
			
			initClass();
			_dim = dim
			_titleHeight = titleHeight;
			_colour = colour;
			initUI();
		}
		
		
		
		private var eleList:Array;

		public function get titleHeight():int
		{
			return _titleHeight;
		}

		private function initClass():void
		{
			eleList = [];
		}
		private function initUI():void
		{
			_titleBar=new Sprite();
			_titleBar.graphics.lineStyle(1);
			_titleBar.graphics.beginFill(0x666666);
			_titleBar.graphics.drawRect(0, 0, _dim.width, _titleHeight);
			_titleBar.graphics.endFill();
			addChild(_titleBar);
			addEvents(_titleBar);
		}
		
		protected function addEvents(sp:Sprite):void
		{
			_dim.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_dim.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_dim.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		protected function onAddedToStage(event:Event):void
		{
			_dim.addEventListener(Event.MOUSE_LEAVE, onMouseLevel);
		}
		
		private var _dragable:Boolean=true;
		protected function onMouseDown(event:MouseEvent):void
		{
			if (_dragable)
			{
				_dim.startDrag();
			}
		}
		
		protected function onMouseLevel(event:Event):void
		{
			if (_dragable)
			{
				_dim.stopDrag();
			}
		}
		
		protected function onMouseUp(event:MouseEvent):void
		{
			if (_dragable)
			{
				_dim.stopDrag();
			}
		}
		
		private var orgX:int = 0
		public function addElement(ele:DisplayObject):void
		{
			eleList.push(ele);
			orgX = ele.x = orgX + ele.width ;
			ele.y = _titleHeight - 20;
			addChild(ele);
		}
		
	}
}