package events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	public class MiniGameEvent extends EventDispatcher
	{
		public static var GAME_TIMER:String="game_timer";
		public static var KEY_DOWN:String="key_down";
		public static var KEY_UP:String="key_up";
		public static var HITTED:String="hitted";
		public static var GAME_COMPLETE:String="game_complete";
		public static var SCORE:String="score";
		public static var VICTORY:String="victory";
		public var keyDown:String="";
		public var keyUp:String="";
		public var score:Number=0;
		 
		public function doKeyDownHandle():void
		{
			dispatchEvent(new Event(MiniGameEvent.KEY_DOWN));
		}
		public function doKeyUpHandle():void
		{
			dispatchEvent(new Event(MiniGameEvent.KEY_UP));
		}
		public function onHitHandle():void
		{
			dispatchEvent(new Event(MiniGameEvent.HITTED));
		}
		public function onCompleteHandle():void
		{
			dispatchEvent(new Event(MiniGameEvent.GAME_COMPLETE));
		}
		public function onGamePlaying():void
		{
			dispatchEvent(new Event(MiniGameEvent.GAME_TIMER));
		}
		public function onGetScore():void
		{
			dispatchEvent(new Event(MiniGameEvent.SCORE));
		}
		public function onVictory():void
		{
			dispatchEvent(new Event(MiniGameEvent.VICTORY));
		}
	}
	
}