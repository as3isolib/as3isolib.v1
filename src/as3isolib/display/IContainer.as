package as3isolib.display
{
	import as3isolib.data.INode;
	
	import flash.display.Sprite;
	
	/**
	 * The IContainer interface defines the methods necessary for display visual content associated with a particular data node.
	 */
	public interface IContainer extends INode
	{
		//////////////////////////////////////////////////////////////////
		//	BOUNDS
		//////////////////////////////////////////////////////////////////
		
		
		
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