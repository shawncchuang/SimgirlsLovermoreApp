package controller {

import com.greensock.TweenLite;
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.shortybmc.data.parser.CSV;

import data.StoryDAO;
import flash.display.Bitmap;
import flash.display.MovieClip;

import flash.desktop.NativeApplication;
import flash.events.ContextMenuEvent;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.net.URLRequest;
import flash.system.System;
import flash.text.TextFormat;
import flash.ui.ContextMenu;
import flash.ui.ContextMenuItem;
import flash.display.StageQuality;
import flash.ui.Keyboard;

import data.Config;
import data.DataContainer;
import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;



import model.BattleData;
import model.SaveGame;
import services.LoaderRequest;

import starling.animation.DelayedCall;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.KeyboardEvent;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;


import utils.DebugTrace;
import utils.DrawManager;
import utils.ViewsContainer;
import views.AlertMessage;
import views.CommandCloud;
import views.FloxManagerView;
import views.DatingScene;
import views.PopupManager;
import views.RandomBattlePopup;
import views.Reward;


public class MainCommand implements MainInterface {




    private var item:flash.display.MovieClip;
    private static var alertmsg:flash.display.MovieClip=null;
    private static var csv:CSV;
    private var ch_talk_csv:CSV;
    private var schedule_csv:CSV;
    private var main_story:CSV;
    private var loading:flash.display.MovieClip;
    private static var bgsound_channel:SoundChannel=new SoundChannel();
    private var sound_channel:SoundChannel;
    private var switch_verify:Boolean = false;
    //private var fliter:FilterInterface=new FilterManager();
    private var resetdely:DelayedCall;

    public function updateInfo():void{
        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");
    }

    public function sceneDispatch(type:String, data:Object = null):void {
        var mainstage:Sprite = ViewsContainer.MainStage;
        // mainstage.dispatchEvent(new SceneEvent(type,true,false,data));
        mainstage.dispatchEventWith(type, false, data);
    }

    public function topviewDispatch(type:String, data:Object = null):void {
        var target:Sprite = ViewsContainer.currentScene;
        target.dispatchEvent(new TopViewEvent(type, true, false, data));
    }

    public static function set BgSoundChannel(ch:SoundChannel):void {
        bgsound_channel = ch;
    }

    public static function get BgSoundChannel():SoundChannel {
        return bgsound_channel;
    }

    public function addDisplayObj(current:String, target:String):void {
        DebugTrace.msg("MainCommand.addDisplayObj  current="+current+" ,target="+target);
        var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
        var txt:String = "";
        var target_pos:String = "";
        if (target.indexOf("_") != -1) {
            if (target.split("_")[2] != undefined) {
                target_pos = "_" + target.split("_")[2];
            }
            txt = target.split("_")[1] + target_pos;
            target = target.split("_")[0];
        }
        var style:String = current + "_" + target;
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;

        DebugTrace.msg("MainCommand.addDisplayObj txt:" + txt+" ; style:"+style);

        switch (target) {
            case "ComCloud":

                var curreent_scene:Sprite=ViewsContainer.currentScene;
                var comcloud:Sprite=new CommandCloud(txt);
                curreent_scene.addChild(comcloud);
                var clouds:Array=ViewsContainer.CurrentClouds;
                clouds.push(comcloud);
                ViewsContainer.CurrentClouds=clouds;

                break
        }
        switch (style) {
            /*d
             case "TarotReading_ComCloud":
             case "AirportScene_ComCloud":
             gameEvent.data=txt;
             gameEvent._name="comcloud";
             gameEvent.displayHandler();
             break;*/
            case "Story_QA":
            case "TarotReading_QA":
            case "AirplaneScene_QA":
                gameEvent._name = "QA";
                gameEvent.qa_label = txt;
                gameEvent.displayHandler();
                break;
            case "TarotReading_TarotCards":
                gameEvent._name = "tarot_cards";
                gameEvent.displayHandler();
                break
            case "Story_twinflame":
            case "StoryPreview_twinflame":
                var _data:Object=new Object();
                _data.type=style;
                var mainStage:Sprite=ViewsContainer.MainStage;
                mainStage.dispatchEventWith(SceneEvent.DISPLAY,false,_data);
                break

        }

        //switch
        if (txt.indexOf("battle") != -1) {
            gameEvent._name = "QA";
            gameEvent.qa_label = txt;
            gameEvent.displayHandler();
        }
        //if
    }

    public function addLoadind(msg:String):void {
        var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
        loading = new LoadingAni();
        loading.txt.text = msg;
        topview.addChild(loading);

    }

    public function removeLoading():void {
        var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
        try {
            topview.removeChild(loading);
        }
        catch (e:Error) {
            DebugTrace.msg("MainCommand.removeLoading Null");

        }
    }

    private var att_msg:String;
    //private var att:Boolean=false;
    public function addAttention(msg:String):void {
        att_msg = msg;
        //var topview:flash.display.MovieClip=SimgirlsLovemore.topview;
        DebugTrace.msg("MainCommand.addAttention swfloader");

        // var swfLoader:SWFLoader=LoaderMax.getLoader("attention");
        //trace( swfLoader)
        /*if(swfLoader)
         {
         var  loaderQueue:LoaderMax=ViewsContainer.loaderQueue;
         loaderQueue.remove(swfLoader);
         }*/
        var topview:flash.display.MovieClip = ViewsContainer.battleTop;
        var loaderReq:LoaderRequest = new LoaderRequest();
        loaderReq.setLoaderQueue("attention", "../swf/attention.swf", topview, onAttentionComplete);

        //var command:MainInterface = new MainCommand();
        playSound("ErrorSound");

    }

    private function onAttentionComplete(e:LoaderEvent):void {

        DebugTrace.msg("MainCommand.onAttentionComplete att_msg=" + att_msg);
        //var content:ContentDisplay=LoaderMax.getContent("attention");
        var swfloader:SWFLoader = LoaderMax.getLoader("attention");
        var attMC:flash.display.MovieClip = swfloader.getSWFChild("att") as flash.display.MovieClip;

        try {
            attMC.msg.text = att_msg;
            attMC.mouseChildren = false;
            attMC.addEventListener(MouseEvent.CLICK, doColseAttention);


        }
        catch (e:Error) {
            DebugTrace.msg("MainCommand.onAttentionComplete swfloader ERROR");
            //LoaderMax.getLoader("attention").unload();
            //var queue:LoaderMax=ViewsContainer.loaderQueue;
            //queue.unload();
            //swfloader.unload();
            var battleScene:flash.display.Sprite = ViewsContainer.battlescene;
            var battletop:flash.display.MovieClip = ViewsContainer.battleTop;
            battleScene.removeChild(battletop);

            battletop = new flash.display.MovieClip();
            battleScene.addChild(battletop);
            ViewsContainer.battleTop = battletop;
        }
        //try
    }

    private function doColseAttention(e:MouseEvent):void {


        LoaderMax.getLoader("attention").unload();

    }
    public function showSaveError(attr:String,data:*,msg:String):void{

        if(!DataContainer.popupMessage){

            var popup:PopupManager=new PopupManager();
            popup.attr=attr;
            popup.data=data;
            popup.msg=msg;
            popup.init();
        }

    }

    public static function addAlertMsg(msg:String):void {

        DebugTrace.msg("MainCommand.addAlertMsg msg="+msg);
        //if(alertmsg){
            var format:TextFormat = new TextFormat();
            format.size = 20;
            format.align = "center";
            format.font = "SimFutura";
            var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
            alertmsg = new AlertMsgUI();
            alertmsg.name = "alert";
            alertmsg.msg.embedFonts = true;
            alertmsg.msg.defaultTextFormat = format;
            alertmsg.confirm.buttonMode = true;
            alertmsg.cancelbtn.visible=false;
            //alertmsg.mouseChildren = false;
            alertmsg.confirm.addEventListener(MouseEvent.MOUSE_DOWN, doColseAlertmsg);
            alertmsg.x = 1024 / 2;
            alertmsg.y = 768 / 2;
            alertmsg.msg.text = msg;
            topview.addChild(alertmsg);

       // }


        //var command:MainInterface=new MainCommand();
        //command.playSound("ErrorSound");

    }

    public static function sysAlert(type, msg:String):void {

        var format:TextFormat = new TextFormat();
        format.size = 20;
        format.align = "center";
        format.font = "SimFutura";
        var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
        alertmsg = new AlertMsgUI();
        alertmsg.name = "alert";
        alertmsg.msg.embedFonts = true;
        alertmsg.msg.defaultTextFormat = format;
        alertmsg.confirm.buttonMode = true;
        alertmsg.confirm.visible = true;
        alertmsg.cancelbtn.visible = false;
        switch (type) {
            case "warning":
                alertmsg.confirm.addEventListener(MouseEvent.MOUSE_DOWN, doColseAlertmsg);
                break
            case "maintaining":
                alertmsg.confirm.addEventListener(MouseEvent.MOUSE_DOWN, doQuictGame);
            function doQuictGame(e:MouseEvent):void {
                NativeApplication.nativeApplication.exit();

            }

                break
        }

        alertmsg.x = 1024 / 2;
        alertmsg.y = 768 / 2;
        alertmsg.msg.text = msg;
        alertmsg.alpha = 0;
        topview.addChild(alertmsg);

        TweenLite.to(alertmsg, 0.5, {alpha: 1});

        //
    }


    public static function addTalkingMsg(msg:String):void {

        var format:TextFormat = new TextFormat();
        format.align = "left";
        var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
        alertmsg = new AlertTalkingUI();
        alertmsg.name = "alert";
        alertmsg.msg.defaultTextFormat = format;

        alertmsg.cancelbtn.addEventListener(MouseEvent.CLICK, doColseAlertmsg);
        alertmsg.x = 1024 / 2;
        alertmsg.y = 768 / 2;
        alertmsg.msg.text = msg;
        topview.addChild(alertmsg);

    }

    private static function doColseAlertmsg(e:MouseEvent):void {
        var topview:flash.display.MovieClip = SimgirlsLovemore.topview;
        var _alert:flash.display.MovieClip = topview.getChildByName("alert") as flash.display.MovieClip;
        try{
            topview.removeChild(_alert);
            alertmsg=null;
        }catch (e:Error){}

    }

    public static function initPreOrderAccount():void {
        csv = new CSV();
        //csv.headerOverwrite = false
        //csv.header = ['Email'];

        csv.addEventListener(Event.COMPLETE, completePreOrderAccount);
        csv.load(new URLRequest('csv/member_emails.csv'));

    }

    private static function completePreOrderAccount(e:Event):void {
        //var emails:Array=csv.header[0].split("\n");
        var emails:Array = csv.data;
        DebugTrace.msg("completeBlackPreasAccount:\n" + csv.data);
        DebugTrace.msg("completeBlackPreasAccount:" + emails[0]);
        Config.AccType = "";
        if (emails.indexOf(FloxCommand.my_email) != -1) {
            Config.AccType = "blackspears";
        }
        //if
        /*var floxcom:FloxInterface=new FloxCommand();
         var _data:Object=new Object();
         _data.from=Config.AccType;
         floxcom.savePlayer(_data);*/
        if (emails.length > 0) {
            DataContainer.MembersMail = emails;
            var floxMg:FloxManagerView = ViewsContainer.FloxManager;
            floxMg.currentAccount();
        }
        DebugTrace.msg("MainCommand.completePreOrderAccount emails="+JSON.stringify(emails));
    }

    public function initSceneLibrary():void {
        ch_talk_csv = new CSV();
        ch_talk_csv.addEventListener(Event.COMPLETE, onChTalkLibrary);
        ch_talk_csv.load(new URLRequest('csv/scenelibrary.csv'));

    }

    private function onChTalkLibrary(e:Event):void {
        //trace("onChTalkLibrary library:")
        //DebugTrace.msg("MainCommand.onChTalkLibrary :"+ch_talk_csv.dump());

        var library:Array = ch_talk_csv.data;
        for (var i:uint = 0; i < library.length; i++) {
            var _header:Array = library[i];
            library[i] = filterTalking(_header);

        }
        //for
        //DataContainer.characterTalklibrary=library;
        //initSchedule();
        var flox:FloxInterface = new FloxCommand();
        flox.saveSystemData("scenelibrary", library);
    }

    public function filterTalking(source:Array):Array {
        var sentances:Array = new Array();
        for (var i:uint = 0; i < source.length; i++) {
            var re:String = source[i];
            if (re.charAt(0) == '"') {
                var _re:String = re.split('"').join("");
                source[i] = _re
            }
            if (re.charAt(re.length - 1) == '"') {
                _re = re.split('"').join("");
                source[i] = _re;
            }
            if (source[i] != "") {
                sentances.push(source[i]);
            }
        }

        return sentances;
    }

    public function initSchedule():void {
        schedule_csv = new CSV();
        schedule_csv.addEventListener(Event.COMPLETE, onScheduleComplete);
        schedule_csv.load(new URLRequest('csv/schedule.csv'));


    }

    private function onScheduleComplete(e:Event):void {
        //trace("MainCommand.onScheduleComplete :"+schedule_csv.dump());
        var schedule:Array = schedule_csv.data;
        for (var i:uint = 0; i < schedule.length; i++) {

            var months:Array = schedule[i];
            months.shift();
            schedule[i] = months;
            //DebugTrace.msg(months.toString()+" ; length:"+months.length);
        }
        //DataContainer.scheduleListbrary=schedlue;

        var flox:FloxInterface = new FloxCommand();
        flox.saveSystemData("schedule", schedule);

    }

    public function initMainStory():void {

        main_story = new CSV();
        main_story.addEventListener(Event.COMPLETE, onMainStoryComplete);
        main_story.load(new URLRequest('csv/main_story_scenes.csv'));
    }

    private function onMainStoryComplete(e:Event):void {
        var stories:Array = main_story.data;
        for (var i:uint = 0; i < stories.length; i++) {

            var story:Array = stories[i];
            stories[i] = filterTalking(story);
            DebugTrace.msg("MainCommand.onMainStoryComplete story=" + filterTalking(story) + " ; length:" + story.length);
        }

        var flox:FloxInterface = new FloxCommand();
        flox.saveSystemData("main_story", stories);

    }

    public function playBackgroudSound(src:String, st:SoundTransform = null):void {
        //DebugTrace.msg("playBackgroudSound:"+src);
        //var assets:Assets=new Assets();
        //assets.initMusicAssetsManager(src);
        //bgsound_channel=new SoundChannel();
        var mute:Boolean = SoundController.Mute;
        if(mute){
            st=new SoundTransform(0,0);
        }else{
            st=new SoundTransform(0.5,0);
        }
        bgsound_channel = Assets.MusicManager.playSound(src, 0, 1000, st);


    }
    private var bgSoundTween:TweenMax;
    public function stopBackgroudSound():void {


        if(bgsound_channel)
        {
            bgSoundTween=new TweenMax(bgsound_channel,0.5,{volume:0,onComplete:stopBgSound});
        }
        function stopBgSound():void{


            TweenMax.killTweensOf(bgSoundTween);

        }

    }
    public function playSound(src:String, repeat:Number = 0, st:SoundTransform = null):SoundChannel {


        var mute:Boolean = SoundController.Mute;

        if (!mute) {

            sound_channel = Assets.SoundManager.playSound(src, 0, repeat, st);

        }
        return sound_channel;

    }

    public function stopSound(name:String):void {

        if(sound_channel){
            sound_channel.stop();
        }

    }

    public function verifySwitch():Boolean {
        /*
         var flox:FloxInterface=new FloxCommand();
         var switchID:String=flox.getSaveData("current_switch");
         var switchs:Object=flox.getSyetemData("switchs");
         var values:Object=switchs[switchID];
         */
        var scencom:SceneInterface = new SceneCommnad();
        switch_verify = scencom.switchGateway("Rest||Stay");

        return switch_verify

    }

    private var overday:Boolean;

    public function dateManager(type:String):void {
        //start Tur.1.Mar.2033|12
        DebugTrace.msg("MainCommand.dateManager  type:" + type);
        var Days:Array=Config.Days;
        var Monthslist:Array=Config.Monthslist;
        var Months:Object=Config.Months;

        var flox:FloxInterface=new FloxCommand();
        var dateStr:String = flox.getSaveData("date");
        var dayStr:String = dateStr.split("|")[0];
        var _day:String = dayStr.split(".")[0];
        var _data_index:Number = Days.indexOf(_day);
        var _date:Number = Number(dayStr.split(".")[1]);
        var _de_month:String = "";
        var _month:String = _de_month = dayStr.split(".")[2];
        var _year:Number = Number(dayStr.split(".")[3]);
        var timeNum:Number = Number(dateStr.split("|")[1]);
        var _type:String = type;
        overday = false;
        if (type.indexOf("Stay") != -1) {

            _type = "Stay";
        }
        switch (_type) {
            case "Rest":
                timeNum += 12;

                if (timeNum > 24) {
                    // over day
                    overday = true;
                    timeNum = 12;
                    _date++;
                    _data_index++;

                    var dataCon:DataContainer=new DataContainer();
                    var scenelikes:Object=dataCon.initChacacterLikeScene();
                    var secrets:Object=dataCon.setupCharacterSecrets();
                    flox.save("scenelikes",scenelikes);
                    flox.save("secrets",secrets);
                    //savegame.scenelikes=scenelikes;
                    //savegame.secrets=secrets;

                }
                //if


                break;
            case "Stay":
                var stay_days:Number = Number(type.split("Stay").join(""));
                _date += stay_days;
                _data_index += stay_days;
                new DataContainer().initChacacterLikeScene();

                praseOwnedAssets(stay_days);
                reseatDating();
                break

        }
        //switch
        DebugTrace.msg("MainCommand.dateManager  _data_index:" + _data_index);
        var month_index:uint = Monthslist.indexOf(_month);
        if (_data_index >= Days.length) {
            _data_index -= Days.length;
        }
        if (_date > Months[_month]) {
            _date = 1;

            month_index++;
            if (month_index > Monthslist.length - 1) {
                //Cross Year
                month_index = 0;
                _year++;
            }
            //if
            _month = Monthslist[month_index];
        }
        //if
        var dateIndex:Object = {"date": _date - 1, "month": month_index};
        DataContainer.currentDateIndex = dateIndex;
        var __date:Date=new Date(_year,month_index,_date);
        _data_index=__date.getDay();
        var new_date:String = Days[_data_index] + "." + _date + "." + _month + "." + _year + "|" + timeNum;

        DebugTrace.msg("MainCommand.dateManager  new_date:" + new_date+" , overday:"+overday);
        var _data:Object = new Object();
        _data.date = new_date;
        flox.save("date", new_date);
        healSpiritEngine();
        if (overday) {
            reseatDating();
            setNowMood();
            praseOwnedAssets(1);
            reseatDatingCommandTimes();
            submitDailyReport();
            initCriminalsRecord();
            initDailyUpgrade();
        }

        if (comType == "Rest") {

            _data = new Object();
            var scene:Sprite = ViewsContainer.currentScene;
            _data.removed = "ani_complete";
            scene.dispatchEventWith(TopViewEvent.REMOVE, false, _data);
            comType = "";

            if(timeNum==24){
                var battleData:BattleData=new BattleData();
                battleData.checkBattleSchedule("CpuBattleRanking","cpu_team");
            }

            var current_switch:String=flox.getSaveData("current_switch");
            if(current_switch=="s1427_1|on"){
                checkFinalRankingBattle();
            }
            if(new_date=="Tue.14.Feb.2034|12"){

                checkTwinFlamePts();
            }

        }


        var pay:Boolean = flox.getPlayerData("paid");
        if (!pay && _type != "Rest" && _type != "Stay") {
            //didn't pay this game
            var deadline:Number = Config.deadline;
            for (var k:uint = Monthslist.indexOf(_de_month); k < Monthslist.length; k++) {
                var monthdays:Number = Months[Monthslist[k]];
                //DebugTrace.msg("MainCommand.dateManager monthdays:"+monthdays);
                if (deadline > monthdays) {
                    deadline -= monthdays;
                    //DebugTrace.msg("MainCommand.dateManager pay_day:"+pay_day);
                    var end_month:String = Monthslist[k];
                    var end_date:Number = deadline;
                }
                else {
                    end_month = _month;
                    end_date = deadline;
                    break
                }
                //if
            }
            //for
            DebugTrace.msg("MainCommand.dateManager  end_month:" + end_month + "; end_day:" + end_date);
            DebugTrace.msg("MainCommand.dateManager  _type:" + _type);
            if (Monthslist.indexOf(_month) >= Monthslist.indexOf(end_month) && _date >= end_date) {
                //deadline
                DataContainer.deadline = true;
                var mainstage:Sprite = ViewsContainer.MainStage;
                mainstage.broadcastEventWith("PAY_CHECK");


            }
            //if
        }
        //if
        if (_month == "Nov" && _date==2) {
            //season 2 upgrade cpu team se

            var cpucom:CpuMembersInterface = new CpuMembersCommand();
            cpucom.upgradeCpu();


        }


    }

    private function praseOwnedAssets(days:Number):void {
        var flox:FloxInterface = new FloxCommand();
        var ownedAssets:Object = flox.getSaveData("owned_assets");
        for (var ch:String in ownedAssets) {
            var assetslist:Array = ownedAssets[ch];

            for (var i:uint = 0; i < assetslist.length; i++) {

                if (assetslist[i].expiration > 0) {
                    var expr:Number = assetslist[i].expiration;
                    expr -= days;
                    assetslist[i].expiration = expr;
                }
                //if
                ownedAssets[ch] = assetslist;
            }
            //for

        }
        //for

        for (var _ch:String in ownedAssets) {
            assetslist = ownedAssets[_ch];

            for (var j:uint = 0; j < assetslist.length; j++) {
                expr = assetslist[j].expiration;
                if (expr <= 0) {
                    var _assetslist:Array = assetslist.splice(j);
                    _assetslist.shift();
                    var new_assetslist:Array = assetslist.concat(_assetslist);
                    ownedAssets[_ch] = new_assetslist;
                }
                //if
            }
            //for

        }
        //for
        var assetesStr:String = JSON.stringify(ownedAssets);
        DebugTrace.msg("MainComanad.praseOwnedAssets assetesStr:" + assetesStr);

        flox.save("owned_assets", ownedAssets)

    }

    private function reseatDatingCommandTimes():void {

        var playerConfig:Object = Config.PlayerAttributes();
        var command_dating:Object = playerConfig.command_dating;
        var flox:FloxInterface = new FloxCommand();
        flox.save("command_dating", command_dating);

    }

    public function filterScene(target:Sprite):void {
        //day night filter
        var currentScene:String = DataContainer.currentScene;
        var scene:Sprite = ViewsContainer.MainScene;
        //var scene_container:Sprite=scene.getChildByName("scene_container") as Sprite;
        var scene_container:Sprite = target;
        var savedata:SaveGame = FloxCommand.savegame;
        var dateStr:String = savedata.date.split("|")[1];
        DebugTrace.msg("MainCommand.filterScene currentScene:" + currentScene + " dateStr:" + dateStr);
        if (currentScene == "MainScene" && dateStr == "24") {
            var bg:starling.display.MovieClip = scene_container.getChildByName("bg") as starling.display.MovieClip;
            try {
                bg.removeFromParent(true);
            } catch (e:Error) {
                DebugTrace.msg("MainCommand.filterScene bg=NUll");

            }
            //var night_bg:starling.display.MovieClip=Assets.getDynamicAtlas("MainSceneNight");
            var mapTextute:Texture = Assets.getTexture("MainBgNight");
            var night_bg:Image = new Image(mapTextute);
            scene_container.addChild(night_bg);
        }
        else {
            if (dateStr == "24") {
                //night
//                var nightSprtie:Sprite = new Sprite();
//                nightSprtie.flatten();
//                var maskTexture:Texture = Assets.getTexture("Whitebg");
//                var nightmask:Image = new Image(maskTexture);
//                nightmask.color = Color.BLACK;
//                nightmask.width = scene_container.width;
//                nightmask.height = scene_container.height;
//                nightmask.alpha = 0.5;
//                nightSprtie.addChild(nightmask);
//                scene_container.addChild(nightSprtie);

            }
        }

    }

    public function listArrowEnabled(index:Number, pages:Number, left:*, right:*):void {

        left.visible = true;
        right.visible = true;
        var end_node:Number = index;

        if (index <= 0) {
            left.visible = false;
        }
        //if
        if (index == pages - 1) {
            right.visible = false;
        }
        //if
        if (pages <= 1) {
            left.visible = false;
            right.visible = false;
        }
        //if
    }

    public function setNowMood():void {

        var flox:FloxInterface = new FloxCommand();
        var moods:Object = flox.getSaveData("mood");
        var rel:Object=flox.getSaveData("rel");
        var maintainDecline:Object = {"close friend":-111,"dating partner":-222,"lover":-333,"spouse":-333};
        for(var _name:String in rel){
            switch(rel[_name]){
                case "close friend":
                case "dating partner":
                case "lover":
                case "spouse":
                        var uptoMood:Number=Math.abs(maintainDecline[rel[_name]])*2;
                        if(moods[_name]>uptoMood){
                            moods[_name]=uptoMood;
                        }else{
                            moods[_name]+=maintainDecline[rel[_name]];
                        }
                    break
            }
            if(moods[_name]<-9999){
                moods[_name]=-9999;
            }
        }
        //DebugTrace.msg("MainCommand.serNowMood="+JSON.stringify(moods));
        flox.save("mood", moods);


    }

    public function initStyleSchedule(callback:Function=null):void {

        var suitup:Object = new Object();
        var characters:Array = Config.allCharacters;
        var flox:FloxInterface = new FloxCommand();
        var date:String = flox.getSaveData("date").split("|")[0];
        var styles:Object = flox.getSyetemData("style_schedule");
        var _name:String = DataContainer.currentDating;
        var style:String = "";
        var normalStyles:Object=Config.styles;
        var scenes:Array=Config.allScenes;
        var styleNames:Array=new Array();
        var currentScene:String=DataContainer.currentScene;
        var shortcutsScene:String=DataContainer.shortcutsScene;
        var current_scene:String=currentScene.split("Scene").join("");

        if (style == "") {
            //normal day ,depends on located
            var scene_index:Number=scenes.indexOf(current_scene);
            if(scene_index==-1){
                styleNames=["casual1"];
            }
            else {
                styleNames=normalStyles[_name+"_"+current_scene];
            }

            if(styleNames){
                style=_name+"_"+styleNames[0];
                if(styleNames.length>1){
                    style=_name+"_"+styleNames[Math.floor(Math.random()*styleNames.length)];
                }
            }
            suitup[_name] = style;
        }
        //DebugTrace.msg("MainCommand.initStyleSechedule shortcutsScene="+shortcutsScene);
        if(shortcutsScene=="ProfileScene" || shortcutsScene=="AcademyScene"){
            suitup = new Object();

            for (var j:uint = 0; j < characters.length; j++) {

                _name=characters[j];
                styleNames=new Array();
                styleNames=normalStyles[_name+"_"+scenes[Math.floor(Math.random()*scenes.length)]];
                if(styleNames.length<1){
                    styleNames.push("casual1");
                }
                style=_name+"_"+styleNames[0];
                if(styleNames.length>1){
                    style=_name+"_"+styleNames[Math.floor(Math.random()*styleNames.length)];
                }
                // DebugTrace.msg("MainCommand.initStyleSechedule style="+style);
                suitup[_name] = style;
            }

        }
        DebugTrace.msg("MainCommand.initStyleSechedule suitup="+JSON.stringify(suitup));
        DataContainer.styleSchedule = suitup;

        if(callback){
            callback();
        }
    }

    public function updateRelationship():void {

        var relMax:Number = 9999;
        var datingScene:Sprite=ViewsContainer.baseSprite;
        var flox:FloxInterface = new FloxCommand();
        var dating:String = DataContainer.currentDating;
        var relObj:Object = flox.getSaveData("rel");
        var ptsObj:Object = flox.getSaveData("pts");
        var loveObj:Object=flox.getSaveData("love");
        var love:Number=loveObj[dating];
        var playerlove:Number=loveObj.player;
        //var mood:Number = flox.getSaveData("mood")[dating];
        var pts:Number = Number(ptsObj[dating]);

        rewards=DataContainer.rewards;
        DebugTrace.msg("MianCommnand.updateRelationship rewards="+JSON.stringify(rewards));

        pts += Math.floor(rewards.mood / 15);

        if (pts > relMax) {
            pts = relMax;
        } else if (pts < -(relMax)) {
            pts = -(relMax);
        }

        var twinflame:String= flox.getSaveData("twinflame");
        //ahter owning twinflame could raise relationship
        if(twinflame =="" || !twinflame){
            var reStep:Object=flox.getSyetemData("relationship_level");
            var closefriendMax:Number=reStep["closefriend-Max"];
            if(pts>closefriendMax){
                pts=closefriendMax;
            }

        }
        ptsObj[dating] = pts;
        flox.save("pts",ptsObj);

        datingBonus(loveObj);

        var rel:String = DataContainer.getRelationship(pts, dating);
        var oldRel:String=relObj[dating];

        relObj[dating] = rel;
        flox.save("rel",relObj);

        if(oldRel!=rel){
            //relationship changed

            var oldLv:Number= Config.relHierarchy.indexOf(oldRel);
            var currentLv:Number=Config.relHierarchy.indexOf(rel);
            DebugTrace.msg("MainCommand.updateRelationship changed oldLv="+oldLv+", currentLv="+currentLv);
            var _data:Object=new Object();
            if(oldLv>currentLv){
                //reduce
                _data.change_type="reduce";

            }
            if(oldLv<currentLv){
                //raise
                _data.change_type="raise";
            }

            if(oldLv != currentLv){

                datingScene.dispatchEventWith(DatingScene.CHANGED_RELATIONSHIP,false,_data);
            }else{
                datingScene.dispatchEventWith(DatingScene.NONE_RELATIONSHIP);
            }

        }else{
            datingScene.dispatchEventWith(DatingScene.NONE_RELATIONSHIP);
        }


        // DebugTrace.msg("MainCommand.updateRelationship _data="+JSON.stringify(_data));


    }
    private function datingBonus(loveObj:Object):void{

        var flox:FloxInterface = new FloxCommand();
        var loveMax:Number=9999;
        var dating:String = DataContainer.currentDating;
        var love:Number=loveObj[dating];
        var playerlove:Number=loveObj.player;
        //love+=(Math.floor(pts/5));
        //playerlove+=(Math.floor(pts/5));
        //love player:80% ,dating target:100% , other characters:55%
        var adjust:Number=Math.floor(Math.random()*3);
        var loveReward:Number=Math.floor(rewards.mood /35);
        var CloveReward:Number=Math.floor(loveReward);
        var PloveReward:Number=Math.floor(loveReward);
        love+=loveReward;
        playerlove+=PloveReward;


        if(love > loveMax){
            love=loveMax;

        }else if(love<0){
            love=0;
        }
        if(playerlove > loveMax){
            playerlove=loveMax;

        }else if(playerlove<0){
            playerlove=0;
        }

        loveObj[dating]=love;
        loveObj.player=playerlove;

        var seObj:Object=flox.getSaveData("se");

        for(var character:String in loveObj ){
            if(character!=dating && character!="player"){
                var chlove:Number=loveObj[character];
                chlove+=CloveReward;
                if(chlove > loveMax){
                    chlove=loveMax;

                }else if(chlove<0){
                    chlove=0;
                }
                loveObj[character]=chlove;

            }

            if(loveObj[character]<seObj[character]){
                seObj[character]=loveObj[character];
            }
        }



        var _data:Object = new Object();
        _data.love= loveObj;
        _data.se=seObj;
        flox.updateSavegame(_data);

    }

    public function moodCalculator(item_id:String, dating:String):Number {
        var flox:FloxInterface = new FloxCommand();
        var sysAssets:Object = flox.getSyetemData("assets");
        var price:Number = sysAssets[item_id].price;
        var rating:Number = searchAssetRating(item_id);
        var mood:Number = 100+Math.floor((300+price) * rating / 100);
        DebugTrace.msg("MainCommand.moodCalculator item_id="+item_id+", mood=" + mood + ", price=" + price + ", rating=" + rating);

        return mood
    }

    public function searchAssetRating(item_id:String):Number {

        var flox:FloxInterface = new FloxCommand();
        var dating:String = DataContainer.currentDating;
        var rating:Number=0;
        var assets_ratingData:Object = flox.getSaveData("assets");
        var assets_rating:Array = assets_ratingData[dating];
        DebugTrace.msg("MainCommand.searchAssetRating assets_rating.length="+assets_rating.length);

        for (var i:uint = 0; i < assets_rating.length; i++) {

            if (assets_rating[i][item_id] != null) {
                rating = Number(assets_rating[i][item_id]);
                break
            }
            //if
        }
        //for
        return rating;

    }

    //private var valueSprite:Sprite;
    private var apSprite:Sprite;
    private var cashSprite:Sprite;
    private var imageSprite:Sprite;
    private var intSprite:Sprite;
    private var moodSprite:Sprite;
    private var loveSprite:Sprite;
    private var rewardNode:Reward;

    public function displayUpdateValue(target:Sprite, _data:Object):void {
        //valueSprite=target;
        var attrlist:Array = _data.attr.split(",");
        var rewardlist:Array = _data.values.split(",");
        var stageCW:Number = Starling.current.stage.stageWidth / 2;
        var stageCH:Number = Starling.current.stage.stageHeight / 2;
        rewards=new Object();

        for (var i:uint = 0; i < attrlist.length; i++) {
            var attr:String = attrlist[i];
            var value:String = rewardlist[i];
            var posY:Number = i * 80;

            rewardNode = new Reward();
            rewardNode.index = i;
            rewardNode.type = attr;
            rewardNode.value = value;
            rewardNode.x = stageCW;
            rewardNode.y = stageCH - posY;
            rewardNode.addNode();
            target.addChild(rewardNode);


            if(value.indexOf("MOOD")!=-1 || value.indexOf("mood")!=-1){
                value=value.split("MOOD ").join("");
            }
            if(value.indexOf("+")!=-1){
                value=value.split("+").join("");
            }

            rewards[attr]=Number(value);

        }
        //for
        //DataContainer.rewards=rewards;

    }

    private var cancelbtn:Image;
    private var cancelOverTex:Texture;
    private var cancelUpTex:Texture;
    private var confirmbtn:Image;
    private var confirmOverTex:Texture;
    private var confirmUpTex:Texture;
    private var onTouchCancelBegan:Function;
    private var onTouchConfirmBegan:Function;

    public function addedConfirmButton(target:Sprite, callback:Function, pos:Point = null):void {
        onTouchConfirmBegan = callback;
        confirmOverTex = Assets.getTexture("CheckAltOver");
        confirmUpTex = Assets.getTexture("CheckAltUp");
        confirmbtn = new Image(confirmUpTex);
        confirmbtn.useHandCursor = true;
        confirmbtn.name = "confirm";
        confirmbtn.pivotX = confirmbtn.width / 2;
        confirmbtn.pivotY = confirmbtn.height / 2;
        if (!pos) {
            confirmbtn.x = 904;
            confirmbtn.y = 717;
        }
        else {
            confirmbtn.x = pos.x;
            confirmbtn.y = pos.y;
        }
        confirmbtn.addEventListener(TouchEvent.TOUCH, onTouchConfirm);
        target.addChild(confirmbtn);
    }

    private function onTouchConfirm(e:TouchEvent):void {
        var target:Image = e.currentTarget as Image;
        var began:Touch = e.getTouch(target, TouchPhase.BEGAN);
        var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
        if (began) {

            try {
                onTouchConfirmBegan(e);
            }
            catch (e:Error) {
                onTouchConfirmBegan();
            }
            //try...catch

        }
        //if
        if (hover) {

            confirmbtn.texture = confirmOverTex;
        }
        else {
            confirmbtn.texture = confirmUpTex;
        }
        //if
    }

    public function addedCancelButton(target:Sprite, callback:Function, pos:Point = null):Image {

        onTouchCancelBegan = callback;
        cancelOverTex = Assets.getTexture("XAltOver");
        cancelUpTex = Assets.getTexture("XAltUp");
        cancelbtn = new Image(cancelUpTex);
        cancelbtn.useHandCursor = true;
        cancelbtn.name = "cancel";
        cancelbtn.pivotX = cancelbtn.width / 2;
        cancelbtn.pivotY = cancelbtn.height / 2;
        if (!pos) {
            cancelbtn.x = 970;
            cancelbtn.y = 717;
        }
        else {
            cancelbtn.x = pos.x;
            cancelbtn.y = pos.y;
        }
        //if
        cancelbtn.addEventListener(TouchEvent.TOUCH, onTouchCancel);
        target.addChild(cancelbtn);
        return cancelbtn
    }





    private function onTouchCancel(e:TouchEvent):void {
        var target:Image = e.currentTarget as Image;
        var began:Touch = e.getTouch(target, TouchPhase.BEGAN);
        var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
        if (began) {


            try {
                onTouchCancelBegan(e);
            }
            catch (e:Error) {
                onTouchCancelBegan();
            }
            //try...catch

        }
        //if
        if (hover) {

            cancelbtn.texture = cancelOverTex;
        }
        else {
            cancelbtn.texture = cancelUpTex;
        }
        //if
    }

    private var comType:String = "";

    public function doRest(free:Boolean,from:String=""):void {
        comType = "Rest";
        var flox:FloxInterface = new FloxCommand();
        var command:MainInterface = new MainCommand();
        var apMax:Number = flox.getSaveData("ap_max");
        var ap:Number = flox.getSaveData("ap");
        var cash:Number = flox.getSaveData("cash");
        var time:Number = Number(flox.getSaveData("date").split("|")[1]);
        var sysCommad:Object = flox.getSyetemData("command");
        var _data:Object = new Object();

        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();


        if (free) {
            var restObj:Object = sysCommad.FreeRest;
        }
        else {

            switch(from){
                case "Sail":
                    restObj = sysCommad[from];
                    break;
                default:
                    restObj = sysCommad.PayRest;
                    break
            }
            cash += restObj.values.cash;

            flox.save("cash", cash);
        }
        //if

        var rewardAP:Number = restObj.values.ap;

        ap += rewardAP;
        if (ap > apMax) {
            ap = apMax;
        }

        flox.save("ap", ap);
        onFinishAnimated();


        var evtObj:Object = new Object();
        var scene:String = DataContainer.currentScene;
        evtObj.command = "Rest@"+scene;
        flox.logEvent("CloudCommand", evtObj);
    }

    public function doStay(days:Number):void {
        comType = "Stay";
        var flox:FloxInterface = new FloxCommand();
        var command:MainInterface = new MainCommand();
        var ap:Number = flox.getSaveData("ap");
        var cash:Number = flox.getSaveData("cash");
        var sysCommad:Object = flox.getSyetemData("command");

        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();

        //var mediacom:MediaInterface = new MediaCommand();
        //mediacom.PlayVideo("rest-animated",ViewsContainer.currentScene, new Point(1024, 250), new Point(0, 260));
        //mediacom.play("video/rest-animated.flv", false, onFinishAnimated);

        var restObj:Object = sysCommad.Stay;
        var getAP:Number = restObj.ap;
        var value:Number = restObj.values.cash;
        //DebugTrace.msg("MainComnad.doStay days:"+days+" ; value:"+value);

        var pay:Number = value * days;
        var _data:Object = new Object();
        _data.cash = cash + pay;
        _data.ap = ap + getAP;
        flox.updateSavegame(_data);
        command.dateManager("Stay" + days);

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO", false);


    }

    public function doTrain():void {
        comType = "Train";

        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();


        var mediacom:MediaInterface = new MediaCommand();
        mediacom.SWFPlayer("transform", "../swf/workout.swf", onFinishAnimated);


        var savegame:SaveGame = new SaveGame();
        var flox:FloxInterface = new FloxCommand();
        var dating:String = flox.getSaveData("dating");
        var comObj:Object = flox.getSyetemData("command");

        var cash_pay:Number = comObj.Train.values.cash;
        var valuesImg:String = comObj.Train.values.image;
        var cash:Number = flox.getSaveData("cash");
        var ap:Number = flox.getSaveData("ap");
        var imageObj:Object = flox.getSaveData("image");
        var image:Number = imageObj.player;

        var _data:Object = new Object();

        var minImg:Number = Number(valuesImg.split("~")[0]) - 1;
        var maxImg:Number = Number(valuesImg.split("~")[1]);
        //DebugTrace.msg("MainCommand.doLearn sysCommand="+JSON.stringify(sysCommand));

        var reward_img:Number = minImg + Math.floor(Math.random() * (maxImg - minImg)) + 1;

        if(dating!=""){
            reward_img=Math.floor(reward_img*1.8);
            imageObj[dating] += reward_img;
        }

        imageObj.player += reward_img;
        _data.image = imageObj;

        rewards = new Object();
        rewards.image = reward_img;
        //rewards.cash = cash_pay;

        //cash += cash_pay;
        //flox.save("cash", cash);


        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO", false);

        var evtObj:Object = new Object();
        var scene:String = DataContainer.currentScene;
        evtObj.command = "Train@"+scene;
        flox.logEvent("CloudCommand", evtObj);

    }

    public function doWork():void {
        //nightclub,themed part,bank
        comType = "Work";
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();

        var scene:String = DataContainer.currentScene;
        var mediacom:MediaInterface = new MediaCommand();
        //mediacom.VideoPlayer(new Point(1024,250),new Point(0,260))
        //mediacom.play("video/"+scene+"-work-animated.flv",false,onFinishAnimated);
        mediacom.SWFPlayer("transform", "../swf/" + scene + "Work.swf", onFinishAnimated);

        var attr:String = scene.split("Scene").join("Work");

        var flox:FloxInterface = new FloxCommand();
        var cash:Number = flox.getSaveData("cash");
        var ap:Number = flox.getSaveData("ap");
        var image:Number = flox.getSaveData("image").player;
        var int:Number = flox.getSaveData("int").player;
        var love:Number=flox.getSaveData("love").player;
        var dating:String = flox.getSaveData("dating");

        var income:Number = 0;
        var rate: Number = Number(((Math.floor(Math.random() * 30) + 1) / 100));
        switch (scene) {
            case "NightclubScene":
                income = 20+Math.floor(image / 7.5 * (rate+1));
                break
            case "BankScene":
                income = 25+Math.floor(int / 5 * (rate+1));
                break
            case "ThemedParkScene":
                income = 200+Math.floor(love / 15 * (rate+1));
                break
        }
        if(dating!=""){
            income = Math.floor(income*1.8);
        }
        cash += income;
        flox.save("cash", cash);

        rewards = new Object();
        rewards.cash = income;

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        var evtObj:Object = new Object();
        evtObj.command = "Work@"+scene;
        flox.logEvent("CloudCommand", evtObj);

    }

    private var rewards:Object;

    public function doLearn():void {
        //research
        comType = "Learn";
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();


        var mediacom:MediaInterface = new MediaCommand();
        mediacom.SWFPlayer("transform", "../swf/research.swf", onFinishAnimated);


        var flox:FloxInterface = new FloxCommand();
        var sysCommand:Object = flox.getSyetemData("command");
        var dating:String = flox.getSaveData("dating");
        var valuesInt:String = sysCommand.Research.values.int;
        var cash_pay:Number = sysCommand.Research.values.cash;
        DebugTrace.msg("MainCommand.doLearn cash_pay=" + cash_pay);
        var cash:Number = flox.getSaveData("cash");
        var ap:Number = flox.getSaveData("ap");
        var intObj:Object = flox.getSaveData("int");

        var minInt:Number = Number(valuesInt.split("~")[0]) - 1;
        var maxInt:Number = Number(valuesInt.split("~")[1]);
        //DebugTrace.msg("MainCommand.doLearn sysCommand="+JSON.stringify(sysCommand));

        var reward_int:Number = minInt + Math.floor(Math.random() * (maxInt - minInt)) + 1;
        // cash += cash_pay;
        if(dating!=""){
            reward_int=Math.floor(reward_int*1.8);
            intObj[dating]+=reward_int;
        }
        intObj.player += reward_int;

        flox.save("int", intObj);
        //flox.save("cash", cash);

        rewards = new Object();
        rewards.int = reward_int;
        //rewards.cash = cash_pay;

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        var scene:String = DataContainer.currentScene;
        var evtObj:Object = new Object();
        evtObj.command = "Research@"+scene;
        flox.logEvent("CloudCommand", evtObj);

    }

    public function doMeditate():void {
        comType = "Meditate";
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");


        var scene:String = DataContainer.currentScene;
        var flox:FloxInterface = new FloxCommand();
        var evtObj:Object = new Object();
        evtObj.command = "Meditate@"+scene;
        flox.logEvent("CloudCommand", evtObj);


        var _data:Object = new Object();
        _data.name = "TrainingGame";
        sceneDispatch(SceneEvent.CHANGED, _data);

    }
    private var tweenID:uint=0;
    public function doRelax():void{

        var flox:FloxInterface=new FloxCommand();
        var moods:Object=flox.getSaveData("mood");
        for(var _name:String in moods){
            moods[_name]=0;
        }
        flox.save("mood",moods);

        tweenID = Starling.juggler.delayCall(onRelaxComplete,1);
        function onRelaxComplete():void{
            Starling.juggler.removeByID(tweenID);

            var _data:Object = new Object();
            _data.name = DataContainer.currentScene;
            sceneDispatch(SceneEvent.CHANGED, _data);
        }

    }
    public function doThink():void{
        var flox:FloxInterface=new FloxCommand();
        var dating:String=flox.getSaveData("dating");
        var intObj:Object=flox.getSaveData("int");
        var moods:Object=flox.getSaveData("mood");
        var commands:Object=flox.getSyetemData("command");
        rewards = new Object();
        rewards.int = commands["Think"].values.int;
        if(dating!=""){
            var reward_mood:Number=Math.floor((intObj.player+intObj[dating])/12);
            rewards.mood=reward_mood;
            moods[dating]+=reward_mood;
            intObj[dating]+=rewards.int;
            flox.save("mood",moods);

        }
        intObj.player+=rewards.int;
        flox.save("int",intObj);

        var scene:Sprite = ViewsContainer.currentScene;
        showCommandValues(scene,"Think",rewards);

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        tweenID = Starling.juggler.delayCall(onThinkComplete,1);
        function onThinkComplete():void{
            Starling.juggler.removeByID(tweenID);

            var _data:Object = new Object();
            _data.name = DataContainer.currentScene;
            sceneDispatch(SceneEvent.CHANGED, _data);
        }

    }

    public function doWatchMovies():void{
        var flox:FloxInterface=new FloxCommand();
        var dating:String=flox.getSaveData("dating");
        var intObj:Object=flox.getSaveData("int");
        var moods:Object=flox.getSaveData("mood");
        var commands:Object=flox.getSyetemData("command");
        rewards = new Object();
        rewards.int = commands["WatchMovies"].values.int;

        if(dating!=""){
            var reward_mood:Number=Math.floor((intObj.player+intObj[dating])/16);
            rewards.mood=reward_mood;
            moods[dating]+=reward_mood;
            intObj[dating]+=rewards.int;
            flox.save("mood",moods);

        }
        intObj.player+=rewards.int;
        flox.save("int",intObj);

        var scene:Sprite = ViewsContainer.currentScene;
        showCommandValues(scene,"WatchMovies",rewards);

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        tweenID = Starling.juggler.delayCall(onThinkComplete,1);
        function onThinkComplete():void{
            Starling.juggler.removeByID(tweenID);

            var _data:Object = new Object();
            _data.name = DataContainer.currentScene;
            sceneDispatch(SceneEvent.CHANGED, _data);
        }
    }

    public function doDrink():void{
        var flox:FloxInterface=new FloxCommand();
        var dating:String=flox.getSaveData("dating");
        var imgObj:Object=flox.getSaveData("image");
        var moods:Object=flox.getSaveData("mood");
        var commands:Object=flox.getSyetemData("command");
        rewards = new Object();
        rewards.image = commands["Drink"].values.image;

        if(dating!=""){
            var reward_mood:Number=Math.floor((imgObj.player+imgObj[dating])/16);
            rewards.mood=reward_mood;
            moods[dating]+=reward_mood;
            imgObj[dating]+=rewards.image;
            flox.save("mood",moods);

        }
        imgObj.player+=rewards.image;
        flox.save("image",imgObj);

        var scene:Sprite = ViewsContainer.currentScene;
        showCommandValues(scene,"Drink",rewards);

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        tweenID = Starling.juggler.delayCall(onThinkComplete,1);
        function onThinkComplete():void{
            Starling.juggler.removeByID(tweenID);

            var _data:Object = new Object();
            _data.name = DataContainer.currentScene;
            sceneDispatch(SceneEvent.CHANGED, _data);
        }
    }

    public function doDine():void{
        var flox:FloxInterface=new FloxCommand();
        var dating:String=flox.getSaveData("dating");
        var imgObj:Object=flox.getSaveData("image");
        var moods:Object=flox.getSaveData("mood");
        var commands:Object=flox.getSyetemData("command");
        rewards = new Object();
        rewards.image = commands["Dine"].values.image;
        if(dating!=""){
            var reward_mood:Number=Math.floor((imgObj.player+imgObj[dating])/12);
            rewards.mood=reward_mood;
            moods[dating]+=reward_mood;
            imgObj[dating]+=rewards.image;
            flox.save("mood",moods);

        }
        imgObj.player+=rewards.image;
        flox.save("image",imgObj);

        var scene:Sprite = ViewsContainer.currentScene;
        showCommandValues(scene,"Dine",rewards);

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        tweenID = Starling.juggler.delayCall(onThinkComplete,1);
        function onThinkComplete():void{
            Starling.juggler.removeByID(tweenID);

            var _data:Object = new Object();
            _data.name = DataContainer.currentScene;
            sceneDispatch(SceneEvent.CHANGED, _data);
        }

    }
    public function doPlayGamble():void{

        var flox:FloxInterface=new FloxCommand();
        var cash:Number=flox.getSaveData("cash");
        var commands:Object=flox.getSyetemData("command");
        var rewardCash:Number=Math.ceil(Math.random()*1000);
        rewards = new Object();
        rewards.cash=rewardCash;
        cash+=rewardCash;
        flox.save("cash",cash);
        var scene:Sprite = ViewsContainer.currentScene;
        showCommandValues(scene,"PlayGamble",rewards);

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

        tweenID = Starling.juggler.delayCall(onThinkComplete,1);
        function onThinkComplete():void{
            Starling.juggler.removeByID(tweenID);

            var _data:Object = new Object();
            _data.name = DataContainer.currentScene;
            sceneDispatch(SceneEvent.CHANGED, _data);
        }

    }
    public function PlayBattleTutorial():void{

        comType = "BattleTutorial";
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();

        var scene:String = DataContainer.currentScene;
        var mediacom:MediaInterface = new MediaCommand();
        mediacom.SWFPlayer("battletutorial", "../swf/BattleTutorial.swf", onFinishAnimated);

    }

    // private var sysValues:Object;
    private function initCommnadValues(attr:String, values:Object):void {

        //var flox:FloxInterface=new FloxCommand();
        //var sysCommad:Object=flox.getSyetemData("command");
        //sysValues=sysCommad[attr].values;
        rewards = new Object();
        for (var type:String in values) {

            rewards[type] = values[type];
        }

    }

    public function showCommandValues(target:Sprite, attr:String, values:Object = null):void {
        //show up reward after excuting command

        //var assets:AssetManager=Assets.SoundManager;
        //assets.playSound("GotFoods");
        playSound("GodRewards");


        var flox:FloxInterface = new FloxCommand();
        var sysCommad:Object = flox.getSyetemData("command");
        var rewards:Object = new Object();

        var command:MainInterface = new MainCommand();
        var attrlist:Array = new Array();
        var valueslist:Array = new Array();

        if (values) {
            rewards = values;

        } else {

            rewards = sysCommad[attr].values;
        }

        for (var cate:String in rewards) {

            if (rewards[cate] > 0) {
                attrlist.push(cate);
                var valueStr:String = "";
                if(cate=="mood"){
                    valueStr="MOOD +"+rewards[cate];
                }else{
                    valueStr="+"+rewards[cate];
                }
                valueslist.push(valueStr);
            }else {
                //valueStr = String(rewards[i]);
            }


        }
        //for
        var value_data:Object = new Object();
        value_data.attr = attrlist.toString();
        value_data.values = valueslist.toString();
        command.displayUpdateValue(target, value_data);

        if(attr=="FreeRest"){

            resetdely=new DelayedCall(onRestTimeOut,2);
            Starling.juggler.add(resetdely);

        }

    }
    private function onRestTimeOut():void{

        Starling.juggler.remove(resetdely);

        var command:MainInterface = new MainCommand();
        var _data:Object=new Object();
        _data.name=DataContainer.currentScene;
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }

    private function reseatDating():void {

        DebugTrace.msg("MainCommand.reeseatDating");
        DataContainer.currentDating = null;

        var flox:FloxInterface = new FloxCommand();
        flox.save("dating", "");


        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("CANCEL_DATING");


    }

    private var playerBitmap:Bitmap;
    //private var playerTween:TweenMax;
    private var playerTween:Tween;

    private var character:Image;
    private var basemodel:Sprite;


    public function drawPlayer(target:Sprite,avatar:Object=null):Sprite {

        var flox:FloxInterface = new FloxCommand();
        var gender:String = flox.getSaveData("avatar").gender;

        var modelObj:Object = Config.modelObj;
        var pos:Point = new Point(44, 120);
        if (gender == "Female") {
            pos = new Point(80, 150);
        }
        var modelRec:Rectangle = modelObj[gender];

        var player:Sprite = new Sprite();
        player.name = "player";

        var modelAttr:Object = new Object();
        modelAttr.gender = gender;
        modelAttr.width = modelRec.width;
        modelAttr.height = modelRec.height;



        var drawcom:DrawerInterface = new DrawManager();
        drawcom.drawCharacter(player, modelAttr);

        drawcom.updateBaseModel("Eyes");
        if(avatar){
            drawcom.updateBaseModel("Pants",avatar);
            drawcom.updateBaseModel("Clothes",avatar);
        }else{
            drawcom.updateBaseModel("Pants");
            drawcom.updateBaseModel("Clothes");

        }
        drawcom.updateBaseModel("Hair");
        drawcom.updateBaseModel("Features");
        drawcom.updateBaseModel("Features");


        player.x = pos.x + Math.floor(player.width / 2);
        player.y = pos.y;


        target.addChild(player);

        return player

    }

    public function drawCharacter(target:Sprite, style:String):Image {

        //var dating:String=DataContainer.currentDating;
        //var style:String=DataContainer.styleSechedule[dating];

        var clothTexture:Texture = Assets.getTexture(style);
        character = new Image(clothTexture);
        character.x = 400;
        //character.alpha=0;
        target.addChild(character);

        var tween:Tween = new Tween(character, 0.5, Transitions.EASE_IN_OUT);
        tween.fadeTo(1);
        tween.onComplete = onCharacterFadein;
        //Starling.juggler.add(tween);

        function onCharacterFadein():void {
            Starling.juggler.removeTweens(character);
        }

        return character

    }

    public function copyPlayerAndCharacter():void {

        //var scene:Sprite=ViewsContainer.baseSprite;
        var scene:Sprite = ViewsContainer.currentScene;

        var savedata:SaveGame = FloxCommand.savegame;

        var gender:String = savedata.avatar.gender;
        var dating:String = savedata.dating;

        var modelObj:Object = Config.modelObj;
        var pos:Point = new Point(44, 120);
        if (gender == "Female") {
            pos = new Point(80, 150);
        }
        var modelRec:Rectangle = modelObj[gender];

        basemodel = new Sprite();
        basemodel.name = "player";
        basemodel.x = modelRec.x;
        basemodel.y = modelRec.y;


        var modelAttr:Object = new Object();
        modelAttr.gender = gender;
        modelAttr.width = modelRec.width;
        modelAttr.height = modelRec.height;

        var drawcom:DrawerInterface = new DrawManager();
        drawcom.drawCharacter(basemodel, modelAttr);

        drawcom.updateBaseModel("Eyes");
        drawcom.updateBaseModel("Pants");
        drawcom.updateBaseModel("Clothes");
        drawcom.updateBaseModel("Hair");
        drawcom.updateBaseModel("Features");

        scene.addChild(basemodel);

        basemodel.x = -100;
        basemodel.y = pos.y;
        basemodel.alpha = 0;

        var playerTween:Tween = new Tween(basemodel, 0.5, Transitions.EASE_IN_OUT);
        playerTween.fadeTo(1);
        playerTween.animate("x", pos.x);
        Starling.juggler.add(playerTween);


        /*
         var bitmapdata:BitmapData=drawcom.copyAsBitmapData(basemodel,new Rectangle(0,0,basemodel.width,basemodel.height),new Point(0,-50));
         playerBitmap=new Bitmap(bitmapdata);
         playerBitmap.name="player"
         playerBitmap.x=-100;
         playerBitmap.y=pos.y;
         playerBitmap.alpha=0;
         playerTween=new TweenMax(playerBitmap,0.5,{"alpha":1,"x":pos.x,onComplete:onShowed});
         Starling.current.nativeOverlay.addChild(playerBitmap);
         */


        if (dating) {


            var style:String = DataContainer.styleSchedule[dating];
            var clothTexture:Texture = Assets.getTexture(style);

            character = new Image(clothTexture);
            character.x = 1300;
            character.alpha = 0;
            //chTween=new TweenMax(character,0.5,{"alpha":1,"x":550,onComplete:onShowed});
            var characterTween:Tween = new Tween(character, 0.5, Transitions.EASE_IN_OUT);
            characterTween.fadeTo(1);
            characterTween.animate("x", 550);
            characterTween.onComplete = onShowed;
            Starling.juggler.add(characterTween);

            scene.addChild(character);

            //Starling.current.nativeOverlay.addChild(character);
        }


    }

    private function onShowed():void {
        // playerTween.kill();
        Starling.juggler.removeTweens(character);
        Starling.juggler.removeTweens(basemodel);

    }

    public function clearCopyPixel():void {
        //DebugTrace.msg("ManCommand.clearCopyPixel")
        SimgirlsLovemore.topview.removeChild(playerBitmap);
        try {
            //SimgirlsLovemore.topview.removeChild(character);
            character.removeFromParent(true);
        }
        catch (err:Error) {
            DebugTrace.msg("ManCommand.clearCopyPixel character NULL !");
        }

    }

    private function onFinishAnimated():void {

        var queue:LoaderMax=ViewsContainer.loaderQueue;
        queue.empty(true,true);

        try {
            Starling.current.nativeOverlay.removeChild(playerBitmap);
        }
        catch (err:Error) {
            DebugTrace.msg("ManCommand.onFinishAnimated playerBitmap NULL !");
        }
        try {

            character.removeFromParent(true);
            // Starling.current.nativeOverlay.removeChild(character);
        }
        catch (err:Error) {
            DebugTrace.msg("MainCommand.onFinishAnimated character NULL !");
        }

        var current_scence:String = DataContainer.currentScene;
        var _data:Object = new Object();
        if (current_scence == "Tarotreading" || current_scence == "AirplaneScene") {


            switch (SceneEvent.scene) {
                case "Tarotreading":

                    _data.name = "AirplaneScene";
                    break
                case "AirplaneScene":
                    _data.name = "MainScene";
                    break
                default:
                    _data.name = DataContainer.currentScene;
                    break
            }
            //switch
            sceneDispatch(SceneEvent.CHANGED, _data);
        } else {

            if (comType != "Rest" && comType != "Sail") {

                var scene:Sprite = ViewsContainer.currentScene;
                _data.rewards = rewards;
                _data.removed = "ani_complete";
                scene.dispatchEventWith(TopViewEvent.REMOVE, false, _data);

            }
            else {
                //Do Rest

                dateManager("Rest");
                var gameinfo:Sprite = ViewsContainer.gameinfo;
                gameinfo.dispatchEventWith("UPDATE_INFO");
            }


        }


    }

    public function consumeHandle(com:String):Boolean {
        //command

        var pass_ap:Boolean = false;
        var pass_cash:Boolean = false;
        var pass_se:Boolean = true;
        var success:Boolean = false;
        var scene:Sprite = ViewsContainer.MainScene;
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        var flox:FloxInterface = new FloxCommand();
        var ap:Number = flox.getSaveData("ap");
        var sysCommand:Object = flox.getSyetemData("command");
        var payCash:Number = 0;
        var alert:AlertMessage;
        var msg:String = "";
        if (com.indexOf("\n") != -1) {
            com = com.split("\n").join("");
        }
        if (com == "Work") {

            var current_scene:String = DataContainer.currentScene.split("Scene").join("");
            com = current_scene + com;
        }


        if (com == "Meditate") {

            var seMax:Number = flox.getSaveData("love").player;
            var se:Number = flox.getSaveData("se").player;
            if (se >= seMax) {

                pass_se = false;
                payAP = 0;
                msg = "Your Spirit Energy has reached the limit!!";
                alert = new AlertMessage(msg, onClosedAlert);
                scene.addChild(alert);

            }
        }
        if(com =="CannotPaticipate"){

            msg = "There's no game today.";
            alert = new AlertMessage(msg, onClosedAlert);
            scene.addChild(alert);

            gameEvent._name = "clear_comcloud";
            gameEvent.displayHandler();
            return false;
        }
        if(com=="CannotBattleToday"){

            msg = "You have already battled today.";
            alert = new AlertMessage(msg, onClosedAlert);
            scene.addChild(alert);

            gameEvent._name = "clear_comcloud";
            gameEvent.displayHandler();
            return false;

        }
        if(com=="NoSurvivor" || com=="NoSurvivor_Normal"){
            //random battle
            var alertType:String="nobutton_type";
            msg = "No one in the team has SE to fight. Pay Pizzo $50.";
            if(com=="NoSurvivor_Normal"){
                //battle , pratice
                alertType="button_type";
                msg = "No one in the team has SE to fight.";
            }
            alert = new AlertMessage(msg, onClosedAlert,alertType);
            scene.addChild(alert);
            gameEvent._name = "clear_comcloud";
            gameEvent.displayHandler();
            return false;
        }
        if(com=="RandomBattle"){

            ViewsContainer.UIViews.visible = false;

            gameEvent._name="clear_comcloud";
            gameEvent.displayHandler();

            var popup:RandomBattlePopup=new RandomBattlePopup();
            popup.init();
            scene.addChild(popup);

            return false;
        }

        var payAP:Number = sysCommand[com].ap;
        if (sysCommand[com].values) {
            payCash = sysCommand[com].values.cash;
        }

        if (payAP < 0) {

            if (ap + payAP < 0) {
                ViewsContainer.UIViews.visible = false;
                msg = "You need more AP.";
                alert = new AlertMessage(msg, onClosedAlert);
                scene.addChild(alert);

            }
            else {

                DebugTrace.msg("MainCommand.paidAP ap=" + ap);
                pass_ap = true;

            }
            //if

        }
        else {

            //don't need to spend AP
            pass_ap = true;

        }

        if (payCash < 0) {

            var cash:Number = flox.getSaveData("cash");
            var cash_pay:Number = sysCommand[com].values.cash;
            cash += cash_pay;
            if (cash >= 0) {

                pass_cash = true;

                //flox.save("cash",cash);

            } else {

                if(com=="RunAwayRandomBattle"){
                    msg = "You are broke.\n They let you go.";

                }else{
                    msg = "Not enough money.";
                }
                alert = new AlertMessage(msg, onClosedAlert);
                scene.addChild(alert);

            }

        } else {

            //don't need to spend Cash
            pass_cash = true;


        }




        if (pass_ap && pass_cash && pass_se) {
            var value_data:Object = new Object();
            var attrArr:Array=new Array();
            var valuesArr:Array=new Array();
            if (payAP < 0) {
                //have to spend AP
                ap = ap + payAP;
                flox.save("ap", ap);

                attrArr.push("ap");
                valuesArr.push(payAP);


            }
            if(cash_pay<0){
                //have to spend Cash
                flox.save("cash", cash);

                attrArr.push("cash");
                valuesArr.push(cash_pay);

            }
            try{
                var mood:*=sysCommand[com].values.mood;
                if(mood!=undefined){
                    attrArr.push("mood");
                    valuesArr.push("MOOD = "+mood);
                }

            }catch (e:Error){}


            if(attrArr.length>0){
                var command:MainInterface = new MainCommand();
                value_data.attr = attrArr.toString();
                value_data.values =valuesArr.toString();
                command.displayUpdateValue(scene, value_data);

                var gameinfo:Sprite = ViewsContainer.gameinfo;
                gameinfo.dispatchEventWith("UPDATE_INFO");
            }

            success = true;
        }

        if (!success) {


            gameEvent._name = "clear_comcloud";
            gameEvent.displayHandler();
        }

        return success;

    }

    private function onSaveComplete():void {

        var scene:String = DataContainer.currentScene;

        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO");

    }

    private function onClosedAlert():void {
        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();

        var command:MainInterface = new MainCommand();
        var current_label:String=  DataContainer.currentLabel;
        if(current_label.indexOf("Dating")!=-1){
            command.addShortcuts();
        }

        var _data:Object = new Object();
        _data.name = DataContainer.currentScene;

        command.sceneDispatch(SceneEvent.CHANGED, _data);
    }

    public function syncSpiritEnergy():void {

        var flox:FloxInterface = new FloxCommand();
        var seObj:Object = flox.getSaveData("se");
        var loveObj:Object = flox.getSaveData("love");
        for (var name:String in loveObj) {

            seObj[name] = loveObj[name];
        }
        flox.save("se", seObj);


    }

    public function checkSystemStatus():void {
        //type---> normal,maintaining,warning
        var flox:FloxInterface = new FloxCommand();
        var status:Object = flox.getSyetemData("status");
        DebugTrace.msg("MainCommand.checkSystemStatus status=" + status.type);
        if (status.type != "normal") {

            MainCommand.sysAlert(status.type, status.log);

        }

    }

    public function initCharacterLocation(type:String,arrived:Array=null):void{

        var flox:FloxInterface = new FloxCommand();
        var scenelikes:Object=flox.getSaveData("scenelikes");
        var schedule:Array=flox.getSyetemData("schedule");
        var current_scene:String=DataContainer.currentScene.split("Scene").join("");
        var allChacters:Array=Config.datingCharacters;
        var dating:String=flox.getSaveData("dating");
        var chlist:Array=new Array();
        var dateStr:String=flox.getSaveData("date").split("|")[0];
        var _date:Number=Number(dateStr.split(".")[1]);
        var _month:String=dateStr.split(".")[2];
        if(!arrived){
            arrived=new Array();
        }
        //check schedule
        for(var j:uint=0;j<allChacters.length;j++)
        {

            var character:String=allChacters[j];
            characterInSchedule(character);
            var liksObj:Object=checkSchedule(character,schedule);

            if(liksObj)
            {

                arrived.push(liksObj);
                chlist.push(liksObj.name);
            }
            else
            {
                //people likes
                //DebugTrace.msg("FoundSomeScene.setCharacterInside scenelikes:"+JSON.stringify(scenelikes));
                //DebugTrace.msg("FoundSomeScene.setCharacterInside character="+character);
                if(dating!=character) {
                    //not incloud dating character
                    if (chlist.indexOf(character) == -1) {
                        //popele don't have schedule
                        //but likes this scene with character;
                        var _scenelikes:Object=scenelikes[character][0];

                        var likes:Number = Number(_scenelikes.likes);
                        var scene:String = String(_scenelikes.name);
                        var chlikes:Object=new Object();


                        if(_month=="Dec" && character=="tomoru"){
                            if(_date>=2 && _date<=4){

                                likes=0;
                            }

                        }
                        switch(type){
                            case "all_scene":
                                if (likes > 0) {
                                    // the most like

                                    chlikes.name = character;
                                    chlikes.value = likes;
                                    chlikes.location=scene;
                                    arrived.push(chlikes);
                                }
                                break;
                            default :
                                if (scene == current_scene && likes > 0) {
                                    // most like

                                    chlikes.name = character;
                                    chlikes.value = likes;
                                    chlikes.location=scene;
                                    //trace("FoundSomeScene.setCharacterInside scene: ",scene,"; character:",character," : ",likes);
                                    arrived.push(chlikes);

                                }
                                //if
                                break

                        }    //switch

                    }
                }

            }
            //if

        }
        //for

        //fake
        //chlikeslist.push({"value":80,"name":"lenus"});
        arrived.sortOn("value",Array.NUMERIC|Array.DESCENDING);
        DataContainer.CharacherLocation=arrived;


    }
    private function checkSchedule(character:String,schedule:Array):Object
    {
        //DebugTrace.msg("FoundSomeScene.checkSchedule likesObj:"+JSON.stringify(likesObj));

        var _likesObj:Object=new Object();
        var dateIndx:Object=DataContainer.currentDateIndex;

        var flox:FloxInterface = new FloxCommand();
        //var schedule:Array=flox.getSyetemData("schedule");
        var schIndex:Object=Config.scheduleIndex as Object;
        var index:Number=schIndex[character];
        var schedule_scene:String=String(schedule[index+dateIndx.month][dateIndx.date]);
        var current_scene:String=DataContainer.currentScene;
        var scene:String=String(current_scene.split("Scene").join());

        DebugTrace.msg("MainCommand.checkSchedule schedule_scene:"+schedule_scene+" ;scene:"+scene);
        if(schedule_scene==scene)
        {
            _likesObj.value=100;
            _likesObj.name=character;
        }
        else
        {

            _likesObj=null;
        }

        return _likesObj;
    }
    private function characterInSchedule(name:String):void
    {

        var flox:FloxInterface = new FloxCommand();
        var scenelikes:Object=flox.getSaveData("scenelikes");
        var schedule:Array=flox.getSyetemData("schedule");
        var dateIndx:Object=DataContainer.currentDateIndex;

        var schIndex:Object=Config.scheduleIndex;
        var index:Number=schIndex[name];
        var schedule_scene:String=schedule[index+dateIndx.month][dateIndx.date];
        DebugTrace.msg("MainCommand.characterInSchedule  date:"+dateIndx.date);
        DebugTrace.msg("MainCommand.characterInSchedule  schedule_scene:"+schedule_scene);
        if(schedule_scene!="")
        {
            //character has schedule
            for(var i:uint=0;i<scenelikes[name].length;i++)
            {
                scenelikes[name][i].likes=0;
            }
            //savegame.scenelikes=scenelikes;
            //FloxCommand.savegame=savegame;
            flox.save("scenelikes",scenelikes);
        }
        //if
    }

    private function submitDailyReport():void{

        var report:Object=new Object();
        var flox:FloxInterface = new FloxCommand();

        var intObj:Object=flox.getSaveData("int");
        var imageObj:Object=flox.getSaveData("image");
        var honorObj:Object=flox.getSaveData("honor");
        //var ap_max:Number=flox.getSaveData("ap_max");
        var cash:Number=flox.getSaveData("cash");
        var loveObj:Object=flox.getSaveData("love");
        var moodObj:Object=flox.getSaveData("mood");
        var seObj:Object=flox.getSaveData("se");
        var skillPtsObj:Object=flox.getSaveData("skillPts");
        var time:String=String(flox.getSaveData("date").split("|")[0]);

        report.intelligent=intObj.player;
        report.image=imageObj.player;
        report.cash=cash;
        report.love=loveObj.player;
        report.honor=honorObj.player;
        report.mood=moodObj.player;
        report.se=seObj.player;
        report.skill_point=skillPtsObj.player;
        flox.logEvent("DailyReport-"+time,report);
    }

    private function healSpiritEngine():void{
        var flox:FloxInterface = new FloxCommand();
        //Love=se maximum
        var seMaxObj:Object=flox.getSaveData("love");
        var seObj:Object=flox.getSaveData("se");

        for(var name:String in seObj){

            if(name!="player"){
                var se:Number= seObj[name];
                var seMax:Number= seMaxObj[name];
                se+=Math.floor(seMax*0.5);

                if(se>seMax){
                    se=seMax;
                }
                seObj[name]=se;
            }

        }
        flox.save("se",seObj);

    }

    public function removeShortcuts():void{

        Starling.current.stage.removeEventListeners();
    }
    public function addShortcuts():void{

        DebugTrace.msg("MainCommand.addShortcuts");
        Starling.current.stage.addEventListener(KeyboardEvent.KEY_UP, doShortcuts);

    }
    private function doShortcuts(e:KeyboardEvent):void{
        var toScene:String="";
        var shortcutsScene:String= DataContainer.shortcutsScene;
        DataContainer.shortcuts="";
        var flox:FloxInterface=new FloxCommand();
        switch(e.keyCode){

            case Keyboard.SPACE:
                toScene="ProfileScene";
                break
            case Keyboard.C:
                toScene="ContactsScene";
                break
            case Keyboard.D:
                toScene="CalendarScene";
                break
            case Keyboard.Q:
                toScene="MainScene";
//                var datingnow:String=flox.getSaveData("dating");
//                if(datingnow==""){
//                    DataContainer.currentDating=null;
//                }
                break;
            case Keyboard.H:
                DataContainer.shortcuts="Rest";
                toScene="HotelScene";
                break;
            case Keyboard.B:
                DataContainer.shortcuts="Rest";
                toScene="BeachScene";
                break

        }
        var scenecom:SceneInterface=new SceneCommnad();
        var switch_verifies:Array=scenecom.switchGateway("Rest");
        var battle_verify:Boolean=switch_verifies[switch_verifies.length-1];
        var playStroy:Boolean=true;
        if(DataContainer.shortcuts=="Rest"){
            playStroy=switch_verifies[0];
        }else{
            playStroy=false;
        }
        if(!playStroy && battle_verify){
            //no story yet , no battle

            if(toScene!="" && shortcutsScene!=toScene && shortcutsScene.indexOf("Game")==-1){
                DebugTrace.msg("MainCommand.doShortcuts  toScene="+toScene+" , shortcutsScene="+shortcutsScene);
                var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
                gameEvent._name="clear_comcloud";
                gameEvent.displayHandler();

                var _data:Object=new Object();
                _data.name=toScene;
                sceneDispatch(SceneEvent.CHANGED,_data);

            }else{
                DataContainer.shortcuts="";
            }
        }else{
            DataContainer.shortcuts="";
            var switchID:String=flox.getSaveData("current_switch").split("|")[0];
            var switchs:Object=flox.getSyetemData("switchs");
            var values:Object=switchs[switchID];
            var alert:Sprite = new AlertMessage(values.hints);
            if(!battle_verify){
                var hints:String="There is a SSCC game today at the Arena.";
                alert = new AlertMessage(hints);
                Starling.current.stage.addChild(alert);
            }else{

                if(values && values.hints!="") {

                    Starling.current.stage.addChild(alert);

                }

            }

        }

    }


    public function initCriminalsRecord():void{
        //DebugTrace.msg("MainCommand.initCriminalsRecord");
        var ranking:Array=Config.CriminalRanking;
        var records:Array=new Array();
        var location:Array=new Array();
        var ranks:Array=new Array();
        var rewardslist:Array=new Array();

        for(var loc:String in Config.stagepoints){
            if(loc!="PrivateIsland")
                location.push(loc);
        }
        for(var j:uint=0;j<ranking.length;j++){
            ranks.push(ranking[j].rank);
            rewardslist.push(ranking[j].rewards);
        }

        for(var i:uint=0;i<location.length;i++){

            var criminial:Object=new Object();
            criminial.location=location[i];
            var index:Number=Math.floor(Math.random()*ranks.length);
            criminial.rank=ranks[index];
            criminial.rewards=rewardslist[index];
            records.push(criminial);
        }
        //var flox:FloxInterface = new FloxCommand();
        //flox.save("criminals",records)
        DataContainer.Criminals=records;


    }
    public function criminalAbility():Object{

        var ranking:Array=Config.CriminalRanking;
        var current_scene:String=DataContainer.currentLabel;
        var scene:String=current_scene.split("Scene").join("");
        var records:Array=DataContainer.Criminals;
        var rank:String="";
        var reqawrds:Number=0;
        var se:Number=0;
        for(var i:uint=0;i<records.length;i++){
            if(records[i].location==scene){
                rank=records[i].rank;
                reqawrds=records[i].rewards;
                break
            }
        }
        for(var j:uint=0;j<ranking.length;j++) {
            if (ranking[j].rank == rank) {
                se=ranking[j].se;
                break
            }
        }

        //DebugTrace.msg("MainCommand.criminalAbility rank="+rank);

        var ability:Object={"se":se,"rewards":reqawrds,"rank":rank};
        //DebugTrace.msg("MainCommand.criminalAbility ability="+JSON.stringify(ability));
        DataContainer.CrimimalAbility=ability;


        return ability
    }

    private function initDailyUpgrade():void{
        var flox:FloxInterface = new FloxCommand();
        var ch_cash:Object=flox.getSaveData("ch_cash");
        var intObj:Object=flox.getSaveData("int");
        var imgObj:Object=flox.getSaveData("image");
        var cashRate:Object=Config.cashRate;
        var intRate:Object=Config.intRate;
        var imgRate:Object=Config.imgRate;
        for(var ch:String in ch_cash){
            if(ch!="player")
                ch_cash[ch]+=Math.floor(cashRate[ch]/2);
        }
        for(ch in intObj) {
            if(ch!="player")
                intObj[ch]+=Math.floor(intRate[ch]/2);
        }
        for(ch in imgObj){
            if(ch!="player")
                imgObj[ch]+=Math.floor(imgRate[ch]/2);
        }
        flox.save("ch_cash",ch_cash);
        flox.save("int",intObj);
        flox.save("image",imgObj);
    }
    private var _menu:ContextMenu;
    public function initContextMenu():void{

        this._menu= new ContextMenu();
        this._menu.hideBuiltInItems();
        var QHItem:ContextMenuItem=new ContextMenuItem("Quality - High");
        QHItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, doItemSelectHigh);
        var QMItem:ContextMenuItem=new ContextMenuItem("Quality - Medium");
        QMItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, doItemSelectMedium);
        var QLItem:ContextMenuItem=new ContextMenuItem("Quality - Low");
        QLItem.addEventListener(ContextMenuEvent.MENU_ITEM_SELECT, doItemSelectLow);
        this._menu.customItems.push(QHItem);
        this._menu.customItems.push(QMItem);
        this._menu.customItems.push(QLItem);
        Starling.current.nativeStage.addEventListener(MouseEvent.RIGHT_MOUSE_DOWN, nativeStage_rightMouseDownHandler, false, 0, true);
    }
    private function doItemSelectHigh(e:ContextMenuEvent):void{


        Starling.current.nativeStage.quality=StageQuality.HIGH;
    }
    private function doItemSelectMedium(e:ContextMenuEvent):void{

        Starling.current.nativeStage.quality=StageQuality.MEDIUM;
    }
    private function doItemSelectLow(e:ContextMenuEvent):void{

        Starling.current.nativeStage.quality=StageQuality.LOW;
    }
    public function nativeStage_rightMouseDownHandler(e:MouseEvent):void{
        this._menu.display(Starling.current.nativeStage, e.stageX, e.stageY);
    }

    public function checkCaptainAdjustData():void{
        var flox:FloxInterface=new FloxCommand();
        var skills:Object=flox.getSaveData("skills");
        if(!skills.captain){

            var captain_items:Array= [
                {
                    "qty": 0,
                    "id": "com0"
                },
                {
                    "qty": 0,
                    "id": "com1"
                },
                {
                    "qty": 0,
                    "id": "com2"
                },
                {
                    "qty": 0,
                    "id": "com3"
                }
            ];
            skills.captain=captain_items;
            flox.save("skills",skills);

        }
    }
    public function checkRanking():Number{
        var rank:Number=0;
        var flox:FloxInterface=new FloxCommand();
        var ranking:Array=flox.getSaveData("ranking");
        ranking=ranking.sortOn("win",Array.NUMERIC,Array.DESCENDING);
        DebugTrace.msg("MainCommand.checkTanking ranking="+ranking);

        for(var i:uint=0;i<ranking.length;i++){
            var team:Object=ranking[i];
            if(team.team_id == "player"){
                rank=(i+1);
                break
            }
        }
        return rank

    }

    public function checkSceneEnable(scene:String):Boolean{


        var enabled:Boolean=false;
        var flox:FloxInterface=new FloxCommand();
        var current_switch:String=flox.getSaveData("current_switch");
        var today:String=flox.getSaveData("date");
        var dayStr:String=today.split("|")[0];
        var month:String=dayStr.split(".")[2];
        var switchID:String=current_switch.split("|")[0];
        var enableObj:Object={"AcademyScene":"s009","SpiritTempleScene":"s010","LovemoreMansionScene":"s007","PoliceStationScene":"s013"};
        var storyID:String=enableObj[scene];

        if(storyID){

            var storyIDs:Array = new Array();
            var swiths:Object=StoryDAO.container;
            for(var id:String in swiths){
                storyIDs.push(id);
            }
            storyIDs.sort();

            //DebugTrace.msg("MainCommand.checkSceneEnable storyIDs="+JSON.stringify(storyIDs));
            var enabledIndex:Number=storyIDs.indexOf(storyID);
            var currentIndex:Number=storyIDs.indexOf(switchID);

            // DebugTrace.msg("MainCommand.checkSceneEnable enabledIndex="+enabledIndex);
            //DebugTrace.msg("MainCommand.checkSceneEnable currentIndex="+currentIndex);

            if(currentIndex>=enabledIndex){
                enabled=true;
                if(scene=="PoliceStationScene"){
                    switch(month){
                        case "Nov":
                        case "Dec":
                        case "Jan":
                        case "Feb":
                            enabled=true;
                            break;
                        default:
                            //no random battle before Dec.2034
                            enabled=false;
                            break
                    }
                }

            }

        }else{
            enabled=true;
        }



        return enabled;


    }
    private function checkFinalRankingBattle():void{

        var flox:FloxInterface=new FloxCommand();
        var command:MainInterface=new MainCommand();
        var ranking:Array=flox.getSaveData("ranking");
        ranking=ranking.sortOn("win",Array.NUMERIC,Array.DESCENDING);
        var winIndex:uint=0;
        for(var i:uint=0;i<ranking.length;i++){
            var rankInfo:Object=ranking[i];
            if(rankInfo.team_id =="player"){
                winIndex=i;
            }
        }
        if(winIndex<ranking.length-2){
            //not top 2, game over
            flox.save("current_switch","s9999|on");


        }


    }
    private function checkTwinFlamePts():void{

        var flox:FloxInterface=new FloxCommand();
        var relLv:Object=flox.getSyetemData("relationship_level");
        var twinflame:String=flox.getSaveData("twinflame");
        var ptsObj:Object=flox.getSaveData("pts");
        var pts:Number=ptsObj[twinflame];
        if(pts<=relLv["spouse-Min"]){
            flox.save("current_switch","s9999|on");

        }


    }
    public function checkMemory():void{


        var tweenID:uint=Starling.juggler.repeatCall(StartCheck,300,100);

        function StartCheck():void{

            var freeMemory:Number=Number((System.freeMemory/ Math.pow(1024,2)).toFixed(2));
            var totalMemory:Number=Math.floor(System.totalMemory/Math.pow(1024,2));

            DebugTrace.msg("MainCommmand.checkMemory freeMemory:"+freeMemory+" MB");
            DebugTrace.msg("MainCommmand.checkMemory totalMemory:"+totalMemory+" MB");

            if(!DataContainer.popupMessage && freeMemory<5 && totalMemory>100){

                var msg:String="Free memory is running low. If the game is experiencing significant slowdowns please save your progress and restart the game.";

                var popup:PopupManager=new PopupManager();
                popup.attr="memory";
                popup.msg=msg;
                popup.init();
            }

        }

    }

}
}