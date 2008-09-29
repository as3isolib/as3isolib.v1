package as3isolib.bounds
{
	import as3isolib.geom.Pt;
	
	/**
	 * The IBounds interface defines the interface that all classes used bound-type information objects should use.
	 * 
	 * Properties of IBounds implementors will refer to properties in isometric space.
	 */
	public interface IBounds
	{
		///////////////////////////////////////////////////////////
		//	WIDTH / LENGTH / HEIGHT
		///////////////////////////////////////////////////////////
		
		/**
		 * The difference of the left and right properties.
		 */
		function get width ():Number;
		
		/**
		 * The difference of the back and front properties.
		 */
		function get length ():Number;
		
		/**
		 * The difference of the top and bottom properties.
		 */
		function get height ():Number;
		
		///////////////////////////////////////////////////////////
		//	LEFT / RIGHT
		///////////////////////////////////////////////////////////
		
		/**
		 * The left most coordinate. Most often this cooresponds to the x position of the IBounds' target.
		 */
		function get left ():Number;
		
		/**
		 * The right most coordinate. Cooresponds to the x + width of the IBounds' target.
		 */
		function get right ():Number;
		
		///////////////////////////////////////////////////////////
		//	BACK / FRONT
		///////////////////////////////////////////////////////////
		
		/**
		 * The back most coordinate. Most often this cooresponds to the y position of the IBounds' target.
		 */
		function get back ():Number;
		
		/**
		 * The front most coordinate. Cooresponds to the y + length of the IBounds' target.
		 */
		function get front ():Number;
		
		///////////////////////////////////////////////////////////
		//	TOP / BOTTOM
		///////////////////////////////////////////////////////////
		
		/**
		 * The bottom most coordinate. Most often this cooresponds to the z position of the IBounds' target.
		 */
		function get bottom ():Number;
		
		/**
		 * The top most coordinate. Cooresponds to the z + height of the IBounds' target.
		 */
		function get top ():Number;
		
		///////////////////////////////////////////////////////////
		//	CENTER PT
		///////////////////////////////////////////////////////////
		
		/**
		 * Represents the center pt of the IBounds object in 3D isometric space
		 */
		function get centerPt ():Pt;
		
		///////////////////////////////////////////////////////////
		//	INTERSECTS
		///////////////////////////////////////////////////////////
		
		/**
		 * Determines if the IBounds oject has a 3D isometric intersection with the target IBounds.
		 * 
		 * @param bounds The IBounds object to test for an intersection against.
		 * 
		 * @returns Boolean Returns true if an intersection occured, else false.
		 */
		function intersects (bounds:IBounds):Boolean;
	}
}