package core
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Rectangle;
	
	import core.IResizeable;
	
	/**
	 * 场景大小变化管理类;
	 *
	 * 主要设置了变化的最小范围,让注册的面板在最小范围之外进行位置的调整;
	 *
	 */	
	public class ResizeMananger extends EventDispatcher implements IResizeable
	{
		protected static var stage:Stage;
		protected var resizeList:Vector.<IResizeable>;
		
		protected var initialized:Boolean=false;
		protected var _miniSize:Rectangle;
		protected var _maxSize:Rectangle;
		protected var _currentSize:Rectangle;
		
		
		protected static var  instance:ResizeMananger;
		public static function getInstance():ResizeMananger{
			if(instance==null){
				new ResizeMananger();
			}
			return instance;
		}
		
		public function ResizeMananger()
		{
			if(instance)throw new Error("");
			resizeList=new Vector.<IResizeable>();
			
			_currentSize=	new Rectangle(0,0,400,300);
			_miniSize=		new Rectangle(0,0,400,300);
			_maxSize=		new Rectangle(0,0,2880,2880);
			
			instance=this;
		}
		

		/**
		 * 绑定要侦听场景的resize事件;
		 * @param stage 被侦听场景;
		 *
		 */		
		public function bindStage(stage:Stage):void{
			
			if(stage==null)return;
			if(initialized)return;
			initialized=true;
			ResizeMananger.stage=stage;
			
			_currentSize.width=stage.stageWidth;
			_currentSize.height=stage.stageHeight;
			stage.addEventListener(Event.RESIZE,resizeHandler);
		}
		
		/**
		 * 更新当前宽度(取大值);
		 *
		 */		
		protected function updatecurrentSize():Rectangle{
			if(stage==null)return null;
			
			var sw:int=stage.stageWidth;
			var sh:int=stage.stageHeight;
			
			sharedTempRec.width=Math.min(this._maxSize.width,Math.max(this._miniSize.width,sw));
			sharedTempRec.height=Math.min(this._maxSize.height,Math.max(this._miniSize.height,sh));
			
			//如果当前值跟旧值一样;
			if(_currentSize.width==sharedTempRec.width && _currentSize.height==sharedTempRec.height){
				return null;
			}
			
			return sharedTempRec;
		}
		private var sharedTempRec:Rectangle=new Rectangle();
		
		/**
		 * 设置一个最小区域,比这个区域小的屏幕将不进行动态调整;
		 * @param width
		 * @param height
		 *
		 */		
		public function setMiniSize(width:int,height:int):void{
			this._miniSize.width=width;
			this._miniSize.height=height;
			
			if(this._maxSize.width<width){
				this._maxSize.width=width;
			}
			if(this._maxSize.height<height){
				this._maxSize.height=height;
			}
		}
		
		public function setMaxSize(width:int,height:int):void{
			this._maxSize.width=width;
			this._maxSize.height=height;
			
			if(this._miniSize.width>width){
				this._miniSize.width=width;
			}
			if(this._miniSize.height>height){
				this._miniSize.height=height;
			}
		}
		
		/**
		 * 取得最小区域;
		 * @return
		 *
		 */		
		public function getMiniSize():Rectangle{
			return _miniSize;
		}
		public function getMaxSize():Rectangle{
			return _maxSize;
		}
		
		/**
		 * 场景被调整;
		 * @param event
		 *
		 */		
		protected function resizeHandler(event:Event):void{
			var size:Rectangle=this.updatecurrentSize();
			if(size==null){
				return;
			}
			this.resize(int(size.width),int(size.height));
			
			_currentSize.width=int(size.width);
			_currentSize.height=int(size.height);
		}
		
		public function get currentSize():Rectangle{
			return _currentSize;
		}
		
		
		/**
		 * 调整位置,触发调整所有注册项; ;
		 * @param width
		 * @param height
		 *
		 */		
		public function resize(width:int,height:int):void{
			for each(var item:IResizeable in resizeList){
				item.resize(width,height);
			}
		}
		
		/**
		 *	添加;
		 * @param item
		 * @return
		 *
		 */		
		public function add(item:IResizeable):int{
			
			if(resizeList.indexOf(item) !=-1)return -1;
			
			if(stage){
				addingResize(item);
			}
			return resizeList.push(item);
		}
		
		protected function addingResize(item:IResizeable):void{
			item.resize(_currentSize.width,_currentSize.height);
		}
		
		/**
		 *  刷新当前的坐标;
		 * @param value
		 * 
		 */		
		public function refreash(value:IResizeable):void{
			value.resize(_currentSize.width,_currentSize.height);
		}
		
		/**
		 * 删除
		 * @param item
		 * @return
		 *
		 */		
		public function remove(item:IResizeable):int{
			var index:int=resizeList.indexOf(item);
			if(index==-1)return -1;
			
			resizeList.splice(index,1);
			return index;
		}
		
		private static var stageBounds:Rectangle=new Rectangle();
		
		/**
		 * 静态的居中方法; 
		 * @param display 要居中的对像;
		 * @param padX 居中后再向x轴调整偏移值;
		 * @param padY 居中后再向y轴调整偏移值;
		 * @param parentBounds 居中对像所在的父容器区域框,默认为stage的区域框;
		 * 
		 */			
		public static function center(display:DisplayObject,padX:int=0,padY:int=0,parentBounds:Rectangle=null):void{
			if(parentBounds==null){
				if(!stage && display.stage){
					stage=display.stage;	
				}
				if(stage==null)return;
				
				stageBounds.width=stage.stageWidth;
				stageBounds.height=stage.stageHeight;
				parentBounds=stageBounds;
			}
			display.x=((parentBounds.width-display.width)>>1)+padX;
			display.y=((parentBounds.height-display.height)>>1)+padY;
		}
		
	}
}

