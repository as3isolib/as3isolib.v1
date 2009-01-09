package as3isolib.geom.transformations
{
	import as3isolib.geom.Pt;
	
	/**
	 * @private
	 */
	public class DimetricTransformation implements IAxonometricTransformation
	{
		static private var theta:Number = 42 * Math.PI / 180;
		static private var gamma:Number = 7 * Math.PI / 180;
		
		public function DimetricTransformation (theta:Number = 42, gamma:Number = 7)
		{
			DimetricTransformation.theta = theta * Math.PI / 180;
			DimetricTransformation.gamma = gamma * Math.PI / 180;
		}

		public function screenToSpace (screenPt:Pt):Pt
		{
			return null;
		}
		
		public function spaceToScreen (spacePt:Pt):Pt
		{
			/* if (bAxonometricAxesProjection)
			{
				spacePt.x = spacePt.x * axialProjection;
				spacePt.y = spacePt.y * axialProjection;
			} */		
			
			var z:Number = spacePt.z;
			var y:Number = (spacePt.x * Math.sin(gamma) + spacePt.y * Math.sin(theta)) / 2 - spacePt.z;
			var x:Number = spacePt.x * Math.cos(gamma) - (spacePt.y * Math.cos(theta)) / 2;
			
			return new Pt(x, y, z);
		}
		
	}
}