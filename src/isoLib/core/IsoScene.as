package isoLib.core
{
	import flash.display.DisplayObjectContainer;
	
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.Node;

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
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function IsoScene (id:String = "", hostingContainer:DisplayObjectContainer = null, root:INode = null)
		{
			this.id = (id == "")?
				"isoScene_" + UID://give it a specific id
				id; //or go with the user-assigned id
				
			this.rootNode = root;
			this.hostContainer = hostingContainer;
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