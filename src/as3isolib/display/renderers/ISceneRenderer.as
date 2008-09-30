package as3isolib.display.renderers
{
	import as3isolib.display.scene.IIsoScene;
	
	import flash.events.IEventDispatcher;
	
	/**
	 * The ISceneRenderer interface defines the methods that all scene renderer-type classes should implement.
	 * Scene renderer-type classes are intended to assist IIsoScene implementors in renderering scenes with various layouts, shadowing and effects.
	 */
	public interface ISceneRenderer extends IEventDispatcher
	{
		/**
		 * @private
		 */
		function get target ():IIsoScene;
		
		/**
		 * The target IIsoScene whose children will be rendererd.
		 */
		function set target (value:IIsoScene):void;
		
		/**
		 * Iterates and renders each child of the target.
		 */
		function renderScene ():void;
	}
}