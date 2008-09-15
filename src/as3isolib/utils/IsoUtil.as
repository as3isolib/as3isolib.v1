package isoLib.utils
{
	import com.jwopitz.geom.Pt;
	
	import flash.geom.Rectangle;
	
	import isoLib.core.shape.IPrimitive;
	
	public class IsoUtil
	{
		static public var zRatio:Number = 2;
		static public var xyRation:Number;
		
		static public function compareDepths (childA:IPrimitive, childB:IPrimitive):int
		{
			if (hitTest(childA, childB))
			{
				if (childA.right <= childB.left)
					return -1;
					
				else if (childA.left >= childB.right)
					return 1;
				
				else if (childA.front <= childB.back)
					return -1;
					
				else if (childA.back >= childB.front)
					return 1;
					
				else if (childA.top <= childB.bottom)
					return -1;
					
				else if (childA.bottom >= childB.top)
					return 1;
				
				else
					return 0;
			}			
			
			//else simple positioning sort
			else
			{
				if (childA.screenY > childB.screenY)
					return 1;
					
				else if (childA.screenY < childB.screenY)
					return -1;
				
				else
				{
					if (childA.screenX > childB.screenX)
						return 1;
						
					else if (childA.screenX < childB.screenX)
						return -1;
						
					else 
						return 0;
				}
			}
		}
		
		static public function hexagonalHitTest (childA:IPrimitive, childB:IPrimitive):Boolean
		{
			/* 1. [xA−y'A,x'A−yA] and [xB−y'B,x'B−yB] overlap, and
			2. [xA−z'A,x'A−zA] and [xB−z'B,x'B−zB] overlap, and
			3. [−y'A+zA,−yA+z'A] and [−y'B+zB,−yB+z'B] overlap. 
			
			[a,b] and [c,d] overlap" is:
			(a ≤ c ≤ b) or (c ≤ a ≤ d) */
						
			var overlaps:Array = [false, false, false];
			
			var a:Number = childA.x - childA.front
			var b:Number = childA.right - childA.y;
			var c:Number = childB.x - childB.front;
			var d:Number = childB.right - childB.y;
			if ((a <= c && c <= b) || (c <= a && a <= d))
				overlaps[0] = true;
				
			a = childA.x - childA.top;
			b = childA.right - childA.z;
			c = childB.x - childB.top;
			d = childB.right - childB.z;
			if ((a <= c && c <= b) || (c <= a && a <= d))
				overlaps[1] = true;
				
			a = -1 * childA.front + childA.z;
			b = -1 * childA.y + childA.top;
			c = -1 * childB.front + childB.z;
			d = -1 * childB.y + childB.top;
			if ((a <= c && c <= b) || (c <= a && a <= d))
				overlaps[2] = true;
			
			return (overlaps[0] && overlaps[1] && overlaps[2]);
		}
		
		static public function hitTest (childA:IPrimitive, childB:IPrimitive):Boolean
		{
			var rectA:Rectangle = childA.container.getBounds(childA.container.parent);
			var rectB:Rectangle = childB.container.getBounds(childB.container.parent);
			return rectA.intersects(rectB);
		}
		
		static public function spacialHitTest (childA:IPrimitive, childB:IPrimitive):Boolean
		{
			var axialDistance:Number;
			var axialSums:Number;
			
			var hasXAxisOverlap:Boolean = false;
			var hasYAxisOverlap:Boolean = false;
			var hasZAxisOverlap:Boolean = false;
			
			axialDistance = Math.abs((childA.x + childA.width / 2) - (childB.x + childB.width / 2));
			axialSums = childA.width / 2 + childB.width / 2;
			if (axialDistance < axialSums)
				hasXAxisOverlap = true;
			
			axialDistance = Math.abs((childA.y + childA.length / 2) - (childB.y + childB.length / 2));
			axialSums = childA.length / 2 + childB.length / 2;
			if (axialDistance < axialSums)
				hasYAxisOverlap = true;
				
			axialDistance = Math.abs((childA.z + childA.height / 2) - (childB.z + childB.height / 2));
			axialSums = childA.height / 2 + childB.height / 2;
			if (axialDistance < axialSums)
				hasZAxisOverlap = true;
				
			if (hasXAxisOverlap && hasYAxisOverlap && hasZAxisOverlap)
				return true;
			
			else
				return false;
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
		
		/* static public function convertAll (pts:Array, isoToScreen:Boolean = true, createNew:Boolean = true):Array
		{
			
		} */
		
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