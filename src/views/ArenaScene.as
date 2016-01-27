package views
{



import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.MediaCommand;
import controller.MediaInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.Config;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;

import flash.display.MovieClip;
import flash.geom.Point;

import model.SaveGame;
import model.Scenes;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
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
	private var player:Sprite;
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


		init();
	}
	private function init():void
	{

		scencom.init("ArenaScene",speaker_sprite,24,onStartStory);
		scencom.start();

	}
	private function onStartStory():void
	{

		var switch_verifies:Array=scencom.switchGateway("SSCCArena");
		if(switch_verifies[0]){
			scencom.disableAll();
			scencom.start();
		}

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
		var evtObj:Object = new Object();
		var scene:String = DataContainer.currentScene;
		var current_switch:String=flox.getSaveData("current_switch");
		switch(e.data.removed)
		{
			case "Leave":
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				_data.name="MainScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				break
			case "Battle":
				DataContainer.battleType="schedule";

				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				_data.name="ChangeFormationScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data);


				evtObj.command = "Join@"+scene;
				flox.logEvent("CloudCommand", evtObj);

				break
			case "CheckStatus":
				command.removeShortcuts();
				gameinfo.visible=false;
				raningScene=new RankBoard();
				Starling.current.nativeOverlay.addChild(raningScene);

				evtObj.command = "CheckStatus@"+scene;
				flox.logEvent("CloudCommand", evtObj);

				break
			case "Remove_Ranking":
				command.addShortcuts();
				gameinfo.visible=true;
				Starling.current.nativeOverlay.removeChild(raningScene);
				init();
				break
			case "ani_complete":
				var sysCommand:Object=flox.getSyetemData("command");
				command.showCommandValues(this,"Battle");
				init();
				break
			case "CannotParticipate":
				// from CommandCloud
//                        var msg:String="There's no game today.";
//                        var alert:AlertMessage=new AlertMessage(msg);
//                        addChild(alert);
				break
			case "story_complete":
				DebugTrace.msg("ArenaScene.doTopViewDispatch story_complete current_switch="+current_switch);
				player=new Sprite();
				addChild(player);
				var twinflame:String=flox.getSaveData("twinflame");
				var fullname:String=Config.fullnames[twinflame];


						if(current_switch=="s261|off"){
							//s261 off-> s262 on
							command.removeShortcuts();

							var mediaplayer:MediaInterface=new MediaCommand();
							mediaplayer.PlayVideo("End001",player,new Point(1024,768),null,30,"f4v",onEnd001VideoComplete);

						}
						if(current_switch=="s262|off"){
							//s262 off

							var mediaplayer:MediaInterface=new MediaCommand();
							mediaplayer.PlayVideo("End003/"+fullname,player,new Point(1024,768),null,30,"mp4",onEnd003VideoComplete);

						}
						if(current_switch=="s270|off"){

							var mediaplayer:MediaInterface=new MediaCommand();
							mediaplayer.PlayVideo("End005/"+fullname,player,new Point(1024,768),null,30,"mp4",onEnd005VideoComplete);

						}


						if(current_switch=="s280|off"){

							this.removeFromParent(true);
							var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
							gameEvent._name = "restart-game";
							gameEvent.displayHandler();

						}

				break

		}

	}
	private function onEnd001VideoComplete():void{

		DebugTrace.msg("ArenaScene.onEnd001VideoComplete");


		var twinflame:String=flox.getSaveData("twinflame");
		var fullname:String=Config.fullnames[twinflame];

		var mediaplayer:MediaInterface=new MediaCommand();
		mediaplayer.PlayVideo("End002/"+fullname,player,new Point(1024,768),null,30,"mp4",onEnd002VideoComplete);


	}
	private function onEnd002VideoComplete():void{

		DebugTrace.msg("ArenaScene.onEnd002VideoComplete");
		player.removeFromParent(true);
		Starling.juggler.removeTweens(this);

		flox.save("current_switch","s262|on");


		var _data:Object=new Object();
		_data.name= "SSCCArenaScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);
	}
	private function onEnd003VideoComplete():void{

		DebugTrace.msg("ArenaScene.onEnd003VideoComplete");

		var mediaplayer:MediaInterface=new MediaCommand();
		mediaplayer.PlayVideo("End004",player,new Point(1024,768),null,30,"mp4",onEnd004VideoComplete);
	}
	private function onEnd004VideoComplete():void{

		DebugTrace.msg("ArenaScene.onEnd004VideoComplete");
		player.removeFromParent(true);
		flox.save("current_switch","s270|on");

		var _data:Object=new Object();
		_data.name= "SSCCArenaScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);

	}
	private function onEnd005VideoComplete():void{


		this.removeFromParent(true);
		var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
		gameEvent._name = "restart-game";
		gameEvent.displayHandler();


	}

	private function onClosedAlert():void
	{
		var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
		gameEvent._name="clear_comcloud";
		gameEvent.displayHandler();

		var _data:Object=new Object();
		_data.name= "MainScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);

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