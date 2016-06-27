/**
 * Created by JiangHaiYang on 2016/6/16.
 */
package MornLib {

    import JLib.BaseRes.JBaseResManager;
    import JLib.BaseRes.JResXmlCache;

    import flash.display.Sprite;

    import flash.display.Stage;
    import flash.utils.Dictionary;

    import morn.core.handlers.Handler;

    import picCreatR.PicCreatCore;

    public class MornInit {
        public function MornInit()
        {
        }

        public static function init(org:Sprite):void
        {
            trace("!!!!!!!!MornInit!!!!!!!!!!");
            App.init(org);
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


        private var loadedDic:Dictionary;
        public function loadSwf(swf:String,complete:Function):void
        {
            if(!loadedDic[swf])
            {
                App.loader.loadAssets([swf],
                        new Handler(complete));
            }
            else
            {
                complete.apply();
            }
        }

        public function saveDic(url:String):void
        {
            loadedDic[url] = url;
        }

        private static function loadComplete(e:* = null):void
        {
            trace("loadComplete " + e);
            FontInit.init();
            PicCreatCore.creatCore();
        }

        private static function progressFun(e:* = null):void
        {
            //trace("progressFun");
        }
    }
}
