package
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.InteractiveObject;
    import flash.display.Sprite;
    import flash.display.Stage3D;
    import flash.display3D.Context3D;
    import flash.display3D.Context3DRenderMode;
    import flash.events.ContextMenuEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;
    import flash.utils.ByteArray;

    import jp.live2d.Live2D;

    import jp.live2d.Live2DModelAs3;
    import jp.live2d.motion.Live2DMotion;
    import jp.live2d.motion.MotionQueueManager;

    [SWF(width="512", height="512", backgroundColor="0xFFFFFF", frameRate="30")]
    public class Live2DAppDesctopMascot extends Sprite
    {
        public var context3D:Context3D;

        public var live2DModel:Live2DModelAs3;
        public var motionMgr:MotionQueueManager;
        public var motions:Vector.<Live2DMotion>;
        public var offscreen:Bitmap;

        [Embed(source = '../assets/wanko/wanko.moc', mimeType = 'application/octet-stream')] private var ModelData:Class;
        [Embed(source = '../assets/wanko/wanko.1024/texture_00.png')] private var Texture_00:Class;

        public var textures:Array = [Texture_00];

        [Embed(source = '../assets/wanko/motions/idle_01.mtn', mimeType = 'application/octet-stream')] private var Motion_00:Class;
        [Embed(source = '../assets/wanko/motions/idle_02.mtn', mimeType = 'application/octet-stream')] private var Motion_01:Class;
        [Embed(source = '../assets/wanko/motions/idle_03.mtn', mimeType = 'application/octet-stream')] private var Motion_02:Class;
        [Embed(source = '../assets/wanko/motions/idle_04.mtn', mimeType = 'application/octet-stream')] private var Motion_03:Class;

        public var motionClass:Array = [Motion_00, Motion_01, Motion_02, Motion_03];

         public function Live2DAppDesctopMascot()
         {
             Live2D.init();
             var stage3D:Stage3D = stage.stage3Ds[0];

             // 3Dレイヤーの準備
             stage3D.addEventListener(Event.CONTEXT3D_CREATE, onCreateStage3D, false, 1);
             stage3D.requestContext3D(Context3DRenderMode.AUTO);
         }
        /*
         * 3Dレイヤーの準備完了時
         * @param	event
         */
        public function onCreateStage3D(e:Event):void
        {
            var stage3D:Stage3D = (e.target as Stage3D);
            context3D = stage3D.context3D;
            context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
            context3D.setRenderToBackBuffer();

            live2DModel = Live2DModelAs3.loadModel( ByteArray(new ModelData) );

            // グラフィックコンテキストをモデルに設定
            live2DModel.setGraphicsContext(context3D);

            // テクスチャの設定
            for (var i:int = 0; i < textures.length; i++)
            {
                var tex:Bitmap = new textures[i];
                live2DModel.setTexture(i, tex.bitmapData );
            }


            // 表示位置の設定
            var scale:Number = 2 / live2DModel.getCanvasWidth(); // 横幅で合わせる
            live2DModel.scaleX = scale;
            live2DModel.scaleY = -scale;
            live2DModel.x = -1; // スクリーン上の左上とモデルの左上を合わせる
            live2DModel.y = 1;

            motionMgr = new MotionQueueManager();
            motions = new Vector.<Live2DMotion>();

            for (i = 0; i < motionClass.length; i++)
            {
                var motion:Live2DMotion = Live2DMotion.loadMotion(String(new motionClass[i]));
                motions.push(motion);
            }

            var dragSprite:Sprite = new Sprite;

            offscreen = new Bitmap(new BitmapData(stage.stageWidth, stage.stageHeight, true, 0x00FFFFFF));
            dragSprite.addEventListener(MouseEvent.MOUSE_DOWN,function ():void
            {
                stage.nativeWindow.startMove();
            });
            addChild(dragSprite);
            dragSprite.addChild(offscreen);
            stage3D.visible = false;

            stage.nativeWindow.alwaysInFront = true;


            addMenu(this,"Exit",function ():void
            {
                stage.nativeWindow.close();
            });



            stage.addEventListener(Event.ENTER_FRAME, update);
        }

        public function update(e:Event):void
        {
            if (motionMgr.isFinished())
            {
                var idle:Live2DMotion = motions[int(Math.random()*motions.length)];
                motionMgr.startMotion(idle);
            }
            else
            {
                motionMgr.updateParam(live2DModel);
            }


            live2DModel.update(); // モデルパラメータの更新

            context3D.clear(0, 0, 0, 0); // 画面のクリア
            live2DModel.draw(); // モデル描画

            context3D.drawToBitmapData(offscreen.bitmapData);

            context3D.present(); // 描画を適用
        }

        /*
         * コンテストメニューに項目と実行関数を登録する
         */
        static public function addMenu(target:InteractiveObject,caption:String, func:Function=null,checked:Boolean=false):void {
            var menu_item:ContextMenuItem = new ContextMenuItem("");	// メニューアイテムを作成

            menu_item.caption = caption;		// キャプション名
            if(func!=null){
                menu_item.enabled = true;			// 有効か
                menu_item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, func);
            }else {
                menu_item.enabled = false;
            }
            menu_item.separatorBefore = false;		// １つ上にセパレータを付けるか
            menu_item.visible = true;			// 可視表示するか

            //ブラウザ版では使えない
            //menu_item.checked = checked;
            if (menu_item.hasOwnProperty("checked"))
            {
                menu_item["checked"] = checked;
            }

            if(target.contextMenu==null){
                var menu_cm:ContextMenu = new ContextMenu ();
                menu_cm.customItems = [menu_item];		// カスタムメニューに登録

                // スプライトにコンテキストメニューを登録
                target.contextMenu = menu_cm;

            }else {
                // Flashではtarget.contextMenuはContextMenu
                // Airではtarget.contextMenuはNativeMenu（ContextMenuのスーパークラス）

                //target.contextMenu.hideBuiltInItems();
                if (target.contextMenu is ContextMenu) {
                    if (ContextMenu(target.contextMenu).customItems==null)
                    {
                        ContextMenu(target.contextMenu).customItems = new Array();
                    }
                    ContextMenu(target.contextMenu).customItems.push(menu_item);
                }
            }
            //target.contextMenu.hideBuiltInItems();
        }
    }
}
