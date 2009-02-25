package as3isolib.graphics
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.geom.ColorTransform;
	import flash.utils.Dictionary;

	public class BasicSpriteAsset implements ISpriteAsset
	{
		static private var nonUniqueInstances:Dictionary = new Dictionary(true);
		
		//////////////////////////////////////////////	
		//	CONSTRUCTOR
		//////////////////////////////////////////////
		
		private var src:Object
		
		private var bCache:Boolean = true;
		private var bUnique:Boolean = false;
		
		private var ox:Number = 0;
		private var oy:Number = 0;
		
		private var ct:ColorTransform;
		
		public function BasicSpriteAsset (source:Object, cacheAsBitmap:Boolean = true, isUnique:Boolean = false, offsetX:Number = 0, offsetY:Number = 0, colorTransform:ColorTransform = null)
		{
			src = source;
			bCache = cacheAsBitmap;
			bUnique = isUnique;
			ox = offsetX;
			oy = offsetY;
			ct = colorTransform;
		}
		
		//////////////////////////////////////////////	
		//	DRAW
		//////////////////////////////////////////////
		
		public function get asset ():DisplayObject
		{
			var instance:DisplayObject;
			
			if (src is Class)
			{
				var SrcClass:Class = src as Class;
				instance = DisplayObject(new SrcClass());
			}
			
			else if (src is BitmapData)
			{
				
			}
			
			else if (src is Bitmap)
			{
				
			}
			
			else if (src is DisplayObject)
			{
				
			}
			
			return null;
		}
	}
}