package as3isolib.bounds
{
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.geom.Pt;

	public class PrimitiveBounds implements IBounds
	{
		////////////////////////////////////////////////////////////////
		//	LEFT / RIGHT
		////////////////////////////////////////////////////////////////
		
		public function get left ():Number
		{
			return _target.x;
		}
		
		public function get right ():Number
		{
			return _target.x + _target.width;
		}
		
		////////////////////////////////////////////////////////////////
		//	BACK / FRONT
		////////////////////////////////////////////////////////////////
		
		public function get back ():Number
		{
			return _target.y;
		}
		
		public function get front ():Number
		{
			return _target.y + _target.length;
		}
		
		////////////////////////////////////////////////////////////////
		//	BOTTOM / TOP
		////////////////////////////////////////////////////////////////
		
		public function get bottom ():Number
		{
			return _target.z;
		}
		
		public function get top ():Number
		{
			return _target.z + _target.height;
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
			if (centerPt.x + bounds.centerPt.x <= _target.width / 2 + target.width / 2 &&
				centerPt.y + bounds.centerPt.y <= _target.length / 2 + target.length / 2 &&
				centerPt.z + bounds.centerPt.z <= _target.height / 2 + target.height / 2)
				
				return true;
			
			else
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
		
		public function PrimitiveBounds (target:IIsoDisplayObject)
		{
			this._target = target;
		}
	}
}