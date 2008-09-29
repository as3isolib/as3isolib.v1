package as3isolib.display
{
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class IsoView extends Sprite implements IIsoView
	{
		///////////////////////////////////////////////////////////////////////////////
		//	SCENE METHODS
		///////////////////////////////////////////////////////////////////////////////
		
		private var _currentScreenPt:Pt;
		
		public function get currentPt ():Pt
		{
			return _currentScreenPt.clone() as Pt;
		}
		
		public function centerOnPt (pt:Pt, isIsometrc:Boolean = true):void
		{
			var target:Pt = Pt(pt.clone());
			if (isIsometrc)
				IsoMath.isoToScreen(target);
			
			var dx:Number = _currentScreenPt.x - target.x;
			var dy:Number = _currentScreenPt.y - target.y;
			
			mainIsoScene.container.x += dx;
			mainIsoScene.container.y += dy;
			
			_currentScreenPt = target;
		}
		
		public function centerOnIso (iso:IIsoDisplayObject):void
		{
			centerOnPt(iso.isoBounds.centerPt);	
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	PAN
		///////////////////////////////////////////////////////////////////////////////
		
		public function pan (px:Number, py:Number):void
		{
			var pt:Pt = _currentScreenPt.clone() as Pt;
			pt.x += px;
			pt.y += py;
			
			centerOnPt(pt, false);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	ZOOM
		///////////////////////////////////////////////////////////////////////////////
		
		public function get currentZoom ():Number
		{
			return _zoomContainer.scaleX;
		}
		
		public function zoom (zFactor:Number):void
		{
			_zoomContainer.scaleX = _zoomContainer.scaleY = zFactor;
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	RESET
		///////////////////////////////////////////////////////////////////////////////
		
		public function reset ():void
		{
			_zoomContainer.scaleX = _zoomContainer.scaleY = 1;
			
			if (mainIsoScene)
			{
				var pt:Pt = mainIsoScene.isoBounds.centerPt;
				IsoMath.isoToScreen(pt);
				
				mainIsoScene.container.x = pt.x * -1;
				mainIsoScene.container.y = pt.y * -1;
				
				_currentScreenPt = pt;
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	SCENE
		///////////////////////////////////////////////////////////////////////////////
		
		private var mainIsoScene:IIsoScene;
		
		public function get scene ():IIsoScene
		{
			return mainIsoScene;
		}
		
		public function set scene (value:IIsoScene):void
		{
			if (mainIsoScene != value)
			{
				if (mainIsoScene)
					mainIsoScene.hostContainer = null;
				
				mainIsoScene = value;
				if (mainIsoScene)
				{
					mainIsoScene.hostContainer = _zoomContainer;
					reset();
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	SIZE
		///////////////////////////////////////////////////////////////////////////////
		
		private var _w:Number;
		private var _h:Number;
		
		override public function get width ():Number
		{
			return _w;
		}
		
		override public function get height ():Number
		{
			return _h;
		}
		
		public function get size ():Point
		{
			return new Point(_w, _h);
		}
		
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
		
		public function get clipContent ():Boolean
		{
			return _clipContent;
		}
		
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
		
		public function render (recursive:Boolean = true):void
		{
			if (mainIsoScene)
				mainIsoScene.render(recursive);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		private var _zoomContainer:Sprite;
		private var _mask:Shape;
		private var _border:Shape;
		
		public function IsoView ()
		{
			super();
			
			_zoomContainer = new Sprite();
			addChild(_zoomContainer);
			
			_mask = new Shape();
			addChild(_mask);
			
			_border = new Shape();
			addChild(_border);
			
			setSize(400, 250);
		}
	}
}