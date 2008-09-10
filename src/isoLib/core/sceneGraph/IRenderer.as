package isoLib.core.sceneGraph
{
	import flash.display.Sprite;
	
	import isoLib.bounds.PrimitiveBounds;
	
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