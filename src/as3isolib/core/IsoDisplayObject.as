package as3isolib.core
{
	import as3isolib.bounds.IBounds;
	import as3isolib.bounds.PrimitiveBounds;
	import as3isolib.core.as3isolib_internal;
	import as3isolib.data.Node;
	import as3isolib.enum.RenderStyleType;
	import as3isolib.events.IsoEvent;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	use namespace as3isolib_internal;
	
	/**
	 * IsoDisplayObject is the base class that all primitive and complex isometric display objects should extend.
	 * Developers should not instantiate this class but rather extend it.
	 */
	public class IsoDisplayObject extends IsoContainer implements IIsoDisplayObject
	{
		////////////////////////////////////////////////////////////////////////
		//	CONSTANTS
		////////////////////////////////////////////////////////////////////////
		
		static public const DEFAULT_WIDTH:Number = 25;
		static public const DEFAULT_LENGTH:Number = 25;
		static public const DEFAULT_HEIGHT:Number = 25;
		
		////////////////////////////////////////////////////////////////////////
		//	BOUNDS
		////////////////////////////////////////////////////////////////////////
		
		private var _isoBounds:IBounds;
		
		/**
		 * @inheritDoc
		 */
		public function get isoBounds ():IBounds
		{
			if (!_isoBounds || isInvalidated)
				_isoBounds = new PrimitiveBounds(this);
			
			return _isoBounds;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get screenBounds ():Rectangle
		{
			var r:Rectangle;
			if (container.parent)
				r = container.getBounds(container.parent);
			
			return r;
		}
		
			/////////////////////////////////////////////////////////
			//	POSITION
			/////////////////////////////////////////////////////////
			
		/**
		 * @inheritDoc
		 */
		public function moveTo (x:Number, y:Number, z:Number):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	X
		////////////////////////////////////////////////////////////////////////
		
		private var isoX:Number = 0;
		private var oldX:Number;
		
		/**
		 * @inheritDoc
		 */
		[Bindable("move")]
		public function get x ():Number
		{
			return isoX;
		}
		
		/**
		 * @private
		 */
		public function set x (value:Number):void
		{
			value = Math.round(value);
			if (isoX != value)
			{
				oldX = isoX;
				
				isoX = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get screenX ():Number
		{
			var b:IBounds = isoBounds;
			var pt:Pt = IsoMath.isoToScreen(new Pt(b.left, b.front, b.bottom));
						
			return pt.x//container.localToGlobal(pt).x;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Y
		////////////////////////////////////////////////////////////////////////
		
		private var isoY:Number = 0;
		private var oldY:Number;
		
		/**
		 * @private
		 */
		[Bindable("move")]
		public function get y ():Number
		{
			return isoY;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set y (value:Number):void
		{
			value = Math.round(value);
			if (isoY != value)
			{
				oldY = isoY;
				
				isoY = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		/**
		 * @inheritDoc
		 */
		public function get screenY ():Number
		{
			var b:IBounds = isoBounds;
			var pt:Pt = IsoMath.isoToScreen(new Pt(b.right, b.front, b.bottom));
			
			return pt.y//container.localToGlobal(pt).y;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Z
		////////////////////////////////////////////////////////////////////////
		
		private var isoZ:Number = 0;
		private var oldZ:Number;
		
		/**
		 * @private
		 */
		[Bindable("move")]
		public function get z ():Number
		{
			return isoZ;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set z (value:Number):void
		{
			value = Math.round(value);
			if (isoZ != value)
			{
				oldZ = isoZ;
				
				isoZ = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
			/////////////////////////////////////////////////////////
			//	GEOMETRY
			/////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function setSize (width:Number, length:Number, height:Number):void
		{
			this.width = width;
			this.length = length;
			this.height = height;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	WIDTH
		////////////////////////////////////////////////////////////////////////
		
		private var isoWidth:Number = 0;
		private var oldWidth:Number;
		
		/**
		 * @private
		 */
		[Bindable("resize")]
		public function get width ():Number
		{
			return isoWidth;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set width (value:Number):void
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
		
		////////////////////////////////////////////////////////////////////////
		//	LENGTH
		////////////////////////////////////////////////////////////////////////
		
		private var isoLength:Number = 0;
		private var oldLength:Number;
		
		/**
		 * @private
		 */
		[Bindable("resize")]
		public function get length ():Number
		{
			return isoLength;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set length (value:Number):void
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
		
		////////////////////////////////////////////////////////////////////////
		//	HEIGHT
		////////////////////////////////////////////////////////////////////////
		
		private var isoHeight:Number = 0;
		private var oldHeight:Number;
		
		/**
		 * @private
		 */
		[Bindable("resize")]
		public function get height ():Number
		{
			return isoHeight;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set height (value:Number):void
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
		//	RENDERING
		/////////////////////////////////////////////////////////
		
		/**
		 * Flag indicating whether a property change will automatically trigger a render phase.
		 */
		public var autoUpdate:Boolean = false;
		
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
				
				var evt:IsoEvent = new IsoEvent(IsoEvent.RESIZE);
				evt.propName = "size";
				evt.oldValue = {width:oldWidth, length:oldLength, height:oldHeight};
				evt.newValue = {width:isoWidth, length:isoLength, height:isoHeight};
				
				dispatchEvent(evt);
				
				bGeometryInvalidated = false;
			}
			
			if (bPositionInvalidated)
			{
				validatePosition();
				
				evt = new IsoEvent(IsoEvent.MOVE);
				evt.propName = "position";
				evt.oldValue = {x:oldX, y:oldY, z:oldZ};
				evt.newValue = {x:isoX, y:isoY, z:isoZ};
				
				bPositionInvalidated = false;
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
		
		/**
		 * Takes the given 3D isometric coordinates and positions them in cartesian coordinates relative to the parent container.
		 */
		protected function validatePosition ():void
		{
			var pt:Pt = new Pt(x, y, z);
			IsoMath.isoToScreen(pt);
			
			container.x = pt.x;
			container.y = pt.y;
		}
		
		/////////////////////////////////////////////////////////
		//	INVALIDATION
		/////////////////////////////////////////////////////////
		
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
		 * @private
		 */
		as3isolib_internal var bPositionInvalidated:Boolean = false;
		
		/**
		 * @inheritDoc
		 */
		public function invalidatePosition ():void
		{
			bPositionInvalidated = true;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get isInvalidated ():Boolean
		{
			return (bGeometryInvalidated || bPositionInvalidated);
		}
		
		/////////////////////////////////////////////////////////
		//	CLONE
		/////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function clone ():IIsoDisplayObject
		{
			var CloneClass:Class = getDefinitionByName(getQualifiedClassName(this)) as Class;
			
			var cloneInstance:IIsoDisplayObject = new CloneClass();
			cloneInstance.setSize(isoWidth, isoLength, isoHeight);
			cloneInstance.lineAlphas = lineAlphasArray;
			cloneInstance.lineColors = lineColorArray;
			cloneInstance.lineThicknesses = lineThicknessesArray;
			cloneInstance.faceAlphas = faceAlphasArray;
			cloneInstance.faceColors = shadedColorArray;
			
			return cloneInstance;
		}	
		
		/////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		/////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoDisplayObject ()
		{
			super();
			
			width = DEFAULT_WIDTH;
			length = DEFAULT_LENGTH;
			height = DEFAULT_HEIGHT;
		}	
	}
}