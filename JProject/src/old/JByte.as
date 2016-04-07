package old 
{
	import flash.utils.ByteArray;

	public class JByte
	{
		public function JByte()
		{
		}
		
		public static function Byte_TO_String(ob:ByteArray):String
		{
			var len:uint = ob.readUnsignedShort();
			var str:String = ob.readUTFBytes(len);
			return str;
		}
		
		static public function StringToBytes(_str:String,	_len:uint = 0):ByteArray {
			var _bytes:ByteArray	=	new ByteArray();
			_bytes.writeUTFBytes(_str);
			if (_len)	_bytes.length	=	_len;
			_bytes.position	=	0;
			return _bytes;
		}
		
		public static function read8Byte(ob:ByteArray):Number
		{
			var value:Number;
			value = ob.readUnsignedInt();
			value += ob.readUnsignedInt() * 0x100000000;
			return value;	
		}
		
		public static function ASC16TO_Int(str:String):int
		{
			return parseInt("0x" + str);
		}
		
		public static function ASC16To_Bytes(str:String):ByteArray
		{
			var arr:Array = str.split(" ");
			var byte:ByteArray  = new ByteArray()
			while(arr.length)
			{
				var INT:int = ASC16TO_Int(arr.unshift() as String);
				byte.writeByte(INT)
			}
			byte.position = 0;
			return byte;
		}
	}
}