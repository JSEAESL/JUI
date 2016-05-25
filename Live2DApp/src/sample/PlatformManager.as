package sample
{
	import flash.display.Bitmap;

	import framework.IPlatformManager;

	import jp.live2d.ALive2DModel;
	import flash.utils.ByteArray;
	import jp.live2d.Live2DModelAs3;

	import utils.FileManager;

	/**
	 * ...
	 * @author aso
	 */
	public class PlatformManager implements IPlatformManager
	{
		
		/* INTERFACE jp.live2d.framework.IPlatformManager */
		
		public function loadBytes(path:String):ByteArray 
		{
			var data:Object = FileManager.openEmbedFile(path);
			return ByteArray(data);
		}
		
		public function loadString(path:String):String 
		{
			var data:Object = FileManager.openEmbedFile(path);
			return String(data);
		}
		
		public function log(txt:String):void 
		{
			trace(txt);
		}
		
		public function loadTexture(model:ALive2DModel, no:int, path:String):void 
		{
			var data:Object = FileManager.openEmbedFile(path);
			Live2DModelAs3(model).setTexture(no, Bitmap(data).bitmapData, true); // 3D用のテクスチャを作成したら、BitmapDataのリソースを自動で削除する。
			
			
		}
		
		/* INTERFACE jp.live2d.framework.IPlatformManager */
		
		public function loadLive2DModel(path:String):ALive2DModel 
		{
			var model:ALive2DModel = Live2DModelAs3.loadModel(loadBytes(path));
			return model;
		}
		
	}

}