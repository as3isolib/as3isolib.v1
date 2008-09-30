package as3isolib.geom
{
	/**
	 * IsoMath provides functions for converting pts back and forth between 3D isometric space and cartesian coordinates.
	 */
	public class IsoMath
	{
		/**
		 * Converts a given pt in cartesian coordinates to 3D isometric space.
		 * 
		 * @param screenPt The pt in cartesian coordinates.
		 * @param createNew Flag indicating whether to affect the provided pt or to return a converted copy.
		 * @return pt A pt in 3D isometric space.
		 */
		static public function screenToIso (screenPt:Pt, createNew:Boolean = false):Pt
		{
			var z:Number = screenPt.z / Math.sqrt(1.25);
			var y:Number = (2 * screenPt.y - screenPt.x) / 2 + screenPt.z;
			var x:Number = screenPt.x + y;
			
			if (createNew)
				return new Pt(x, y, z);
			
			else
			{
				screenPt.x = x;
				screenPt.y = y;
				screenPt.z = z;
				
				return screenPt;
			}
		}
		
		/**
		 * Converts a given pt in 3D isometric space to cartesian coordinates.
		 * 
		 * @param isoPt The pt in 3D isometric space.
		 * @param createNew Flag indicating whether to affect the provided pt or to return a converted copy.
		 * @return pt A pt in cartesian coordinates.
		 */
		static public function isoToScreen (isoPt:Pt, createNew:Boolean = false):Pt
		{
			var z:Number = isoPt.z * Math.sqrt(1.25);
			var y:Number = 0.5 * (isoPt.x + isoPt.y) - isoPt.z;
			var x:Number = isoPt.x - isoPt.y;
			
			if (createNew)
				return new Pt(x, y, z);
			
			else
			{
				isoPt.x = x;
				isoPt.y = y;
				isoPt.z = z;
				
				return isoPt;
			}
		}
	}
}