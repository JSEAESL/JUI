/**
 * Created by JiangHaiYang on 2016/6/28.
 */
package MornLib {
    import flash.system.ApplicationDomain;
    import flash.text.Font;

    public class FontInit {
        public function FontInit() {
        }

        //[Embed(source="../resources/simhei.ttf", fontName="myFont", embedAsCFF="false", mimeType="application/x-font")]
        //private static var Cls:Class;
        //[Embed(source="../resources/simhei.ttf", fontName="myFont_BD", embedAsCFF="false", mimeType="application/x-font")]
        //private static var ClsBd:Class;
        public static function init():void
        {
            var fontClass :Class = ApplicationDomain.currentDomain.getDefinition("myFont") as Class;
            var fontClassBD :Class = ApplicationDomain.currentDomain.getDefinition("myFontUI") as Class;
            Font.registerFont(fontClass);
            Font.registerFont(fontClassBD);
            trace("initFont ");
            var fontlist:Array = Font.enumerateFonts();
            trace("initFont ");
            //Font.registerFont(ClsBd);
        }
    }
}
