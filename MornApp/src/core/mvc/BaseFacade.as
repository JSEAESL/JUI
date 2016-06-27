package core.mvc
{
	/*
	*	by StevenZhai @ 2014.7.11
	*	
	* 	Facade 基础类,  游戏中Facade需要从此处继承
	*/

	import org.puremvc.as3.multicore.interfaces.IFacade;
	import org.puremvc.as3.multicore.patterns.facade.Facade;

	public class BaseFacade extends Facade implements IFacade
	{
		public function BaseFacade(key:String)
		{
			super(key);
		}

	}
}