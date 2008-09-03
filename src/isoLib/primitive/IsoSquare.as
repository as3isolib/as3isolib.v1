package isoLib.primitive
{
	import com.jwopitz.geom.Pt;
	
	import isoLib.core.shape.Primitive;
	import isoLib.utils.IsoUtil;
	
	public class IsoSquare extends Primitive
	{
		protected var iso:IsoPolygon;
		
		override protected function createChildren ():void
		{
			super.createChildren();
			
			if (!iso)
			{
				iso = new IsoPolygon();
				addChild(iso);
			}
		}
		
		override protected function validateGeometry ():Boolean
		{
			pts = [];
			pts.push(new Pt(0, 0, 0));
			
			//width x length
			if (width > 0 && length > 0 && height <= 0)
			{
				pts.push(new Pt(width, 0, 0));
				pts.push(new Pt(width, length, 0));
				pts.push(new Pt(0, length, 0));
			}
			
			//width x height
			else if (width > 0 && length <= 0 && height > 0)
			{
				pts.push(new Pt(width, 0, 0));
				pts.push(new Pt(width, 0, height));
				pts.push(new Pt(0, 0, height));
			}
			
			//length x height
			else if (width <= 0 && length > 0 && height > 0)
			{
				pts.push(new Pt(0, length, 0));
				pts.push(new Pt(0, length, height));
				pts.push(new Pt(0, 0, height));
			}
			
			else
				return false;
				
			var pt:Pt;
			for each (pt in pts)
				IsoUtil.mapToIso(pt);
				
			return true;
		}
		
		override protected function renderGeometry ():void
		{			
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