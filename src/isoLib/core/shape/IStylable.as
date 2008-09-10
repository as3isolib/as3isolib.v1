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
		
		//////////////////////////////////////////////////////////////////
		//	TYPE
		//////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get type ():String;
		
		/**
		 * Indicates what kind of rendering/styles to apply to the IPrimitive during the validation phases.
		 * 
		 * @see isolib.core.shape.IsoType
		 */
		function set type (value:String):void;
			
		function get filters ():Array;
		function set filters (value:Array):void;
	}
}