package events
{
	import starling.events.Event;

	public class TopViewEvent extends Event
	{
		public static const REMOVE:String = "remove";
		public static const DISPALY:String = "display";
		private var mResult:Boolean;
	    public var part_index:uint;
		public var removed:String;
		public function TopViewEvent(type:String, result:Boolean, bubbles:Boolean=false,data:Object=null):void
		{
			super(type,bubbles,data);
			mResult=result;
		}
		public function get result():Boolean
		{
			return mResult;
		}
	}
}