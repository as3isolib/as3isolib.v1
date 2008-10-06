package as3isolib.data
{
	import eDpLib.events.IEventDispatcherProxy;
	
	public interface INode extends IEventDispatcherProxy
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
		//	DATA
		////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get data ():Object;
		
		/**
		 * A generic data storage property.
		 */
		function set data (value:Object):void;
		
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
		
		/**
		 * Retrieves the top-most INode within this node hierarchy.
		 * 
		 * @returns INode The top-most INode.
		 */
		function getRootNode ():INode;
		
		/**
		 * Retrieves the furthest descendant nodes within the node hierarchy.
		 * 
		 * @param includeBranches Flag indicating that during each point of recursion adds descendant nodes.  If false, only leaf nodes are returned.
		 * @return Array A flat array consisting of all possible descendant nodes.
		 */
		function getDescendantNodes (includeBranches:Boolean = false):Array;
		
		////////////////////////////////////////////////
		//	CHILD METHODS
		////////////////////////////////////////////////
		
		/**
		 * Determines if a particular INodes is an immediate child of this INode.
		 * 
		 * @param value The INode to check for.
		 * @returns Boolean Returns true if this INode contains the given value as a child INode, false otherwise.
		 */
		function contains (value:INode):Boolean;
		
		/**
		 * An array representing the immediate child INodes.
		 */
		function get children ():Array;
		
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
		 * Returns the child node at the given index.
		 * 
		 * @param index The index of the child to retrieve.
		 * @returns INode The child at the given index.
		 */
		function getChildAt (index:uint):INode;
		
		/**
		 * Returns the child node with the given id.
		 * 
		 * @param id The id of the child to retrieve.
		 * @returns INode The child at with the given id.
		 */
		function getChildByID (id:String):INode;
		
		/**
		 * Moves a child node to the provided index
		 * 
		 * @param child The child node whose index is to be changed.
		 * @param index The destination index to move the child node to.
		 */
		function setChildIndex (child:INode, index:uint):void;
		
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