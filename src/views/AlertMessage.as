package views
{
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;

import controller.FloxCommand;

import controller.FloxInterface;

import flash.geom.Point;

import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.Color;

import utils.DebugTrace;
import utils.ViewsContainer;

public class AlertMessage extends Sprite
{
    private var comfirm:Sprite=new Sprite();
    //private var alertframe:MovieClip;
    private var alertframe:Image;
    private var btn:Button;
    private var onClosed:Function;
    private var command:MainInterface=new MainCommand();
    private var font:String="SimImpact";
    private var msg:String="";
    private var quad:Quad;
    private var clickmouse:Sprite;
    public function AlertMessage(content:String,callback:Function=null,type:String=null):void
    {
        DebugTrace.msg("AlertMessage");
        onClosed=callback;
        comfirm=new Sprite();
        msg=content;
        switch(type){

            case "screen_type":
                initScreenType();
                break;
            case "nobutton_type":
                initNoButtonType();
                break
            default:
                initButtonType();
                break
        }

        var current_scene:Sprite=ViewsContainer.currentScene;
        current_scene.addEventListener("ALERT_DISABLE_TOUCHSCREEN",onDisableHandle);
        current_scene.addEventListener("ALERT_ENABLE_TOUCHSCREEN",onEnableHandle);


    }
    private function onDisableHandle(e:Event):void{

        DebugTrace.msg("AlertMessage.onDisableHandle");

        this.removeEventListener(TouchEvent.TOUCH,doCancelHandler);
    }
    private function onEnableHandle(e:Event):void{

        DebugTrace.msg("AlertMessage.onEnableHandle");
        this.addEventListener(TouchEvent.TOUCH,doCancelHandler);



    }
    private function initScreenType():void{

        var width:Number=Starling.current.stage.stageWidth;
        var height:Number=Starling.current.stage.stageHeight;
        quad= new Quad(width,height,Color.AQUA);
        quad.alpha=0;
        addChild(quad);


        var txt:TextField=new TextField(1024,80,msg);
        txt.format.setTo(font, 20);
        txt.format.color=0xFFFFFF;
        txt.x=-512;
        txt.y=290;

        clickmouse=new ClickMouseIcon();
        clickmouse.x=973;
        clickmouse.y=704;
        addChild(clickmouse);
        this.useHandCursor=true;
        this.addEventListener(TouchEvent.TOUCH,doCancelHandler);


    }
    private function doCancelHandler(e:TouchEvent):void{

        var began:Touch=e.getTouch(this,TouchPhase.BEGAN);
        if(began){
            this.removeEventListener(Event.TRIGGERED,doCancelHandler);
            this.removeFromParent(true);
            if(onClosed)
                onClosed();
        }



    }
    private function initNoButtonType():void{

        DebugTrace.msg("AlertMessage.initNoButtonType");

        var width:Number=Starling.current.stage.stageWidth;
        var height:Number=Starling.current.stage.stageHeight;
        quad= new Quad(width,height,Color.AQUA);
        quad.alpha=0;
        addChild(quad);


        var texture:Texture=Assets.getTexture("SceneMask");
        alertframe=new Image(texture);
        alertframe.pivotX=alertframe.width/2;
        alertframe.pivotY=alertframe.height/2;
        comfirm.addChild(alertframe);


        var txt:TextField=new TextField(785,80,msg);
        txt.format.setTo(font,20);
        txt.autoScale=true;
        txt.format.color=0xFFFFFF;
        txt.x=-512;
        txt.y=290;
        comfirm.addChild(txt);

        comfirm.x= Starling.current.stage.stageWidth/2;
        comfirm.y= Starling.current.stage.stageHeight/2;
        addChild(comfirm);


        clickmouse=new ClickMouseIcon();
        clickmouse.x=973;
        clickmouse.y=704;
        addChild(clickmouse);

        this.addEventListener(TouchEvent.TOUCH,doCancelHandler);



    }
    private function initButtonType():void{


        var texture:Texture=Assets.getTexture("SceneMask");
        alertframe=new Image(texture);
        alertframe.pivotX=alertframe.width/2;
        alertframe.pivotY=alertframe.height/2;



        var txt:TextField=new TextField(1024,80,msg);
        txt.format.setTo(font,20);
        txt.format.color=0xFFFFFF;
        txt.x=-512;
        txt.y=290;

        comfirm.addChild(alertframe);
        comfirm.addChild(txt);
        command.addedCancelButton(comfirm,onTouchAlertFrame,new Point(438,319));
        //comfirm.addChild(btn);
        comfirm.x= Starling.current.stage.stageWidth/2;
        comfirm.y= Starling.current.stage.stageHeight/2;
        addChild(comfirm);
        comfirm.alpha=0.5;
        var tween:Tween=new Tween(comfirm,0.5,Transitions.EASE_OUT_ELASTIC);
        tween.animate("alpha",1);
        tween.onComplete=onAlertMessageFadeIn;
        Starling.juggler.add(tween);

        //waving=Starling.current.nativeOverlay.getChildByName("waving") as MovieClip;

        var wavesloader:SWFLoader=LoaderMax.getLoader("waving") as SWFLoader;
        if(wavesloader)
            wavesloader.content.visible=false;
    }
    private function onAlertMessageFadeIn():void
    {
        //btn.visible=true;
        Starling.juggler.removeTweens(comfirm);



    }
    private function onTouchAlertFrame():void
    {
        DebugTrace.msg("AlertMessage.onTouchAlertFrame");
        //var target:Sprite=e.currentTarget as Sprite;
        //var BEGAN:Touch=e.getTouch(target,TouchPhase.BEGAN);
        //removeChild(comfirm);

        var flox:FloxInterface=new FloxCommand();
        var current_scene:String=flox.getSaveData("current_scene");
        if(current_scene=="MainScene"){
            var wavesloader:SWFLoader=LoaderMax.getLoader("waving") as SWFLoader;
            if(wavesloader)
                wavesloader.content.visible=true;
        }
        try{

            this.removeFromParent(true);

            if(onClosed)
                onClosed();


        }catch(error:Error)
        {
            DebugTrace.msg("AlertMessage.onTouchAlertFrame Error");
        }

    }

}
}