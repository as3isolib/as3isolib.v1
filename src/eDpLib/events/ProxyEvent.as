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
		 * The original event being proxied for.
		 */
		public var targetEvent:Event;
		
		/**
		 * @constructor
		 * 
		 * @param proxy The proxy object dispatching on behalf of the original event's target.
		 * @param targetEvt The original event being proxied for.
		 */
		public function ProxyEvent (proxy:IEventDispatcher, targetEvt:Event)
		{
			super(targetEvt.type, targetEvt.bubbles, targetEvt.cancelable);
			
			this.proxy = proxy;
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