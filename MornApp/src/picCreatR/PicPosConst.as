/**
 * Created by JiangHaiYang on 2016/7/11.
 */
package picCreatR {
    public class PicPosConst {
        public function PicPosConst() {
        }

        public static var maxW:int = 0;
        public static var maxH:int = 0;

        public static function creatMaxW(max:int):int
        {
            maxW = maxW>max?maxW:max;
            return maxW;
        }

        public static function creatMaxH(max:int):int
        {
            maxH = maxH>max?maxH:max;
            return maxH;
        }
    }
}
