package as3isolib.bounds
{
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.display.scene.IsoScene;
	import as3isolib.geom.Pt;
	
	/**
	 * The IBounds implementation for IIsoScene implementors.
	 */
	public class SceneBounds implements IBounds
	{
		////////////////////////////////////////////////////////////////
		//	W / L / H
		////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function get width ():Number
		{
			return _right - _left;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get length ():Number
		{
			return _front - _back;
		}
		
		/**
		 * @inheritDoc
		 */
		public function get height ():Number
		{
			return _top - _bottom;
		}
		
		////////////////////////////////////////////////////////////////
		//	LEFT / RIGHT
		////////////////////////////////////////////////////////////////
		
		private var _left:Number;
		
		/**
		 * @inheritDoc
		 */
		public function get left ():Number
		{
			return _left;
		}
		
		private var _right:Number;
		
		/**
		 * @inheritDoc
		 */
		public function get right ():Number
		{
			return _right;
		}
		
		////////////////////////////////////////////////////////////////
		//	BACK / FRONT
		////////////////////////////////////////////////////////////////
		
		private var _back:Number;
		
		/**
		 * @inheritDoc
		 */
		public function get back ():Number
		{
			return _back;
		}
		
		private var _front:Number;
		
		/**
		 * @inheritDoc
		 */
		public function get front ():Number
		{
			return _front;
		}
		
		////////////////////////////////////////////////////////////////
		//	TOP / BOTTOM
		////////////////////////////////////////////////////////////////
		
		private var _bottom:Number;
		
		/**
		 * @inheritDoc
		 */
		public function get bottom ():Number
		{
			return _bottom;
		}
		
		private var _top:Number;
		
		/**
		 * @inheritDoc
		 */
		public function get top ():Number
		{
			return _top
		}
		
		////////////////////////////////////////////////////////////////
		//	CENTER PT
		////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function get centerPt ():Pt
		{
			var pt:Pt = new Pt();
			pt.x = (_right - _left) / 2;
			pt.y = (_front - _back) / 2;
			pt.z = (_top - _bottom) / 2;
			
			return pt;
		}
		
		////////////////////////////////////////////////////////////////
		//	COLLISION
		////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function intersects (bounds:IBounds):Boolean
		{
			return false;
		}
		
		////////////////////////////////////////////////////////////////
		//	_target
		////////////////////////////////////////////////////////////////
		
		private var _target:IsoScene;
		
		////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function SceneBounds (target:IsoScene)
		{
			this._target = target;
			
			var child:IIsoDisplayObject;
			for each (child in _target.children)
			{
				if (isNaN(_left) || child.isoBounds.left < _left)
					_left = child.isoBounds.left;
				
				if (isNaN(_right) || child.isoBounds.right > _right)
					_right = child.isoBounds.right;
				
				if (isNaN(_back) || child.isoBounds.back < _back)
					_back = child.isoBounds.back;
				
				if (isNaN(_front) || child.isoBounds.front > _front)
					_front = child.isoBounds.front;
					
				if (isNaN(_bottom) || child.isoBounds.bottom < _bottom)
					_bottom = child.isoBounds.bottom;
					
				if (isNaN(_top) || child.isoBounds.top > _top)
					_top = child.isoBounds.top;
			}
			
			if (isNaN(_left))
				_left = 0;
				
			if (isNaN(_right))
				_right = 0;
			
			if (isNaN(_back))
				_back = 0;
			
			if (isNaN(_front))
				_front = 0;
			
			if (isNaN(_bottom))
				_bottom = 0;
				
			if (isNaN(_top))
				_top = 0;		
		}
	}
}