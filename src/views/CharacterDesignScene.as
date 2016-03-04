package views
{


import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;

import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import events.SceneEvent;
import events.TopViewEvent;

import model.SaveGame;
import model.Scenes;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;
import starling.utils.Color;


import utils.DebugTrace;
import utils.DrawManager;
import utils.ViewsContainer;

public class CharacterDesignScene extends Scenes
{
    public static var COLOR_UPDATE:String="color_update";
    private var base_sprite:Sprite;
    private var command:MainInterface=new MainCommand();
    private var scencom:SceneInterface=new SceneCommnad();
    private var flox:FloxInterface=new FloxCommand();
    private var haircolor:ColorSwatches;
    private var maleImg:Button;
    private var femaleImg:Button;
    private var malefilter:MovieClip;
    private var femalefilter:MovieClip;
    private var hairlist:MovieClip;
    private var gender:String="Male";
    private var fake_head:Image;
    private var hair:Image;
    private var hairStytleAtlas:TextureAtlas ;
    private var eyes:Image;
    private var hairIndex:Number=0;
    private var hairTexture:Texture;
    private var hairdemo:Sprite;
    private var featuresdemo:Sprite;
    private var hairstyleMax:Number;
    private var body:MovieClip;
    private var rgbObj:Object=null;
    private var basemodel:Sprite;
    private var featuresMax:Number;
    private var featuresIndex:Number=0;
    private var drawcom:DrawerInterface=new DrawManager();
    public function CharacterDesignScene()
    {



        ViewsContainer.chacaterdesignScene=this;
        this.addEventListener(CharacterDesignScene.COLOR_UPDATE,onColorUpadeted);


        base_sprite=new Sprite();
        addChild(base_sprite);


        initLayout();
        initGender();
        initColorSwatches();
        initBaseModel();
        initHairStyle();
        initFeatures();

        initConfirm();

    }
    private function onColorUpadeted(e:Event):void
    {
        //DebugTrace.msg("CharacterDesignScene.onColorUpadeted type:"+e.data.rgb);
        //var savedata:SaveGame=FloxCommand.savegame;
        rgbObj=e.data.rgb;

        var flox:FloxInterface=new FloxCommand();
        var avatar:Object=flox.getSaveData("avatar");
        var partmodel:Image=basemodel.getChildByName(e.data.type) as Image;
        partmodel.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
        switch(e.data.type)
        {

            case "Hair":
                //hair.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
                avatar.haircolor=partmodel.color;
                break
            case "Skin":
                //body.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
                avatar.skincolor=partmodel.color;
                break
            case "Eyes":
                //eyes.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
                avatar.eyescolor=partmodel.color;
                break


        }
        //switch
        flox.save("avatar",avatar);



        //drawcom.updateModelColor(e.data.type,rbgObj);

    }
    private function initLayout():void
    {

        scencom.init("CharacterDesignScene",base_sprite,16,onCallback);
        scencom.start();
        //scencom.disableAll();


        var title:Image=new Image(getTexture("DesignAvatarTitle"));
        title.y=21;
        addChild(title);


        var LeftFrame:Image=new Image(getTexture("DesignAvatarLeft"));
        LeftFrame.x=16;
        LeftFrame.y=124;
        addChild(LeftFrame);

        var RightFrame:Image=new Image(getTexture("DesignAvatarRight"));
        RightFrame.x=698;
        RightFrame.y=124;
        addChild(RightFrame);

    }
    private function initGender():void
    {
        //maleImg=new Image(getTexture("MaleIcon"));
        maleImg=new Button(getTexture("MaleIcon"));
        maleImg.name="Male";
        maleImg.x=93.5;
        maleImg.y=202.5;
        maleImg.addEventListener(Event.TRIGGERED,doTriggeredSex);

        //femaleImg=new Image(getTexture("FemaleIcon"));
        femaleImg=new Button(getTexture("FemaleIcon"));
        femaleImg.name="Female";
        femaleImg.x=193.5;
        femaleImg.y=202.5;
        femaleImg.addEventListener(Event.TRIGGERED,doTriggeredSex);

        addChild(maleImg);
        addChild(femaleImg);


        malefilter=Assets.getDynamicAtlas("FrameFilterSex");
        malefilter.fps=30
        malefilter.x=95-maleImg.width;
        malefilter.y=209-maleImg.height;

        addChild(malefilter);
        Starling.juggler.add(malefilter);

        femalefilter=Assets.getDynamicAtlas("FrameFilterSex");
        femalefilter.fps=30;
        femalefilter.x=195-femaleImg.width;
        femalefilter.y=209-femaleImg.height;

        addChild(femalefilter);
        Starling.juggler.add(femalefilter);

        malefilter.visible=false;
        femalefilter.visible=false;
    }
    private function doTriggeredSex(e:Event):void
    {
        //change gender
        hairIndex=0;
        featuresIndex=0;

        var target:Button=e.currentTarget as Button;
        gender=target.name;
        if(gender=="Male")
        {
            malefilter.visible=true;
            femalefilter.visible=false;
        }
        else
        {
            malefilter.visible=false;
            femalefilter.visible=true;
        }
        DebugTrace.msg("CharacterDesignScene.doTriggeredSex gender:"+gender);

        updateSaveData();
        initBaseModel();
        drawcom.updateBaseModel("HairStyle");
        addHairSytleDemo();
        addFeatures();
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

    private function initHairStyle():void
    {


        var fake_head_texture:Texture=getTexture("FakeHead");
        fake_head=new Image(fake_head_texture);
        fake_head.x=90.5;
        fake_head.y=290;
        addChild(fake_head);

        addHairSytleDemo();

        var arrowleft:Button=new Button(getTexture("ArrowAlt"));
        arrowleft.name="prev";
        arrowleft.scaleX=-1;
        arrowleft.x=72.5;
        arrowleft.y=350;
        addChild(arrowleft);
        arrowleft.addEventListener(Event.TRIGGERED,doSelectHairStyle);

        var arrowright:Button=new Button(getTexture("ArrowAlt"));
        arrowright.name="next";
        arrowright.x=262;
        arrowright.y=350;
        addChild(arrowright);
        arrowright.addEventListener(Event.TRIGGERED,doSelectHairStyle);
    }
    private function addHairSytleDemo():void
    {
        if(hairdemo)
        {
            hairdemo.removeFromParent();
            hairdemo=null;
        }
        hairdemo=new Sprite();

        var texture:Texture=getTexture(gender+"HairStyle");
        var xml:XML=Assets.getAtalsXML(gender+"HairStyleXML");
        hairstyleMax=xml.SubTexture.length();
        DebugTrace.msg("CharacterDesignScene.addHairSytleDemo hairstyleMax:"+hairstyleMax);
        hairStytleAtlas = new TextureAtlas(texture, xml);
        hairTexture=hairStytleAtlas.getTexture("hair"+hairIndex);
        var hairImg:Image=new Image(hairTexture);
        hairImg.name="HairDemo";

        if(gender=="Male")
        {
            //hairdemo.clipRect=new flash.geom.Rectangle(0,0,153,163);
            hairdemo.mask=new Quad(153,163);
            hairdemo.x=100;
            hairdemo.y=276;
            hairImg.width=130;
            hairImg.height=204;

        }else
        {
            //hairdemo.clipRect=new flash.geom.Rectangle(0,0,153,153);
            hairdemo.mask=new Quad(153,153);
            hairdemo.x=77;
            hairdemo.y=286;

//            var copy_sprite:Sprite=new Sprite();
//            copy_sprite.addChild(hairImg);

//            var properties:Object=new Object();
//            properties.transparent=true;
//            properties.bgcolor=0x000000;
//            drawcom.setBitmapPorperties(properties);

           //copy_sprite.removeFromParent();


        }
        hairdemo.addChild(hairImg);
        addChild(hairdemo);
        DebugTrace.msg("CharacterDesignScene.addHairSytleDemo haircolor:"+haircolor+" ; hairdemo:"+hairdemo);




    }
    private function doSelectHairStyle(e:Event):void
    {

        var target:Button=e.currentTarget as Button;
        var dir:String=target.name;
        if(dir=="prev")
        {
            hairIndex--;
            if(hairIndex<0)
            {
                hairIndex=0;
            }
        }
        else
        {
            hairIndex++;
            if(hairIndex>=hairstyleMax-1)
            {
                hairIndex=hairstyleMax-1;
            }
        }

        updateSaveData();

        /*hairTexture=hairStytleAtlas.getTexture("hair"+hairIndex);
         var hair_privew:Image=hairdemo.getChildByName("HairDemo") as Image;
         hair_privew.texture=hairTexture;*/
        addHairSytleDemo();
        drawcom.updateBaseModel("HairStyle");
    }

    private function initColorSwatches():void
    {

        haircolor=new ColorSwatches("Hair");
        haircolor.x=48.5;
        haircolor.y=480.5;
        addChild(haircolor);

        var skincolor:ColorSwatches=new ColorSwatches("Skin");
        skincolor.x=729.5;
        skincolor.y=205.5;
        addChild(skincolor);

        var eysecolor:ColorSwatches=new ColorSwatches("Eyes");
        eysecolor.x=729.5;
        eysecolor.y=290.5;
        addChild(eysecolor);

    }
    private function initFeatures():void
    {

        var fake_head_texture:Texture=getTexture("FakeHead");
        var fake_head:Image=new Image(fake_head_texture);
        fake_head.x=776;
        fake_head.y=421;
        addChild(fake_head);

        addFeatures();


        var arrowleft:Button=new Button(getTexture("ArrowAlt"));
        arrowleft.name="prev";
        arrowleft.scaleX=-1;
        arrowleft.x=756;
        arrowleft.y=479.5;
        addChild(arrowleft);
        arrowleft.addEventListener(Event.TRIGGERED,doSelectFeatures);

        var arrowright:Button=new Button(getTexture("ArrowAlt"));
        arrowright.name="next";
        arrowright.x=945.5;
        arrowright.y=479.5;
        addChild(arrowright);
        arrowright.addEventListener(Event.TRIGGERED,doSelectFeatures);

    }
    private function addFeatures():void
    {
        if(featuresdemo)
        {
            featuresdemo.removeFromParent();
            featuresdemo=null;
        }
        if(gender=="Male")
        {
            featuresdemo=new Sprite();
            var texture:Texture=getTexture(gender+"Features");
            var xml:XML=Assets.getAtalsXML(gender+"FeaturesXML");
            featuresMax=xml.SubTexture.length();
            DebugTrace.msg("CharacterDesignScene.addFeatures featuresMax:"+featuresMax)
            var featuresAtlas:TextureAtlas = new TextureAtlas(texture, xml);
            var feateursTexture:Texture=featuresAtlas.getTexture("features"+featuresIndex);
            var featuresImg:Image=new Image(feateursTexture);
            featuresImg.name="FeaturesDemo";
            featuresdemo.x=795;
            featuresdemo.y=440;
            featuresImg.width=113;
            featuresImg.height=123;
            featuresdemo.addChild(featuresImg);
            addChild(featuresdemo);
            updateSaveData();
            drawcom.updateBaseModel("FeaturesStyle");
        }

    }
    private function doSelectFeatures(e:Event):void
    {
        var target:Button=e.currentTarget as Button;
        if(target.name=="prev")
        {

            featuresIndex--;
            if(featuresIndex<0)
            {
                featuresIndex=0;
            }


        }
        else
        {

            featuresIndex++;
            if(featuresIndex>=featuresMax-1)
            {
                featuresIndex=featuresMax-1;
            }

        }
        DebugTrace.msg("CharacterDesignScene.addFeatures featuresIndex:"+featuresIndex);

        addFeatures();


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
    private function doFinished(e:Event):void
    {
        var target:Button=e.currentTarget as Button;
        //DebugTrace.msg("CharacterDesignScene.doFinished target:"+target.name);

        var _data:Object=new Object();
        if(target.name=="confirm")
        {

            var gameInfo:Sprite=ViewsContainer.gameinfo;
            gameInfo.dispatchEventWith("UPDATE_PROFILE");

            //_data.name="MainScene";
            _data.name="Tarotreading";
            command.sceneDispatch(SceneEvent.CHANGED,_data);
        }
        else
        {
            //cancel

            _data.removed="characterdesign_to_loadgame";
            command.topviewDispatch(TopViewEvent.REMOVE,_data);


        }
        //if

    }

    private function getTexture(src:String):Texture
    {
        var textture:Texture=Assets.getTexture(src);
        return textture;
    }
    private function updateSaveData():void
    {

        var flox:FloxInterface=new FloxCommand();
        var avatar:Object=flox.getSaveData("avatar");
        if(!avatar){
            avatar=new Object();
        }
        avatar.gender=gender;
        avatar.hairstyle=hairIndex;
        avatar.features=featuresIndex;
        flox.save("avatar",avatar);

    }
    private function onCallback():void
    {

    }

}
}