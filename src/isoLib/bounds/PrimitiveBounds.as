package isoLib.bounds
{
	import isoLib.core.shape.IPrimitive;
	
	public class PrimitiveBounds implements IBounds
	{
		private var primitive:IPrimitive;
		
		public function PrimitiveBounds (target:IPrimitive)
		{
			primitive = target;
		}
	}
}