package isoLib.primitive
{
	import com.jwopitz.geom.Pt;
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	import isoLib.core.IsoType;
	import isoLib.utils.IsoUtil;

	public class IsoShape extends Sprite implements IIsoPrimitive
	{
		//////////////////////////////////////////////////////
		// ISO Z
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isometricZ:Number = 0;
		
		public function get isoZ ():Number
		{
			return isometricZ;
		}
		
		/**
		 * @private
		 */
		public function set isoZ (value:Number):void
		{
			if (isometricZ != value)
			{
				isometricZ = value;
				reposition();
			}
		}
		
		//////////////////////////////////////////////////////
		// ISO Y
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isometricY:Number = 0;
		
		public function get isoY ():Number
		{
			return isometricY;
		}
		
		/**
		 * @private
		 */
		public function set isoY (value:Number):void
		{
			if (isometricY != value)
			{
				isometricY = value;
				reposition();
			}
		}
		
		//////////////////////////////////////////////////////
		// ISO X
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isometricX:Number = 0;
		
		public function get isoX ():Number
		{
			return isometricX;
		}
		
		/**
		 * @private
		 */
		public function set isoX (value:Number):void
		{
			if (isometricX != value)
			{
				isometricX = value;
				reposition();
			}
		}
		
		//////////////////////////////////////////////////////
		// ISO LENGTH
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isometricLength:Number = 0;
		
		public function get isoLength ():Number
		{
			return isometricLength;
		}
		
		/**
		 * @private
		 */
		public function set isoLength (value:Number):void
		{
			if (isometricLength != value)
			{
				isometricLength = value;
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// ISO WIDTH
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isometricWidth:Number = 0;
		
		public function get isoWidth ():Number
		{
			return isometricWidth;
		}
		
		/**
		 * @private
		 */
		public function set isoWidth (value:Number):void
		{
			if (isometricWidth != value)
			{
				isometricWidth = value;
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// ISO HEIGHT
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isometricHeight:Number = 0;
		
		public function get isoHeight ():Number
		{
			return isometricHeight;
		}
		
		/**
		 * @private
		 */
		public function set isoHeight (value:Number):void
		{
			if (isometricHeight != value)
			{
				isometricHeight = value;
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// OVERRIDES X/Y
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var isoRenderType:String = IsoType.WIREFRAME;
		
		public function get type ():String
		{
			return isoRenderType;
		}
		
		/**
		 * @private
		 */
		public function set type (value:String):void
		{
			if (value != IsoType.WIREFRAME &&
				value != IsoType.SOLID &&
				value != IsoType.SHADED)
			{
				throw new Error("type is not of value IsoType.WIREFRAME, IsoType.SOLID, or IsoType.SHADED");
				return;
			}
			
			if (isoRenderType != value)
			{
				isoRenderType = value;
				
				if (autoUpdate)
					render();
			}
		}
		
		//////////////////////////////////////////////////////
		// AUTO UPDATE
		//////////////////////////////////////////////////////
		
		public var autoUpdate:Boolean = false;
		
		//////////////////////////////////////////////////////
		// OVERRIDES X/Y
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		override public function set x (value:Number):void
		{
			super.x = value;
			updateIsoFromMap();
		}
		
		/**
		 * @private
		 */
		override public function set y (value:Number):void
		{
			super.y = value;
			updateIsoFromMap();
		}
		
		protected function updateIsoFromMap ():void
		{
			var mapPt:Pt = new Pt(super.x, super.y, 0);
			var isoPt:Pt = IsoUtil.mapToIso(mapPt, true);
			
			isometricX = isoPt.x;
			isometricY = isoPt.y;
			isometricZ = isoPt.z;
		}
		
		//////////////////////////////////////////////////////
		// ISO RENDERER METHODS
		//////////////////////////////////////////////////////
		
		public function reposition ():void
		{
			var iso2mapPt:Pt = new Pt(isoX, isoY, isoZ);
			IsoUtil.mapToIso(iso2mapPt);
			
			super.x = iso2mapPt.x;
			super.y = iso2mapPt.y;
		}
		
		public function render ():void
		{
			if (validateGeometry())
				renderGeometry();
			
			else
				throw new Error("Render phase failed pointLogic inspection.  Please make sure that the IsoShape instance has all the necessary properties to render properly.");
		}
		
		[ArrayElementType("com.jwopitz.geom.Pt")]
		public var pts:Array = [];
		
		protected function validateGeometry ():Boolean
		{
			return true;
		}
		
		protected function renderGeometry ():void
		{
		}
		
		//////////////////////////////////////////////////////
		// LINE STYLES
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		[ArrayElementType("uint")]
		protected var lineThicknessesArray:Array = [0, 0, 0, 0, 0, 0];
		
		public function get lineThicknesses ():Array
		{
			return lineThicknessesArray;
		}
		
		public function set lineThicknesses (value:Array):void
		{
			lineThicknessesArray = value;
			
			if (autoUpdate)
				render();
		}
		
		/**
		 * @private
		 */
		[ArrayElementType("uint")]
		protected var lineColorArray:Array = [0x000000, 0x000000, 0x000000, 0x000000, 0x000000, 0x000000,];
		
		public function get lineColors ():Array
		{
			return lineColorArray;
		}
		
		/**
		 * @private
		 */
		public function set lineColors (value:Array):void
		{
			lineColorArray = value;
			
			if (autoUpdate)
				render();
		}
		
		/**
		 * @private
		 */
		[ArrayElementType("Number")]
		protected var lineAlphasArray:Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
		
		public function get lineAlphas ():Array
		{
			return lineAlphasArray;
		}
		
		/**
		 * @private
		 */
		public function set lineAlphas (value:Array):void
		{
			lineAlphasArray = value;
			
			if (autoUpdate)
				render();
		}
		
		//////////////////////////////////////////////////////
		// FACE STYLES
		//////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		[ArrayElementType("uint")]
		protected var solidColorArray:Array = [0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
		
		public function get solidColors ():Array
		{
			return solidColorArray;
		}
		
		/**
		 * @private
		 */
		public function set solidColors (value:Array):void
		{
			solidColorArray = value;
			
			if (autoUpdate)
				render();
		}
		
		/**
		 * @private
		 */
		[ArrayElementType("uint")]
		protected var shadedColorArray:Array = [0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF, 0xFFFFFF];
		
		public function get shadedColors ():Array
		{
			return shadedColorArray;
		}
		
		/**
		 * @private
		 */
		public function set shadedColors (value:Array):void
		{
			shadedColorArray = value;
			
			if (autoUpdate)
				render();
		}
		
		/**
		 * @private
		 */
		[ArrayElementType("Number")]
		protected var faceAlphasArray:Array = [1.0, 1.0, 1.0, 1.0, 1.0, 1.0];
		
		public function get faceAlphas ():Array
		{
			return faceAlphasArray;
		}
		
		/**
		 * @private
		 */
		public function set faceAlphas (value:Array):void
		{
			faceAlphasArray = value;
			
			if (autoUpdate)
				render();
		}
	}
}