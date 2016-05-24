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
	import jp.live2d.motion.AMotion;
	import jp.live2d.motion.MotionQueueEnt;
	
	/*
	 * 差分モーション。
	 * 通常のモーションは値をsetParamFloatでセットするが、
	 * この差分モーションでは値を足すか、掛けるかする。
	 *
	 * Live2DライブラリのAMotionを継承しているのでMotionQueueManagerで管理できる。
	 * @author ono
	 */
	public class L2DExpressionMotion extends AMotion
	{
		public static const TYPE_EXPRESSION:String = "Live2D Expression";
		public static const KEY_FADE_IN:String = "fade_in";
		public static const KEY_FADE_OUT:String = "fade_out";
		public static const KEY_ID:String = "id";
		public static const KEY_CALCULATION:String = "calc";
		public static const KEY_DEFAULT_VALUE:String = "def";
		public static const KEY_VALUE:String = "val";
		public static const KEY_PARAMS:String = "params";
		public static const KEY_TYPE:String = "type";
		public static const TYPE_SET_STRING:String = "set" ; 
		public static const TYPE_ADD_STRING:String = "add" ; 
		public static const TYPE_MULT_STRING:String = "mult" ; 
		
		public static const DEFAULT_FADE_IN_VALUE:int = 500; 
		public static const DEFAULT_FADE_OUT_VALUE:int = 500 ; 
		
		// public static const EXPRESSION_DEFAULT:String = ; //表情のデフォルト値要素のキー
		public static const TYPE_SET_INDEX:int = 0;
		public static const TYPE_ADD_INDEX:int = 1;
		public static const TYPE_MULT_INDEX:int = 2;
		
		protected var paramList:Vector.<L2DExpressionParam>;
		protected var _name:String;
		
		
		public function L2DExpressionMotion()
		{
			paramList = new Vector.<L2DExpressionParam>();
		}
		
		
		/*
		 * パラメータを追加する
		 * @param paramID
		 * @param value
		 * @param type
		 */
		public function addParam(paramID:String, value:Number, type:int):void
		{
			var param:L2DExpressionParam = new L2DExpressionParam();
			param.enable = true;
			param.id = paramID;
			param.type = type;
			param.value = value;
			paramList.push(param);
		}
		
		
		/*
		 * モデルのパラメータを更新する。
		 * 引数の詳細はドキュメントを参照。
		 */
		protected override function updateParamExe(model:ALive2DModel, timeMSec:Number, weight:Number, motionQueueEnt:MotionQueueEnt):void
		{
			for (var i:int = paramList.length - 1; i >= 0; --i)
			{
				var param:L2DExpressionParam = paramList[i];
				if ( ! param.enable) continue;
				if (param.type == TYPE_ADD_INDEX)
				{
					model.addToParamFloat(param.id, param.value, weight);
				}
				else if (param.type == TYPE_MULT_INDEX)
				{
					model.multParamFloat(param.id, param.value, weight);
				}
			}
		}
		
		
		public static function loadJsonStr(str:String):L2DExpressionMotion
		{
			return loadJson(JSON.parse(str));
		
		}
		
		
		/*
		 * JSONファイルから読み込み。
		 * 仕様についてはマニュアル参照。JSONスキーマの形式の仕様がある。
		 * @param buf
		 * @return
		 */
		public static function loadJson(json:Object):L2DExpressionMotion
		{
			var ret:L2DExpressionMotion = new L2DExpressionMotion();
			
			// フェードイン
			ret.setFadeIn(json[KEY_FADE_IN]);
			
			// フェードアウト
			ret.setFadeOut(json[KEY_FADE_OUT]);
			
			// パラメータ一覧
			var params:Array = json[KEY_PARAMS];
			
			if (params == null)
				return ret;
			var paramNum:int = params.length;
			
			ret.paramList = new Vector.<L2DExpressionParam>();
			
			for (var i:int = 0; i < paramNum; i++)
			{
				var param:Object = params[i];
				var paramID:String = param[KEY_ID];
				
				var def:Object = param[KEY_DEFAULT_VALUE]; //default
				var value:Number;
				
				var calc:String = param[KEY_CALCULATION];
				var calcTypeInt:int = TYPE_ADD_INDEX;
				if (calc == TYPE_ADD_STRING)
				{
					calcTypeInt = TYPE_ADD_INDEX;
				}
				else if (calc == TYPE_MULT_STRING)
				{
					calcTypeInt = TYPE_MULT_INDEX;
					
				}
				if (calcTypeInt == TYPE_ADD_INDEX)
				{
					if (def != null)
					{
						// デフォルトの値が設定されてるときは差分をとる
						value = -Number(def) + param[KEY_VALUE];
					}
					else
					{
						value = param[KEY_VALUE];
					}
				}
				else if (calcTypeInt == TYPE_MULT_INDEX)
				{
					if (def != null)
					{
						// デフォルトの値が設定されてるときは差分をとる
						value = param[KEY_VALUE] / Number(def);
					}
					else
					{
						value = param[KEY_VALUE];
					}
				}
				
				ret.addParam(paramID, value, calcTypeInt);
			}
			return ret;
		}
		
		
		/*
		 * JSONファイルを読み込んで表情の設定を取得する
		 * @param	live2DMgr
		 * @param	dir
		 * @param	filename
		 * @return
		 */
		public static function loadExpressionJsonStrV09(data:String):Array /*<String, LAppExpressionMotion>*/
		{
			var json:Object = JSON.parse(data);
			return loadExpressionJsonV09(json);
		}
		
		
		public static function loadExpressionJsonV09(json:Object):Array /*<String, LAppExpressionMotion>*/
		{
			var expressions:Array = new Array;
			
			var defaultExpr:Object = json["DEFAULT"]; // 相対値の基準となる値
			
			for (var key:String in json)
			{
				if ("DEFAULT" == key)
					continue; // 飛ばす
				
				var expr:Object = json[key];
				
				var exMotion:L2DExpressionMotion = loadJsonV09(defaultExpr, expr);
				expressions[key] = exMotion;
			}
			
			return expressions; // nullには成らない
		}
		
		
		/*
		 * JSONの解析結果からExpressionを生成する
		 * @param v
		 */
		static private function loadJsonV09(defaultExpr:Object, expr:Object):L2DExpressionMotion
		{
			
			var ret:L2DExpressionMotion = new L2DExpressionMotion();
			ret.setFadeIn(expr["FADE_IN"] ? expr["FADE_IN"] : 1000);
			ret.setFadeOut(expr["FADE_OUT"] ? expr["FADE_OUT"] : 1000);
			
			// --- IDリストを生成
			var defaultParams:Object = defaultExpr["PARAMS"];
			var params:Object = expr["PARAMS"];
			
			// --------- 値を設定 ---------
			for (var name:String in params)
			{
				var defaultV:Number = defaultParams[name];
				var v:Number = params[name];
				var value:Number = (v - defaultV);
				
				ret.addParam(name, value, L2DExpressionMotion.TYPE_ADD_INDEX);
			}
			
			return ret;
		}
		
		
		public function get name():String
		{
			return _name;
		}
	
	}
}
