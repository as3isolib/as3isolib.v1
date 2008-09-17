package as3isolib.geom
{
	public class IsoMath
	{
		static public function screenToIso (screenPt:Pt, createNew:Boolean = false):Pt
		{
			var z:Number = screenPt.z;// / Math.sqrt(1.25);
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
		
		static public function isoToScreen (isoPt:Pt, createNew:Boolean = false):Pt
		{
			var z:Number = isoPt.z;// * Math.sqrt(1.25);
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