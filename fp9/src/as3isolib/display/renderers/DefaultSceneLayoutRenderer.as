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
	import flash.utils.Dictionary;
	
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

			// Rewrite #2 by David Holz, naive dependency version
			
			// IIsoDisplayObject -> [obj that should be behind the key]
			var dependency:Dictionary = new Dictionary();
			
			var children:Array = scene.displayListChildren;
			
			// Full naive cartesian scan, see what objects are behind child[i]
			var max:uint = children.length;
			for (var i:uint = 0; i < max; ++i)
			{
				var behind:Array = [];
				
				var objA:IIsoDisplayObject = children[i];
				var boundsA:IBounds = objA.isoBounds;

				for (var j:uint = 0; j < max; ++j)
				{
					var objB:IIsoDisplayObject = children[j];
					var boundsB:IBounds = objB.isoBounds;
					
					// See if B should go behind A
					if (// Behind in any axis,
					    ((boundsB.top <= boundsA.bottom) ||
						 (boundsB.right <= boundsA.left) ||
						 (boundsB.front <= boundsA.back))
						&&
						// but not in front in any other axis
						!((boundsB.bottom >= boundsA.top) ||
						  (boundsB.left >= boundsA.right) ||
						  (boundsB.back >= boundsA.front)))
					{
						behind.push(objB);
					}
				}
				dependency[objA] = behind;
			}

			// Place the children into a sorted array, using dependency ordering
			var sortedChildren:Array = [];
			
			// IIsoDisplayObject -> Boolean, true signifies it's already been put in the display list
			var visited:Dictionary = new Dictionary();
			
			var place:Function = function(obj:IIsoDisplayObject):void
			{
				if (visited[obj])
					return;
				visited[obj] = true;
				
				for each(var inner:IIsoDisplayObject in dependency[obj])
					place(inner);
				sortedChildren.push(obj);
			};
			
			for each(var obj:IIsoDisplayObject in children)
			{
				place(obj);
			}
			
			// Update the scene's ordering
			for (i = 0; i < max; ++i)
			{
				var child:IIsoDisplayObject = IIsoDisplayObject(sortedChildren[i]);
				if (child.depth != i)
					scene.setChildIndex(child, i);
			}

			// DEBUG OUTPUT
			
			//trace("--------------------");
			//for (i = 0; i < max; ++i)
			//	trace(dumpBounds(sortedChildren[i].isoBounds), dependency[sortedChildren[i]].length);
			
			trace("scene layout render time", getTimer() - startTime, "ms (manual sort)");
		}
		
		//static private function dumpBounds(b:IBounds):String { return "[" + b.left + ".." + b.right + "," + b.back + ".." + b.front + "," + b.bottom + ".." + b.top + "]"; }
	}
}
