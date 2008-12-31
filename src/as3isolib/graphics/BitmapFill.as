package as3isolib.graphics
{
	import as3isolib.enum.IsoOrientation;
	import as3isolib.utils.IsoDrawingUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;

	public class BitmapFill implements IFill
	{
		///////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function BitmapFill (source:Object, orientation:String = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
		{
			this.source = source;
			this.orientation = orientation;
			
			if (matrix)
				this.matrix = matrix;
			
			this.repeat = repeat;
			this.smooth = smooth;
		}
		
		///////////////////////////////////////////////////////////
		//	SOURCE
		///////////////////////////////////////////////////////////
		
		private var bitmapData:BitmapData;
		
		/**
		 * @private
		 */
		public function get source ():Object
		{
			return bitmapData;
		}
		
		/**
		 * The source object for the bitmap fill.
		 */
		public function set source (value:Object):void
		{
			var tempSprite:DisplayObject;
			
			if (value is BitmapData)
			{
				bitmapData = BitmapData(value);
				return;
			}
			
			if (value is Class)
			{
				var classInstance:Class = Class(value);
				tempSprite = new classInstance();
			}
			
			else if (value is Bitmap)
				bitmapData = Bitmap(value).bitmapData;
			
			else if (value is DisplayObject)
				tempSprite = DisplayObject(value);
			
			else if (value is String)
			{
				classInstance = Class(getDefinitionByName(String(value)));
				tempSprite = new classInstance();
			}
			
			else
				return;
				
			if (!bitmapData && tempSprite)
			{
				bitmapData = new BitmapData(tempSprite.width, tempSprite.height);
				bitmapData.draw(tempSprite, new Matrix());
			}
		}
		
		///////////////////////////////////////////////////////////
		//	ORIENTATION
		///////////////////////////////////////////////////////////
		
		private var _orientation:String;
		
		public function get orientation ():String
		{
			return _orientation;
		}
		
		public function set orientation (value:String):void
		{
			_orientation = value;
			
			if (value == IsoOrientation.XY ||
				value == IsoOrientation.XZ ||
				value == IsoOrientation.YZ)
			{
				matrix = IsoDrawingUtil.getIsoMatrix(value);
			}
		}
		
		///////////////////////////////////////////////////////////
		//	props
		///////////////////////////////////////////////////////////
		
		public var matrix:Matrix;
		
		public var repeat:Boolean;
		public var smooth:Boolean;
		
		///////////////////////////////////////////////////////////
		//	IFILL
		///////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function begin (target:Graphics):void
		{			
			target.beginBitmapFill(bitmapData, matrix, repeat, smooth);
		}
		
		/**
		 * @inheritDoc
		 */
		public function end (target:Graphics):void
		{
			target.endFill();
		}
	}
}