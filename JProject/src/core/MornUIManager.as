package core {
	import BaseRes.JBaseResManager;
	import BaseRes.JResXmlCache;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import morn.core.handlers.Handler;
	public class MornUIManager
	{
		private static var _ins:MornUIManager;
		private var windowUI:Sprite;
		public static function getInsance():MornUIManager
		{
			if(null == _ins)
			{
				_ins = new MornUIManager()
			}
			return _ins;
		}

		public function MornUIManager()
		{
			loadedDic = new Dictionary();
		}

		
		public function init(main:Sprite,loadComplete:Function):void
		{
			Config.uiPath = JBaseResManager.creatTureUrl("assets/ui.swf");
			App.init(main);


			var loadUrlList:Array = [];
			//加载资源
			var ob:Object = JResXmlCache.Instance.getConfigBykey("MornUI");
			for each(var i:Object in ob.res)
			{

				loadUrlList.push(JBaseResManager.creatTureUrl(i.url));
			}
			App.loader.loadAssets(loadUrlList,
								new Handler(loadComplete)
									);
		}

		private  var loadedDic:Dictionary;
		public function loadSwf(swf:String,complete:Function):void
		{
			if(!loadedDic[swf])
			{
				App.loader.loadAssets([JBaseResManager.creatTureUrl(swf)],
						new Handler(complete));
				//new Handler(progressFun));
			}
			else
			{
				complete.apply();
				//trace("loadSwf:发现重复Swf加载路径 请检查配置" + swf )
			}
		}


		public function saveDic(url:String):void
		{
			loadedDic[url] = url;
		}

		private function getResUrl(url:String):String
		{
			return "";
		}


	}
}