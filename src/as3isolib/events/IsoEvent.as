package as3isolib.events
{
	import flash.events.Event;

	public class IsoEvent extends Event
	{
		static public const RENDER:String = "render";
		
		static public const MOVE:String = "move";
		static public const RESIZE:String = "resize";
		
		public var propName:String;
		
		public var oldValue:Object;
		public var newValue:Object;
		
		public function IsoEvent (type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
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