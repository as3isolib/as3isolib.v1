package as3isolib.display.layoutClasses
{
	import as3isolib.display.IContainer;
	
	import flash.events.IEventDispatcher;

	public interface ILayoutObject extends IEventDispatcher
	{
		function get target ():IContainer;
		function set target (value:IContainer):void;
		
		function updateLayout ():void;
	}
}