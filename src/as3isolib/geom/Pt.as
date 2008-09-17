package as3isolib.geom
{
	import flash.geom.Point;
	
	public class Pt extends Point
	{		
		///////////////////////////////////////////////
		//	CALCULATIONS
		///////////////////////////////////////////////
		
		static public function distance (ptA:Pt, ptB:Pt):Number
		{
			var tx:Number = ptB.x - ptA.x;
			var ty:Number = ptB.y - ptA.y;
			var tz:Number = ptB.z - ptA.z;
			
			return Math.sqrt(tx * tx + ty * ty + tz * tz);
		}
		
		static public function theta (ptA:Pt, ptB:Pt):Number
		{
			var tx:Number = ptB.x - ptA.x;
			var ty:Number = ptB.y - ptA.y;
			
			var radians:Number = Math.atan(ty / tx);
			if (tx < 0)
				radians += Math.PI;
			
			if (tx >= 0 && ty < 0)
				radians += Math.PI * 2;
				
			return radians;
		}
		
		static public function angle (ptA:Pt, ptB:Pt):Number
		{
			return theta(ptA, ptB) * 180 / Math.PI;
		}
		
		/**
		 * @param theta The amount of rotation in radians perpendicular to the X-Y plane.
		 * @param gamma The amount of rotation in radians perpendicular to the plane established by the new point's x & y coordinates
		 */
		static public function polar (originPt:Pt, radius:Number, theta:Number, gamma:Number = 0):Pt
		{
			var tx:Number = originPt.x + Math.cos(theta) * radius;
			var ty:Number = originPt.y + Math.sin(theta) * radius;
			
			return new Pt(tx, ty, 0);
		}
		
		static public function interpolate (ptA:Pt, ptB:Pt, f:Number):Pt
		{
			if (f <= 0)
				return ptA;
				
			if (f >= 1)
				return ptB;
				
			var nx:Number = (ptB.x - ptA.x) * f + ptA.x;	
			var ny:Number = (ptB.y - ptA.y) * f + ptA.y;	
			var nz:Number = (ptB.z - ptA.z) * f + ptA.z;
			
			return new Pt(nx, ny, nz);
		}
		
		///////////////////////////////////////////////
		//	X, Y, Z
		///////////////////////////////////////////////
		
		public var z:Number = 0;
		
		override public function get length ():Number
		{
			return Math.sqrt(x * x + y * y + z * z);
		}
		
		override public function clone ():Point
		{
			return new Pt(x, y, z);
		}
		
		///////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////
		
		public function Pt (x:Number = 0, y:Number = 0, z:Number = 0)
		{
			super();
			
			this.x = x;
			this.y = y;
			this.z = z;
		}
	}
}