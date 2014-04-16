
package events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class GameEvent extends EventDispatcher
	{
		public static var SHOWED:String="showed";
		public var _name:String="";
		public var video:String;
		public var data:String;
		public var qa_label:String;
		public function displayHandler():void
		{
			
			dispatchEvent(new Event(GameEvent.SHOWED));
		}
	}
}