package isoLib.core.shape
{
	import isoLib.bounds.IBounds;
	import isoLib.core.sceneGraph.INode;
	import isoLib.core.sceneGraph.IRenderer;
	
	public interface IPrimitive extends INode, IRenderer, IStylable
	{
		//////////////////////////////////////////////////////////////////
		//	BOUNDS
		//////////////////////////////////////////////////////////////////
		
		function get bounds ():IBounds;
		
		//////////////////////////////////////////////////////////////////
		//	POSITION
		//////////////////////////////////////////////////////////////////
		
		function get depth ():Number;
		function set depth (value:Number):void;
		
		function get screenX ():int;
		function get screenY ():int;
		
		/**
		 * @private
		 */
		function get x ():Number;
		
		/**
		 * The x position along the x-axis in isometric coordinate space.
		 */
		function set x (value:Number):void;
		
		/**
		 * @private
		 */
		function get y ():Number;
		
		/**
		 * The y position along the y-axis in isometric coordinate space.
		 */
		function set y (value:Number):void;
		
		/**
		 * @private
		 */
		function get z ():Number;
		
		/**
		 * The z position along the z-axis in isometric coordinate space.
		 */
		function set z (value:Number):void;
		
		//////////////////////////////////////////////////////////////////
		//	GEOMETRY
		//////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get width ():Number;
		
		/**
		 * The width value along the x-axis in isometric coordinate space.
		 */
		function set width (value:Number):void;
		
		/**
		 * @private
		 */
		function get length ():Number;
		
		/**
		 * The length value along the y-axis in isometric coordinate space.
		 */
		function set length (value:Number):void;
		
		/**
		 * @private
		 */
		function get height ():Number;
		
		/**
		 * The height value along the z-axis in isometric coordinate space.
		 */
		function set height (value:Number):void;
		
		//////////////////////////////////////////////////////////////////
		//	TYPE
		//////////////////////////////////////////////////////////////////
		
		function get left ():Number;
		function get right ():Number;
		function get front ():Number;
		function get back ():Number;
		function get top ():Number;
		function get bottom ():Number;
		
		//////////////////////////////////////////////////////////////////
		//	ORIENTATION
		//////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		function get orientation ():String;
		
		/**
		 * Given a isometric coordinate space, objects may have rendering logic based on their orientation.
		 */
		function set orientation (value:String):void;
		
		//////////////////////////////////////////////////////////////////
		//	INVALIDATION
		//////////////////////////////////////////////////////////////////
		
		/**
		 * Flag indicating geomtry requires validation.
		 */
		function get geometryInvalidated ():Boolean;
		
		/**
		 * Flag indicating position requires validation.
		 */
		function get positionInvalidated ():Boolean;
		
		/**
		 * Flag indicating position along the z-axis requires validation.
		 */
		function get depthInvalidated ():Boolean;
		
		/**
		 * Flag indicating styles requires validation.
		 */
		function get stylesInvalidated ():Boolean;
		
		/**
		 * Sets flag to indicate geomtry requires validation.
		 */
		function invalidateGeometry ():void;
		
		/**
		 * Sets flag to indicate position requires validation.
		 */
		function invalidatePosition ():void;
		
		/**
		 * Sets flag to indicate position and depth requires validation.
		 */
		function invalidateDepth ():void;
		
		/**
		 * Sets flag to indicate styles requires validation.
		 */
		function invalidateStyles ():void;
		
		//////////////////////////////////////////////////////////////////
		//	CLONE
		//////////////////////////////////////////////////////////////////
		
		function clone ():IPrimitive;
	}
}