package isoLib.utils
{
	import com.jwopitz.geom.Pt;
	
	public class IsoUtil
	{
		static public var zRatio:Number = 2;
		static public var xyRation:Number;
		
		static private const ALPHA:Number = Math.asin(Math.tan(Math.PI / 6));
		static private const BETA:Number = Math.PI / 4;
		
		static public function getDepth (isoPt:Pt):int
		{
			var x:Number = isoPt.x; //c.isoX;
			var y:Number = isoPt.z// * -1; //c.isoZ;
			var z:Number = isoPt.y// * -1; //c.isoY;
			
			var a:int = 10;
			var b:int = 10;
			
			var floor:Number = a * (b - 1) + x;
			var depth:Number = a * (z - 1) + x + floor * y;
			
			return depth;
		}
		
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
			var y:Number = 0.5 * (isoPt.x + isoPt.y) - z;
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