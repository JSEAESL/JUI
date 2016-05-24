/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.sample
{
	
	public class LAppDefine
	{
		// デバッグ。trueのときにログを表示する。
		public static const DEBUG_LOG:Boolean = true;
		public static const DEBUG_MOUSE_LOG:Boolean = false; // マウス関連の冗長なログ
		public static const DEBUG_DRAW_HIT_AREA:Boolean = false; // 当たり判定の可視化
		public static const DEBUG_DRAW_ALPHA_MODEL:Boolean = false; // 半透明のモデル描画を行うかどうか。(パフォーマンスが落ちる可能性があります)
		
		//  全体の設定-------------------------------------------------------------------------------------------
		// 画面
		public static const VIEW_MAX_SCALE:Number = 2;
		public static const VIEW_MIN_SCALE:Number = 0.8;
		
		public static const VIEW_LOGICAL_LEFT:Number = -1;
		public static const VIEW_LOGICAL_RIGHT:Number = 1;
		
		public static const VIEW_LOGICAL_MAX_LEFT:Number = -2;
		public static const VIEW_LOGICAL_MAX_RIGHT:Number = 2;
		public static const VIEW_LOGICAL_MAX_BOTTOM:Number = -2;
		public static const VIEW_LOGICAL_MAX_TOP:Number = 2;
		
		// モーションの優先度定数
		public static const PRIORITY_NONE:int = 0;
		public static const PRIORITY_IDLE:int = 1;
		public static const PRIORITY_NORMAL:int = 2;
		public static const PRIORITY_FORCE:int = 3;
		
		// モデルの後ろにある背景の画像ファイル
		public static const BACK_IMAGE_NAME:String = "image/back_class_normal.png";
		
		//  モデル定義----------------------------------------------------------------------------------------------------
		public static const MODEL_HARU:String = "live2d/haru/haru.model.json";
		public static const MODEL_HARU_A:String = "live2d/haru/haru_01.model.json";
		public static const MODEL_HARU_B:String = "live2d/haru/haru_02.model.json";
		public static const MODEL_SHIZUKU:String = "live2d/shizuku/shizuku.model.json";
		public static const MODEL_WANKO:String = "live2d/wanko/wanko.model.json";
		
		// 外部定義ファイル(json)と合わせる
		public static const MOTION_GROUP_IDLE:String = "idle"; // アイドリング
		public static const MOTION_GROUP_TAP_BODY:String = "tap_body"; // 体をタップしたとき
		public static const MOTION_GROUP_FLICK_HEAD:String = "flick_head"; // 頭を撫でた時
		public static const MOTION_GROUP_PINCH_IN:String = "pinch_in"; // 拡大した時
		public static const MOTION_GROUP_PINCH_OUT:String = "pinch_out"; // 縮小した時
		public static const MOTION_GROUP_SHAKE:String = "shake"; // シェイク
		
		// 外部定義ファイル(json)と合わせる
		public static const HIT_AREA_HEAD:String = "head";
		public static const HIT_AREA_BODY:String = "body";
	
	}
}
