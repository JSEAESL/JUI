package {

    import MornLib.MornInit;
    import flash.display.Sprite;
    import flash.events.Event;

public class MornAPP extends Sprite {
    public function MornAPP()
    {
        if(stage != null)
        {
            init();
        }
        addEventListener(Event.ADDED_TO_STAGE,addToStage);
    }

	private function addToStage(e:Event):void
    {
        init();
    }
    private function init():void
    {
        MornInit.init();
    }

}
}
