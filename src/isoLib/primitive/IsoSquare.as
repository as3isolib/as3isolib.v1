package isoLib.primitive
{
	import com.jwopitz.geom.Pt;
	
	import isoLib.utils.IsoUtil;
	
	public class IsoSquare extends IsoShape
	{
		override protected function validateGeometry ():Boolean
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
				IsoUtil.mapToIso(pt);
				
			return true;
		}
		
		protected var iso:IsoPolygon;
		
		override protected function renderGeometry ():void
		{
			if (!iso)
			{
				iso = new IsoPolygon();
				addChild(iso);
			}
			
			iso.pts = pts;
			iso.type = type;
			iso.lineAlphas = [lineAlphas[0]];
			iso.lineColors = [lineColors[0]];
			iso.lineThicknesses = [lineThicknesses[0]];
			iso.faceAlphas = [faceAlphas[0]];
			iso.solidColors = [solidColors[0]];
			iso.shadedColors = [shadedColors[0]];
			
			iso.render();
		}
	}
}