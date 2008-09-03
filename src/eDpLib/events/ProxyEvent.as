package eDpLib.events
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	public class ProxyEvent extends Event
	{
		public var proxy:IEventDispatcher;
		public var targetEvent:Event;
			
		public function ProxyEvent (proxy:IEventDispatcher, targetEvt:Event)
		{
			super(targetEvt.type, targetEvt.bubbles, targetEvt.cancelable);
			
			this.proxy = proxy;
			this.targetEvent = targetEvt;
		}
		
		override public function clone ():Event
		{
			return new ProxyEvent(proxy, targetEvent);
		}
	}
}