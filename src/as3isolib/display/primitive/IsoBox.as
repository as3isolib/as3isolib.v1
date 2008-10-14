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
package as3isolib.display.primitive
{
	import as3isolib.core.IsoDisplayObject;
	
	/**
	 * 3D box primitive in isometric space.
	 */
	public class IsoBox extends IsoPrimitive
	{
		/**
		 * Constructor
		 */
		public function IsoBox ()
		{
			super();
			
			lineThicknesses = [0, 0, 0, 3, 3, 3];
			faceColors = [0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xcccccc, 0x000000];
		}
		
		/**
		 * @private
		 */
		protected var sq0:IsoRectangle;
		
		/**
		 * @private
		 */
		protected var sq1:IsoRectangle;
		
		/**
		 * @private
		 */
		protected var sq2:IsoRectangle;
		
		/**
		 * @private
		 */
		protected var sq3:IsoRectangle;
		
		/**
		 * @private
		 */
		protected var sq4:IsoRectangle;
		
		/**
		 * @private
		 */
		protected var sq5:IsoRectangle;
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren ():void
		{
			super.createChildren();
			
			var sq:IsoRectangle;
			var i:uint;
			for (i; i < 6; i++)
			{
				if (this['sq' + i] == null)
				{
					sq = new IsoRectangle();
					this['sq' + i] = sq;
				}
				
				addChild(sq);
			}
			
			sq0.id = "bottom";
			sq1.id = "left";
			sq2.id = "back";
			sq3.id = "front";
			sq4.id = "right";
			sq5.id = "top";
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function validateGeometry ():Boolean
		{
			return (width <= 0 && length <= 0 && height <= 0) ? false : true;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function drawGeometry ():void
		{
			//bottom face
			sq0.width = width;
			sq0.length = length;
			sq0.height = 0;
			
			//back-left face
			sq1.width = 0;
			sq1.length = length;
			sq1.height = height;
			
			//back-right face
			sq2.width = width;
			sq2.length = 0;
			sq2.height = height;
			
			//front-left face
			sq3.width = width;
			sq3.length = 0;
			sq3.height = height;
			sq3.y = length;
			
			//front-right face
			sq4.width = 0;
			sq4.length = length;
			sq4.height = height;
			sq4.x = width;
			
			//top face
			sq5.width = width;
			sq5.length = length;
			sq5.height = 0;
			sq5.z = height;
			
			//now apply all common properties
			var sq:IsoRectangle;
			var i:int = numChildren - 1;
			var c:int;
			for (i; i >= 0; i--)
			{
				sq = IsoRectangle(getChildAt(i));
				
				//styling
				sq.lineAlphas = [lineAlphas[c]];
				sq.lineColors = [lineColors[c]];
				sq.lineThicknesses = [lineThicknesses[c]];
				sq.faceAlphas = [faceAlphas[c]];
				sq.faceColors = [faceColors[c]];
				sq.styleType = styleType;
				
				c++;
			}		
		}
	}
}