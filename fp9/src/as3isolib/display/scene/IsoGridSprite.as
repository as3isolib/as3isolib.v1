package as3isolib.display.scene 
{
	import as3isolib.data.INode;
	import as3isolib.display.IsoSprite;
	import as3isolib.geom.Pt;
	import as3isolib.geom.IsoMath;
	import as3isolib.graphics.Stroke;
	import as3isolib.graphics.IStroke;
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * <p>Replacement for IsoGrid that actually has spatial presence.  Much of the code was lifted straight from IsoGrid.</p>
	 * 
	 * <p>The grid size is not in cell units, but in iso coordinates taken directly from its width and length.  Grid lines are drawn every cellSize units across the grid.</p>
	 * 
	 * <p>There is no option to display the origin, since this grid can be placed anywhere in isometric space, just like any other object.</p>
	 * 
	 * @author David Holz (permission granted to as3isolib project to MIT license this file)
	 */
	public class IsoGridSprite extends IsoSprite
	{
		/**
		 * Local sprite for drawing the grid
		 */
		private var gfx:Sprite = new Sprite();

		public function IsoGridSprite()
		{
			sprites = [gfx];
			gridlines = new Stroke(0, 0xCCCCCC, 0.5);
			cellSize = 25;
			setGridSize(5, 5);
			return;
		}
		
		////////////////////////////////////////////////////
		//	GRID SIZE
		////////////////////////////////////////////////////
		
		/**
		 * Sets the number of grid cells in each direction respectively.  This is a
		 * shortcut for setting the width & length using the current cell size, and will
		 * not reflect a change in size if the cell size is modified afterwards.
		 * 
		 * @param width The number of cells along the x-axis.
		 * @param length The number of cells along the y-axis.
		 * @param height The number of cells along the z-axis (currently not implemented).
		 */
		public function setGridSize (width:uint, length:uint, height:uint = 0):void
		{
			this.width = width * cSize;
			this.length = length * cSize;
			this.height = height * cSize;
		}

		////////////////////////////////////////////////////
		//	CELL SIZE
		////////////////////////////////////////////////////
		
		private var cSize:Number;
		
		/**
		 * @private
		 */
		public function get cellSize ():Number
		{
			return cSize;
		}
		
		/**
		 * Represents the size of each grid cell.  This value sets both the width, length and height (where applicable) to the same size.
		 */
		public function set cellSize (value:Number):void
		{
			if (value < 2)
				throw new Error("cellSize must be a positive value greater than 2");
				
			if (cSize != value)
			{
				cSize = value;
				invalidateSize();
			}
		}
		

		////////////////////////////////////////////////////
		//	GRID STYLES
		////////////////////////////////////////////////////
		
		private var stroke:IStroke = new Stroke(0, 0x000000);
		
		public function get gridlines ():IStroke
		{
			return stroke;
		}
		
		public function set gridlines (value:IStroke):void
		{
			stroke = value;
		}

		
		////////////////////////////////////////////////////
		//	RENDERING
		////////////////////////////////////////////////////

		/**
		 * Redraw the grid any time the size changes.
		 */
		override public function invalidateSize():void 
		{
			super.invalidateSize();
			redraw();
		}
		
		private function redraw():void
		{
			var g:Graphics = gfx.graphics;
			g.clear();
			
			stroke.apply(g);
			
			var pt:Pt = new Pt();
			var draw:Function = function(fun:Function, x:Number, y:Number)
			{
				pt = IsoMath.isoToScreen(new Pt(x, y, 0));
				fun.apply(null, [pt.x, pt.y]);
			};
			

			// Draw the y hatches
			for (var x:Number = cSize; x < width; x += cSize)
			{
				draw(g.moveTo, x, 0);
				draw(g.lineTo, x, length);
			}
			
			// Draw the x hatches
			for (var y:Number = cSize; y < length; y += cSize)
			{
				draw(g.moveTo, 0, y);
				draw(g.lineTo, width, y);
			}
			
			// Draw the border and the invisible fill to receive mouse events
			g.beginFill(0xFF0000, 0.0);
			draw(g.moveTo, 0, 0);
			draw(g.lineTo, width, 0);
			draw(g.lineTo, width, length);
			draw(g.lineTo, 0, length);
			draw(g.lineTo, 0, 0);
			g.endFill();
		}
	}
	
}