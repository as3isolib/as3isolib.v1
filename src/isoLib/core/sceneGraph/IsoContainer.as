package isoLib.core.sceneGraph
{
	import eDpLib.events.ProxyEvent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import isoLib.bounds.IBounds;

	public class IsoContainer extends Node implements IRenderer
	{
		////////////////////////////////////////////////////////////////////////
		//	CHILD METHODS
		////////////////////////////////////////////////////////////////////////
		
		override public function addChildAt (child:INode, index:uint):void
		{
			if (child is IRenderer)
			{
				super.addChildAt(child, index);
				
				/* if (child is IsoContainer)
					container.addChildAt(IsoContainer(child).mainContainer, index); //we are going to hit some RTEs with this for now
				
				else */
					container.addChildAt(IRenderer(child).container, index);
			}
			
			else
				throw new Error("parameter child is not of type IRenderer");
		}
		
		override public function setChildIndex (child:INode, index:uint):void
		{
			if (!child is IRenderer)
				throw new Error("");
				
			if (!child.hasParent || child.parent != this)
				throw new Error("");
			
			else
			{
				super.setChildIndex(child, index);
				
				/* if (child is IsoContainer)
					container.setChildIndex(IsoContainer(child).mainContainer, index); //we are going to hit some RTEs with this for now
				
				else
					 */container.setChildIndex(IRenderer(child).container, index);
			}
		}
		
		override public function removeChildByID (id:String):INode
		{
			var child:INode = super.removeChildByID(id);
			if (child && child is IRenderer)
			{
				/* if (child is IsoContainer)
					container.removeChild(IsoContainer(child).mainContainer);
					
				else
					 */container.removeChild(IRenderer(child).container);			
			}
			
			return child;
		}
		
		override public function removeAllChildren ():void
		{
			var child:IRenderer;
			for each (child in children)
			{
				/* if (child is IsoContainer)
					container.removeChild(IsoContainer(child).mainContainer);
				
				else
					 */container.removeChild(child.container);
			}
			
			super.removeAllChildren();
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONTAINERS
		////////////////////////////////////////////////////////////////////////
		
			//	BACKGROUND
			////////////////////////////////////////////////////////////////////////
		
		/* protected var backgroundContainer:Sprite;
		
		public function get background ():Sprite
		{
			if (!backgroundContainer)
			{
				backgroundContainer = new Sprite();
				mainContainer.addChildAt(backgroundContainer, 0);
			}
			
			return backgroundContainer
		}
		
		public function set background (value:Sprite):void
		{
			if (backgroundContainer != value)
			{
				if (backgroundContainer)
					mainContainer.removeChild(backgroundContainer);
				
				foregroundContainer = value;
				mainContainer.addChildAt(backgroundContainer, 0);
			}
		} */
		
			//	FORGROUND
			////////////////////////////////////////////////////////////////////////
		
		/* protected var foregroundContainer:Sprite;
		
		public function get foreground ():Sprite
		{
			if (!foregroundContainer)
			{
				foregroundContainer = new Sprite();
				mainContainer.addChild(foregroundContainer);
			}
			
			return foregroundContainer
		}
		
		public function set forground (value:Sprite):void
		{
			if (foregroundContainer != value)
			{
				if (foregroundContainer)
					mainContainer.removeChild(foregroundContainer);
				
				foregroundContainer = value;
				mainContainer.addChild(foregroundContainer);
			}
		} */
		
			//	OBJECTS
			////////////////////////////////////////////////////////////////////////
		
		protected var spriteContainer:Sprite;
		
		public function get container ():Sprite
		{
			if (!spriteContainer)
			{
				spriteContainer = new Sprite();
				//spriteContainer.cacheAsBitmap = true;
			
			}
			
			return spriteContainer;
		}
		
		/*
		main structure should be like so:
		
			* mainContainer
				* backgroundContainer - INodes
				* objects -  INodes
				* foregroundContainer - INodes
				* overlay gfx
		*/
		
		//protected var mainContainer:Sprite;
		
		///////////////////////////////////////////////////////////////////////////////
		//	BOUNDS
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function get bounds ():IBounds
		{
			return null;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	RENDER
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function render (recursive:Boolean = true):void
		{
			if (recursive)
			{
				var child:IRenderer;
				for each (child in children)
					child.render(recursive);
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////////////
		
		public function IsoContainer()
		{
			super();
			
			//mainContainer = new Sprite();
			//mainContainer.addChild(container);
			
			proxyTarget = container;
		}
		
		override public function dispatchEvent (event:Event):Boolean
		{
			//so we can make use of the bubbling events via the display list
			if (event.bubbles)
				return proxyTarget.dispatchEvent(new ProxyEvent(this, event));
				
			else
				return super.dispatchEvent(event);
		}
	}
}