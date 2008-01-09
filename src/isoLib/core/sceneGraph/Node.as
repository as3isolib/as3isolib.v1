package isoLib.core.sceneGraph
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.display.Sprite;

	public class Node extends EventDispatcher implements INode
	{
		////////////////////////////////////////////////////////////////////////
		//	ID
		////////////////////////////////////////////////////////////////////////
		
		private static var _IDCount:uint = 0;
		
		public const UID:uint = _IDCount++;
		protected var setID:String;
		
		public function get id ():String
		{
			return (setID == null || setID == "")?
				UID.toString():
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
			if (recursive)
			{
				var child:INode;
				for each (child in children)
					child.render();
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
		//	CONTAINER
		////////////////////////////////////////////////////////////////////////
		
		protected var spriteContainer:Sprite;
		
		public function get container ():Sprite
		{
			if (!spriteContainer)
				spriteContainer = new Sprite();
				
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
		
		public function addChild (child:INode):void
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
			
			container.addChild(child.container);
			children.push(child);
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