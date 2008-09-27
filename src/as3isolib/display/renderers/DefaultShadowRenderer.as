package as3isolib.display.renderers
{
	import as3isolib.bounds.IBounds;
	import as3isolib.display.IContainer;
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Graphics;
	import flash.events.EventDispatcher;
	
	public class DefaultShadowRenderer extends EventDispatcher implements ISceneRenderer
	{
		////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////
		
		public function DefaultShadowRenderer (shadowColor:uint = 0x000000, shadowAlpha:Number = 0.15, drawAll:Boolean = false)
		{
			this.shadowColor = shadowColor; 
			this.shadowAlpha = shadowAlpha;
			
			this.drawAll = drawAll;
		}
		
		////////////////////////////////////////////////////
		//	TARGET
		////////////////////////////////////////////////////
		
		private var _target:IContainer
		
		public function get target ():IContainer
		{
			return _target;
		}
		
		public function set target (value:IContainer):void
		{
			_target = value;
		}
		
		////////////////////////////////////////////////////
		//	STYLES
		////////////////////////////////////////////////////
		
		private var drawAll:Boolean = false;
		
		private var shadowColor:uint = 0x000000;
		private var shadowAlpha:Number = 0.15;
		
		////////////////////////////////////////////////////
		//	RENDERER
		////////////////////////////////////////////////////
		
		public function renderScene ():void
		{
			if (!_target)
				return;
			
			g = _target.container.graphics;
			g.clear();
			g.beginFill(shadowColor, shadowAlpha);
			
			var shadowChildren:Array = target.children;
			var child:IIsoDisplayObject;
			for each (child in shadowChildren)
			{
				if (drawAll)
					drawChildShadow(child);
				
				else
				{
					if (child.z > 0)
						drawChildShadow(child);
				}
			}
			
			g.endFill();
		}
		
		private var g:Graphics;
		
		private function drawChildShadow (child:IIsoDisplayObject):void
		{
			var b:IBounds = child.isoBounds;
			var pt:Pt;
			
			pt = IsoMath.isoToScreen(new Pt(b.left, b.back, 0));
			g.moveTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(b.right, b.back, 0));
			g.lineTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(b.right, b.front, 0));
			g.lineTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(b.left, b.front, 0));
			g.lineTo(pt.x, pt.y);
			
			pt = IsoMath.isoToScreen(new Pt(b.left, b.back, 0));
			g.lineTo(pt.x, pt.y);
		}
		
	}
}