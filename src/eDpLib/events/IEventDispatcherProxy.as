package eDpLib.events
{
	import flash.events.IEventDispatcher;
	
	/**
	 * The IEventDispatcherProxy interface defines the methods for preforming IEventDispatcher events on behalf of a target.
	 */
	public interface IEventDispatcherProxy extends IEventDispatcher
	{
		/**
		 * @private
		 */
		function get proxy ():IEventDispatcher;
		
		/**
		 * Generally the IEventDispatcherProxy is indeed the proxy for the proxyTarget.
		 * However in special cases a developer may want to delegate IEventDispatcher tasks to another target.
		 */
		function set proxy (value:IEventDispatcher):void;
		
		/**
		 * @private
		 */
		function get proxyTarget ():IEventDispatcher;
		
		/**
		 * The target whose events are being redispatched by the proxy.
		 */
		function set proxyTarget (value:IEventDispatcher):void;
	}
}