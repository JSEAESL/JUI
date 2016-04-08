package core.common
{
	import com.greensock.TweenLite;
	import core.common.utils.DragSprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.text.Font;
	import flash.utils.Dictionary;
	import morn.core.components.Box;
	import morn.core.components.Label;
	public class CreatUtil
	{
		public function CreatUtil()
		{
		}

		public static  function cloneDrag(drager:Sprite,data:* = null):DragSprite
		{
			var result:DragSprite = new DragSprite();
			var bit:Bitmap = new Bitmap();
			var bitData:BitmapData = new BitmapData(drager.width,drager.height,true,0x00000000);
			bit.bitmapData = bitData;
			bitData.draw(drager);
			result.addChild(bit);
			var par:*  = drager.parent;
			var p:Point = drager.parent.localToGlobal(new Point(drager.x,drager.y) );
			result.x = p.x;
			result.y = p.y;
			//par.addChild(result);
			result.alpha = 0.8;
			result.DragData = data;
			return result;
		}

		public static function setValueBoxData(dimBox:Box,data:Object):void
		{
			var name:String = data.name;
			var value:String = data.value;
			var label:Label = dimBox.getChildByName("nameLabel") as Label;
			label.text = name;
			label = dimBox.getChildByName("valueLabel") as Label;
			label.text = value;
		}


		
		public static function CreatPageOb(StartIndex:int,EndIndex:int):Object
		{
			return {"nowPage":StartIndex,"maxPage":EndIndex};
		}
		
		public static function CreatPageText(ob:Object):String
		{
			return ob.nowPage + "\\" + ob.maxPage;
		}
		

		
		public static function CreartNextSoulLevelOb(nowExp:int,addExp:int,nowLevel:int,propSoul:*):Object
		{
			var result:Object;
			var costExp:int;
			addExp = addExp + nowExp;
			while( (addExp>=0)&& (nowLevel < propSoul.level) )
			{
				costExp = propSoul.upgradeNeedExper.baseExp + propSoul.upgradeNeedExper.growExp*(nowLevel - 1); 
				addExp = addExp - costExp;
				if(addExp>0)
				{
					nowLevel = (nowLevel + 1);					
				}
			}
			result = {"Level":nowLevel,"nowExp":(addExp + costExp) ,"MaxExp":(nowLevel<propSoul.level?costExp:0)};
			return result;
		}

		public static function randRange(min:Number, max:Number):Number
		{
			var randomNum:Number = Math.floor(Math.random() * (max - min + 1)) + min;
			return randomNum;
		}

		public static function get Rand():int
		{
			return (Math.random()>0.5?-1:1)
		}

		private static var colourList:Array = ["ffffff","047d00","0073b9","91007f","e34f00","fd0c0c","fd0c0c"];
		public static function addColourStr(str:String,quality:int = 1):String
		{
			var result:String;
			var colour:String = colourList[quality];
			var fontlist:Array = Font.enumerateFonts();
			var t:String = fontlist[0].fontName;
			result = "<font face='" + t + "'color='#" + colour + "'>" + str + "</font>";
			return result;
		}

		public static function showAni(view:*):void
		{
			if(view)
			{
				view.alpha=0;
				TweenLite.killTweensOf(view);
				TweenLite.to(view,0.7,{alpha:1});
			}
		}

		public static function hideAni(view:*,callBack:Function):void
		{
			view.alpha=1;
			TweenLite.killTweensOf(view);
			TweenLite.to(view,0.7,{alpha:0,onComplete:callBack});
		}


		public static function find(x:*,temDic:Dictionary):*
		{
			if(x!=temDic[x])
			{
				temDic[x] = find(temDic[x],temDic);
			}
			return temDic[x];
		}

		public static function union(x:*,y:*,temDic:Dictionary):void
		{
			var a:int = find(x,temDic);
			var b:int = find(y,temDic);
			if(a!=b)
			{
				temDic[b] = a;
			}
		}


	}
}