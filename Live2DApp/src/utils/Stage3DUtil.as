/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package utils
{
	import com.adobe.utils.AGALMiniAssembler;
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.IndexBuffer3D;
	import flash.display3D.Program3D;
	import flash.display3D.VertexBuffer3D;
	import flash.geom.Matrix3D;
	
	public class Stage3DUtil
	{
		
		public function Stage3DUtil()
		{
		
		}
		
		
		/*
		 * 色付き背景の描画
		 *
		 * @param	context3D
		 * @param	r 0 ~ 1.0
		 * @param	g 0 ~ 1.0
		 * @param	b 0 ~ 1.0
		 */
		public static function drawColor(context3D:Context3D, r:Number, g:Number, b:Number):void
		{
			var vertexShader:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShader.assemble(Context3DProgramType.VERTEX, "m44 op, va0, vc0 \n" + "mov v0, va1\n");
			
			var mtx:Matrix3D = new Matrix3D();
			//mtx.appendScale(1, 0.5, 1);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mtx, false);
			
			var fragmentShader:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentShader.assemble(Context3DProgramType.FRAGMENT, "mov oc v0");
			
			var program:Program3D = context3D.createProgram();
			program.upload(vertexShader.agalcode, fragmentShader.agalcode);
			
			var vertexBuffer:VertexBuffer3D = context3D.createVertexBuffer(4, 6); // 頂点*4、頂点情報 x,y,z,r,g,b=6
			context3D.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_3);
			context3D.setVertexBufferAt(1, vertexBuffer, 3, Context3DVertexBufferFormat.FLOAT_3);
			
			vertexBuffer.uploadFromVector(Vector.<Number>([-1, -1, 0, r, g, b, -1, 1, 0, r, g, b, 1, -1, 0, r, g, b, 1, 1, 0, r, g, b]), 0, 4);
			
			var indexBuffer:IndexBuffer3D = context3D.createIndexBuffer(6);
			indexBuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 2, 1, 3]), 0, 6);
			
			context3D.setProgram(program);
			context3D.drawTriangles(indexBuffer);
		}
		
		
		/*
		 * 線で囲まれた四角を描画する。
		 * 非効率的。デバッグ用途のみの使用推奨。
		 *
		 */
		public static function drawLineBox(context3D:Context3D, size:Number, left:Number, right:Number, bottom:Number, top:Number, mtxData:Vector.<Number>, r:Number, g:Number, b:Number):void
		{
			context3D.setCulling(Context3DTriangleFace.NONE);
			
			var vertexShader:AGALMiniAssembler = new AGALMiniAssembler();
			vertexShader.assemble(Context3DProgramType.VERTEX, "m44 op, va0, vc0 \n" + "mov v0, va1\n");
			
			var mtx:Matrix3D = new Matrix3D(mtxData);
			context3D.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, mtx, true);
			
			var fragmentShader:AGALMiniAssembler = new AGALMiniAssembler();
			fragmentShader.assemble(Context3DProgramType.FRAGMENT, "mov oc v0");
			
			var program:Program3D = context3D.createProgram();
			program.upload(vertexShader.agalcode, fragmentShader.agalcode);
			
			var numVtx:int = 16;
			var vertexBuffer:VertexBuffer3D = context3D.createVertexBuffer(numVtx, 5); // 頂点 numVtx、頂点情報 x,y,r,g,b=5
			context3D.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2);
			context3D.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_3);
			
			vertexBuffer.uploadFromVector(Vector.<Number>([
				// 上辺
				left, top + size, r, g, b, right, top + size, r, g, b, left, top - size, r, g, b, right, top - size, r, g, b,
				
				// 右辺
				right - size, top, r, g, b, right + size, top, r, g, b, right - size, bottom, r, g, b, right + size, bottom, r, g, b,
				
				// 下辺
				left, bottom + size, r, g, b, right, bottom + size, r, g, b, left, bottom - size, r, g, b, right, bottom - size, r, g, b,
				
				// 左辺
				left - size, top, r, g, b, left + size, top, r, g, b, left - size, bottom, r, g, b, left + size, bottom, r, g, b,
				
				]), 0, numVtx);
			
			var numTri:int = 8;
			var indexBuffer:IndexBuffer3D = context3D.createIndexBuffer(numTri * 3);
			indexBuffer.uploadFromVector(Vector.<uint>([0, 1, 2, 2, 1, 3, 4, 5, 6, 6, 5, 7, 8, 9, 10, 10, 9, 11, 12, 13, 14, 14, 13, 15]), 0, numTri * 3);
			
			context3D.setProgram(program);
			context3D.drawTriangles(indexBuffer);
		}
	
	}

}