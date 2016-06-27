package core.facade {
    import core.facade.command.HallUpCommand;
    import core.mvc.BaseFacade;

    import flash.display.Sprite;

    public class HallFacade extends BaseFacade {
        public static const HALL_FACADE:String = "hall_facade";
        public static const HALL_START_UP:String = "hall_start_up";

        public static const HALL_END:String = "HALL_END";

        public static const HALL_BACK_PACK:String = "hall_back_pack";
        public static const HALL_SELECT_MAP:String = "hall_select_map";
        public static const HALL_EQUIP_GROW:String = "hall_equip_grow";
        public static const ROLE_INFO_PANEL:String = "role_info_panel";
        public static const TASK_START_UP:String = "task_start_up";

        public function HallFacade(key:String) {
            super(key);
        }

        public static function getInstance(key:String = HALL_FACADE):HallFacade {
            if (instanceMap[key] == null) {
                instanceMap[key] = new HallFacade(key);
            }
            return instanceMap[key];
        }

        override protected function initializeController():void {
            super.initializeController();
            registerCommand(HALL_START_UP, HallUpCommand);

        }

        public function startup(gameView:Sprite):void {
            sendNotification(HALL_START_UP, gameView, HALL_START_UP);
        }
    }
}