package isoLib.core.shape
{
	import isoLib.core.sceneGraph.INode;
	
	public interface IPrimitive extends INode
	{
		function get x ():Number;
		function set x (value:Number):void;
		
		function get y ():Number;
		function set y (value:Number):void;
		
		function get z ():Number;
		function set z (value:Number):void;
		
		function get width ():Number;
		function set width (value:Number):void;
		
		function get length ():Number;
		function set length (value:Number):void;
		
		function get height ():Number;
		function set height (value:Number):void;
		
		function get type ():String;
		function set type (value:String):void;
		
		function get geometryInvalidated ():Boolean;
		function get positionInvalidated ():Boolean;
		function get stylesInvalidated ():Boolean;
		
		function invalidateGeometry ():void;
		function invalidatePosition ():void;
		function invalidateStyles ():void;
	}
}