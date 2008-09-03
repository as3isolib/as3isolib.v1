package isoLib.core.sceneGraph
{
	import eDpLib.events.EventDispatcherProxy;
	
	import flash.display.Sprite;
	
	public class Node extends EventDispatcherProxy implements INode
	{
		////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////////////
		
		public function Node ()
		{
			super();
			proxyTarget = container;
			
			createChildren();
		}
		
		////////////////////////////////////////////////////////////////////////
		//	ID
		////////////////////////////////////////////////////////////////////////
		
		static private var _IDCount:uint = 0;
		
		public const UID:uint = _IDCount++;
		protected var setID:String;
		
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
		//	RENDER
		////////////////////////////////////////////////////////////////////////
		
		public function render (recursive:Boolean = true):void
		{
			if (recursive && hasParent)
			{
				var child:INode;
				for each (child in children)
					child.render(recursive);
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	PARENT
		////////////////////////////////////////////////////////////////////////
		
		public function get hasParent ():Boolean
		{
			return parentNode? true: false;
		}
		
		protected var parentNode:INode;
		
		public function get parent():INode
		{
			return parentNode;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	DEPTH
		////////////////////////////////////////////////////////////////////////
		
		protected var nodeDepth:int = -1;
		
		public function get depth ():int
		{
			if (hasParent)
				return parent.container.getChildIndex(container);
			
			else
				return -1;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONTAINER
		////////////////////////////////////////////////////////////////////////
		
		protected var spriteContainer:Sprite;
		
		public function get container ():Sprite
		{
			if (!spriteContainer)
			{
				spriteContainer = new Sprite();
				spriteContainer.buttonMode = true;
			}
			
			return spriteContainer;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CHILD METHODS
		////////////////////////////////////////////////////////////////////////
		
		[ArrayElementType("isoLib.core.sceneGraph.INode")]
		protected var children:Array = [];
		
		public function get numChildren ():uint
		{
			return children.length;
		}
		
		protected function createChildren ():void
		{
			//will be overridden by subclasses
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
			container.addChildAt(child.container, index);
			
			children.push(child);
		}
		
		public function setChildIndex (child:INode, index:uint):void
		{
			if (child.hasParent)
			{
				var p:INode = child.parent;
				p.container.setChildIndex(child.container, index);
			}
		}
		
		public function removeChild (child:INode):INode
		{
			return removeChildByID(child.id);
		}
		
		public function removeChildAt (index:uint):INode
		{				
			var child:INode;
			if (index >= children.length)
				return null;
				
			else
				child = INode(children[index]);
				
			return removeChildByID(child.id);
		}
		
		public function removeChildByID (id:String):INode
		{
			var child:INode = getChildByID(id);
			if (child)
			{
				//remove child.container from parent's container
				container.removeChild(child.container);
				
				//remove parent ref
				Node(child).parentNode = null;
				
				//remove from children array
				var i:int;
				for (i; i < children.length; i++)
				{
					if (child == children[i])
					{
						children.splice(i, 1);
						break;
					}
				}
			}
			
			return child;
		}
		
		public function removeAllChildren ():void
		{
			var child:INode;
			for each (child in children)
			{
				container.removeChild(child.container);
				Node(child).parentNode = null;
			}
			
			children = [];
		}
		
		public function getChildByID (id:String):INode
		{
			var childID:String;
			var child:INode;
			for each (child in children)
			{
				childID = child.id;
				if (childID == id)
					return child;
			}
			
			return null;
		}		
	}
}