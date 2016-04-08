/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class EndUIUI extends View {
		public function EndUIUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("EndUI.xml");
		}
	}
}