/**Created by the Morn,do not modify.*/
package mornUI.PicCreat {
	import morn.core.components.*;
	public class PicCreatViewUI extends View {
		public var dragImage:Image = null;
		public var btnBox:Box = null;
		public var coreView:Box = null;
		public var picBox:Box = null;
		public var pic:Image = null;
		public function PicCreatViewUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("PicCreat/PicCreatView.xml");
		}
	}
}