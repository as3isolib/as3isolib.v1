package isoLib.primitive
{
	import com.jwopitz.geom.Pt;
	
	import isoLib.core.Isometric;
	
	public class IsoSquare extends IsoShape
	{
		override protected function pointLogic ():Boolean
		{
			pts = [];
			pts.push(new Pt(0, 0, 0));
			
			//width x length
			if (isoWidth > 0 && isoLength > 0 && isoHeight <= 0)
			{
				pts.push(new Pt(isoWidth, 0, 0));
				pts.push(new Pt(isoWidth, isoLength, 0));
				pts.push(new Pt(0, isoLength, 0));
			}
			
			//width x height
			else if (isoWidth > 0 && isoLength <= 0 && isoHeight > 0)
			{
				pts.push(new Pt(isoWidth, 0, 0));
				pts.push(new Pt(isoWidth, 0, isoHeight));
				pts.push(new Pt(0, 0, isoHeight));
			}
			
			//length x height
			else if (isoWidth <= 0 && isoLength > 0 && isoHeight > 0)
			{
				pts.push(new Pt(0, isoLength, 0));
				pts.push(new Pt(0, isoLength, isoHeight));
				pts.push(new Pt(0, 0, isoHeight));
			}
			
			else
				return false;
				
			var pt:Pt;
			for each (pt in pts)
				Isometric.mapToIso(pt);
				
			return true;
		}
		
		protected var iso:IsoPolygon;
		
		override public function renderWireframe ():void
		{
			if (!iso)
			{
				iso = new IsoPolygon();
				addChild(iso);
			}
			
			iso.gfx = gfx;
			iso.pts = pts;
			iso.type = type;
			iso.lineAlphas = lineAlphas;
			iso.lineColors = lineColors;
			iso.lineThicknesses = lineThicknesses;
			iso.faceAlphas = faceAlphas;
			iso.faceColors = faceColors;
			
			iso.render();
		}
		
		override public function renderShaded ():void
		{
			renderWireframe();
		}
		
		override public function renderSolid ():void
		{
			renderWireframe();
		}
	}
}