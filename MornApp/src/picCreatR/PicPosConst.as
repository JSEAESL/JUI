/**
 * Created by JiangHaiYang on 2016/7/11.
 */
package picCreatR {
    public class PicPosConst {
        public function PicPosConst() {
        }

        public static var maxW:int = 0;
        public static var maxH:int = 0;
        public static var Wcount:int = 4;

        public static var BgW:int = 600;
        public static var BgH:int = 600;

        public static var sc:Number = 0.8;
        public static function creatMaxH(max:int):int
        {
            maxH = maxH>max?maxH:max;
            return maxH;
        }

        public static function checkMaxW(maxW_:int):void
        {
            if( maxW_ *sc*Wcount>BgW)
            {
                sc = sc*sc;
                checkMaxW(maxW_*sc);
            }/*else
            {
                maxW = maxW_;
                maxH = maxH*sc;
            }*/
        }

        public static function creatMaxW(max:int):int
        {
            maxW = maxW>max?maxW:max;
            checkMaxW(maxW);
            return maxW;
        }
    }
}
