package
{
    import flash.desktop.ClipboardFormats;
    import flash.desktop.NativeDragManager;
    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    import flash.events.NativeDragEvent;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.text.TextField;
    import flash.utils.ByteArray;

    [SWF(backgroundColor="#666666", frameRate="60", width="840", height="640")]

    public class PicCreat extends Sprite
    {
        public function PicCreat()
        {
            var textField:TextField = new TextField();
            textField.text = "Hello, World";
            addChild(textField);
            init()
        }

        private function init():void
        {
            var MC:Sprite = Draw.creatRoundRect(0,0,200,200,5,5,0xff00ff);
            Child.addChild(stage,MC,this.stage.stageWidth - MC.width,this.stage.stageHeight - MC.height);

            Child.addChild(stage,PicCon.Instance,100,100);

            DragManager.Instance.creatDrawMC(MC,CheckDrag,DragEnd)
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
