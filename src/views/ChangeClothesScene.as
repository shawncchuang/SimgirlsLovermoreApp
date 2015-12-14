/**
 * Created by shawnhuang on 15-11-03.
 */
package views {
import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneInterface;

import data.DataContainer;

import events.SceneEvent;

import model.Scenes;

import starling.animation.DelayedCall;

import starling.core.Starling;

import starling.display.Button;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;
import starling.utils.Color;

import utils.DebugTrace;

import utils.DrawManager;

import utils.ViewsContainer;

public class ChangeClothesScene extends Scenes {

    private var base_sprite:Sprite;
    private var drawcom:DrawerInterface=new DrawManager();
    private var flox:FloxInterface=new FloxCommand();
    //private var avatar:Object=new Object();
    private var gender:String="";
    private var basemodel:Sprite;
    private var rgbObj:Object=null;
    private var upperstyleIndex:Number=0;
    private var upperstyleMax:Number=0;
    private var lowerstyleIndex:Number=0;
    private var lowerstyleMax:Number=0;
    private var font:String = "SimImpact";
    private var upperStyleTxt:TextField;
    private var lowerStyleTxt:TextField;
    private var command:MainInterface=new MainCommand();

    private var upperstyles:Array=new Array();
    private var lowerstyles:Array=new Array();

    private var delay:DelayedCall;

    public function ChangeClothesScene() {
        ViewsContainer.chacaterdesignScene=this;
        ViewsContainer.baseSprite = this;
        base_sprite = new Sprite();
        addChild(base_sprite);

        init();

    }
    private function init():void{

        var bgImg:* = drawcom.drawBackground();
        var bgSprtie:Sprite = new Sprite();
        bgSprtie.addChild(bgImg);
        addChild(bgSprtie);


        var stageW:Number=Starling.current.stage.stageWidth;
        var quad:Quad=new Quad(stageW,45,0x000000);
        quad.alpha=0.4;
        quad.y=21;
        addChild(quad);

        var title:String="Change Clothes";
        var titleTxt:TextField=new TextField(300,45,title,font,30,0xFFFFFF);
        titleTxt.hAlign="left";
        titleTxt.x=10;
        titleTxt.y=21;
        addChild(titleTxt);

        var avatar:Object=flox.getSaveData("avatar");
        var _avatar:Object=new Object();
        for(var attr:String in avatar){
            _avatar[attr]=avatar[attr];
        }
        DataContainer.contanstAvatar=_avatar;
        DebugTrace.msg("ChangeClothesScence.init _avatar="+JSON.stringify(_avatar));
        upperstyles=_avatar.upperbody;
        lowerstyles=_avatar.lowerbody;
        gender=avatar.gender;
        upperstyleIndex= upperstyles.indexOf(String(_avatar.clothes));
        lowerstyleIndex=lowerstyles.indexOf(String(_avatar.pants));
        this.addEventListener(CharacterDesignScene.COLOR_UPDATE,onColorUpadeted);

        delay=new DelayedCall(onDelayCallComplete,1);
        Starling.juggler.add(delay);



    }

    private function onColorUpadeted(e:Event):void
    {
        //DebugTrace.msg("CharacterDesignScene.onColorUpadeted type:"+e.data.rgb);
        //var savedata:SaveGame=FloxCommand.savegame;
        rgbObj=e.data.rgb;
        var _type:String=e.data.type;
        if(_type=="Upperbody"){
            _type="Clothes";
        }else if(_type=="Lowerbody"){
            _type="Pants";
        }

        //var flox:FloxInterface=new FloxCommand();
        var current_avatar:Object=flox.getSaveData("avatar");
        var partmodel:Image=basemodel.getChildByName(_type) as Image;
        partmodel.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
        switch(e.data.type)
        {
            case "Upperbody":

                current_avatar.uppercolor=partmodel.color;
                break
            case "Lowerbody":
                current_avatar.lowercolor=partmodel.color;
                break

        }
        //switch
        flox.save("avatar",current_avatar);


        //drawcom.updateModelColor(e.data.type,rbgObj);

    }
    private function onDelayCallComplete():void{
        Starling.juggler.remove(delay);
        initBaseModel();
        initUpperbodyStyles();
        initLowerbodyStyles();
        initColorSwatches();
        initConfirm();
    }
    private function initBaseModel():void
    {
        if(basemodel)
        {
            removeChild(basemodel);
            basemodel=null;
        }

        if(gender=="Male")
        {
            basemodel=new Sprite();
            basemodel.x=380;
            basemodel.y=106;
            addChild(basemodel);

            var modelAttr:Object=new Object();
            modelAttr.gender=gender;
            modelAttr.width=276;
            modelAttr.height=661;

            drawcom.drawCharacter(basemodel,modelAttr);
            drawcom.updateBaseModel("Hair");
            drawcom.updateBaseModel("Eyes");
            drawcom.updateBaseModel("Pants");
            drawcom.updateBaseModel("Clothes");
            drawcom.updateBaseModel("Features");
        }
        else
        {

            basemodel=new Sprite();
            basemodel.x=372;
            basemodel.y=169;
            addChild(basemodel);

            modelAttr=new Object();
            modelAttr.gender=gender;
            modelAttr.width=262;
            modelAttr.height=613;
            drawcom.drawCharacter(basemodel,modelAttr);
            drawcom.updateBaseModel("Eyes");
            drawcom.updateBaseModel("Pants");
            drawcom.updateBaseModel("Clothes");
            drawcom.updateBaseModel("Hair");
        }

    }
    private function initUpperbodyStyles():void{

        upperstyles=flox.getSaveData("avatar").upperbody;

        var texture:Texture=getTexture(gender+"Clothes");
        var xml:XML=Assets.getAtalsXML(gender+"ClothesXML");
        //upperstyleMax=xml.SubTexture.length();
        upperstyleMax=upperstyles.length;

        var icons:Image=new Image(getTexture("UpperBodyIcon"));
        icons.x=30;
        icons.y=195;
        addChild(icons);
        var styleID:Number= Number(upperstyles[upperstyleIndex])+1;
        upperStyleTxt=new TextField(160,35,"Style "+styleID,font,30,0xFFFFFF,true);
        upperStyleTxt.x=88;
        upperStyleTxt.y=350;
        addChild(upperStyleTxt);

        var arrowleft:Button=new Button(getTexture("ArrowAlt"));
        arrowleft.name="prev";
        arrowleft.scaleX=-1;
        arrowleft.x=72.5;
        arrowleft.y=350;
        addChild(arrowleft);
        arrowleft.addEventListener(Event.TRIGGERED,doSelectUpperStyle);

        var arrowright:Button=new Button(getTexture("ArrowAlt"));
        arrowright.name="next";
        arrowright.x=262;
        arrowright.y=350;
        addChild(arrowright);
        arrowright.addEventListener(Event.TRIGGERED,doSelectUpperStyle);


    }
    private function doSelectUpperStyle(e:Event):void{

        var target:Button=e.currentTarget as Button;
        var dir:String=target.name;
        switch(dir){
            case "prev":
                upperstyleIndex--;
                if(upperstyleIndex<0)
                {
                    upperstyleIndex=0;
                }
                break
            case "next":
                upperstyleIndex++;
                if(upperstyleIndex>=upperstyleMax-1)
                {
                    upperstyleIndex=upperstyleMax-1;
                }
                break

        }
        var styleID:Number= Number(upperstyles[upperstyleIndex])+1;
        upperStyleTxt.text="Style "+styleID;
        updateSaveData();
        drawcom.updateBaseModel("UpperBodyStyle");
    }
    private function initLowerbodyStyles():void{

        lowerstyles=flox.getSaveData("avatar").lowerbody;

        var texture:Texture=getTexture(gender+"PantsStyle");
        var xml:XML=Assets.getAtalsXML(gender+"PantsStyleXML");
        //lowerstyleMax=xml.SubTexture.length();
        lowerstyleMax=lowerstyles.length;

        var icons:Image=new Image(getTexture("LowerBodyIcon"));
        icons.x=680;
        icons.y=195;
        addChild(icons);


        var styleID:Number=Number(lowerstyles[lowerstyleIndex])+1;
        lowerStyleTxt=new TextField(160,35,"Style "+styleID,font,30,0xFFFFFF,true);
        lowerStyleTxt.x=753;
        lowerStyleTxt.y=350;
        addChild(lowerStyleTxt);

        var arrowleft:Button=new Button(getTexture("ArrowAlt"));
        arrowleft.name="prev";
        arrowleft.scaleX=-1;
        arrowleft.x=737;
        arrowleft.y=350;
        addChild(arrowleft);
        arrowleft.addEventListener(Event.TRIGGERED,doSelectLowerStyle);

        var arrowright:Button=new Button(getTexture("ArrowAlt"));
        arrowright.name="next";
        arrowright.x=927;
        arrowright.y=350;
        addChild(arrowright);
        arrowright.addEventListener(Event.TRIGGERED,doSelectLowerStyle);



    }
    private function doSelectLowerStyle(e:Event):void{

        var target:Button=e.currentTarget as Button;
        var dir:String=target.name;
        switch(dir){
            case "prev":
                lowerstyleIndex--;
                if(lowerstyleIndex<0)
                {
                    lowerstyleIndex=0;
                }
                break
            case "next":
                lowerstyleIndex++;
                if(lowerstyleIndex>=lowerstyleMax-1)
                {
                    lowerstyleIndex=lowerstyleMax-1;
                }
                break

        }

        var styleID:Number=Number(lowerstyles[lowerstyleIndex])+1;
        lowerStyleTxt.text="Style "+styleID;
        updateSaveData();
        drawcom.updateBaseModel("LowerBodyStyle");


    }

    private function initColorSwatches():void
    {

        var upperbodyColors:ColorSwatches=new ColorSwatches("Upperbody");
        upperbodyColors.x=48.5;
        upperbodyColors.y=480.5;
        addChild(upperbodyColors);

        var lowerbodyColors:ColorSwatches=new ColorSwatches("Lowerbody");
        lowerbodyColors.x=710;
        lowerbodyColors.y=480.5;
        addChild(lowerbodyColors);



    }
    private function getTexture(src:String):Texture
    {

        var textture:Texture=Assets.getTexture(src);
        return textture;
    }

    private function updateSaveData():void
    {
        var current_avatar:Object=flox.getSaveData("avatar");

        current_avatar.clothes=Number(upperstyles[upperstyleIndex]);
        current_avatar.pants=lowerstyleIndex;
        flox.save("avatar",current_avatar);

    }
    private function initConfirm():void
    {

        var confirm:Button=new Button(getTexture("CheckAlt"));
        confirm.name="confirm";
        confirm.x=904;
        confirm.y=720;
        addChild(confirm);
        confirm.addEventListener(Event.TRIGGERED,doFinished);
        var cancel:Button=new Button(getTexture("XAlt"));
        cancel.name="cancel";
        cancel.x=964;
        cancel.y=720;
        addChild(cancel);
        cancel.addEventListener(Event.TRIGGERED,doFinished);

    }
    private function doFinished(e:Event):void{

        var target:Button=e.currentTarget as Button;
        var tap:String=target.name;
        var _data:Object=new Object();
        switch(tap){
            case "confirm":

                _data.name="ChangingRoomScene";
                command.sceneDispatch(SceneEvent.CHANGED,_data);

                break
            case "cancel":
//                var current_avatar:Object=flox.getSaveData("avatar");
//                DebugTrace.msg("ChangeClothesScence current="+JSON.stringify(current_avatar));
//
                var contanstAvatar:Object=DataContainer.contanstAvatar;
//                DebugTrace.msg("ChangeClothesScence contanstAvatar="+JSON.stringify(contanstAvatar));
                flox.save("avatar",contanstAvatar,onSaveChanfedComplete);
                break

        }


    }
    private function onSaveChanfedComplete():void{
        var _data:Object=new Object();
        _data.name="ChangingRoomScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }
}
}
