package isoLib.primitive
{
	import com.jwopitz.geom.Pt;
	
	import flash.display.Graphics;
	
	import isoLib.core.shape.IsoType;
	import isoLib.core.shape.Primitive;
	import isoLib.utils.IsoUtil;
	
	public class IsoPolygon extends Primitive
	{
		override protected function validateGeometry ():Boolean
		{
			if (pts.length <= 2)
				return false;
			
			/*var pt:Pt;
			for each (pt in pts)
				Isometric.mapToIso(pt);*/
				
			return true;
		}
		
		public function convertPts ():void
		{
			var pt:Pt;
			for each (pt in pts)
				IsoUtil.mapToIso(pt);
		}
		
		override protected function renderGeometry():void
		{
			var g:Graphics = container.graphics;
			
			g.clear();
			g.moveTo(pts[0].x, pts[0].y);
			
			if (type == IsoType.SOLID)
				g.beginFill(solidColors[0], faceAlphas[0]);
				
			else if (type == IsoType.SHADED)
				g.beginFill(shadedColors[0], faceAlphas[0]);
			
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0]);
			
			var i:uint = 1;
			var l:uint = pts.length;
			for (i; i < l; i++)
				g.lineTo(pts[i].x, pts[i].y);
				
			g.lineTo(pts[0].x, pts[0].y);
			
			if (type == IsoType.SOLID || type == IsoType.SHADED)
				g.endFill();
		}
	}
}