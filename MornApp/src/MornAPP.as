package {

    import MornLib.MornInit;
    import MornLib.MouseInit;

    import core.StageManager;

    import flash.display.Sprite;
    import flash.events.Event;

    [SWF(backgroundColor="#666666", frameRate="60", width="1024", height="900")]
    public class MornAPP extends Sprite {
        public function MornAPP()
        {
            if(stage != null)
            {
                init();
            }else
            {
                addEventListener(Event.ADDED_TO_STAGE,addToStage);
            }
        }

        private function addToStage(e:Event):void
        {
            removeEventListener(Event.ADDED_TO_STAGE,addToStage);
            init();
        }
        private function init():void
        {
            MouseInit.init();
            StageManager.getInstance().setStage(this.stage);
            MornInit.init(this);
        }
    }
}
