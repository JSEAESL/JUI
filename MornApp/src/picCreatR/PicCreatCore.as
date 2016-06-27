/**
 * Created by JiangHaiYang on 2016/7/11.
 */
package picCreatR {
    import core.StageManager;

    import flash.desktop.ClipboardFormats;
    import flash.desktop.NativeDragManager;
    import flash.display.InteractiveObject;

    import flash.events.NativeDragEvent;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;

    public class PicCreatCore {
        public function PicCreatCore()
        {
            init();
        }

        public static function creatCore():PicCreatCore
        {
            var result:PicCreatCore = new PicCreatCore();
            return result;
        }

        private var m_view:PicCreatView;
        private function init():void
        {
            m_view = new PicCreatView();
            StageManager.getInstance().addLayer(m_view);
            DragManager.Instance.creatDrawMC(m_view.dragImage,CheckDrag,DragEnd);
            PicCon.Instance.setPar(m_view.picBox);
        }


        private function CheckDrag(e:NativeDragEvent):void
        {
            var arr:Array = e.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
            var SuffixStr:String = JStrUnti.getUrlSuffixStr(arr[0].name);
            if(		SuffixStr== "jpg"
                    ||SuffixStr== "png"
            /*||SuffixStr== "dec"*/)
            {
                NativeDragManager.acceptDragDrop(e.currentTarget as InteractiveObject);
            }

        }

        private function DragEnd(e:NativeDragEvent):void
        {
            var airData:Object=e.clipboard.formats;
            for each(var type:String in airData) {
                if (type != "air:url") {
                    var airObjects:Array = e.clipboard.getData(type) as Array;//获取剪切板中的数据
                    var inFile:File = airObjects[0] as File;//获取剪切板中的文件
                    var fileInStream:FileStream = new FileStream();//文件流
                    var contentArray:ByteArray = new ByteArray();
                    fileInStream.open(inFile, FileMode.READ);
                    fileInStream.readBytes(contentArray);//读取字节保存到contentArray
                    fileInStream.close();
                    PicManage.Instance.addPic(contentArray);
                }
            }
        }


    }
}
