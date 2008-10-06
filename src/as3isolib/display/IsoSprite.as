package as3isolib.display
{
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.core.as3isolib_internal;
	
	import flash.display.DisplayObject;
	
	use namespace as3isolib_internal;
	
	/**
	 * IsoSprite is the base class in which visual assets may be attached to be presented in 3D isometric space.
	 * Since visual assets may not clearly define a volume in 3D isometric space, the developer is responsible for establishing the width, length and height properties.
	 */
	public class IsoSprite extends IsoDisplayObject
	{
		////////////////////////////////////////////////////////////
		//	SKINS
		////////////////////////////////////////////////////////////
		
		as3isolib_internal var spritesArray:Array = [];	
		
		/**
		 * @private
		 */
		public function get sprites ():Array
		{
			return spritesArray;
		}
		
		/**
		 * An array of visual assets to be attached.
		 * Elements in the array are expected be of type DisplayObject or Class (cast to a DisplayObject upon instantiation).
		 */
		public function set sprites (value:Array):void
		{
			if (spritesArray != value)
			{
				spritesArray = value;
				bSkinsInvalidated = true;
			}
		}
		
		////////////////////////////////////////////////////////////
		//	INVALIDATION
		////////////////////////////////////////////////////////////
		
		as3isolib_internal var bSkinsInvalidated:Boolean = false;
		
		/**
		 * Invalidates the skins of the IIsoDisplayObject.
		 */
		public function invalidateSkins ():void
		{
			bSkinsInvalidated = true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get isInvalidated ():Boolean
		{
			return (bPositionInvalidated || bSkinsInvalidated);
		}
		
		////////////////////////////////////////////////////////////
		//	RENDER
		////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			if (bSkinsInvalidated)
			{
				//remove all previous skins				
				while (container.numChildren > 0)
					container.removeChildAt(container.numChildren - 1);
				
				var sprite:Object;
				for each (sprite in spritesArray)
				{
					if (sprite is DisplayObject)
						container.addChild(sprite as DisplayObject);
					
					else if (sprite is Class)
					{
						var spriteInstance:DisplayObject = DisplayObject(new sprite());
						container.addChild(spriteInstance);
					}
					
					else
						throw new Error("skin asset is not of the following types: DisplayObject or Class cast as DisplayOject.");
				}
				
				bSkinsInvalidated = false;
			}
			
			super.render(recursive);
		}
		
		////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoSprite ()
		{
			super();
		}
	}
}