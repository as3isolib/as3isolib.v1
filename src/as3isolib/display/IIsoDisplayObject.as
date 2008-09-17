package as3isolib.display
{
	import as3isolib.bounds.IBounds;
	import as3isolib.core.data.INode;
	
	public interface IIsoDisplayObject extends INode, IRenderer
	{
		//////////////////////////////////////////////////////////////////
		//	BOUNDS
		//////////////////////////////////////////////////////////////////
		
		function get bounds ():IBounds;
		
		//////////////////////////////////////////////////////////////////
		//	POSITION
		//////////////////////////////////////////////////////////////////
		
		function get x ():Number;
		function set x (value:Number):void;
		
		function get y ():Number;
		function set y (value:Number):void;
		
		function get z ():Number;
		function set z (value:Number):void;
		
		function get screenX ():Number;
		function get screenY ():Number;
		
		//////////////////////////////////////////////////////////////////
		//	GEOMETRY
		//////////////////////////////////////////////////////////////////
		
		function get width ():Number;
		function set width (value:Number):void;
		
		function get length ():Number;
		function set length (value:Number):void;
		
		function get height ():Number;
		function set height (value:Number):void;
		
		//////////////////////////////////////////////////////////////////
		//	STYLES
		//////////////////////////////////////////////////////////////////
		
		function get faceAlphas ():Array;
		function set faceAlphas (value:Array):void;
		
		function get faceColors ():Array;
		function set faceColors (value:Array):void;
		
		function get lineAlphas ():Array;
		function set lineAlphas (value:Array):void;
		
		function get lineColors ():Array;
		function set lineColors (value:Array):void;
		
		function get lineThicknesses ():Array;
		function set lineThicknesses (value:Array):void;
		
		function get styleType ():String;
		function set styleType (value:String):void;
		
		//////////////////////////////////////////////////////////////////
		//	INVALIDATION
		//////////////////////////////////////////////////////////////////
		
		function get isInvalidated ():Boolean;
		
		function invalidateGeometry ():void;
		function invalidatePosition ():void;
		
		//////////////////////////////////////////////////////////////////
		//	CLONE
		//////////////////////////////////////////////////////////////////
		
		function clone ():IIsoDisplayObject;
	}
}