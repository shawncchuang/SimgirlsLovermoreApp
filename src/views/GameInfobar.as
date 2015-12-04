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

import data.Config;
import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;

import model.SaveGame;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.extensions.pixelmask.PixelMaskDisplayObject;
import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;
import starling.utils.HAlign;
import starling.utils.VAlign;

import utils.DebugTrace;
import utils.DrawManager;
import utils.ViewsContainer;

public class GameInfobar extends Sprite
{
    private var numbersfont:String="SimNeogreyMedium";
    private var font:String="SimMyriadPro";
    private var fonColor:int=0x373535;
    private var attrlist:Array;
    private var valuelist:Array;
    private var flox:FloxInterface=new FloxCommand();
    private var dateTxt:TextField;
    private var cashTxt:TextField;
    private var apTxt:TextField;
    private var imageTxt:TextField;
    private var intTxt:TextField;
    private var honorTxt:TextField;
    private var loveTxt:TextField;
    //private var proTxt:TextField;
    private var ypos:Number=53;
    private var diplaymc:Image;
    private var displayConvert:Image;
    private var dayImg:Image;
    private var nightImg:Image;
    private var moreIcon:Image;
    private var morebar:Sprite;

    private var covertTween:Tween;
    private var apSprite:Sprite=null;
    private var cashSprite:Sprite=null;
    private var imageSprite:Sprite=null;
    private var intSprite:Sprite=null;
    private var moodSprite:Sprite=null;
    private var command:MainInterface=new MainCommand();
    private var basemodel:Sprite;
    private var drawcom:DrawerInterface=new DrawManager();
    private var player_icon:Sprite;
    private var scenecom:SceneInterface=new SceneCommnad();
    private var infoDataView:Sprite;
    private var comDirView:Sprite;
    private var comDirTxt:TextField;
    private var payApTxt:TextField;
    private var apIcon:Image;
    private var current_dating:String;
    private var dating_icon:Sprite;
    public function GameInfobar()
    {


        current_dating=flox.getSaveData("dating");

        ViewsContainer.gameinfo=this;

        infoDataView=new Sprite();
        infoDataView.x=-11;
        infoDataView.y=-29;
        addChild(infoDataView);
        ViewsContainer.InfoDataView=infoDataView;


        //showWheel();
        showBackground();
        showDate();
        showCash();
        showAP();
        showDayIcon();

        showMenu();
        showImage();
        showIntelligence();
        showHonor();
        showLove();


        drawProfile();
        //showSavedProgress();

        showCommandDirections();



        this.addEventListener("UPDATE_INFO",onUpdateInformation);
        //this.addEventListener("DISPLAY_VALUE",onShowDisplayValue);
        this.addEventListener("UPDATE_DIRECTION",onUpdateDirections);
       this.addEventListener("UPDATE_DATING",onUpdateDating);
        this.addEventListener("CANCEL_DATING",onCancelDating);
        this.addEventListener("REMOVE",onRemovedHandler);
        this.addEventListener("DISPLAY",onDisplayHandler);
        this.addEventListener("DRAW_PROFILE",onDrawProfile);
        this.addEventListener("DISPLAY",onDisplayHandle);
        this.dispatchEventWith("UPDATE_INFO");
        this.dispatchEventWith("UPDATE_DATING");
    }
    private function showBackground():void
    {
        //var framesX:Array=[169,390,607];
        var barbgTexture:Texture=Assets.getTexture("GameInfobarBg");
        diplaymc=new Image(barbgTexture);
        infoDataView.addChild(diplaymc);

    }
    private function onDisplayHandle(e:Event):void{




        morebar.visible=true;
        player_icon.visible=true;
        //proTxt.visible=true;

        var current_dating:String=flox.getSaveData("dating");
        if(current_dating!=""){
            dating_icon.visible=true;
        }
    }

    private function onUpdateInformation(e:Event):void
    {
        //DebugTrace.msg("GameInfobar.onUpdateInformation");

        dateTxt.removeFromParent(true);
        showDate();

        var intObj:Object=flox.getSaveData("int");
        var imageObj:Object=flox.getSaveData("image");
        var ap:Number=flox.getSaveData("ap");
        var honor:Object=flox.getSaveData("honor");
        var ap_max:Number=flox.getSaveData("ap_max");
        var cash:Number=flox.getSaveData("cash");
        var love:Object=flox.getSaveData("love");
        var time:String=String(flox.getSaveData("date").split("|")[1]);
        cashTxt.text=DataContainer.currencyFormat(cash);

        apTxt.text=String(ap+"/"+ap_max);
        imageTxt.text=String(imageObj.player);
        intTxt.text=String(intObj.player);
        honorTxt.text=String(honor.player);
        loveTxt.text=String(love.player);
        dayImg.visible=true;
        nightImg.visible=true;
        if(time=="12")
        {
            nightImg.visible=false;
        }
        else
        {
            dayImg.visible=false;
        }

        //var progress:Number=flox.getPlayerData("inGameProgress");
        //proTxt.text="No."+progress;

    }

