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
package as3isolib.display.renderers
{
	import as3isolib.bounds.IBounds;
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.core.as3isolib_internal;
	import as3isolib.display.scene.IIsoScene;
	
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	use namespace as3isolib_internal;
	
	/**
	 * The DefaultSceneLayoutRenderer is the default renderer responsible for performing the isometric position-based depth sorting on the child objects of the target IIsoScene. 
	 */
	public class DefaultSceneLayoutRenderer extends EventDispatcher implements ISceneRenderer
	{		
		////////////////////////////////////////////////////
		//	TARGET
		////////////////////////////////////////////////////
		
		private var targetContainer:IIsoScene;
		
		/**
		 * @private
		 */
		public function get target ():IIsoScene
		{
			return targetContainer;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set target (value:IIsoScene):void
		{
			targetContainer = value;
		}
		
		////////////////////////////////////////////////////
		//	UPDATE LAYOUT
		////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function renderScene ():void
		{
			//var time:int = getTimer();
			
			var sortedChildren:Array = targetContainer.children.slice(); //make a copy of the children
			sortedChildren.sortOn(["distance", "screenX", "screenY"], Array.NUMERIC);
			sortedChildren.sort(isoDepthSort); //perform a secondary sort for any hittests
			
			//trace("sort:", getTimer() - time, "milliseconds");
			
			var child:IIsoDisplayObject;
			var i:uint;
			var m:uint = sortedChildren.length;
			while (i < m)
			{
				child = IIsoDisplayObject(sortedChildren[i]);
				if (child.depth != i)
					targetContainer.setChildIndex(child, i); //is there a way to make this more efficient?
				
				i++;
			}
			
			//trace("index assignment:", getTimer() - time, "milliseconds");
		}
		
		////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function DefaultSceneLayoutRenderer ()
		{
			super();
		}
		
		////////////////////////////////////////////////////
		//	SORT
		////////////////////////////////////////////////////
		
		private function isoDepthSort (childA:Object, childB:Object):int
		{
			var boundsA:IBounds;
			var boundsB:IBounds;
			
			//trace(childA.id, childB.id);
			
			if (childA.container.hitTestObject(childB.container))
			{
				boundsA = childA.isoBounds;
				boundsB = childB.isoBounds;
				
				if (boundsA.right <= boundsB.left)
					return -1;
					
				else if (boundsA.left >= boundsB.right)
					return 1;
				
				else if (boundsA.front <= boundsB.back)
					return -1;
					
				else if (boundsA.back >= boundsB.front)
					return 1;
					
				else if (boundsA.top <= boundsB.bottom)
					return -1;
					
				else if (boundsA.bottom >= boundsB.top)
					return 1;
				
				else
					return 0;
			}			
			
			//else simple positioning sort
			else
			{
				if (childA.screenY > childB.screenY)
					return 1;
					
				else if (childA.screenY < childB.screenY)
					return -1;
				
				else
				{
					if (childA.screenX > childB.screenX)
						return 1;
						
					else if (childA.screenX < childB.screenX)
						return -1;
						
					else 
						return 0;
				}
			}
		}
	}
}