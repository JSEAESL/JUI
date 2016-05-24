/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework 
{
	import flash.utils.ByteArray;
	import jp.live2d.ALive2DModel;
	
	public interface IPlatformManager 
	{
		function loadBytes(path:String):ByteArray;
		function loadString(path:String):String;
		function log(txt:String):void ;
		function loadLive2DModel(path:String):ALive2DModel;
		function loadTexture(model:ALive2DModel, no:int, path:String):void ;
	}
	
}