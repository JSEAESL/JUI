/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.utils
{
	
	public class MatrixStack
	{
		// 行列スタック。4x4行列を基本とするので、16ごとの区切りの配列。
		private static var matrixStack:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
		
		// 現在のスタックの深さ。初期は0でpushするごとに+1。
		private static var depth:int = 0;
		
		// 現在の行列
		private static var currentMatrix:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
		
		// 計算用
		private static var tmp:Vector.<Number> = new Vector.<Number>(16);
		
		
		/*
		 * スタックをリセット
		 */
		public static function reset():void
		{
			depth = 0;
		}
		
		
		/*
		 * 単位行列にする
		 */
		public static function loadIdentity():void
		{
			for (var i:int = 0; i < 16; i++)
			{
				currentMatrix[i] = (i % 5 == 0) ? 1 : 0;
			}
		}
		
		
		/*
		 * 現在の行列を保存
		 */
		public static function push():void
		{
			var offset:int = depth * 16;
			var nextOffset:int = (depth + 1) * 16;
			
			if (matrixStack.length < nextOffset + 16)
			{
				matrixStack.length = nextOffset + 16;
			}
			
			for (var i:int = 0; i < 16; i++)
			{
				matrixStack[nextOffset + i] = currentMatrix[i];
			}
			
			depth++;
		}
		
		
		/*
		 * 一つ前の行列へ
		 */
		public static function pop():void
		{
			depth--;
			if (depth < 0)
			{
				trace("Invalid matrix stack.");
				depth = 0;
			}
			
			var offset:int = depth * 16;
			for (var i:int = 0; i < 16; i++)
			{
				currentMatrix[i] = matrixStack[offset + i];
			}
		}
		
		
		/*
		 * 現在の行列を取得
		 * @return
		 */
		public static function getMatrix():Vector.<Number>
		{
			return currentMatrix;
		}
		
		
		/*
		 * 行列を掛け合わせる
		 * @param	matNew
		 */
		public static function multMatrix(matNew:Vector.<Number>):void
		{
			var i:int, j:int, k:int;
			
			for (i = 0; i < 16; i++)
			{
				tmp[i] = 0;
			}
			
			for (i = 0; i < 4; i++)
			{
				for (j = 0; j < 4; j++)
				{
					for (k = 0; k < 4; k++)
					{
						tmp[i + j * 4] += currentMatrix[i + k * 4] * matNew[k + j * 4];
					}
				}
			}
			for (i = 0; i < 16; i++)
			{
				currentMatrix[i] = tmp[i];
			}
		}
	
	}
}