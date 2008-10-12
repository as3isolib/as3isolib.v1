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
package as3isolib.display.renderers
{
	import as3isolib.display.scene.IIsoScene;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * The ISceneRenderer interface defines the methods that all scene renderer-type classes should implement.
	 * Scene renderer-type classes are intended to assist IIsoScene implementors in renderering scenes with various layouts, shadowing and effects.
	 */
	public interface ISceneRenderer extends IEventDispatcher
	{
		/**
		 * @private
		 */
		function get target ():IIsoScene;
		
		/**
		 * The target IIsoScene whose children will be rendererd.
		 */
		function set target (value:IIsoScene):void;
		
		/**
		 * Iterates and renders each child of the target.
		 */
		function renderScene ():void;
	}
}