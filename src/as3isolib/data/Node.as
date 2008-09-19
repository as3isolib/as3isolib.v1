package as3isolib.data
{
	import eDpLib.events.EventDispatcherProxy;
	
	public class Node extends EventDispatcherProxy implements INode
	{
		////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////////////
		
		public function Node ()
		{
			super();
		}
		
		////////////////////////////////////////////////////////////////////////
		//	ID
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		static private var _IDCount:uint = 0;
		
		/**
		 * @private
		 */
		public const UID:uint = _IDCount++;
		
		/**
		 * @private
		 */
		protected var setID:String;
		
		/**
		 * @private
		 */
		public function get id ():String
		{
			return (setID == null || setID == "")?
				"Node" + UID.toString():
				setID;
		}
		
		public function set id (value:String):void
		{
			setID = value;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	PARENT
		////////////////////////////////////////////////////////////////////////
		
		public function get hasParent ():Boolean
		{
			return parentNode? true: false;
		}
		
		/**
		 * @private
		 */
		protected var parentNode:INode;
		
		public function get parent():INode
		{
			return parentNode;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	ROOT NODE
		////////////////////////////////////////////////////////////////////////
		
		public function getRootNode ():INode
		{
			var p:INode = this;
			while (p.hasParent)
				p = p.parent;
			
			return p;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CHILD METHODS
		////////////////////////////////////////////////////////////////////////
		
		public function contains (value:INode):Boolean
		{
			if (value.hasParent)
				return value.parent == this;
			
			else
			{
				var child:INode;
				for each (child in childrenArray)
				{
					if (child == value)
						return true;
				}
				
				return false;
			}
		}
		
		/**
		 * @private
		 */
		[ArrayElementType("as3isolib.core.sceneGraph.INode")]
		private var childrenArray:Array = [];
		
		public function get children ():Array
		{
			return childrenArray.slice(); //return a copy not the actual array
		}
		
		public function get numChildren ():uint
		{
			return childrenArray.length;
		}
		
		public function addChild (child:INode):void
		{
			addChildAt(child, numChildren);
		}
		
		public function addChildAt (child:INode, index:uint):void
		{
			//if it already exists here, do nothing
			if (getChildByID(child.id))
				return;
				
			//if it has another parent, then remove it there
			if (child.hasParent)
			{
				var parent:INode = child.parent;
				parent.removeChildByID(child.id);
			}
			
			Node(child).parentNode = this;
			childrenArray.push(child);
		}
		
		public function getChildAt (index:uint):INode
		{
			if (index >= numChildren)
				throw new Error("");
			
			else
				return INode(childrenArray[index]);
		}
		
		public function getChildIndex (child:INode):int
		{
			var i:int;
			while (i < numChildren)
			{
				if (child == childrenArray[i])
					return i;
				
				i++;
			}
			
			return -1;
		}
		
		public function setChildIndex (child:INode, index:uint):void
		{
			var i:int = getChildIndex(child);
			if (i > -1)
			{
				childrenArray.splice(i, 1); //remove it form the array
				
				//now let's check to see if it really did remove the correct choice - this may not be necessary but I get OCD about crap like this
				var c:INode;
				var notRemoved:Boolean = false;
				for each (c in childrenArray)
				{
					if (c == child)
						notRemoved = true;
				}
				
				if (notRemoved)
				{
					throw new Error("");
					return;
				}
				
				if (index >= numChildren)
					childrenArray.push(child);
				
				else
					childrenArray.splice(index, 0, child);
			}
			
			else
				throw new Error("");
		}
		
		public function removeChild (child:INode):INode
		{
			return removeChildByID(child.id);
		}
		
		public function removeChildAt (index:uint):INode
		{				
			var child:INode;
			if (index >= numChildren)
				return null;
				
			else
				child = INode(childrenArray[index]);
				
			return removeChildByID(child.id);
		}
		
		public function removeChildByID (id:String):INode
		{
			var child:INode = getChildByID(id);
			if (child)
			{
				//remove parent ref
				Node(child).parentNode = null;
				
				//remove from children array
				var i:int;
				for (i; i < childrenArray.length; i++)
				{
					if (child == childrenArray[i])
					{
						childrenArray.splice(i, 1);
						break;
					}
				}
			}
			
			return child;
		}
		
		public function removeAllChildren ():void
		{
			var child:INode;
			for each (child in childrenArray)
				Node(child).parentNode = null;
			
			childrenArray = [];
		}
		
		public function getChildByID (id:String):INode
		{
			var childID:String;
			var child:INode;
			for each (child in childrenArray)
			{
				childID = child.id;
				if (childID == id)
					return child;
			}
			
			return null;
		}		
	}
}