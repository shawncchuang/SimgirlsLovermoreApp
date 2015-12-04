package
{
import com.gamua.flox.Player;
import com.greensock.TweenMax;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;

import events.GameEvent;

import flash.desktop.NativeApplication;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.events.Event;


import controller.FloxCommand;
import controller.FloxInterface;
import controller.FloxManagerController;
import controller.MainCommand;
import controller.MainInterface;

import data.Config;
import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;

import model.CustomPlayer;

import services.LoaderRequest;

import starling.core.Starling;
import starling.events.Event;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.BattleScene;

import views.CommandCloud;
import views.GameStartPanel;
import views.LoginPanel;
import views.QADisplayContainer;
import views.SceneVideo;
import views.StoryPreview;
import views.TarotCardsDisplay;
import views.TraceGame;
import views.TrainingGame;

[SWF(width="1024",height="768",frameRate="24")]
public class SimgirlsLovemore extends MovieClip
{

	[Embed(source="../assets/fonts/NeogreyMedium.otf",fontWeight='bold',
			fontName="SimNeogreyMedium",
			mimeType="application/x-font-truetype",
			embedAsCFF="false")]
	public static const NeogreyMediumOTF:String;

	[Embed(source="../assets/fonts/Impact.ttf",
			fontName="SimImpact",
			mimeType="application/x-font-truetype",
			embedAsCFF="false")]
	public static const ImpactTTF:String;

	[Embed(source="../assets/fonts/Futura.ttc",
			fontName="SimFutura",
			mimeType="application/x-font-truetype",
			embedAsCFF="false")]
	public static const FuturaTTC:String;



	[Embed(source="../assets/fonts/erbos_draco_1st_open_nbp.ttf",
			fontName="SimErbosDraco",
			mimeType="application/x-font-truetype",
			embedAsCFF="false")]
	public static const ErbosDracoTTF:String;

	[Embed(source="../assets/fonts/MyriadPro-Regular.otf",
			fontName="SimMyriadPro",
			mimeType="application/x-font-truetype",
			embedAsCFF="false")]
	public static const SimMyriadPro:String;


	private var manager:Boolean=false;
	public static var previewStory:Boolean=false;

	public static var verifyKey:String;
	private var longinUI:MovieClip;

	private var gamestartUI:MovieClip;
	private var flox:FloxInterface=new FloxCommand();
	private var mStarling:Starling;
	private var command:MainInterface=new MainCommand();
	public static var successLogin:Function;
	public static var failedLogin:Function;
	public static var gameStart:Function;
	public static var topview:MovieClip;
	public static var gameEvent:GameEvent;
	private var comcloud:MovieClip;
	//private var inputUI:InputNamePannel;
	private var qaDisplay:QADisplayContainer;
	private var qa_label:String;
	private var tarotcards:TarotCardsDisplay;
	private var videoframe:SceneVideo;
	private var gametitle:BgGameTitle;
	private static const PROGRESS_BAR_HEIGHT:Number = 20;
	private var com_btn_txt:String;
	private var comcouldlist:Array=new Array();
	private var animation:MovieClip;
	private var assetsform:flash.display.Sprite;
	public static var filtesContainer:MovieClip;
	private var swfloader:SWFLoader;
	private var battlescene:Sprite;
	private var blackmarketform:Sprite;
	private var minigamescene:Sprite;
	public function SimgirlsLovemore():void
	{
		//var paypal:PayPal=new PayPal();
		//paypal.init();

		//var se:SocialEngine=new SocialEngine();
		//se.init();


		ViewsContainer.PlayerProfile=null;
		var dateIndex:Object={"date":0,"month":3-1};
		DataContainer.currentDateIndex=dateIndex;
		DataContainer.battleDemo=false;
		DataContainer.SaveRecord=new Array();
		DataContainer.player=new Object();

		var evt:GameEvent=new GameEvent();
		evt.addEventListener(GameEvent.SHOWED,displayHandler);
		gameEvent=evt;

		flox.init();

		gametitle=new BgGameTitle();
		addChild(gametitle);

		longinUI=new LoginPanel();
		addChild(longinUI);


		var mc:MovieClip=new MovieClip();
		addChild(mc);
		topview=mc;


		//var filters:MovieClip=new MovieClip();
		//addChild(filters);
		//filtesContainer=filters;

		flox.loadSystemData();

		successLogin=onLoginComplete;
		failedLogin=onLoginFailed;
		gameStart=onGameStart;
		//DebugTrace.msg("SimgirlsLovemore.verifyKey:"+Preloader.verifyKey);
		var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
		DebugTrace.msg("player verify :"+currentPlayer.verify+" ; "+Main.verifyKey);
		if(Main.verifyKey)
		{
			Config.verifyKey=Main.verifyKey;
			flox.loginWithKey("%*%%!@#(","%*%%!@#(");
		}



		if(manager)
		{
			//flox manager panel-----------------

			var floxMg:FloxManagerController=new FloxManagerController();
			floxMg.init();
			addChild(floxMg);
			ViewsContainer.FloxManager=floxMg;

			//---------------------------
		}
		//if



		NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING,onNavieAppExit);


	}
	private function onNavieAppExit(e:flash.events.Event):void
	{
		flox.logEvent("GameQuit");
	}
	private function displayHandler(e:flash.events.Event):void
	{
		var scene:String=DataContainer.currentScene;
		switch(e.target._name)
		{
			case "waving":

				var loaderReq:LoaderRequest=new LoaderRequest();
				loaderReq.setLoaderQueue("waving","../swf/map_anim.swf",e.target.container);

				break;
			case "remove_waving":
				try
				{
					LoaderMax.getLoader("waving").unload();
				}
				catch(e:Error)
				{

				}
				break;
			case "comcloud":
				com_btn_txt=e.target.data;
//					comcloud=new CommandCloud(com_btn_txt);
//					//topview.addChild(comcloud);
//					Starling.current.nativeOverlay.addChild(comcloud);
//					comcouldlist.push(comcloud);

				break;

			case "clear_comcloud":
				var clouds:Array=ViewsContainer.CurrentClouds;
				for(var i:uint=0;i<clouds.length;i++)
				{
					var cloud:CommandCloud=clouds[i];
					cloud.removeFromParent(true);

				}
				ViewsContainer.CurrentClouds=new Array();
				break;
			case "disable_comloud":
				DebugTrace.msg("SimgirlsLovemore.disable_comloud");
				for(var m:uint=0;m<comcouldlist.length;m++)
				{
					var cloud:CommandCloud=comcouldlist[m];
					cloud.visible=false;
				}

				break
			case "hide_comcloud":
				for(var j:uint=0;j<comcouldlist.length;j++) {

					TweenMax.to(comcouldlist[j],0.5,{alpha:0});
				}
				break;
			case "show_comcloud":
				for(var k:uint=0;k<comcouldlist.length;k++) {

					TweenMax.to(comcouldlist[k],0.5,{alpha:1});
				}
				break;
			case "QA":
				//inputUI=new InputNamePannel(onSubmitComplete);
				//topview.addChild(inputUI);
				qa_label=e.target.qa_label;
				qaDisplay=new QADisplayContainer(qa_label,onSubmitComplete);
				topview.addChild(qaDisplay);
				break;
			case "tarot_cards":
				tarotcards=new TarotCardsDisplay();
				topview.addChild(tarotcards);
				break;
			case "remove_tarot_card":
				topview.removeChild(tarotcards);
				break;
			case "show_video":
				//command.playSound("plane");
				videoframe=new SceneVideo(e.target.video,onVideoComplete);
				topview.addChild(videoframe);
				break;

			case "display_new_load_game":
				Game.LoadGame=false;

				gametitle=new BgGameTitle();
				addChild(gametitle);

				onLoginComplete();
				break
			case "assets_form":
			case "dating_assets_form":
				//assetsform=new AssetsTileList(e.target._name);
				//topview.addChild(assetsform);
				break;
			case "enable_assets_form":
				assetsform.visible=true;
				break;
			case "disable_assets_form":
				assetsform.visible=false;
				break;
			case "removed_assets_form":
				topview.removeChild(assetsform);
				break;
			case "battle":
				battlescene=new BattleScene();
				topview.addChild(battlescene);
				break;
			case "remove_battle":
				topview.removeChild(battlescene);
				break;
			case  "blackmarket_form":
				//blackmarketform=new BlackTileList();
				//topview.addChild(blackmarketform);
				break;
			case "remove_blackmarket_form":
				topview.removeChild(blackmarketform);
				break;
			case "TraceGame":
				minigamescene=new TraceGame();
				topview.addChild(minigamescene);
				break
			case "TrainingGame":
				minigamescene=new TrainingGame();
				topview.addChild(minigamescene);
				break;
			case "remove_mini_game":
				topview.removeChild(minigamescene);
				break
		}
		//siwtch

	}

	private function onAnimationComplete(e:flash.events.Event):void
	{
		if(e.target.currentFrame==e.target.totalFrames)
		{
			animation.removeEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
			animation.addEventListener(flash.events.Event.ENTER_FRAME,doFadeoutAnimation);

			/*topview.removeChild(animation);
			 var _data:Object=new Object();
			 _data.removed="ani_complete";
			 command.topviewDispatch(TopViewEvent.REMOVE,_data);*/


			var _data:Object=new Object();
			_data.removed="ani_complete_clear_character";
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
		}

	}
	private function doFadeoutAnimation(e:flash.events.Event):void
	{
		var __alpha:Number=(0-animation.alpha*100)*0.5;
		animation.alpha+=__alpha/100;
		//DebugTrace.msg("SimgirlsLovemore.doFadeoutAnimation __alpha:"+__alpha)
		if(Number(__alpha.toFixed(1))==0.0)
		{
			animation.removeEventListener(flash.events.Event.ENTER_FRAME,doFadeoutAnimation);
			topview.removeChild(animation);

			var _data:Object=new Object();
			_data.removed="ani_complete";
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
		}
	}
	private function onVideoComplete():void
	{
		topview.removeChild(videoframe);
		//DebugTrace.msg("SimgirlsLovemore.onVideoComplete : "+SceneEvent.scene);
		DebugTrace.msg("SimgirlsLovemore.onVideoComplete : "+DataContainer.currentScene);
		var _data:Object=new Object();
		switch(DataContainer.currentScene)
		{
			case "Tarotreading":
				_data.name="AirplaneScene";
				break
			case "AirplaneScene":
				_data.name="MainScene";
				break
		}
		//switch
		command.sceneDispatch(SceneEvent.CHANGED,_data);

	}
	private function onSubmitComplete():void
	{

		DebugTrace.msg("SimgirlsLovemore.onSubmitComplete");
		topview.removeChild(qaDisplay);
		var _data:Object=new Object();
		_data.removed="QA";
		command.topviewDispatch(TopViewEvent.REMOVE,_data);


	}
	private function onLoginComplete():void
	{
		//flox.save();
		//flox.setup();
		//flox.loadEntities();
		//flox.indices("nickname");
		//flox.submitCoins();
		if(longinUI)
		{

			removeChild(longinUI);
			longinUI=null;

		}
		if(previewStory){
			removeChild(gametitle);
			start();
		}else{

			gamestartUI=new GameStartPanel();
			addChild(gamestartUI);
		}


	}
	private function onGameStart():void
	{

		removeChild(gamestartUI);
		removeChild(gametitle);
		if(!mStarling)
		{


			if(stage)
			{
				start();
			}
			else
			{
				addEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
			}
			//if

		}
		else
		{
			var _data:Object=new Object();
			if(Game.LoadGame)
			{
				_data.removed="loadgame";

			}
			else
			{
				_data.removed="newgame";
			}
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
		}
		//if


	}
	private function onLoginFailed(re:String):void
	{


		MainCommand.addAlertMsg(re);

	}
	private function start():void
	{
		//stage.scaleMode = StageScaleMode.NO_SCALE;

		stage.align = StageAlign.TOP_LEFT;


		//Starling.multitouchEnabled = true; // useful on mobile devices
		Starling.handleLostContext = true; // required on Windows and Android, needs more memory


		mStarling=new Starling(Game,stage,null,null,"auto","auto");
		mStarling.showStats=false;

		//mStarling.enableErrorChecking=Capabilities.isDebugger;

		mStarling.start();
		//mStarling.stage3D.addEventListener(Event.CONTEXT3D_CREATE,onContextCreated);

		mStarling.addEventListener(starling.events.Event.ROOT_CREATED, onContextCreated);
	}
	private function onAddedToStage(event:flash.events.Event):void
	{
		removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
		start();
	}
	private function onContextCreated(e:starling.events.Event):void
	{

		if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
		{
			Starling.current.nativeStage.frameRate = 30;
		}

	}


}
}

