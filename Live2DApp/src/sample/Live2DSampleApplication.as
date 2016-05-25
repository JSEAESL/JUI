package sample
{
    import flash.display.Bitmap;
    import flash.display.Sprite;
    import flash.display.Stage3D;
    import flash.display3D.Context3D;
    import flash.events.ContextMenuEvent;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.ContextMenu;
    import flash.ui.ContextMenuItem;

    import framework.L2DMatrix44;

    import framework.L2DViewMatrix;

    import utils.FileManager;

    import utils.MatrixStack;

    import utils.OffscreenImage;

    import utils.SimpleImage;

    [SWF(width="640", height="960", backgroundColor="0xFFFFFF", frameRate="30")]
    public class Live2DSampleApplication extends Sprite
    {
        private var stage3D:Stage3D;

        //  Live2Dの管理
        private var live2DMgr:LAppLive2DManager;

        private var bg:SimpleImage; // 背景の描画
        private var viewMatrix:L2DViewMatrix;
        private var projMatrix:L2DMatrix44;
        private var deviceToScreen:L2DMatrix44;

        private var drag:Boolean = false; // ドラッグ中かどうか

        private var lastMouseX:Number = 0;
        private var lastMouseY:Number = 0;


        public function Live2DSampleApplication()
        {

            if (LAppDefine.DEBUG_LOG)
            {
                trace("==============================================\n");
                trace("   Live2D Sample  \n");
                trace("==============================================\n");
            }
            live2DMgr = new LAppLive2DManager();

            stage3D = stage.stage3Ds[0];

            stage3D.addEventListener(Event.CONTEXT3D_CREATE, onCreateContext3D);
            stage3D.requestContext3D();

            // 右クリックメニューを追加
            var menu_item:ContextMenuItem = new ContextMenuItem("change model"); //  メニューアイテムを作成

            menu_item.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, changeModel);

            var menu_cm:ContextMenu = new ContextMenu();

            menu_cm.customItems = [menu_item]; //  カスタムメニューに登録

            //  スプライトにコンテキストメニューを登録
            contextMenu = menu_cm;
            //contextMenu.hideBuiltInItems();

        }


        /*
         * モデルを変更する
         * @param	e
         */
        private function changeModel(e:Event):void
        {
            live2DMgr.changeModel();
        }


        /*
         * 3Dレイヤが作成された時のイベント
         * @param	e
         */
        private function onCreateContext3D(e:Event):void
        {
            if (LAppDefine.DEBUG_LOG)
                trace("graphics driver :" + stage3D.context3D.driverInfo);

            // 3Dバッファの初期化
            var width:Number = stage.stageWidth;
            var height:Number = stage.stageHeight;

            stage3D.context3D.configureBackBuffer(width, height, 0, false);
            stage3D.context3D.setRenderToBackBuffer();

            if (LAppDefine.DEBUG_LOG)
                stage3D.context3D.enableErrorChecking = true; // エラーチェック

            // Live2D関連の初期化
            live2DMgr.changeModel();

            // 背景の作成
            setupBackground(stage3D.context3D);

            // ビュー行列
            var ratio:Number = height / width;
            var left:Number = LAppDefine.VIEW_LOGICAL_LEFT;
            var right:Number = LAppDefine.VIEW_LOGICAL_RIGHT;
            var bottom:Number = -ratio;
            var top:Number = ratio;

            viewMatrix = new L2DViewMatrix;

            viewMatrix.setScreenRect(left, right, bottom, top); // デバイスに対応する画面の範囲。 Xの左端, Xの右端, Yの下端, Yの上端
            viewMatrix.setMaxScreenRect(LAppDefine.VIEW_LOGICAL_MAX_LEFT, LAppDefine.VIEW_LOGICAL_MAX_RIGHT, LAppDefine.VIEW_LOGICAL_MAX_BOTTOM, LAppDefine.VIEW_LOGICAL_MAX_TOP); // デバイスに対応する画面の範囲。 Xの左端, Xの右端, Yの下端, Yの上端

            viewMatrix.setMaxScale(LAppDefine.VIEW_MAX_SCALE);
            viewMatrix.setMinScale(LAppDefine.VIEW_MIN_SCALE);

            projMatrix = new L2DMatrix44;
            projMatrix.multScale(1, (width / height));

            OffscreenImage.init(stage3D.context3D);

            // マウス用スクリーン変換行列
            deviceToScreen = new L2DMatrix44;
            deviceToScreen.multTranslate(-width / 2.0, -height / 2.0);
            deviceToScreen.multScale(2 / width, -2 / width);

            stage.addEventListener(MouseEvent.CLICK, onClick);
            stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
            stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
            stage.addEventListener(MouseEvent.MOUSE_WHEEL, onWheel);
            stage.addEventListener(Event.MOUSE_LEAVE, onLeave);

            addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }


        /*
         * マウスホイールによる拡大縮小
         * @param	e
         */
        private function onWheel(e:MouseEvent):void
        {
            if (e.stageX < 0 || stage.stageWidth < e.stageX || e.stageY < 0 || stage.stageHeight < e.stageY)
            {
                return;
            }
            var sx:Number = transformScreenX(e.stageX);
            var sy:Number = transformScreenY(e.stageY);
            var vx:Number = transformViewX(e.stageX);
            var vy:Number = transformViewY(e.stageY);

            if (LAppDefine.DEBUG_MOUSE_LOG)
                trace("onWheel device( x:" + e.stageX + " y:" + e.stageY + " ) screen( x:" + sx + " y:" + sy + ")" + " ) view( x:" + vx + " y:" + vy + ")");

            var isMaxScale:Boolean = viewMatrix.isMaxScale();
            var isMinScale:Boolean = viewMatrix.isMinScale();

            if (e.delta > 0)
            {
                // 上方向スクロール 拡大
                viewMatrix.adjustScale(sx, sy, 1.1);
            }
            else
            {
                // 下方向スクロール 縮小
                viewMatrix.adjustScale(sx, sy, 0.9);
            }

            // 画面が最大になったときのイベント
            if (!isMaxScale)
            {
                if (viewMatrix.isMaxScale())
                {
                    live2DMgr.maxScaleEvent();
                }
            }
            // 画面が最小になったときのイベント
            if (!isMinScale)
            {
                if (viewMatrix.isMinScale())
                {
                    live2DMgr.minScaleEvent();
                }
            }

        }


        /*
         * 毎フレームの更新
         * @param	e
         */
        private function onEnterFrame(e:Event):void
        {
            live2DMgr.update(stage3D.context3D);

            draw(stage3D.context3D);
        }


        /*
         * マウスを押した時のイベント
         * @param	e
         */
        private function onMouseDown(e:MouseEvent):void
        {
            drag = true;
            var sx:Number = transformScreenX(e.stageX);
            var sy:Number = transformScreenY(e.stageY);
            var vx:Number = transformViewX(e.stageX);
            var vy:Number = transformViewY(e.stageY);
            if (LAppDefine.DEBUG_MOUSE_LOG)
                trace("onMouseDown device( x:" + e.stageX + " y:" + e.stageY + " ) view( x:" + vx + " y:" + vy + ")");

            lastMouseX = sx;
            lastMouseY = sy;

            live2DMgr.setDrag(vx, vy); // その方向を向く
        }


        /*
         * マウスを動かした時のイベント
         * @param	e
         */
        private function onMouseMove(e:MouseEvent):void
        {
            var sx:Number = transformScreenX(e.stageX);
            var sy:Number = transformScreenY(e.stageY);
            var vx:Number = transformViewX(e.stageX);
            var vy:Number = transformViewY(e.stageY);
            if (LAppDefine.DEBUG_MOUSE_LOG)
                trace("onMouseMove device( x:" + e.stageX + " y:" + e.stageY + " ) view( x:" + vx + " y:" + vy + ")");

            if (drag)
            {
                // viewMatrix.adjustTranslate(sx - lastMouseX, sy - lastMouseY);//カメラを移動するとき
                lastMouseX = sx;
                lastMouseY = sy;

                live2DMgr.setDrag(vx, vy); // その方向を向く
            }
        }


        /*
         * マウスを離した時のイベント
         * @param	e
         */
        private function onMouseUp(e:MouseEvent):void
        {
            if (drag)
            {
                drag = false;
            }
            var x:Number = transformViewX(e.stageX);
            var y:Number = transformViewY(e.stageY);
            if (LAppDefine.DEBUG_MOUSE_LOG)
                trace("onMouseUp device( x:" + e.stageX + " y:" + e.stageY + " ) view( x:" + x + " y:" + y + ")");

            live2DMgr.setDrag(0, 0);
        }


        /*
         * マウスがステージから離れた時のイベント
         * @param	e
         */
        private function onLeave(e:Event):void
        {
            live2DMgr.setDrag(0, 0);
        }


        /*
         * クリック時のイベント
         * @param	e
         */
        private function onClick(e:MouseEvent):void
        {
            var sx:Number = transformScreenX(e.stageX);
            var sy:Number = transformScreenY(e.stageY);
            var vx:Number = transformViewX(e.stageX);
            var vy:Number = transformViewY(e.stageY);
            if (LAppDefine.DEBUG_MOUSE_LOG)
                trace("onClick device( x:" + e.stageX + " y:" + e.stageY + " ) screen( x:" + sx + " y:" + sy + ")" + " ) view( x:" + vx + " y:" + vy + ")");

            live2DMgr.tapEvent(vx, vy);
        }


        /*
         * 背景の設定
         * @param context
         */
        internal function setupBackground(context3D:Context3D):void
        {

            bg = new SimpleImage(context3D);
            var data:Object = FileManager.openEmbedFile(LAppDefine.BACK_IMAGE_NAME);
            bg.setImage(context3D, Bitmap(data).bitmapData);

            // 描画範囲。画面の最大表示範囲に合わせる
            bg.setDrawRect(LAppDefine.VIEW_LOGICAL_MAX_LEFT, LAppDefine.VIEW_LOGICAL_MAX_RIGHT, LAppDefine.VIEW_LOGICAL_MAX_BOTTOM, LAppDefine.VIEW_LOGICAL_MAX_TOP);

        }


        /*
         * 描画
         * @param	context3D
         */
        public function draw(context3D:Context3D):void
        {
            MatrixStack.reset();
            MatrixStack.loadIdentity();

            context3D.clear();

            MatrixStack.multMatrix(projMatrix.getArray());
            MatrixStack.multMatrix(viewMatrix.getArray());
            MatrixStack.push();
            {

                bg.setMatrixVector(MatrixStack.getMatrix());
                bg.drawImage(context3D);

                for (var i:int = 0; i < live2DMgr.numModels(); i++)
                {
                    var model:LAppModel = live2DMgr.getModel(i);
                    if (model.initialized && !model.updating)
                    {
                        model.update();
                        model.draw(context3D);
                    }
                }
            }
            MatrixStack.pop();

            context3D.present();
        }


        public function transformViewX(deviceX:Number):Number
        {
            var screenX:Number = deviceToScreen.transformX(deviceX); // 論理座標変換した座標を取得。
            return viewMatrix.invertTransformX(screenX); // 拡大、縮小、移動後の値。
        }


        public function transformViewY(deviceY:Number):Number
        {
            var screenY:Number = deviceToScreen.transformY(deviceY); // 論理座標変換した座標を取得。
            return viewMatrix.invertTransformY(screenY); // 拡大、縮小、移動後の値。
        }


        public function transformScreenX(deviceX:Number):Number
        {
            return deviceToScreen.transformX(deviceX);
        }


        public function transformScreenY(deviceY:Number):Number
        {
            return deviceToScreen.transformY(deviceY);
        }
    }
}
