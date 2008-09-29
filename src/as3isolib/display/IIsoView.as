package as3isolib.display
{
	import as3isolib.display.IIsoDisplayObject;
	import as3isolib.geom.Pt;
	
	public interface IIsoView
	{
		function get currentPt ():Pt;
		
		function centerOnPt (pt:Pt, isIsometric:Boolean = true):void;
		function centerOnIso (iso:IIsoDisplayObject):void;
		
		function pan (px:Number, py:Number):void;
		function zoom (zFactor:Number):void;
		
		function reset ():void;
	}
}