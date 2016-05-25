/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package framework
{
	import jp.live2d.ALive2DModel;
	import jp.live2d.physics.PhysicsHair;
	import jp.live2d.util.UtDebug;
	import jp.live2d.util.UtSystem;
	
	/*
	 * 物理演算のアニメーション。
	 *
	 */
	public class L2DPhysics
	{
		public static const TYPE_PHYSICS:String = "Live2D Physics";
		public static const KEY_TYPE:String = "type";
		public static const KEY_PHYSICS_HAIR:String = "physics_hair";
		public static const KEY_SETUP:String = "setup";
		public static const KEY_LENGTH:String = "length";
		public static const KEY_REGIST:String = "regist";
		public static const KEY_MASS:String = "mass";
		public static const KEY_SRC:String = "src";
		public static const KEY_ID:String = "id";
		public static const KEY_TARGETS:String = "targets";
		public static const KEY_PTYPE:String = "ptype";
		public static const KEY_SCALE:String = "scale";
		public static const KEY_WEIGHT:String = "weight";

		public static const SRC_TYPE_X:String = "x";
		public static const SRC_TYPE_Y:String = "y";
		public static const SRC_TYPE_ANGLE:String = "angle";
		public static const TARGET_TYPE_ANGLE:String = "angle";
		public static const TARGET_TYPE_ANGLE_V:String = "angle_v";
		
		
		protected var physicsList:Vector.<PhysicsHair>;
		protected var startTimeMSec:Number;
		
		

		public function L2DPhysics()
		{
			physicsList = new Vector.<PhysicsHair>();
			startTimeMSec = UtSystem.getUserTimeMSec();
		}
		
		
		/*
		 * モデルのパラメータを更新。
		 * @param model
		 */
		public function updateParam(model:ALive2DModel):void
		{
			var timeMSec:Number = UtSystem.getUserTimeMSec() - startTimeMSec;
			for (var i:int = 0; i < physicsList.length; i++)
			{
				physicsList[i].update(model, timeMSec);
			}
		}
		
		
		public static function loadJsonStr(str:String):L2DPhysics
		{
			var json:Object = JSON.parse(str);
			return loadJson(json);
		}
		
		
		/*
		 * JSONファイルから読み込み
		 * 仕様についてはマニュアル参照。JSONスキーマの形式の仕様がある。
		 * @param buf
		 * @return
		 */
		public static function loadJson(json:Object):L2DPhysics
		{
			var ret:L2DPhysics = new L2DPhysics();
			
			// 物理演算一覧
			var params:Array = json[KEY_PHYSICS_HAIR];
			var paramNum:int = params.length;
			
			for (var i:int = 0; i < paramNum; i++)
			{
				var param:Object = params[i];
				
				var physics:PhysicsHair = new PhysicsHair();
				// 計算の設定
				var setup:Object = param[KEY_SETUP];
				// 長さ
				var length:Number = setup[KEY_LENGTH];
				// 空気抵抗
				var resist:Number = setup[KEY_REGIST];
				// 質量
				var mass:Number = setup[KEY_MASS];
				physics.setup(length, resist, mass);
				
				// 元パラメータの設定
				var srcList:Array = param[KEY_SRC];
				var srcNum:int = srcList.length;
				for (var j:int = 0; j < srcNum; j++)
				{
					var src:Object = srcList[j];
					var id:String = src[KEY_ID];
					var type:int = PhysicsHair.SRC_TO_X;
					var typeStr:String = src[KEY_PTYPE];
					if (typeStr == SRC_TYPE_X)
					{
						type = PhysicsHair.SRC_TO_X;
					}
					else if (typeStr == SRC_TYPE_Y)
					{
						type = PhysicsHair.SRC_TO_Y;
					}
					else if (typeStr == SRC_TYPE_ANGLE)
					{
						type = PhysicsHair.SRC_TO_G_ANGLE;
					}
					else
					{
						UtDebug.error("Invalid parameter:PhysicsHair.Src");
					}
					var scale:Number = src[KEY_SCALE];
					var weight:Number = src[KEY_WEIGHT];
					physics.addSrcParam(type, id, scale, weight);
				}
				
				// 対象パラメータの設定
				var targetList:Array = param[KEY_TARGETS];
				var targetNum:int = targetList.length;
				for (j = 0; j < targetNum; j++)
				{
					var target:Object = targetList[j];
					id = target[KEY_ID];
					type = PhysicsHair.TARGET_FROM_ANGLE;
					typeStr = target[KEY_PTYPE];
					if (typeStr == TARGET_TYPE_ANGLE)
					{
						type = PhysicsHair.TARGET_FROM_ANGLE;
					}
					else if (typeStr == TARGET_TYPE_ANGLE_V)
					{
						type = PhysicsHair.TARGET_FROM_ANGLE_V;
					}
					else
					{
						UtDebug.error("Invalid parameter:PhysicsHair.Target");
					}
					scale = target[KEY_SCALE];
					weight = target[KEY_WEIGHT];
					physics.addTargetParam(type, id, scale, weight);
				}
				ret.physicsList.push(physics);
			}
			return ret;
		}
	}
}
