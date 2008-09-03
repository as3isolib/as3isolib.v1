package eDpLib.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	public class EventDispatcherProxy implements IEventDispatcher
	{
		////////////////////////////////////////////////////////////////////////
		//	PROXY TARGET
		////////////////////////////////////////////////////////////////////////
		
		private var _proxyTarget:IEventDispatcher; //the item that we are intercepting and redispatching, this being the target, should be set in subclasses
		
		public function get proxyTarget ():IEventDispatcher
		{
			return _proxyTarget;
		}
		
		public function set proxyTarget (value:IEventDispatcher):void
		{
			if (_proxyTarget != value)
			{
				_proxyTarget = value;
				updateProxyListeners();
			}
		}
		
		////////////////////////////////////////////////////////////////////////
		//	CONSTRUCTOR
		////////////////////////////////////////////////////////////////////////
		
		public var proxy:IEventDispatcher; //generally this, but you could assing another IEventDispatcher to be the stand end target
		
		public function EventDispatcherProxy ()
		{
			proxy = this;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	LISTENER HASH
		////////////////////////////////////////////////////////////////////////
		
		protected var listenerHashTable:Object = {}; //will contain a value i.e. listenerHash.eventType = {listener:eventListenerFunction};
		
		protected function setListenerHashProperty (type:String, listener:Function):void
		{
			var hash:ListenerHash;
			if (!listenerHashTable.hasOwnProperty(type))
			{
				hash = new ListenerHash();
				hash.addListener(listener);
				
				listenerHashTable[type] = hash;
			}
			
			else
			{
				hash = ListenerHash(listenerHashTable[type]);
				hash.addListener(listener);
			}
		}
		
		protected function hasListenerHashProperty (type:String):Boolean
		{
			return listenerHashTable.hasOwnProperty(type);			
		}
		
		protected function getListenersForEventType (type:String):Array
		{
			if (listenerHashTable.hasOwnProperty(type))
				return ListenerHash(listenerHashTable[type]).listeners;
			
			else
				return [];
		}
		
		protected function removeListenerHashProperty (type:String):Boolean
		{
			if (listenerHashTable.hasOwnProperty(type))
			{
				listenerHashTable[type] = null;
				delete listenerHashTable[type];
				
				return true;
			}
			
			return false;
		}
		
		////////////////////////////////////////////////////////////////////////
		//	MISC. PROXY METHODS
		////////////////////////////////////////////////////////////////////////
		
		private var _interceptedEventTypes:Array = generateEventTypes();
		
		protected function generateEventTypes ():Array
		{
			var evtTypes:Array = [];
			evtTypes.push
			(
				MouseEvent.CLICK,
				MouseEvent.DOUBLE_CLICK, 
				MouseEvent.MOUSE_DOWN, 
				MouseEvent.MOUSE_MOVE, 
				MouseEvent.MOUSE_OUT,
				MouseEvent.MOUSE_OVER,
				MouseEvent.MOUSE_UP,
				MouseEvent.MOUSE_WHEEL,
				MouseEvent.ROLL_OUT,
				MouseEvent.ROLL_OVER
			);
				
			return evtTypes;
		}
		
		protected function checkForProxy (type:String):Boolean
		{
			var evtType:String;
			for each (evtType in _interceptedEventTypes)
			{
				if (type == evtType)
					return true;
			}
			
			return false;
		}
		
		protected function eventDelegateFunction (evt:Event):void
		{
			evt.stopImmediatePropagation(); //prevent from further bubbling up thru display list
			var pEvt:ProxyEvent = new ProxyEvent(proxy, evt);
			
			var func:Function;
			var listeners:Array;
			if (hasListenerHashProperty(evt.type))
			{
				listeners = getListenersForEventType(evt.type);
				for each (func in listeners)
					func.call(this, pEvt);
			}
		}
		
		public var deleteQueueAfterUpdate:Boolean = true;
		
		protected function updateProxyListeners ():void
		{
			var queueItem:Object
			for each (queueItem in _proxyTargetListenerQueue)
				proxyTarget.addEventListener(queueItem.type, eventDelegateFunction, queueItem.useCapture, queueItem.priority, queueItem.useWeakReference);
				
			if (deleteQueueAfterUpdate)
				_proxyTargetListenerQueue = [];
		}
		
		////////////////////////////////////////////////////////////////////////
		//	EVENT DISPATCHER HOOKS
		////////////////////////////////////////////////////////////////////////
		
		private var _proxyTargetListenerQueue:Array = [];
		
		protected var eventDispatcher:EventDispatcher = new EventDispatcher(IEventDispatcher(this));
		
		public function hasEventListener (type:String):Boolean
		{			
			if (checkForProxy(type))
			{
				if (proxyTarget)				
					return proxyTarget.hasEventListener(type);
					
				else 
					return false;
			}
			
			else
				return eventDispatcher.hasEventListener(type);
		}
		
		public function willTrigger (type:String):Boolean
		{
			if (checkForProxy(type))
			{
				if (proxyTarget)				
					return proxyTarget.willTrigger(type);
					
				else 
					return false;
			}
			
			else
				return eventDispatcher.willTrigger(type);
		}
		
		public function addEventListener (type:String, listener:Function, useCapture:Boolean = false, priority:int = 0.0, useWeakReference:Boolean = false):void
		{
			if (checkForProxy(type))
			{
				setListenerHashProperty(type, listener);
				
				if (proxyTarget)
					proxyTarget.addEventListener(type, eventDelegateFunction, useCapture, priority, useWeakReference);
					
				else
				{
					var queueItem:Object = {type:type, useCapture:useCapture, priority:priority, useWeakReference:useWeakReference};
					_proxyTargetListenerQueue.push(queueItem);
				}
			}
			
			else
				eventDispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener (type:String, listener:Function, useCapture:Boolean = false):void
		{
			if (checkForProxy(type))
			{
				if (hasListenerHashProperty(type))
				{
					removeListenerHashProperty(type);
					
					if (proxyTarget)
						proxyTarget.removeEventListener(type ,eventDelegateFunction, useCapture);
						
					else
					{
						var quequeItem:Object;
						
						var i:uint;
						var l:uint = _proxyTargetListenerQueue.length;
						for (i; i < l; i++)
						{
							quequeItem = _proxyTargetListenerQueue[i];
							if (quequeItem.type == type)
							{
								_proxyTargetListenerQueue.splice(i, 1);
								return;
							}
						}
					}
				}
			}
			
			else
				eventDispatcher.addEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent (event:Event):Boolean
		{
			return eventDispatcher.dispatchEvent(event);
		}
		
	}
}

class ListenerHash
{
	public var listeners:Array = [];
	
	
	
	public function addListener (listener:Function):void
	{
		if (!contains(listener))
			listeners.push(listener);
	}
	
	public function removeListener (listener:Function):void
	{
		if (contains(listener))
		{
			var i:int;
			var m:int = listeners.length;
			while (i < m)
			{
				if (listener == Function(listeners[i]))
					break;
				
				i++;
			}
			
			listeners.splice(i, 1);
		}
	}
	
	public function contains (listener:Function):Boolean
	{
		var func:Function;
		for each (func in listeners)
		{
			if (func == listener)
				return true;
		}
		
		return false;
	}
}