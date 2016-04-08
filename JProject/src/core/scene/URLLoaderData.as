package core.scene
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class URLLoaderData extends URLLoader
	{
		public var key:String;
		public function URLLoaderData(request:URLRequest=null)
		{
			super(request);
		}
	}
}