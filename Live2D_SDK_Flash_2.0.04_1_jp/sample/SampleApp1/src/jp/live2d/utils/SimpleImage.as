/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.utils
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.textures.Texture;
	import flash.display3D.VertexBuffer3D;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix3D;
	import flash.net.URLRequest;
	
	/*
	 * 背景
	 */
	public class SimpleImage
	{
		private var texture:Texture; // テクスチャ
		static private var program:Program3D = null;
		private var matrix:Matrix3D = new Matrix3D(); // 拡大縮小用
		private var color:Vector.<Number> = new <Number>[1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1];
		private var _alpha:Number;
		
		// 通常の座標系は中心が原点(0,0,0)になる
		// 頂点 x,y
		private const vertexArray:Vector.<Number> = Vector.<Number>([-1, 1, // 画面左上
			1, 1, // 画面右上 
			-1, -1, // 画面左下 
			1, -1 // 画面右下
			]);
		
		// 画像のUV
		private const uvArray:Vector.<Number> = Vector.<Number>([0, 0, 1, 0, 0, 1, 1, 1]);
		
		// 板ポリゴン用頂点インデックス
		private const indexArray:Vector.<Number> = Vector.<Number>([0, 1, 2, 2, 1, 3]);
		
		
		public function SimpleImage(context3D:Context3D):void
		{
			//program = new ShaderProgram(context3D);
			if (program == null)
			{
				initProgram(context3D);
			}
		
		}
		
		
		static public function initProgram(context3D:Context3D):void
		{
			var vshCode:String = "m44 op, va0, vc0 \n" + // 行列演算。頂点(va0)に変換行列(vc0)をかけて出力
				"mov v0, va1 \n"; //  変数(v0)にuv情報(va1)を設定して、断片シェーダで使えるようにする
			
			var fshCode:String = "tex ft0, v0.xy, fs0 <2d,clamp,linear>\n" + // 頂点シェーダで設定したuv情報(v0)からテクスチャ(fs0)を読み込んで一時レジスタに出力(ft0)
				"m44 oc,  ft0 , fc0\n"; // alpha用行列(fc0)をrgbaそれぞれに乗算して出力
			// "tex oc, v0.xy, fs0 <2d,clamp,linear>\n" ; //頂点シェーダで設定したuv情報(v0)からテクスチャ(fs0)を読み込んで一時レジスタに出力(ft0)
			program = context3D.createProgram(); // Program3Dを作成
			
			var vsh:AGALMiniAssembler = new AGALMiniAssembler;
			var fsh:AGALMiniAssembler = new AGALMiniAssembler;
			vsh.assemble(Context3DProgramType.VERTEX, vshCode);
			fsh.assemble(Context3DProgramType.FRAGMENT, fshCode);
			program.upload(vsh.agalcode, fsh.agalcode); // 頂点シェーダと断片シェーダを設定
		}
		
		
		public function setMatrixVector(data:Vector.<Number>):void
		{
			matrix.copyRawDataFrom(data);
		}
		
		
		/*
		 * テクスチャの描画先の座標を設定
		 *
		 * @param left
		 * @param right
		 * @param bottom
		 * @param top
		 */
		public function setDrawRect(left:Number, right:Number, bottom:Number, top:Number):void
		{
			vertexArray[0] = left;
			vertexArray[1] = top;
			
			vertexArray[2] = right;
			vertexArray[3] = top;
			
			vertexArray[4] = left;
			vertexArray[5] = bottom;
			
			vertexArray[6] = right;
			vertexArray[7] = bottom;
		
		}
		
		
		/*
		 * 背景画像の描画
		 * @param	context3D
		 */
		public function drawImage(context3D:Context3D):void
		{
			if (texture == null)
			{
				return;
			}
			
			var vtxBuffer:VertexBuffer3D;
			var indexBuffer:IndexBuffer3D;
			var uvBuffer:VertexBuffer3D;
			
			// 行列の設定。以前の設定は無効
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, matrix, true); // vc0 に頂点の変換行列を設定
			context3D.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, color); // fc0 に色行列を設定
			context3D.setTextureAt(0, texture); // テクスチャの登録
			context3D.setProgram(program); // レンダリングプログラムの登録
			
			// 頂点、テクスチャUV、インデックス バッファの作成
			if (vtxBuffer == null)
				vtxBuffer = context3D.createVertexBuffer(vertexArray.length / 2, 2); // 頂点数 vertexArray.length/2、 頂点ごとの要素数 2(x,y)
			if (uvBuffer == null)
				uvBuffer = context3D.createVertexBuffer(uvArray.length / 2, 2); // 頂点数 uvArray.length/2、 頂点ごとの要素数 2(u,v)
			if (indexBuffer == null)
				indexBuffer = context3D.createIndexBuffer(indexArray.length); // インデックス数 indexArray.length
			
			// 頂点、テクスチャUV、インデックス バッファのアップロード
			vtxBuffer.uploadFromVector(vertexArray, 0, vertexArray.length / 2); // データ vertexArray, 開始頂点 0番 , 頂点数 vertexArray.length/2 
			uvBuffer.uploadFromVector(uvArray, 0, uvArray.length / 2); // データ vertexArray, 開始頂点 0番 , 頂点数 uvArray.length/2
			indexBuffer.uploadFromVector(Vector.<uint>(indexArray), 0, indexArray.length); // データ vertexArray, 開始インデックス 0番 , インデックス数 indexArray.length
			
			// 頂点バッファのレジスタ登録
			context3D.setVertexBufferAt(0, vtxBuffer, 0, Context3DVertexBufferFormat.FLOAT_2); // va0 データ _vtxBuffer、 開始 0番、頂点ごとの要素数 2(x,y)
			context3D.setVertexBufferAt(1, uvBuffer, 0, Context3DVertexBufferFormat.FLOAT_2); // va1 データ _uvBuffer、 開始 0番、頂点ごとの要素数 2(u,v)
			
			context3D.drawTriangles(indexBuffer); // 描画
			
			context3D.setTextureAt(0, null);
		}
		
		
		public function setTexture(t:Texture):void
		{
			texture = t;
		}
		
		
		/*
		 * 背景画像の設定
		 * @param	modelTextureNo
		 * @param	bitmap
		 */
		public function setImage(context3D:Context3D, bmd:BitmapData):void
		{
			texture = context3D.createTexture(bmd.width, bmd.height, Context3DTextureFormat.BGRA, false);
			texture.uploadFromBitmapData(bmd);
		}
		
		
		/*
		 * 背景画像を読み込んで設定
		 * @param	context3D
		 * @param	path
		 */
		public function loadImage(context3D:Context3D, path:String):void
		{
			var loader:Loader = new Loader;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function():void
				{
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, arguments.callee);
					setImage(context3D, Bitmap(loader.content).bitmapData);
				});
			
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, function():void
				{
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, arguments.callee);
				//UtSystem.errPrintf(path);
				});
			
			loader.load(new URLRequest(path));
		}
		
		
		public function get alpha():Number
		{
			return color[15];
		}
		
		
		public function set alpha(value:Number):void
		{
			color[0] = value;
			color[5] = value;
			color[10] = value;
			color[15] = value;
		}
	
	}
}

