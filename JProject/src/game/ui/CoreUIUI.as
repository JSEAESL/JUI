/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class CoreUIUI extends View {
		public function CoreUIUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("CoreUI.xml");
		}
	}
}