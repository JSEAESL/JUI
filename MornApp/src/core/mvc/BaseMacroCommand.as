package core.mvc
{
	/*
	*	by StevenZhai @ 2014.7.11
	*	
	* 	控制层 - 复合Command基础类,  游戏中所有的 复合Command需要从此处继承
	*/

	import org.puremvc.as3.multicore.interfaces.ICommand;
	import org.puremvc.as3.multicore.patterns.command.MacroCommand;

	public class BaseMacroCommand extends MacroCommand implements ICommand
	{
		public function BaseMacroCommand()
		{
			super();
		}
	}
}