/**
 *
 *  You can modify and use this source freely
 *  only for the development of application related Live2D.
 *
 *  (c) Live2D Inc. All rights reserved.
 */
package jp.live2d.framework 
{
	public class Live2DFramework 
	{
		private static var platformManager:IPlatformManager;
		
		
		public static function setPlatformManager(mgr:IPlatformManager):void 
		{
			platformManager = mgr;
		}
		
		public static function getPlatformManager():IPlatformManager
		{
			return platformManager;
		}
	}

}