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

import starling.events.Event;

import utils.ViewsContainer;

	public class TrainingGame extends MovieClip
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
		public function TrainingGame()
		{
			
			 
			ViewsContainer.MiniGame=this;
			
			var st:SoundTransform=new SoundTransform(0.7);
			command.playBackgroudSound("FoodChase",st);
		 
			gamecom.init(this,"training");
			gamecom.createEnemyBike(new Point(0,380));
			gamecom.createPlayerBike();

			MiniGameEvt=gamecom.initGameEvent();

		}

		
	}
}