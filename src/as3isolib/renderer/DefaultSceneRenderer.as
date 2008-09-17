package as3isolib.renderer
{
	import as3isolib.bounds.IBounds;
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.display.IRenderer;
	
	import flash.events.EventDispatcher;

	public class DefaultSceneRenderer extends EventDispatcher implements ISceneRenderer
	{		
		public function renderScene (objects:Array):Array
		{
			return objects.slice().sort(isoDepthSort);
		}
		
		private var scene:IRenderer;
		
		public function DefaultSceneRenderer ()
		{
			super();
		}
		
		private function isoDepthSort (childA:IIsoDisplayObject, childB:IIsoDisplayObject):int
		{
			var boundsA:IBounds = childA.isoBounds;
			var boundsB:IBounds = childB.isoBounds;
			
			if (childA.container.hitTestObject(childB.container))
			{
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