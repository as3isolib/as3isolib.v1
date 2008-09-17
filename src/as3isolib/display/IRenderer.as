package as3isolib.display
{
	import flash.display.Sprite;
	
	public interface IRenderer
	{
		//////////////////////////////////////////////////////////////////
		//	CONTAINER
		//////////////////////////////////////////////////////////////////
		
		/**
		 * The sprite that contains the visual assets.
		 */
		function get container ():Sprite;
		
		//////////////////////////////////////////////////////////////////
		//	RENDER
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Initiates the various validation processes in order to display the IPrimitive.
		 * 
		 * @param recursive If true will tell child nodes to render through the display list.
		 */
		function render (recursive:Boolean = true):void;
	}
}