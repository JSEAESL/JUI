package jlib.old
{
	import flash.net.SharedObject;
	import flash.system.Security;
	import flash.system.SecurityPanel;

	public class JLocal
	{
		
		public static const J_SEA:String = "J_SEAES_L"
		public function JLocal()
		{
		}
		
		public static function saveLocal(key:String,data:Object,dim:String = J_SEA,localPath:String = null ):void
		{
			var so:SharedObject = SharedObject.getLocal(dim,localPath);
			so.data[key] = data;
		}
		
		public static function cleanLocal(dim:String = J_SEA):void
		{
			var so:SharedObject = SharedObject.getLocal(dim);
			so.clear();
		}
		
		public static function getLocal(key:String,dim:String = J_SEA,localPath:String = null ):Object
		{
			var so:SharedObject = SharedObject.getLocal(dim,localPath);
			if(so.size > 0)
			{
			return so.data[key];				
			}
			return null;
		}
		
		//显示“Flash Player 设置”中的“摄像头”面板
		public static function CAMERRA_SETTING():void
		{
			flash.system.Security.showSettings(SecurityPanel.CAMERA);
		}
		
		//显示“Flash Player 设置”中的“本地存储设置”面板。
		public static function LOCALSTORAGE_SETTING():void
		{
			flash.system.Security.showSettings(SecurityPanel.LOCAL_STORAGE);
		}
		
		//显示“Flash Player 设置”中的“麦克风”面板。
		public static function MICROPHONE_SETTING():void
		{
			flash.system.Security.showSettings(SecurityPanel.MICROPHONE);
		}
		
		//显示“Flash Player 设置”中的“隐私设置”面板。
		public static function PRIVACY_SETTING():void
		{
			flash.system.Security.showSettings(SecurityPanel.PRIVACY);
		}
		
		//显示“设置管理器”(在一个单独的浏览器窗口中)。
		public static function SETTINGS_MANAGER():void
		{
			flash.system.Security.showSettings(SecurityPanel.SETTINGS_MANAGER);
		}
	}
}