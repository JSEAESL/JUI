package jlib.load.slow
{
	import com.adobe.protocols.dict.Dict;
	
	import flash.display.Loader;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import jlib.I.CashManager;
	import jlib.old.JStrUnti;
	import jlib.unit.JXmlUnit;

	public class JLoadMgr
	{
		private static var _instance:JLoadMgr
		
		public static function get instance():JLoadMgr
		{
			if (_instance == null)
			{
				_instance=new JLoadMgr(new instanceClass());
			}
			
			return _instance;
		}
		private var listLoad:JListLoad;
		private var _finishBackDic:Dictionary;
		private var _finishBack:Function
		
		public function JLoadMgr(insClass:instanceClass)
		{
			_finishBackDic = new Dictionary();
			
			listLoad = JListLoad.creat();
		}
		
		public function addFileToList(path:String,key:String,callBack:Function = null):void
		{
			listLoad.addFile(path,key,swfLoad);
		}
		
		public function setAllComFun(fun:Function):void
		{
			listLoad.setComFun(fun);	
		}
		
		public function startListLoad():void
		{
			listLoad.toLoad();
		}
		
		
		
		
		public function addFile(path:String, callBack0:Function=null, callback1:Function=null):void
		{
			_path=path;
			_proBack=callBack0;
			_finishBack=callback1;
		}
		
		
		
		private var _path:String;
		
		
		
		private var _proBack:Function;
		
		
		
		
		public function loadPic(url:String,callBack:Function):void
		{
			JLoad.creat().toLoad(url,callBack);
		}
		
		private var _loadCount:int = 0;
		public function loadSwf(url:String,callBack:Function = null):void
		{
			JLoad.creat().toLoad(url,swfLoad)
			_loadCount++
			var name:String = JStrUnti.getDimStr(url);
			if(callBack)
			{
				_finishBackDic[name] = callBack				
			}
			//_finishBack = callBack;
		}
		
		
		
		private function hasDic(key:String):Boolean
		{
			if(_finishBackDic[key] !=null)
			{
				return true;
			}
			return false
		}
		
		
		
		
		private function swfLoad(load:JloaderDeco):void
		{
			
			var name:String = load.key;
			CashManager.instance.addCash(name,load.contentLoaderInfo.applicationDomain);
			_loadCount--;
			if(_loadCount == 0)
			{
				if(_finishBackDic[name])
				{
					_finishBackDic[name].apply();
				}
			}
		}
		
		private var delayTime:Timer = new Timer(1000)
		
		private function delayTimeFunction(fun:Function,...arg):void
		{
			delayTime.addEventListener(TimerEvent.TIMER,toDelayFunction);	
			delayTime.start()
		}
		
		private function toDelayFunction(e:TimerEvent):void
		{
			if(_loadCount == 0)
			{
				for each(var f:Function in _finishBackDic)
				{
					f.apply();
				}
				delayTime.stop();
			}
			
		}
		
		
		
		public function loadObject():void
		{
			
		}
		
		
		
		public function toNext():void
		{
			
		}
		
		private function toLoadPath():void
		{
			
		}
		
		private function toLoadPathList():void
		{
			
		}
	}
}

class instanceClass
{
}

