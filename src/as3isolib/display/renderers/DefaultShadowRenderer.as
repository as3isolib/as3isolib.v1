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
package as3isolib.display.renderers
{
	import as3isolib.bounds.IBounds;
	import as3isolib.core.IIsoDisplayObject;
	import as3isolib.display.scene.IIsoScene;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import flash.display.Graphics;
	import flash.events.EventDispatcher;
	
	/**
	 * The DefaultShadowRenderer class is the default renderer for applying basic shadowing on child objects of the target IIsoScene.
	 */
	public class DefaultShadowRenderer extends EventDispatcher implements ISceneRenderer
	{
		////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function DefaultShadowRenderer (shadowColor:uint = 0x000000, shadowAlpha:Number = 0.15, drawAll:Boolean = false)
		{
			this.shadowColor = shadowColor; 
			this.shadowAlpha = shadowAlpha;
			
			this.drawAll = drawAll;
		}
		
		////////////////////////////////////////////////////
		//	TARGET
		////////////////////////////////////////////////////
		
		private var _target:IIsoScene
		
		/**
		 * @private
		 */
		public function get target ():IIsoScene
		{
			return _target;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set target (value:IIsoScene):void
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
		
		/**
		 * @inheritDoc
		 */
		public function renderScene ():void
		{
			if (!_target)
				return;
			
			g = _target.container.graphics;
			g.clear();
			
			var shadowChildren:Array = target.children;
			var child:IIsoDisplayObject;
			for each (child in shadowChildren)
			{
				
				if (drawAll)
				{
					g.beginFill(shadowColor, shadowAlpha);
					drawChildShadow(child);
				}
				
				else
				{
					if (child.z > 0)
					{
						g.beginFill(shadowColor, shadowAlpha);
						drawChildShadow(child);
					}
				}
				
				g.endFill();
			}
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