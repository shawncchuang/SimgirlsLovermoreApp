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
import data.DataContainer;

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
        var _data:Object=new Object();
        var gameinfo:Sprite=ViewsContainer.gameinfo;
        var evtObj:Object = new Object();
        var scene:String = DataContainer.currentScene;

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

                player=new Sprite();
                addChild(player);
                onStoryComplete();

                break

        }

    }
    private function onStoryComplete():void{

        var current_switch:String=flox.getSaveData("current_switch");
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;

        DebugTrace.msg("ArenaScene.doTopViewDispatch story_complete current_switch="+current_switch);
        switch (current_switch){

            case "s261|off":
                //s261 off-> s262 on
                command.removeShortcuts();
                videoPlayerhandler("End001",onEnd001VideoComplete);
                break;
            case "s262|off":
                videoPlayerhandler("End003",onEnd003VideoComplete);
                break;
            case "s270|off":
                DataContainer.EndingReplay=true;
                videoPlayerhandler("End002",onReplayEnd002VideoComplete);
                break;
            case "s1418|off":
                videoPlayerhandler("prms_rfs",onS1418Complete);
                break;
            case "s9999|off":
                this.removeFromParent(true);

                gameEvent._name = "restart-game";
                gameEvent.displayHandler();
                break;
            default:
                var _data:Object=new Object();
                _data.name= "MainScene";
                _data.from="story";
                command.sceneDispatch(SceneEvent.CHANGED,_data);
                break
        }


    }
    private function onEnd001VideoComplete():void{

        DebugTrace.msg("ArenaScene.onEnd001VideoComplete");

        videoPlayerhandler("End002",onEnd002VideoComplete);
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


        if(!DataContainer.EndingReplay){

            videoPlayerhandler("End004",onEnd004VideoComplete);

        }else{

            videoPlayerhandler("End005",onEnd005VideoComplete);

        }

    }
    private function onEnd004VideoComplete():void{

        DebugTrace.msg("ArenaScene.onEnd004VideoComplete");
        player.removeFromParent(true);
        flox.save("current_switch","s270|on");

        var _data:Object=new Object();
        _data.name= "SSCCArenaScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }

    private function onReplayEnd002VideoComplete():void{


        DebugTrace.msg("ArenaScene.onEnd002VideoComplete");
        player.removeFromParent(true);
        Starling.juggler.removeTweens(this);

        flox.save("current_switch","s262|on");
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

    private function onS1418Complete():void{

        player.removeFromParent(true);
        flox.save("current_switch","s1418b|on");

        var _data:Object=new Object();
        _data.name= "SSCCArenaScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

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
    private function videoPlayerhandler(src:String,callback:Function):void{


        var twinflame:String=flox.getSaveData("twinflame");
        var fullname:String=Config.fullnames[twinflame];
        var mediaplayer:MediaInterface=new MediaCommand();
        if(src=="End002" || src=="End003" || src=="End005"){
            var _src:String=src+"/"+fullname;
        }else{
            _src=src;

        }
        DebugTrace.msg("ArenaScene.videoPlayerhandler _src="+_src);

        mediaplayer.PlayVideo(_src,player,new Point(1024,768),null,30,"mp4",callback);

    }

}
}