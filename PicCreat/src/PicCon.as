/**
 * Created by JiangHaiYang on 2016/5/23.
 */
package {
    import flash.display.DisplayObjectContainer;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.utils.ByteArray;

    public class PicCon extends Sprite {
        public function PicCon() {
            super();
        }

        private static var _Ins:PicCon;

        public static function get Instance():PicCon
        {
            if(null == _Ins)
            {
                _Ins = new PicCon();
                _Ins.init();
            }
            return _Ins;
        }

        private function init():void
        {
            miniPicList = [];
        }


        public function updata():void
        {
            cleanPic();
            var data:Array = PicManage.Instance.getPicData();
            var len:int = data.length;
            trace("addMiniPic len" + len);
            for(var i:int = 0;i<len; i++)
            {
                addMiniPic(data[i],i);
            }
        }

        public function addMiniPic(mapData:ByteArray,index:int):void
        {
            addChildMiniPic( MiniPic.creatPic(mapData,index) );
        }

        private var miniPicList:Array;

        private var MaxX:int = 4;

        public function setMaxX(_MaxX:int):void
        {
            MaxX = _MaxX;
            removePic();
            updataList();
        }

        private function updataList():void
        {
            for each(var i:MiniPic in miniPicList)
            {
                var miniPic:MiniPic = i;
                var count:int = miniPic.index;
                var This:DisplayObjectContainer = this;
                var x:int = count%MaxX* miniPic.Width;
                var y:int = Math.floor(count/MaxX)* miniPic.Height;
                Child.addChild(This,miniPic,x,y);
            }
        }

        private function addChildMiniPic(miniPic:MiniPic):void
        {
            miniPic.addEventListener(Event.COMPLETE,AddPic);
        }
        private function AddPic(e:Event):void
        {
            var miniPic:MiniPic = e.currentTarget as MiniPic;
            var count:int = miniPic.index;
            var This:DisplayObjectContainer = this;
            var x:int = count%MaxX* miniPic.Width;
            var y:int = Math.floor(count/MaxX)* miniPic.Height;
            Child.addChild(This,miniPic,x,y);
            miniPic.removeEventListener(Event.COMPLETE,AddPic);
            miniPicList.push(miniPic);
        }

        private function removePic():void
        {
            for (var i:int = 0;i<miniPicList.length;i++)
            {
                Child.removeChild(miniPicList[i]);
            }
        }

        private function cleanPic():void
        {
            while(miniPicList.length)
            {
                Child.removeChild(miniPicList.pop());
            }
            miniPicList = [];
        }


    }
}
