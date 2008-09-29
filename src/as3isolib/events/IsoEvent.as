package as3isolib.events
{
	import flash.events.Event;

	/**
	 * The IsoEvent class represents the event object passed to the listener for various isometric display events.
	 */
	public class IsoEvent extends Event
	{
		/////////////////////////////////////////////////////////////
		//	CONST
		/////////////////////////////////////////////////////////////
		
		/**
		 * The IsoEvent.RENDER constant defines the value of the type property of the event object for an iso event.
		 */
		static public const RENDER:String = "as3isolib_render";
		
		/**
		 * The IsoEvent.MOVE constant defines the value of the type property of the event object for an iso event.
		 */
		static public const MOVE:String = "as3isolib_move";
		
		/**
		 * The IsoEvent.RESIZE constant defines the value of the type property of the event object for an iso event.
		 */
		static public const RESIZE:String = "as3isolib_resize";
		
		/////////////////////////////////////////////////////////////
		//	DATA
		/////////////////////////////////////////////////////////////
		
		/**
		 * Specifies the property name of the property values assigned in oldValue and newValue.
		 */
		public var propName:String;
		
		/**
		 * Specifies the previous value assigned to the property specified in propName.
		 */
		public var oldValue:Object;
		
		/**
		 * Specifies the new value assigned to the property specified in propName.
		 */
		public var newValue:Object;
		
		/**
		 * @constructor
		 */
		public function IsoEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		/**
		 * @inheritDoc
		 */
		override public function clone ():Event
		{
			var evt:IsoEvent = new IsoEvent(type, bubbles, cancelable);
			evt.propName = propName;
			evt.oldValue = oldValue;
			evt.newValue = newValue;
			
			return evt;
		}
	}
}