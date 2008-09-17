package as3isolib.renderer
{
	import flash.events.IEventDispatcher;

	public interface ISceneRenderer extends IEventDispatcher
	{
		function renderScene (objects:Array):Array;
	}
}