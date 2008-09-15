package isoLib.primitive
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	
	import isoLib.core.shape.Primitive;
	import isoLib.events.IsoEvent;
	import isoLib.style.RenderStyle;
	
	public class IsoPolygon extends Primitive
	{
		/**
		 * @inheritDoc
		 */
		override protected function validateGeometry ():Boolean
		{
			if (pts.length <= 2)
				return false;
			
			/*var pt:Pt;
			for each (pt in pts)
				Isometric.mapToIso(pt);*/
			
			return true;
		}
		
		/**
		 * Since IsoPolygons comprise the base structure for other isometric primitives it is necessary to delay conversion of the points in some instances.
		 */
		/* public function convertPts ():void
		{
			var pt:Pt;
			for each (pt in pts)
				IsoUtil.mapToIso(pt);
		} */
		
		/**
		 * @inheritDoc
		 */
		override protected function renderGeometry():void
		{
			var g:Graphics = container.graphics;
			
			g.clear();
			g.moveTo(pts[0].x, pts[0].y);
			
			if (renderStyle == RenderStyle.SOLID)
				g.beginFill(solidColors[0], faceAlphas[0]);
				
			else if (renderStyle == RenderStyle.SHADED)
				g.beginFill(shadedColors[0], faceAlphas[0]);
			
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0], true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.ROUND);
			
			var i:uint = 1;
			var l:uint = pts.length;
			for (i; i < l; i++)
				g.lineTo(pts[i].x, pts[i].y);
				
			g.lineTo(pts[0].x, pts[0].y);
			
			if (renderStyle == RenderStyle.SOLID || renderStyle == RenderStyle.SHADED)
				g.endFill();
		}
	}
}