package as3isolib.display.primitive
{
	import as3isolib.bounds.IBounds;
	import as3isolib.bounds.PrimitiveBounds;
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.display.IsoContainer;
	import as3isolib.enum.RenderStyleType;
	import as3isolib.events.IsoEvent;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;

	public class IsoPrimitive extends IsoContainer implements IIsoDisplayObject
	{
		////////////////////////////////////////////////////////////////////////
		//	CONSTANTS
		////////////////////////////////////////////////////////////////////////
		
		static public const DEFAULT_WIDTH:Number = 25;
		static public const DEFAULT_LENGTH:Number = 25;
		static public const DEFAULT_HEIGHT:Number = 25;
		
		public function get bounds ():IBounds
		{
			return new PrimitiveBounds(this);
		}
		
			/////////////////////////////////////////////////////////
			//	POSITION
			/////////////////////////////////////////////////////////
		
		////////////////////////////////////////////////////////////////////////
		//	X
		////////////////////////////////////////////////////////////////////////
		
		public function moveTo (x:Number = 0, y:Number = 0, z:Number = 0):void
		{
			this.x = x;
			this.y = y;
			this.z = z;
		}
		
		private var isoX:Number = 0;
		private var oldX:Number;
		
		[Bindable("move")]
		public function get x ():Number
		{
			return isoX;
		}
		
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
		
		public function get screenX ():Number
		{
			var b:IBounds = bounds;
			return IsoMath.isoToScreen(new Pt(b.left, b.front, b.bottom)).x;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Y
		////////////////////////////////////////////////////////////////////////
		
		private var isoY:Number = 0;
		private var oldY:Number;
		
		[Bindable("move")]
		public function get y ():Number
		{
			return isoY;
		}
		
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
		
		public function get screenY ():Number
		{
			var b:IBounds = bounds;
			return IsoMath.isoToScreen(new Pt(b.right, b.front, b.bottom)).y;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Z
		////////////////////////////////////////////////////////////////////////
		
		private var isoZ:Number = 0;
		private var oldZ:Number;
		
		[Bindable("move")]
		public function get z ():Number
		{
			return isoZ;
		}
		
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
		
		////////////////////////////////////////////////////////////////////////
		//	WIDTH
		////////////////////////////////////////////////////////////////////////
		
		private var isoWidth:Number = 0;
		private var oldWidth:Number;
		
		[Bindable("resize")]
		public function get width ():Number
		{
			return isoWidth;
		}
		
		public function set width (value:Number):void
		{	
			value = Math.abs(value);
			if (isoWidth != value)
			{
				oldWidth = isoWidth;
				
				isoWidth = value;
				invalidateGeometry();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	LENGTH
		////////////////////////////////////////////////////////////////////////
		
		private var isoLength:Number = 0;
		private var oldLength:Number;
		
		[Bindable("resize")]
		public function get length ():Number
		{
			return isoLength;
		}
		
		public function set length (value:Number):void
		{
			value = Math.abs(value);
			{
				oldLength = isoLength;
				
				isoLength = value;
				invalidateGeometry();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	HEIGHT
		////////////////////////////////////////////////////////////////////////
		
		private var isoHeight:Number = 0;
		private var oldHeight:Number;
		
		[Bindable("resize")]
		public function get height ():Number
		{
			return isoHeight;
		}
		
		public function set height (value:Number):void
		{
			value = Math.abs(value);	
			if (isoHeight != value)
			{
				oldHeight = isoHeight;
				
				isoHeight = value;
				invalidateGeometry();				
				if (autoUpdate)
					render();
			}
		}
		
			//////////////////////////////////////////////////////
			// STYLES
			//////////////////////////////////////////////////////
		
		private var renderStyle:String = RenderStyleType.SHADED;
		
		public function get styleType ():String
		{
			return renderStyle;
		}
		
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
		
		public function get lineThicknesses ():Array
		{
			return lineThicknessesArray;
		}
		
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
		
		public function get lineColors ():Array
		{
			return lineColorArray;
		}
		
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
		
		public function get lineAlphas ():Array
		{
			return lineAlphasArray;
		}
		
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
		
		public function get faceColors ():Array
		{
			return shadedColorArray;
		}
		
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
		
		public function get faceAlphas ():Array
		{
			return faceAlphasArray;
		}
		
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
		
		public var autoUpdate:Boolean = false;
		
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
			
			dispatchEvent(new IsoEvent(IsoEvent.RENDER));
			
			super.render(recursive);
		}
		
		protected function drawGeometry ():void
		{
			//overridden by subclasses
		}
		
		/////////////////////////////////////////////////////////
		//	VALIDATION
		/////////////////////////////////////////////////////////
		
		protected function validateGeometry ():Boolean
		{
			return true;
		}
		
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
		
		protected var bGeometryInvalidated:Boolean = false;
		public function invalidateGeometry ():void
		{
			bGeometryInvalidated = true;
		}
		
		protected var bPositionInvalidated:Boolean = false;
		public function invalidatePosition ():void
		{
			bPositionInvalidated = true;
		}
		
		public function get isInvalidated ():Boolean
		{
			return (bGeometryInvalidated || bPositionInvalidated);
		}
		
		/////////////////////////////////////////////////////////
		//	CLONE
		/////////////////////////////////////////////////////////
		
		public function clone ():IIsoDisplayObject
		{
			return null;
		}	
		
		/////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		/////////////////////////////////////////////////////////
		
		public function IsoPrimitive ()
		{
			super();
			
			width = DEFAULT_WIDTH;
			length = DEFAULT_LENGTH;
			height = DEFAULT_HEIGHT;
		}	
	}
}