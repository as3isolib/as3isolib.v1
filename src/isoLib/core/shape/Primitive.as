package isoLib.core.shape
{
	import com.jwopitz.geom.Pt;
	
	import flash.filters.DropShadowFilter;
	
	import isoLib.core.isolib_internal;
	import isoLib.core.sceneGraph.Node;
	import isoLib.utils.IsoUtil;
	
	use namespace isolib_internal;

	public class Primitive extends Node implements IPrimitive, IStylable
	{
		////////////////////////////////////////////////////////////////////////
		//	VARIOUS FLAGS
		////////////////////////////////////////////////////////////////////////
		
		public var autoUpdate:Boolean = false; //if true, will update on every property change
		
		////////////////////////////////////////////////////////////////////////
		//	RENDER / GEOMETRY
		////////////////////////////////////////////////////////////////////////
		
		override public function render (recursive:Boolean = true):void
		{
			if (geometryInvalidated || stylesInvalidated)
			{
				if (geometryInvalidated && validateGeometry() == false)
				{
					throw new Error("Validation of geometry failed.  Please make sure that the Primitive instance has all the necessary properties to render properly.");
					return
				}
				
				renderGeometry();
				
				_geometryInvalidated = false;
				_stylesInvalidated = false;
			}
			
			if (positionInvalidated)
			{
				validatePosition();
				_positionInvalidated = false;
			}
			
			super.render(recursive);
		}
		
		////////////////////////////////////////////////////////////////////////
		//	INVALIDATION
		////////////////////////////////////////////////////////////////////////
		
		private var _geometryInvalidated:Boolean = false; //for width, length, height or style changes, will require geometry validation
		
		public function get geometryInvalidated ():Boolean
		{
			return _geometryInvalidated;
		}
		
		public function invalidateGeometry ():void
		{
			_geometryInvalidated = true;
		}
		
		private var _stylesInvalidated:Boolean = false; //for x, y, z or depth changes, will require position validation		
		
		public function get stylesInvalidated ():Boolean
		{
			return _stylesInvalidated;
		}
		
		public function invalidateStyles ():void
		{
			_stylesInvalidated = true;
		}
		
		private var _positionInvalidated:Boolean = false; //for various style changes, will require style validation
		
		public function get positionInvalidated ():Boolean
		{
			return _positionInvalidated;
		}
		
		public function invalidatePosition ():void
		{
			 _positionInvalidated = true
		}
		
		////////////////////////////////////////////////////////////////////////
		//	VALIDATION
		////////////////////////////////////////////////////////////////////////		
		
		protected function validateGeometry ():Boolean
		{
			return true;
		}
		
		protected function renderGeometry ():void
		{
		}
		
		protected function validatePosition ():void
		{
			var pt:Pt = new Pt(x, y, z);
			IsoUtil.mapToIso(pt);
			
			container.x = pt.x;
			container.y = pt.y;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	PTS
		////////////////////////////////////////////////////////////////////////
		
		[ArrayElementType("com.jwopitz.geom.Pt")]
		protected var geometryPts:Array = [];
		
		public function get pts ():Array
		{
			return geometryPts;
		}
		
		public function set pts (value:Array):void
		{
			if (geometryPts != value)
			{
				geometryPts = value;
				invalidateGeometry();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	TYPE
		////////////////////////////////////////////////////////////////////////
		
		protected var isoType:String = IsoType.SOLID;
		
		public function get type ():String
		{
			return isoType;
		}
		
		public function set type (value:String):void
		{
			if (value != IsoType.WIREFRAME &&
				value != IsoType.SOLID &&
				value != IsoType.SHADED)
			{
				throw new Error("type is not of value IsoType.WIREFRAME, IsoType.SOLID, or IsoType.SHADED");
				return;
			}
			
			if (isoType != value)
			{
				isoType = value;
				invalidateGeometry();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	WIDTH
		////////////////////////////////////////////////////////////////////////
		
		protected var isoWidth:Number = 0;
		
		public function get width ():Number
		{
			return isoWidth;
		}
		
		public function set width (value:Number):void
		{	
			value = Math.abs(value);
					
			if (isoWidth != value)
			{
				isoWidth = value;
				invalidateGeometry();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	LENGTH
		////////////////////////////////////////////////////////////////////////
		
		protected var isoLength:Number = 0;
		
		public function get length ():Number
		{
			return isoLength;
		}
		
		public function set length (value:Number):void
		{
			value = Math.abs(value);
					
			if (isoLength != value)
			{
				isoLength = value;
				invalidateGeometry();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	HEIGHT
		////////////////////////////////////////////////////////////////////////
		
		protected var isoHeight:Number = 0;
		
		public function get height ():Number
		{
			return isoHeight;
		}
		
		public function set height (value:Number):void
		{
			value = Math.abs(value);
					
			if (isoHeight != value)
			{
				isoHeight = value;
				invalidateGeometry();				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	X
		////////////////////////////////////////////////////////////////////////
		
		protected var isoX:Number = 0;
		
		public function get x ():Number
		{
			return isoX;
		}
		
		public function set x (value:Number):void
		{
			if (isoX != value)
			{
				isoX = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Y
		////////////////////////////////////////////////////////////////////////
		
		protected var isoY:Number = 0;
		
		public function get y ():Number
		{
			return isoY;
		}
		
		public function set y (value:Number):void
		{
			if (isoY != value)
			{
				isoY = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Z
		////////////////////////////////////////////////////////////////////////
		
		protected var isoZ:Number = 0;
		
		public function get z ():Number
		{
			return isoZ;
		}
		
		public function set z (value:Number):void
		{
			if (isoZ != value)
			{
				isoZ = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// LINE STYLES
		//////////////////////////////////////////////////////
		
		[ArrayElementType("uint")]
		protected var lineThicknessesArray:Array = [0, 0, 0, 0, 0, 0];
		
		public function get lineThicknesses ():Array
		{
			return lineThicknessesArray;
		}
		
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
		protected var lineColorArray:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,];
		
		public function get lineColors ():Array
		{
			return lineColorArray;
		}
		
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
		protected var lineAlphasArray:Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
		
		public function get lineAlphas ():Array
		{
			return lineAlphasArray;
		}
		
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
		protected var solidColorArray:Array = [0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff];
		
		public function get solidColors ():Array
		{
			return solidColorArray;
		}
		
		public function set solidColors (value:Array):void
		{
			if (solidColorArray != value)
			{
				solidColorArray = value;
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		[ArrayElementType("uint")]
		protected var shadedColorArray:Array = [0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xffffff];
		
		public function get shadedColors ():Array
		{
			return shadedColorArray;
		}
		
		public function set shadedColors (value:Array):void
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
		protected var faceAlphasArray:Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
		
		public function get faceAlphas ():Array
		{
			return faceAlphasArray;
		}
		
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
	}
}