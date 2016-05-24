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
	 * 目パチモーション。
	 * Live2DライブラリのEyeBlinkMotionクラスとほぼ同一。
	 * 使用はどちらでも良いが拡張する場合はこちらを使う。
	 */
	public class L2DEyeBlink
	{
		// ---- 内部データ ----
		protected var nextBlinkTime:Number; // 次回眼パチする時刻（msec）
		protected var stateStartTime:Number; // 現在のstateが開始した時刻
		
		protected var eyeState:int; // 現在の状態
		
		protected var closeIfZero:Boolean; // IDで指定された眼のパラメータが、0のときに閉じるなら true 、1の時に閉じるなら false
		
		protected var eyeID_L:String;
		protected var eyeID_R:String;
		// ------------ 設定 ------------
		protected var blinkIntervalMsec:int;
		
		protected var closingMotionMsec:int; // 眼が閉じるまでの時間
		protected var closedMotionMsec:int; // 閉じたままでいる時間
		protected var openingMotionMsec:int; // 眼が開くまでの時間
		
		

		public function L2DEyeBlink()
		{
			eyeState = EYE_STATE.STATE_FIRST;
			
			blinkIntervalMsec = 4000;
			
			closingMotionMsec = 100; // 眼が閉じるまでの時間
			closedMotionMsec = 50; // 閉じたままでいる時間
			openingMotionMsec = 150; // 眼が開くまでの時間
			
			closeIfZero = true; // IDで指定された眼のパラメータが、0のときに閉じるなら true 、1の時に閉じるなら false
			
			eyeID_L = "PARAM_EYE_L_OPEN";
			eyeID_R = "PARAM_EYE_R_OPEN";
		}
		
		
		/*
		 * 次回の眼パチの時刻を決める。
		 * @return
		 */
		public function calcNextBlink():Number
		{
			var time:Number = UtSystem.getUserTimeMSec();
			var r:Number = Math.random();
			return Number((time + r * (2 * blinkIntervalMsec - 1)));
		}
		
		
		public function setInterval(blinkIntervalMsec:int):void
		{
			this.blinkIntervalMsec = blinkIntervalMsec;
		}
		
		
		public function setEyeMotion(closingMotionMsec:int, closedMotionMsec:int, openingMotionMsec:int):void
		{
			this.closingMotionMsec = closingMotionMsec;
			this.closedMotionMsec = closedMotionMsec;
			this.openingMotionMsec = openingMotionMsec;
		}
		
		
		/*
		 * モデルのパラメータを更新。
		 * @param model
		 */
		public function updateParam(model:ALive2DModel):void
		{
			var time:Number = UtSystem.getUserTimeMSec();
			var eyeParamValue:Number; // 設定する値
			var t:Number = 0;
			
			switch (this.eyeState)
			{
				case EYE_STATE.STATE_CLOSING: 
					// 閉じるまでの割合を0..1に直す(blinkMotionMsecの半分の時間で閉じる)
					t = (time - stateStartTime) / Number(closingMotionMsec);
					if (t >= 1)
					{
						t = 1;
						this.eyeState = EYE_STATE.STATE_CLOSED; // 次から開き始める
						this.stateStartTime = time;
					}
					eyeParamValue = 1 - t;
					break;
				
				case EYE_STATE.STATE_CLOSED: 
					t = (time - stateStartTime) / Number(closedMotionMsec);
					if (t >= 1)
					{
						this.eyeState = EYE_STATE.STATE_OPENING; // 次から開き始める
						this.stateStartTime = time;
					}
					eyeParamValue = 0; // 閉じた状態
					break;
				
				case EYE_STATE.STATE_OPENING: 
					t = (time - stateStartTime) / Number(openingMotionMsec);
					if (t >= 1)
					{
						t = 1;
						this.eyeState = EYE_STATE.STATE_INTERVAL; // 次から開き始める
						this.nextBlinkTime = calcNextBlink(); // 次回のまばたきのタイミングを始める時刻
					}
					eyeParamValue = t;
					break;
				
				case EYE_STATE.STATE_INTERVAL: 
					// まばたき開始時刻なら
					if (this.nextBlinkTime < time)
					{
						this.eyeState = EYE_STATE.STATE_CLOSING;
						this.stateStartTime = time;
					}
					eyeParamValue = 1; // 開いた状態
					break;
				
				case EYE_STATE.STATE_FIRST: 
				default: 
					this.eyeState = EYE_STATE.STATE_INTERVAL;
					this.nextBlinkTime = calcNextBlink(); // 次回のまばたきのタイミングを始める時刻
					eyeParamValue = 1; // 開いた状態
					break;
			}
			if (!closeIfZero)
				eyeParamValue = -eyeParamValue;
			
			// ---- 値を設定 ----
			model.setParamFloat(eyeID_L, eyeParamValue);
			model.setParamFloat(eyeID_R, eyeParamValue);
		
		}
	}
}

// 眼の状態定数
class EYE_STATE
{
	public static const STATE_FIRST:int = 1;
	public static const STATE_INTERVAL:int = 2;
	public static const STATE_CLOSING:int = 3; // 閉じていく途中
	public static const STATE_CLOSED:int = 4; // 閉じている状態
	public static const STATE_OPENING:int = 5; // 開いていく途中
}