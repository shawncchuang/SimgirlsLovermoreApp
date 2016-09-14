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

import services.LoaderRequest;

import starling.animation.Juggler;

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
    public static var iconsname:Array=["ProfileScene","ContactsScene","CalendarScene","PhotosScene","MessagingScene","SettingsScene"];
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
    private var shilfies:Image;
    private var precioursmoments:Image;
    private var options:Array=new Array();
    private var optionTxts:Array=new Array();

    private var fwTxt:TextField;
    private var tweenId:uint;
    public function MenuScene()
    {

        base_sprite=new Sprite();
        addChild(base_sprite);

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
        centeframeTween.delay=0.3;
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
        network.addEventListener(TouchEvent.TOUCH,doEnanbleMenuHandler);


        /*
         titleIcon=new Image(getTexture("IconMenuTitle"));
         titleIcon.pivotX=titleIcon.width/2;
         titleIcon.pivotY=titleIcon.height/2;
         titleIcon.x=114
         titleIcon.y=117;
         addChild(titleIcon);
         */

        tween=new Tween(network,0.3,Transitions.EASE_IN_OUT_BACK);
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


        for(var j:uint=0;j<options.length;j++) {

            var optionIcon:Image = options[j];
            var optionTxt:TextField=optionTxts[j] as TextField;


            optionTxt.removeFromParent(true);
            optionIcon.removeFromParent(true);

        }
        options=new Array();
        optionTxts=new Array();

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

            var textlabel:TextField=new TextField(200,40,labelsName[i]);
            textlabel.format.setTo(font,35,0x292929,"left");
            textlabel.alpha=0;
            textlabel.autoSize=TextFieldAutoSize.HORIZONTAL;
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
        delayCall.delay=0.2;
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

        fwTxt=new TextField(100,30,"Freedom Wall");
        fwTxt.format.setTo(font,30,0x292929);
        fwTxt.autoScale=true;
        fwTxt.x=network.x-(network.width/2);
        fwTxt.y=network.y+(network.height/2)+3;
        fwTxt.alpha=0;
        addChild(fwTxt);

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

                if(click_type=="PhotosScene"){
                    //add photo options
                    initPhotosOptoins();
                }
                else{
                    doFadeoutTransatoin();

                }

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
        Starling.juggler.removeTweens(network);
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

        centerframe.removeFromParent(true);
        templete.removeFromParent(true);

        var  gameinfo:Sprite=ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("DISPLAY");


        DebugTrace.msg("MenuScene.onFadeoutComplete click_type="+click_type);

        if(click_type=="Cancel")
        {
            click_type=DataContainer.currentScene;
            gameinfo.dispatchEventWith("UPDATE_PROFILE");

        }


        var _data:Object=new Object();
        _data.name=click_type;
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function initPhotosOptoins():void{

        options=new Array();
        optionTxts=new Array();

        for(var i:uint=0;i<iconsname.length;i++) {
            var iconimg:Image = iconsimg[i];
            iconimg.removeEventListener(TouchEvent.TOUCH,doTouchIconHandler);
            var icon_tween:Tween=new Tween(iconimg,0.5,Transitions.EASE_IN_OUT_BACK);
            icon_tween.scaleTo(0.5);
            icon_tween.fadeTo(0.5);
            Starling.juggler.add(icon_tween);
            iconsLabelList[i].alpha=0.1;

        }


        var shilfiesTexture:Texture=Assets.getTexture("SelfiesIcon");
        shilfies=new Image(shilfiesTexture);
        shilfies.useHandCursor=true;
        shilfies.name="PhotosScene";
        shilfies.pivotX=shilfies.width/2;
        shilfies.pivotY=shilfies.height/2;
        shilfies.x=597;
        shilfies.y=570;
        shilfies.scaleX=0.2;
        shilfies.scaleY=0.2;
        var shTxt:TextField=new TextField(100,40,"Selfies");
        shTxt.format.setTo(font,30,0x292929);
        shTxt.pivotX=shTxt.width/2;
        shTxt.name="Label-"+shilfies.name;
        shTxt.x=shilfies.x;
        shTxt.y=shilfies.y;
        shTxt.alpha=0;
        //shTxt.y=640;

        optionTxts.push(shTxt);
        options.push(shilfies);

        var pmTexture:Texture=Assets.getTexture("PrecriousIcon");
        precioursmoments=new Image(pmTexture);
        precioursmoments.useHandCursor=true;
        precioursmoments.name="PreciousPhotosScene";
        precioursmoments.pivotX=precioursmoments.width/2;
        precioursmoments.pivotY=precioursmoments.height/2;
        precioursmoments.x=748;
        precioursmoments.y=570;
        precioursmoments.scaleX=0.2;
        precioursmoments.scaleY=0.2;

        var pmTxt:TextField=new TextField(300,40,"Precious Moments");
        pmTxt.format.setTo(font,30,0x292929);
        pmTxt.pivotX=pmTxt.width/2;
        pmTxt.name="Label-"+precioursmoments.name;
        pmTxt.x=precioursmoments.x;
        pmTxt.y=precioursmoments.y;
        pmTxt.alpha=0;
        //pmTxt.y=640;

        addChild(pmTxt);
        addChild(shTxt);

        addChild(shilfies);
        addChild(precioursmoments);

        optionTxts.push(pmTxt);
        options.push(precioursmoments);


        for(var j:uint=0;j<options.length;j++){

            var optionIcon:Image=options[j];
            var tween:Tween=new Tween(optionIcon,0.3,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(0.9);
            tween.onComplete=onOptionsFadein;
            Starling.juggler.add(tween);

            optionIcon.addEventListener(TouchEvent.TOUCH,doTouchOptionsHandler);

        }
        network.addEventListener(TouchEvent.TOUCH,doEnanbleMenuHandler);


    }
    private function doEnanbleMenuHandler(e:TouchEvent):void{

        var target:Image=e.currentTarget as Image;
        var began:Touch= e.getTouch(target, TouchPhase.BEGAN);
        var hover:Touch= e.getTouch(target,TouchPhase.HOVER);
        if(hover){

            if(fwTxt)
            fwTxt.alpha=1;

        }else{
            if(fwTxt)
            fwTxt.alpha=0;
        }

        if(began){

            onTranstionToMenuScene();
            onIconsComplete();

            var req:LoaderRequest=new LoaderRequest();
            var url:String="http://www.freedomwall.info";
            req.navigateToURLHandler(url);

            //network.removeEventListener(TouchEvent.TOUCH,doEnanbleMenuHandler);
        }

    }
    private function onTranstionToMenuScene():void{

        for(var i:uint=0;i<iconsname.length;i++) {
            var iconimg:Image = iconsimg[i];

            var icon_tween:Tween=new Tween(iconimg,0.5,Transitions.EASE_IN_OUT_BACK);
            icon_tween.scaleTo(1);
            icon_tween.fadeTo(1);
            Starling.juggler.add(icon_tween);
            iconsLabelList[i].alpha=1;

        }
        for(var j:uint=0;j<options.length;j++) {

            var optionIcon:Image = options[j];
            var optionTxt:TextField=optionTxts[j] as TextField;

            optionIcon.removeEventListener(TouchEvent.TOUCH,doTouchOptionsHandler);
            Starling.juggler.removeTweens(optionIcon);


            optionTxt.removeFromParent(true);
            optionIcon.removeFromParent(true);

        }



    }
    private function onOptionsFadein():void{

        Starling.juggler.removeTweens(shilfies);
        Starling.juggler.removeTweens(precioursmoments);

    }

    private function doTouchOptionsHandler(e:TouchEvent):void{

        var target:Image=e.currentTarget as Image;
        var hovor:Touch = e.getTouch(target, TouchPhase.HOVER);
        var began:Touch= e.getTouch(target, TouchPhase.BEGAN);


        var optionTween:Tween;
        var labelTween:Tween;

        var optionName:String=target.name;
        var labelTxt:TextField=this.getChildByName("Label-"+optionName) as TextField;

        if(hovor){

            optionTween=new Tween(target,0.1,Transitions.EASE_IN_OUT_BACK);
            optionTween.scaleTo(1);
            Starling.juggler.add(optionTween);


            labelTween=new Tween(labelTxt,0.1,Transitions.EASE_IN_OUT_BACK);
            labelTween.animate("y",640);
            labelTween.fadeTo(1);
            Starling.juggler.add(labelTween);
        }else
        {
            Starling.juggler.removeTweens(target);
            Starling.juggler.removeTweens(labelTxt);


            optionTween=new Tween(target,0.1,Transitions.EASE_IN_OUT_BACK);
            optionTween.scaleTo(0.8);
            Starling.juggler.add(optionTween);


            labelTween=new Tween(labelTxt,0.1,Transitions.EASE_IN_OUT_BACK);
            labelTween.animate("y",target.y);
            labelTween.fadeTo(0);
            Starling.juggler.add(labelTween);

        }

        if(began){

            Starling.juggler.removeTweens(target);
            Starling.juggler.removeTweens(labelTxt);

            click_type=target.name;
            optionIconsFadeout();

        }

    }
    private function optionIconsFadeout():void
    {


        for(var j:uint=0;j<options.length;j++) {

            var optionIcon:Image = options[j];
            var optionTxt:TextField=optionTxts[j] as TextField;

            var tween:Tween = new Tween(optionIcon, 0.5, Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(0.1);
            tween.fadeTo(0);
            tween.onComplete = onOptionsFadeoutComplete;
            Starling.juggler.add(tween);

            optionTxt.removeFromParent(true);
        }


    }
    private function onOptionsFadeoutComplete():void{

        for(var j:uint=0;j<options.length;j++) {

            var optionIcon:Image = options[j];
            Starling.juggler.removeTweens(optionIcon);
            optionIcon.removeFromParent(true);
        }

        doFadeoutTransatoin();
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