package
{
import com.demonsters.debugger.MonsterDebugger;
import com.gamua.flox.Player;
import com.gamua.flox.TimeScope;
import com.gamua.flox.utils.DateUtil;
import com.gamua.flox.utils.SHA256;
import com.greensock.TweenMax;
import com.greensock.easing.Elastic;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.display.ContentDisplay;

import data.MD5;

import flash.desktop.NativeApplication;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
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

import flash.events.MouseEvent;


import flash.geom.Rectangle;
import flash.system.System;


import model.CustomPlayer;

import services.LoaderRequest;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.Event;

import utils.DebugTrace;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.BattleScene;

import views.CommandCloud;
import views.GameStartPanel;
import views.LoginPanel;
import views.MainScene;

import views.QADisplayContainer;
import views.SceneVideo;

import views.TarotCardsDisplay;
import views.TraceGame;
import views.TrainingGame;


[SWF(width="1024",height="768")]
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
    public static var preview:Boolean=false;
    public static var previewStory:Boolean=false;

    public static var verifyKey:String;
    private var longinUI:MovieClip;

    private var gamestartUI:MovieClip;
    private var flox:FloxInterface=new FloxCommand();
    private var _starling:Starling;
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
    private var battlescene:flash.display.Sprite;
    private var blackmarketform:flash.display.Sprite;
    private var minigamescene:flash.display.Sprite;
    private var loaderReq:LoaderRequest
    private var campaign_visual:ContentDisplay;
    private var  campaignData:Object;
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
        DataContainer.restart=false;
        DataContainer.popupMessage=false;
        ViewsContainer.loaderQueue=new Object();

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
//        if(Main.verifyKey)
//        {
//            Config.verifyKey=Main.verifyKey;
//            flox.loginWithKey("%*%%!@#(","%*%%!@#(");
//        }


        if(previewStory){
            flox.LoginForDestroyPlayer("Fh9jSxC3pKzMJIeO","");

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

        MonsterDebugger.initialize(this);
        NativeApplication.nativeApplication.addEventListener(flash.events.Event.EXITING,onNavieAppExit);



    }
    private function onNavieAppExit(e:flash.events.Event):void
    {
        flox.logEvent("GameQuit");
    }

    private function initCampaign():void{

        loadCampaign();

    }
    private function loadCampaign():void
    {
        command.addLoadind("");
        var url:String=Config.campaignUrl;
        var loaderReq:LoaderRequest=new LoaderRequest();
        loaderReq.LoaderDataHandle(url,loadedCampaignComplete);
    }
    private function loadedCampaignComplete(data:String):void{
        DebugTrace.msg("SimgirlsLovemore.loadedCampaignComplete data="+data);
        campaignData=JSON.parse(data);
        if(campaignData.active){


            var loaderReq:LoaderRequest=new LoaderRequest();
            loaderReq.setLoaderQueue("campaign",campaignData.assets.src,this,loadedVisualComplete);

        }else{
            command.removeLoading();

        }
    }

    private function loadedVisualComplete(e:LoaderEvent):void{


        command.removeLoading();
        campaign_visual = LoaderMax.getContent("campaign");
        campaign_visual.buttonMode=true;
        campaign_visual.addEventListener(MouseEvent.MOUSE_DOWN, doCampaignFadeOut);

        function doCampaignFadeOut(e:MouseEvent):void{

            flox.logEvent("facebook_share");

            TweenMax.to(campaign_visual, 0.5, {alpha:0,onComplete:doCampaignFadeOutComplete});
            var hashkey:String=flox.getPlayerData("hashkey");
            var reqloader:LoaderRequest=new LoaderRequest();
            var vars:Object={authKey:hashkey};
            reqloader.navigateToURLHandler(campaignData.url,vars);
        }

    }
    private  function doCampaignFadeOutComplete():void{
        TweenMax.killAll();

        var queue:LoaderMax=ViewsContainer.loaderQueue["campaign"];
        queue.unload();

    }

    private function displayHandler(e:flash.events.Event):void
    {
        var scene:String=DataContainer.currentScene;
        switch(e.target._name)
        {
            case "start-game":

                onGameStart();
                break;
            case "waving":

                loaderReq=new LoaderRequest();
                loaderReq.setLoaderQueue("waving","../swf/map_anim.swf",e.target.container);

                break;
            case "remove_waving":
                try
                {
                    LoaderMax.getLoader("waving").unload();
                    //var queue:LoaderMax=ViewsContainer.loaderQueue;
                    //queue.empty(true,true);

                }
                catch(e:Error)
                {
                    DebugTrace.msg("SimgirlsLovemore.displayHandler waving Null");
                }
                break;
            case "comcloud":
                com_btn_txt=e.target.data;

                break;

            case "clear_comcloud":
                var clouds:Array=ViewsContainer.CurrentClouds;
                for(var i:uint=0;i<clouds.length;i++)
                {
                    var cloud:CommandCloud=clouds[i];
                    cloud.dispatchEventWith(CommandCloud.REMOVED);
                }
                ViewsContainer.CurrentClouds=new Array();
                break;
            case "disable_comloud":
                DebugTrace.msg("SimgirlsLovemore.displayHandler disable_comloud");
                for(var m:uint=0;m<comcouldlist.length;m++)
                {
                    cloud=comcouldlist[m];
                    cloud.visible=false;
                }

                break
            case "hide_comcloud":
//				for(var j:uint=0;j<comcouldlist.length;j++) {
//
//					TweenMax.to(comcouldlist[j],0.5,{alpha:0});
//				}
                break;
            case "show_comcloud":
//				for(var k:uint=0;k<comcouldlist.length;k++) {
//
//					TweenMax.to(comcouldlist[k],0.5,{alpha:1});
//				}
                break;
            case "QA":

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
                break;
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
                command.stopSound("MapWaves");
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
                //topview.removeChild(blackmarketform);
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
                loaderReq=new LoaderRequest();
                loaderReq.EmptyLoaderMax();
                topview.removeChild(minigamescene);
                break;

            case "restart-game":
                DataContainer.restart=true;
                gametitle=new BgGameTitle();
                addChild(gametitle);

                longinUI=new LoginPanel();
                addChild(longinUI);

                break;

        }
        //swich

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
        _data.removed="Choice";
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

            initCampaign();
        }


    }
    private function onGameStart():void
    {

        removeChild(gamestartUI);
        removeChild(gametitle);
        if(!_starling)
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


                var playerAttr:Object=Config.PlayerAttributes();
                flox.save("datingtwin",playerAttr.datingtwin);


            }
            if(DataContainer.restart){
                //restart game
                var gamescene:starling.display.Sprite=ViewsContainer.gameScene;
                gamescene.dispatchEventWith("RESTART_GAME");

            }else{
                command.topviewDispatch(TopViewEvent.REMOVE,_data);
            }

        }
        //if


    }
    private function onLoginFailed(type:String,msg:String):void
    {


        MainCommand.addAlertMsg(msg,type);


    }
    private function start():void
    {
        //stage.scaleMode = StageScaleMode.SHOW_ALL;
        //stage.align = StageAlign.TOP;
        //stage.quality=StageQuality.LOW;


        //Starling.multitouchEnabled = true; // useful on mobile devices
        var vp:Rectangle=new flash.geom.Rectangle(0, 0, 1024, 768);
        _starling=new Starling(Game,stage,vp,null,"auto","auto");

        _starling.showStats=false;
        Starling.current.nativeStage.frameRate = 24;
        //_starling.enableErrorChecking=Capabilities.isDebugger;

        _starling.start();


        //_starling.stage3D.addEventListener(Event.CONTEXT3D_CREATE,onContextCreated);
        _starling.addEventListener(starling.events.Event.ROOT_CREATED, onContextCreated);



        this.stage.addEventListener(flash.events.Event.DEACTIVATE, stage_deactiveHadnler,false, 0, true);
    }
    private function stage_deactiveHadnler(e:flash.events.Event):void{
        DebugTrace.msg("SimgirlsLovermore.stage_deactiveHadnler");
        System.gc();
        _starling.stop(true);
        this.stage.addEventListener(flash.events.Event.ACTIVATE, stage_activeHadnler,false, 0, true);
        mapActivedHander("deactive");
    }
    private function stage_activeHadnler(e:flash.events.Event):void{
        DebugTrace.msg("SimgirlsLovermore.stage_activeHadnler");
        this.stage.removeEventListener(flash.events.Event.ACTIVATE, stage_activeHadnler);
        _starling.start();
        mapActivedHander("active");

    }
    private function mapActivedHander(status:String):void{

        if(DataContainer.currentScene=="MainScene"){

            var mainscene:starling.display.Sprite=ViewsContainer.MainScene;
            if(mainscene){
                if(status=="deactive" ){

                    mainscene.dispatchEventWith(MainScene.DEACTAVICE);
                }else{
                    mainscene.dispatchEventWith(MainScene.ACTAVICE);
                }
            }
        }

    }
    private function onAddedToStage(e:flash.events.Event):void
    {
        removeEventListener(flash.events.Event.ADDED_TO_STAGE, onAddedToStage);
        start();


    }
    private function onContextCreated(e:starling.events.Event):void
    {

        if (Starling.context.driverInfo.toLowerCase().indexOf("software") != -1)
        {
            Starling.current.nativeStage.frameRate = 24;
        }

    }



}
}

