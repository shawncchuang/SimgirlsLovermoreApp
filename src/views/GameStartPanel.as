package views
{
import events.GameEvent;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;

import utils.DebugTrace;

public class GameStartPanel extends MovieClip
	{
		private var panel:MovieClip;
		private var flox:FloxInterface=new FloxCommand();
		public function GameStartPanel()
		{
			panel=new GameStartUI();
			panel.x=1024/2;
			panel.y=768/2;
			panel.width=360;
			panel.height=230;
			panel.x=800;
			panel.y=600;
			panel.new_game.buttonMode=true;
			panel.new_game.mouseChildren=false;
			panel.load_game.buttonMode=true;
			panel.load_game.mouseChildren=false;
			panel.new_game.addEventListener(MouseEvent.CLICK,doNewGame);
			panel.new_game.addEventListener(MouseEvent.ROLL_OVER,doRollOverHandle);
			panel.new_game.addEventListener(MouseEvent.ROLL_OUT,doRollOutHandle);
			
			panel.load_game.addEventListener(MouseEvent.CLICK,doLoadGameHandle);
			panel.load_game.addEventListener(MouseEvent.ROLL_OVER,doRollOverHandle);
			panel.load_game.addEventListener(MouseEvent.ROLL_OUT,doRollOutHandle);
			addChild(panel);

			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
		}
		private function doNewGame(e:MouseEvent):void
		{
            addLoadingAni();
			Game.LoadGame=false;
			flox.setupSaveGame();

			
		}
		private function doLoadGameHandle(e:MouseEvent):void
		{
			Game.LoadGame=true;
			
			//SimgirlsLovemore.gameStart();

			var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
			gameEvent._name = "start-game";
			gameEvent.displayHandler();

		}
		private function doRollOverHandle(e:MouseEvent):void
		{
			e.target.gotoAndStop(2);
		}
		private function doRollOutHandle(e:MouseEvent):void
		{
			e.target.gotoAndStop(1);
		}

		private var buffer:MovieClip;
		private function addLoadingAni():void
		{

			buffer=new LoadingAni();
			addChild(buffer);
		}

		private function onRemovedHandler(e:Event):void{

            DebugTrace.msg("GameStartPanel.onRemovedHandler");
			if(buffer)
				removeChild(buffer);
		}
	}
}