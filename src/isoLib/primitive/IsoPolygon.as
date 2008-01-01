package isoLib.primitive
{
	import com.jwopitz.geom.Pt;
	
	import flash.display.Graphics;
	
	import isoLib.core.IsoType;
	import isoLib.core.Isometric;
	
	public class IsoPolygon extends IsoShape
	{
		override protected function pointLogic ():Boolean
		{
			if (pts.length <= 2)
				return false;
			
			/*var pt:Pt;
			for each (pt in pts)
				Isometric.mapToIso(pt);*/
				
			return true;
		}
		
		override public function renderWireframe ():void
		{
			var g:Graphics = gfx;
			
			g.clear();
			g.moveTo(pts[0].x, pts[0].y);
			
			if (type == IsoType.SOLID)
				g.beginFill(0xFFFFFF, faceAlphas[0]);
				
			else if (type == IsoType.SHADED)
				g.beginFill(faceColors[0], faceAlphas[0]);
			
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0]);
			
			var i:uint = 1;
			var l:uint = pts.length;
			for (i; i < l; i++)
				g.lineTo(pts[i].x, pts[i].y);
				
			g.lineTo(pts[0].x, pts[0].y);
			
			if (type == IsoType.SOLID || type == IsoType.SHADED)
				g.endFill();
		}
		
		override public function renderSolid ():void
		{
			renderWireframe();
		}
		
		override public function renderShaded ():void
		{
			renderWireframe();
		}
	}
}