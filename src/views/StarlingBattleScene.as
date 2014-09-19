package views
{

import flash.geom.Point;
import controller.Assets;
import controller.AvatarCommand;
import controller.AvatarInterface;
import controller.MainCommand;
import controller.MainInterface;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;

import model.Scenes;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

import utils.DebugTrace;

import utils.ViewsContainer;

public class StarlingBattleScene extends Scenes
{



    private var base_sprite:Sprite;
    private var command:MainInterface=new MainCommand();
    private var button:Button;
    private var avatarcom:AvatarInterface=new AvatarCommand();
    public function StarlingBattleScene()
    {
        /*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
         button=new Button(pointbgTexture);
         addChild(button);
         button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/

        ViewsContainer.currentScene=this;
        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();

        initTeam();
    }

    private function initTeam():void
    {

        //ViewsContainer.AvatarShip=this;
        //var avatar_attr:Object={"name":"tmr","side":1,"pos":new Point(400,400)};
        //avatarcom.createAvatar(onReadyComplete,avatar_attr);


        var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvt._name="battle";
        gameEvt.displayHandler()
    }
    private function onReadyComplete():void
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
    private function onClearComplete():void
    {
        Starling.juggler.removeTweens(this);
        var _data:Object=new Object();
        _data.name= "MainScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }
}
}