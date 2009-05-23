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
	
	import flash.utils.getTimer;
	
	use namespace as3isolib_internal;
	
	/**
	 * The DefaultSceneLayoutRenderer is the default renderer responsible for performing the isometric position-based depth sorting on the child objects of the target IIsoScene. 
	 */
	public class DefaultSceneLayoutRenderer implements ISceneLayoutRenderer
	{		
		////////////////////////////////////////////////////
		//	RENDER SCENE
		////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function renderScene (scene:IIsoScene):void
		{
			var startTime:uint = getTimer();

			// Rewrite by David Holz
			
			// NOTE - Flash player 10 only
			// Using scene.children because they are in last display order, scene.displayListChildren are unordered and fully resorted every time!
			//var sortedChildren:Vector.<IIsoDisplayObject> = Vector.<IIsoDisplayObject>(scene.children);
			
			// Flash player 9
			var sortedChildren:Array = scene.children.slice();
			
			// Ocean sort, from http://cadaver.homeftp.net/rants/sprite.htm
			// Starting from offset 1, make sure [N] >= [N-1].  If not, keep pushing N back in the list until it's >= the new [N-1]
			// This sort works best when there are minor changes to the depth ordering that need to be patched up
			
			// All of the aditional variables are to reduce the number of array accesses, which are all bounds checked by the VM.  Each removed array access lopped more time off the render.
			var max:uint = sortedChildren.length;
			var objB:IIsoDisplayObject = sortedChildren[0];
			var boundsB:IBounds = objB.isoBounds;
			for (var i:uint = 1; i < max; ++i)
			{
				var j:uint = i;
				
				var objA:IIsoDisplayObject = sortedChildren[i];
				var boundsA:IBounds = objA.isoBounds;
				
				// There are many instances where 2 blocks can be ordered A->B in one axis, and B->A in the other
				// We need to determine a priority order for comparing, so that they won't just toggle getting behind each other from frame to frame.
				// Also, these mutual behindednesses can lead to the painter's algorithm type of problems and break visual sorting order.
				
				// See if objA is behind objB, which would be out of place
				if((boundsA.top <= boundsB.bottom) || // if A is under B, then process
				   (!(boundsA.bottom >= boundsB.top) && // else, if A is _known not to be over B_ and ...
				    ((boundsA.right <= boundsB.left) || // if A is left of B, then process
					 (!(boundsA.left >= boundsB.right) && // else, if A is _known not to be right of B_ and ...
					  (boundsA.front <= boundsB.back))))) // if A is back of B, then process
				{
					// Leave objB where it is so the next iteration of the main loop has it intact for reuse
					var tempObjB:IIsoDisplayObject = objB;
					var tempBoundsB:IBounds;
					
					// This should be faster than 2 calls to splice(), since those 2 calls would shuffle all the way to the end of the Vector.
					// This code only shifts the affected indexes
					do
					{
						sortedChildren[j] = tempObjB;
						--j;
						if (0 == j)
							break;
						tempObjB = sortedChildren[j - 1];
						tempBoundsB = tempObjB.isoBounds;
					}
					while ((boundsA.top <= tempBoundsB.bottom) || // if A is under B, then process
				           (!(boundsA.bottom >= tempBoundsB.top) && // else, if A is _known not to be over B_ and ...
				            ((boundsA.right <= tempBoundsB.left) || // if A is left of B, then process
					         (!(boundsA.left >= tempBoundsB.right) && // else, if A is _known not to be right of B_ and ...
					          (boundsA.front <= tempBoundsB.back))))) // if A is back of B, then process
					
					//trace("moved", i, dumpBounds(boundsA), "to", j, dumpBounds(sortedChildren[j+1].isoBounds));
					
					// Update the display order of this moved object
					sortedChildren[j] = objA;
					scene.setChildIndex(objA, j);
				}
				else
				{
					objB = objA;
					boundsB = boundsA;
				}
			}
			
			// DEBUG OUTPUT
			
			//trace("--------------------");
			//for (i = 0; i < max; ++i)
			//	trace(dumpBounds(sortedChildren[i].isoBounds));
			
			trace("scene layout render time", getTimer() - startTime, "ms (manual sort)");
		}
		
		//static private function dumpBounds(b:IBounds):String { return "[" + b.left + ".." + b.right + "," + b.back + ".." + b.front + "," + b.bottom + ".." + b.top + "]"; }

	}
}
