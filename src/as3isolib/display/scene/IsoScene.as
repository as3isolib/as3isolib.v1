package as3isolib.display.scene
{
	import as3isolib.data.INode;
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.display.IsoContainer;
	import as3isolib.display.renderers.DefaultSceneLayoutRenderer;
	import as3isolib.display.renderers.DefaultShadowRenderer;
	import as3isolib.display.renderers.ISceneRenderer;
	
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
			{
				super.addChildAt(child, index);
				invalidateScene();
			}
				
			else
				throw new Error ("parameter child is not of type IIsoDisplayObject");
		}
		
		override public function setChildIndex (child:INode, index:uint):void
		{
			super.setChildIndex(child, index);
			invalidateScene();
		}
		
		override public function removeChildByID (id:String):INode
		{
			invalidateScene();
			return super.removeChildByID(id);
		}
		
		override public function removeAllChildren ():void
		{
			super.removeAllChildren();
			invalidateScene();
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	DEPTH SORT
		///////////////////////////////////////////////////////////////////////////////
		
		public var layoutEnabled:Boolean = true;
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		private var _isInvalidated:Boolean = false;
		public function get isInvalidated ():Boolean
		{
			return _isInvalidated;
		}
		
		public function invalidateScene ():void
		{
			_isInvalidated = true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			var child:IIsoDisplayObject;
			for each (child in children)
			{
				if (child.isInvalidated)
				{
					invalidateScene();
					break;
				}
			}
			
			super.render(recursive); //push individual changes thru, then sort based on new visible content of each child
			
			if (isInvalidated && layoutEnabled)
			{
				var layoutRenderer:ISceneRenderer = new DefaultSceneLayoutRenderer();
				layoutRenderer.target = this;
				layoutRenderer.renderScene();
				
				var shadowRenderer:ISceneRenderer = new DefaultShadowRenderer(0x000000, 0.15, true);
				shadowRenderer.target = this;
				shadowRenderer.renderScene();
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