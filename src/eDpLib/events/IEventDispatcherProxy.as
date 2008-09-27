package eDpLib.events
{
	import flash.events.IEventDispatcher;
	
	public interface IEventDispatcherProxy extends IEventDispatcher
	{
		function get proxy ():IEventDispatcher;
		function set proxy (value:IEventDispatcher):void;
		
		function get proxyTarget ():IEventDispatcher;
		function set proxyTarget (value:IEventDispatcher):void;
	}
}