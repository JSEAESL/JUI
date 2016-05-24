/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.utils
{
	
	public interface ModelSetting
	{
		
		function getModelName():String;
		function getModelFile():String;
		function getTextureNum():int;
		function getTextureFile(n:int):String;
		
		function getHitAreaNum():int;
		function getHitAreaID(n:int):String;
		function getHitAreaName(n:int):String;
		
		function getPhysicsFile():String;
		function getPoseFile():String;
		
		function getExpressionNum():int;
		function getExpressionName(n:int):String;
		function getExpressionFile(n:int):String;
		
		function getMotionNum(name:String):int;
		function getMotionFile(name:String, n:int):String;
		function getMotionSound(name:String, n:int):String;
		function getMotionFadeIn(name:String, n:int):int;
		function getMotionFadeOut(name:String, n:int):int;
		
		function getLayout():Object;
		
		function getInitParamNum():int;
		function getInitParamID(n:int):String;
		function getInitParamValue(n:int):Number;
		
		function getInitPartsVisibleNum():int;
		function getInitPartsVisibleID(n:int):String;
		function getInitPartsVisibleValue(n:int):Number;
	}
}