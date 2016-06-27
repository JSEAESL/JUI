package core.facade {
    import core.facade.command.CommonDlgCommand;
    import core.facade.command.UiUpCommand;
    import core.mvc.BaseFacade;

    import flash.display.Sprite;

    public class UiFacade extends BaseFacade {
        public static const UI_FACADE:String = "ui_facade";

        public static const CLIENT_TEST:String = "client_test";

        public static const UI_START_UP:String = "ui_start_up";

        public static const LOGIN_START_UP:String = "login_start_up";

        public static const COMMON_DLG_UP:String = "common_dlg_up";

        public static const SKILL_SOUL_DLG_UP:String = "skill_soul_dlg_up";


        public static const APP_TO_UI_MESS:String = "app_to_ui_mess";
        public static const ENTER_HALL_MESS:String = "enter_hall_mess";

        public static const ONOFF_COMMAND_LINE:String = "open_command_line";
        public static const TALK_WINDOW:String = "talk_window";
        public static const CREATE_HERO_SCENE:String = "create_hero_scene";
        public static const ROLE_CLICK_PANEL:String = "role_click_panel_";

        public function UiFacade(key:String) {
            super(key);
        }

        public static function getInstance(key:String = UI_FACADE):UiFacade {
            if (instanceMap[key] == null) {
                instanceMap[key] = new UiFacade(key);
            }
            return instanceMap[key]
        }

        override protected function initializeController():void {
            super.initializeController();
            registerCommand(CLIENT_TEST, UiUpCommand);
        }

        public function startup(gameView:Sprite, proFun:Function = null):void {
            sendNotification(UI_START_UP, [gameView, proFun]);
            sendNotification(COMMON_DLG_UP, null, COMMON_DLG_UP);
            sendNotification(SKILL_SOUL_DLG_UP, null, SKILL_SOUL_DLG_UP);

        }

        public function TEST_CLIENT():void {
            sendNotification(CLIENT_TEST);
        }
    }
}