package core.scene
{
	/**
	 *  可被调整接口;
	 * 
	 */	
	public interface IResizeable
	{
		/**
		 *	所在区域变化时; 
		 * @param width
		 * @param height
		 * 
		 */		
		function resize(width:int,height:int):void;
		
	}
}