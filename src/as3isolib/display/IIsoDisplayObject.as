package as3isolib.display
{
	import as3isolib.bounds.IBounds;
	import as3isolib.data.INode;
	
	import flash.geom.Rectangle;
	
	/**
	 * The IIsoDisplayObject interface defines methods for any base display class needing rendering within an 3D isometric space.
	 */
	public interface IIsoDisplayObject extends INode, IContainer
	{
		//////////////////////////////////////////////////////////////////
		//	BOUNDS
		//////////////////////////////////////////////////////////////////
		
		/**
		 * The object that defines the boundries of the IIsoDisplayObject in 3D isometric space.
		 */
		function get isoBounds ():IBounds;
		
		/**
		 * The traditional screen boundries associated with the IIsoDisplayObject in 2D screen coordinates.
		 */
		function get screenBounds ():Rectangle;
		
		//////////////////////////////////////////////////////////////////
		//	POSITION
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Moves the IIsoDisplayObject to the particular 3D isometric coordinates.
		 * 
		 * @param x The x value in 3D isometric space.
		 * @param y The y value in 3D isometric space.
		 * @param z The z value in 3D isometric space.
		 */
		function moveTo (x:Number, y:Number, z:Number):void;
		
		/**
		 * @private
		 */
		function get x ():Number;
		
		/**
		 * The x value in 3D isometric space.
		 */ 
		function set x (value:Number):void;
		
		/**
		 * @private
		 */
		function get y ():Number;
		
		/**
		 * The y value in 3D isometric space.
		 */ 
		function set y (value:Number):void;
		
		/**
		 * @private
		 */
		function get z ():Number;
		
		/**
		 * The z value in 3D isometric space.
		 */ 
		function set z (value:Number):void;
		
		/**
		 * The x value of the container in screen coordinates relative to the parent container.
		 */
		function get screenX ():Number;
		
		/**
		 * The y value of the container in screen coordinates relative to the parent container.
		 */ 
		function get screenY ():Number;
		
		//////////////////////////////////////////////////////////////////
		//	GEOMETRY
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Resizes the IIsoDisplayObject in 3D isometric coordinates.
		 * 
		 * @param width The width in 3D isometric space.
		 * @param length The length in 3D isometric space.
		 * @param height The height in 3D isometric space.
		 */
		function setSize (width:Number, length:Number, height:Number):void
		
		/**
		 * @private
		 */
		function get width ():Number;
		
		/**
		 * The width in 3D isometric space.
		 */
		function set width (value:Number):void;
		
		/**
		 * @private
		 */
		function get length ():Number;
		
		/**
		 * The length in 3D isometric space.
		 */
		function set length (value:Number):void;
		
		/**
		 * @private
		 */
		function get height ():Number;
		
		/**
		 * The height in 3D isometric space.
		 */
		function set height (value:Number):void;
		
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
		 * Flag indicating that one or more of the IIsoDisplayObject's properties are invalidated and will be validated during the next render phase.
		 */
		function get isInvalidated ():Boolean;
		
		/**
		 * Invalidates the geometry of the  IIsoDisplayObject.
		 */
		function invalidateGeometry ():void;
		
		/**
		 * Invalidates the position of the  IIsoDisplayObject.
		 */
		function invalidatePosition ():void;
		
		//////////////////////////////////////////////////////////////////
		//	CLONE
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Clones the IIsoDisplayObject, copying its dimensional and style properties.
		 * Does not copy the position of the original.
		 * Casting to the original class is necessary to avoid compile-time errors.
		 * 
		 * @return IIsoDisplayObject The clone of the original.
		 */
		function clone ():IIsoDisplayObject;
	}
}