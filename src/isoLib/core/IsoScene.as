package isoLib.core
{
	import flash.display.DisplayObjectContainer;
	
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.Node;
	import isoLib.core.shape.IPrimitive;
	
	use namespace isolib_internal;
	
	public class IsoScene extends Node
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
		
		override public function addChild (child:INode):void
		{
			if (child is IPrimitive)
				super.addChild(child);
			
			else
				throw new Error ("parameter child is not of type IPrimitive");
		}
		
		override public function render (recursive:Boolean=true):void
		{			
			var depthArray:Array = [];
			
			var child:IPrimitive;
			for each (child in children)
				depthArray.push(child);
			
			depthArray = depthArray.sortOn(["x", "y", "z",], Array.NUMERIC);
			
			var i:int;
			for each (child in depthArray)
			{
				if (child.depth != i)
					setChildIndex(child, i);
				
				i++;
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

import isoLib.core.sceneGraph.INode;
import isoLib.core.shape.IPrimitive;

class DepthObject
{
	public var child:IPrimitive;
	public var depthRatio:Number = 1;
	
	public var x:Number;
	public var y:Number;
	public var z:Number;
	
	public var width:Number;
	public var length:Number;
	public var height:Number;
	
	public function DepthObject (child:IPrimitive)
	{
		this.child = child;
		
		x = child.x;
		y = child.y;
		z = child.z;
		
		width = child.width;
		length = child.length;
		height = child.height;
	}
}