    private function showDate():void
    {
        var datedata:String=flox.getSaveData("date");
        var dateStr:String=datedata.split("|")[0];
        var datelist:Array=dateStr.split(".");
        datelist.pop();

        var show_date:String=String(datelist.toString().split(",").join("."));
        //DebugTrace.msg("GameInfobar.showDate show_date:"+show_date)
        dateTxt=new TextField(200,40,show_date,numbersfont,22,fonColor);
        dateTxt.hAlign="left";
        dateTxt.vAlign="center";
        dateTxt.x=335;
        dateTxt.y=ypos;
        infoDataView.addChild(dateTxt);
    }
    private function showCash():void
    {
        var cash:Number=flox.getSaveData("cash");
        var cashStr:String=String(cash);
        cashTxt=new TextField(170,40,cashStr,numbersfont,22,fonColor);
        cashTxt.hAlign="left";
        cashTxt.vAlign="center";
        cashTxt.x=572;
        cashTxt.y=ypos;
        infoDataView.addChild(cashTxt);

    }
    private function showAP():void
    {


        var ap:Number=flox.getSaveData("ap");
        var ap_max:Number=flox.getSaveData("ap_max");
        var cashStr:String=String(ap);
        var value:String=cashStr+"/"+ap_max;
        apTxt=new TextField(200,40,value,numbersfont,22,fonColor);
        apTxt.hAlign="left";
        apTxt.vAlign="center";
        apTxt.autoSize=TextFieldAutoSize.HORIZONTAL;
        apTxt.x=800;
        apTxt.y=ypos;
        infoDataView.addChild(apTxt);
    }

    private function showHonor():void
    {
        var honor:Object=flox.getSaveData("honor");
        var honorStr:String=String(honor.play);


        honorTxt=new TextField(morebar.width,40,honorStr,numbersfont,18,0xFFFFFF);
        honorTxt.vAlign="center";
        honorTxt.hAlign="center";
        honorTxt.y=60;
        morebar.addChild(honorTxt);
    }
    private function showLove():void
    {
        var love:Object=flox.getSaveData("love");
        var loveStr:String=String(love.player);

        loveTxt=new TextField(morebar.width,40,loveStr,numbersfont,18,0xFFFFFF);
        loveTxt.vAlign="center";
        loveTxt.hAlign="center";
        loveTxt.y=130;
        morebar.addChild(loveTxt);
    }
    private function showIntelligence():void
    {
        var intObj:Object=flox.getSaveData("int");

        var intStr:String=String(intObj.player);


        intTxt=new TextField(morebar.width,40,intStr,numbersfont,18,0xFFFFFF);
        intTxt.vAlign="center";
        intTxt.hAlign="center";
        intTxt.y=200;
        morebar.addChild(intTxt);
    }

    private function showImage():void
    {

        var image:Object=flox.getSaveData("image");
        var imageStr:String=String(image.player);

        imageTxt=new TextField(morebar.width,40,imageStr,numbersfont,18,0xFFFFFF);
        imageTxt.vAlign="center";
        imageTxt.hAlign="center";
        imageTxt.y=270;
        morebar.addChild(imageTxt);

    }

    private function showDayIcon():void
    {
        var __x:Number=265;
        var __y:Number=35;

        var day_texture:Texture=Assets.getTexture("DaySign");
        dayImg=new Image(day_texture);
        dayImg.smoothing=TextureSmoothing.TRILINEAR;
        dayImg.x=__x;
        dayImg.y=__y;

        var night_texture:Texture=Assets.getTexture("NightSign");
        nightImg=new Image(night_texture);
        nightImg.smoothing=TextureSmoothing.TRILINEAR;
        nightImg.x=__x;
        nightImg.y=__y;

        infoDataView.addChild(dayImg);
        infoDataView.addChild(nightImg);


    }

