package as3isolib.utils
{
	import as3isolib.bounds.IBounds;
	import as3isolib.display.IIsoDisplayObject;
	
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	
	public class IsoUtil
	{
		static public function isoDepthSort (childA:IIsoDisplayObject, childB:IIsoDisplayObject):int
		{
			var rectA:Rectangle = childA.container.getRect(childA.container.stage);
			var rectB:Rectangle = childB.container.getRect(childA.container.stage);
			if (rectA.intersects(rectB))
			{
				var boundsA:IBounds = childA.bounds;
				var boundsB:IBounds = childB.bounds;
				
				if (boundsA.right <= boundsB.left)
					return -1;
					
				else if (boundsA.left >= boundsB.right)
					return 1;
				
				else if (boundsA.front <= boundsB.back)
					return -1;
					
				else if (boundsA.back >= boundsB.front)
					return 1;
					
				else if (boundsA.top <= boundsB.bottom)
					return -1;
					
				else if (boundsA.bottom >= boundsB.top)
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
	}
}