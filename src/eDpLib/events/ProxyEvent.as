package eDpLib.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * ProxyEvent allows a proxy to redispatch event information on behalf of a IEventDispatcher not directly accessible through the display list.
	 */
	public class ProxyEvent extends Event
	{
		/**
		 * The proxy object dispatching on behalf of the original event's target.
		 */
		public var proxy:IEventDispatcher;
		
		/**
		 * The original event target who is being proxied for.
		 */
		public var proxyTarget:IEventDispatcher;
		
		/**
		 * Just another accessor for the proxy property.
		 */
		override public function get target ():Object
		{
			return proxy;
		}
		
		/**
		 * The original event being proxied for.
		 */
		public var targetEvent:Event;
		
		/**
		 * Constructor
		 * 
		 * @param proxy The proxy object dispatching on behalf of the original event's target.
		 * @param targetEvt The original event being proxied for.
		 */
		public function ProxyEvent (proxy:IEventDispatcher, targetEvt:Event)
		{
			super(targetEvt.type, targetEvt.bubbles, targetEvt.cancelable);
			
			this.proxy = proxy;
			this.proxyTarget = Object(proxy).hasOwnProperty("proxyTarget") ? Object(proxy).proxyTarget : null;
			this.targetEvent = targetEvt;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone ():Event
		{
			return new ProxyEvent(proxy, targetEvent);
		}
	}
}