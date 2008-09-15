package isoLib.display
{
	import com.jwopitz.geom.Pt;
	
	import flash.display.DisplayObjectContainer;
	
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.IRenderer;
	import isoLib.core.sceneGraph.IsoContainer;
	import isoLib.core.sceneGraph.Node;
	import isoLib.core.shape.IPrimitive;
	import isoLib.utils.IsoUtil;
	
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
				
				else if (hasParent)
					parent.removeChild(this);
				
				host = value;
				if (host)
				{
					host.addChild(container);
					parentNode = null;
				}
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
				child.depth = -1 * Math.sqrt(Math.pow(camera.x - child.right, 2) + Math.pow(camera.y - child.front, 2) + Math.pow(camera.z - child.top, 2));
				if (child.positionInvalidated || child.depthInvalidated || child.geometryInvalidated)
				{
					sceneInvalidated = true;
					//break;
				}
			}
			
			if (sceneInvalidated)
			{
				var sortedChildren:Array = children.slice()//.sortOn(["depth", "screenY", "screenX", "z"], Array.NUMERIC);
				sortedChildren.sort(IsoUtil.compareDepths);
							
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
		
		protected var camera:Pt
		
		public function IsoScene ()
		{
			super();
			
			camera = new Pt(10000, 10000, 10000);
		}
	}
}