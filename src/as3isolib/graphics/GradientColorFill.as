package as3isolib.graphics
{
	import flash.display.GradientType;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	
	/**
	 * @private
	 */
	public class GradientColorFill implements IFill
	{
		/**
		 * Constructor
		 */
		public function GradientColorFill (type:String,
											colors:Array,
											alphas:Array,
											ratios:Array,
											matrix:Matrix = null,
											spreadMethod:String = "pad",
											interpolationMethod:String = "rgb",
											focalPointRatio:Number = 0)
		{
			this.type = type;
			
			this.colors = colors;
			this.alphas = alphas;
			this.ratios = ratios;
			
			this.matrix = matrix;
			
			this.spreadMethod = spreadMethod;
			this.interpolationMethod = interpolationMethod;
			
			this.focalPointRatio = focalPointRatio;
		}
		
		public var type:String = GradientType.LINEAR;
		
		public var colors:Array = [];
		public var alphas:Array = [];
		public var ratios:Array = [];
		
		public var matrix:Matrix;
		
		public var spreadMethod:String;
		public var interpolationMethod:String;
		
		public var focalPointRatio:Number;
		
		/**
		 * @inheritDoc
		 */
		public function begin (target:Graphics):void
		{
			target.beginGradientFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
		/**
		 * @inheritDoc
		 */
		public function end (target:Graphics):void
		{
			target.endFill();
		}
		
		/**
		 * @inheritDoc
		 */
		public function clone ():IFill
		{
			return new GradientColorFill(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
		}
		
	}
}