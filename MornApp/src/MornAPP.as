package {

    import MornLib.MornInit;

    import core.StageManager;

    import flash.display.Sprite;
    import flash.events.Event;

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
        StageManager.getInstance().setStage(this.stage);
        MornInit.init(this);
    }

}
}
