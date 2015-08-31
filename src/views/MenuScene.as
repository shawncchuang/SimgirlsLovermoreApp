package views
{
import flash.geom.Point;

import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;
import events.SceneEvent;
import model.Scenes;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.text.TextFieldAutoSize;
import starling.textures.TextureSmoothing;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class MenuScene extends Scenes
{
    private var scencom:SceneInterface=new SceneCommnad();
    private var base_sprite:Sprite;
    private var network:Image;
    private var tween:Tween;
    //profile,contacts,calendar,photos,mail,option
    public static var iconsname:Array=["ProfileScene","ContactsScene","CalendarScene","PhotosScene","Mail","SettingsScene"];
    private var icons:Array=[new Point(422,278),new Point(344,426),new Point(427,572),
        new Point(596,570),new Point(682,435),new Point(595,280)];

    public static var labelsName:Array=["PROFILE","CONTACTS","CALENDAR","PHOTOS","MESSAGING","SETTINGS"];
    private var iconsLabel:Array=[new Point(257,186),new Point(101,408),new Point(216,640),
        new Point(636,640),new Point(760,408),new Point(676,187)];

    private var iconsimg:Array=new Array();
    private var command:MainInterface=new MainCommand();
    private var click_type:String="";
    private var font:String="SimMyriadPro";
    private var titlebar:Sprite;
    private var centerframe:Image;
    private var titleIcon:Image;
    private var templete:MenuTemplate;
    private var iconsLabelList:Array=new Array();
    public function MenuScene()
    {


        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();
        initLayout();
    }
    private function initLayout():void
    {

        scencom.init("MenuScene",base_sprite,20,onCallback);
        //scencom.start();
        //scencom.disableAll();

        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="MENU";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-360,151),to:new Point(-178,151)},
            {from:new Point(1385,151),to:new Point(1204,151)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();
        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(114,117),to:new Point(114,117)});
        addChild(templete);



        centerframe=new Image(getTexture("MenuCenterFrame"));
        centerframe.pivotX=centerframe.width/2;
        centerframe.pivotY=centerframe.height/2;
        centerframe.x=513;
        centerframe.y=426;
        centerframe.alpha=0;
        addChild(centerframe);
        var centeframeTween:Tween=new Tween(centerframe,0.2,Transitions.EASE_IN_OUT_BACK);
        centeframeTween.delay=1;
        centeframeTween.animate("alpha",1);
        Starling.juggler.add(centeframeTween);




        network=new Image(getTexture("IconNetwork"));
        network.useHandCursor=true;
        network.pivotX=network.width/2;
        network.pivotY=network.height/2;
        network.x=513;
        network.y=900;
        network.scaleX=0.1;
        network.scaleY=0.1;
        network.alpha=0;
        addChild(network);

        /*
         titleIcon=new Image(getTexture("IconMenuTitle"));
         titleIcon.pivotX=titleIcon.width/2;
         titleIcon.pivotY=titleIcon.height/2;
         titleIcon.x=114
         titleIcon.y=117;
         addChild(titleIcon);
         */

        tween=new Tween(network,1,Transitions.EASE_IN_OUT_BACK);
        tween.scaleTo(1);
        tween.animate("y",428);
        tween.animate("alpha",1);
        tween.onComplete=onNetworkComplete;
        Starling.juggler.add(tween);



        //cancel button
        //command.addedCancelButton(this,doCannelHandler);
        /*
         var cancel:Button=new Button(getTexture("IconPrevBtn"));
         cancel.name="cancel";
         cancel.x=16;
         cancel.y=678;
         addChild(cancel);
         cancel.addEventListener(Event.TRIGGERED,doCannelHandler);
         */

    }

    private function doCannelHandler(e:Event):void
    {

        click_type="Cancel";
        DebugTrace.msg("MenuScene.doCencaleHandler click_type:"+click_type);

        var infobar:Sprite=ViewsContainer.gameinfo;
        infobar.dispatchEventWith("DRAW_PROFILE");

        doFadeoutTransatoin();



    }
    private function onNetworkComplete():void
    {
        Starling.juggler.remove(tween);
        //network.addEventListener(TouchEvent.TOUCH,doTouchIconHandler);
        initFadeinIcons();

    }

    private function initFadeinIcons():void
    {


        for(var i:uint=0;i<iconsname.length;i++)
        {

            var texture:Texture=Assets.getTexture("Icon"+iconsname[i]);
            //DebugTrace.msg("MenuScene.initFadeinIcons icon name:"+"Icon"+iconsname[i])
            var iconimg:Image=new Image(texture);
            iconimg.smoothing=TextureSmoothing.TRILINEAR;
            iconimg.name=iconsname[i];
            iconimg.useHandCursor=true;
            iconimg.pivotX=iconimg.width/2;
            iconimg.pivotY=iconimg.height/2;
            iconimg.x=network.x;
            iconimg.y=network.y;
            iconimg.scaleX=0.5;
            iconimg.scaleY=0.5;
            iconimg.alpha=0;
            addChild(iconimg);
            iconsimg.push(iconimg);

            var textlabel:TextField=new TextField(200,40,labelsName[i],font,35,0x292929,false);
            textlabel.alpha=0;
            textlabel.autoSize=TextFieldAutoSize.HORIZONTAL;
            textlabel.hAlign="left";
            textlabel.x=iconsLabel[i].x;
            textlabel.y=iconsLabel[i].y;
            addChild(textlabel);
            iconsLabelList.push(textlabel);
            //iconimg.addEventListener(TouchEvent.TOUCH,doTouchIconHandler);
        }
        //for
        for(var j:uint=0;j<iconsimg.length;j++)
        {

            var tween:Tween=new Tween(iconsimg[j],0.5,Transitions.EASE_IN_OUT_BACK);
            //tween.delay=j;
            tween.moveTo(icons[j].x,icons[j].y);
            tween.animate("alpha",1);
            tween.scaleTo(1);
            Starling.juggler.add(tween);

            var labelTween:Tween=new Tween(iconsLabelList[j],0.5);
            labelTween.animate("alpha",1);
            Starling.juggler.add(labelTween);
        }
        //for
        var delayCall:Tween=new Tween(this,0.5);
        delayCall.delay=0.5;
        delayCall.onComplete=onIconsComplete;
        Starling.juggler.add(delayCall);
    }
    private function onIconsComplete():void
    {
        Starling.juggler.removeTweens(this);
        for(var i:int=0;i<iconsimg.length;i++)
        {

            var iconimg:Image=iconsimg[i];
            iconimg.addEventListener(TouchEvent.TOUCH,doTouchIconHandler);
        }

    }
    private function doTouchIconHandler(e:TouchEvent):void
    {

        var target:Image=e.currentTarget as Image;
        var hovor:Touch = e.getTouch(target, TouchPhase.HOVER);
        var began:Touch= e.getTouch(target, TouchPhase.BEGAN);
        var tween:Tween;
        if(hovor)
        {
            tween=new Tween(target,0.2,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(1.3);
            Starling.juggler.add(tween);
        }
        else
        {
            Starling.juggler.removeTweens(target);
            tween=new Tween(target,0.2,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(1);
            Starling.juggler.add(tween);
        }
        if(began)
        {
            click_type=target.name;

            if(click_type.indexOf("Scene")!=-1){
                doFadeoutTransatoin();
            }


        }
    }

    private function doFadeoutTransatoin():void
    {



        for(var i:uint=0;i<iconsname.length;i++)
        {

            var iconimg:Image=iconsimg[i];
            var tween:Tween=new Tween(iconimg,0.2,Transitions.EASE_IN_OUT_BACK);
            tween.moveTo(network.x,network.y);
            tween.animate("alpha",0);
            Starling.juggler.add(tween);

            var titleIconTween:Tween=new Tween(titleIcon,0.2);
            titleIconTween.moveTo(network.x,network.y);
            titleIconTween.scaleTo(0.1);
            titleIconTween.animate("alpha",0);
            Starling.juggler.add(titleIconTween);

            try
            {
                iconimg.removeEventListener(TouchEvent.TOUCH,doTouchIconHandler);
            }
            catch(error:Error)
            {

                trace("MenuScene error remove iconimg");
            }


        }

        var network_tween:Tween=new Tween(network,0.2,Transitions.EASE_IN_OUT_BACK);
        network_tween.delay=0.2;
        network_tween.scaleTo(0.1);
        network_tween.animate("y",900);
        network_tween.animate("alpha",0);
        network_tween.onComplete=onNetworkFadeout;
        Starling.juggler.add(network_tween);


    }
    private function onNetworkFadeout():void
    {

        for(var i:uint=0;i<iconsname.length;i++)
        {
            var iconimg:Image=iconsimg[i];

            try{
                iconimg.removeFromParent(true);
                Starling.juggler.removeTweens(iconimg);
            }catch(error:Error){
                DebugTrace.msg("MenuScene.onNetworkFadeout remove iconimg catch Error");
            }

            var iconlabels:TextField=iconsLabelList[i];
            if(iconlabels)
            iconlabels.removeFromParent(true);
        }
        Starling.juggler.removeTweens(network);
        network.removeFromParent(true);


        var _data:Object=new Object();
        _data.pos={x:0,y:0};
        templete.dispatchEventWith(MenuTemplate.EFFECT_TITLEICON_FADEOUT,false,_data);
        templete.dispatchEventWith(MenuTemplate.EFFECT_TITLEBAR_FADEOUT);


        var cfTween:Tween=new Tween(centerframe,0.2);
        cfTween.animate("alpha",0);
        cfTween.onComplete=onFadeoutComplete;
        Starling.juggler.add(cfTween);


        templete.dispatchEventWith(MenuTemplate.EFFECT_BG_FADEOUT)


    }
    private function onFadeoutComplete():void{

        Starling.juggler.removeTweens(centerframe);

        var  gameinfo:Sprite=ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("DISPLAY");


        DebugTrace.msg("MenuScene.onFadeoutComplete click_type="+click_type);

        if(click_type=="Cancel")
        {
            click_type=DataContainer.currentScene;
            gameinfo.dispatchEventWith("UPDATE_DATING");

        }
        var _data:Object=new Object();
        _data.name=click_type;
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function onCallback():void
    {

    }
    private function getTexture(src:String):Texture
    {
        var textture:Texture=Assets.getTexture(src);
        return textture;
    }
}
}