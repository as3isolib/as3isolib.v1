package as3isolib.geom
{
	public class IsoMath
	{
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
		
		static public function intersection (lineA0:Pt, lineA1:Pt, lineB0:Pt, lineB1:Pt):Pt
		{
			var slopeA:Number = (lineA1.y - lineA0.y) / (lineA1.x - lineA0.x);
			var slopeB:Number = (lineB1.y - lineB0.y) / (lineB1.x - lineB0.x);
			
			var yIntercept0:Number = lineA1.y - slopeA * lineA1.x;
			var yIntercept1:Number = lineB1.y - slopeB * lineB1.x;
			
					
			
			
			return new Pt();
		}
	}
}