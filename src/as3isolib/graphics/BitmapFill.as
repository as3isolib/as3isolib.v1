/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 - 2008 J.W.Opitz, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
package as3isolib.graphics
{
	import as3isolib.enum.IsoOrientation;
	import as3isolib.utils.IsoDrawingUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.geom.Matrix;
	import flash.utils.getDefinitionByName;

	public class BitmapFill implements IFill
	{
		///////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function BitmapFill (source:Object, orientation:String = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
		{
			this.source = source;
			this.orientation = orientation;
			
			if (matrix)
				this.matrix = matrix;
			
			this.repeat = repeat;
			this.smooth = smooth;
		}
		
		///////////////////////////////////////////////////////////
		//	SOURCE
		///////////////////////////////////////////////////////////
		
		private var bitmapData:BitmapData;
		
		/**
		 * @private
		 */
		public function get source ():Object
		{
			return bitmapData;
		}
		
		/**
		 * The source object for the bitmap fill.
		 */
		public function set source (value:Object):void
		{
			var tempSprite:DisplayObject;
			
			if (value is BitmapData)
			{
				bitmapData = BitmapData(value);
				return;
			}
			
			if (value is Class)
			{
				var classInstance:Class = Class(value);
				tempSprite = new classInstance();
			}
			
			else if (value is Bitmap)
				bitmapData = Bitmap(value).bitmapData;
			
			else if (value is DisplayObject)
				tempSprite = DisplayObject(value);
			
			else if (value is String)
			{
				classInstance = Class(getDefinitionByName(String(value)));
				tempSprite = new classInstance();
			}
			
			else
				return;
				
			if (!bitmapData && tempSprite)
			{
				bitmapData = new BitmapData(tempSprite.width, tempSprite.height);
				bitmapData.draw(tempSprite, new Matrix());
			}
		}
		
		///////////////////////////////////////////////////////////
		//	ORIENTATION
		///////////////////////////////////////////////////////////
		
		private var _orientation:String;
		
		public function get orientation ():String
		{
			return _orientation;
		}
		
		public function set orientation (value:String):void
		{
			_orientation = value;
			
			if (value == IsoOrientation.XY ||
				value == IsoOrientation.XZ ||
				value == IsoOrientation.YZ)
			{
				matrix = IsoDrawingUtil.getIsoMatrix(value);
			}
		}
		
		///////////////////////////////////////////////////////////
		//	props
		///////////////////////////////////////////////////////////
		
		public var matrix:Matrix;
		
		public var repeat:Boolean;
		public var smooth:Boolean;
		
		///////////////////////////////////////////////////////////
		//	IFILL
		///////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function begin (target:Graphics):void
		{			
			target.beginBitmapFill(bitmapData, matrix, repeat, smooth);
		}
		
		/**
		 * @inheritDoc
		 */
		public function end (target:Graphics):void
		{
			target.endFill();
		}
	}
}