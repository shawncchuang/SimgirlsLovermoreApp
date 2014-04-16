package
{
	import com.gamua.flox.Player;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	
	//import flash.display.Bitmap;
	//import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	//import flash.display.StageScaleMode;
	import flash.events.Event;
	
	//import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	//import controller.FloxManagerController;
	
	import data.Config;
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.CustomPlayer;
	
	//import services.PayPal;
	//import services.SocialEngine;
	//import services.TurboSMTP;
	
	import starling.core.Starling;
	import starling.events.Event;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	import views.AssetsTileList;
	import views.BattleScene;
	import views.BlackTileList;
	import views.CommandCloud;
	
	import views.GameStartPanel;
	//import views.InputNamePannel;
	import views.LoginPanel;
	import views.QADisplayContainer;
	import views.SceneVideo;
	import views.TarotCardsDisplay;
	import controller.FloxManagerController;
	
	[SWF(width="1024",height="768",frameRate="24", backgroundColor="#222222")]
	public class SimgirlsLovemore extends MovieClip
	{
		
		public static var verifyKey:String;
		private var longinUI:MovieClip;
		
		private var gamestartUI:MovieClip;
		private var floxserver:FloxInterface=new FloxCommand();
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
		public function SimgirlsLovemore():void
		{
			//var paypal:PayPal=new PayPal();
			//paypal.init();
			
			//var se:SocialEngine=new SocialEngine();
			//se.init();
			
			
			var dateIndex:Object={"date":0,"month":3-1};
			DataContainer.currentDateIndex=dateIndex;
			DataContainer.battleDemo=false;
			DataContainer.SaveRecord=new Array();
			DataContainer.player=new Object();
			
			var evt:GameEvent=new GameEvent();
			evt.addEventListener(GameEvent.SHOWED,displayHandler);
			gameEvent=evt;
			
			floxserver.init();
			
			gametitle=new BgGameTitle()
			addChild(gametitle);
			
			longinUI=new LoginPanel()
			addChild(longinUI);
			
			
			var mc:MovieClip=new MovieClip();
			addChild(mc);
			topview=mc;
			
			
			var filters:MovieClip=new MovieClip();
			addChild(filters);
			filtesContainer=filters;
			
			command.initSceneLibrary();
			
			successLogin=onLoginComplete;
			failedLogin=onLoginFailed;
			gameStart=onGameStart;
			//DebugTrace.msg("SimgirlsLovemore.verifyKey:"+Preloader.verifyKey);
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			DebugTrace.msg("player verify :"+currentPlayer.verify+" ; "+Main.verifyKey);
			if(Main.verifyKey)
			{
				Config.verifyKey=Main.verifyKey;
				floxserver.loginWithKey("%*%%!@#(","%*%%!@#(");
			}
			
			//flox manager -----------------
			/*
			var floxMg:FloxManagerController=new FloxManagerController();
			floxMg.init();
			addChild(floxMg);
			ViewsContainer.FloxManager=floxMg;
			*/
			//---------------------------
		}
		 
		private function displayHandler(e:flash.events.Event):void
		{
			var scene:String=DataContainer.currentScene;
			switch(e.target._name)
			{
				case "waving":
					//new SWFLoader("main.swf", {name:"myFile", x:100, y:100, width:200, height:200, container:this, onComplete:completeHandler, onProgress:progressHandler});
					var queue:LoaderMax = new LoaderMax({name:"mainQueue"});
					swfloader=new SWFLoader("../swf/map_anim.swf", {name:"waving",width:1536,hieght:1195, container:filtesContainer});
					queue.append(swfloader);
					LoaderMax.prioritize("photo1");
					queue.load();
					break
				case "remove_waving":
					if(swfloader)
					swfloader.unload();
					break
				case "comcloud":
					com_btn_txt=e.target.data;
					comcloud=new CommandCloud(com_btn_txt)
					topview.addChild(comcloud);
					comcouldlist.push(comcloud);
					/*comcloud=new ComCloud();
					comcloud.buttonMode=true;
					comcloud.addEventListener(MouseEvent.CLICK,doClickComCloud);
					comcloud.mc.addEventListener(Event.ENTER_FRAME,doComCloudEnterFrame)
					topview.addChild(comcloud);*/
					break
				
				case "clear_comcloud":
					for(var i:uint=0;i<comcouldlist.length;i++)
					{
						topview.removeChild(comcouldlist[i]);
					}
					comcouldlist=new Array();
					break
				case "QA":
					//inputUI=new InputNamePannel(onSubmitComplete);	
					//topview.addChild(inputUI);
					qa_label=e.target.qa_label
					qaDisplay=new QADisplayContainer(qa_label,onSubmitComplete);
					topview.addChild(qaDisplay);
					break
				case "tarot_cards":
					tarotcards=new TarotCardsDisplay();
					topview.addChild(tarotcards);
					break
				case "remove_tarot_card":
					topview.removeChild(tarotcards);
					break
				case "show_video":
					//command.playSound("plane");
					videoframe=new SceneVideo(e.target.video,onVideoComplete);
					topview.addChild(videoframe);
					break
				
				case "display_new_load_game":
					Game.LoadGame=false;
					
					gametitle=new BgGameTitle();
					addChild(gametitle);
					
					onLoginComplete();
					break
				case "rest_animation":
					animation=new RestAnimation();
					animation.addEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
					topview.addChild(animation);
					 
					break
				case "stay_animation":
					animation=new RestAnimation();
					animation.addEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
					topview.addChild(animation);
					break
				case "train_animation":
					animation=new TrainAnimation();
					animation.addEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
					topview.addChild(animation);
					
					break
				case "learning_animation":
					switch(scene)
					{
						case "MuseumScene":
							animation=new MuseumLearnAnimation();
						break
						case "AcademyScene":
							animation=new AcademyLearnAnimation();
							break

					}
					//swotch
					
					animation.addEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
					topview.addChild(animation);
					break
				case "working_animation":
					
					
					DebugTrace.msg("SimgirlLovemore.displayHandler scene:"+scene)
					switch(scene)
					{
					   case "NightclubScene":
						   animation=new NightClubWorkAnimation();
						   break
					   case "BankScene":
						   animation=new BankWorkAnimation();
						   break
					   case "ThemedParkScene":
						   animation=new ThemedParkWorkAnimation();
						   break
					}
					
					animation.addEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
					topview.addChild(animation);
					break
				case "meditate_animation":
					animation=new MeditateAnimation();
					animation.addEventListener(flash.events.Event.ENTER_FRAME,onAnimationComplete);
					topview.addChild(animation);
					break
				case "assets_form":
				case "dating_assets_form":
					assetsform=new AssetsTileList(e.target._name);
					topview.addChild(assetsform);
					break
				case "enable_assets_form":
					assetsform.visible=true;
					break
				case "disable_assets_form":
					assetsform.visible=false;
					break
				case "removed_assets_form":
					topview.removeChild(assetsform);
					break
				case "battle":
					battlescene=new BattleScene();
					topview.addChild(battlescene);
					break
				case "remove_battle":
					topview.removeChild(battlescene);
					break
				case  "blackmarket_form":
					blackmarketform=new BlackTileList();
					topview.addChild(blackmarketform);
					break
				case "remove_blackmarket_form":
					topview.removeChild(blackmarketform);
					break
			}
			//siwtch
			
		}
		/*private function doClickComCloud(e:MouseEvent):void
		{
		comcloud.removeEventListener(MouseEvent.CLICK,doClickComCloud);
		comcloud.mc.gotoAndPlay("broke");
		command.playSound("Break");
		
		}*/
		/*private function doComCloudEnterFrame(e:Event):void
		{
		if(e.target.currentFrameLabel=="showed")
		{
		if(com_btn_txt.indexOf("^")!=-1)
		{
		com_btn_txt=String(com_btn_txt.split("^").join("\n"));
		}
		comcloud.mc.txt.text=com_btn_txt;
		}
		
		if(e.target.currentFrame==e.target.totalFrames)
		{
		comcloud.mc.removeEventListener(Event.ENTER_FRAME,doComCloudEnterFrame);
		topview.removeChild(comcloud);
		
		var _data:Object=new Object();
		_data.removed="comcloud";
		command.topviewDispatch(TopViewEvent.REMOVE,_data);
		
		}
		}*/
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
			DebugTrace.msg("SimgirlsLovemore.onVideoComplete : "+SceneEvent.scene);
			
			var _data:Object=new Object();
			switch(SceneEvent.scene)
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
			//saved QA
			DebugTrace.msg("SimgirlsLovemore.onSubmitComplete");
			topview.removeChild(qaDisplay);
			var _data:Object=new Object();
			_data.removed="QA";
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
			
			
		}
		private function onLoginComplete():void
		{
			//floxserver.save();
			//floxserver.setup();
			//floxserver.loadEntities();
			//floxserver.indices("nickname");
			//floxserver.submitCoins();
			if(longinUI)
			{
				
				removeChild(longinUI);
				longinUI=null;	
				
			}
			
			gamestartUI=new GameStartPanel();
			//gamestartUI.x=408;
			//gamestartUI.y=525;
			addChild(gamestartUI);
			
			
			
			
			
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
			
			
			mStarling=new Starling(Game,stage);
			mStarling.showStats=true;
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

