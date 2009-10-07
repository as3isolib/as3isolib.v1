/*

as3isolib - An open-source ActionScript 3.0 Isometric Library developed to assist 
in creating isometrically projected content (such as games and graphics) 
targeted for the Flash player platform

http://code.google.com/p/as3isolib/

Copyright (c) 2006 - 3000 J.W.Opitz, All Rights Reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/
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