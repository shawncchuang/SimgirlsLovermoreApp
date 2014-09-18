package views
{
	
	
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;

import flash.display.MovieClip;

import model.SaveGame;
	import model.Scenes;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	import data.DataContainer;

	public class ArenaScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		
		private var payAP:Number=20;
		private var payCash:Number=20;
		//image return 5-10;
		private var getInt:Number=5;
		private var reInt:Number;
        private var raningScene:MovieClip;
		public function ArenaScene()
		{
			/*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
			button=new Button(pointbgTexture);
			addChild(button);
			button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
			DataContainer.BatttleScene="Arena";
			ViewsContainer.currentScene=this;
			this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
			speaker_sprite=new Sprite();
			addChild(speaker_sprite);
			speaker_sprite.flatten();


			init();
		}
		private function init():void
		{
			
			scencom.init("ArensScene",speaker_sprite,24,onCallback);
			scencom.start();
			scencom.disableAll();
		}
		private function onCallback():void
		{
			/*var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			
			
			var _data:Object=new Object();
			_data.name="BattleScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);*/
			
		}
		private function onSceneTriggered(e:Event):void
		{
			
			button.visible=false;
			command.sceneDispatch(SceneEvent.CLEARED);
			
			
			var tween:Tween=new Tween(this,1);
			tween.onComplete=onClearComplete;
			Starling.juggler.add(tween);
			
			
		}
		private function doTopViewDispatch(e:Event):void
		{
			DebugTrace.msg("ArenaScene.doTopViewDispatch removed:"+e.data.removed);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			var savegame:SaveGame=FloxCommand.savegame;
			var _data:Object=new Object();
            var gameinfo:Sprite=ViewsContainer.gameinfo;
			switch(e.data.removed)
			{
				case "Leave":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
				case "Join":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="ChangeFormationScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
                case "Rank":
                    gameinfo.visible=false;
                    raningScene=new RankBoard();
                    Starling.current.nativeOverlay.addChild(raningScene);
                    break
                case "Remove_Ranking":
                    gameinfo.visible=true;
                    Starling.current.nativeOverlay.removeChild(raningScene);
                    init();
                    break
				case "ani_complete":
					var sysCommand:Object=flox.getSyetemData("command");
					command.showCommandValues(this,"Join");
					init();
					break
                case "Cannot Join":
                        var msg:String="There's no game today."
                        var alert:AlertMessage=new AlertMessage(msg);
                        addChild(alert);
                    break
				
			}
			
		}
		 
		private function onClosedAlert():void
		{
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			 
			init();
			
		}
		private function onClearComplete():void
		{
			Starling.juggler.removeTweens(this);
			var _data:Object=new Object();
			_data.name= "MainScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}
	}
}