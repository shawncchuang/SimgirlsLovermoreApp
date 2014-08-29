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

import model.SaveGame;
import model.Scenes;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;

import utils.DebugTrace;
import utils.ViewsContainer;

public class FitnessClubScene extends Scenes
{
    private var speaker_sprite:Sprite;
    private var command:MainInterface=new MainCommand();
    private var button:Button;
    private var scencom:SceneInterface=new SceneCommnad();
    private var flox:FloxInterface=new FloxCommand();

    private var ap_pay:Number;
    private var cash_pay:Number;
    //image return 5-10;
    private var image_re:Number;
    public function FitnessClubScene()
    {
        /*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
         button=new Button(pointbgTexture);
         addChild(button);
         button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
        ViewsContainer.currentScene=this;
        this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
        speaker_sprite=new Sprite();
        addChild(speaker_sprite);
        speaker_sprite.flatten();
        init();
    }
    private function init():void
    {

        scencom.init("FitnessClubScene",speaker_sprite,8,onCallback);
        scencom.start();
        scencom.disableAll();
    }
    private function onCallback():void
    {

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
        DebugTrace.msg("FitnessClubScene.doTopViewDispatch removed:"+e.data.removed);
        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        var savegame:SaveGame=FloxCommand.savegame;
        var _data:Object=new Object();

        switch(e.data.removed)
        {
            case "Leave":
                gameEvent._name="clear_comcloud";
                gameEvent.displayHandler();
                _data.name="MainScene";
                command.sceneDispatch(SceneEvent.CHANGED,_data);
                break
            case "Train":
                command.doTrain();

                break
            case "ani_complete":

                command.showCommandValues(this,"Train");
                init();
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