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
	import as3isolib.enum.RenderStyleType;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.GradientColorFill;
	import as3isolib.graphics.IFill;
	import as3isolib.graphics.IStroke;
	
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.display.InterpolationMethod;
	import flash.display.SpreadMethod;
	import flash.geom.Matrix;
	
	/**
	 * @private
	 */
	public class IsoSphere extends IsoPrimitive
	{
		static protected const DEFAULT_SPHERE_FILL:IFill = new GradientColorFill(GradientType.RADIAL,
																					[0xFFFFFF, 0x000000],
																					[1, 1],
																					[80, 100],
																					new Matrix(1, 0, 0, 1, -10, -10),
																					SpreadMethod.PAD,
																					InterpolationMethod.RGB,
																					0);
		
		private var diameter:Number;
		private var oldDiameter:Number;
		
		public function get size ():Number
		{
			return diameter;
		}
		
		public function set size (value:Number):void
		{
			if (!usePreciseValues)
				value = Math.round(value);
				
			value = Math.abs(value);
			
			if (diameter != value)
			{
				oldDiameter = diameter;
				
				diameter = value;
				invalidateSize();
				
				if (autoUpdate)
					render();
			}
		}
		
		override protected function validateGeometry ():Boolean
		{
			return diameter > 2 ? true : false;
		}
		
		override protected function drawGeometry ():void
		{
			var radius:Number = diameter / 2;
			var ctrPt:Pt = new Pt(radius, radius, radius);
			IsoMath.isoToScreen(ctrPt);
			
			var g:Graphics = mainContainer.graphics;
			g.clear();
			
			var fill:IFill = fills[0] ? IFill(fills[0]) : DEFAULT_SPHERE_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			var stroke:IStroke = strokes[0] ? IStroke(strokes[0]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
			
			g.drawCircle(ctrPt.x, ctrPt.y, radius);
			if (fill)
				fill.end(g);
		}
		
		public function IsoSphere ()
		{
			super();
			
			this.fills = [DEFAULT_SPHERE_FILL];
		}
		
	}
}