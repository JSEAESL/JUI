/**
 *  Sample.as
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.sample
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage3D;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DRenderMode;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import jp.live2d.Live2D;
	import jp.live2d.Live2DModelAs3;
	import jp.live2d.util.UtSystem;
	
	[SWF(width="512", height="512", backgroundColor="0xFFFFFF", frameRate="30")]
	public class Simple extends Sprite
	{
		public var context3D:Context3D;
		
		public var live2DModel:Live2DModelAs3;
		
		[Embed(source = '../../../../assets/haru/haru.moc', mimeType = 'application/octet-stream')] private var ModelData:Class;
		[Embed(source = '../../../../assets/haru/haru.1024/texture_00.png')] private var Texture_00:Class;
		[Embed(source = '../../../../assets/haru/haru.1024/texture_01.png')] private var Texture_01:Class;
		[Embed(source = '../../../../assets/haru/haru.1024/texture_02.png')] private var Texture_02:Class;
		
		public function Simple():void
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
			context3D = (e.target as Stage3D).context3D;
			context3D.configureBackBuffer(stage.stageWidth, stage.stageHeight, 0, false);
			context3D.setRenderToBackBuffer();
			
			live2DModel = Live2DModelAs3.loadModel( ByteArray(new ModelData) );
			
			// グラフィックコンテキストをモデルに設定
			live2DModel.setGraphicsContext(context3D);
			
			// テクスチャの設定
			var tex00:Bitmap = new Texture_00;
			var tex01:Bitmap = new Texture_01;
			var tex02:Bitmap = new Texture_02;
			live2DModel.setTexture(0, tex00.bitmapData );
			live2DModel.setTexture(1, tex01.bitmapData );
			live2DModel.setTexture(2, tex02.bitmapData );
			
			
			// 表示位置の設定
			var scale:Number = 2 / live2DModel.getCanvasWidth(); // 横幅で合わせる
			live2DModel.scaleX = scale;
			live2DModel.scaleY = -scale;
			live2DModel.x = -1; // スクリーン上の左上とモデルの左上を合わせる
			live2DModel.y = 1;
			
			stage.addEventListener(Event.ENTER_FRAME, update);
		}
		
		
		public function update(e:Event):void
		{
			var t:Number = (UtSystem.getUserTimeMSec()/1000.0) * 2 * Math.PI  ;// 1秒ごとに2π(1周期)増える
			var cycle:Number=3.0;// パラメータが一周する時間(秒)
			var sin:Number=Math.sin( t/cycle );// -1から1の間を周期ごとに変化する
			live2DModel.setParamFloat( "PARAM_ANGLE_X" , (30 * sin) ) ;// PARAM_ANGLE_Xのパラメータが[cycle]秒ごとに-30から30まで変化する


			live2DModel.update(); // モデルパラメータの更新
			
			context3D.clear(1, 1, 1, 0); // 画面のクリア
			live2DModel.draw(); // モデル描画
			context3D.present(); // 描画を適用
		}
	}
}