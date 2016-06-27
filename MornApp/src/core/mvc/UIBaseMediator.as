package core.mvc {
    /*
     *	by StevenZhai @ 2014.7.11
     *
     * 	表现层 - Mediator 基础类,  游戏中所有的 mediator 需要从此处继承
     */

    import com.greensock.TweenLite;

    import core.IDestroy;
    import core.IUIMediator;
    import core.StageManager;

    import flash.display.DisplayObject;
    import flash.events.EventDispatcher;
    import flash.events.MouseEvent;

    import org.puremvc.as3.multicore.interfaces.IMediator;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class UIBaseMediator extends Mediator implements IMediator,IDestroy,IUIMediator {
        public function UIBaseMediator(mediatorName:String = null, viewComponent:Object = null) {
            super(mediatorName, viewComponent);
        }

        protected var Dispatcher:EventDispatcher;

        public function resize(width:int, height:int):void {
            view.x = (width - view.width) / 2;
            view.y = (height - view.height) / 2;
        }

        override public function onRegister():void {
            if (!Dispatcher) {
                Dispatcher = new EventDispatcher();
            }
        }

        override public function setViewComponent(viewComponent:Object):void {
            super.setViewComponent(viewComponent);
        }

        public function defResize(width:int = 0, height:int = 0):void {
            view.width = width ? width : StageManager.getInstance().getStage().stageWidth;
            view.height = height ? height : StageManager.getInstance().getStage().stageWidth;
        }

        public function get view():* {
            return viewComponent;
        }

        protected function init():void {
        }

        public function uiShow(bool:Boolean, type:int = 0):void {
            if (bool) {
                switch (type) {
                    case 0:
                        show();
                        break;
                    case 1:
                        show();
                        break;
                    case 2:
                        delayShow();
                        break;
                    case 3:
                        show();
                        break;
                }

            }
            else {
                destroy();
            }
        }

        protected function OnStopPropagation(e:MouseEvent):void {
            e.stopPropagation()
        }

        protected function addEventListeners():void {
            if (null != view) {
                removeEventListeners();
                view.addEventListener(MouseEvent.MOUSE_DOWN, OnStopPropagation);
//			view.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void{e.stopPropagation()});
                view.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, OnStopPropagation);
//			view.addEventListener(MouseEvent.RIGHT_MOUSE_UP,function(e:MouseEvent):void{e.stopPropagation()});
                view.addEventListener(MouseEvent.CLICK, OnStopPropagation);
//			view.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void{e.stopPropagation()});
//			view.addEventListener(KeyboardEvent.KEY_UP,function(e:KeyboardEvent):void{e.stopPropagation()});
                view.addEventListener(MouseEvent.MOUSE_WHEEL, OnStopPropagation);
            }
        }

        protected function removeEventListeners():void {
            if (null != view) {
                view.removeEventListener(MouseEvent.MOUSE_DOWN, OnStopPropagation);
//			view.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void{e.stopPropagation()});
                view.removeEventListener(MouseEvent.RIGHT_MOUSE_DOWN, OnStopPropagation);
//			view.addEventListener(MouseEvent.RIGHT_MOUSE_UP,function(e:MouseEvent):void{e.stopPropagation()});
                view.removeEventListener(MouseEvent.CLICK, OnStopPropagation);
//			view.addEventListener(KeyboardEvent.KEY_DOWN,function(e:KeyboardEvent):void{e.stopPropagation()});
//			view.addEventListener(KeyboardEvent.KEY_UP,function(e:KeyboardEvent):void{e.stopPropagation()});
                view.removeEventListener(MouseEvent.MOUSE_WHEEL, OnStopPropagation);
            }
        }

        public function destroy():void {
            removeEventListeners();
            UImanager.getInstance().cleanUI(viewComponent as DisplayObject);
            //viewComponent = null;
        }

        private var _isShow:Boolean = false;
        public function get isShow():Boolean {
            return _isShow;
        }

        public function set isShow(boo:Boolean):void {
            _isShow = boo;
        }


        public function show():void {

        }

        public function hide(e:* = null):void {

        }

        public function delayShow():void {
            if (isShow) {
                return;
            }
            if (_panel && _swfUrl && _loadSwf && !viewComponent) {
                //StageManager.getInstance().WaitTime();
                _loadSwf.apply(null, [_swfUrl, _panel, loadEd]);
                return;
            }
            if (viewComponent) {
                //StageManager.getInstance().CloseWait();
                ShowAni(show);
                //show();
            }
            function loadEd():void {
                //StageManager.getInstance().CloseWait();
                swfLoadEd();
                ShowAni(show);
                //show();
            }
        }

        private var isAni:Boolean = false;

        private function ShowAni(callBack:Function):void {
            if (isAni) {
                return;
            }
            callBack.apply();
            isAni = true;
            if (viewComponent) {
                viewComponent.alpha = 0;
                TweenLite.killTweensOf(viewComponent);
                TweenLite.to(viewComponent, 0.7, {alpha: 1});
                TweenLite.delayedCall(0.7, restIsAni)
            }
        }

        private function restIsAni():void {
            isAni = false;
        }

        public function HideAni(callBack:Function):void {
            if (isAni) {
                return
            }
            if (viewComponent) {
                isAni = true;
                viewComponent.alpha = 1;
                TweenLite.killTweensOf(viewComponent);
                TweenLite.to(viewComponent, 0.7, {alpha: 0, onComplete: callBack});
                TweenLite.delayedCall(0.7, restIsAni)
            }
        }

        protected function swfLoadEd():void {
        }

        private var _panel:Object;
        private var _swfUrl:String;
        private var _loadSwf:Function;

        public function regSwfUrl(swfUrl:String, panel:Object, loadSwf:Function):void {
            _swfUrl = swfUrl;
            _panel = panel;
            _loadSwf = loadSwf;
        }
    }
}