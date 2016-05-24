package jlib.ui.component.box
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
	

	public class JBox extends Sprite
	{

		public function JBox(boxWight:int=233, boxHeight:int=233, bgColor:uint=0x666666, titleHeight:int = 20)
		{
			_titleHeight  = titleHeight;
			_bgColor=bgColor;
			_boxHeight=boxHeight;
			_boxWight=boxWight;

			
			initClass();
			
			
			drawBox();
			//drawTitleBar();
		}

		private var _Alpha:int=1;
		private var _bg:Sprite;

		private var _bgColor:uint;
		private var _boxHeight:int;
		private var _boxWight:int;
		//private var _isDraging:Boolean = false;
		private var _dragable:Boolean=true;

		private var _isShow:Boolean;

		private var _maskShap:Shape;

		private var _titleBar:Sprite;
		private var _titleHeight:int=20;

		private var disObjctList:Vector.<DisplayObject>;
		private var disBtnList:Vector.<DisplayObject>;
		
		private var orgX:int = 0;
		public function addElementBtn(obj:DisplayObject, x:int=0, y:int=0):void
		{
			orgX = 	obj.x= orgX   +  obj.width
			
			//obj.y=_titleHeight + 1 + y;
			disBtnList.push(obj);
			if(_titleBar)
			{
				_titleBar.addChild(obj);
			}
			else
			{
				obj.y=_titleHeight + 1 + y;
				this.addChild(obj);
			}
		
		}
		
		public function addElement(obj:DisplayObject, x:int=0, y:int=0):void
		{
			var count:int = disObjctList.length;
			var posX:int = count%_boxWight;
			var posY:int = count/_boxHeight;
			
			obj.x=posX;
			obj.y=posY*_boxHeight + _titleHeight;
			disObjctList.push(obj);
			this.addChild(obj);
		}
		
		public function addtoBg(obj:DisplayObject):void
		{
			_bg.addChild(obj);
		}

		public function setPos(x:int, y:int):void
		{
			this.x=x;
			this.y=y;
		}

		/*protected function addEvents(sp:Sprite):void
		{
			sp.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			sp.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			sp.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}*/

		protected function drawBox():void
		{
			/*_bg=new Sprite();
			_bg.graphics.clear();
			_bg.graphics.lineStyle(1, 0x000000, _Alpha);
			_bg.graphics.beginFill(_bgColor, _Alpha);
			_bg.graphics.drawRect(0, _titleHeight, _boxWight, _boxHeight);
			_bg.graphics.endFill();*/
			_bg = Draw.creatRect(0, _titleHeight, _boxWight, _boxHeight,_bgColor,_Alpha);
			//initMask();
			addChild(_bg);
		}

		public function serTitleBar(bar:Sprite):void
		{
			_titleBar = bar;
			addChild(_titleBar);
		}


		private function get Alpha():int
		{
			return _Alpha;
		}

		private function set Alpha(alpha:int):void
		{
			this._Alpha=alpha;
			drawBox()
		}

		private function initClass():void
		{
			disBtnList = new Vector.<DisplayObject>();
			disObjctList=new Vector.<DisplayObject>();
		}

		private function initMask():void
		{
			_maskShap=new Shape();
			_maskShap.graphics.beginFill(0);
			_maskShap.graphics.drawRect(10, _titleHeight + 10, _boxWight - 20, _boxHeight - 20);
			//_maskShap.visible = false;
			this.mask=_maskShap;
		}
		
		public function clean():void
		{
			removeChild(_bg);
			drawBox();
		}
	}
}
