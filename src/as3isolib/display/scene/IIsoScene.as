package as3isolib.display.scene
{
	import as3isolib.bounds.IBounds;
	import as3isolib.display.IContainer;
	
	import flash.display.DisplayObjectContainer;

	public interface IIsoScene extends IContainer
	{
		/**
		 * The IBounds for this object in 3D isometric space.
		 */
		function get isoBounds ():IBounds;
		
		/**
		 * @private
		 */
		function get hostContainer ():DisplayObjectContainer;
		
		/**
		 * The host container which will contain the display list of the isometric display list.
		 * 
		 * @param value The host container.
		 */
		function set hostContainer (value:DisplayObjectContainer):void;
	}
}