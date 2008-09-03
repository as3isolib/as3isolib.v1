package isoLib.primitive
{
	import isoLib.core.shape.Primitive;
	
	public class IsoCube extends Primitive
	{
		protected var sq0:IsoSquare;
		protected var sq1:IsoSquare;
		protected var sq2:IsoSquare;
		protected var sq3:IsoSquare;
		protected var sq4:IsoSquare;
		protected var sq5:IsoSquare;
		
		override protected function createChildren ():void
		{
			super.createChildren();
			
			var sq:IsoSquare;
			var i:uint;
			for (i; i < 6; i++)
			{
				if (this['sq' + i] == null)
				{
					sq = new IsoSquare();
					this['sq' + i] = sq;
				}
				
				addChild(sq);
			}
		}
		
		override protected function validateGeometry ():Boolean
		{
			return (width <= 0 && length <= 0 && height <= 0)? false: true;
		}
		
		override protected function renderGeometry ():void
		{
			//bottom face
			sq0.width = width;
			sq0.length = length;
			
			//back-left face
			sq1.length = length;
			sq1.height = height;
			
			//back-right face
			sq2.width = width;
			sq2.height = height;
			
			//front-left face
			sq3.width = width;
			sq3.height = height;
			sq3.y = length;
			
			//front-right face
			sq4.length = length;
			sq4.height = height;
			sq4.x = width;
			
			//top face
			sq5.width = width;
			sq5.length = length;
			sq5.z = height;
			
			//now apply all common properties
			var sq:IsoSquare;
			var i:int = numChildren - 1;
			var c:int;
			for (i; i >= 0; i--)
			{
				sq = IsoSquare(children[i]);
				
				//styling
				sq.lineAlphas = [lineAlphas[c]];
				sq.lineColors = [lineColors[c]];
				sq.lineThicknesses = [lineThicknesses[c]];
				sq.faceAlphas = [faceAlphas[c]];
				sq.shadedColors = [shadedColors[c]];
				sq.solidColors = [solidColors[c]];
				sq.type = type;
				
				c++;
			}		
		}
	}
}