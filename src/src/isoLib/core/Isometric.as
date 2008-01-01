package isoLib.core
{
	import com.jwopitz.geom.Pt;
	
	public class Isometric
	{
		public static function isoToMap (pt:Pt, createNew:Boolean = false):Pt
		{
			var z:Number = pt.z / Math.sqrt(1.25);
			var y:Number = (2 * pt.y - pt.x) / 2 + pt.z;
			var x:Number = pt.x + y;
			
			if (createNew)
				return new Pt(x, y, z);
			
			else
			{
				pt.x = x;
				pt.y = y;
				pt.z = z;
				
				return pt;
			}
		}
		
		public static function isoXToMapX (pt:Pt):Number
		{
			var y:Number = (2 * pt.y - pt.x) / 2 + pt.z;
			return pt.x + y;
		}
		
		public static function isoYToMapY (pt:Pt):Number
		{
			return (2 * pt.y - pt.x) / 2 + pt.z;
		}
		
		public static function isoZToMapZ (pt:Pt):Number
		{
			return pt.z;
		}
		
		public static function mapToIso (pt:Pt, createNew:Boolean = false):Pt
		{
			var z:Number = pt.z * Math.sqrt(1.25);
			var y:Number = 0.5 * (pt.x + pt.y) - z;
			var x:Number = pt.x - pt.y;
			
			if (createNew)
				return new Pt(x, y, z);
			
			else
			{
				pt.x = x;
				pt.y = y;
				pt.z = z;
				
				return pt;
			}
		}
		
		public static function mapXToIsoX (pt:Pt):Number
		{
			return pt.x - pt.y;
		}
		
		public static function mapYToIsoY (pt:Pt):Number
		{
			var z:Number;
			return 0.5 * (pt.x + pt.y) - pt.z;
		}
		
		public static function mapZToIsoZ (pt:Pt):Number
		{
			return pt.z;
		}
	}
}