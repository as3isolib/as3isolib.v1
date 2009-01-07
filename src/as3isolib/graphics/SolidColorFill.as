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
package as3isolib.graphics
{
	import as3isolib.errors.IsoError;
	
	import flash.display.Graphics;

	public class SolidColorFill implements IFill
	{
		/**
		 * Constructor
		 */
		public function SolidColorFill (color:uint, alpha:Number)
		{
			this.color = color;
			this.alpha = alpha;
		}
		
		/**
		 * The color of the fill.
		 */
		public var color:uint;
		
		/**
		 * The alpha of the fill.
		 */
		public var alpha:Number;
		
		///////////////////////////////////////////////////////////
		//	IFILL
		///////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function begin (target:Graphics):void
		{			
			target.beginFill(color, alpha);
		}
		
		/**
		 * @inheritDoc
		 */
		public function end (target:Graphics):void
		{
			target.endFill();
		}
	}
}