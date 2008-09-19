package as3isolib.bounds
{
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.geom.Pt;
	
	import flash.geom.Rectangle;
	
	public interface IBounds
	{
		function get target ():IIsoDisplayObject;
		
		function get left ():Number;
		function get right ():Number;
		
		function get back ():Number;
		function get front ():Number;
		
		function get bottom ():Number;
		function get top ():Number;
		
		function get centerPt ():Pt;
		
		function intersects (bounds:IBounds):Boolean;
	}
}