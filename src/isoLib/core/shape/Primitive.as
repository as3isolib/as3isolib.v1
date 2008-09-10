package isoLib.core.shape
{
	import com.jwopitz.geom.Pt;
	
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import isoLib.bounds.IBounds;
	import isoLib.bounds.PrimitiveBounds;
	import isoLib.core.isolib_internal;
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.IsoContainer;
	import isoLib.utils.IsoUtil;
	
	use namespace isolib_internal;

	public class Primitive extends IsoContainer implements IPrimitive
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
		
		///////////////////////////////////////////////////////////////////////////////
		//	OVERRIDES
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt (child:INode, index:uint):void
		{
			if (child is IPrimitive)
			{
				super.addChildAt(child, index);
				container.addChildAt(IPrimitive(child).container, index);			
			}
			
			else
				throw new Error ("parameter child is not of type IPrimitive");
		}
		
		override public function setChildIndex (child:INode, index:uint):void
		{
			
		}
		
		////////////////////////////////////////////////////////////////////////
		//	INVALIDATION
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
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
		
		private var _depthInvalidated:Boolean = false;
		
		public function get depthInvalidated ():Boolean
		{
			return _depthInvalidated;
		}
		
		public function invalidateDepth ():void
		{
			_depthInvalidated = true;
			_positionInvalidated = true;
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
			IsoUtil.isoToScreen(pt);
			
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
		//	ORIENTATION
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		private var isoOrientation:String = IsoOrientation.NONE;
		
		/**
		 * @private
		 */
		public function get orientation ():String
		{
			return isoOrientation
		}
		
		/**
		 * @inheritDoc
		 */
		public function set orientation (value:String):void
		{
			//to be overridden by subclasses
		}
		
		////////////////////////////////////////////////////////////////////////
		//	BOUNDS
		////////////////////////////////////////////////////////////////////////
		
		override public function get bounds ():IBounds
		{
			return new PrimitiveBounds(this);
		}
		
		public function get left ():Number
		{
			return x;
		}
		
		public function get right ():Number
		{
			return x + width;
		}
		
		public function get front ():Number
		{
			return y + length
		}
		
		public function get back ():Number
		{
			return y;
		}
		
		public function get top ():Number
		{
			return z + height;
		}
		
		public function get bottom ():Number
		{
			return z;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	WIDTH
		////////////////////////////////////////////////////////////////////////
		
		private var isoWidth:Number = 0;
		
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
		
		private var isoLength:Number = 0;
		
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
		
		private var isoHeight:Number = 0;
		
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
		
		private var isoX:Number = 0;
		
		public function get x ():Number
		{
			return isoX;
		}
		
		public function set x (value:Number):void
		{
			value = Math.round(value);
			if (isoX != value)
			{
				isoX = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		public function get screenX ():int
		{
			return IsoUtil.isoToScreen(new Pt(left, front, bottom)).x;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Y
		////////////////////////////////////////////////////////////////////////
		
		private var isoY:Number = 0;
		
		public function get y ():Number
		{
			return isoY;
		}
		
		public function set y (value:Number):void
		{
			value = Math.round(value);
			if (isoY != value)
			{
				isoY = value;
				invalidatePosition();
				
				if (autoUpdate)
					render();
			}
		}
		
		public function get screenY ():int
		{
			return IsoUtil.isoToScreen(new Pt(right, front, bottom)).y;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	Z
		////////////////////////////////////////////////////////////////////////
		
		private var isoZ:Number = 0;
		
		public function get z ():Number
		{
			return isoZ;
		}
		
		public function set z (value:Number):void
		{
			value = Math.round(value);
			if (isoZ != value)
			{
				isoZ = value;
				invalidatePosition();
				invalidateDepth();
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// DEPTH
		//////////////////////////////////////////////////////
		
		private var isoDepth:int;
		
		public function get depth ():int
		{
			return isoDepth;
		}
		
		public function set depth (value:int):void
		{
			isoDepth = value;
		}
		
		//////////////////////////////////////////////////////
		// FILTERS
		//////////////////////////////////////////////////////
		
		public function get filters ():Array
		{
			return container.filters;
		}
		
		public function set filters (value:Array):void
		{
			container.filters = value;
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
				invalidateStyles();
				
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
				invalidateStyles();
				
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
		private var shadedColorArray:Array = [0xffffff, 0xffffff, 0xffffff, 0xffffff, 0xcccccc, 0xcccccc];
		
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
				invalidateStyles();
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////////////////
		//	CLONE
		//////////////////////////////////////////////////////////////////
		
		public function clone ():IPrimitive
		{
			var className:String = getQualifiedClassName(this).replace("::", ".");
			var classReference:Class = getDefinitionByName(className) as Class;
			
			var copy:IPrimitive = new classReference();
			copy.type = this.type;
			
			copy.width = this.width;
			copy.length = this.length;
			copy.height = this.height;
			
			copy.lineAlphas = this.lineAlphas;
			copy.lineColors = this.lineColors;
			copy.lineThicknesses = this.lineThicknesses;
			
			copy.faceAlphas = this.faceAlphas;
			copy.solidColors = this.solidColors;
			copy.shadedColors = this.shadedColors;
			
			return copy;
		}
	}
}