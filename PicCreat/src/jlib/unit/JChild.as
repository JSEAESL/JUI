package jlib.unit
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;

	public class JChild
	{
		public function JChild()
		{
		}
		
		public static function addToFather(dim:DisplayObject,father:Sprite,x:int = 0,y:int = 0):void
		{
			dim.x = x;
			dim.y = y;
			father.addChild(dim);
		}
		
		public static function removeDim(dim:*):void
		{
			
			if(dim.parent)
			{
				dim.parent.removeChild(dim);
			}
		}
			
	}
}