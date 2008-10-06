package as3isolib.display.renderers
{
	import as3isolib.bounds.IBounds;
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.core.as3isolib_internal;
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.geom.Pt;
	
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	
	use namespace as3isolib_internal;
	
	/**
	 * The DefaultSceneLayoutRenderer is the default renderer responsible for performing the isometric position-based depth sorting on the child objects of the target IIsoScene. 
	 */
	public class DefaultSceneLayoutRenderer extends EventDispatcher implements ISceneRenderer
	{		
		////////////////////////////////////////////////////
		//	TARGET
		////////////////////////////////////////////////////
		
		private var targetContainer:IIsoScene;
		
		/**
		 * @private
		 */
		public function get target ():IIsoScene
		{
			return targetContainer;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set target (value:IIsoScene):void
		{
			targetContainer = value;
		}
		
		////////////////////////////////////////////////////
		//	UPDATE LAYOUT
		////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function renderScene ():void
		{
			var time:int = getTimer();
			var sortedChildren:Array = targetContainer.children.slice();	
			
			var camera:Pt = new Pt(100000, 100000, 100000);
			var child:IIsoDisplayObject;
			for each (child in sortedChildren)
			{
				child.distance = -1 * Math.sqrt
								(
									Math.pow(camera.x - child.isoBounds.right, 2) + 
									Math.pow(camera.y - child.isoBounds.front, 2) + 
									Math.pow(camera.z - child.isoBounds.bottom, 2)
								);
			}
			
			trace("distance assignment:", getTimer() - time, "milliseconds");
					
			//sortedChildren.sortOn(["x", "y", "z"], Array.NUMERIC);
			sortedChildren.sortOn(["distance", "screenX", "screenY"], Array.NUMERIC);
			sortedChildren.sort(isoDepthSort);
			
			trace("sort:", getTimer() - time, "milliseconds");
			
			var i:uint;
			var m:uint = sortedChildren.length;
			while (i < m)
			{
				targetContainer.setChildIndex(IIsoDisplayObject(sortedChildren[i]), i);
				i++;
			}
			
			trace("index assignment:", getTimer() - time, "milliseconds");
		}
		
		////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function DefaultSceneLayoutRenderer ()
		{
			super();
		}
		
		////////////////////////////////////////////////////
		//	SORT
		////////////////////////////////////////////////////
		
		private function isoDepthSort (childA:Object, childB:Object):int
		{
			var boundsA:IBounds;
			var boundsB:IBounds;
			
			trace(childA.id, childB.id);
			
			if (childA.container.hitTestObject(childB.container))
			{
				boundsA = childA.isoBounds;
				boundsB = childB.isoBounds;
				
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