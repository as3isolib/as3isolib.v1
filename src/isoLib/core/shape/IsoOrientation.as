package isoLib.core.shape
{
	public class IsoOrientation
	{
		/**
		 * Indicates an orientation along the x-axis only.
		 */
		static public const X:String = "x";
		
		/**
		 * Indicates an orientation along the y-axis only.
		 */
		static public const Y:String = "y";
		
		/**
		 * Indicates an orientation along the z-axis only.
		 */
		static public const Z:String = "z";
		
		/**
		 * Indicates an orientation within the x-y plane. Most 2D objects will have this orientation.
		 */
		static public const XY:String = "xy";
		
		/**
		 * Indicates an orientation within the x-z plane. Most 2D objects will have this orientation.
		 */
		static public const XZ:String = "xz";
		
		/**
		 * Indicates an orientation within the y-z plane. Most 2D objects will have this orientation.
		 */
		static public const YZ:String = "yz";
		
		/**
		 * Indicates an orientation within the x-y-z coordinate space. Most 3D objects will have this orientation
		 */
		static public const XYZ:String = "xyz";
		
		/**
		 * Indicates no specific orientation.
		 */
		static public const NONE:String = "none";
	}
}