package jlib.old
{
	import flash.utils.getTimer;

	public class JTimeUnti
	{
		public function JTimeUnti()
		{
		}
		
		public static var hours:int; 
		public static var minute:int; 
		public static var second:int; 
		
		public static function getDefTime(delay:uint):String
		{
			hours = delay/1000/60/60;
			minute = delay/1000/60%60;
			second = delay/1000%60;
			
			
			return ( getTimeStr(hours) + ":" + getTimeStr(minute) + ":" + getTimeStr(second) )
		}
		
		public static function getTimeStr(time:int):String	
		{
			if(time<10)
			{
				return "0"+ time.toString();
			}
			return time.toString();	
		}
		
		
		public static const aday:uint = 1000 * 60 * 60 * 24;
		public static const DateString:Array = ["今天","昨天","前天","三天前"]
		public static function getNowTime(/*nowDate:uint,*/serTime:int):String
		{
			
			var systTime:int = new Date().time;
			
			//var date:Date  = new Date().setDate( firstDate); 
			var dim:int = systTime - serTime;
			var num:int = dim/aday;
			trace(dim,num);
			if(num == 0)
			{
				return "在线"
			}
			if(num<1)
			{
				return DateString[0];
			}else if(num<2)
			{
				return DateString[1];
			}else if(num<3)
			{
				return DateString[2]
			}else 
			{
				return DateString[3]
			}
			
			
			return "计算日期错误";
		}
	}
}