    private var menusprite:Sprite;
    private function showMenu():void
    {


        menusprite=new Sprite();
        menusprite.name="menusprite";
        menusprite.x=934;
        menusprite.y=21;


        var bgTexture:Texture=Assets.getTexture("MoreIcon");
        var menuIcon:Image=new Image(bgTexture);

        menuIcon.useHandCursor=true;
        menuIcon.addEventListener(TouchEvent.TOUCH,doTouchMenuIcon);

        morebar=new Sprite();
        morebar.x=13;
        morebar.y=-217;
        var barTexture:Texture=Assets.getTexture("MorebarIcon");
        var barImg:Image=new Image(barTexture);
        morebar.clipRect=new Rectangle(0,0,86,menuIcon.height+barImg.height);
        morebar.addChild(barImg);


        menusprite.addChild(morebar);
        menusprite.addChild(menuIcon);
        infoDataView.addChild(menusprite);


    }
    private function doTouchMenuIcon(e:TouchEvent):void
    {
        var target:Image=e.currentTarget as Image;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        if(hover)
        {

            var tween:Tween=new Tween(morebar,0.2,Transitions.EASE_OUT)
            tween.animate("y",77);
            tween.fadeTo(1);
            Starling.juggler.add(tween);

            gameEvent._name="hide_comcloud";
            gameEvent.displayHandler();

        }
        else
        {

            Starling.juggler.removeTweens(morebar);

            tween=new Tween(morebar,0.2,Transitions.EASE_OUT);
            tween.animate("y",-217);
            tween.fadeTo(0);
            Starling.juggler.add(tween);


            gameEvent._name="show_comcloud";
            gameEvent.displayHandler();

        }
        //began
        if(began){

            Starling.juggler.removeTweens(morebar);
            //morebar.y=-217;
            morebar.visible=false;
            profileFadeout();
            datingProfileFadeout();
            gameInfobarFadeout();




            var currentScene:String=DataContainer.currentScene;
            var main_index:Number=currentScene.indexOf("MainScene");
            if(main_index==-1)
            {

                gameEvent._name="clear_comcloud";
                gameEvent.displayHandler();
            }

            //var _data:Object=new Object();
            //_data.name="MenuScene";
            //command.sceneDispatch(SceneEvent.CHANGED,_data);
        }

    }
    private function onDrawProfile(e:Event):void
    {
        DebugTrace.msg("GameInfobar.onDrawProfile");
        try{

            player_icon.removeFromParent(true);
        }catch(e:Error){
            DebugTrace.msg("GameInfobar remove  player_icon Error");
        }
        drawProfile();
    }
    private function drawProfile():void
    {

        var flox:FloxInterface=new FloxCommand();
        var gender:String=flox.getSaveData("avatar").gender;
        if(!gender){
            gender="Male";
        }
        var modelObj:Object=Config.modelObj;
        var modelRec:Rectangle=modelObj[gender];

        basemodel=new Sprite();
        basemodel.x=modelRec.x;
        basemodel.y=modelRec.y;

        var modelAttr:Object=new Object();
        modelAttr.gender=gender;
        modelAttr.width=modelRec.width;
        modelAttr.height=modelRec.height;

        drawcom.drawCharacter(basemodel,modelAttr);
        drawcom.updateBaseModel("Eyes");
        drawcom.updateBaseModel("Hair");
        drawcom.updateBaseModel("Features");


        playerProfile();

    }

    private function playerProfile():void
    {

        player_icon=new Sprite();
        drawcom.drawPlayerProfileIcon(player_icon,1,new Point(64,50));
        player_icon.name="Player";
        player_icon.scaleX=0.89;
        player_icon.scaleY=0.89;
        addChild(player_icon);


    }
//    private function showSavedProgress():void{
//
//        var progress:Number=flox.getPlayerData("inGameProgress");
//        proTxt=new TextField(100,30,"",font,14,0xffffff,true);
//        //proTxt.x=100;
//        //proTxt.y=18;
//        proTxt.hAlign="left";
//        proTxt.vAlign="top";
//        proTxt.text="No."+progress;
//        addChild(proTxt);
//    }

    private function profileFadeout():void
    {

        current_dating=flox.getSaveData("dating");
        if(current_dating!=""){
            dating_icon.removeFromParent(true);

        }
        player_icon.removeFromParent(true);
//        var tween:Tween=new Tween(player_icon,0.3,Transitions.EASE_IN_OUT);
//        tween.fadeTo(0);
//        tween.onComplete=function():void{
//            Starling.juggler.removeTweens(player_icon);
//            player_icon.removeFromParent(true);
//
//
//
//        };
//        Starling.juggler.add(tween);

    }

