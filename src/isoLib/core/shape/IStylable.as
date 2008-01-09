package isoLib.core.shape
{
	public interface IStylable
	{
		function get faceAlphas ():Array;
		function set faceAlphas (value:Array):void;
		
		function get lineAlphas ():Array;
		function set lineAlphas (value:Array):void;
		
		function get lineColors ():Array;
		function set lineColors (value:Array):void;
		
		function get lineThicknesses ():Array;
		function set lineThicknesses (value:Array):void;
		
		function get shadedColors ():Array;
		function set shadedColors (value:Array):void;
		
		function get solidColors ():Array;
		function set solidColors (value:Array):void;
	}
}