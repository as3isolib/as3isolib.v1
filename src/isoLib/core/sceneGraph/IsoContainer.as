package isoLib.core.sceneGraph
{
	import flash.display.Sprite;
	
	import isoLib.bounds.IBounds;
	import isoLib.bounds.PrimitiveBounds;

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
				container.setChildIndex(IRenderer(child).container, index);
			}
		}
		
		override public function removeChildByID (id:String):INode
		{
			var child:INode = super.removeChildByID(id);
			if (child && child is IRenderer)
				container.removeChild(IRenderer(child).container);
			
			return child;
		}
		
		override public function removeAllChildren ():void
		{
			var child:IRenderer;
			for each (child in children)
				container.removeChild(child.container);
			
			super.removeAllChildren();
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
				//spriteContainer.cacheAsBitmap = true;
			
			}
			
			return spriteContainer;
		}
		
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
			if (recursive && hasParent)
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
			
			proxyTarget = container;
		}		
	}
}