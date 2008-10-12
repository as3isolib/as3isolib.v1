/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 J.W.Opitz, All Rights Reserved.

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
package as3isolib.display
{
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * IsoView is a default view port that provides basic panning and zooming functionality on a given IIsoScene.
	 */
	public class IsoView extends Sprite implements IIsoView
	{
		///////////////////////////////////////////////////////////////////////////////
		//	SCENE METHODS
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var currentScreenPt:Pt;
		
		/**
		 * @inheritDoc
		 */
		public function get currentPt ():Pt
		{
			return currentScreenPt.clone() as Pt;
		}
		
		/**
		 * @inheritDoc
		 */
		public function centerOnPt (pt:Pt, isIsometrc:Boolean = true):void
		{
			var target:Pt = Pt(pt.clone());
			if (isIsometrc)
				IsoMath.isoToScreen(target);
			
			var dx:Number = currentScreenPt.x - target.x;
			var dy:Number = currentScreenPt.y - target.y;
			
			_mainContainer.x += dx;
			_mainContainer.y += dy;
			
			currentScreenPt = target;
		}
		
		/**
		 * @inheritDoc
		 */
		public function centerOnIso (iso:IIsoDisplayObject):void
		{
			centerOnPt(iso.isoBounds.centerPt);	
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	PAN
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function pan (px:Number, py:Number):void
		{
			var pt:Pt = currentScreenPt.clone() as Pt;
			pt.x += px;
			pt.y += py;
			
			centerOnPt(pt, false);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	ZOOM
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * The current zoom factor applied to the child scene objects.
		 */
		public function get currentZoom ():Number
		{
			return _zoomContainer.scaleX;
		}
		
		/**
		 * @inheritDoc
		 */
		public function zoom (zFactor:Number):void
		{
			_zoomContainer.scaleX = _zoomContainer.scaleY = zFactor;
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	RESET
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		public function reset ():void
		{
			_zoomContainer.scaleX = _zoomContainer.scaleY = 1;
			
			if (mainIsoScene)
			{
				var pt:Pt = mainIsoScene.isoBounds.centerPt;
				IsoMath.isoToScreen(pt);
				
				_mainContainer.x = pt.x * -1;
				_mainContainer.y = pt.y * -1;
				
				currentScreenPt = pt;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	SCENE
		///////////////////////////////////////////////////////////////////////////////
		
		private var mainIsoScene:IIsoScene;
		
		/**
		 * @private
		 */
		public function get scene ():IIsoScene
		{
			return mainIsoScene;
		}
		
		/**
		 * The child scene object that this IsoView wraps.
		 */
		public function set scene (value:IIsoScene):void
		{
			if (mainIsoScene != value)
			{
				if (mainIsoScene)
					mainIsoScene.hostContainer = null;
				
				mainIsoScene = value;
				if (mainIsoScene)
				{
					mainIsoScene.hostContainer = _isoContainer;
					reset();
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	SIZE
		///////////////////////////////////////////////////////////////////////////////
		
		private var _w:Number;
		private var _h:Number;
		
		/**
		 * @inheritDoc
		 */
		override public function get width ():Number
		{
			return _w;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get height ():Number
		{
			return _h;
		}
		
		/**
		 * The current size of the IsoView.
		 * Returns a Point whose x corresponds to the width and y corresponds to the height.
		 */
		public function get size ():Point
		{
			return new Point(_w, _h);
		}
		
		/**
		 * Set the size of the IsoView and repositions child scene objects, masks and borders (where applicable).
		 * 
		 * @param w The width to resize to.
		 * @param h The height to resize to.
		 */
		public function setSize (w:Number, h:Number):void
		{
			_w = w;
			_h = h;
			
			_zoomContainer.x = _w / 2;
			_zoomContainer.y = _h / 2;
			_zoomContainer.mask = _clipContent ? _mask : null;
			
			_mask.graphics.clear();
			if (_clipContent)
			{
				_mask.graphics.beginFill(0);
				_mask.graphics.drawRect(0, 0, _w, _h);
				_mask.graphics.endFill();
			}
			
			_border.graphics.clear();
			_border.graphics.lineStyle(0);
			_border.graphics.drawRect(0, 0, _w, _h);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CLIP CONTENT
		///////////////////////////////////////////////////////////////////////////////
		
		private var _clipContent:Boolean = true;
		
		/**
		 * @private
		 */
		public function get clipContent ():Boolean
		{
			return _clipContent;
		}
		
		/**
		 * Flag indicating where to allow content to visibly extend beyond the boundries of this IsoView.
		 */
		public function set clipContent (value:Boolean):void
		{
			if (_clipContent != value)
			{
				_clipContent = value;
				reset();
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Render the child scene objects.
		 * 
		 * @param recursive Flag indicating if each child scene object should render its children.
		 */
		public function render (recursive:Boolean = true):void
		{
			if (mainIsoScene)
				mainIsoScene.render(recursive);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONTAINER STRUCTURE
		///////////////////////////////////////////////////////////////////////////////
		
		private var _zoomContainer:Sprite;
		
		/**
		 * @private
		 */
		protected var _mainContainer:Sprite;
		
		private var _bgContainer:Sprite;
		
		/**
		 * The container for background elements.
		 */
		public function get backgroundContainer ():Sprite
		{
			if (!_bgContainer)
			{
				_bgContainer = new Sprite();
				_mainContainer.addChildAt(_bgContainer, 0);
			}
			
			return _bgContainer;
		}
		
		private var _isoContainer:Sprite;
		private var _fgContainer:Sprite;
		
		/**
		 * The container for foreground elements.
		 */
		public function get foregroundContainer ():Sprite
		{
			if (!_fgContainer)
			{
				_fgContainer = new Sprite();
				_mainContainer.addChild(_fgContainer);
			}
			
			return _fgContainer;
		}
		
		private var _mask:Shape;
		private var _border:Shape;
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function IsoView ()
		{
			super();
			
			_isoContainer = new Sprite();
			
			_mainContainer = new Sprite();
			_mainContainer.addChild(_isoContainer);
			
			_zoomContainer = new Sprite();
			_zoomContainer.addChild(_mainContainer);
			addChild(_zoomContainer);
			
			_mask = new Shape();
			addChild(_mask);
			
			_border = new Shape();
			addChild(_border);
			
			setSize(400, 250);
		}
	}
}