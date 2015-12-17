package views
{



import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;


import model.Scenes;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;

import utils.DebugTrace;
import utils.ViewsContainer;

public class BeachScene extends Scenes
{
    private var speaker_sprite:Sprite;
    private var command:MainInterface=new MainCommand();
    private var button:Button;
    private var scenecom:SceneInterface=new SceneCommnad();
    private var flox:FloxInterface=new FloxCommand();

    private var getAP:Number=10;


    public function BeachScene()
    {
        /*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
         button=new Button(pointbgTexture);
         addChild(button);
         button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
        ViewsContainer.currentScene=this;
        this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
        speaker_sprite=new Sprite();
        addChild(speaker_sprite);

        init(onStartStory);
    }
    private function init(callback:Function=null):void
    {

        scenecom.init("BeachScene",speaker_sprite,12,callback);
        scenecom.start();


        if(DataContainer.shortcuts=="Rest"){

            var _data:Object=new Object();
            _data.removed=DataContainer.shortcuts;
            command.topviewDispatch(TopViewEvent.REMOVE,_data);
            DataContainer.shortcuts="";
        }


    }
    private function onStartStory():void
    {
        DebugTrace.msg("BeachScene.onStartStory");

        scenecom.disableAll();
        var switch_verifies:Array=scenecom.switchGateway("BeachScene");
        DebugTrace.msg("Beach.init switch_verifies="+switch_verifies);
        if(switch_verifies[0])
        {
            scenecom.start();

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
        DebugTrace.msg("BeachScene.doTopViewDispatch removed:"+e.data.removed);
        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        var _data:Object=new Object();

        switch(e.data.removed)
        {
            case "Leave":
                gameEvent._name="clear_comcloud";
                gameEvent.displayHandler();
                _data.name="MainScene";
                command.sceneDispatch(SceneEvent.CHANGED,_data);
                break
            case "Rest":

                command.doRest(true);
                break
            case "ani_complete":

                command.showCommandValues(this,"FreeRest");

                break
            case "ani_complete_clear_character":
                command.clearCopyPixel();
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