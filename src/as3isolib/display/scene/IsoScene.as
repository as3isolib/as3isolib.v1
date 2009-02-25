/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 - 2008 J.W.Opitz, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
package as3isolib.display.scene
{
	
	import as3isolib.bounds.IBounds;
	import as3isolib.bounds.SceneBounds;
	import as3isolib.core.ClassFactory;
	import as3isolib.core.IFactory;
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.core.IsoContainer;
	import as3isolib.core.as3isolib_internal;
	import as3isolib.data.INode;
	import as3isolib.display.renderers.DefaultSceneLayoutRenderer;
	import as3isolib.display.renderers.ISceneLayoutRenderer;
	import as3isolib.display.renderers.ISceneRenderer;
	import as3isolib.events.IsoEvent;
	
	import flash.display.DisplayObjectContainer;
	
	use namespace as3isolib_internal;
	
	/**
	 * IsoScene is a base class for grouping and rendering IIsoDisplayObject children according to their isometric position-based depth.
	 */
	public class IsoScene extends IsoContainer implements IIsoScene
	{		
		///////////////////////////////////////////////////////////////////////////////
		//	BOUNDS
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		private var _isoBounds:IBounds;
		
		/**
		 * @inheritDoc
		 */
		public function get isoBounds ():IBounds
		{
			/* if (!_isoBounds || isInvalidated)
				_isoBounds =  */
			
			return new SceneBounds(this);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	HOST CONTAINER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var host:DisplayObjectContainer;
		
		/**
		 * @private
		 */
		public function get hostContainer ():DisplayObjectContainer
		{
			return host;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set hostContainer (value:DisplayObjectContainer):void
		{
			if (value && host != value)
			{
				if (host && host.contains(container))
				{
					host.removeChild(container);
					ownerObject = null;
				}
				
				else if (hasParent)
					parent.removeChild(this);
				
				host = value;
				if (host)
				{
					host.addChild(container);
					ownerObject = host;
					parentNode = null;
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	INVALIDATE CHILDREN
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 * 
		 * Array of invalidated children.  Each child dispatches an IsoEvent.INVALIDATION event which notifies 
		 * the scene that that particular child is invalidated and subsequentally the scene is also invalidated.
		 */
		protected var invalidatedChildrenArray:Array = [];
		
		/**
		 * @inheritDoc
		 */
		public function get invalidatedChildren ():Array
		{
			return invalidatedChildrenArray;
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
				child.addEventListener(IsoEvent.INVALIDATE, child_invalidateHandler);
				
				_isInvalidated = true; //since the child most likely had fired an invalidation event prior to being added, manually invalidate the scene
			}
				
			else
				throw new Error ("parameter child is not of type IIsoDisplayObject");
		}
		
		/**
		 * @inheritDoc
		 */
		override public function setChildIndex (child:INode, index:uint):void
		{
			super.setChildIndex(child, index);
			_isInvalidated = true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildByID (id:String):INode
		{
			var child:INode = super.removeChildByID(id);
			child.removeEventListener(IsoEvent.INVALIDATE, child_invalidateHandler);
			
			_isInvalidated = true;
			
			return child;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAllChildren ():void
		{			
			var child:INode
			for each (child in children)
				child.removeEventListener(IsoEvent.INVALIDATE, child_invalidateHandler);
			
			super.removeAllChildren();
			_isInvalidated = true;
		}
		
		/**
		 * Renders the scene as invalidated if a child object is invalidated.
		 * 
		 * @param evt The IsoEvent dispatched from the invalidated child.
		 */
		protected function child_invalidateHandler (evt:IsoEvent):void
		{
			var child:Object = evt.target;
			if (invalidatedChildrenArray.indexOf(child) == -1)
				invalidatedChildrenArray.push(child);
			
			_isInvalidated = true;
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	LAYOUT RENDERER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Flags the scene for possible layout rendering.
		 * If false, child objects are sorted by the order they were added rather than by their isometric depth.
		 */
		public var layoutEnabled:Boolean = true;
		
		private var layoutRendererFactory:IFactory;
		
		/**
		 * @private
		 */
		public function get layoutRenderer ():IFactory
		{
			return layoutRendererFactory;
		}
		
		/**
		 * The factory used to create the ISceneLayoutRenderer responsible for the layout of the child objects.
		 */
		public function set layoutRenderer (value:IFactory):void
		{
			if (value && layoutRendererFactory != value)
			{
				layoutRendererFactory = value;
				_isInvalidated = true;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	STYLE RENDERERS
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Flags the scene for possible style rendering.
		 */
		public var stylingEnabled:Boolean = true;
		
		private var styleRendererFactories:Array = [];
		
		/**
		 * @private
		 */
		public function get styleRenderers ():Array
		{
			return styleRendererFactories;
		}
		
		/**
		 * An array of IFactories whose class generators are ISceneRenderer.
		 * If any value contained within the array is not of type IFactory, it will be ignored.
		 */
		public function set styleRenderers (value:Array):void
		{			
			if (value)
			{
				var temp:Array = [];
				var obj:Object;
				for each (obj in value)
				{
					if (obj is IFactory)
						temp.push(obj);
				}
				
				styleRendererFactories = temp;
				_isInvalidated = true;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	INVALIDATION
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		private var _isInvalidated:Boolean = false;
		
		/**
		 * Flag indicating if the scene is invalidated.  If true, validation will occur during the next render pass.
		 */
		public function get isInvalidated ():Boolean
		{
			return _isInvalidated;
		}
		
		/**
		 * Flags the scene as invalidated during the rendering process
		 */
		public function invalidateScene ():void
		{
			_isInvalidated = true;
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			super.render(recursive); //push individual changes thru, then sort based on new visible content of each child
			
			if (_isInvalidated)
			{
				//render the layout first
				var sceneLayoutRenderer:ISceneLayoutRenderer;
				if (layoutEnabled)
				{
					sceneLayoutRenderer = layoutRendererFactory.newInstance();
					if (sceneLayoutRenderer)
						sceneLayoutRenderer.renderScene(this);
				}
				
				//apply styling
				mainContainer.graphics.clear(); //should we do this here?
				
				var sceneRenderer:ISceneRenderer;
				var factory:IFactory
				if (stylingEnabled)
				{
					for each (factory in styleRendererFactories)
					{
						sceneRenderer = factory.newInstance();
						if (sceneRenderer)
							sceneRenderer.renderScene(this);
					}
				}
				
				_isInvalidated = false;
				
				sceneRendered();
			}
		}
		
		/**
		 * Performs any last minute clean up after a render phase.
		 */
		protected function sceneRendered ():void
		{
			invalidatedChildrenArray = [];
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoScene ()
		{
			super();
			
			layoutRendererFactory = new ClassFactory(DefaultSceneLayoutRenderer);
		}
	}
}