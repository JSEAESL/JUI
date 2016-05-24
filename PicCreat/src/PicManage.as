/**
 * Created by JiangHaiYang on 2016/5/23.
 */
package {
    import flash.utils.ByteArray;

    public class PicManage {
        private static var _Ins:PicManage;
        public static function get Instance():PicManage
        {
            if(null == _Ins)
            {
                _Ins = new PicManage();
            }
            return _Ins;
        }

        public function PicManage()
        {
            byteList = [];
        }

        private var byteList:Array;
        public function addPic(data:ByteArray):void
        {
            if(-1 == byteList.indexOf(data))
            {
                byteList.push(data);
                PicCon.Instance.updata()
            }
        }

        public function getPicData():Array
        {
            return byteList;
        }

    }
}
