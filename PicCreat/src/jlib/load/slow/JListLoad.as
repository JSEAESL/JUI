package jlib.load.slow
{
	import com.adobe.protocols.dict.Dict;
	
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLStream;
	import flash.utils.Dictionary;
	
	import jlib.jevent.JEvent;
	import jlib.load.JURLloader;
	import jlib.old.JStrUnti;

	public class JListLoad
	{
		
		public static function creat():JListLoad
		{
			return new JListLoad();
		}
		
		
		public function JListLoad()
		{
			_finishFunctionDic=new Dictionary();
			_pathList=new Dictionary();
			_proFunctionDic=new Dictionary();
			_keyList = [];
		}
		
		private var _finishFunctionDic:Dictionary;
		private var _pathList:Dictionary;
		private var _proFunctionDic:Dictionary;
		
		private var _keyList:Array;
		
		private var AllComPleteFun:Function;
		
		private var _count:int = 0;
		public function addFile(path:String, key:String, callBack:Function=null):void
		{
			
			if ( !has(key) )
			{
				_keyList.push(key);
				_pathList[key]=path;
				_finishFunctionDic[key]=callBack;
				_count++;
			}
			trace("已经加载KEY")
		}
		
		private var hasComFun:Boolean = false
		public function setComFun(fun:Function):void
		{
			AllComPleteFun = fun;
			hasComFun = true;
		}
		
		public function deleteFile(key:String):void
		{
			if( has(key) )
			{
				_pathList[key] = null;
				delete  _pathList[key];
				_finishFunctionDic[key] = null;
				delete  _finishFunctionDic[key];
				
				var index:int = _keyList.indexOf(key);
				_keyList.splice(index,1);
			}
		}
		
		private function has(key:String):Boolean
		{
			if (_pathList[key])
			{
				return true;
			}
			return false;
		}
		
		public function toLoad():void
		{
			
			while(_keyList.length)
			{
				var key:String = _keyList.shift();
				if(has(key))
				{
					load(key);
				}
			}
			
		}
		
		private function load(key:String):void
		{
			var load:JUrload =  JUrload.creat()
			load.toLoad(_pathList[key],null,JUrload.BINARY);
			load.addEventListener(JEvent.LOAD_COMPELETE,onCompleteF)
		}
		
		
		private function onCompleteF(e:JEvent):void
		{
			var name:String = JStrUnti.getDimStr(e.target.url);
			var urlLoad:URLLoader = e.data;
			
			var load:JLoad = JLoad.creat()
			load.toLoadBytes(urlLoad.data,_finishFunctionDic[name],name);
			load.addEventListener(JEvent.LOAD_COMPELETE,onCompleteT)
		}
		
		private function onCompleteT(e:JEvent):void
		{
			_count--
			if(_count == 0 && AllComPleteFun )
			{
				AllComPleteFun.apply();
			}
		}
		
	}
}
