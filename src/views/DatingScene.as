package views {

import controller.Assets;
import controller.DrawerInterface;
import controller.FilterInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.MediaCommand;
import controller.MediaInterface;
import controller.ParticleInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;
import events.SceneEvent;

import feathers.controls.ImageLoader;

import flash.geom.Point;
import flash.html.script.Package;
import flash.media.SoundChannel;

import model.CusomAssets;
import model.SaveGame;
import model.Scenes;

import starling.animation.DelayedCall;
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
import starling.text.TextFieldAutoSize;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;

import utils.DebugTrace;
import utils.DrawManager;
import utils.FilterManager;
import utils.ParticleSystem;
import utils.ViewsContainer;

public class DatingScene extends Scenes {
    private var font:String = "SimImpact";
    private var base_sprite:Sprite;
    private var character:Image;
    private var filters:FilterInterface = new FilterManager();
    private var command:MainInterface = new MainCommand();
    private var flox:FloxInterface = new FloxCommand();
    //private var proSprtie:Sprite;
    private var moodPie:MovieClip;
    private var mood:Number;
    //raise or less
    private var reward_mood:Number;
    private var _love:Number;
    private var drawcom:DrawerInterface = new DrawManager();
    private var fIndex:uint = 0;

    private var moodPieImg:Image;
    private var cancelbtn:Button;
    private var pts_txt:TextField;
    private var scenecom:SceneInterface = new SceneCommnad();
    private var comcloud:String = "ComCloud_L1_^Give," +
            "ComCloud_L2_^Chat," +
            "ComCloud_R1_^Dating," +
            "ComCloud_R2_^Leave," +
            "ComCloud_R3_^Flirt";
    public static var COMMIT:String = "commit";
    public static var DISPLAY_ALERT:String = "display_alert";
    public static var UPDATE_INFO:String = "update_info";
    public static var REJECT_GIFT:String = "reject_gift";
    public static var CHANGED_RELATIONSHIP:String="changed_relationship";
    public static var NONE_RELATIONSHIP:String="none_relationship";
    private var excerptbox:ExcerptBox;
    private var item_id:String;
    private var bubble:Sprite;
    private var goDating:Number = 0;
    private var chat:String;
    private var chatTxt:TextField;
    private var player_love:Number = 0;
    private var ch_love:Number = 0;
    private var com:String;
    private var assets:AssetsForm;
    private var panelbase:Sprite;
    private var heartView:Sprite;

    private var talkingAlert:Sprite;
    private var takephoto:Sprite=null;
    private var cloudlist:Array;
    private var cancelImg:Image;
    private var tweenID:uint=0;
    private var mediacom:MediaInterface = new MediaCommand();

    private var cloudcom:String="";
    public function DatingScene() {

        base_sprite = new Sprite();
        addChild(base_sprite);

        this.addEventListener(DatingScene.COMMIT, doCommitCommand);
        this.addEventListener(DatingScene.DISPLAY_ALERT, doAlerMessage);
        this.addEventListener(DatingScene.UPDATE_INFO, doUpdateDatingInfo);
        this.addEventListener(DatingScene.REJECT_GIFT, doRejectGiftHandle);
        this.addEventListener(DatingScene.CHANGED_RELATIONSHIP, doChandedRelactionshipHandle);
        this.addEventListener(DatingScene.NONE_RELATIONSHIP, doNoneRelationshipHandle);
        this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);


        ViewsContainer.baseSprite = this;


        ProfileScene.CharacterName = "player";

        var dating:String = DataContainer.currentDating;
        var moodObj:Object = flox.getSaveData("mood");
        mood = moodObj[dating];

        initLayout();
        //var customAssets:CusomAssets=new CusomAssets();
        //customAssets.checkRatingAssets();
        twinflameWarning();
    }

    private function doUpdateDatingInfo(e:Event):void {
        updateAP();

    }

    private function doRejectGiftHandle(e:Event):void {


        panelbase.removeFromParent(true);
        excerptbox.removeFromParent(true);

        chat = "Sorry, I can't accept it. We are not that close...";
        initBubble();


    }

    private function doAlerMessage(e:Event):void {


        var dating:String = DataContainer.currentDating;
        var msg:String = dating.toUpperCase() + " owned this !!";
        talkingAlert= new AlertMessage(msg);
        addChild(talkingAlert);

    }

    private var globalPos:Point;

    private function doCommitCommand(e:Event):void {
        ViewsContainer.UIViews.visible = false;
        datingTopic.visible = true;
        com = e.data.com;
        DebugTrace.msg("DatingScene.doCommitCommand com:" + com);
        if (com != "GotGift" || com != "FlirtLove") {

            mainProfileTransForm();
        }

        try{
            talkingAlert.removeFromParent(true);
        }catch(error:Error){

        }
        for(var i:uint=0;i<cloudlist.length;i++){
            var cloudMC:MovieClip=cloudlist[i];
            Starling.juggler.removeTweens(cloudMC);

        }

        switch (com) {
            case "Give":
                initAssetsForm();

                break;
            case "Leave":
                datingTopic.visible = false;

                var _data:Object = new Object();
                _data.name = DataContainer.currentScene;
                _data.from="dating";
                command.sceneDispatch(SceneEvent.CHANGED, _data);

                command.updateInfo();

                break;
            case "Chat":
                var chat:ChatScene = new ChatScene();
                addChild(chat);
                break;
            case "Flirt":
                var flirt:FlirtScene = new FlirtScene();
                addChild(flirt);

                break;
            case "Date":

                confirmDating();

                break;
            case "SendGift":

                var command_dating:Object = flox.getSaveData("command_dating");
                var dating:String = DataContainer.currentDating;
                var comTimes:Number = command_dating[dating].Give;
                comTimes--;
                command_dating[dating].Give = comTimes;
                flox.save("command_dating", command_dating);

                item_id = e.data.item_id;
                globalPos = e.data.began;

                updateAssetsForm();
                actTransform("../swf/gift.swf", onGiftActComplete);

                break;
            case "KissLove":
                _love = e.data.love;
                updateLovefromKiss();
                break;
            case "TakePhoto":

                character.removeFromParent(true);
                actTransform("../swf/photos.swf",onPhotosActComplete);

                break;
            case "TakePhotosReward":
            case "TakeFlirtReward":

                if (e.data.love) {
                    playerloveTxt.text = String(e.data.love.player);
                    chloveTxt.text = String(e.data.love.dating);
                }

                startPaticles();
                drawcom.updatePieChart(e.data.mood);

                delayCall=new DelayedCall(doCallUpdateRelationship,2);
               Starling.juggler.add(delayCall);

                break;
            case "Kiss":

                var kissScene:KissScene = new KissScene();
                addChild(kissScene);

                break;
            case "Reward_Mood":
                reward_mood = e.data.mood;

                updateMood();
                break

        }

    }
    private function doCallUpdateRelationship():void{

        Starling.juggler.remove(delayCall);
        command.updateRelationship();
    }

    private function mainProfileTransForm():void {

        mainProfile.x = 130;
        mainProfile.y = 127;
        mainProfile.scaleX = 0.9;
        mainProfile.scaleY = 0.9;
        var tween:Tween = new Tween(mainProfile, 0.3, Transitions.EASE_IN_OUT);
        tween.delay = 0.2;
        tween.animate("alpha", 1);
        Starling.juggler.add(tween);

    }

    private function updateAssetsForm():void {

        cancelImg.removeFromParent(true);
        panelbase.removeFromParent(true);
        excerptbox.removeFromParent(true);
        addExcertbox();

    }


    private function initAssetsForm():void {

        panelbase = new Sprite();
        panelbase.x = 360;
        panelbase.y = 159;
        addChild(panelbase);

        var panelAssets:Image = new Image(Assets.getTexture("AssetsTab"));
        panelAssets.name = "assets";
        panelbase.addChild(panelAssets);


        assets = new AssetsForm();
        panelbase.addChild(assets);

        var _data:Object = new Object();
        _data.type = "give";
        assets.dispatchEventWith(AssetsForm.INILAIZE, false, _data);


        addExcertbox();


        // gameEvent._name="dating_assets_form";
        //gameEvent.displayHandler();

        //added cancel button
        cancelImg= command.addedCancelButton(this, doCancelAssetesForm);


    }

    private function addExcertbox():void {
        excerptbox = new ExcerptBox();
        excerptbox.x = 56;
        excerptbox.y = 275;
        addChild(excerptbox);
        ViewsContainer.ExcerptBox = excerptbox;
    }

    private function doCancelAssetesForm():void {


        excerptbox.removeFromParent(true);
        panelbase.removeFromParent(true);

        var _data:Object = new Object();
        _data.name = DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED, _data);


    }

    private function startPaticles():void {

        var rating:Number = command.searchAssetRating(item_id);
        var type:String = "like";
        if (rating < 0) {
            type = "unlike"
        }
        var ps:ParticleInterface = new ParticleSystem();
        ps.init(mainProfile, type);
        ps.showParticles();

    }


    private function updateMood():void {

        DebugTrace.msg("DatingScene.updateMood reward_mood:" + reward_mood);

        var dating:String = DataContainer.currentDating;
        var moodObj:Object = flox.getSaveData("mood");
        //DebugTrace.msg("DatingScene.updateMood mood data:" + JSON.stringify(moodObj));
        mood = moodObj[dating] + reward_mood;
        moodObj[dating] = mood;
        flox.save("mood", moodObj);

        var rewards:Object=new Object();
        rewards.mood=reward_mood;
        DataContainer.rewards=rewards;

        drawcom.updatePieChart(mood);

        var mood_value:String = String(reward_mood);
        if (reward_mood > 0) {
            mood_value = "+" + reward_mood;
        }else{
            mood_value = String(reward_mood);
        }

        var value_data:Object = new Object();
        value_data.attr = "mood";
        value_data.values = "MOOD " + mood_value;
        command.displayUpdateValue(this, value_data);


        delayCall= new DelayedCall(doUpdateRelationship,2);
        Starling.juggler.add(delayCall);

        function doUpdateRelationship():void{
            Starling.juggler.remove(delayCall);
            command.updateRelationship();
        }

    }


    private var pts_index:Number;
    private var old_pts:Number;

    private function updateRelPoint():void {
        pts_index = 0;
        var dating:String = DataContainer.currentDating;
        var savegame:SaveGame = FloxCommand.savegame;
        var ptsObj:Object = savegame.pts;
        old_pts = Number(ptsObj[dating]);
        //DebugTrace.msg("DatingScene.updateRelPoint old_pts:" + old_pts);

    }

    private function updateLovefromKiss():void {
        startPaticles();
        //Kiss Formula

        var dating:String = DataContainer.currentDating;
        var loveObj:Object = flox.getSaveData("love");
        var moodObj:Object = flox.getSaveData("mood");
        var love:Number=loveObj.player;

        player_love = loveObj.player;
        ch_love = loveObj[dating];

        player_love += _love;
        ch_love += _love;
        loveObj.player = player_love;
        loveObj[dating] = ch_love;

        playerloveTxt.text = String(player_love);
        chloveTxt.text = String(ch_love);

        var _int:Number=flox.getSaveData("int").player;
        var _img:Number=flox.getSaveData("image").player;
        var reward_mood:Number=Math.floor(love/6);
        mood = moodObj[dating];
        mood += reward_mood;
        moodObj[dating] = mood;
        var savegame:SaveGame = FloxCommand.savegame;
        savegame.mood = moodObj;
        savegame.love = loveObj;
        FloxCommand.savegame = savegame;

        var reward_love:String = String(_love);
        if (_love >= 0) {
            reward_love = "+" + _love;
        }

        DebugTrace.msg("DatingScene.updateLovefromKiss reward_love:"+reward_love);
        DebugTrace.msg("DatingScene.updateLovefromKiss reward_mood:"+reward_mood);
        drawcom.updatePieChart(mood);

        var _data:Object=new Object();
        _data.mood=reward_mood;
        _data.love=reward_love;
        DataContainer.rewards=_data;

        var value_data:Object = new Object();
        value_data.attr = "love,mood";
        value_data.values = reward_love + ",MOOD +" + reward_mood;
        command.displayUpdateValue(this, value_data);

        delayCall=new DelayedCall(doCallUpdateRelationship,2);
        Starling.juggler.add(delayCall);


    }


    private var playerloveTxt:TextField;
    private var datingTopic:Sprite;
    private var chloveTxt:TextField;
    //private var profile:Sprite=null;
    private var mainProfile:Sprite;
    private var bgEffectImg:Image;
    private var titleIcon:Image;
    private var relactionInfo:Sprite;
    private var clouds:Array = new Array();
    private var apPanel:Sprite;
    private var apTxt:TextField;
    private var chFacials:CharacterFacials;
    private var clothTexture:Texture;
    private var bgSprtie:Sprite;

    private function initLayout():void {


        var dating:String = DataContainer.currentDating;
        var rel:String = flox.getSaveData("rel")[dating];
        rel=rel.split(" ").join("");


        bgSprtie =  drawcom.drawBackground();

        filters.setSource(bgSprtie);
        filters.setBulr();
        addChild(bgSprtie);



        var effterxture:Texture = Assets.getTexture("DatingSceneBgEffect");
        bgEffectImg = new Image(effterxture);
        addChild(bgEffectImg);



        titleIcon = new Image(Assets.getTexture("IconRel_"+rel));
        titleIcon.x = 34;
        titleIcon.y = 11;
        addChild(titleIcon);


        relactionInfo = new Sprite();
        relactionInfo.x = 18;
        relactionInfo.y = 193;
        addChild(relactionInfo);

        var quad1:Quad = new Quad(200, 36, 0);
        quad1.x = 5;
        relactionInfo.addChild(quad1);

        if(rel=="spouse"){
            rel="soulmate";
        }
        var relationship:TextField = new TextField(210, 34, rel.toUpperCase());
        relationship.format.setTo(font, 30, 0xffffff);

        relactionInfo.addChild(relationship);


        var quad2:Quad = new Quad(200, 30, 0xffffff);
        quad2.x = 5;
        quad2.y = 36;
        relactionInfo.addChild(quad2);
        var pts:String = String(flox.getSaveData("pts")[dating]);
        var ptsTxt:TextField = new TextField(210, 34, pts);
        ptsTxt.format.setTo(font, 30, 0x373535);
        ptsTxt.x = 5;
        ptsTxt.y = 35;
        relactionInfo.addChild(ptsTxt);


        mainProfile = new Sprite();

        mainProfile.x = 370;
        mainProfile.y = 190;

        var moodCircle:Image = new Image(getTexture("EnergyPieChartBg"));
        moodCircle.pivotX = moodCircle.width / 2;
        moodCircle.pivotY = moodCircle.height / 2;
        mainProfile.addChild(moodCircle);

        drawcom.drawPieChart(mainProfile, "MoodPieChart");
        drawcom.updatePieChart(mood);

        chFacials = new CharacterFacials();
        chFacials.chname = dating;
        chFacials.initlailizeView();
        mainProfile.addChild(chFacials);

        apPanel = new Sprite();
        apPanel.x = 750;
        apPanel.y = -20;
        apTxt = new TextField(87, 50, "");
        apTxt.format.setTo(font, 25, 0x373535,"left");
        apTxt.autoSize = TextFieldAutoSize.HORIZONTAL;
        apTxt.x = 87;
        apTxt.y = 37;

        var apImg:Image = new Image(Assets.getTexture("apPanel"));
        apPanel.addChild(apImg);
        apPanel.addChild(apTxt);
        addChild(apPanel);

        command.initStyleSchedule(onStyleComplete);

    }

    private function onStyleComplete():void{

        updateAP();
        initCharacter();
        initTopicBar();
        displayCloud();

        addChild(mainProfile);

    }

    private function updateAP():void {

        var ap:Number = flox.getSaveData("ap");
        var apMax:Number = flox.getSaveData("ap_max");
        apTxt.text = ap + "/" + apMax;
        command.updateInfo();

    }


    private function initCharacter():void {

        var dating:String = DataContainer.currentDating;
        var styleSechedule:Object=DataContainer.styleSchedule;
        var style:String = styleSechedule[dating];

        var datingSuit:String=DataContainer.DatingSuit;
        if(datingSuit!=""){
            style=datingSuit;
        }else{
            DataContainer.DatingSuit=style;
        }

        //DebugTrace.msg("DatingScene.initCharacter datingSuit="+datingSuit);
        //DebugTrace.msg("DatingScene.initCharacter dating="+dating);
        DebugTrace.msg("DatingScene.initCharacter style="+style);


        clothTexture = Assets.getTexture(style) as Texture;
        character = new Image(clothTexture);
        character.alpha=0;
        character.x=400;
        character.y=character.y - 80;
        character.scaleX=1.2;
        character.scaleY=1.2;
        addChild(character);

        tweenID=Starling.juggler.tween(character, 0.5,{transition:Transitions.EASE_IN_OUT,alpha:1,onComplete:onCharaacterComplete});
//        var tween:Tween = new Tween(character, 0.5, Transitions.EASE_IN_OUT);
//        tween.fadeTo(1);
//        tween.onComplete=onCharaacterComplete;
//        Starling.juggler.add(tween);
        function onCharaacterComplete():void{
            //Starling.juggler.removeTweens(character);
            Starling.juggler.removeByID(tweenID);
        }

    }
    private function initTopicBar():void {


        datingTopic = new Sprite();
        datingTopic.visible = false;
        //this.addChild(datingTopic);

        var title:Image = new Image(getTexture("DatingTitleBg"));
        title.y = 35;
        datingTopic.addChild(title);


        var dating:String = DataContainer.currentDating;

        var loveObj:Object = flox.getSaveData("love");

        playerloveTxt = new TextField(120, 55, loveObj.player);
        playerloveTxt.format.setTo(font, 40, 0xFFFFFF);
        playerloveTxt.x = 290;
        playerloveTxt.y = 54;
        datingTopic.addChild(playerloveTxt);

        var ch_love_txt:TextField = new TextField(55, 55, dating + "\nLove");
        ch_love_txt.format.setTo(font, 18, 0xFFFFFF);
        ch_love_txt.autoSize = TextFieldAutoSize.HORIZONTAL;
        ch_love_txt.x = 420;
        ch_love_txt.y = 54;
        datingTopic.addChild(ch_love_txt);


        chloveTxt = new TextField(120, 55, loveObj[dating]);
        chloveTxt.format.setTo(font, 40, 0xFFFFFF);
        chloveTxt.x = 500;
        chloveTxt.y = 54;
        datingTopic.addChild(chloveTxt);


        var first_str:String = dating.charAt(0).toUpperCase();
        var _dating:String = dating.slice(1);
        var pro_dating:String = "Pro" + first_str.concat(_dating);
        DebugTrace.msg("DatingScene.initLayout pro_dataing:" + pro_dating);


    }

    private function displayCloud():void {

        cloudlist=new Array();
        var command_dating:Object = flox.getSaveData("command_dating");

        var cloudAttr:Array = [{name: "Kiss", pos: new Point(182, 410)},
            {name: "Flirt", pos: new Point(120, 530)},
            {name: "TakePhoto", pos: new Point(880, 558)},
            {name: "Chat", pos: new Point(945, 322)},
            {name: "Give", pos: new Point(920, 439)},
            {name: "Date", pos: new Point(85, 654)},
            {name: "Leave", pos: new Point(825, 675)}
        ];

        for (var i:uint = 0; i < cloudAttr.length; i++) {
            var src:String = cloudAttr[i].name;

            if (src == "Kiss" || src == "Flirt" || src == "TakePhoto") {
                var posX:Number = -200;
            } else {
                posX = 1000;
            }

            var cloud:Sprite = new Sprite();
            cloud.useHandCursor = true;
            cloud.name = src;
            cloud.x = posX;
            //cloud.x=cloudAttr[src].x;
            cloud.y = cloudAttr[i].pos.y;

            var xml:XML = Assets.getAtalsXML("ComCloudXML");
            var cloudTexture:Texture = Assets.getTexture("ComCloud");
            var cloudAltas:TextureAtlas = new TextureAtlas(cloudTexture, xml);

            var cloudMC:MovieClip = new MovieClip(cloudAltas.getTextures("command_cloud"), 30);
            cloudMC.name = "mc";
            cloudMC.pivotX = cloudMC.width / 2;
            cloudMC.pivotY = cloudMC.height / 2;
            cloudMC.stop();
            cloud.addChild(cloudMC);
            Starling.juggler.add(cloudMC);
            cloudlist.push(cloudMC);

            if (src == "TakePhoto") {
                src = "Take\nPhoto";
            }

            var cloudTxt:TextField = new TextField(cloudMC.width, cloudMC.height, src);
            cloudTxt.name = "txt";
            cloudTxt.format.setTo(font, 25, 0x66CCFF);
            cloudTxt.pivotX = cloudTxt.width / 2;
            cloudTxt.pivotY = cloudTxt.height / 2;
            cloud.addChild(cloudTxt);

            cloud.scaleX = 0.1;
            cloud.scaleY = 0.1;
            addChild(cloud);
            clouds.push(cloud);
            cloud.addEventListener(TouchEvent.TOUCH, onTouchedCloudHandler);

            if (src != "Leave") {
                if (src.indexOf("\n") != -1) {
                    src = src.split("\n").join("");
                }
                var dating:String = DataContainer.currentDating;
                var comTimes:Number = command_dating[dating][src];

                var comTimesTxt:TextField = new TextField(40, 24, "x" + comTimes);
                comTimesTxt.name = "times";
                comTimesTxt.format.setTo(font, 18, 0xffffff);
                comTimesTxt.autoSize = TextFieldAutoSize.HORIZONTAL;
                comTimesTxt.pivotX = comTimesTxt.width / 2;
                comTimesTxt.y = 20;
                cloud.addChild(comTimesTxt);
            }


            var tween:Tween = new Tween(cloud, i * 0.1 + 0.2, Transitions.EASE_IN_OUT_BACK);
            tween.animate("x", cloudAttr[i].pos.x);
            tween.scaleTo(1);
            Starling.juggler.add(tween);


        }
        delayTween = new Tween(this, 0.1);
        delayTween.delay = 2;
        delayTween.onComplete = onClodFadeInComplete;
        Starling.juggler.add(delayTween);

    }


    private function onClodFadeInComplete():void {

        Starling.juggler.remove(delayTween);

        for (var i:uint = 0; i < clouds.length; i++) {

            var cloud:Sprite = clouds[i];
            Starling.juggler.removeTweens(cloud);

        }


    }

    private var cloud:Sprite;

    private function onTouchedCloudHandler(e:TouchEvent):void {

        cloud = e.currentTarget as Sprite;
        var began:Touch = e.getTouch(cloud, TouchPhase.BEGAN);
        var hover:Touch = e.getTouch(cloud, TouchPhase.HOVER);
        com = cloud.name;
        var gameInfo:Sprite = ViewsContainer.gameinfo;
        if (com != "Leave") {

            if (hover) {

                var _data:Object = new Object();
                _data.enabled = true;
                _data.content = com;
                gameInfo.dispatchEventWith("UPDATE_DIRECTION", false, _data);
            } else {

                _data = new Object();
                _data.enabled = false;
                _data.content = com;
                gameInfo.dispatchEventWith("UPDATE_DIRECTION", false, _data);
            }

        }

        if (began) {
            command.playSound("Break");
            var mr_permission:Boolean = specificChecking(com);
            if (mr_permission) {

                var times_permission:Boolean = checkCommandEnabled();
                if (times_permission) {
                    // can do this command
                    var ap_permissions:Boolean = command.consumeHandle(com);
                    if (ap_permissions) {
                        // ap enough
                        if (com != "Give" && com!="Leave") {

                            var command_dating:Object = flox.getSaveData("command_dating");
                            var dating:String = DataContainer.currentDating;
                            var comTimes:Number = command_dating[dating][com];
                            comTimes--;
                            command_dating[dating][com] = comTimes;
                            flox.save("command_dating", command_dating);
                        }


                        for (var i:uint = 0; i < clouds.length; i++) {
                            clouds[i].removeEventListener(TouchEvent.TOUCH, onTouchedCloudHandler);
                        }
                        if (com == "Leave") {

                            gameInfo = ViewsContainer.gameinfo;
                            gameInfo.dispatchEventWith("UPDATE_INFO");
                            DataContainer.DatingSuit="";
                            clickedCloudHandle();

                        } else {


                            clickedCloudHandle();
                        }
                    }
                }

            }

        }


    }

    private function checkCommandEnabled():Boolean {

        var enabled:Boolean = true;
        if (com != "Leave") {

            var command_dating:Object = flox.getSaveData("command_dating");
            var dating:String = DataContainer.currentDating;
            var comTimes:Number = command_dating[dating][com];
            if (comTimes > 0) {
                enabled = true;
//                if (com != "Give") {
//
//                    comTimes--;
//                    command_dating[dating][com] = comTimes;
//                    flox.save("command_dating", command_dating);
//                }

            } else {

                enabled = false;
                var msg:String = "";

                chat = "Can we do something else?";
                var attr:Object = new Object();
                attr.x = 640;
                attr.y = 132;
                initBubble(attr);
                bubbleFadeoutHandle();
            }

        }
        return enabled

    }



    private function clickedCloudHandle():void {



        var mc:MovieClip = cloud.getChildByName("mc") as MovieClip;
        mc.play();
        mc.addEventListener(Event.COMPLETE, onCloudMovieComplete);
        Starling.juggler.add(mc);
        var txt:TextField = cloud.getChildByName("txt") as TextField;
        txt.visible = false;

        if (com != "Leave") {
            var timesTxt:TextField = cloud.getChildByName("times") as TextField;
            timesTxt.visible = false;
        }


    }

    private function onCloudMovieComplete(e:Event):void {

        //DebugTrace.msg("DatingScene.onCloudMovieComplete");
        var target:MovieClip = e.currentTarget as MovieClip;
        target.pause();
        Starling.juggler.remove(target);
        target.visible=false;

        delayCall=new DelayedCall(layoutFadeout,.8);
        Starling.juggler.add(delayCall);

    }

    private var chTween:Tween;
    private var bgEfftween:Tween;
    private var titleIcontween:Tween;
    private var relactionInfoTween:Tween;
    private var mainProTween:Tween;
    private var delayTween:Tween;
    private var apPanelTween:Tween;

    private function layoutFadeout():void {

        Starling.juggler.remove(delayCall);
        for (var i:uint = 0; i < clouds.length; i++) {

            var cloud:Sprite = clouds[i];
            switch (cloud.name) {
                case "Kiss":
                case "TakePhoto":
                case "Flirt":
                    var posX:Number = -200;
                    break;
                default :
                    posX = 1000;
                    break
            }

            var cloudTween:Tween = new Tween(cloud, i * 0.1, Transitions.EASE_IN_OUT);
            cloudTween.animate("x", posX);
            cloudTween.scaleTo(0.1);
            Starling.juggler.add(cloudTween);

        }
        bgEfftween = new Tween(bgEffectImg, 0.3, Transitions.EASE_IN_OUT);
        bgEfftween.fadeTo(0);
        bgEfftween.onComplete = onTweenComplete;
        titleIcontween = new Tween(titleIcon, 0.3, Transitions.EASE_IN_OUT);
        titleIcontween.fadeTo(0);
        titleIcontween.onComplete = onTweenComplete;
        relactionInfoTween = new Tween(relactionInfo, 0.3, Transitions.EASE_IN_OUT);
        relactionInfoTween.fadeTo(0);
        relactionInfoTween.onComplete = onTweenComplete;

        apPanelTween = new Tween(apPanel, 0.3, Transitions.EASE_IN_OUT);
        apPanelTween.fadeTo(0);
        apPanelTween.onComplete = onTweenComplete;

        if (com != "Leave") {

            chTween = new Tween(character, 0.2, Transitions.EASE_IN_OUT);
            chTween.scaleTo(1);
            if (com == "Kiss") {
                chTween.fadeTo(0);
            }
            chTween.moveTo(260, 0);

            mainProTween = new Tween(mainProfile, 0.2, Transitions.EASE_IN_OUT);
            mainProTween.animate("alpha", 0);

        } else {

            chTween = new Tween(character, 0.2, Transitions.EASE_IN_OUT);
            chTween.fadeTo(0);

            mainProTween = new Tween(mainProfile, 0.2, Transitions.EASE_IN_OUT);
            mainProTween.fadeTo(0);

        }
        chTween.onComplete = onTweenComplete;
        mainProTween.onComplete = onTweenComplete;

        Starling.juggler.add(bgEfftween);
        Starling.juggler.add(titleIcontween);
        Starling.juggler.add(relactionInfoTween);
        Starling.juggler.add(chTween);
        Starling.juggler.add(mainProTween);

        //delayTween=new Tween(this,0.5);
        //delayTween.onComplete=onReadyToChangeScene;
        // Starling.juggler.add(delayTween);

        onReadyToChangeScene();
    }


    private function onTweenComplete():void {

        Starling.juggler.removeTweens(chTween);
        Starling.juggler.removeTweens(bgEfftween);
        Starling.juggler.removeTweens(titleIcontween);
        Starling.juggler.removeTweens(relactionInfoTween);
        Starling.juggler.removeTweens(mainProTween);


        for (var i:uint = 0; i < clouds.length; i++) {

            var cloud:Sprite = clouds[i];
            Starling.juggler.removeTweens(cloud);
            var cloudMC:MovieClip=cloudlist[i];
            cloudMC.dispose();
            cloud.removeFromParent(true);

        }
//
//        bgEffectImg.removeFromParent(true);
//        titleIcon.removeFromParent(true);
//        relactionInfo.removeFromParent(true);
//        apPanel.removeFromParent(true);
//
//        if (com == "Leave") {
//            character.removeFromParent(true);
//            mainProfile.removeFromParent(true);
//        }
    }

    private function onReadyToChangeScene():void {

        Starling.juggler.remove(delayTween);
        DebugTrace.msg("DatingScene.onReadyToChangeScene com=" + com);

        //enabled=true can commmit command
        var _data:Object = new Object();
        _data.com = com;
        this.dispatchEventWith(DatingScene.COMMIT, false, _data);


    }

    private var chats:Array;

    private function confirmDating():void {
        /*
         acquaintance      X
         new friend    1600
         friend   1200
         clsoe firned  800
         dating partner    400
         lover         200
         spouse          100
         mood/rel=x/100
         */
        var relExp:Object =
        {
            "acquaintance": 1600,
            "friend": 1200,
            "close friend": 800,
            "dating partner": 400,
            "lover": 200,
            "spouse": 100
        }

        var talking:Object = flox.getSyetemData("date_response");
        var dating:String = DataContainer.currentDating;
        var relObj:Object = flox.getSaveData("rel");
        var moodObj:Object = flox.getSaveData("mood");
        var pts:Object = flox.getSaveData("pts");
        var mood:Number = Number(moodObj[dating]);
        var honorObj:Object = flox.getSaveData("honor");
        var loveObj:Object=flox.getSaveData("love");
        var honor:Number = honorObj[dating];
        var rel:String = relObj[dating];
        var love:Number=loveObj.player;

        DebugTrace.msg("DatingScene.confirmDating dating:" + dating);
        DebugTrace.msg("DatingScene.confirmDating mood:" + mood + " ;rel:" + rel);


        goDating = Math.floor((mood * 100 / relExp[rel]));


        var result:Number = uint(Math.random() * 100) + 1;

        DebugTrace.msg("DatingScene.confirmDating goDating:" + goDating);
        DebugTrace.msg("DatingScene.confirmDating result:" + result);

        //fake
        //result=-1000;
        if (result <= goDating) {
            //success dating
            chats = talking.y;

            flox.save("dating", dating);

            var gameinfo:Sprite = ViewsContainer.gameinfo;
            var _data:Object = new Object();
            _data.dating = dating;
            gameinfo.dispatchEventWith("UPDATE_DATING", false, _data);
            DataContainer.currentDating=dating;

            reward_mood = Math.floor(love / 18);
//            mood += reward_mood;
//            moodObj[dating] = mood;
//            flox.save("mood", moodObj);

            dateBubble();
            actTransform("../swf/date.swf",onDateActComplete);


        }
        else {
            //lose dating
            chats = talking.n;
            dateBubble();
            command.addedCancelButton(this, doCancelDating);
        }
        //if

    }

    private function dateBubble():void {

        var index:Number = Math.floor(Math.random() * chats.length);
        chat = chats[index];
        initBubble();


    }

    private var bubbleTwwen:Tween;

    private function initBubble(attr:Object = null):void {


        var texture:Texture = Assets.getTexture("Bubble");

        bubble = new Sprite();
        var bubbleImg:Image = new Image(texture);
        bubbleImg.pivotX = bubbleImg.width / 2;
        bubbleImg.pivotY = bubbleImg.height / 2;
        bubbleImg.scaleX = -1;
        var maxSize:Number = 1;
        if (!attr) {

            bubble.x = 768;
            bubble.y = 260;

        } else {

            if (attr.scale) {
                maxSize = attr.scale;
            }
            bubble.x = attr.x;
            bubble.y = attr.y;
        }

        bubble.scaleX = 0;
        bubble.scaleY = 0;
        bubble.alpha = 0;
        bubble.addChild(bubbleImg);
        addChild(bubble);


        bubbleTwwen = new Tween(bubble, 0.5, Transitions.EASE_OUT_ELASTIC);
        bubbleTwwen.scaleTo(maxSize);
        bubbleTwwen.fadeTo(1);
        bubbleTwwen.onComplete = onBubbleComplete;
        Starling.juggler.add(bubbleTwwen);
    }

    private function onBubbleComplete():void {

        Starling.juggler.remove(bubbleTwwen);

        chatTxt = new TextField(245, 145, chat);
        chatTxt.format.setTo( font, 20, 0x000000,"left");
        chatTxt.x = -120;
        chatTxt.y = -88;
        bubble.addChild(chatTxt);


    }

    private function doCancelDating():void {
        character.removeFromParent(true);

        var _data:Object = new Object();
        _data.name = DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED, _data);


    }

    private function getTexture(src:String):Texture {
        var textture:Texture = Assets.getTexture(src);
        return textture;
    }

    private var actSrc:String;
    private var actCallBack:Function;
    private var delayCall:DelayedCall;
    private function actTransform(src:String, callback:Function=null):void {

        actSrc = src;
        actCallBack = callback;

        tweenID= Starling.juggler.delayCall(onTransformDelayTimeOut,1);

    }

    private function onTransformDelayTimeOut():void {

        Starling.juggler.removeByID(tweenID);

        mediacom.SWFPlayer("transform", actSrc, actCallBack);

    }

    private function onGiftActComplete():void {

        //Gift Formula
        var rating:Number = command.searchAssetRating(item_id);
        chat = DataContainer.getGiftResponse(rating);
        initBubble();

        var dating:String = DataContainer.currentDating;
        reward_mood = Number(command.moodCalculator(item_id, dating));


        updateMood();
        startPaticles();

    }

    private function onDateActComplete():void {


        DebugTrace.msg("DatingScene.onDateActComplete reward_mood=" + reward_mood);
        bubble.removeFromParent(true);

        updateMood();

        //drawcom.updatePieChart(mood);
//        var _data:Object = new Object();
//        _data.attr = "mood";
//        _data.values = "MOOD +" + reward_mood;
//        command.displayUpdateValue(this, _data);
        //command.addedCancelButton(this, doCancelDating);

    }

    private function specificChecking(com:String):Boolean {

        var success:Boolean = false;
        var relPass:Boolean = false;
        var moodPass:Boolean = false;
        var limitMood:Number = 0;
        var limitRel:Number = 0;
        var dating:String = DataContainer.currentDating;
        var relationship_level:Object=flox.getSyetemData("relationship_level");
        var mood_level:Object=flox.getSyetemData("mood_level");
        var ptsObj:Object=flox.getSaveData("pts");
        var pts:Number = ptsObj[dating];
        DebugTrace.msg("DatingScene.specificChecking com=" + com + " , mood=" + mood + " , pts=" + pts);
        cloudcom=com;
        switch (com) {
            case "Chat":
                relPass = true;
                limitMood = mood_level["annoyed-Min"];
                break;
            case "Give":
                relPass = true;
                limitMood = mood_level["depressed-Min"];
                break;
            case "Flirt":
                limitRel = relationship_level["datingpartner-Min"];
                limitMood = mood_level["smitten-Min"];
                break;
            case "TakePhoto":
                limitRel = relationship_level["friend-Min"];
                limitMood = mood_level["pleased-Min"];
                break;
            case "Date":
                limitRel = relationship_level["closefriend-Min"];
                limitMood = mood_level["delighted-Min"];
                break;
            case "Kiss":
                limitRel = relationship_level["lover-Min"];
                limitMood = mood_level["loved-Min"];
                break;
            case "Leave":
                relPass = true;
                moodPass = true;
//                var datingnow:String=flox.getSaveData("dating");
//                if(datingnow==""){
//                    DataContainer.currentDating=null;
//                }

                break

        }
        if (!relPass) {

            if (pts >= limitRel) {
                relPass = true;
            }

        }

        if (relPass || !moodPass) {

            if (mood >= limitMood) {
                moodPass = true;
            }

        }
        //************
        //moodPass = true;

        var attr:Object = new Object();
        attr.x = 640;
        attr.y = 132;
        if (!relPass) {

            if (!bubble) {
                chat = "Wait...\nWe are not that close!";
                initBubble(attr);
                bubbleFadeoutHandle();
            }

        }

        if (!moodPass) {

            if (!bubble) {
                chat = "Sorry!\nI am not in the mood.";
                initBubble(attr);
                bubbleFadeoutHandle();
            }


        }


        if (relPass && moodPass) {
            success = true;
        }
        return success

    }

    private function bubbleFadeoutHandle():void {

        var tween:Tween = new Tween(bubble, 0.5, Transitions.EASE_IN_OUT);
        tween.delay = 3;
        tween.scaleTo(0);
        tween.moveTo(mainProfile.x, mainProfile.y);
        tween.onComplete = onBubbleFadeoutComplete;
        Starling.juggler.add(tween);

    }

    private function onBubbleFadeoutComplete():void {

        Starling.juggler.removeTweens(bubble);
        try{
            bubble.removeFromParent(true);
            bubble = null;
        }catch(error:Error){
            DebugTrace.msg("DatingScene.onBubbleFadeoutComplete bubble error");
        }

    }

    private function onPhotosActComplete():void {


        var takephoto:TakePhotos = new TakePhotos();
        takephoto.name="TakePhoto";
        addChild(takephoto);

    }
    private var relationshipChaned:String="";

    private function doChandedRelactionshipHandle(e:Event):void{

        DebugTrace.msg("DatingScene.doChandedRelactionshipHandle change_type="+e.data.change_type);
        //raise, reduce
        var change_type:String=e.data.change_type;


        var point:Point=new Point();
        point.x=Starling.current.stage.stageWidth/2;
        point.y=Starling.current.stage.stageHeight/2;



        heartView=new Sprite();
        addChild(heartView);


        relationshipChaned=change_type+"_"+DatingScene.CHANGED_RELATIONSHIP;
        var ps:ParticleInterface = new ParticleSystem();
        ps.init(heartView,relationshipChaned,point);
        ps.showParticles();


        var texture:Texture=Assets.getTexture("RelationshipChangedTexture");
        var txtImage:Image=new Image(texture);
        txtImage.pivotX=txtImage.width/2;
        txtImage.pivotY=txtImage.height/2;
        txtImage.x=point.x;
        txtImage.y=point.y;
        heartView.addChild(txtImage);



        var tween:Tween=new Tween(txtImage,1,Transitions.EASE_OUT_ELASTIC);
        tween.animate("scaleX",0.2);
        tween.animate("scaleY",0.2);
        tween.scaleTo(1.2);
        tween.animate("alpha",0.7);
        tween.animate("alpha",1);
        if(change_type=="reduce")
            tween.animate("color",0x00FFFF);
        tween.onComplete=onTxtImageComplete;
        Starling.juggler.add(tween);
        function onTxtImageComplete():void{
            Starling.juggler.removeTweens(txtImage);
        }

        var dating:String=DataContainer.currentDating;
        var rel:String=flox.getSaveData("rel")[dating];
        //DebugTrace.msg("DatingScene.doChandedRelactionshipHandle rel="+rel);
        if(change_type=="raise" && rel!="acquaintance"){
            disabledSreenTouch();

            delayCall=new DelayedCall(onReadyShowPreciousPhoto,3);
            Starling.juggler.add(delayCall);
        }else{

            delayCall=new DelayedCall(onDowngradeRelationship,3);
            Starling.juggler.add(delayCall);


        }

    }
    private function onDowngradeRelationship():void{


        Starling.juggler.remove(delayCall);
        try{
            heartView.removeFromParent(true);
        }catch (e:Error){}

        this.dispatchEventWith(DatingScene.NONE_RELATIONSHIP);


    }

    private function onReadyShowPreciousPhoto():void {

        Starling.juggler.remove(delayCall);

        try{
            heartView.removeFromParent(true);
        }catch (e:Error){}

        showupPreciousPhoto();

    }
    private var photo:Sprite;
    private var bg:Quad;
    private var imgloader:ImageLoader;
    private var preload:LoadingBuffer;
    private function showupPreciousPhoto():void{

        var domainPath:String= flox.getSyetemData("domainPrecious");
        var stageW:Number=Starling.current.stage.stageWidth;
        var stageH:Number=Starling.current.stage.stageHeight;

        var dating:String = DataContainer.currentDating;
        var rel:Object=flox.getSaveData("rel")[dating];
        if(rel=="close friend"){
            rel="closefriend"
        }else if(rel=="dating partner"){
            rel="dating";
        }
        var file:String=dating+"_"+rel;

        DebugTrace.msg("DatingScene.showupPreciousPhoto source="+domainPath+file+"1.jpg");

        photo=new Sprite();
        bg = new Quad( stageW,stageH, 0x000000 );
        bg.alpha=0;
        photo.addChild(bg);

        imgloader=new ImageLoader();
        imgloader.useHandCursor=true;
        imgloader.width=1024;
        imgloader.height=576;
        imgloader.y=90;
        imgloader.alpha=0;
        imgloader.source=domainPath+file+"1.jpg";
        imgloader.addEventListener(Event.COMPLETE, onPhotoLoadedComplete);
        photo.addChild(imgloader);

        var msg:String="Relationship level goes up!\n" +
                "View new photo(s) in your Precious Moments Collection!\n" +
                "Check his/her current location in your Contacts!";
        var txt:TextField=new TextField(stageW,60,msg);
        txt.format.setTo(font,18,0xFFFFFF);
        txt.autoScale=true;
        txt.y=stageH-txt.height;
        photo.addChild(txt);

        this.addChild(photo);


        preload=new LoadingBuffer();
        addChild(preload);

        bg.alpha=0.9;


    }
    private var photoMusic:SoundChannel;
    private function onPhotoLoadedComplete(e:Event):void{

        preload.removeFromParent(true);

        var tween:Tween=new Tween(imgloader,0.5,Transitions.EASE_IN);
        tween.fadeTo(1);
        tween.onComplete=onImageComplete;
        Starling.juggler.add(tween);
        function onImageComplete():void{
            Starling.juggler.removeTweens(imgloader);
        }


        var dating:String=DataContainer.currentDating;
        command.playBackgroudSound(dating+"Music");
        //photoMusic=command.playSound(dating+"Music");


        delayCall=new DelayedCall(onShowFinished,10);
        Starling.juggler.add(delayCall);

    }
    private function onShowFinished():void{

        command.stopBackgroudSound();
        Starling.juggler.remove(delayCall);

        var tween:Tween=new Tween(photo,1,Transitions.EASE_IN);
        tween.fadeTo(0);
        tween.onComplete=onPhotoFadeout;
        Starling.juggler.add(tween);


    }
    private function onPhotoFadeout():void{

        Starling.juggler.removeTweens(photo);
        bg.dispose();
        imgloader.dispose();
        photo.removeFromParent(true);
        if(screenview)
            screenview.removeFromParent(true);

        this.dispatchEventWith(DatingScene.NONE_RELATIONSHIP);

        startDatingTwinStory();

    }
    private function startDatingTwinStory():void{

        var twinflame:String=flox.getSaveData("twinflame");
        var dating:String=DataContainer.currentDating;
        var rel:Object=flox.getSaveData("rel");
        var current_rel:String=rel[dating];
        var datingtwin:Object=flox.getSaveData("datingtwin");
        var _data:Object = new Object();
        if(twinflame==dating){
            if(datingtwin[current_rel]){
                var twinstory:Object=datingtwin[current_rel];
                var enabled:Boolean=twinstory.enabled;
                if(enabled){

                    var id:String=twinstory.id;
                    DataContainer.DatingTwinID=id;


                    _data.name="DatingTwinScene";
                    command.sceneDispatch(SceneEvent.CHANGED, _data);
                }
            }
        }else{

            _data.name="DatingScene";
            command.sceneDispatch(SceneEvent.CHANGED, _data);

        }

    }
    private function doNoneRelationshipHandle(e:Event):void{



        if(cloudcom=="Chat"){

            var datingscene:Sprite=ViewsContainer.datingScene;
            datingscene.dispatchEventWith("DATING_CHAT_COMPLETE");

        }else{

            try{
                screenview.removeFromParent(true);
            }catch(e:Error){}

            var _data:Object=new Object();
            _data.name=DataContainer.currentLabel;
            command.sceneDispatch(SceneEvent.CHANGED,_data);

        }


    }
    private var screenview:Quad;
    private function disabledSreenTouch():void{
        var stageW:Number=Starling.current.stage.stageWidth;
        var stageH:Number=Starling.current.stage.stageHeight;
        screenview=new Quad(stageW,stageH,0x000000);
        screenview.alpha=0;
        addChild(screenview);
    }

    private function onRemovedHandler(e:Event):void{
        DebugTrace.msg("DatingScene.onRemovedHandler");



        filters.doDispose();
        bgSprtie.removeFromParent(true);
        bgEffectImg.removeFromParent(true);
        titleIcon.removeFromParent(true);
        relactionInfo.removeFromParent(true);
        apPanel.removeFromParent(true);


        character.removeFromParent(true);
        mainProfile.removeFromParent(true);

    }
    private function twinflameWarning():void{
        var attr:Object = new Object();
        attr.x = 640;
        attr.y = 132;

        var relLv:Object=flox.getSyetemData("relationship_level");
        var twinflame:String=flox.getSaveData("twinflame");
        var dating:String=DataContainer.currentDating;
        var ptsObj:Object=flox.getSaveData("pts");
        var pts:Number=ptsObj[dating];

        if (!bubble && !twinflame && pts==relLv["closefriend-Max"]) {
            chat = "I'm not looking to date anyone right now \n" +
                    "(can only further improve relationship after SSCC Gala Dinner).";
            initBubble(attr);
            bubbleFadeoutHandle();
        }


    }
}
}