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
		// WIDTH / LENGTH / HEIGHT
		//////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function set width (value:Number):void
		{	
			value = Math.abs(value);
			if (isoWidth != value)
			{
				oldWidth = isoWidth;
				
				isoWidth = value;
				invalidateGeometry();
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set length (value:Number):void
		{
			value = Math.abs(value);
			{
				oldLength = isoLength;
				
				isoLength = value;
				invalidateGeometry();
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function set height (value:Number):void
		{
			value = Math.abs(value);	
			if (isoHeight != value)
			{
				oldHeight = isoHeight;
				
				isoHeight = value;
				invalidateGeometry();	
				invalidatePosition();
							
				if (autoUpdate)
					render();
			}
		}
		
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
				invalidateGeometry();
				
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
				invalidateGeometry();
				
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
				invalidateGeometry();
				
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
				invalidateGeometry();
				
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
				invalidateGeometry();
				
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
				invalidateGeometry();
				
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
			
			if (bGeometryInvalidated)
			{
				if (!validateGeometry())
					throw new Error("validation of geometry failed.");
					
				drawGeometry();
				
				_isoBounds = new PrimitiveBounds(this);
				_screenBounds = container.getBounds(container.parent);
				
				var evt:IsoEvent = new IsoEvent(IsoEvent.RESIZE);
				evt.propName = "size";
				evt.oldValue = {width:oldWidth, length:oldLength, height:oldHeight};
				evt.newValue = {width:isoWidth, length:isoLength, height:isoHeight};
				
				dispatchEvent(evt);
				
				bGeometryInvalidated = false;
			}
			
			super.render(recursive);
		}
		
		/**
		 * @inheritDoc
		 */
		protected function drawGeometry ():void
		{
			//overridden by subclasses
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
			return true;
		}
		
		////////////////////////////////////////////////////////////
		//	INVALIDATION
		////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		as3isolib_internal var bGeometryInvalidated:Boolean = false;
		
		/**
		 * @inheritDoc
		 */
		public function invalidateGeometry ():void
		{
			bGeometryInvalidated = true;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get isInvalidated ():Boolean
		{
			return (bGeometryInvalidated || bPositionInvalidated);
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