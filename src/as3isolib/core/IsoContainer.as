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
package as3isolib.core
{
	import as3isolib.data.INode;
	import as3isolib.data.Node;
	import as3isolib.events.IsoEvent;
	
	import eDpLib.events.ProxyEvent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	use namespace as3isolib_internal;
	
	/**
	 * IsoContainer is the base class that any isometric object must extend in order to be shown in the display list.
	 * Developers should not instantiate this class directly but rather extend it.
	 */
	public class IsoContainer extends Node implements IContainer
	{
		////////////////////////////////////////////////////////////////////////
		//	CHILD METHODS
		////////////////////////////////////////////////////////////////////////
			
			//	ADD
			////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt (child:INode, index:uint):void
		{
			if (child is IContainer)
			{
				super.addChildAt(child, index);
				mainContainer.addChildAt(IContainer(child).container, index);
			}
			
			else
				throw new Error("parameter child does not implement IContainer.");
		}
		
			//	SWAP
			////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function setChildIndex (child:INode, index:uint):void
		{
			if (!child is IContainer)
				throw new Error("parameter child does not implement IContainer.");
			
			else if (!child.hasParent || child.parent != this)
				throw new Error("parameter child is not found within node structure.");
			
			else
			{
				super.setChildIndex(child, index);
				mainContainer.setChildIndex(IContainer(child).container, index);
			}
		}
			
			//	REMOVE
			////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildByID (id:String):INode
		{
			var child:INode = super.removeChildByID(id);
			if (child && child is IsoContainer)
				mainContainer.removeChild(IContainer(child).container);
			
			return child;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeAllChildren ():void
		{
			var child:IContainer;
			for each (child in children)
				mainContainer.removeChild(child.container);
				
			super.removeAllChildren();
		}		
			
			//	CREATE
			////////////////////////////////////////////////////////////////////////
		
		/**
		 * Initialization method to create the child IContainer objects.
		 */
		protected function createChildren ():void
		{
			//overriden by subclasses
			mainContainer = new Sprite();	
			//mainContainer.cacheAsBitmap = true;		
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
				var child:IContainer;
				for each (child in children)
					child.render(recursive);
			}
			
			dispatchEvent(new IsoEvent(IsoEvent.RENDER));
		}
		
		////////////////////////////////////////////////////////////////////////
		//	EVENT DISPATCHER PROXY
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function dispatchEvent (event:Event):Boolean
		{
			//so we can make use of the bubbling events via the display list
			if (event.bubbles)
				return proxyTarget.dispatchEvent(new ProxyEvent(this, event));
				
			else
				return super.dispatchEvent(event);
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONTAINER STRUCTURE
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		as3isolib_internal var mainContainer:Sprite;
		
		/**
		 * @inheritDoc
		 */
		public function get depth ():int
		{
			if (mainContainer.parent)
				return mainContainer.parent.getChildIndex(mainContainer);
			
			else
				return -1;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get container ():Sprite
		{
			return mainContainer;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoContainer()
		{
			super();
			createChildren();
			
			proxyTarget = container;
		}
	}
}