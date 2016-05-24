package jlib.old
{
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;

	public class JFilter
	{
		static public const LIGHT_YELLOW:GlowFilter			=	new GlowFilter(0xffff00, 1, 4, 4, 10);
		static public const BORDER_BROWN:GlowFilter			=	new GlowFilter(0x491F02, 1, 2, 2, 10);
		static public const BORDER_WHITE:GlowFilter			=	new GlowFilter(0xffffff, 1, 2, 2, 6);
		static public const BORDER_BLACK:GlowFilter			=	new GlowFilter(0x000000, 1, 2, 2, 6);
		static public const BORDER_YELLOW:GlowFilter		=	new GlowFilter(0xffff00, 1, 2, 2, 6);
		static public const BORDER_PURPLE:GlowFilter		=	new GlowFilter(0x3F1E4D, 1, 2, 2, 6);
		static public const BORDER_GREEN:GlowFilter			=	new GlowFilter(0x55AA22, 1, 4, 4, 6);
		static public const BORDER_RED:GlowFilter			=	new GlowFilter(0xff6600, 1, 2, 2, 10);
		static public const BORDER_RED_BLACK:GlowFilter		=	new GlowFilter(0xCC0000, 1, 2, 2, 10);
		static public const BORDER_RED_INSIDE:GlowFilter	=	new GlowFilter(0xff6600, 1, 4, 4, 10, 1, true);
		static public const BORDER_BLUE_INSIDE:GlowFilter	=	new GlowFilter(0x0066ff, 1, 10, 10, 1, 1, true);
		static public const BORDER_BLUE:GlowFilter			=	new GlowFilter(0x0066ff, 1, 2, 2, 6);
		
		static public const BORDER_YELLOW_BOLD:GlowFilter	=	new GlowFilter(0xffff00, 1, 4, 4, 6);
		static public const BORDER_BLUESKY_BOLD:GlowFilter	=	new GlowFilter(0x00ffff, 1, 4, 4, 6);
		
		static public const BORDER_WHITE_BOLD:GlowFilter	=	new GlowFilter(0xffffff, 1, 4, 4, 6);
		static public const BORDER_BLACK_BOLD:GlowFilter	=	new GlowFilter(0x000000, 1, 4, 4, 6);
		static public const BORDER_RED_BOLD:GlowFilter		=	new GlowFilter(0xff0000, 1, 4, 4, 10);
		
		static public const BORDER_REDB:GlowFilter			=	new GlowFilter(0xCC5544, 1, 2, 2, 6);
		
		static public const BORDER_BLACK_50:GlowFilter		=	new GlowFilter(0x000000, 0.5, 2, 2, 6);
		static public const BORDER_BLACK_4PIX:GlowFilter	=	new GlowFilter(0x000000, 1, 1.5, 1.5, 3);
		static public const BORDER_WHITE_CENT:GlowFilter	=	new GlowFilter(0xffffff, 1, 6,  6, 25, 1, true);
		
		static public const BORDER_CHOOSE:GlowFilter		=	new GlowFilter(0xbfa84d, 1, 6, 6, 1.5);
		
		static public const COLOR_MATRIX_LIGHT:ColorMatrixFilter	=	new ColorMatrixFilter( [1, 0.8, 0, 0, 0, 0, 1, 0.75, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0] );
		static public const COLOR_MATRIX_SPECIAL:ColorMatrixFilter	=	new ColorMatrixFilter( [1, 0, 0, 0.13, 0.01, 0, 1, 0, 0.18, 0, 0, 0, 1, 0.13, 0.02, 0, 0, 0, 0.98, 0.02]);
		static public const COLOR_MATRIX_ACTIVE:ColorMatrixFilter	=	new ColorMatrixFilter( [0.52,0,	0,	0,	0,		//	red
			0,	0.85,0,	0,	0,		//	green
			0,	0,	0,0.52,	0,		//	blue
			0,	0,	0,	1, 0] );	//	alpha
		
		static public const COLOR_MATRIX_SELECT:ColorMatrixFilter	=	new ColorMatrixFilter( [1.2,0,	0,	0,	0,		//	red
			0,	1.2,0,	0,	0,		//	green
			0,	0,	1.2,0,	0,		//	blue
			0,	0,	0,	1, 0] );	//	alpha
		
		static public const COLOR_MATRIX_BLACK:ColorMatrixFilter	=	new ColorMatrixFilter( [0.5,0,	0,	0,	0,		//	red
			0,	0.5,0,	0,	0,		//	green
			0,	0,	0.5,0,	0,		//	blue
			0,	0,	0,	1, 0] );	//	alpha
		
		static public const COLOR_MATRIX_WHITE:ColorMatrixFilter	=	new ColorMatrixFilter( [2,	0,	0,	0,	0,		//	red
			0,	2,	0,	0,	0,		//	green
			0,	0,	2,	0,	0,		//	blue
			0,	0,	0,	1, 0] );	//	alpha
		
		static public const COLOR_MATRIX_BW:ColorMatrixFilter		=	new ColorMatrixFilter( [0.3086, 0.6094, 0.0820, 0, 0,		//	黑白
			0.3086, 0.6094, 0.0820, 0, 0,		//	green
			0.3086, 0.6094, 0.0820, 0, 0,		//	blue
			0,	0,	0,	1,  0] );				//	alpha
		
		static public const COLOR_MATRIX_GREEN:ColorMatrixFilter	=	new ColorMatrixFilter( [0.5,0,	0,	0,	0,		//	red
			0,	1,	0,	0,	0,		//	green
			0,	0,	0.5,0,	0,		//	blue
			0,	0,	0,	1, 	0] );	//	alpha
		
		static public const COLOR_MATRIX_RED:ColorMatrixFilter		=	new ColorMatrixFilter( [1,	0,	0,	0,	0,		//	red
			0,	0.5,0,	0,	0,		//	green
			0,	0,	0.5,0,	0,		//	blue
			0,	0,	0,	1, 	0] );	//	alpha
		
		static public const COLOR_MATRIX_BLUE:ColorMatrixFilter		=	new ColorMatrixFilter( [0.5,0,	0,	0,	0,		//	red
			0,	0.5,0,	0,	0,		//	green
			0,	0,	1,	0,	0,		//	blue
			0,	0,	0,	1, 	0] );	//	alpha
		
		static public const	COLOR_MATRIX_FILM:ColorMatrixFilter	=	new ColorMatrixFilter([		-1, 0,  0,  0, 255,		//	胶片效果(反色)
			0,  -1, 0,  0, 255,
			0,  0,  -1, 0, 255,
			0,  0,  0,  1, 1]	);
		
		// ---- [ 私有方法 ] ---- //
		
		/*
		*   AS3的代码绘制滤镜，AS3中包含下面滤镜， 
		Drop Shadow －－投影滤镜 
		Blur －－模糊滤镜 
		Glow －－发光滤镜 
		Bevel －－斜角滤镜 
		Gradient bevel －－渐变斜角滤镜 
		Gradient glow －－渐变发光滤镜 
		Color matrix －－颜色矩阵滤镜 
		Convolution －－卷积滤镜 
		Displacement map－－转换图滤镜 
		关于Blur的使用情况 
		var blur:BlurFilter=new BlurFilter(5,5,3); 
		var filters:Array=new Array(); 
		filters.push(blur); 
		sprite.filters=filters; 
		关于Gradient bevel的使用情况 
		import flash.display.*; 
		import flash.geom.*; 
		var fType:String = GradientType.LINEAR;//用指定线性渐变填充的值 
		var colors:Array = [ 0xF1F1F1, 0x666666 ]; 
		var alphas:Array = [ 1, 1 ]; 
		var ratios:Array = [ 0, 255 ]; 
		var matr:Matrix = new Matrix(); 
		matr.createGradientBox( 200, 20, 0, 0, 0 ); 
		var sprMethod:String = SpreadMethod.PAD; 
		var sprite:Sprite = new Sprite(); 
		var g:Graphics = sprite.graphics; 
		g.beginGradientFill( fType, colors, alphas, ratios, matr,   sprMethod ); 
		g.drawRect( 0, 0, 400, 200 ); 
		addChild( sprite ); 
		关于使用DropShadowFilter制作投影 
		var color:Number = 0x000000;//投影的颜色 
		var angle:Number = 45;//投影的角度 
		var alpha:Number = 0.8;//投影的透明度 
		var blurX:Number = 8;//水平模糊量,0不模糊 
		var blurY:Number = 8;//垂直模糊量,0不模糊 
		var distance:Number = 15;//投影的距离 
		var strength:Number = 1;//强度 
		var inner:Boolean = false;//是不是内嵌 
		var knockout:Boolean = false; 
		var quality:Number = BitmapFilterQuality.HIGH; 
		var filter:DropShadowFilter=new DropShadowFilter(distance, 
		angle,color,alpha,blurX,blurY, 
		strength,quality,inner,knockout); 
		sprite.filters=[filter]; 
		*/
	}
}