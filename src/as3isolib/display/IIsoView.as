package as3isolib.display
{
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.geom.Pt;
	
	/**
	 * The IIsoView interface defines methods necessary to properly perform panning, zooming and other display task for a given IIsoScene.
	 * The implementor normally wraps an IIsoScene with layout constraints.
	 */
	public interface IIsoView
	{
		/**
		 * The current pt relative to the child scene objects and the center of the IIsoView.
		 */
		function get currentPt ():Pt;
		
		/**
		 * Centers the IIsoView on a given pt within the current child scene objects.
		 * 
		 * @param pt The pt to pan and center on.
		 * @param isIsometric A flag indicating wether the pt parameter represents a pt in 3D isometric space or screen coordinates.
		 */
		function centerOnPt (pt:Pt, isIsometric:Boolean = true):void;
		
		/**
		 * Centers the IIsoView on a given IIsoDisplayObject within the current child scene objects.
		 * 
		 * @param iso The IIsoDisplayObject to pan and center on.
		 */
		function centerOnIso (iso:IIsoDisplayObject):void;
		
		/**
		 * Pans the child scene objects by a given amount in screen coordinate space.
		 * 
		 * @param px The x value to pan by.
		 * @param py the y value to pan by.
		 */
		function pan (px:Number, py:Number):void;
		
		/**
		 * Zooms the child scene objects by a given amount.
		 * 
		 * @param zFactor The positive non-zero value to scale the child scene objects by.  This corresponds to the child scene objects' containers' scaleX and scaleY properties.
		 */
		function zoom (zFactor:Number):void;
		
		/**
		 * Resets the child scene objects to be centered within the IIsoView and returns the zoom factor back to a normal value.
		 */
		function reset ():void;
	}
}