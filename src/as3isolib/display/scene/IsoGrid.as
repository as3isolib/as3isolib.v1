package as3isolib.display.scene
{
	import as3isolib.display.primitive.IsoPrimitive;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Graphics;

	public class IsoGrid extends IsoPrimitive
	{
		////////////////////////////////////////////////////
		//	GRID SIZE
		////////////////////////////////////////////////////
		
		private var gSize:Array = [0, 0];
		
		public function get gridSize ():Array
		{
			return gSize;
		}
		
		public function setGridSize (width:uint, length:uint, height:uint = 0):void
		{
			if (gSize[0] != width || gSize[1] != length || gSize[2] != height)
			{
				gSize = [width, length, height];
				invalidateGeometry();
			}
		}
		
		////////////////////////////////////////////////////
		//	CELL SIZE
		////////////////////////////////////////////////////
		
		private var cSize:Number;
		
		public function get cellSize ():Number
		{
			return cSize;
		}
		
		public function set cellSize (value:Number):void
		{
			if (value < 2)
				throw new Error("cellSize must be a positive value greater than 2");
			
			if (cSize != value)
			{
				cSize = value;
				invalidateGeometry();
			}
		}
		
		////////////////////////////////////////////////////
		//	SHOW ORIGIN
		////////////////////////////////////////////////////
		
		private var showOrigin:Boolean = false;
		private var showOriginChanged:Boolean = false;
		
		public function get hasOrigin ():Boolean
		{
			return showOrigin;
		}
		
		public function set hasOrigin (value:Boolean):void
		{
			if (showOrigin != value)
			{
				showOrigin = value;
				invalidateGeometry();
			}
		}
		
		////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////
		
		public function IsoGrid ()
		{
			super();
			
			hasOrigin = true;
			
			lineThicknesses = [0];
			lineColors = [0xcccccc];
			lineAlphas = [0.5];
			
			cellSize = 25;
			setGridSize(5, 5);
		}
		
		private var origin:IsoOrigin;
		
		override protected function createChildren ():void
		{
			origin = new IsoOrigin();
			addChild(origin);
		}
		
		override protected function drawGeometry ():void
		{
			var g:Graphics = container.graphics;
			g.clear();
			
			g.lineStyle(lineThicknesses[0], lineColors[0], lineAlphas[0]);
			
			var pt:Pt = new Pt();
			
			var i:int;
			var m:int = int(gridSize[0]);
			while (i <= m)
			{
				pt = IsoMath.isoToScreen(new Pt(cellSize * i));
				g.moveTo(pt.x, pt.y);
				
				pt = IsoMath.isoToScreen(new Pt(cellSize * i, cellSize * gridSize[1]));
				g.lineTo(pt.x, pt.y);
				
				i++;
			}
			
			i = 0;
			m = int(gridSize[1]);
			while (i <= m)
			{
				pt = IsoMath.isoToScreen(new Pt(0, cellSize * i));
				g.moveTo(pt.x, pt.y);
				
				pt = IsoMath.isoToScreen(new Pt(cellSize * gridSize[0], cellSize * i));
				g.lineTo(pt.x, pt.y);
				
				i++;
			}
		}
		
	}
}