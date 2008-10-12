/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 J.W.Opitz, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
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