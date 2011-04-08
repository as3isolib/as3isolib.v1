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
	import flash.events.EventDispatcher;
	import flash.events.FocusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	
	/**
	 * EventDispatcherProxy provides a means for intercepting events on behalf of a target and redispatching them as the target of the event.
	 */
	public class EventDispatcherProxy implements IEventDispatcher, IEventDispatcherProxy
	{
		////////////////////////////////////////////////////////////////////////
		//	PROXY TARGET
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		private var _proxyTarget:IEventDispatcher; //the item that we are intercepting and redispatching, this being the target, should be set in subclasses
		
		/**
		 * @private
		 */
		public function get proxyTarget():IEventDispatcher
		{
			return _proxyTarget;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set proxyTarget( value:IEventDispatcher ):void
		{
			if ( _proxyTarget != value )
			{
				_proxyTarget = value;
				updateProxyListeners();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	PROXY
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		private var _proxy:IEventDispatcher;
		
		/**
		 * @private
		 */
		public function get proxy():IEventDispatcher
		{
			return _proxy;
		}
		
		/**
		 * @inheritDoc
		 */
		public function set proxy( target:IEventDispatcher ):void
		{
			if ( _proxy != target )
			{
				_proxy = target;
				eventDispatcher = new EventDispatcher( _proxy );
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * Constructor
		 */
		public function EventDispatcherProxy()
		{
			proxy = this;
			
			interceptedEventTypes = generateEventTypes();
		}
		
		////////////////////////////////////////////////////////////////////////
		//	LISTENER HASH
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 *
		 * A hash table following a basic format:
		 *
		 * hash[eventType] = ListenerHash() - a collection of listener objects with some convenience methods.
		 */
		private var listenerHashTable:Object = {};
		
		/**
		 * @private
		 *
		 * Adds a listener for a given event type.
		 */
		private function setListenerHashProperty( type:String, listener:Function ):void
		{
			var hash:ListenerHash;
			
			if ( !listenerHashTable.hasOwnProperty( type ))
			{
				hash = new ListenerHash();
				hash.addListener( listener );
				
				listenerHashTable[ type ] = hash;
			}
			
			else
			{
				hash = ListenerHash( listenerHashTable[ type ]);
				hash.addListener( listener );
			}
		}
		
		/**
		 * @private
		 *
		 * Checks to see if a particular event type has been set up within the hash table.
		 */
		private function hasListenerHashProperty( type:String ):Boolean
		{
			return listenerHashTable.hasOwnProperty( type );
		}
		
		/**
		 * @private
		 *
		 * Returns an array of listeners for a given event type.
		 */
		private function getListenersForEventType( type:String ):Array
		{
			if ( listenerHashTable.hasOwnProperty( type ))
				return ListenerHash( listenerHashTable[ type ]).listeners;
			
			else
				return [];
		}
		
		/**
		 * @private
		 *
		 * Removes the listeners and the event type from the hash table.
		 */
		private function removeListenerHashProperty( type:String, listener:Function ):Boolean
		{
			if ( listenerHashTable.hasOwnProperty( type ))
			{
				var hash:ListenerHash = ListenerHash( listenerHashTable[ type ]);
				hash.removeListener( listener );
				
				return true;
			}
			
			return false;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	MISC. PROXY METHODS
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 */
		protected var interceptedEventHash:Dictionary = new Dictionary( true );
		
		/**
		 * @private
		 *
		 * An array of events to check against that could be dispatched from an interactive target.
		 */
		public function get interceptedEventTypes():Array
		{
			var a:Array = [];
			
			var p:Object;
			
			for ( p in interceptedEventHash )
				a.push( interceptedEventHash[ p ]);
			
			return a;
		}
		
		//public var interceptedEventTypes:Array = generateEventTypes();
		
		/**
		 * @private
		 */
		public function set interceptedEventTypes( value:Array ):void
		{
			var hash:Dictionary = new Dictionary( true );
			
			var type:String;
			
			for each ( type in value )
				hash[ type ] = type;
			
			interceptedEventHash = hash;
		}
		
		/**
		 * Creates an array of interactive object events to check against during event proxying.
		 * To add more event types to check for, subclasses should override this.
		 *
		 * @return Array An array of event types.
		 */
		protected function generateEventTypes():Array
		{
			var evtTypes:Array = [];
			evtTypes.push
				(
				//REGULAR EVENTS
				Event.ADDED,
				Event.ADDED_TO_STAGE,
				Event.ENTER_FRAME,
				Event.REMOVED,
				Event.REMOVED_FROM_STAGE,
				Event.RENDER,
				Event.TAB_CHILDREN_CHANGE,
				Event.TAB_ENABLED_CHANGE,
				Event.TAB_INDEX_CHANGE,
				
				//FOCUS EVENTS
				FocusEvent.FOCUS_IN,
				FocusEvent.FOCUS_OUT,
				FocusEvent.KEY_FOCUS_CHANGE,
				FocusEvent.MOUSE_FOCUS_CHANGE,
				
				//MOUSE EVENTS
				MouseEvent.CLICK,
				MouseEvent.DOUBLE_CLICK,
				MouseEvent.MOUSE_DOWN,
				MouseEvent.MOUSE_MOVE,
				MouseEvent.MOUSE_OUT,
				MouseEvent.MOUSE_OVER,
				MouseEvent.MOUSE_UP,
				MouseEvent.MOUSE_WHEEL,
				MouseEvent.ROLL_OUT,
				MouseEvent.ROLL_OVER,
				
				//KEYBOARD EVENTS
				KeyboardEvent.KEY_DOWN,
				KeyboardEvent.KEY_UP
				);
			
			return evtTypes;
		}
		
		/**
		 * @private
		 *
		 * For a given event type, check to see if it is intended for interception.
		 * InteractiveObject event types will return true since the non-visual class that proxies the proxyTarget needs to dispatch those events on the target's behalf.
		 */
		private function checkForInteceptedEventType( type:String ):Boolean
		{
			return interceptedEventHash.hasOwnProperty( type );
		}
		
		/**
		 * @private
		 *
		 * A generic event handler that stops event propogation of InteractiveObject event types.
		 * Once stopped, it checks for listeners for the given event type and triggers them.
		 *
		 * Depending on specific developer needs, this method can be overridden by subclasses.
		 */
		protected function eventDelegateFunction( evt:Event ):void
		{
			evt.stopImmediatePropagation(); //prevent from further bubbling up thru display list
			
			var pEvt:ProxyEvent = new ProxyEvent( proxy, evt );
			pEvt.proxyTarget = proxyTarget;
			
			var func:Function;
			var listeners:Array;
			
			if ( hasListenerHashProperty( evt.type ))
			{
				listeners = getListenersForEventType( evt.type );
				
				for each ( func in listeners )
					func.call( this, pEvt );
			}
		}
		
		/**
		 * A flag indicating if the queue is a one-time use, where other visual assets may not receive the same handlers.
		 */
		public var deleteQueueAfterUpdate:Boolean = true;
		
		/**
		 * If a proxyTarget has not been set, then a queue of event handlers has been set up.
		 * Once the proxyTarget is created, it iterates through each queue item and assigns the listeners.
		 */
		protected function updateProxyListeners():void
		{
			var queueItem:Object
			
			for each ( queueItem in _proxyTargetListenerQueue )
				proxyTarget.addEventListener( queueItem.type, eventDelegateFunction, queueItem.useCapture, queueItem.priority, queueItem.useWeakReference );
			
			if ( deleteQueueAfterUpdate )
				_proxyTargetListenerQueue = [];
		}
		
		////////////////////////////////////////////////////////////////////////
		//	EVENT DISPATCHER HOOKS
		////////////////////////////////////////////////////////////////////////
		
		/**
		 * @private
		 *
		 * A queue of events a proxy target will listen for and hand off to the proxy.
		 */
		private var _proxyTargetListenerQueue:Array = [];
		
		/**
		 * @private
		 */
		private var eventDispatcher:EventDispatcher;
		
		/**
		 * @inheritDoc
		 */
		public function hasEventListener( type:String ):Boolean
		{
			if ( checkForInteceptedEventType( type ))
			{
				if ( proxyTarget )
					return proxyTarget.hasEventListener( type );
				
				else
					return false;
			}
			
			else
				return eventDispatcher.hasEventListener( type );
		}
		
		/**
		 * @inheritDoc
		 */
		public function willTrigger( type:String ):Boolean
		{
			if ( checkForInteceptedEventType( type ))
			{
				if ( proxyTarget )
					return proxyTarget.willTrigger( type );
				
				else
					return false;
			}
			
			else
				return eventDispatcher.willTrigger( type );
		}
		
		/**
		 * @inheritDoc
		 */
		public function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0.0, useWeakReference:Boolean = false ):void
		{
			if ( checkForInteceptedEventType( type ))
			{
				setListenerHashProperty( type, listener );
				
				if ( proxyTarget )
					proxyTarget.addEventListener( type, eventDelegateFunction, useCapture, priority, useWeakReference );
				
				else
				{
					var queueItem:Object = { type:type, useCapture:useCapture, priority:priority, useWeakReference:useWeakReference };
					_proxyTargetListenerQueue.push( queueItem );
				}
			}
			
			else
				eventDispatcher.addEventListener( type, listener, useCapture, priority, useWeakReference );
		}
		
		/**
		 * @inheritDoc
		 */
		public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void
		{
			if ( checkForInteceptedEventType( type ))
			{
				if ( hasListenerHashProperty( type ))
				{
					removeListenerHashProperty( type, listener );
					
					//if ( proxyTarget )
					//	proxyTarget.removeEventListener( type, eventDelegateFunction, useCapture );
					
					if ( !proxyTarget )
					{
						var quequeItem:Object;
						
						var i:uint;
						var l:uint = _proxyTargetListenerQueue.length;
						
						for ( i; i < l; i++ )
						{
							quequeItem = _proxyTargetListenerQueue[ i ];
							
							if ( quequeItem.type == type )
							{
								_proxyTargetListenerQueue.splice( i, 1 );
								return;
							}
						}
					}
				}
			}
			
			else
				eventDispatcher.removeEventListener( type, listener, useCapture );
		}
		
		/**
		 * @inheritDoc
		 */
		public function dispatchEvent( event:Event ):Boolean
		{
			if ( event.bubbles || checkForInteceptedEventType( event.type ))
				return proxyTarget.dispatchEvent( new ProxyEvent( this, event ));
			
			else
				return eventDispatcher.dispatchEvent( event );
		}
	}
}