/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 - 2008 J.W.Opitz, All Rights Reserved.

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
package as3isolib.display.primitive
{
	import as3isolib.bounds.PrimitiveBounds;
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.core.IsoDisplayObject;
	import as3isolib.core.as3isolib_internal;
	import as3isolib.enum.RenderStyleType;
	import as3isolib.events.IsoEvent;
	
	use namespace as3isolib_internal;
	
	/**
	 * IsoPrimitive is the base class for primitive-type classes that will make great use of Flash's drawing API.
	 * Developers should not directly instantiate this class but rather extend it or one of the other primitive-type subclasses.
	 */
	public class IsoPrimitive extends IsoDisplayObject implements IIsoPrimitive
	{
		////////////////////////////////////////////////////////////////////////
		//	CONSTANTS
		////////////////////////////////////////////////////////////////////////
		
		static public const DEFAULT_WIDTH:Number = 25;
		static public const DEFAULT_LENGTH:Number = 25;
		static public const DEFAULT_HEIGHT:Number = 25;
		
		//////////////////////////////////////////////////////
		// STYLES
		//////////////////////////////////////////////////////
		
		private var renderStyle:String = RenderStyleType.SHADED;
		
		/**
		 * @private
		 */
		public function get styleType ():String
		{
			return renderStyle;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set styleType (value:String):void
		{
			if (renderStyle != value)
			{
				renderStyle = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// LINE STYLES
		//////////////////////////////////////////////////////
		
		[ArrayElementType("uint")]
		private var lineThicknessesArray:Array = [0, 0, 0, 0, 0, 0];
		
		/**
		 * @private
		 */
		public function get lineThicknesses ():Array
		{
			return lineThicknessesArray;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set lineThicknesses (value:Array):void
		{
			if (lineThicknessesArray != value)
			{
				lineThicknessesArray = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		[ArrayElementType("uint")]
		private var lineColorArray:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,];
		
		/**
		 * @private
		 */
		public function get lineColors ():Array
		{
			return lineColorArray;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set lineColors (value:Array):void
		{
			if (lineColorArray != value)
			{
				lineColorArray = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		[ArrayElementType("Number")]
		private var lineAlphasArray:Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
		
		/**
		 * @private
		 */
		public function get lineAlphas ():Array
		{
			return lineAlphasArray;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set lineAlphas (value:Array):void
		{
			if (lineAlphasArray != value)
			{
				lineAlphasArray = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// FACE STYLES
		//////////////////////////////////////////////////////
		
		[ArrayElementType("uint")]
		private var solidColorArray:Array = [0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff];
		
		[ArrayElementType("uint")]
		private var shadedColorArray:Array = [0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xcccccc, 0xcccccc];
		
		/**
		 * @private
		 */
		public function get faceColors ():Array
		{
			return shadedColorArray;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set faceColors (value:Array):void
		{
			if (shadedColorArray != value)
			{
				shadedColorArray = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		[ArrayElementType("Number")]
		private var faceAlphasArray:Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
		
		/**
		 * @private
		 */
		public function get faceAlphas ():Array
		{
			return faceAlphasArray;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set faceAlphas (value:Array):void
		{
			if (faceAlphasArray != value)
			{
				faceAlphasArray = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		/////////////////////////////////////////////////////////
		//	RENDER
		/////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			if (!hasParent)
				return;
			
			//we do this before calling super.render() so as to only perform drawing logic for the size or style invalidation, not both.
			if (bSizeInvalidated || bSytlesInvalidated)
			{
				if (!validateGeometry())
					throw new Error("validation of geometry failed.");
				
				drawGeometry();
				validateSize();
				
				bSizeInvalidated = false;
				bSytlesInvalidated = false;
			}
			
			super.render(recursive);
		}
		
		/////////////////////////////////////////////////////////
		//	VALIDATION
		/////////////////////////////////////////////////////////
		
		
		/**
		 * For IIsoDisplayObject that make use of Flash's drawing API, validation of the geometry must occur before being rendered.
		 * 
		 * @return Boolean Flag indicating if the geometry is valid.
		 */
		protected function validateGeometry ():Boolean
		{
			//overridden by subclasses
			return true;	
		}
		
		/**
		 * @inheritDoc
		 */
		protected function drawGeometry ():void
		{
			//overridden by subclasses
		}
		
		////////////////////////////////////////////////////////////
		//	INVALIDATION
		////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		as3isolib_internal var bSytlesInvalidated:Boolean = false;
		
		/**
		 * @inheritDoc
		 */
		public function invalidateStyles ():void
		{
			bSytlesInvalidated = true;
			
			if (!bInvalidateEventDispatched)
			{
				dispatchEvent(new IsoEvent(IsoEvent.INVALIDATE));
				bInvalidateEventDispatched = true;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get isInvalidated ():Boolean
		{
			return (bSizeInvalidated || bPositionInvalidated || bSytlesInvalidated);
		}
		
		////////////////////////////////////////////////////////////
		//	CLONE
		////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function clone ():IIsoDisplayObject
		{
			var cloneInstance:IIsoPrimitive = super.clone() as IIsoPrimitive;
			cloneInstance.styleType = styleType;
			cloneInstance.lineAlphas = lineAlphasArray;
			cloneInstance.lineColors = lineColorArray;
			cloneInstance.lineThicknesses = lineThicknessesArray;
			cloneInstance.faceAlphas = faceAlphasArray;
			cloneInstance.faceColors = shadedColorArray;
			
			return cloneInstance;
		}
		
		////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoPrimitive ()
		{
			super();
			
			width = DEFAULT_WIDTH;
			length = DEFAULT_LENGTH;
			height = DEFAULT_HEIGHT;
		}
		
	}
}