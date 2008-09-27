package as3isolib.display.renderers
{
	import as3isolib.display.IContainer;
	import as3isolib.display.IIsoDisplayObject;
	
	import flash.events.IEventDispatcher;

	public interface ISceneRenderer extends IEventDispatcher
	{
		function get target ():IContainer;
		function set target (value:IContainer):void;
		
		function renderScene ():void;
	}
}