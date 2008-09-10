package isoLib.core
{
	import flash.display.DisplayObjectContainer;
	import flash.geom.Rectangle;
	
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.IRenderer;
	import isoLib.core.sceneGraph.IsoContainer;
	import isoLib.core.sceneGraph.Node;
	import isoLib.core.shape.IPrimitive;
	
	use namespace isolib_internal;
	
	public class IsoScene extends IsoContainer implements IRenderer
	{		
		///////////////////////////////////////////////////////////////////////////////
		//	HOST CONTAINER
		///////////////////////////////////////////////////////////////////////////////
		
		protected var host:DisplayObjectContainer;		
		
		public function get hostContainer ():DisplayObjectContainer
		{
			return host;
		}
		
		public function set hostContainer (value:DisplayObjectContainer):void
		{
			if (value && host != value)
			{
				if (host && host.contains(container))
					host.removeChild(container);
				
				host = value;
				host.addChild(container);
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	OVERRIDES
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt (child:INode, index:uint):void
		{
			if (child is IPrimitive)
				super.addChildAt(child, index);
			
			else
				throw new Error ("parameter child is not of type IPrimitive");
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			var child:IPrimitive;
			var sceneInvalidated:Boolean = false;
			for each (child in children)
			{
				if (child.positionInvalidated || child.depthInvalidated || child.geometryInvalidated)
				{
					sceneInvalidated = true;
					break;
				}
			}
			
			if (sceneInvalidated)
			{
				var sortedChildren:Array = children.slice().sortOn(["z", "screenY", "screenX"], Array.NUMERIC);
				if (sortedChildren.length > 0 && IPrimitive(sortedChildren[0]).z != IPrimitive(sortedChildren[sortedChildren.length - 1]).z)
				{
					var requiresSwap:Boolean = false;
					var requiresBoundCheck:Boolean = false;
					
					var reorderedArray:Array = [];
					var tempArray:Array = [];
					var currentDepth:int;
					var targetDepth:int;
					
					var childA:IPrimitive;
					var childB:IPrimitive;
					
					var rectA:Rectangle;
					var rectB:Rectangle;
					for each (childA in sortedChildren)
					{
						tempArray = [];
						
						for each (childB in sortedChildren)
						{
							if (childA == childB)
								continue;
								
							if (childA.z > childB.z && childA.z < childB.top)
							{								
								rectA = childA.container.getBounds(container);
								rectB = childB.container.getBounds(container);
								if (rectA.intersects(rectB))
								{
									if (childA.x < childB.x && childA.y < childB.y)
										requiresSwap = true;
									
									else if (childA.x <= childB.x)
									{
										if (childA.y < childB.front)
											requiresSwap = true;
									}
									
									else if (childA.front <= childB.y)
									{
										if (childA.x < childB.right)
											requiresSwap = true;	
									}
								}
							}
							
							if (requiresSwap)
							{
								//works kinda
								currentDepth = sortedChildren.indexOf(childB);
								sortedChildren.splice(currentDepth, 1);
								
								targetDepth = sortedChildren.indexOf(childA);
								sortedChildren.splice(targetDepth + 1, 0, childB);
								
								requiresSwap = false;
							}
						}
						
						/* if (tempArray.length > 0)
						{							
							tempArray.reverse();
							for each (child in tempArray)
								sortedChildren.splice(targetDepth, 0, child);
						} */
					}
				}
							
				var i:int;
				var m:int = sortedChildren.length;
				while (i < m)
					setChildIndex(IPrimitive(sortedChildren[i]), i++);
			}
			
			super.render(recursive);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function IsoScene (hostingContainer:DisplayObjectContainer = null, root:INode = null)
		{
			super();
			
			parentNode = new Node();
			
			rootNode = root;
			hostContainer = hostingContainer;
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	ROOT NODE
		///////////////////////////////////////////////////////////////////////////////
		
		protected var rNode:INode;
		
		public function get rootNode ():INode
		{
			return rNode;
		}
		
		public function set rootNode (value:INode):void
		{
			if (value)
			{
				removeAllChildren();
				super.addChild(value);
			}
		}
	}
}