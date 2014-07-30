package views
{
 
	import flash.display.MovieClip;
	import flash.geom.Point;
	import flash.media.SoundTransform;
	
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.MiniGameCommand;
	import controller.MiniGameInterface;
	
	import events.MiniGameEvent;
	
	import utils.ViewsContainer;
	
	public class TraceGame extends MovieClip
	{
		private var command:MainInterface=new MainCommand();
		private var gamecom:MiniGameInterface=new MiniGameCommand();
		private static var evt:MiniGameEvent;
		 
		public static function set MiniGameEvt(e:MiniGameEvent):void
		{
			evt=e;
		}
		public static function get MiniGameEvt():MiniGameEvent
		{
			return evt;
		}
		public function TraceGame()
		{
			
			ViewsContainer.MiniGame=this;
		 
			
			//var st:SoundTransform=new SoundTransform(0.7);
			command.playBackgroudSound("Mayhem");
			
			gamecom.init(this,"tracing");
			gamecom.createEnemyBike(new Point(-410,190));
			gamecom.createPlayerBike();
			MiniGameEvt=gamecom.initGameEvent();
		 
			
			
		}
	}
}