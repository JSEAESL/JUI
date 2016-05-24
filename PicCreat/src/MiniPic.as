/**
 * Created by JiangHaiYang on 2016/5/23.
 */
package {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.display.LoaderInfo;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.HTTPStatusEvent;
    import flash.events.IOErrorEvent;
    import flash.geom.Matrix;
    import flash.system.LoaderContext;
    import flash.utils.ByteArray;

    public class MiniPic extends Sprite {
        public function MiniPic() {
            super();
        }

        public var index:int;
        public static function creatPic(mapData:ByteArray,_index:int):MiniPic
        {
            var result:MiniPic = new MiniPic();
            result.setData(mapData);
            result.index = _index;
            return result;
        }

        private var _loader:Loader = new Loader();
        public function setData(mapData:ByteArray):void
        {
            var LC:LoaderContext = new LoaderContext();
            _loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
            _loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
            _loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
            _loader.loadBytes(mapData,LC);
        }

        private var _loaderInfo:LoaderInfo;

        private function onComplete(e:Event):void
        {
            trace("onComplete");
            _loaderInfo = e.currentTarget as LoaderInfo;
            updataPic()
        }

        private var miniPic:Sprite;
        private var _miniMap:Bitmap;
        private var _souMap:Bitmap;

        private var _sou:BitmapData;
        private function updataPic():void
        {
            if(_loaderInfo.content)
            {
                _miniMap = _loaderInfo.content as Bitmap;
                creatMiniMap();
            }
        }

        private function creatMiniMap():void
        {
            if(!_miniMap)
            {
                return;
            }
            _sou = new BitmapData(Math.round(_miniMap.bitmapData.width / 10),	Math.round(_miniMap.bitmapData.height / 10),	false,	0x0);
            _sou.draw(_miniMap.bitmapData,new Matrix(1 / 10, 0, 0, 1 / 10, 0, 0));
            _souMap = new Bitmap(_sou);
            addChild(_souMap);
            _Height = _souMap.height;
            _Width = _souMap.width;
            dispatchEvent(new Event(Event.COMPLETE));
        }

        private function onError(e:IOErrorEvent):void
        {
            trace("Error")
        }

        private function onStatus(e:HTTPStatusEvent):void
        {
            trace("onStatus")
        }

        private var _Height:int = 0;
        private var _Width:int = 0;
        public function get Height():int
        {
            return _Height;
        }

        public function get Width():int
        {
            return _Width;
        }
    }
}
