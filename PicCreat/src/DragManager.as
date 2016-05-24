/**
 * Created by JiangHaiYang on 2016/5/23.
 */
package {
    import flash.display.DisplayObject;
    import flash.events.NativeDragEvent;
    import flash.utils.Dictionary;

    public class DragManager {
        private static var _Ins:DragManager;
        public static function get Instance():DragManager
        {
            if(null == _Ins)
            {
                _Ins = new DragManager();
            }
            return _Ins;
        }
        public function DragManager()
        {
            creatMC = new Dictionary();
        }

        private var creatMC:Dictionary;
        public function creatDrawMC(mc:DisplayObject,onDragEnter:Function = null,onDragDrop:Function = null):void
        {
            if(!creatMC[mc])
            {
                if(onDragEnter)
                {
                    mc.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER,onDragEnter);//通常做拖入文件的类型检查
                }

                if(onDragDrop)
                {
                    mc.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP,onDragDrop);//拖拽完成事件
                }
                creatMC[mc] = {Fun1:onDragEnter,Fun2:onDragDrop};
            }
        }
    }
}
