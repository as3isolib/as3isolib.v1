/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 - 3000 J.W.Opitz, All Rights Reserved.

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
	import as3isolib.graphics.IBitmapFill;
	import as3isolib.graphics.IFill;
	import as3isolib.graphics.IStroke;
	
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * 3D box primitive in isometric space.
	 */
	public class IsoBox extends IsoPrimitive
	{
		/**
		 * Constructor
		 */
		public function IsoBox (descriptor:Object = null)
		{
			super(descriptor);
		}
		
		override public function set stroke (value:IStroke):void
		{
			strokes = [value, value, value, value, value, value];
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
			var g:Graphics = mainContainer.graphics;
			g.clear();
			
			//all pts are named in following order "x", "y", "z" via rfb = right, front, bottom
			var lbb:Pt = IsoMath.isoToScreen(new Pt(0, 0, 0));
			var rbb:Pt = IsoMath.isoToScreen(new Pt(width, 0, 0));
			var rfb:Pt = IsoMath.isoToScreen(new Pt(width, length, 0));
			var lfb:Pt = IsoMath.isoToScreen(new Pt(0, length, 0));
			
			var lbt:Pt = IsoMath.isoToScreen(new Pt(0, 0, height));
			var rbt:Pt = IsoMath.isoToScreen(new Pt(width, 0, height));
			var rft:Pt = IsoMath.isoToScreen(new Pt(width, length, height));
			var lft:Pt = IsoMath.isoToScreen(new Pt(0, length, height));
			
			//bottom face
			g.moveTo(lbb.x, lbb.y);
			var fill:IFill = fills.length >= 6 ? IFill(fills[5]) : DEFAULT_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			var stroke:IStroke = strokes.length >= 6 ? IStroke(strokes[5]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(rbb.x, rbb.y);
			g.lineTo(rfb.x, rfb.y);
			g.lineTo(lfb.x, lfb.y);
			g.lineTo(lbb.x, lbb.y);
			
			if (fill)
				fill.end(g);
				
			//back-left face
			g.moveTo(lbb.x, lbb.y);
			fill = fills.length >= 5 ? IFill(fills[4]) : DEFAULT_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = strokes.length >= 5 ? IStroke(strokes[4]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(lfb.x, lfb.y);
			g.lineTo(lft.x, lft.y);
			g.lineTo(lbt.x, lbt.y);
			g.lineTo(lbb.x, lbb.y);
			
			if (fill)
				fill.end(g);
				
			//back-right face
			g.moveTo(lbb.x, lbb.y);
			fill = fills.length >= 4 ? IFill(fills[3]) : DEFAULT_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = strokes.length >= 4 ? IStroke(strokes[3]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(rbb.x, rbb.y);
			g.lineTo(rbt.x, rbt.y);
			g.lineTo(lbt.x, lbt.y);
			g.lineTo(lbb.x, lbb.y);
			
			if (fill)
				fill.end(g);
				
			//front-left face
			g.moveTo(lfb.x, lfb.y);
			fill = fills.length >= 3 ? IFill(fills[2]) : DEFAULT_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
			{
				if (fill is IBitmapFill)
				{
					var m:Matrix = IBitmapFill(fill).matrix ? IBitmapFill(fill).matrix : new Matrix();
					m.tx += lfb.x;
					m.ty += lfb.y;
					
					if (!IBitmapFill(fill).repeat)
					{
						//calculate how to stretch fill for face
						//this is not great OOP, sorry folks!
						
						
					}
					
					IBitmapFill(fill).matrix = m;
				}
				
				fill.begin(g);
			}
			
			stroke = strokes.length >= 3 ? IStroke(strokes[2]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(lft.x, lft.y);
			g.lineTo(rft.x, rft.y);
			g.lineTo(rfb.x, rfb.y);
			g.lineTo(lfb.x, lfb.y);
			
			if (fill)
				fill.end(g);
				
			//front-right face
			g.moveTo(rbb.x, rbb.y);
			fill = fills.length >= 2 ? IFill(fills[1]) : DEFAULT_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
			{
				if (fill is IBitmapFill)
				{
					m = IBitmapFill(fill).matrix ? IBitmapFill(fill).matrix : new Matrix();
					m.tx += lfb.x;
					m.ty += lfb.y;
					
					if (!IBitmapFill(fill).repeat)
					{
						//calculate how to stretch fill for face
						//this is not great OOP, sorry folks!
						
						
					}
					
					IBitmapFill(fill).matrix = m;
				}
				
				fill.begin(g);
			}
			
			stroke = strokes.length >= 2 ? IStroke(strokes[1]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(rfb.x, rfb.y);
			g.lineTo(rft.x, rft.y);
			g.lineTo(rbt.x, rbt.y);
			g.lineTo(rbb.x, rbb.y);
			
			if (fill)
				fill.end(g);
				
			//top face
			g.moveTo(lbt.x, lbt.y);
			fill = fills.length >= 1 ? IFill(fills[0]) : DEFAULT_FILL;
			if (fill && styleType != RenderStyleType.WIREFRAME)
			{
				if (fill is IBitmapFill)
				{
					m = IBitmapFill(fill).matrix ? IBitmapFill(fill).matrix : new Matrix();
					m.tx += lbt.x;
					m.ty += lbt.y;
					
					if (!IBitmapFill(fill).repeat)
					{
						
					}
					
					IBitmapFill(fill).matrix = m;
				}
				
				fill.begin(g);
			}
			
			stroke = strokes.length >= 1 ? IStroke(strokes[0]) : DEFAULT_STROKE;
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(rbt.x, rbt.y);
			g.lineTo(rft.x, rft.y);
			g.lineTo(lft.x, lft.y);
			g.lineTo(lbt.x, lbt.y);
			
			if (fill)
				fill.end(g);
		}
	}
}