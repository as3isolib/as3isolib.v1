package as3isolib.display.scene
{
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Graphics;
	
	public class IsoOrigin extends IsoPrimitive
	{
		override protected function drawGeometry ():void
		{
			var pt0:Pt = IsoMath.isoToScreen(new Pt(-1 * axisLength, 0, 0));
			var ptM:Pt;
			var pt1:Pt = IsoMath.isoToScreen(new Pt(axisLength, 0, 0));
			
			var g:Graphics = container.graphics;
			g.clear();
			
			//draw x-axis
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0]);
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			
			/* g.moveTo(pt0.x, pt0.y);
			g.beginFill(lineColors[0], lineAlphas[0]);
			IsoDrawUtils.drawIsoArrow2(g, new Pt(-1 * axisLength, 0), 180, IsoOrientation.XY);
			g.endFill();
			
			g.moveTo(pt1.x, pt1.y);
			g.beginFill(lineColors[0], lineAlphas[0]);
			IsoDrawUtils.drawIsoArrow2(g, new Pt(axisLength, 0), 0, IsoOrientation.XY);
			g.endFill(); */
			
			//draw y-axis
			pt0 = IsoMath.isoToScreen(new Pt(0, -1 * axisLength, 0));
			pt1 = IsoMath.isoToScreen(new Pt(0, axisLength, 0));
			
			g.lineStyle(lineThicknesses[1], lineColors[1], lineAlphas[1]);
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			
			/* g.moveTo(pt0.x, pt0.y);
			g.beginFill(lineColors[1], lineAlphas[1]);
			IsoDrawUtils.drawIsoArrow2(g, new Pt(0, -1 * axisLength), 270, IsoOrientation.XY);
			g.endFill();
			
			g.moveTo(pt1.x, pt1.y);
			g.beginFill(lineColors[1], lineAlphas[1]);
			IsoDrawUtils.drawIsoArrow2(g, new Pt(0, axisLength), 90, IsoOrientation.XY);
			g.endFill(); */
			
			//draw z-axis
			pt0 = IsoMath.isoToScreen(new Pt(0, 0, -1 * axisLength));
			pt1 = IsoMath.isoToScreen(new Pt(0, 0, axisLength));
			
			g.lineStyle(lineThicknesses[2], lineColors[2], lineAlphas[2]);
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			
			/* g.moveTo(pt0.x, pt0.y);
			g.beginFill(lineColors[2], lineAlphas[2]);
			IsoDrawUtils.drawIsoArrow2(g, new Pt(0, 0, axisLength), 90, IsoOrientation.XZ);
			g.endFill();
			
			g.moveTo(pt1.x, pt1.y);
			g.beginFill(lineColors[2], lineAlphas[2]);
			IsoDrawUtils.drawIsoArrow2(g, new Pt(0, 0, -1 * axisLength), 270, IsoOrientation.XZ);
			g.endFill(); */
		}
		
		public var axisLength:Number = 100;
		public var arrowLength:Number = 20;
		public var arrowWidth:Number = 3;
		
		public function IsoOrigin ()
		{
			super();
			
			lineThicknesses = [0, 0, 0]
			lineColors = [0xff0000, 0x00ff00, 0x0000ff];
			lineAlphas = [0.75, 0.75, 0.75];
		}
		
		override public function set width (value:Number):void
		{
			super.width = 0;
		}
		
		override public function set length (value:Number):void
		{
			super.length = 0;
		}
		
		override public function set height (value:Number):void
		{
			super.height = 0;
		}
	}
}