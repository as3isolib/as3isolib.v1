package isoLib.display
{
	import flash.display.DisplayObjectContainer;
	
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.IsoContainer;

	public class IsoWorld extends IsoContainer
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
				
				if (hasParent)
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
		//	LAYERS
		///////////////////////////////////////////////////////////////////////////////
		
		protected var backgroundScene:IsoScene;
		protected var objectsScene:IsoScene;
		protected var foregroundScene:IsoScene;
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function IsoWorld (hostingContainer:DisplayObjectContainer)
		{
			super();
			
			backgroundScene = new IsoScene();
			addChild(backgroundScene);
			
			objectsScene = new IsoScene();
			addChild(objectsScene);
			
			foregroundScene = new IsoScene();
			addChild(foregroundScene);	
		}
	}
}