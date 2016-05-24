package jlib.load
{
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.net.ObjectEncoding;
	import flash.system.ApplicationDomain;
	import flash.utils.ByteArray;
	import jlib.old.CVSencode;
	import jlib.old.JFile;
	import jlib.old.JStrUnti;
	import jlib.old.ResManager;
	import jlib.jevent.JEvent;
	public class Jload
	{
		private static var _arg:Array;

		private static var _encoding:String="utf8";
		private static var _fun:Function;


		private static var _isClass:Boolean=true;

		private static var _url:String;

		public static function URLload(url:String, _callFun:Function=null, DataFormat:String=null, toload:Boolean=false, ... arg):void
		{
			var urlLoad:JURLloader=new JURLloader(url);
			_url=url;
			_fun=_callFun;
			//_arg = arg
			if (DataFormat)
			{
				urlLoad.toLoad(DataFormat);
			}
			else
			{
				urlLoad.toLoad();
			}

			if (toload)
			{
				urlLoad.addEventListener(JEvent.LOAD_COMPELETE, onJsea);
			}
			else
			{
				urlLoad.addEventListener(JEvent.LOAD_COMPELETE, next);
			}
		}

		public static function URLloadToLoadByte(byte:ByteArray):void
		{
			var load:Jloader=new Jloader();
			load.toLoadBy(byte);
			load.addEventListener(JEvent.LOAD_COMPELETE, next);
		}

		public static function encodeCVS(data:ByteArray):void
		{
			var resultStr:String=data.readMultiByte(data.length, _encoding);
			var resultArr:Array=CVSencode.encode(resultStr);

			var dataBy:ByteArray=new ByteArray();
			dataBy.objectEncoding=ObjectEncoding.AMF3;
			dataBy.writeObject(resultArr);
			dataBy.compress();



			var resultUrl:String=JStrUnti.replaceSuffixStr(_url, "oo");

			JFile.creat.saveTo(resultUrl, dataBy);
		}



		public static function loadPic(url:String, o:Function):void
		{
			var picload:PicLoader=new PicLoader(url);
			_url=url;
			_fun=o;
			picload.toLoad();
			picload.addEventListener(JEvent.LOAD_COMPELETE, onLoadPicComplete);
		}

		public static function loadSwf(url:String, o:Function=null, isClass:Boolean=true):void
		{
			_isClass=isClass;
			var swfload:SwfLoader=new SwfLoader(url, isClass);
			_url=url;
			_fun=o;
			swfload.toLoad();
			if (isClass)
			{
				swfload.addEventListener(JEvent.LOAD_COMPELETE, onLoadSwfComplete);
			}
			else
			{
				swfload.addEventListener(JEvent.LOAD_COMPELETE, onLoadNomSwfComplete);
			}
		}





		private static function next(e:JEvent):void
		{
			if (_fun)
			{
				_fun.call(null, e.data);
			}
		}

		private static function onJsea(e:JEvent):void
		{

			URLloadToLoadByte(e.data);
		}

		private static function onLoadNomSwfComplete(e:JEvent):void
		{
			var load:Loader=e.data;


			//var key:String = JStrUnti.getUrlLastStr(_url);
			//var type:String = JStrUnti.getUrlSuffixStr(_url);
			//ResManager.instance.setRes(type,key,applican);
			if (_fun)
			{
				_fun.call(null, load);
			}
		}

		private static function onLoadPicComplete(e:JEvent):void
		{

			var pic:Bitmap=new Bitmap();
			pic.bitmapData=(e.data as Bitmap).bitmapData;

			if (_fun)
			{
				_fun.call(null, pic);
			}
		}

		private static function onLoadSwfComplete(e:JEvent):void
		{

			var applican:ApplicationDomain=e.data;


			var key:String=JStrUnti.getUrlLastStr(_url);
			var type:String=JStrUnti.getUrlSuffixStr(_url);
			ResManager.instance.setRes(type, key, applican);
			if (_fun)
			{
				_fun.apply(null, null);
			}
		}

		public function Jload()
		{
		}
	}
}
