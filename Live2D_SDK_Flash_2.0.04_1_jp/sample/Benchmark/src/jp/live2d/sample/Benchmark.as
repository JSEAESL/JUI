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
	import flash.text.TextField;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;
	import jp.live2d.Live2D;
	import jp.live2d.Live2DModelAs3;
	import jp.live2d.motion.Live2DMotion;
	import jp.live2d.motion.MotionQueueManager;
	import jp.live2d.util.UtSystem;
	
	[SWF(width="1024", height="1024", backgroundColor="0xFFFFFF", frameRate="60")]
	public class Benchmark extends Sprite
	{
		//Number of Live2D Model
		private const NUM_MODEL:int = 10;

		public var context3D:Context3D;
		public var models:Vector.<Live2DModelAs3>=new Vector.<Live2DModelAs3>;
		
		[Embed(source = '../../../../assets/haru/haru.moc', mimeType = 'application/octet-stream')] private var ModelData:Class;
		[Embed(source = '../../../../assets/haru/haru.1024/texture_00.png')] private var Texture_00:Class;
		[Embed(source = '../../../../assets/haru/haru.1024/texture_01.png')] private var Texture_01:Class;
		[Embed(source = '../../../../assets/haru/haru.1024/texture_02.png')] private var Texture_02:Class;
		
		[Embed(source='../../../../assets/haru/haru_idle_01.mtn',mimeType='application/octet-stream')]
		private var MotionData:Class;
		private var motionMgr:MotionQueueManager = new MotionQueueManager;
		private var motion:Live2DMotion;
		
		public function Benchmark():void
		{
			Live2D.init();
			var stage3D:Stage3D = stage.stage3Ds[0];
			
			
			// 3Dレイヤーの準備
			stage3D.addEventListener(Event.CONTEXT3D_CREATE, onCreateStage3D, false, 1);
			stage3D.requestContext3D(Context3DRenderMode.AUTO);
			
		}
		
		public function createModel():Live2DModelAs3 
		{
			var live2DModel:Live2DModelAs3 = Live2DModelAs3.loadModel( ByteArray(new ModelData) );
			
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
			live2DModel.x = -1+(Math.random()-0.5); // スクリーン上の左上とモデルの左上を合わせる
			live2DModel.y = 1;
			
			return live2DModel;
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
			
			for (var i:int = 0; i < NUM_MODEL; i++) 
			{
				models.push(createModel());
			}
			
			motion = Live2DMotion.loadMotion(String(new MotionData));
			
			
			var text_field:TextField = new TextField();
			text_field.background = true;
			text_field.width = stage.stageWidth;
			text_field.height = 18;
			stage.addChild (text_field);

			var update_time:int = 1000;      
			var draw_count:int = 0;         
			var old_timer:int = getTimer(); 


			stage.addEventListener(Event.ENTER_FRAME ,function ():void{
				draw_count += 1;
				if (getTimer()-old_timer >= update_time) {
					var fps:Number = draw_count * 1000 / (getTimer() - old_timer);
					fps = Math.floor(fps * 10) / 10;  

					text_field.text ="Model : "+NUM_MODEL+"  FPS "+ fps + " / " + stage.frameRate;
					old_timer = getTimer();
					draw_count = 0;
				}
				
				update();
			});
		}
		
		
		public function update():void
		{
			context3D.clear(1, 1, 1, 0); // 画面のクリア
			
			if (motionMgr.isFinished()) 
			{
				motionMgr.startMotion(motion);
			}
			
			var n:int = models.length;
			for (var i:int = 0; i < n; i++) 
			{
				var live2DModel:Live2DModelAs3 = models[i];
				motionMgr.updateParam(live2DModel);
				
				//live2DModel.setParamFloat("PARAM_ANGLE_X", Math.random() * 30);
				live2DModel.update(); // モデルパラメータの更新
				live2DModel.draw(); // モデル描画
			}
			context3D.present(); // 描画を適用
		}
	}
}