package jlib.JAni
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class JBitFrameCase extends Sprite
	{
		private var bitmap:Bitmap;
		private var nowBitData:BitmapData;
		private var caseFrameList:Vector.<BitmapData>
		private var nowIndex:int;
		private var maxIndex:int;
		public var pause:Boolean = true;
		//private static const map_data:Object = {};
		public function JBitFrameCase()
		{
			super();
			initClass();
		}
		
		private function initClass():void
		{
			bitmap = new Bitmap();
			
			addChild(bitmap);
		}
		
		public function setCaseList(caselist:Vector.<BitmapData>):void
		{
			caseFrameList = caselist;
			if(caseFrameList)
			{
				nowIndex = 0;
				maxIndex = caseFrameList.length - 1;
			}
			timerAction();
		}
		
		public function timerAction():void
		{
			if(!pause)
			{
				Play(nowIndex + 1)
			}
		}
		
		private var tRect:Rectangle;
		private function Play(index:int):void
		{
			nowIndex = index;
			if(nowIndex>maxIndex)
			{
				nowIndex = maxIndex
			}else if(nowIndex<0)
			{
				nowIndex = 0;
			}
			if (tRect == null)
			{
				tRect = new Rectangle(0,0,caseFrameList[nowIndex].width,caseFrameList[nowIndex].height)
				nowBitData = new BitmapData(caseFrameList[nowIndex].width,caseFrameList[nowIndex].height)
				bitmap.bitmapData = nowBitData
			}
			nowBitData.lock();
			nowBitData.copyPixels(caseFrameList[nowIndex],tRect,new Point(0,0))
			nowBitData.unlock();	

			if(nowIndex == maxIndex)
			{
				nowIndex = 0;
			}
		}
		


	}
}