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
	import as3isolib.graphics.IFill;
	import as3isolib.graphics.IStroke;
	
	import flash.display.Graphics;
	
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
			/* var g:Graphics = mainContainer.graphics;
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
			
			var stroke:IStroke = edges.length >= 6 ? IStroke(edges[5]) : DEFAULT_STROKE;
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
			fill = IFill(fills[4]);
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = IStroke(edges[4]);
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
			fill = IFill(fills[3]);
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = IStroke(edges[3]);
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
			fill = IFill(fills[2]);
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = IStroke(edges[2]);
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
			fill = IFill(fills[1]);
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = IStroke(edges[1]);
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
			fill = IFill(fills[0]);
			if (fill && styleType != RenderStyleType.WIREFRAME)
				fill.begin(g);
			
			stroke = IStroke(edges[0]);
			if (stroke)
				stroke.apply(g);
				
			g.lineTo(rbt.x, rbt.y);
			g.lineTo(rft.x, rft.y);
			g.lineTo(lft.x, lft.y);
			g.lineTo(lbt.x, lbt.y);
			
			if (fill)
				fill.end(g); */
			
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
				
				sq.strokes = strokes[c] ? [strokes[c]] : [strokes[0]];
				sq.fills = fills[c] ? [fills[c]] : [fills[0]];
				sq.styleType = styleType;
				
				c++;
			}
		}
	}
}