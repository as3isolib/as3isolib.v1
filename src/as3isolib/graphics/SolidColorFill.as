package as3isolib.graphics
{
	import as3isolib.errors.IsoError;
	
	import flash.display.Graphics;

	public class SolidColorFill implements IFill
	{
		/**
		 * Constructor
		 */
		public function SolidColorFill (color:uint, alpha:Number)
		{
			this.color = color;
			this.alpha = alpha;
		}
		
		/**
		 * The color of the fill.
		 */
		public var color:uint;
		
		/**
		 * The alpha of the fill.
		 */
		public var alpha:Number;
		
		///////////////////////////////////////////////////////////
		//	IFILL
		///////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function begin (target:Graphics):void
		{			
			target.beginFill(color, alpha);
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