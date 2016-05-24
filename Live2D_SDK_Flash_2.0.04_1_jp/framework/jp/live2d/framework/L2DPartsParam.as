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
	import jp.live2d.id.PartsDataID;
	/*
	 * パーツインデックスを保持するクラス。
	 * パーツにはパーツIDとモーションから設定するパーツパラメータIDがある。
	 * 文字列で設定することもできるが、インデックスを取得してから設定したほうが高速。
	 */
	public class L2DPartsParam 
	{
		
		public static const VISIBLE:String = "VISIBLE:";
		
		public var id:String;
		public var paramIndex:int = -1;
		public var partsIndex:int = -1;
		
		public var link:Vector.<L2DPartsParam> = null; // 連動するパーツ
		
		

		public function L2DPartsParam(id:String)
		{
			this.id = id;
		}
		
		
		/*
		 * パラメータとパーツのインデックスを初期化する。
		 * @param model
		 */
		public function initIndex(model:ALive2DModel):void
		{
			paramIndex = model.getParamIndex(VISIBLE + id); // パーツ表示のパラメータはVISIBLE:がつく。Live2Dアニメータの仕様。
			
			partsIndex = model.getModelContext().getPartsDataIndex(PartsDataID.getID(id));
			model.setParamFloatIndex(paramIndex, 1);
		}
	}
}