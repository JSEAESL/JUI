/**
 * Created by JiangHaiYang on 2016/6/28.
 */
package MornLib {
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Point;
    import flash.ui.Mouse;
    import flash.ui.MouseCursorData;

    public class MouseInit {
        public function MouseInit() {
        }
        [Embed(source="../../bin/assets/Mouse.png")]
        private static var mouseRes:Class;
        [Embed(source="../../bin/assets/Mouse2.png")]
        private static var mouseRes2:Class;
        //[Embed(source = "../../bin/assets/bg.png")]
        //private var bg:Class;
        public static function init():void
        {
            var bg0:Bitmap = new mouseRes();
            var bg2:Bitmap = new mouseRes2();
            var cursorData:MouseCursorData = new MouseCursorData();
            cursorData.hotSpot = new Point(0,0);
            var bitmapDatas:Vector.<BitmapData> = new Vector.<BitmapData>(1, true);
            //addChild(new bg())
            bitmapDatas[0] = bg0.bitmapData;
            //bitmapDatas[1] = bg2.bitmapData;
            //bitmapDatas[2] = bg0.bitmapData;
            cursorData.data = bitmapDatas;
            cursorData.frameRate = 1;
            Mouse.registerCursor("ActMouse",cursorData);
            Mouse.cursor = "ActMouse"
        /*    var y:Array = quickSort(t);
            trace(y);*/
        }

        private static var t:Array = [56,156,76,13,4561,9456,48,135,84,15,48,661,89];
        public static function quickSort(array:Array):Array
        {
            sort(0, array.length);
            return array;
            function sort(prev:int, numsize:int){
                var nonius:int = prev;
                var j:int = numsize -1;
                var flag:int = array[prev];
                if ((numsize - prev) > 1) {
                    while(nonius < j){
                        for(; nonius < j; j--){
                            if (array[j] < flag) {
                                array[nonius++] = array[j];　//a[i] = a[j]; i += 1;
                                break;
                            };
                        }
                        for( ; nonius < j; nonius++){
                            if (array[nonius] > flag){
                                array[j--] = array[nonius];
                                break;
                            }
                        }
                    }
                    array[nonius] = flag;
                    sort(0, nonius);
                    sort(nonius + 1, numsize);
                }
            }
        }
    }
}
