package views
{
import controller.FilterInterface;

import flash.events.TimerEvent;
import flash.utils.Timer;

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import events.SceneEvent;

import starling.animation.DelayedCall;

import starling.animation.Tween;
import starling.core.Starling;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;

import utils.DebugTrace;
import utils.FilterManager;
import utils.ViewsContainer;

import views.DatingScene;

public class KissScene extends Sprite
{
    private var heartView:Sprite;
    public static var UPDATE_MOOD:String="update_mood";
    public static var UPDATE_LOVE:String="update_love";
    public static var kissScene:Sprite;
    private var flox:FloxInterface=new FloxCommand();
    private var mood:Number=0;
    private var love:Number=0;
    private var bubble:Image;
    private var playtimes:uint=10;
    private var timer:Timer;
    private var cancelbtn:Button;
    private var command:MainInterface=new MainCommand();
    private var character:Image;
    private var delaycall:DelayedCall;
    public function KissScene()
    {

        this.addEventListener(KissScene.UPDATE_MOOD,onUpdateMood);
        this.addEventListener(KissScene.UPDATE_LOVE,onUpdateLove);
        KissScene.kissScene=this;
        initCharacter();
        initHearts();

    }
    private function onUpdateMood(e:Event):void
    {
        var lv:Number=e.data.lv;
        var dating:String=DataContainer.currentDating;
        var image:Number=Number(flox.getSaveData("image").player);
        var _image:Number=Math.floor(image/20);
        if(lv==4)
        {

            mood--;

        }
        else
        {
            mood+=lv;
        }
        mood=_image+mood;

    }
    private function onUpdateLove(e:Event):void
    {
        var lv:Number=e.data.lv;

        if(lv==4)
        {

            love-=10;

        }
        else
        {
            love+=(lv*10);

            characterFilter();
        }

    }
    private function initCharacter():void
    {

        var dating:String=DataContainer.currentDating;
        var chTexture:Texture=Assets.getTexture(dating+"Kiss");
        character=new Image(chTexture);
        character.x=Math.floor(Starling.current.stage.stageWidth/2-character.width/2);
        addChild(character);
    }
    private function characterFilter():void{


        var filter:FilterInterface=new FilterManager();
        filter.setSource(character);
        filter.startFlash();

    }
    private function initHearts():void
    {
        heartView=new Sprite();
        addChild(heartView);

        timer=new Timer(1000,playtimes);
        timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
        timer.start();

        var tween:Tween=new Tween(this,1);
        tween.repeatDelay=0.5;
        tween.repeatCount=20;
        tween.onUpdate=doShowHearts;
        //tween.onComplete=doShowHearts;
        Starling.juggler.add(tween);
    }
    private function doShowHearts():void
    {

        var heart:HeartParticle=new HeartParticle();
        heartView.addChild(heart);


    }
    private function onTimeOut(e:TimerEvent):void
    {

        timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
        timer.stop();

        DebugTrace.msg("FlirtScene.onTimeOut love:"+love);
        clearHeartView();

        //initBubble();

        var tween:Tween=new Tween(this,1);
        tween.delay=0.5;
        tween.onComplete=onReadyToUpdatLove;
        Starling.juggler.add(tween);

    }
    private function onReadyToUpdatLove():void
    {


        Starling.juggler.removeTweens(this);
        var _data:Object=new Object();
        _data.com="KissLove";
        _data.love=love;
        var base_sprite:Sprite=ViewsContainer.baseSprite;
        base_sprite.dispatchEventWith(DatingScene.COMMIT,false,_data);

        delaycall=new DelayedCall(onUpdateComplete,1);
        Starling.juggler.add(delaycall);
    }
    private function onUpdateComplete():void{
        Starling.juggler.remove(delaycall);
        initCancelHandle();
    }
    private function initBubble():void
    {

        var bubbleTextue:Texture=Assets.getTexture("Bubble");
        bubble=new Image(bubbleTextue);
        bubble.smoothing=TextureSmoothing.TRILINEAR;
        bubble.pivotX=bubble.width/2;
        bubble.pivotY=bubble.height/2;
        bubble.x=768;
        bubble.y=260;
        bubble.scaleX=-1;
        addChild(bubble);
        var chat:String="Bye.";
        var chatTxt:TextField=new TextField(255,190,chat,"SimFutura",20,0x000000);
        chatTxt.hAlign="center";
        chatTxt.x=634;
        chatTxt.y=110;
        addChild(chatTxt);

    }
    private function initCancelHandle():void
    {
        //cancel button

        command.addedCancelButton(this,doCancelAssetesForm);

    }
    private function doCancelAssetesForm():void
    {

        timer.stop();
        timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
        clearHeartView();

        var _data:Object=new Object();
        _data.name=DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }
    private function clearHeartView():void
    {
        Starling.juggler.remove(delaycall);
        Starling.juggler.removeTweens(this);
        heartView.removeFromParent(true);

    }
}
}