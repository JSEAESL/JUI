package core.mvc
{
	/*
	*	by StevenZhai @ 2014.7.11
	*	
	* 	数据层 - Proxy 基础类,  游戏中所有的 proxy 需要从此处继承
	*/

	import org.puremvc.as3.multicore.interfaces.IProxy;
	import org.puremvc.as3.multicore.patterns.proxy.Proxy;

	public class BaseProxy extends Proxy implements IProxy
	{
		public function BaseProxy(proxyName:String=null, data:Object=null)
		{
			super(proxyName, data);
		}

	}
}