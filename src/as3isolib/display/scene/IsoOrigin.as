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
	import as3isolib.utils.IsoDrawingUtil;
	
	import flash.display.Graphics;
	
	/**
	 * IsoOrigin is a visual class that depicts the origin pt (typically at 0, 0, 0) with multicolored axis lines.
	 */
	public class IsoOrigin extends IsoPrimitive
	{
		/**
		 * @inheritDoc
		 */
		override protected function drawGeometry ():void
		{
			var pt0:Pt = IsoMath.isoToScreen(new Pt(-1 * axisLength, 0, 0));
			var ptM:Pt;
			var pt1:Pt = IsoMath.isoToScreen(new Pt(axisLength, 0, 0));
			
			var g:Graphics = container.graphics;
			g.clear();
			
			//draw x-axis
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0]);
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			
			g.lineStyle(0, 0, 0);
			g.moveTo(pt0.x, pt0.y);
			g.beginFill(lineColors[0], lineAlphas[0]);
			IsoDrawingUtil.drawIsoArrow(g, new Pt(-1 * axisLength, 0), 180, arrowLength, arrowWidth);
			g.endFill();
			
			g.moveTo(pt1.x, pt1.y);
			g.beginFill(lineColors[0], lineAlphas[0]);
			IsoDrawingUtil.drawIsoArrow(g, new Pt(axisLength, 0), 0, arrowLength, arrowWidth);
			g.endFill();
			
			//draw y-axis
			pt0 = IsoMath.isoToScreen(new Pt(0, -1 * axisLength, 0));
			pt1 = IsoMath.isoToScreen(new Pt(0, axisLength, 0));
			
			g.lineStyle(lineThicknesses[1], lineColors[1], lineAlphas[1]);
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			
			g.lineStyle(0, 0, 0);
			g.moveTo(pt0.x, pt0.y);
			g.beginFill(lineColors[1], lineAlphas[1]);
			IsoDrawingUtil.drawIsoArrow(g, new Pt(0, -1 * axisLength), 270, arrowLength, arrowWidth);
			g.endFill();
			
			g.moveTo(pt1.x, pt1.y);
			g.beginFill(lineColors[1], lineAlphas[1]);
			IsoDrawingUtil.drawIsoArrow(g, new Pt(0, axisLength), 90, arrowLength, arrowWidth);
			g.endFill();
			
			//draw z-axis
			pt0 = IsoMath.isoToScreen(new Pt(0, 0, -1 * axisLength));
			pt1 = IsoMath.isoToScreen(new Pt(0, 0, axisLength));
			
			g.lineStyle(lineThicknesses[2], lineColors[2], lineAlphas[2]);
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			
			g.lineStyle(0, 0, 0);
			g.moveTo(pt0.x, pt0.y);
			g.beginFill(lineColors[2], lineAlphas[2]);
			IsoDrawingUtil.drawIsoArrow(g, new Pt(0, 0, axisLength), 90, arrowLength, arrowWidth, IsoOrientation.XZ);
			g.endFill();
			
			g.moveTo(pt1.x, pt1.y);
			g.beginFill(lineColors[2], lineAlphas[2]);
			IsoDrawingUtil.drawIsoArrow(g, new Pt(0, 0, -1 * axisLength), 270, arrowLength, arrowWidth, IsoOrientation.YZ);
			g.endFill();
		}
		
		/**
		 * The length of each axis (not including the arrows).
		 */
		public var axisLength:Number = 100;
		
		/**
		 * The arrow length for each arrow found on each axis.
		 */
		public var arrowLength:Number = 20;
		
		/**
		 * The arrow width for each arrow found on each axis. 
		 * This is the total width of the arrow at the base.
		 */
		public var arrowWidth:Number = 3;
		
		/**
		 * Constructor
		 */
		public function IsoOrigin ()
		{
			super();
			
			lineThicknesses = [0, 0, 0]
			lineColors = [0xff0000, 0x00ff00, 0x0000ff];
			lineAlphas = [0.75, 0.75, 0.75];
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set width (value:Number):void
		{
			super.width = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set length (value:Number):void
		{
			super.length = 0;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set height (value:Number):void
		{
			super.height = 0;
		}
	}
}