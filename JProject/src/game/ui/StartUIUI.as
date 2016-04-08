/**Created by the Morn,do not modify.*/
package game.ui {
	import morn.core.components.*;
	public class StartUIUI extends View {
		public function StartUIUI(){}
		override protected function createChildren():void {
			super.createChildren();
			loadUI("StartUI.xml");
		}
	}
}