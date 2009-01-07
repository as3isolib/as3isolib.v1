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
package as3isolib.display.scene
{
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.enum.IsoOrientation;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	import as3isolib.graphics.BitmapFill;
	import as3isolib.graphics.IFill;
	import as3isolib.graphics.IStroke;
	
	import flash.display.Graphics;
	import flash.geom.Matrix;

	public class IsoHexBox extends IsoPrimitive
	{
		static private var sin60:Number = Math.sin(Math.PI / 3);
		static private var cos60:Number = Math.cos(Math.PI / 3);
		
		//////////////////////////////////////////////////
		//	SIZE
		//////////////////////////////////////////////////
		
		private var diameter:Number;
		
		override public function set width (value:Number):void
		{
			diameter = value;
			
			var sideLength:Number = value / 2;
			isoLength = 2 * sin60 * sideLength;
						
			super.width = value;
		}
		
		override public function set length (value:Number):void
		{
			var sideLength:Number = value / 2 * sin60;
			isoWidth = diameter = 2 * sideLength;
			
			super.length = value;
		}
		
		//////////////////////////////////////////////////
		//	GEOMETRY
		//////////////////////////////////////////////////
		
		override protected function drawGeometry ():void
		{
			//calculate pts			
			var sideLength:Number = diameter / 2;
			
			var ptb0:Pt = new Pt(sideLength / 2, 0, 0);
			var ptb1:Pt = Pt.polar(ptb0, sideLength, 0);
			var ptb2:Pt = Pt.polar(ptb1, sideLength, Math.PI / 3);
			var ptb3:Pt = Pt.polar(ptb2, sideLength, 2 * Math.PI / 3);
			var ptb4:Pt = Pt.polar(ptb3, sideLength, Math.PI);
			var ptb5:Pt = Pt.polar(ptb4, sideLength, 4 * Math.PI / 3);
			
			var ptt0:Pt = new Pt(sideLength / 2, 0, height);
			var ptt1:Pt = Pt.polar(ptt0, sideLength, 0);
			var ptt2:Pt = Pt.polar(ptt1, sideLength, Math.PI / 3);
			var ptt3:Pt = Pt.polar(ptt2, sideLength, 2 * Math.PI / 3);
			var ptt4:Pt = Pt.polar(ptt3, sideLength, Math.PI);
			var ptt5:Pt = Pt.polar(ptt4, sideLength, 4 * Math.PI / 3);
			
			var pt:Pt;
			var pts:Array = new Array(ptb0, ptb1, ptb2, ptb3, ptb4, ptb5, ptt0, ptt1, ptt2, ptt3, ptt4, ptt5);
			for each (pt in pts)
				IsoMath.isoToScreen(pt);
			
			//draw bottom hex face
			var g:Graphics = mainContainer.graphics;
			g.clear();
			
			var stroke:IStroke = IStroke(strokes[2]);
			if (stroke)
				stroke.apply(g);
							
			var fill:IFill = IFill(fills[2]);
			if (fill)
			{
				if (fill is BitmapFill)
					BitmapFill(fill).orientation = IsoOrientation.XY;
				
				fill.begin(g);
			}
			
			g.moveTo(ptb0.x, ptb0.y);
			g.lineTo(ptb1.x, ptb1.y);
			g.lineTo(ptb2.x, ptb2.y);
			g.lineTo(ptb3.x, ptb3.y);
			g.lineTo(ptb4.x, ptb4.y);
			g.lineTo(ptb5.x, ptb5.y);
			g.lineTo(ptb0.x, ptb0.y);
			
			if (fill)
				fill.end(g);
			
			//draw side faces, orienting fills to face planes
			//face #6
			stroke = IStroke(strokes[1]);
			if (stroke)
				stroke.apply(g);
			
			fill = IFill(fills[1]);
			if (fill)
			{
				if (fill is BitmapFill)
					BitmapFill(fill).matrix = new Matrix(1, Pt.theta(ptb4, ptb5), 0, 1, 0, 0);
				
				fill.begin(g);
			}
			
			g.moveTo(ptb4.x, ptb4.y);
			g.lineTo(ptb5.x, ptb5.y);
			g.lineTo(ptt5.x, ptt5.y);
			g.lineTo(ptt4.x, ptt4.y);
			g.lineTo(ptb4.x, ptb4.y);
			
			//face #1
			if (fill)
			{
				fill.end(g);
				
				if (fill is BitmapFill)
					BitmapFill(fill).matrix = new Matrix(1, Pt.theta(ptb5, ptb0), 0, 1, 0, 0);
				
				fill.begin(g);
			}
			
			g.moveTo(ptb0.x, ptb0.y);
			g.lineTo(ptb5.x, ptb5.y);
			g.lineTo(ptt5.x, ptt5.y);
			g.lineTo(ptt0.x, ptt0.y);
			g.lineTo(ptb0.x, ptb0.y);
			
			//face #2
			if (fill)
			{
				fill.end(g);
				
				if (fill is BitmapFill)
					BitmapFill(fill).orientation = IsoOrientation.XZ;
				
				fill.begin(g);
			}
			
			g.moveTo(ptb0.x, ptb0.y);
			g.lineTo(ptb1.x, ptb1.y);
			g.lineTo(ptt1.x, ptt1.y);
			g.lineTo(ptt0.x, ptt0.y);
			g.lineTo(ptb0.x, ptb0.y);
			
			//face #3
			if (fill)
			{
				fill.end(g);
				
				if (fill is BitmapFill)
					BitmapFill(fill).matrix = new Matrix(1, Pt.theta(ptb2, ptb3), 0, 1, 0, 0);
				
				fill.begin(g);
			}
			
			g.moveTo(ptb1.x, ptb1.y);
			g.lineTo(ptb2.x, ptb2.y);
			g.lineTo(ptt2.x, ptt2.y);
			g.lineTo(ptt1.x, ptt1.y);
			g.lineTo(ptb1.x, ptb1.y);
			
			//face #4
			if (fill)
			{
				fill.end(g);
				
				if (fill is BitmapFill)
					BitmapFill(fill).matrix = new Matrix(1, Pt.theta(ptb3, ptb2), 0, 1, 0, 0);
				
				fill.begin(g);
			}
			
			g.moveTo(ptb2.x, ptb2.y);
			g.lineTo(ptb3.x, ptb3.y);
			g.lineTo(ptt3.x, ptt3.y);
			g.lineTo(ptt2.x, ptt2.y);
			g.lineTo(ptb2.x, ptb2.y);
			
			//face #5
			if (fill)
			{
				fill.end(g);
				
				if (fill is BitmapFill)
					BitmapFill(fill).orientation = IsoOrientation.XZ;
				
				fill.begin(g);
			}
			
			g.moveTo(ptb3.x, ptb3.y);
			g.lineTo(ptb4.x, ptb4.y);
			g.lineTo(ptt4.x, ptt4.y);
			g.lineTo(ptt3.x, ptt3.y);
			g.lineTo(ptb3.x, ptb3.y);
			
			if (fill)
				fill.end(g);
			
			//top hex
			stroke = IStroke(strokes[0]);
			if (stroke)
				stroke.apply(g);
			
			fill = IFill(fills[0]);
			if (fill)
			{
				if (fill is BitmapFill)
					BitmapFill(fill).orientation = IsoOrientation.XY;
				
				fill.begin(g);
			}
			
			g.moveTo(ptt0.x, ptt0.y);
			g.lineTo(ptt1.x, ptt1.y);
			g.lineTo(ptt2.x, ptt2.y);
			g.lineTo(ptt3.x, ptt3.y);
			g.lineTo(ptt4.x, ptt4.y);
			g.lineTo(ptt5.x, ptt5.y);
			g.lineTo(ptt0.x, ptt0.y);
			
			if (fill)
				fill.end(g);
		}
		
		//////////////////////////////////////////////////
		//	CONSTRUCTOR
		//////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoHexBox ()
		{
			super();
		}
	}
}