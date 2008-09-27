package as3isolib.bounds
{
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.geom.Pt;

	public class SceneBounds implements IBounds
	{
		public function get left ():Number
		{
			var value:Number;
			
			var child:IIsoDisplayObject;
			for each (child in target.children)
			{
				if (isNaN(value) || child.isoBounds.left < value)
					value = child.isoBounds.left;
			}
			
			return value;
		}
		
		public function get right ():Number
		{
			var value:Number;
			
			var child:IIsoDisplayObject;
			for each (child in target.children)
			{
				if (isNaN(value) || child.isoBounds.right > value)
					value = child.isoBounds.right;
			}
			
			return value;
		}
		
		public function get back ():Number
		{
			var value:Number;
			
			var child:IIsoDisplayObject;
			for each (child in target.children)
			{
				if (isNaN(value) || child.isoBounds.back < value)
					value = child.isoBounds.back;
			}
			
			return value;
		}
		
		public function get front ():Number
		{
			var value:Number;
			
			var child:IIsoDisplayObject;
			for each (child in target.children)
			{
				if (isNaN(value) || child.isoBounds.front > value)
					value = child.isoBounds.front;
			}
			
			return value;
		}
		
		public function get bottom ():Number
		{
			var value:Number;
			
			var child:IIsoDisplayObject;
			for each (child in target.children)
			{
				if (isNaN(value) || child.isoBounds.bottom < value)
					value = child.isoBounds.bottom;
			}
			
			return value;
		}
		
		public function get top ():Number
		{
			var value:Number;
			
			var child:IIsoDisplayObject;
			for each (child in target.children)
			{
				if (isNaN(value) || child.isoBounds.top > value)
					value = child.isoBounds.top;
			}
			
			return value;
		}
		
		////////////////////////////////////////////////////////////////
		//	CENTER PT
		////////////////////////////////////////////////////////////////
		
		public function get centerPt ():Pt
		{
			var pt:Pt = new Pt();
			pt.x = _target.x + _target.width / 2;
			pt.y = _target.y + _target.length / 2;
			pt.z = _target.z + _target.height / 2;
			
			return pt;
		}
		
		////////////////////////////////////////////////////////////////
		//	COLLISION
		////////////////////////////////////////////////////////////////
		
		public function intersects (bounds:IBounds):Boolean
		{
			return false;
		}
		
		////////////////////////////////////////////////////////////////
		//	TARGET
		////////////////////////////////////////////////////////////////
		
		private var _target:IIsoDisplayObject;
		
		public function get target ():IIsoDisplayObject
		{
			return _target;
		}
		
		////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////
		
		public function SceneBounds (target:IIsoDisplayObject)
		{
			this._target = target;
		}
	}
}