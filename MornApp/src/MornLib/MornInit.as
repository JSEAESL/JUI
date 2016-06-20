/**
 * Created by JiangHaiYang on 2016/6/16.
 */
package MornLib {

    import JLib.BaseRes.JBaseResManager;
    import JLib.BaseRes.JResXmlCache;

    import morn.core.handlers.Handler;

    public class MornInit {
        public function MornInit()
        {
        }

        public static function init():void
        {
            JBaseResManager.getInstance().firstLoad(next);
        }

        private static function next():void
        {
            var ob:Object = JResXmlCache.Instance.getConfigBykey("MornUI");
            var loadUrlList:Array = [];
            for each(var i:Object in ob.res)
            {
                trace("next: " + String(i.url));
                loadUrlList.push(String(i.url));
            }
            App.loader.loadAssets(loadUrlList,
                    new Handler(loadComplete),
                    new Handler(progressFun));
        }

        private static function loadComplete(e:* = null):void
        {
        }

        private static function progressFun(e:* = null):void
        {
        }
    }
}