    private function datingProfileFadeout():void{


        current_dating=flox.getSaveData("dating");
        if(current_dating!="") {
            dating_icon.removeFromParent(true);

//            var tween:Tween = new Tween(dating_icon, 0.1, Transitions.EASE_IN_OUT);
//            tween.fadeTo(0);
//            tween.onComplete = function ():void{
//                Starling.juggler.removeTweens(dating_icon);
//                dating_icon.removeFromParent(true);
//            };
//            Starling.juggler.add(tween);

        }

    }
    private function showCommandDirections():void
    {
        comDirView=new Sprite();
        comDirView.x=260;
        comDirView.y=85;
        var comdirTexture:Texture=Assets.getTexture("ComDirections");
        var comdir:Image=new Image(comdirTexture);
        comDirView.addChild(comdir);
        var msg:String="";
        comDirTxt=new TextField(455,comdir.height,msg,"SimMyriadPro",18);
        comDirTxt.vAlign=VAlign.CENTER;
        comDirTxt.hAlign=HAlign.LEFT;
        comDirTxt.x=12;
        comDirView.addChild(comDirTxt);
        comDirView.visible=false;

        //apIcon
        var apTexture:Texture=Assets.getTexture("ApIcon");
        apIcon=new Image(apTexture);
        apIcon.x=483;
        apIcon.y=Math.floor((comdir.height-apIcon.height)/2);
        comDirView.addChild(apIcon);


        payApTxt=new TextField(70,comdir.height,"",numbersfont,25,0xFF0000);
        payApTxt.vAlign=VAlign.CENTER;
        payApTxt.hAlign=HAlign.CENTER;
        payApTxt.x=550;
        comDirView.addChild(payApTxt);


        addChild(comDirView);

    }
    private function onUpdateDirections(e:Event):void
    {


        var attr:String=e.data.content.split(" ").join("");

        //DebugTrace.msg("GameInfobar.onUpdateDirections attr:"+attr);
        var commandData:Object=flox.getSyetemData("command");
        comDirView.visible=e.data.enabled;
        var currentscene:String=DataContainer.currentLabel;
        apIcon.visible=true;
        payApTxt.visible=true;


        switch(attr){
            case "Kiss":
            case "Flirt":
            case "TakePhoto":
            case "Chat":
            case "Give":
            case "Date":
                var UIViews:Sprite=ViewsContainer.UIViews;
                UIViews.visible=true;
                player_icon.visible=false;
                //proTxt.visible=false;
                if(current_dating){
                    dating_icon.visible=false;
                }
                comDirView.x=132;
                comDirView.y=665;
                break;
            default:
                comDirView.x=260;
                comDirView.y=85;
                break
        }

        if(currentscene=="HotelScene" && attr=="Rest")
        {
            attr="PayRest";
        }
        else if(attr=="Work")
        {
            var _attr:String=currentscene.split("Scene").join("Work");
            attr=_attr;
        }
        else
        {
            if(attr=="Rest")
            {

                attr="FreeRest";

            }
        }
        //if

        if(e.data.enabled && attr!="Leave")
        {

            var dec:String=commandData[attr].dec;
            var value:Number=Number(commandData[attr].ap);


            if(attr.indexOf("Rest")!=-1)
            {
                var switch_verifies:Array=scenecom.switchGateway("Rest");

                if(switch_verifies[0]){
                    apIcon.visible=false;
                    payApTxt.visible=false;
                    value=0;
                    var switchID:String=flox.getSaveData("next_switch");
                    var switchs:Object=flox.getSyetemData("switchs");
                    var values:Object=switchs[switchID];
                    dec=values.hints;
                }
                //if
            }
            //if

            comDirTxt.text=dec;
            payApTxt.text=String(value);
            if(value>0)
            {
                payApTxt.text="+"+value;
            }

            comDirView.alpha=0;
            var tween:Tween=new Tween(comDirView,0.5,Transitions.EASE_OUT);
            tween.fadeTo(1);
            tween.onComplete=onDirViewComplete;
            Starling.juggler.add(tween);
        }
        //if


    }
    private function onDirViewComplete():void
    {
        Starling.juggler.removeTweens(comDirView);

    }

    private function onUpdateDating(e:Event):void
    {

        current_dating=flox.getSaveData("dating");
        if(current_dating!="")
        {
            DataContainer.currentDating=current_dating;
            dating_icon=new Sprite();
            dating_icon.x=158;
            dating_icon.y=50;
            addChild(dating_icon);
            var drawcom:DrawerInterface=new DrawManager();
            drawcom.drawCharacterProfileIcon(dating_icon,current_dating,0.45);
        }

    }
    private function onCancelDating(e:Event):void{


        try{
            dating_icon.removeFromParent(true);
        }catch(e:Error){

            DebugTrace.msg("GamseIfnobar.onCancelDating dating_icon=Null");

        }

    }

    private function onRemovedHandler(e:Event):void{

        this.visible=false;
    }
    private function onDisplayHandler(e:Event):void{
        this.visible=true;
    }

    private function gameInfobarFadeout():void{


        var tween:Tween=new Tween(infoDataView,1,Transitions.EASE_IN_OUT_BACK);
        tween.animate("y",-(infoDataView.height));
        tween.onComplete=onGameInfoFadoutComplete;
        Starling.juggler.add(tween);


    }
    private function onGameInfoFadoutComplete():void{

        Starling.juggler.removeTweens(this);


        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
}
}