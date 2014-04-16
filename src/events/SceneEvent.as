package events
{
	import starling.events.Event;
 
	public class SceneEvent extends Event
	{
		public static const CHANGED:String = "chenged";
		public static const CLEARED:String = "cleared";
		private var mResult:Boolean;
		public static var scene:String;
		public function SceneEvent(type:String, result:Boolean, bubbles:Boolean=false,data:Object=null):void
		{
		    super(type,bubbles,data);
			mResult=result;
			scene=data.name;
		}
		public function get result():Boolean
		{
			return mResult;
		}
	 
	}
}