/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package utils
{
	/*
	 * 外部データをバイナリとして埋め込んで、擬似的にフォルダパスからファイルを読み込んだように見せかけています。
	 * URLLoaderなどを使って普通に読み込むこともできます。
	 * その場合は非同期読み込みなことと、フォルダやURLへのアクセス権限に注意します。
	 */
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import jp.live2d.util.UtSystem;
	
	public class FileManager
	{
		private static const DEBUG_LOG:Boolean = false; // 読み込みファイルのログを出すかどうか
		
//*** auto generated ***		
[Embed(source='../../assets/image/back_class_normal.png')]
private static var image_back_class_normal_png:Class;
[Embed(source='../../assets/live2d/haru/expressions/f01.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f01_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f02.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f02_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f03.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f03_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f04.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f04_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f05.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f05_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f06.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f06_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f07.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f07_exp_json:Class;
[Embed(source='../../assets/live2d/haru/expressions/f08.exp.json',mimeType='application/octet-stream')]
private static var live2d_haru_expressions_f08_exp_json:Class;
[Embed(source='../../assets/live2d/haru/haru.model.json',mimeType='application/octet-stream')]
private static var live2d_haru_haru_model_json:Class;
[Embed(source='../../assets/live2d/haru/haru.physics.json',mimeType='application/octet-stream')]
private static var live2d_haru_haru_physics_json:Class;
[Embed(source='../../assets/live2d/haru/haru.pose.json',mimeType='application/octet-stream')]
private static var live2d_haru_haru_pose_json:Class;
[Embed(source='../../assets/live2d/haru/haru_01.1024/texture_00.png')]
private static var live2d_haru_haru_01_1024_texture_00_png:Class;
[Embed(source='../../assets/live2d/haru/haru_01.1024/texture_01.png')]
private static var live2d_haru_haru_01_1024_texture_01_png:Class;
[Embed(source='../../assets/live2d/haru/haru_01.1024/texture_02.png')]
private static var live2d_haru_haru_01_1024_texture_02_png:Class;
[Embed(source='../../assets/live2d/haru/haru_01.moc',mimeType='application/octet-stream')]
private static var live2d_haru_haru_01_moc:Class;
[Embed(source='../../assets/live2d/haru/haru_01.model.json',mimeType='application/octet-stream')]
private static var live2d_haru_haru_01_model_json:Class;
[Embed(source='../../assets/live2d/haru/haru_02.1024/texture_00.png')]
private static var live2d_haru_haru_02_1024_texture_00_png:Class;
[Embed(source='../../assets/live2d/haru/haru_02.1024/texture_01.png')]
private static var live2d_haru_haru_02_1024_texture_01_png:Class;
[Embed(source='../../assets/live2d/haru/haru_02.1024/texture_02.png')]
private static var live2d_haru_haru_02_1024_texture_02_png:Class;
[Embed(source='../../assets/live2d/haru/haru_02.moc',mimeType='application/octet-stream')]
private static var live2d_haru_haru_02_moc:Class;
[Embed(source='../../assets/live2d/haru/haru_02.model.json',mimeType='application/octet-stream')]
private static var live2d_haru_haru_02_model_json:Class;
[Embed(source='../../assets/live2d/haru/motions/flickHead_00.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_flickHead_00_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/idle_00.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_idle_00_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/idle_01.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_idle_01_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/idle_02.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_idle_02_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/pinchIn_00.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_pinchIn_00_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/pinchOut_00.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_pinchOut_00_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/shake_00.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_shake_00_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_00.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_00_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_01.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_01_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_02.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_02_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_03.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_03_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_04.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_04_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_05.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_05_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_06.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_06_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_07.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_07_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_08.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_08_mtn:Class;
[Embed(source='../../assets/live2d/haru/motions/tapBody_09.mtn',mimeType='application/octet-stream')]
private static var live2d_haru_motions_tapBody_09_mtn:Class;
[Embed(source='../../assets/live2d/haru/sounds/flickHead_00.mp3')]
private static var live2d_haru_sounds_flickHead_00_mp3:Class;
[Embed(source='../../assets/live2d/haru/sounds/pinchIn_00.mp3')]
private static var live2d_haru_sounds_pinchIn_00_mp3:Class;
[Embed(source='../../assets/live2d/haru/sounds/pinchOut_00.mp3')]
private static var live2d_haru_sounds_pinchOut_00_mp3:Class;
[Embed(source='../../assets/live2d/haru/sounds/shake_00.mp3')]
private static var live2d_haru_sounds_shake_00_mp3:Class;
[Embed(source='../../assets/live2d/haru/sounds/tapBody_00.mp3')]
private static var live2d_haru_sounds_tapBody_00_mp3:Class;
[Embed(source='../../assets/live2d/haru/sounds/tapBody_01.mp3')]
private static var live2d_haru_sounds_tapBody_01_mp3:Class;
[Embed(source='../../assets/live2d/haru/sounds/tapBody_02.mp3')]
private static var live2d_haru_sounds_tapBody_02_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/expressions/f01.exp.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_expressions_f01_exp_json:Class;
[Embed(source='../../assets/live2d/shizuku/expressions/f02.exp.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_expressions_f02_exp_json:Class;
[Embed(source='../../assets/live2d/shizuku/expressions/f03.exp.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_expressions_f03_exp_json:Class;
[Embed(source='../../assets/live2d/shizuku/expressions/f04.exp.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_expressions_f04_exp_json:Class;
[Embed(source='../../assets/live2d/shizuku/motions/flickHead_00.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_flickHead_00_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/flickHead_01.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_flickHead_01_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/flickHead_02.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_flickHead_02_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/idle_00.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_idle_00_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/idle_01.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_idle_01_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/idle_02.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_idle_02_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/pinchIn_00.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_pinchIn_00_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/pinchIn_01.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_pinchIn_01_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/pinchIn_02.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_pinchIn_02_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/pinchOut_00.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_pinchOut_00_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/pinchOut_01.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_pinchOut_01_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/pinchOut_02.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_pinchOut_02_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/shake_00.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_shake_00_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/shake_01.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_shake_01_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/shake_02.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_shake_02_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/tapBody_00.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_tapBody_00_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/tapBody_01.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_tapBody_01_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/motions/tapBody_02.mtn',mimeType='application/octet-stream')]
private static var live2d_shizuku_motions_tapBody_02_mtn:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.1024/texture_00.png')]
private static var live2d_shizuku_shizuku_1024_texture_00_png:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.1024/texture_01.png')]
private static var live2d_shizuku_shizuku_1024_texture_01_png:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.1024/texture_02.png')]
private static var live2d_shizuku_shizuku_1024_texture_02_png:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.1024/texture_03.png')]
private static var live2d_shizuku_shizuku_1024_texture_03_png:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.1024/texture_04.png')]
private static var live2d_shizuku_shizuku_1024_texture_04_png:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.1024/texture_05.png')]
private static var live2d_shizuku_shizuku_1024_texture_05_png:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.moc',mimeType='application/octet-stream')]
private static var live2d_shizuku_shizuku_moc:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.model.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_shizuku_model_json:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.physics.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_shizuku_physics_json:Class;
[Embed(source='../../assets/live2d/shizuku/shizuku.pose.json',mimeType='application/octet-stream')]
private static var live2d_shizuku_shizuku_pose_json:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/flickHead_00.mp3')]
private static var live2d_shizuku_sounds_flickHead_00_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/flickHead_01.mp3')]
private static var live2d_shizuku_sounds_flickHead_01_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/flickHead_02.mp3')]
private static var live2d_shizuku_sounds_flickHead_02_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/pinchIn_00.mp3')]
private static var live2d_shizuku_sounds_pinchIn_00_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/pinchIn_01.mp3')]
private static var live2d_shizuku_sounds_pinchIn_01_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/pinchIn_02.mp3')]
private static var live2d_shizuku_sounds_pinchIn_02_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/pinchOut_00.mp3')]
private static var live2d_shizuku_sounds_pinchOut_00_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/pinchOut_01.mp3')]
private static var live2d_shizuku_sounds_pinchOut_01_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/pinchOut_02.mp3')]
private static var live2d_shizuku_sounds_pinchOut_02_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/shake_00.mp3')]
private static var live2d_shizuku_sounds_shake_00_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/shake_01.mp3')]
private static var live2d_shizuku_sounds_shake_01_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/shake_02.mp3')]
private static var live2d_shizuku_sounds_shake_02_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/tapBody_00.mp3')]
private static var live2d_shizuku_sounds_tapBody_00_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/tapBody_01.mp3')]
private static var live2d_shizuku_sounds_tapBody_01_mp3:Class;
[Embed(source='../../assets/live2d/shizuku/sounds/tapBody_02.mp3')]
private static var live2d_shizuku_sounds_tapBody_02_mp3:Class;
[Embed(source='../../assets/live2d/wanko/motions/idle_01.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_idle_01_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/idle_02.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_idle_02_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/idle_03.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_idle_03_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/idle_04.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_idle_04_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/shake_01.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_shake_01_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/shake_02.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_shake_02_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/touch_01.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_touch_01_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/touch_02.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_touch_02_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/touch_03.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_touch_03_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/touch_04.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_touch_04_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/touch_05.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_touch_05_mtn:Class;
[Embed(source='../../assets/live2d/wanko/motions/touch_06.mtn',mimeType='application/octet-stream')]
private static var live2d_wanko_motions_touch_06_mtn:Class;
[Embed(source='../../assets/live2d/wanko/wanko.1024/texture_00.png')]
private static var live2d_wanko_wanko_1024_texture_00_png:Class;
[Embed(source='../../assets/live2d/wanko/wanko.moc',mimeType='application/octet-stream')]
private static var live2d_wanko_wanko_moc:Class;
[Embed(source='../../assets/live2d/wanko/wanko.model.json',mimeType='application/octet-stream')]
private static var live2d_wanko_wanko_model_json:Class;

		
		
		/*
		 * プロジェクトフォルダにあるassetsフォルダ以下のファイルをあらかじめ埋め込んでおく。
		 * パスは以下のように変化する。
		 * (プロジェクトフォルダ)/assets/live2d/model/haru.moc
		 * ↓
		 * live2d/model/haru.moc
		 *
		 * @param	path
		 * @return
		 */
		public static function openEmbedFile(path:String):Object
		{
			if (DEBUG_LOG)
				trace("load : " + path);
			var file:String = path.replace(/\//g, "_").replace(/\./g, "_"); //ex. image/image1.png -> image_image1_png
			// var fileClass:Object = getClassRef("jp.cybernoids.utils::FileManager_" + file);//FlashDevelopでしか使えない
			var fileClass:Object = FileManager[file];
			return new fileClass;
		}
		
		
		/*
		 * クラス名を取得
		 * 例えばjp.xxx.SampleクラスでEmbedしたDataクラスは
		 * jp.xxx::Sample_Data
		 * のようになります。
		 * @param	o
		 * @return
		 */
		static private function getQClassName(o:*):String
		{
			
			return getQualifiedClassName(o);
		}
		
		
		/*
		 * クラス名から参照を取得
		 * @param	classname
		 * @return
		 */
		static private function getClassRef(classname:String):Object
		{
			
			return getDefinitionByName(classname);
		}
	}
}
