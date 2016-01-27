package
{

import com.demonsters.debugger.MonsterDebugger;

import controller.Assets;
import controller.CpuMembersCommand;
import controller.CpuMembersInterface;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.Config;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;

import flash.display.StageQuality;

import flash.ui.ContextMenu;

import model.BattleData;

import starling.display.Sprite;

import utils.DrawManager;

import views.StoryPreview;

//import model.Avatar;
import model.Scenes;

import services.LoaderRequest;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.GameInfobar;
import views.SaveandLoadList;



public class Game extends Sprite
{
	private var command:MainInterface=new MainCommand();
	private var mainstage:Sprite;
	private var scene:Sprite;
	private var uiView:Sprite;
	private var saveloadlist:Sprite;
	private var bgImg:Sprite;
	private static var loadgame:Boolean=false;
	private var flox:FloxInterface=new FloxCommand();
	private var paymentScene:Sprite=new Sprite();

	public static function set LoadGame(value:Boolean):void
	{
		loadgame=value;
	}
	public static function get LoadGame():Boolean
	{
		return loadgame;
	}
	public function Game()
	{
		Starling.current.nativeStage.quality=StageQuality.LOW;

		MonsterDebugger.initialize(this);

		//Starling.current.stage.stageWidth=1024;
		//Starling.current.stage.stageHeight=768;

		DataContainer.DatingSuit="";
		DataContainer.deadline=false;
		DataContainer.battleType="";
		DataContainer.currentScene="MainScene";
		mainstage=this;
		ViewsContainer.MainStage=mainstage;
		ViewsContainer.CurrentClouds=new Array();
		var scenes:Scenes=new Scenes();
		scenes.setupEvent();

        ViewsContainer.gameScene=this;
		ViewsContainer.currentScene=this;
		this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
		this.addEventListener("PAY_CHECK",onPayCheck);
        this.addEventListener("RESTART_GAME",onRestartGame);
        this.addEventListener("LOAD_TO_RESTART",onLoadToRestart);

		var assets:Assets=new Assets();
		assets.initMusicAssetsManager();
		assets.initSoundAssetsManager();

		if(SimgirlsLovemore.previewStory){

			scene=new Sprite();
			ViewsContainer.MainScene=scene;
			addChild(scene);
			//var _data:Object=new Object();
			//_data.name="StoryPreview";
			//command.sceneDispatch(SceneEvent.CHANGED,_data);
			var story:StoryPreview=new StoryPreview();
			scene.addChild(story);

		}else{

			if(loadgame)
			{
				initLoadScene();
			}
			else
			{
				initUI();
				initMainScene();

				var battleData:BattleData=new BattleData();
				battleData.checkBattleSchedule("BattleRanking","cpu_team");

			}
		}

			command.initCriminalsRecord();


	}
	private function doTopViewDispatch(e:TopViewEvent):void
	{
		DebugTrace.msg("Game.doTopViewDispatch removed:"+e.data.removed);

		switch(e.data.removed)
		{
			case "newgame":
			case "loadtoStart":
				removeChild(saveloadlist);
				initUI();
				initMainScene();

				break
			case "loadgame":
				initLoadScene();

				break
			case "remove_loadgame_gametitle":
				removeChild(bgImg);
				if(uiView){
					removeChild(uiView);
					uiView=null;
				}

				break
			case "characterdesign_to_loadgame":
				var scene:Sprite=ViewsContainer.MainScene;
				scene.removeFromParent();
				mainstage.removeChild(scene);

				var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
				gameEvt._name="display_new_load_game";
				gameEvt.displayHandler();
				break

			case "back":
				//game start close loadgame
				tweenCtrl(0,onFadeOutSaveLoadComplete);
				break
			case "Join":
				break

		}
		//switch
	}
    private function onRestartGame(e:Event):void{


        if(loadgame)
        {
            initLoadScene();
        }
        else
        {
            initUI();
            initMainScene();

        }

    }
    private function onLoadToRestart(e:Event):void{
        saveloadlist.removeFromParent(true);
        bgImg.removeFromParent(true);
        initUI();
        initMainScene();
    }

	private function initLoadScene():void
	{
		DebugTrace.msg("Game.initLoadScene");

		DataContainer.currentScene="HomePageScene";
		var drawManager:DrawerInterface=new DrawManager();
		bgImg=drawManager.drawBackground("HomePageScene");
		addChild(bgImg);

		saveloadlist=new SaveandLoadList("Arrive");
		saveloadlist.x=Starling.current.stage.stageWidth/2;
		saveloadlist.y=Starling.current.stage.stageHeight/2;
		saveloadlist.alpha=0;
		addChild(saveloadlist);
		tweenCtrl(1,onFadeInComplete);

	}

	private function onFadeOutSaveLoadComplete():void
	{
		Starling.juggler.removeTweens(saveloadlist);
		removeChild(bgImg);
		removeChild(saveloadlist);
		var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
		gameEvt._name="display_new_load_game";
		gameEvt.displayHandler()
	}
	private function tweenCtrl(value:Number,onTweenComplete:Function=null):void
	{

		var tween:Tween=new Tween(saveloadlist,0.5);
		tween.animate("alpha",value);
		tween.onComplete=onTweenComplete;
		Starling.juggler.add(tween);
	}
	private function onFadeInComplete():void
	{
		Starling.juggler.removeTweens(saveloadlist);
	}
	private function initMainScene():void
	{
		var battle:Boolean=DataContainer.battleDemo;
		//DebugTrace.obj("initMainScene: "+battle)
		scene=new Sprite();
		ViewsContainer.MainScene=scene;
		addChild(scene);

		command.setNowMood();
		//command.initContextMenu();

		var cpucom:CpuMembersInterface=new CpuMembersCommand();
		cpucom.setupFinalBoss();


		var _data:Object=new Object();
		var flox:FloxInterface=new FloxCommand();
		//var current_scene:String=flox.getSaveData("current_scene");
		var current_scene:String=DataContainer.currentScene;
		if(loadgame){
			_data.name="MainScene";
		}
		else{
			//_data.name="BattleScene";
			//_data.name="HotelScene";
			//_data.name="ProfileScene";
			//_data.name="MenuScene";
			_data.name="CharacterDesignScene";
			//_data.name="ChangeFormationScene";
			//_data.name="MainScene";
			//_data.name="Tarotreading";
			//_data.name="AirplaneScene";
			//_data.name="BlackMarketScene";
			//_data.name="TraceGame";
			//_data.name="TrainingGame";
			//_data.name="BetaScene";

		}

		command.sceneDispatch(SceneEvent.CHANGED,_data)



	}
	private function initUI():void
	{
		uiView=new Sprite();
		var gameInfo:GameInfobar=new GameInfobar();
		uiView.addChild(gameInfo);

		addChild(uiView);

		ViewsContainer.UIViews=uiView;
		//uiView.visible=false
	}
	private function onPayCheck(e:starling.events.Event):void
	{
		paymentScene=new Sprite();
		paymentScene.alpha=0;
		var bgTexture:Texture=Assets.getTexture("NormalBackground");
		var bgImg:Image=new Image(bgTexture);

		var msg:String="GameOver";
		var msgTxt:TextField=new TextField(1024,270,msg,"SimNeogreyMedium",20,0xFFFFFF);
		msgTxt.y=200;
		msgTxt.vAlign="center";
		msgTxt.hAlign="center";

		var btnTexture:Texture=Assets.getTexture("OptionBg");
		var paybtn:Button=new Button(btnTexture,"Buy Now");
		paybtn.fontName="SimNeogreyMedium";
		paybtn.fontSize=30;
		paybtn.fontColor=0xFFFFFF;
		paybtn.x=336;
		paybtn.y=430;
		paybtn.addEventListener(Event.TRIGGERED,doPayCheckout);

		paymentScene.addChild(bgImg);
		paymentScene.addChild(msgTxt);
		paymentScene.addChild(paybtn);
		addChild(paymentScene);

		var tween:Tween=new Tween(paymentScene,0.5);
		tween.animate("alpha",1);
		tween.onComplete=onPaymentFadeIn;
		Starling.juggler.add(tween);
	}
	private function onPaymentFadeIn():void
	{
		Starling.juggler.removeTweens(paymentScene);
	}
	private function doPayCheckout(e:Event):void
	{
		var target:Button=e.currentTarget as Button;
		target.text="Continue";

		command.addLoadind("");

		flox.refreshPlayer(onRefreshPlayerComplete)

	}
	private function onRefreshPlayerComplete():void
	{
		command.removeLoading();

		var paid:Boolean=flox.getPlayerData("paid");
		if(!paid)
		{

			var loderReq:LoaderRequest=new LoaderRequest();
			loderReq.paymentWeb("game");

		}
		else
		{
			removeChild(paymentScene);
			DataContainer.deadline=false;
			var _data:Object=new Object();
			_data.name=DataContainer.currentLabel;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}
		//if
	}
}
}