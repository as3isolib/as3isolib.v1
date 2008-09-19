package as3isolib.display.scene
{
	import as3isolib.data.INode;
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.display.IsoContainer;
	import as3isolib.display.layoutClasses.DefaultSceneLayoutObject;
	import as3isolib.display.layoutClasses.ILayoutObject;
	
	import flash.display.DisplayObjectContainer;
	
	public class IsoScene extends IsoContainer
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
			if (child is IIsoDisplayObject)
				super.addChildAt(child, index);
				
			else
				throw new Error ("parameter child is not of type IIsoDisplayObject");
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	LAYOUT OBJECT
		///////////////////////////////////////////////////////////////////////////////
		
		//protected var layoutObject:ILayoutObject;
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			var child:IIsoDisplayObject;
			var sceneInvalidated:Boolean = false;
			for each (child in children)
			{
				if (child.isInvalidated)
				{
					sceneInvalidated = true;
					break;
				}
			}
			
			super.render(recursive); //push individual changes thru, then sort based on new visible content of each child
			
			if (sceneInvalidated)
			{
				var layoutObject:ILayoutObject = new DefaultSceneLayoutObject();
				layoutObject.target = this;		
				layoutObject.updateLayout();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		public function IsoScene ()
		{
			super();
		}
	}
}