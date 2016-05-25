/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package utils
{
	
	public class ModelSettingJson implements ModelSetting
	{
		private static var NAME:String = "name";
		private static var ID:String = "id";
		private static var MODEL:String = "model";
		private static var TEXTURES:String = "textures";
		private static var HIT_AREAS:String = "hit_areas";
		private static var PHYSICS:String = "physics";
		private static var POSE:String = "pose";
		private static var EXPRESSIONS:String = "expressions";
		private static var MOTION_GROUPS:String = "motions";
		private static var SOUND:String = "sound";
		private static var FADE_IN:String = "fade_in";
		private static var FADE_OUT:String = "fade_out";
		private static var LAYOUT:String = "layout";
		private static var INIT_PARAM:String = "init_param";
		private static var INIT_PARTS_VISIBLE:String = "init_parts_visible";
		private static var VALUE:String = "val";
		private static var FILE:String = "file";
		
		private var json:Object;
		
		
		public function ModelSettingJson(data:String)
		{
			json = JSON.parse(data);
		}
		
		
		public function getModelName():String
		{
			return json[NAME];
		}
		
		
		public function getModelFile():String
		{
			return json[MODEL];
		}
		
		
		public function getTextureNum():int
		{
			if (json[TEXTURES] == null)
				return 0;
			return json[TEXTURES].length;
		}
		
		
		public function getTextureFile(n:int):String
		{
			if (json[TEXTURES] == null || json[TEXTURES][n] == null)
				return null;
			return json[TEXTURES][n];
		}
		
		
		public function getHitAreaNum():int
		{
			if (json[HIT_AREAS] == null)
				return 0;
			return json[HIT_AREAS].length;
		}
		
		
		public function getHitAreaID(n:int):String
		{
			if (json[HIT_AREAS] == null || json[HIT_AREAS][n] == null)
				return null;
			return json[HIT_AREAS][n][ID];
		}
		
		
		public function getHitAreaName(n:int):String
		{
			if (json[HIT_AREAS] == null || json[HIT_AREAS][n] == null)
				return null;
			
			return json[HIT_AREAS][n][NAME];
		}
		
		
		public function getPhysicsFile():String
		{
			return json[PHYSICS];
		}
		
		
		public function getPoseFile():String
		{
			return json[POSE];
		}
		
		
		public function getExpressionNum():int
		{
			return (json[EXPRESSIONS] == null) ? 0 : json[EXPRESSIONS].length;
		}
		
		
		public function getExpressionFile(n:int):String
		{
			if (json[EXPRESSIONS] == null)
				return null;
			return json[EXPRESSIONS][n][FILE];
		}
		
		
		public function getExpressionName(n:int):String
		{
			if (json[EXPRESSIONS] == null)
				return null;
			return json[EXPRESSIONS][n][NAME];
		}
		
		
		public function getMotionNum(name:String):int
		{
			if (json[MOTION_GROUPS] == null || json[MOTION_GROUPS][name] == null)
				return 0;
			return json[MOTION_GROUPS][name].length;
		}
		
		
		public function getMotionFile(name:String, n:int):String
		{
			if (json[MOTION_GROUPS] == null || json[MOTION_GROUPS][name] == null || json[MOTION_GROUPS][name][n] == null)
				return null;
			return json[MOTION_GROUPS][name][n][FILE];
		}
		
		
		public function getMotionSound(name:String, n:int):String
		{
			if (json[MOTION_GROUPS] == null || json[MOTION_GROUPS][name] == null || json[MOTION_GROUPS][name][n] == null || json[MOTION_GROUPS][name][n][SOUND] == null)
				return null;
			
			return json[MOTION_GROUPS][name][n][SOUND];
		}
		
		
		public function getMotionFadeIn(name:String, n:int):int
		{
			if (json[MOTION_GROUPS] == null || json[MOTION_GROUPS][name] == null || json[MOTION_GROUPS][name][n] == null || json[MOTION_GROUPS][name][n][FADE_IN] == null)
				return 1000;
			
			return json[MOTION_GROUPS][name][n][FADE_IN];
		}
		
		
		public function getMotionFadeOut(name:String, n:int):int
		{
			if (json[MOTION_GROUPS] == null || json[MOTION_GROUPS][name] == null || json[MOTION_GROUPS][name][n] == null || json[MOTION_GROUPS][name][n][FADE_OUT] == null)
				return 1000;
			return json[MOTION_GROUPS][name][n][FADE_OUT];
		}
		
		
		public function getLayout():Object
		{
			return json[LAYOUT];
		}
		
		
		public function getInitParamNum():int
		{
			return (json[INIT_PARAM] == null) ? 0 : json[INIT_PARAM].length;
		}
		
		
		public function getInitParamID(n:int):String
		{
			if (json[INIT_PARAM] == null || json[INIT_PARAM][n] == null)
				return null;
			return json[INIT_PARAM][n][ID];
		}
		
		
		public function getInitParamValue(n:int):Number
		{
			if (json[INIT_PARAM] == null || json[INIT_PARAM][n] == null)
				return NaN;
			return json[INIT_PARAM][n][VALUE];
		}
		
		
		public function getInitPartsVisibleNum():int
		{
			return (json[INIT_PARTS_VISIBLE] == null) ? 0 : json[INIT_PARTS_VISIBLE].length;
		}
		
		
		public function getInitPartsVisibleID(n:int):String
		{
			if (json[INIT_PARTS_VISIBLE] == null || json[INIT_PARTS_VISIBLE][n] == null)
				return null;
			return json[INIT_PARTS_VISIBLE][n][ID];
		}
		
		
		public function getInitPartsVisibleValue(n:int):Number
		{
			if (json[INIT_PARTS_VISIBLE] == null || json[INIT_PARTS_VISIBLE][n] == null)
				return NaN;
			return json[INIT_PARTS_VISIBLE][n][VALUE];
		}
	
	}
}