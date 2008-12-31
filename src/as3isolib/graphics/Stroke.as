package as3isolib.graphics
{
	import flash.display.Graphics;

	public class Stroke implements IStroke
	{
		
		public var weight:Number;
		public var color:uint;
		public var alpha:Number;
		
		public var usePixelHinting:Boolean;
		
		public var scaleMode:String;
		public var caps:String;
		public var joints:String;
		public var miterLimit:Number;
		
		/**
		 * Constructor
		 */
		public function Stroke (weight:Number,
								color:uint,
								alpha:Number = 1,
								usePixelHinting:Boolean = false,
								scaleMode:String = "normal",
								caps:String = null,
								joints:String = null,
								miterLimit:Number = 0)
		{
			this.weight = weight;
			this.color = color;
			this.alpha = alpha;
			
			this.usePixelHinting = usePixelHinting;
			
			this.scaleMode = scaleMode;
			this.caps = caps;
			this.joints = joints;
			this.miterLimit = miterLimit;
		}
		
		/**
		 * @inheritDoc
		 */
		public function apply (target:Graphics):void
		{
			target.lineStyle(weight, color, alpha, usePixelHinting, scaleMode, caps, joints, miterLimit);
		}
	}
}