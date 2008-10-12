/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 J.W.Opitz, All Rights Reserved.

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
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.core.IsoContainer;
	import as3isolib.data.INode;
	import as3isolib.display.renderers.DefaultSceneLayoutRenderer;
	import as3isolib.display.renderers.DefaultShadowRenderer;
	import as3isolib.display.renderers.ISceneRenderer;
	
	import flash.display.DisplayObjectContainer;
	
	/**
	 * IsoScene is a base class for grouping and rendering IIsoDisplayObject children according to their isometric position-based depth.
	 */
	public class IsoScene extends IsoContainer implements IIsoScene
	{		
		///////////////////////////////////////////////////////////////////////////////
		//	SCENE PAN / ZOOM
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
			if (!_isoBounds || isInvalidated)
				_isoBounds = new SceneBounds(this);
			
			return _isoBounds;
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
		
		/**
		 * @inheritDoc
		 */
		override public function setChildIndex (child:INode, index:uint):void
		{
			super.setChildIndex(child, index);
			invalidateScene();
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildByID (id:String):INode
		{
			invalidateScene();
			return super.removeChildByID(id);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAllChildren ():void
		{
			super.removeAllChildren();
			invalidateScene();
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	DEPTH SORT
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Flags the scene for possible layout rendering.
		 * If false, child objects are sorted by the order they were added rather than by their isometric depth.
		 */
		public var layoutEnabled:Boolean = true;
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDERERS
		///////////////////////////////////////////////////////////////////////////////
		
		public var layoutRenderer:ISceneRenderer;
		
		public var styleRenderers:Array;
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		private var _isInvalidated:Boolean = false;
		
		/**
		 * @private
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
			
			if (isInvalidated)
			{
				if (layoutEnabled)
				{
					var layoutRenderer:ISceneRenderer = new DefaultSceneLayoutRenderer();
					layoutRenderer.target = this;
					layoutRenderer.renderScene();
				}
				
				var shadowRenderer:ISceneRenderer = new DefaultShadowRenderer(0x000000, 0.15, true);
				shadowRenderer.target = this;
				shadowRenderer.renderScene();
			}
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
		}
	}
}