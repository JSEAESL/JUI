/**
 * Created by JiangHaiYang on 2016/1/18.
 */
package core.common {
    import Game.ui.common.WaitViewUI;

    import core.IResizeable;
    import core.manager.ResizeMananger;
    import core.manager.StageManager;

    import flash.display.Shape;

    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    import morn.core.components.FrameClip;

    import morn.core.components.Image;

    public class WaitLayer extends Sprite implements IResizeable{
        public function WaitLayer() {
            super();
            init();
            initWaitShape();
        }
        private var timer:Timer;
        private var defTime:Number = 3000;
        private var defRepeat:int= 0;
        private function init():void
        {
            timer = new Timer(defTime,defRepeat);
            timer.addEventListener(TimerEvent.TIMER, onTimer);

        }

        private var WaitView:WaitViewUI;
        private function initWaitShape():void
        {
            WaitView = new WaitViewUI();
            ResizeMananger.getInstance().add(this);
        }

        public function resize(width:int,height:int):void
        {
            if(WaitView)
            {
                WaitView.bg.width = width;
                WaitView.bg.height = height;
                WaitView.label.x= (width-WaitView.label.width)*0.5 + WaitView.label.centerX;
                WaitView.label.y= (height-WaitView.label.height)*0.5 + WaitView.label.centerY;
                WaitView.ani.x= (width-WaitView.ani.width)*0.5 + WaitView.ani.centerX;
                WaitView.ani.y= (height-WaitView.ani.height)*0.5 + WaitView.ani.centerY;



                WaitView.width = width;
                WaitView.height = height;
            }
        }

        private function onTimer(e:TimerEvent):void
        {
            CloseWait();
        }

        public function CloseWait():void
        {
            timer.reset();

            StageManager.getInstance().removeTopLayer(WaitView);
            //ResizeMananger.getInstance().remove(this);
        }

        private function OpenWait():void
        {
            StageManager.getInstance().addWaitSprite(WaitView);
        }

        public function WaitTime(time:Number = 3000):void
        {
            timer.delay = time;
            timer.start();
            OpenWait();
        }


    }
}
