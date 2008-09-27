package as3isolib.display
{
	import as3isolib.bounds.IBounds;
	import as3isolib.bounds.PrimitiveBounds;
	import as3isolib.core.as3isolib_internal;
	import as3isolib.data.Node;
	import as3isolib.enum.OffsetType;
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
		
		public function get isoBounds ():IBounds
		{
			if (!_isoBounds || isInvalidated)
				_isoBounds = new PrimitiveBounds(this);
			
			return _isoBounds;
		}
		
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
			var b:IBounds = isoBounds;
			var pt:Pt = IsoMath.isoToScreen(new Pt(b.left, b.front, b.bottom));
						
			return pt.x//container.localToGlobal(pt).x;
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
			var b:IBounds = isoBounds;
			var pt:Pt = IsoMath.isoToScreen(new Pt(b.right, b.front, b.bottom));
			
			return pt.y//container.localToGlobal(pt).y;
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
				invalidatePosition();
							
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
			
			super.render(recursive);
		}
		
		protected function drawGeometry ():void
		{
			//overridden by subclasses
		}
		
		public function get bitmapData ():BitmapData
		{
			var x:Number = IsoMath.isoToScreen(new Pt(x, y + length, z + height)).x;
			var y:Number = IsoMath.isoToScreen(new Pt(x, y, z + height)).y;
			var w:Number = IsoMath.isoToScreen(new Pt(x + width, y, z)).x;
			var h:Number = IsoMath.isoToScreen(new Pt(x + width, y + length, z)).y;
			
			var c:IIsoDisplayObject = clone();
			IsoDisplayObject(c).parentNode = new Node(); //setting parent so as to render
			c.container.x = -1 * x;
			c.container.y = -1 * y;
			c.render();
			
			var host:Sprite = new Sprite();
			host.addChild(c.container);
			
			var bw:Number = Math.abs(w - x);
			var bh:Number = Math.abs(h - y);
			var b:BitmapData = new BitmapData(bw, bh, false, 0xff0000);
			b.draw(host);
			
			return b;
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
		
		as3isolib_internal var bGeometryInvalidated:Boolean = false;
		
		public function invalidateGeometry ():void
		{
			bGeometryInvalidated = true;
		}
		
		as3isolib_internal var bPositionInvalidated:Boolean = false;
		
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
		
		public function IsoDisplayObject ()
		{
			super();
			
			width = DEFAULT_WIDTH;
			length = DEFAULT_LENGTH;
			height = DEFAULT_HEIGHT;
		}	
	}
}