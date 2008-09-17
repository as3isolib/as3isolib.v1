package as3isolib.display.scene
{
	import as3isolib.bounds.IBounds;
	import as3isolib.core.data.INode;
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.display.IRenderer;
	import as3isolib.display.IsoContainer;
	import as3isolib.geom.Pt;
	import as3isolib.utils.IsoUtil;
	
	import flash.display.DisplayObjectContainer;
	
	public class IsoScene extends IsoContainer implements IRenderer
	{		
		///////////////////////////////////////////////////////////////////////////////
		//	HOST CONTAINER
		///////////////////////////////////////////////////////////////////////////////
		
		protected var host:DisplayObjectContainer;		
		
		public function get hostContainer ():DisplayObjectContainer
		{
			return host;
		}
		
		public function set hostContainer (value:DisplayObjectContainer):void
		{
			if (value && host != value)
			{
				if (host && host.contains(container))
					host.removeChild(container);
				
				else if (hasParent)
					parent.removeChild(this);
				
				host = value;
				if (host)
				{
					host.addChild(container);
					parentNode = null;
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	OVERRIDES
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt (child:INode, index:uint):void
		{
			if (child is IIsoDisplayObject)
				super.addChildAt(child, index);
				
			else
				throw new Error ("parameter child is not of type IIsoDisplayObject");
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	RENDER
		///////////////////////////////////////////////////////////////////////////////
		
		/**
		 * @inheritDoc
		 */
		override public function render (recursive:Boolean = true):void
		{
			var child:IIsoDisplayObject;
			var sceneInvalidated:Boolean = false;
			for each (child in children)
			{
				if (child.isInvalidated)
				{
					sceneInvalidated = true;
					break;
				}
			}
			
			if (sceneInvalidated)
			{
				var sortedChildren:Array = children.slice();//.sortOn(["depth", "screenY", "screenX", "z"], Array.NUMERIC);
				sortedChildren.sort(IsoUtil.isoDepthSort);
							
				var i:int;
				var m:int = sortedChildren.length;
				while (i < m)
					setChildIndex(IIsoDisplayObject(sortedChildren[i]), i++);
			}
			
			super.render(recursive);
		}
		
		///////////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		///////////////////////////////////////////////////////////////////////////////
		
		protected var camera:Pt
		
		public function IsoScene ()
		{
			super();
			
			camera = new Pt(10000, 10000, 10000);
		}
	}
}