package core.mvc
{
	/*
	*	by StevenZhai @ 2014.7.11
	*	
	* 	控制层 - 单一Command基础类,  游戏中所有的 单一Command需要从此处继承
	*/

	import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

	public class BaseSimpleCommand extends SimpleCommand
	{
		public function BaseSimpleCommand()
		{
			super();
		}

		public function onlyRegProxy(Cls:Class):Boolean
		{
			if( facade.retrieveProxy(Cls.NAME) == null )
			{
				facade.registerProxy( new Cls(null) );
				return true
			}
			return false
		}
	}
}