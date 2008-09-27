package as3isolib.display.primitive
{
	import as3isolib.display.IsoDisplayObject;
	
	public class IsoBox extends IsoDisplayObject
	{
		public function IsoBox ()
		{
			super();
			
			lineThicknesses = [0, 0, 0, 3, 3, 3];
			faceColors = [0xffffff, 0xffffff, 0xcccccc, 0xffffff, 0xcccccc, 0x000000];
		}
		
		protected var sq0:IsoRectangle;
		protected var sq1:IsoRectangle;
		protected var sq2:IsoRectangle;
		protected var sq3:IsoRectangle;
		protected var sq4:IsoRectangle;
		protected var sq5:IsoRectangle;
		
		override protected function createChildren ():void
		{
			super.createChildren();
			
			var sq:IsoRectangle;
			var i:uint;
			for (i; i < 6; i++)
			{
				if (this['sq' + i] == null)
				{
					sq = new IsoRectangle();
					this['sq' + i] = sq;
				}
				
				addChild(sq);
			}
			
			sq0.id = "bottom";
			sq1.id = "left";
			sq2.id = "back";
			sq3.id = "front";
			sq4.id = "right";
			sq5.id = "top";
		}
		
		override protected function validateGeometry ():Boolean
		{
			return (width <= 0 && length <= 0 && height <= 0) ? false : true;
		}
		
		override protected function drawGeometry ():void
		{
			//bottom face
			sq0.width = width;
			sq0.length = length;
			sq0.height = 0;
			
			//back-left face
			sq1.width = 0;
			sq1.length = length;
			sq1.height = height;
			
			//back-right face
			sq2.width = width;
			sq2.length = 0;
			sq2.height = height;
			
			//front-left face
			sq3.width = width;
			sq3.length = 0;
			sq3.height = height;
			sq3.y = length;
			
			//front-right face
			sq4.width = 0;
			sq4.length = length;
			sq4.height = height;
			sq4.x = width;
			
			//top face
			sq5.width = width;
			sq5.length = length;
			sq5.height = 0;
			sq5.z = height;
			
			//now apply all common properties
			var sq:IsoRectangle;
			var i:int = numChildren - 1;
			var c:int;
			for (i; i >= 0; i--)
			{
				sq = IsoRectangle(getChildAt(i));
				
				//styling
				sq.lineAlphas = [lineAlphas[c]];
				sq.lineColors = [lineColors[c]];
				sq.lineThicknesses = [lineThicknesses[c]];
				sq.faceAlphas = [faceAlphas[c]];
				sq.faceColors = [faceColors[c]];
				sq.styleType = styleType;
				
				c++;
			}		
		}
	}
}