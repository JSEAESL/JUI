package core.facade {
    import core.facade.command.UiLoadingUpCommand;
    import core.mvc.BaseFacade;

    import flash.display.Sprite;

    public class UiLoadingFacade extends BaseFacade {

        public static const UILOADING_FACADE:String = "uiloading_facade";

        public static const UILOADING_START_UP:String = "uiloading_start_up";

        public static const DELAY_TIME_SHOW:String = "delay_time_show";

        public function UiLoadingFacade(key:String) {
            super(key);
        }

        public static function getInstance(key:String = UILOADING_FACADE):UiLoadingFacade {
            if (instanceMap[key] == null) {
                instanceMap[key] = new UiLoadingFacade(key);
            }
            return instanceMap[key];
        }

        override protected function initializeController():void {
            super.initializeController();
            registerCommand(UILOADING_START_UP, UiLoadingUpCommand);
        }

        public function startup(gameView:Sprite):void {
            sendNotification(UILOADING_START_UP, gameView);
        }
    }
}