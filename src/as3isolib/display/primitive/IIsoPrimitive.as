package as3isolib.display.primitive
{
	import as3isolib.core.IIsoDisplayObject;
	
	/**
	 * The IIsoPrimitive interface defines methods for any IIsoDisplayObject class that is utilizing Flash's drawing API.
	 */
	public interface IIsoPrimitive extends IIsoDisplayObject
	{
		//////////////////////////////////////////////////////////////////
		//	STYLES
		//////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get faceAlphas ():Array;
		
		/**
		 * An array of alpha values corresponding to the various faces (where applicable).
		 * For a given IsoBox the values would be assigned in order to: top, right, front, left, back, bottom
		 */
		function set faceAlphas (value:Array):void;
		
		/**
		 * @private
		 */
		function get faceColors ():Array;
		
		/**
		 * An array of color values corresponding to the various faces (where applicable).
		 * For a given IsoBox the values would be assigned in order to: top, right, front, left, back, bottom
		 */
		function set faceColors (value:Array):void;
		
		/**
		 * @private
		 */
		function get lineAlphas ():Array;
		
		/**
		 * An array of alphas values corresponding to the various faces' outlines (where applicable).
		 * For a given IsoBox the values would be assigned in order to: top, right, front, left, back, bottom
		 */
		function set lineAlphas (value:Array):void;
		
		/**
		 * @private
		 */
		function get lineColors ():Array;
		
		/**
		 * An array of color values corresponding to the various faces' outlines (where applicable).
		 * For a given IsoBox the values would be assigned in order to: top, right, front, left, back, bottom
		 */
		function set lineColors (value:Array):void;
		
		/**
		 * @private
		 */
		function get lineThicknesses ():Array;
		
		/**
		 * An array of thickness values corresponding to the various faces' outlines (where applicable).
		 * For a given IsoBox the values would be assigned in order to: top, right, front, left, back, bottom
		 */
		function set lineThicknesses (value:Array):void;
		
		/**
		 * @private
		 */
		function get styleType ():String;
		
		/**
		 * For IIsoDisplayObjects that make use of Flash's drawing API, it is necessary to develop render logic corresponding to the
		 * varios render style types.
		 * 
		 * @see as3isolib.enum.RenderStyleType
		 */
		function set styleType (value:String):void;
		
		//////////////////////////////////////////////////////////////////
		//	INVALIDATION
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Invalidates the geometry of the  IIsoDisplayObject.
		 */
		function invalidateGeometry ():void;		
	}
}