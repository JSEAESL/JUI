package jlib.old
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.FileFilter;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;

	public class JFile
	{

		public static function get creat():JFile
		{
			return new JFile();
		}

		static public const FILE_IMAGE:FileFilter=new FileFilter("图像文件(*.png;*.jpg)", "*.png;*.jpg");
		static public const FILE_ALL:FileFilter=new FileFilter("所有文件(*.*)", "*.*");
		static public const FILE_TEXT:FileFilter=new FileFilter("文本文件(*.txt)", "*.txt");

		static public const FILE_XML:FileFilter=new FileFilter("配置文件(*.xml)", "*.xml");
		static public const FILE_SWF:FileFilter=new FileFilter("动画文件(*.swf)", "*.swf");

		static public function get AppPath():String
		{
			return File.applicationDirectory.nativePath + "\\";
		}
		

		static public function getWebPath(_url:String):String
		{
			return _url.replace(AppPath, "");
		}
		

		public function JFile()
		{
		}
		private var _callFun:Function;
		private var _argArr:Array;
		private var _tyFi:FileFilter;
		private var _dirUrl:String;

		public function browDirectory(callfun:Function,typeFilter:FileFilter,dirUrl:String = null,title:String = "请选择文件夹", ...arg):File
		{
			_callFun = callfun;
			_argArr = arg;
			_tyFi = typeFilter;
			
			if(dirUrl && dirUrl.length == 0)
			{
				_dirUrl = String(JLocal.getLocal("lastOpen","JFile"));
			}
			
			var f:File = (_dirUrl && _dirUrl.length ?　File.applicationDirectory.resolvePath(_dirUrl) : new File() );
			f.browseForDirectory(title);
			
			if(callfun != null)
			{
				f.addEventListener(Event.SELECT,onOpenSelected);
			}
			
			return f;
		}
		
		public function browOpen(callFun:Function, typeFilter:FileFilter, dirUrl:String=null, title:String="请选择目标文件", ... arg):File
		{
			_callFun=callFun;
			_argArr=arg;
			_tyFi=typeFilter;
			
			if (dirUrl && dirUrl.length == 0)
			{
				_dirUrl=String(JLocal.getLocal("lastOpen", "JFile"));
			}

			var f:File=(_dirUrl && _dirUrl.length ? File.applicationDirectory.resolvePath(_dirUrl) : new File());
			f.browseForOpen(title, (typeFilter ? [typeFilter] : null));

			if (callFun != null)
			{
				f.addEventListener(Event.SELECT, onOpenSelected);
			}
			return f;
		}


		private function open(f:File, callFun:Function, format:FileFilter=null):File
		{
			this._callFun=_callFun;
			this._tyFi=format;
			var _fileStream:FileStream=new FileStream();
			_fileStream.addEventListener(Event.COMPLETE, onFileLoaded);
			//_fileStream.addEventListener(IOErrorEvent.IO_ERROR,	onFileError);
			_fileStream.openAsync(f, FileMode.READ);
			//	trace("open", _file.url);
			//_fileStream.close();
			
			return f;
		}

		private function onOpenSelected(e:Event):void
		{
			open(e.currentTarget as File, _callFun, _tyFi);
			JLocal.saveLocal("lastOpen", File(e.currentTarget).nativePath, "JFile");
		}

		private function onFileLoaded(e:Event):void
		{
			var _fileStream:FileStream=FileStream(e.currentTarget);
			var _byteArr:ByteArray=new ByteArray();
			_fileStream.readBytes(_byteArr, 0, _fileStream.bytesAvailable);
			_fileStream.close();
			var _loader:Loader;
			if (_callFun != null)
			{
				switch (_tyFi)
				{
					case FILE_IMAGE:
						_loader=new Loader();
						_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBytesLoaded);
						_loader.loadBytes(_byteArr);
						break;
					case FILE_SWF:
						_loader=new Loader();
						var _loaderContext:LoaderContext=new LoaderContext();
						//_loaderContext.allowCodeImport=true;
						_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onBytesLoaded);
						_loader.loadBytes(_byteArr, _loaderContext);
						//	_callFun.apply(null,	[_loader]);	
						break;
					case FILE_XML:
					case FILE_TEXT:
						_callFun.apply(null, [_byteArr.readUTFBytes(_byteArr.length)]);
						break;
					case FILE_ALL:
					default:
						_callFun.apply(null, [_byteArr]);
						break;
				}
			}

			function onBytesLoaded(evt:Event):void
			{
				evt.currentTarget.removeEventListener(Event.COMPLETE, onBytesLoaded);
				_callFun.apply(null, [_loader]);
			}
		}


		private var _data:ByteArray;
		public function saveAs(_data:ByteArray, _title:String = "请选择或输入保存的文件",	_callFun:Function	=	null,	_dirURL:String = ""):File {
			this._callFun	=	_callFun;
			this._data		=	_data;
			if (_dirURL.length == 0)	_dirURL	=	JLocal.getLocal("lastSave",	"JFile") as String;	//	取最后一次保储的记录
			var _file:File	=	(_dirURL && _dirURL.length?File.applicationDirectory.resolvePath(_dirURL):new File());
			_file.browseForSave(_title);
			_file.addEventListener(Event.SELECT,		onSaveSelected);
			return _file;
		}
		public function saveTo(_path:String, _data:ByteArray):void {
			var _fileSave:File			=	browURL(_path);
			var _fileStream:FileStream	=	new FileStream();
			_fileStream.open(_fileSave,	FileMode.WRITE);	//	openAsync(_fileSave, FileMode.WRITE);
			_fileStream.addEventListener(IOErrorEvent.IO_ERROR,	onFileError);
			_fileStream.writeBytes(_data, 0, _data.length);
			_fileStream.close();
			//	PDebug.add("PFile SaveTo", _path);
		}
		
		private function onSaveSelected(evt:Event):void {
			var _file:File	=	File(evt.currentTarget);
			save(_file, _data);
			JLocal.saveLocal("lastSave",	_file.nativePath,	"JFile")
			if (_callFun != null)	_callFun.apply(null,	[_file]);
			_callFun	=	null;
		}
		public function save(_file:File, _data:ByteArray):void {
			var _fileStream:FileStream	=	new FileStream();
			var _fileSave:File			=	new File(_file.url);
			_fileStream.open(_file, FileMode.WRITE);
			_fileStream.addEventListener(IOErrorEvent.IO_ERROR,	onFileError);
			_fileStream.writeBytes(_data, 0, _data.length);
			_fileStream.close();
		}
		

		public function browURL(_url:String):File {
			var _file:File	=	new File(File.applicationDirectory.resolvePath(_url).nativePath);	// .applicationDirectory.resolvePath(_url);
			return _file;
		}
		private function onFileError(e:IOErrorEvent):void
		{

		}
	}
}
