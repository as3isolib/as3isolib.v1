package isoLib.core.sceneGraph
{
	import flash.events.IEventDispatcher;
	
	public interface INode extends IEventDispatcher
	{
		////////////////////////////////////////////////
		//	ID
		////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get id ():String;
		
		/**
		 * The identifier string.
		 */
		function set id (value:String):void;
		
		////////////////////////////////////////////////
		//	PARENT
		////////////////////////////////////////////////
		
		/**
		 * The parent INode within the node heirarchy structure.
		 */
		function get parent ():INode;
		
		/**
		 * A flag indicating if this INode has a parent node.
		 */
		function get hasParent ():Boolean;
		
		function getRootNode ():INode;
		
		////////////////////////////////////////////////
		//	CHILD METHODS
		////////////////////////////////////////////////
		
		/**
		 * Indicates how many child nodes fall underneath this node within a particular heirarchical structure.
		 */
		function get numChildren ():uint;
		
		/**
		 * Adds a child at the end of the display list.
		 * 
		 * @param child The INode to add this node's heirarchy.
		 */
		function addChild (child:INode):void;
		
		/**
		 * Adds a child to the display list at the specified index.
		 * 
		 * @param child The INode to add this node's heirarchy.
		 * @param index The target index to add the child.
		 */
		function addChildAt (child:INode, index:uint):void;
		
		/**
		 * Returns the index of a given child node or -1 if the child doesn't exist within the node's hierarchy.
		 * 
		 * @param child The INdode whose index is to be retreived.
		 * @return int The child index or -1 if the child's parent is null.
		 */
		function getChildIndex (child:INode):int;
		
		/**
		 * Removes the specified child.
		 * 
		 * @param child The INode to remove from the children hierarchy.
		 * @return INode The child that was removed.
		 */
		function removeChild (child:INode):INode;
		
		/**
		 * Removes the child at the specified index.
		 * 
		 * @param index The INode's index to remove from the children hierarchy.
		 * @return INode The child that was removed.
		 */
		function removeChildAt (index:uint):INode;
		
		/**
		 * Removes the child with the specified id.
		 * 
		 * @param id The INode's id to remove from the children hierarchy.
		 * @return INode The child that was removed.
		 */
		function removeChildByID (id:String):INode;
		
		/**
		 * removes all child INodes.
		 */
		function removeAllChildren ():void;
	}
}