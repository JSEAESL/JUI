package jlib.old
{
	import flash.utils.ByteArray;

	public class Jbytes
	{
		public function Jbytes()
		{
		}
		
		static public function StringToBytes(_str:String,	_len:uint = 0):ByteArray {
			var _bytes:ByteArray	=	new ByteArray();
			_bytes.writeUTFBytes(_str);
			if (_len)	_bytes.length	=	_len;
			_bytes.position	=	0;
			return _bytes;
		}
	}
}