package as3isolib.utils
{
	import as3isolib.enum.IsoOrientation;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Graphics;
	
	/**
	 * IsoDrawingUtil provides some convenience methods for drawing shapes in 3D isometric space.
	 */
	public class IsoDrawingUtil
	{
		/* static public function drawIsoCircle (g:Graphics, originPt:Pt, radius:Number, plane:String = "xy"):void
		{
			switch (plane)
			{
				case IsoOrientation.YZ:
				{					
					break;
				}
				
				case IsoOrientation.XZ:
				{
					break;
				}
				
				case IsoOrientation.XY:
				default:
				{
					var ptX:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 135 * Math.PI / 180));
					var ptY:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 225 * Math.PI / 180));
					var ptW:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 315 * Math.PI / 180));
					var ptH:Pt = IsoMath.isoToScreen(Pt.polar(originPt, radius, 45 * Math.PI / 180));
					
					g.drawEllipse(ptX.x, ptY.y, ptW.x - ptX.x, ptH.y - ptY.y);
				}
			}
		} */
		
		/**
		 * Draws a rectangle in 3D isometric space relative to a specific plane.
		 * 
		 * @param g The target graphics object performing the drawing tasks.
		 * @param originPt The origin pt where the specific drawing task originates.
		 * @param width The width of the rectangle. This is relative to the first orientation axis in the given plane.
		 * @param length The length of the rectangle. This is relative to the second orientation axis in the given plane.
		 * @param plane The plane of orientation to draw the rectangle on.
		 */
		static public function drawIsoRectangle (g:Graphics, originPt:Pt, width:Number, length:Number, plane:String = "xy"):void
		{
			var pt0:Pt = IsoMath.isoToScreen(originPt, true);
			switch (plane)
			{
				case IsoOrientation.XZ:
				{
					var pt1:Pt = IsoMath.isoToScreen(new Pt(originPt.x + width, originPt.y, originPt.z));
					var pt2:Pt = IsoMath.isoToScreen(new Pt(originPt.x + width, originPt.y, originPt.z + length));
					var pt3:Pt = IsoMath.isoToScreen(new Pt(originPt.x, originPt.y, originPt.z + length));
					
					break;
				}
				
				case IsoOrientation.YZ:
				{
					pt1 = IsoMath.isoToScreen(new Pt(originPt.x, originPt.y + width, originPt.z));
					pt2 = IsoMath.isoToScreen(new Pt(originPt.x, originPt.y + width, originPt.z + length));
					pt3 = IsoMath.isoToScreen(new Pt(originPt.x, originPt.y, originPt.z + length));
					
					break;
				}
				
				case IsoOrientation.XY:
				default:
				{
					pt1 = IsoMath.isoToScreen(new Pt(originPt.x + width, originPt.y, originPt.z));
					pt2 = IsoMath.isoToScreen(new Pt(originPt.x + width, originPt.y + length, originPt.z));
					pt3 = IsoMath.isoToScreen(new Pt(originPt.x, originPt.y + length, originPt.z));
				}
			}
			
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			g.lineTo(pt2.x, pt2.y);
			g.lineTo(pt3.x, pt3.y);
			g.lineTo(pt0.x, pt0.y);
		}
		
		/**
		 * Draws an arrow in 3D isometric space relative to a specific plane.
		 * 
		 * @param g The target graphics object performing the drawing tasks.
		 * @param originPt The origin pt where the specific drawing task originates.
		 * @param degrees The angle of rotation in degrees perpendicular to the plane of orientation.
		 * @param length The length of the arrow.
		 * @param width The width of the arrow.
		 * @param plane The plane of orientation to draw the arrow on.
		 */
		static public function drawIsoArrow (g:Graphics, originPt:Pt, degrees:Number, length:Number = 27, width:Number = 6, plane:String = "xy"):void
		{			
			var pt0:Pt = new Pt();
			var pt1:Pt = new Pt();
			var pt2:Pt = new Pt();
			
			var toRadians:Number = Math.PI / 180;
			
			var ptR:Pt;
			
			switch (plane)
			{
				case IsoOrientation.XZ:
				{
					pt0 = Pt.polar(new Pt(0, 0, 0), length, degrees * toRadians)
					ptR = new Pt(pt0.x + originPt.x, pt0.z + originPt.y, pt0.y + originPt.z);
					pt0 = IsoMath.isoToScreen(ptR);
					
					pt1 = Pt.polar(new Pt(0, 0, 0), width / 2, (degrees + 90) * toRadians)
					ptR = new Pt(pt1.x + originPt.x, pt1.z + originPt.y, pt1.y + originPt.z);
					pt1 = IsoMath.isoToScreen(ptR);
					
					pt2 = Pt.polar(new Pt(0, 0, 0), width / 2, (degrees + 270) * toRadians)
					ptR = new Pt(pt2.x + originPt.x, pt2.z + originPt.y, pt2.y + originPt.z);
					pt2 = IsoMath.isoToScreen(ptR);
					
					break;
				}
				
				case IsoOrientation.YZ:
				{
					pt0 = Pt.polar(new Pt(0, 0, 0), length, degrees * toRadians)
					ptR = new Pt(pt0.z + originPt.x, pt0.x + originPt.y, pt0.y + originPt.z);
					pt0 = IsoMath.isoToScreen(ptR);
					
					pt1 = Pt.polar(new Pt(0, 0, 0), width / 2, (degrees + 90) * toRadians)
					ptR = new Pt(pt1.z + originPt.x, pt1.x + originPt.y, pt1.y + originPt.z);
					pt1 = IsoMath.isoToScreen(ptR);
					
					pt2 = Pt.polar(new Pt(0, 0, 0), width / 2, (degrees + 270) * toRadians)
					ptR = new Pt(pt2.z + originPt.x, pt2.x + originPt.y, pt2.y + originPt.z);
					pt2 = IsoMath.isoToScreen(ptR);
					
					break;
				}
				
				case IsoOrientation.XY:
				default:
				{
					pt0 = Pt.polar(originPt, length, degrees * toRadians)
					pt0 = IsoMath.isoToScreen(pt0);
					
					pt1 = Pt.polar(originPt, width / 2, (degrees + 90) * toRadians)
					pt1 = IsoMath.isoToScreen(pt1);
					
					pt2 = Pt.polar(originPt, width / 2, (degrees + 270) * toRadians)
					pt2 = IsoMath.isoToScreen(pt2);
					
				}
			}
			
			g.moveTo(pt0.x, pt0.y);
			g.lineTo(pt1.x, pt1.y);
			g.lineTo(pt2.x, pt2.y);
			g.lineTo(pt0.x, pt0.y);
		}
	}
}