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
	import as3isolib.core.as3isolib_internal;
	import as3isolib.enum.RenderStyleType;
	
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	use namespace as3isolib_internal;
	
	/**
	 * 3D polygon primitive in isometric space.
	 */
	public class IsoPolygon extends IsoPrimitive
	{
		/**
		 * @inheritDoc
		 */
		override protected function validateGeometry ():Boolean
		{
			return pts.length > 2;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function drawGeometry ():void
		{
			var g:Graphics = mainContainer.graphics;
			g.clear();
			g.moveTo(pts[0].x, pts[0].y);
			
			if (styleType == RenderStyleType.SHADED)
				g.beginFill(faceColors[0], faceAlphas[0]);
			
			else if (styleType == RenderStyleType.SOLID)
				g.beginFill(0xffffff, faceAlphas[0]);
				
			else if (styleType == RenderStyleType.WIREFRAME)
				g.beginFill(0xff0000, 0.0);
			
			else
				return;
			
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0], true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.ROUND);
			
			var i:uint = 1;
			var l:uint = pts.length;
			while (i < l)
			{
				g.lineTo(pts[i].x, pts[i].y);
				i++;
			}
				
			g.lineTo(pts[0].x, pts[0].y);
			g.endFill();
		}
		
		////////////////////////////////////////////////////////////////////////
		//	PTS
		////////////////////////////////////////////////////////////////////////
		
		[ArrayElementType("as3isolib.geom.Pt")]
		private var geometryPts:Array = [];
		
		/**
		 * @private
		 */
		public function get pts ():Array
		{
			return geometryPts;
		}
		
		/**
		 * The set of points in isometric space needed to render the polygon.  At least 3 points are needed to render.
		 */
		public function set pts (value:Array):void
		{
			if (geometryPts != value)
			{
				geometryPts = value;
				invalidateSize();
				
				if (autoUpdate)
					render();
			}
		}
		
		/**
		 * Constructor
		 */
		public function IsoPolygon ()
		{
			super();
		}
	}
}