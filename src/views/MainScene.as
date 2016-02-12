package views
{


import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.display.ContentDisplay;

import controller.DrawerInterface;

import controller.SoundController;

import data.DataContainer;

import flash.display.MovieClip;
import flash.geom.Point;

import controller.AssetEmbeds;
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.MediaCommand;
import controller.MediaInterface;

import data.Config;

import events.SceneEvent;

import flash.media.SoundChannel;

import model.SaveGame;
import model.Scenes;

import starling.animation.DelayedCall;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.utils.AssetManager;

import utils.DebugTrace;
import utils.DrawManager;
import utils.ViewsContainer;

public class MainScene extends Scenes
{
    private var command:MainInterface=new MainCommand();
    private var target:String;
    private var points:Sprite;
    private var preview:Image;
    private var container:Sprite;
    private var stageW:Number;
    private var stageH:Number;
    private var bgX:Number=0;
    private var bgY:Number=0;
    private var gx:Number=0;
    private var gy:Number=0;
    private var signTween:Tween;
    private var posY:Number;
    private var currentImg:Image;
    private var sign_name:String="";
    private var scroll_area:uint=350;
    private var speed:Number=.2;
    private var mediacom:MediaInterface=new MediaCommand();
    private var wavesSound:SoundChannel;
    private var sceneDelay:DelayedCall;
    public function MainScene()
    {

        stageW=Starling.current.stage.stageWidth;
        stageH=Starling.current.stage.stageHeight;

        command.checkCaptainAdjustData();


        initScene();
        sceneDelay=new DelayedCall(onSceneComplete,0.5);
        Starling.juggler.add(sceneDelay);



    }
    private function onSceneComplete():void{
        Starling.juggler.remove(sceneDelay);
        initWaving();
        initSigns();
        init();
    }
    private function init():void{

        //after random battle
        var winner:String=DataContainer.BattleWinner;
        var battleType:String=DataContainer.battleType;
        var ability:Object=DataContainer.CrimimalAbility;
        if(battleType=="random_battle" && winner=="player"){
            var rewards:Object={"cash":ability.rewards};
            command.showCommandValues(this,"HuntRewards-"+ability.rank,rewards);

            var flox:FloxInterface=new FloxCommand();
            var cash:Number=flox.getSaveData("cash");
            cash+=ability.rewards;
            flox.save("cash",cash);

            var gameinfo:Sprite = ViewsContainer.gameinfo;
            gameinfo.dispatchEventWith("UPDATE_INFO");
            DataContainer.battleType="";

        }
        DataContainer.BattleWinner="";


    }
    private function initWaving():void
    {

        var wavesloader:SWFLoader=LoaderMax.getLoader("waving") as SWFLoader;
        if(wavesloader)
            wavesloader.content.visible=true;

        command.playSound("MapWaves",100);

    }

    private var movieX:Number;
    private var movieY:Number;
    private var scrollX:Number;
    private var scrollY:Number;
    private var scene:Sprite;
    public static var DEACTAVICE:String="deactive";
    public static var ACTAVICE:String="active";
    private function initScene():void
    {

        scene=ViewsContainer.MainScene;
        container=scene.getChildByName("scene_container") as Sprite;

        var drawmanager:DrawerInterface=new DrawManager();
        var bgSprite:Sprite=drawmanager.drawBackground("MainScene");
        container.addChild(bgSprite);

        bgX=container.x;
        bgY=container.y;


        scrollX=stageW;
        scrollY=stageH;

        movieX=(1536-stageW)/scrollX;
        movieY=(1195-stageH)/scrollY;

        this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);
        scene.addEventListener(MainScene.DEACTAVICE,onDeactiveHandler);
        scene.addEventListener(MainScene.ACTAVICE,onActiveHandler);

        var gameInfo:Sprite=ViewsContainer.gameinfo;
        //gameInfo.addEventListener(TouchEvent.TOUCH,onGameInfobarTouched);
        scene.addEventListener(TouchEvent.TOUCH,onSceneTouched);
        scene.addEventListener(Event.ENTER_FRAME,doSceneEnterFrame);
    }
    private function onDeactiveHandler(e:Event):void{

        deactiveHandler();
    }
    private function onActiveHandler():void{
        initWaving();
        scene.addEventListener(TouchEvent.TOUCH,onSceneTouched);
        scene.addEventListener(Event.ENTER_FRAME,doSceneEnterFrame);
    }
    private function onRemovedHandler(e:Event):void{

        this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);
        scene.removeEventListener(MainScene.DEACTAVICE,onDeactiveHandler);
        scene.removeEventListener(MainScene.ACTAVICE,onActiveHandler);
        deactiveHandler();


    }
    private function deactiveHandler():void{

        scene.removeEventListener(TouchEvent.TOUCH,onSceneTouched);
        scene.removeEventListener(Event.ENTER_FRAME,doSceneEnterFrame);
        command.stopSound("MapWaves");

        //var swfloader:SWFLoader=LoaderMax.getLoader("waving") as SWFLoader;
        //swfloader.content.visible=false;
    }
    private  var new_gx:Number=0;
    private  var new_gy:Number=0;
    //private var hover:Touch;
    private function onGameInfobarTouched(e:TouchEvent):void
    {
        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
        if(hover)
        {

            gx=movieX*hover.globalX;
            gy=movieY*hover.globalY;

        }
        //for
    }
    private function onSceneTouched(e:TouchEvent):void
    {
        var scene:Sprite=ViewsContainer.MainScene;
        var target:Sprite=e.currentTarget as Sprite;
        var touch:Touch=e.getTouch(target);
        var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
        //DebugTrace.msg("MainScene  onSceneTouched:"+target.name);
        //var moved:Touch = e.getTouch(target, TouchPhase.MOVED);


        bgX=container.x;
        bgY=container.y;
        /*if(moved)
         {
         gx=moved.globalX;
         gy=moved.globalY;

         }*/

        if(hover)
        {

            gx=movieX*hover.globalX;
            gy=movieY*hover.globalY;

        }
        else
        {

            //gx=0;
            //gy=0;


        }



    }
    private function doSceneEnterFrame(e:Event):void
    {



        bgX=-gx;
        bgY=-gy;
        container.x+=(bgX-container.x)*speed;
        container.y+=(bgY-container.y)*speed;
        //container.x=bgX;
        //container.y=bgY;


        if(bgX>0)
        {
            bgX=0;
        }
        else if(bgX<container.width-stageW)
        {

            bgX=-(container.width-stageW);
        }
        if(bgY>0)
        {
            bgY=0;
        }
        else if(bgY<container.height-stageH)
        {
            bgY=-(container.height-stageH);

        }



        var waving:MovieClip=Starling.current.nativeOverlay.getChildByName("waving") as MovieClip;
        if(waving){

            waving.x=container.x;
            waving.y=container.y;

        }




    }
    private function initSigns():void
    {
        /*
         var texture:Texture = Texture.fromBitmap(new AtlasTexture());
         var xml:XML = XML(new AtlasXml());
         var atlas:TextureAtlas = new TextureAtlas(texture, xml);
         */



        var textureClass:Class=AssetEmbeds;

        var texture:Texture=Assets.getTexture("SignsSheet");
        var xml:XML = XML(Assets.getAtalsXML("SignsSheetXML"));
        var atlas:TextureAtlas = new TextureAtlas(texture, xml);
        var stagepoints:Object=Config.stagepoints;

        for(var p:String in stagepoints)
        {
            //DebugTrace.msg(p);
            var signTexture:Texture = atlas.getTexture(p);
            var signImg:Image=new Image(signTexture);
            signImg.useHandCursor=true;
            signImg.name=p
            signImg.x=stagepoints[p][0]-signImg.width/2;
            signImg.y=stagepoints[p][1]-signImg.height;
            signImg.addEventListener(TouchEvent.TOUCH,doTouchSign);
            container.addChild(signImg);
        }


    }
    private function doTouchSign(e:TouchEvent):void
    {
        currentImg=e.currentTarget as Image;
        var touch:Touch = e.getTouch(currentImg, TouchPhase.HOVER);
        var began:Touch=e.getTouch(currentImg,TouchPhase.BEGAN);
        if(began)
        {
            //DebugTrace.msg("MainScene.doTouchSign began: "+currentImg.name);

            var savegame:SaveGame=FloxCommand.savegame;
            var date:String=savegame.date;
            var time:String=date.split("|")[1];
            var target:String=currentImg.name+"Scene";
            var msg:String;
            var openDay:Boolean;
            var openNight:Boolean;
            switch(target){
                case "NightclubScene":
                    msg="The Night Club'll open at night.";
                    openDay=false;
                    openNight=true;
                    break
                case "BlackMarketScene":
                    msg="The Black Market'll open at night.";
                    openDay=false;
                    openNight=true;
                    break
                case "SportBarScene":
                    msg="The Sport Bar'll open at night.";
                    openDay=false;
                    openNight=true;
                    break
                case "BankScene":
                    msg="The Bank'll open in the morning.";
                    openDay=true;
                    openNight=false;
                    break
                case "RestaurantScene":
                    msg="The Restaurant'll open at night.";
                    openDay=false;
                    openNight=true;
                    break
//                case "FitnessClubScene":
//                    msg="The Fitness Club'll open in the morning.";
//                    openDay=true;
//                    openNight=false;
//                    break
                default:
                    msg=null;
                    openDay=true;
                    openNight=true;
                    break

            }
            var enabled:Boolean=command.checkSceneEnable(target);
            if(enabled){
                changeScene(target,openDay,openNight,time,msg);
            }else{
                msg="This place is not open to tourists.";
                var alert:Sprite=new AlertMessage(msg);
                Starling.current.stage.addChild(alert);

            }


        }
        if(touch)
        {
            if(sign_name=="")
            {
                //DebugTrace.msg("MainScene.doTouchSign touch: "+currentImg.name);
                sign_name=currentImg.name;
                var stagepoints:Object=Config.stagepoints;
                posY=stagepoints[currentImg.name][1]-currentImg.height;
                signTween=new Tween(currentImg,0.4,Transitions.EASE_IN_OUT);
                signTween.animate("y",posY-10);
                signTween.onComplete=onHaverSignComplete;
                Starling.juggler.add(signTween);
            }
            //if
        }
        else
        {
            //DebugTrace.msg("MainScene.doTouchSign !touch: "+currentImg.name);
            sign_name="";
            Starling.juggler.remove(signTween);
            currentImg.y=posY;
        }
        //if

    }
    private var waving:MovieClip;
    private function changeScene(target:String,openDay:Boolean,openNight:Boolean,time:String,msg:String=null):void
    {
        var _data:Object=new Object();
        var mainStage:Sprite=ViewsContainer.MainStage;
        waving=Starling.current.nativeOverlay.getChildByName("waving") as MovieClip;
        if(!openDay && openNight)
        {
            //day close ,night open
            if(time=="24")
            {
                //night

                _data.name= target;
                command.sceneDispatch(SceneEvent.CHANGED,_data);
                currentImg.removeEventListener(TouchEvent.TOUCH,doTouchSign);
            }
            else
            {



                waving.visible=false;
                var alert:AlertMessage=new AlertMessage(msg,onAlertClosedCallback);
                mainStage.addChild(alert);
            }
            //if
        }
        //if
        if(openDay && !openNight)
        {
            //day open , nihght close

            if(time=="24")
            {
                //night
                waving.visible=false;
                alert=new AlertMessage(msg,onAlertClosedCallback);
                mainStage.addChild(alert);

            }
            else
            {
                _data.name= target;
                command.sceneDispatch(SceneEvent.CHANGED,_data);
                currentImg.removeEventListener(TouchEvent.TOUCH,doTouchSign);
            }
            //if
        }
        //if
        if(openDay && openNight)
        {
            //all day
            _data.name= target;
            command.sceneDispatch(SceneEvent.CHANGED,_data);
            currentImg.removeEventListener(TouchEvent.TOUCH,doTouchSign);


        }
    }
    private function onHaverSignComplete():void
    {
        Starling.juggler.remove(signTween);
        signTween=new Tween(currentImg,0.2,Transitions.EASE_IN);
        signTween.animate("y",posY);
        signTween.onComplete=onSignComplete;
        Starling.juggler.add(signTween);
    }
    private function onSignComplete():void
    {
        Starling.juggler.remove(signTween);

    }

    private function addPreview(p:String):void
    {
        //show preview
        var stagepoints:Object=Config.stagepoints;
        preview=new Image(Assets.getTexture(p+"Preview"));
        preview.name="preview";
        preview.x=stagepoints[p][0];
        preview.y=stagepoints[p][1]+30;
        preview.alpha=0;
        points.addChild(preview);
        addTween(preview,1);
    }



    private function addTween(target:Object,value:uint):void
    {
        var tween:Tween=new Tween(target,0.2,Transitions.EASE_IN);
        tween.animate("alpha",value);
        Starling.juggler.add(tween);
    }
    private function fadeoutTween(target:Object,value:uint):void
    {
        var tween:Tween=new Tween(target,0.2,Transitions.EASE_IN);
        tween.animate("alpha",value);
        tween.onComplete=onFadoutComplete;
        Starling.juggler.add(tween);

    }
    private function onFadoutComplete():void
    {

        var _preview:DisplayObject=points.getChildByName("preview");
        //points.removeChild(_preview);
        points.removeFromParent();
        preview=null
    }
    private function onAlertClosedCallback():void{

        waving.visible=true;

    }


}
}