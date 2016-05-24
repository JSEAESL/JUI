package jlib.old
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.utils.Dictionary;

	public class JkeyUnit
	{

		private static var _instance:JkeyUnit;

		public static function get instance():JkeyUnit
		{
			if (_instance == null)
			{
				_instance=new JkeyUnit(new instanceClass())
			}
			return _instance;
		}

		public function JkeyUnit(intClass:instanceClass)
		{
		}

		private var _stage:Stage;


		public function init(stage:Stage):void
		{
			this._stage=stage;
		
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onDown);
			_stage.addEventListener(Event.ENTER_FRAME,onEnter);
		}

		private  const keys:Array=[KeyStr.str1,KeyStr.str2,KeyStr.str3,KeyStr.str4,KeyStr.str5,KeyStr.str6,KeyStr.str7]; 
		private  const funs:Array	=	[str,str,str,str,str,str,str];

		private var dimArr:Array = [];
		private function onDown(e:KeyboardEvent):void
		{
			
			var keyCode:uint = e.keyCode
			trace(KeyboardKey.codeToString(keyCode));
			if (dimArr.length>0)
			{
				for(var i:int = 0; i< dimArr.length; i++)
				{
					var o:Object = dimArr[i];
					trace((keys[o.index] as Array).length, o.charIndex);
					if( expCode(o.index,o.charIndex,keyCode) )
					{
						o.charIndex++;
						if((keys[o.index] as Array).length > o.charIndex)
						{
							
							trace((keys[i] as Array).length,o.charIndex)
							//trace(keys[o.index][o.charIndex])
							dimArr[i] = o;
						}else
						{
							callFun(o.index);
							break;
						}
					}else
					{	
					 dimArr.splice(i,1);
					 i--;
					}
				}
			}

		
			
			
			for(var i:int = 0;i<keys.length; i++)
			{
				//trace(KeyboardKey.stringToCode(keys[i][0]) ,keyCode) 
				if(expCode(i,0,keyCode))
				{
					if((keys[i] as Array).length > 1)
					{
						var o:Object = new Object();
						o.charIndex = 1;
						o.index = i;
						dimArr.push(o);	
					}else
					{
						callFun(i);
					}
					
				}
			}

		}
		
		private var dely:int = 0;
		private function onEnter(e:Event):void
		{
			if(dely < 10)
			{
				dely++;
				
			}else
			{
				traceStr();
				dely = 0;
			}
			//trace(dely)
		}
		
		private function callFun(index:int,...arg):void
		{
			(funs[index] as Function).call(null,index);
			dimArr = [];
		}
		
		private function expCode(index:int,charindex:int,code:uint):Boolean
		{
			trace(keys[index])
			trace(keys[index][charindex])
			if( KeyboardKey.stringToCode( keys[index][charindex] ) == code )
			{
				return true;
			}
			return false;
		}
	
		private var strArr:Array = [];
		private function str(i:int):void
		{
			//trace(  (i + 1) + "组合键成功" );
			var str:String  = (i + 1) + "组合键成功";
			strArr.push(str);
		}
		
		private function traceStr():void
		{
			var len:int = strArr.length;
			
			for(var i:int = 0; i<len; i++)
			{
				trace(strArr[i]);
			}
			strArr = [];
				
			
		}

	}
}

class instanceClass
{
}
