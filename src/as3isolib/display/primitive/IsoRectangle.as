package as3isolib.display.primitive
{
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	/**
	 * 3D square primitive in isometric space.
	 */
	public class IsoRectangle extends IsoPolygon
	{
		/**
		 * @inheritDoc
		 */
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
				IsoMath.isoToScreen(pt);
				
			return true;
		}
		
		/**
		 * @constructor
		 */
		public function IsoRectangle ()
		{
			super();
			
			width = length = height = 0;
		}
	}
}