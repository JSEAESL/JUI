package jlib.old
{
	public class CVSencode
	{
		public function CVSencode()
		{
		}
		
		public static var keyArr:Array = [];
		public static function encode(dim:String):Array
		{
			var result:Array = [];
			var dimArr:Array = dim.split(String.fromCharCode(13));
			dimArr.pop();
			dimArr.shift();
			keyArr = getKEY(dimArr.shift());
			
			var o:Object = new Object();
			while(dimArr.length >0)
			{
				
				result.push( getOBJECT(o, getKEY(dimArr.shift()) ,keyArr.length) )
			}
			
			
			return dimArr
		}
		
		private static function getKEY(dim:String):Array
		{
			var result:Array = [];
			result = dim.split(",");
			result = parse(result);
			return result;
		}
		
		private static function parse(dim:Array):Array
		{
			for(var i:int = 0; i<dim.length; i++)
			{
				var str:String = dim[i];
				str =	str.replace("\n","");				
				dim[i] = str;
			}
			return dim;
		}
		
		private static function getOBJECT(o:Object,dim:Array,len:int):Object
		{
			
			for(var i:int = 0; i<len; i++)
			{
				if(dim[i])
				{
					o[keyArr[i]] = dim[i];
				}else
				{
					o[keyArr[i]] = "";
					continue;
				}
			
			}
				
				
			return o;
		}
	}
}