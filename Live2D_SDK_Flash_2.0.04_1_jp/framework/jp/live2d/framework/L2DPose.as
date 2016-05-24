/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework
{
	import jp.live2d.ALive2DModel;
	import jp.live2d.util.UtSystem;
	
	/*
	 * パーツの切り替えを管理する。
	 *
	 */
	public class L2DPose
	{
		public static const TYPE_POSE:String = "Live2D Pose";
		public static const KEY_TYPE:String = "type";
		public static const KEY_PARTS_VISIBLE:String = "parts_visible";
		public static const KEY_GROUP:String = "group";
		public static const KEY_ID:String = "id";
		public static const KEY_LINK:String = "link";
		
		protected var partsGroupList:Vector.<Vector.<L2DPartsParam>>;
		protected var lastTime:Number = 0;
		protected var lastModel:ALive2DModel = null; // パラメータインデックスが初期化されてるかどうかのチェック用。
		
		

		public function L2DPose()
		{
			partsGroupList = new Vector.<Vector.<L2DPartsParam>>();
		}
		
		
		/*
		 * パーツグループ(通常の配列)を追加。
		 * 一つのパーツグループからは表示できるパーツは一つだけ。
		 * @param partsGroup
		 */
		public function addPartsGroup(partsGroup:Vector.<L2DPartsParam>):void
		{
			partsGroupList.push(partsGroup);
		}
		
		
		/*
		 * モデルのパラメータを更新。
		 * @param model
		 */
		public function updateParam(model:ALive2DModel):void
		{
			if (model == null)
				return;
			
			// 前回のモデルと同じではない → 初期化が必要
			if (model != lastModel)
			{
				//  パラメータインデックスの初期化
				initParam(model);
			}
			
			lastModel = model;
			var curTime:Number = UtSystem.getTimeMSec();
			var deltaTimeSec:Number = ((lastTime == 0) ? 0 : (curTime - lastTime) / 1000.0);
			lastTime = curTime;
			
			// 設定から時間を変更すると、経過時間がマイナスになることがあるので、経過時間0として対応。
			if (deltaTimeSec < 0) deltaTimeSec = 0;
			
			for (var i:int = 0; i < partsGroupList.length; i++)
			{
				if (partsGroupList[i] == null) continue;
				normalizePartsOpacityGroup(model, partsGroupList[i], deltaTimeSec);
				copyOpacityOtherParts(model, partsGroupList[i]);
			}
		}
		
		
		/*
		 * 表示を初期化。
		 * αの初期値が0でないパラメータは、αを1に設定する。
		 * @param model
		 */
		public function initParam(model:ALive2DModel):void
		{
			if (model == null)
				return;
			
			for (var i:int = 0; i < partsGroupList.length; i++)
			{
				var partsGroup:Vector.<L2DPartsParam> = partsGroupList[i];
				if (partsGroup == null) continue;
				for (var j:int = 0; j < partsGroup.length; j++)
				{
					partsGroup[j].initIndex(model);
					var partsIndex:int = partsGroup[j].partsIndex;
					var paramIndex:int = partsGroup[j].paramIndex;
					var v:Boolean = (model.getParamFloatIndex(paramIndex) != 0);
					model.setPartsOpacityIndex(partsIndex, (v ? 1.0 : 0.0));
					model.setParamFloatIndex(paramIndex, (v ? 1.0 : 0.0));
				}
			}
		}
		
		
		/*
		 * パーツのフェードイン、フェードアウトを設定する。
		 * @param model
		 * @param partsGroup
		 * @param deltaTimeSec
		 */
		public function normalizePartsOpacityGroup(model:ALive2DModel, partsGroup:Vector.<L2DPartsParam>, deltaTimeSec:Number):void
		{
			var visibleParts:int = -1;
			var visibleOpacity:Number = 1.0;
			
			var CLEAR_TIME_SEC:Number = 0.5; // この時間で不透明になる
			var phi:Number = 0.5; // 背景が出にくいように、１＞０への変化を遅らせる場合は、0.5よりも大きくする。ただし、あまり自然ではない
			var maxBackOpacity:Number = 0.15;
			
			
			//  現在、表示状態になっているパーツを取得
			for (var i:int = 0; i < partsGroup.length; i++)
			{
				var partsIndex:int = partsGroup[i].partsIndex;
				var paramIndex:int = partsGroup[i].paramIndex;
				
				if (model.getParamFloatIndex(paramIndex) != 0)
				{
					if (visibleParts >= 0)
					{
						break;
					}
					visibleParts = i;
					visibleOpacity = model.getModelContext().getPartsOpacity(partsIndex);
					
					//  新しいOpacityを計算
					visibleOpacity += deltaTimeSec / CLEAR_TIME_SEC;
					if (visibleOpacity > 1)
					{
						visibleOpacity = 1;
					}
				}
			}
			
			if (visibleParts < 0)
			{
				visibleParts = 0;
				visibleOpacity = 1;
			}
			
			//  表示パーツ、非表示パーツの透明度を設定する
			for (i = 0; i < partsGroup.length; i++)
			{
				partsIndex = partsGroup[i].partsIndex;
				//var paramIndex:int = partsGroup[i].paramIndex;
				var opacity:Number
				//  表示パーツの設定
				if (visibleParts == i) // 先に設定
				{
					opacity = model.getPartsOpacityIndex(partsIndex);
					if (opacity != visibleOpacity) 
					{
						model.setPartsOpacityIndex(partsIndex, visibleOpacity);
					}
				}
				//  非表示パーツの設定
				else
				{
					opacity = model.getModelContext().getPartsOpacity(partsIndex);
					var a1:Number; // 計算によって求められる透明度
					if (visibleOpacity < phi)
					{
						a1 = visibleOpacity * (phi - 1) / phi + 1; //  (0,1),(phi,phi)を通る直線式
					}
					else
					{
						a1 = (1 - visibleOpacity) * phi / (1 - phi); //  (1,0),(phi,phi)を通る直線式
					}
					
					// 背景の見える割合を制限する場合
					var backOp:Number = (1 - a1) * (1 - visibleOpacity); 
					if (backOp > maxBackOpacity)
					{
						a1 = 1 - maxBackOpacity / (1 - visibleOpacity);
					}
					
					if (opacity > a1)
					{
						opacity = a1; //  計算の透明度よりも大きければ（濃ければ）透明度を上げる
						model.setPartsOpacityIndex(partsIndex, opacity);
					}
				}
			}
		}
		
		
		/*
		 * パーツのαを連動する。
		 * @param model
		 * @param partsGroup
		 */
		public function copyOpacityOtherParts(model:ALive2DModel, partsGroup:Vector.<L2DPartsParam>):void
		{
			for (var i_group:int = 0; i_group < partsGroup.length; i_group++)
			{
				var partsParam:L2DPartsParam = partsGroup[i_group];
				if (partsParam.link == null)
					continue; // リンクするパラメータはない
				
				var opacity:Number = model.getModelContext().getPartsOpacity(partsParam.partsIndex);
				for (var i_link:int = 0; i_link < partsParam.link.length; i_link++)
				{
					var linkParts:L2DPartsParam = partsParam.link[i_link];
					if (linkParts.partsIndex < 0)
					{
						// インデックスが初期化されてないときは初期化
						linkParts.initIndex(model);
					}
					var value:Number = model.getPartsOpacityIndex(linkParts.partsIndex);
					
					if (value!=opacity) 
					{
						model.setPartsOpacityIndex(linkParts.partsIndex, opacity);
					}
				}
			}
		}
		
		
		public static function loadJsonStr(str:String):L2DPose
		{
			var json:Object = JSON.parse(str);
			return loadJson(json);
		}
		
		
		/*
		 * JSONファイルから読み込む
		 * 仕様についてはマニュアル参照。JSONスキーマの形式の仕様がある。
		 * @param buf
		 * @return
		 */
		public static function loadJson(json:Object):L2DPose
		{
			var ret:L2DPose = new L2DPose();
			
			// パーツ切り替え一覧
			var poseListInfo:Array = json[KEY_PARTS_VISIBLE];
			var poseNum:int = poseListInfo.length;
			
			for (var i_pose:int = 0; i_pose < poseNum; i_pose++)
			{
				// IDリストの設定
				var idListInfo:Array = poseListInfo[i_pose][KEY_GROUP];
				var idNum:int = idListInfo.length;
				var partsGroup:Vector.<L2DPartsParam> = new Vector.<L2DPartsParam>(idNum);
				for (var i_group:int = 0; i_group < idNum; i_group++)
				{
					var partsInfo:Object = idListInfo[i_group];
					var parts:L2DPartsParam = new L2DPartsParam(idListInfo[i_group][KEY_ID]);
					partsGroup[i_group] = parts;
					
					// リンクするパーツの設定
					if (partsInfo[KEY_LINK] == null)
						continue;
					
					var linkListInfo:Array = partsInfo[KEY_LINK];
					var linkNum:int = linkListInfo.length;
					parts.link = new Vector.<L2DPartsParam>();
					for (var i_link:int = 0; i_link < linkNum; i_link++)
					{
						var linkID:String = idListInfo[i_group];
						var linkParts:L2DPartsParam = new L2DPartsParam(linkListInfo[i_link].toString());
						parts.link.push(linkParts);
					}
				}
				ret.addPartsGroup(partsGroup);
			}
			return ret;
		}
	}
}

