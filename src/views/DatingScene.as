package views
{


import controller.Assets;
import controller.DrawerInterface;
import controller.FilterInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.ParticleInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;

import flash.geom.Point;

import model.SaveGame;
import model.Scenes;

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
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;
import starling.utils.HAlign;
import starling.utils.VAlign;

import utils.DebugTrace;
import utils.DrawManager;
import utils.FilterManager;
import utils.ParticleSystem;
import utils.ViewsContainer;

public class DatingScene extends Scenes
{
    private var font:String="SimImpact";
    private var base_sprite:Sprite;
    private var character:MovieClip;
    private var filters:FilterInterface=new FilterManager();
    private var command:MainInterface=new MainCommand();
    private var flox:FloxInterface=new FloxCommand();
    private var proSprtie:Sprite;
    private var moodPie:MovieClip;
    private var mood:Number;
    //raise or less
    private var _mood:Number;
    private var _love:Number;
    private var drawcom:DrawerInterface=new DrawManager();
    private var fIndex:uint=0;

    private var moodPieImg:Image;
    private var cancelbtn:Button;
    private var pts_txt:TextField;
    private var scenecom:SceneInterface=new SceneCommnad();
    private var comcloud:String="ComCloud_L1_^Give,"+
            "ComCloud_L2_^Chat,"+
            "ComCloud_R1_^Dating,"+
            "ComCloud_R2_^Leave,"+
            "ComCloud_R3_^Flirt";
    public static var COMMIT:String="commit";
    private var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
    private var excerptbox:ExcerptBox;
    private var item_id:String;
    private var loveSprite:Sprite;
    private var cancel:Image;
    private var bubble:Image;
    private var goDating:Number=0;
    private var chat:String;
    private var chatTxt:TextField;
    private var player_love:Number=0;
    private var ch_love:Number=0;
    private var  com:String;
    private var assets:AssetsForm;
    private var panelbase:Sprite;
    private var itemImg:Image;
    public function DatingScene()
    {
        //ViewsContainer.InfoDataView.visible=false;

        base_sprite=new Sprite();
        addChild(base_sprite);
        this.addEventListener(DatingScene.COMMIT,doCommitCommand);
        ViewsContainer.baseSprite=this;
        ProfileScene.CharacterName="player";


        var dating:String=DataContainer.currentDating;
        mood=Number( flox.getSaveData("mood")[dating]);

        initLayout();

    }
    private function doCommitCommand(e:Event):void
    {
        ViewsContainer.UIViews.visible=false;
        datingTopic.visible=true;
        com=e.data.com;
        DebugTrace.msg("DatingScene.doCommitCommand com:"+com);
        switch(com)
        {
            case "Give":
                initAssetsForm();

                break
            case "Leave":
                datingTopic.visible=false;
                var _data:Object=new Object();
                _data.name=DataContainer.currentScene;
                command.sceneDispatch(SceneEvent.CHANGED,_data)
                break
            case "Chat":
                var chat:ChatScene=new ChatScene();
                addChild(chat);
                break
            case "Flirt":
                var flirt:FlirtScene=new FlirtScene();
                addChild(flirt);
                break
            case "Dating":

                confirmDating();
                break
            case "GotGift":
                item_id=e.data.item_id;

                itemMovingHandle(e.data.began);

                break
            case "FlirtLove":
                _love=e.data.love;
                updateLovefromFlirt();
                break

            case "TakePhoto":

                break

            case "Kiss":
                break

        }
        //switch
    }
    private function itemMovingHandle(began:Point):void{

        var itemTexture:Texture=getTexture(item_id);
        itemImg=new Image(itemTexture);
        itemImg.x=began.x-itemImg.width/2;
        itemImg.y=began.y-itemImg.height/2;
        addChild(itemImg);

        var tween:Tween=new Tween(itemImg,0.5,Transitions.EASE_IN_OUT_BACK);
        tween.moveTo(130,135);
        tween.onComplete=onItemMovingComplete;
        Starling.juggler.add(tween)

    }
    private function onItemMovingComplete():void{

        Starling.juggler.removeTweens(itemImg);
        itemImg.removeFromParent(true);


        updateMood();
        var tween:Tween=new Tween(base_sprite,0.25);
        tween.delay=0.25;
        tween.onComplete=onCompleteUpdateMood;
        Starling.juggler.add(tween);

    }
    private function onCompleteUpdateMood():void
    {
        Starling.juggler.removeTweens(base_sprite);
        startPaticles();
    }
    private function initAssetsForm():void
    {

        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);

        var panelAssets:Image=new Image(Assets.getTexture("AssetsTab"));
        panelAssets.name="assets";
        panelbase.addChild(panelAssets);


        assets=new AssetsForm();
        panelbase.addChild(assets);

        var _data:Object=new Object();
        _data.type="give";
        assets.dispatchEventWith("INITAILIZE",false,_data);


        excerptbox=new ExcerptBox();
        excerptbox.x=56;
        excerptbox.y=275;
        addChild(excerptbox);
        ViewsContainer.ExcerptBox=excerptbox;

        // gameEvent._name="dating_assets_form";
        //gameEvent.displayHandler();



        //added cancel button
        command.addedCancelButton(this,doCancelAssetesForm);



    }
    private function doCancelAssetesForm():void
    {

        excerptbox.removeFromParent(true);
        panelbase.removeFromParent(true);

        var _data:Object=new Object();
        _data.name=DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }
    private function startPaticles():void
    {
        //	var assets:Object=flox.getSaveData("assets");

        var rating:Number=command.searchAssetRating(item_id)
        var type:String="like"
        if(rating<0)
        {
            type="unlike"
        }
        var ps:ParticleInterface=new ParticleSystem();
        ps.init(proSprtie,type);
        ps.showParticles();

        showUpdateMood();

    }
    private function showUpdateMood():void
    {
        var content:String="Love +";
        if(_love<0)
        {
            content="Love";
        }
        content+=_love;
        loveSprite=new Sprite();
        var moodTxt:TextField=new TextField(200,50,content,"SimNeogreyMedium",20,0xFFFFFF);
        moodTxt.hAlign="center";
        loveSprite.addChild(moodTxt);

        loveSprite.pivotX=loveSprite.width/2;
        loveSprite.pivotY=loveSprite.height/2;
        loveSprite.x=130;
        loveSprite.y=77;
        addChild(loveSprite);

        var tween:Tween=new Tween(loveSprite,0.5,Transitions.EASE_OUT_BACK);
        tween.animate("y",loveSprite.y-50);
        //tween.animate("alpha",0.9);
        tween.scaleTo(1.5);
        tween.onComplete=onMoodUPdateComplete
        Starling.juggler.add(tween);

    }
    private function onMoodUPdateComplete():void
    {
        Starling.juggler.removeTweens(loveSprite);
        removeChild(loveSprite);
    }
    private function updateMood():void
    {


        var dating:String=DataContainer.currentDating;

        _mood=Number(command.moodCalculator(item_id,dating));
        mood+=_mood;

        DebugTrace.msg("DatingScene.updateMood mood:"+mood);


        var moodObj:Object=flox.getSaveData("mood");
        moodObj[dating]=mood;
        var savegame:SaveGame=FloxCommand.savegame;
        savegame.mood=moodObj;
        FloxCommand.savegame=savegame;



        drawcom.updatePieChart(mood);
        drawProfile();
        updateRelPoint();
    }
    private var pts_index:Number;
    private  var old_pts:Number;
    private function updateRelPoint():void
    {
        pts_index=0;
        var dating:String=DataContainer.currentDating;
        var savegame:SaveGame=FloxCommand.savegame;
        var ptsObj:Object=savegame.pts;
        old_pts=Number(ptsObj[dating]);
        DebugTrace.msg("DatingScene.updateRelPoint old_pts:"+old_pts);
        this.addEventListener(Event.ENTER_FRAME,doUpdatePts);

    }
    private function updateLovefromFlirt():void
    {
        startPaticles();

        var dating:String=DataContainer.currentDating;
        DebugTrace.msg("DatingScene.updateMood dating:"+dating);

        var loveObj:Object=flox.getSaveData("love");
        var moodObj:Object=flox.getSaveData("love");
        player_love=loveObj.player;
        ch_love=loveObj[dating];

        player_love+=_love;
        ch_love+=_love;
        loveObj.player=player_love;
        loveObj[dating]=ch_love;

        playerloveTxt.text=String(player_love);
        chloveTxt.text=String(ch_love);

        mood=loveObj[dating];
        mood+=_love;
        moodObj[dating]=mood;
        var savegame:SaveGame=FloxCommand.savegame;
        savegame.mood=moodObj;
        savegame.love=loveObj;
        FloxCommand.savegame=savegame;


        DebugTrace.msg("DatingScene.updateLovefromFlirt _mood:"+_love);
        DebugTrace.msg("DatingScene.updateLovefromFlirt mood:"+mood);
        drawcom.updatePieChart(mood);
        updateRelPoint();

    }
    private function doUpdatePts(e:Event):void
    {


        if(_mood<0)
        {
            pts_index--;
        }
        else if(_mood>0)
        {
            pts_index++;

        }
        //if
        if(_mood>1000)
        {
            pts_index=_mood;
        }
        var re_pts:Number=old_pts+pts_index;
        if(re_pts<0)
        {
            re_pts=0;
        }
        else if(re_pts>9999)
        {
            re_pts=9999;
        }
        //pts_txt.text=String(re_pts);
        //DebugTrace.msg("DatingScene.doUpdatePts pts_index:"+pts_index);
        if(pts_index==_mood)
        {
            command.updateRelationship(_mood);
            updateRelationShip();
            this.removeEventListener(Event.ENTER_FRAME,doUpdatePts);

        }

    }
    private function updateRelationShip():void
    {
        var dating:String=DataContainer.currentDating;
        var savegame:SaveGame=FloxCommand.savegame;
        var rel:Object=savegame.rel;
        var rel_str:String=rel[dating].toUpperCase();
        //rel_txt.text=rel_str;
    }
    private var playerloveTxt:TextField;
    private var datingTopic:Sprite;
    private var chloveTxt:TextField;
    private var profile:Sprite=null;
    private var mainProfile:Sprite;
    private var bgEffectImg:Image;
    private var titleIcon:Image;
    private var relactionInfo:Sprite;
    private var clouds:Array=new Array();
    private function initLayout():void
    {


        /*var bgMC:MovieClip=Assets.getDynamicAtlas(DataContainer.currentScene);
         bgMC.stop();*/

        var bgImg:*=drawcom.drawBackground();

        var bgSprtie:Sprite=new Sprite();
        bgSprtie.addChild(bgImg);

        filters.setSource(bgSprtie);
        filters.setBulr();
        addChild(bgSprtie);

        var effterxture:Texture=Assets.getTexture("DatingSceneBgEffect");
        bgEffectImg=new Image(effterxture);
        addChild(bgEffectImg);

        titleIcon=new Image(Assets.getTexture("IconDatingSceneTitle"));
        titleIcon.pivotX=titleIcon.width/2;
        titleIcon.pivotY=titleIcon.height/2;
        titleIcon.x=99;
        titleIcon.y=112;
        addChild(titleIcon);


        relactionInfo=new Sprite();
        relactionInfo.x=18;
        relactionInfo.y=193;
        addChild(relactionInfo);

        var dating:String=DataContainer.currentDating;
        var rel:String=flox.getSaveData("rel")[dating];
        var  relationship:TextField=new TextField(210,34,rel.toUpperCase(),font,30,0xffffff);
        relactionInfo.addChild(relationship);


        var quad:Quad=new Quad(200,30,0xffffff);
        quad.x=5;
        quad.y=36;
        relactionInfo.addChild(quad);
        var pts:String=String(flox.getSaveData("pts")[dating]);
        var ptsTxt:TextField=new TextField(210,34,pts,font,30,0x000000);
        ptsTxt.vAlign="center";
        ptsTxt.hAlign="center";
        ptsTxt.x=5;
        ptsTxt.y=35;
        relactionInfo.addChild(ptsTxt);


        mainProfile=new Sprite();
        mainProfile.x=227;
        mainProfile.y=47;
        var mainMood:Image=new Image(getTexture("EnergyPieChartBg"));
        mainMood.smoothing=TextureSmoothing.TRILINEAR;
        mainMood.width=287;
        mainMood.height=287;
        mainProfile.addChild(mainMood);
        addChild(mainProfile)



        initCharacter();
        initTopicBar();
        drawProfile();
        displayCloud();


    }
    private function drawProfile():void
    {

        var dating:String=DataContainer.currentDating;

        if(profile)
        {

            datingTopic.removeChild(profile);
        }

        profile=new Sprite();
        profile.x=130;
        profile.y=126;
        drawcom.drawCharacterProfileIcon(profile,dating,0.5);
        datingTopic.addChild(profile);
    }
    private function initCharacter():void
    {
        var dating:String=DataContainer.currentDating;

        character=Assets.getDynamicAtlas(dating);
        addChild(character);

        var tween:Tween=new Tween(character,0.3,Transitions.EASE_OUT);
        tween.animate("x",400);
        tween.scaleTo(1.2);
        Starling.juggler.add(tween)


    }

    private function initTopicBar():void{


        datingTopic=new Sprite();
        datingTopic.visible=false;
        this.addChild(datingTopic);

        var title:Image=new Image(getTexture("DatingTitleBg"));
        title.y=35;
        datingTopic.addChild(title);



        var dating:String=DataContainer.currentDating;
        var savegame:SaveGame=FloxCommand.savegame;


        var loveObj:Object=flox.getSaveData("love");

        playerloveTxt=new TextField(120,55,loveObj.player,font,40,0xFFFFFF);
        playerloveTxt.x=290;
        playerloveTxt.y=54;
        datingTopic.addChild(playerloveTxt);

        var ch_love_txt:TextField=new TextField(55,55,dating+"\nLove",font,18,0xFFFFFF);
        ch_love_txt.x=420;
        ch_love_txt.y=54;
        datingTopic.addChild(ch_love_txt);


        chloveTxt=new TextField(120,55,loveObj[dating],font,40,0xFFFFFF);
        chloveTxt.x=500;
        chloveTxt.y=54;
        datingTopic.addChild(chloveTxt);


        var texture:Texture=Assets.getTexture("EnergyPieChartBg");
        var pieBg:Image=new Image(texture);
        pieBg.x=8.5;
        pieBg.y=5;
        datingTopic.addChild(pieBg);

        mood=Number(savegame.mood[dating]);
        DebugTrace.msg("DatingScene.initLayout mood:"+mood)
        proSprtie=new Sprite();
        proSprtie.x=130;
        proSprtie.y=127;
        datingTopic.addChild(proSprtie);

        drawcom.drawPieChart(proSprtie,"MoodPieChart");
        drawcom.updatePieChart(mood);


        var first_str:String=dating.charAt(0).toUpperCase();
        var _dating:String=dating.slice(1);
        var pro_dating:String="Pro"+first_str.concat(_dating);
        DebugTrace.msg("DatingScene.initLayout pro_dataing:"+pro_dating);

    }


    private function displayCloud():void
    {
        /*

         var cloudlist:Array=comcloud.split(",")
         for(var i:uint=0;i<cloudlist.length;i++)
         {
         scenecom.addDisplayContainer(cloudlist[i]);
         }
         //for
         */
        var cloudAttr:Object={"Kiss":new Point(29,357),
            "Flirt":new Point(16,478),
            "TakePhoto":new Point(42,600),
            "Chat":new Point(833,270),
            "Give":new Point(870,380),
            "Dating":new Point(870,500),
            "Leave":new Point(834,622)
        };

        for(var src:String in  cloudAttr){

            var cloud:Sprite=new Sprite();
            cloud.useHandCursor=true;
            cloud.name=src;
            cloud.x=cloudAttr[src].x;
            cloud.y=cloudAttr[src].y;

            var xml:XML=Assets.getAtalsXML("ComCloudXML");
            var cloudTexture:Texture=Assets.getTexture("ComCloud");
            var cloudAltas:TextureAtlas=new TextureAtlas(cloudTexture,xml);

            var cloudMC:MovieClip=new MovieClip(cloudAltas.getTextures("command_cloud"),24);
            cloudMC.name="mc";
            cloudMC.stop();
            cloud.addChild(cloudMC);
            Starling.juggler.add(cloudMC);

            if(src=="TakePhoto"){
                src="Take\nPhoto";
            }

            var cloudTxt:TextField=new TextField(140,80,src,font,25,0x66CCFF);
            cloudTxt.name="txt";
            cloudTxt.x=23;
            cloudTxt.y=40;
            cloudTxt.vAlign=VAlign.CENTER;
            cloudTxt.hAlign=HAlign.CENTER;
            cloud.addChild(cloudTxt);
            addChild(cloud);
            clouds.push(cloud);
            cloud.addEventListener(TouchEvent.TOUCH, onTouchedCloudHandler);
        }


    }
    private function onTouchedCloudHandler(e:TouchEvent):void{

        var target:Sprite=e.currentTarget as Sprite;
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);

        if(began){
            target.removeEventListener(TouchEvent.TOUCH, onTouchedCloudHandler);
            com=target.name;
            var mc:MovieClip=target.getChildByName("mc") as MovieClip;
            mc.play();
            mc.addEventListener(Event.COMPLETE, onCloudMovieComplete);
            Starling.juggler.add(mc);
            var txt:TextField=target.getChildByName("txt") as TextField;
            txt.visible=false;
        }

    }
    private function onCloudMovieComplete(e:Event):void{

        DebugTrace.msg("DatingScene.onCloudMovieComplete");

        var target:MovieClip=e.currentTarget as MovieClip;
        target.stop();
        Starling.juggler.remove(target);


        layoutFadeout();

    }
    private var  bgEfftween:Tween;
    private var titleIcontween:Tween;
    private var relactionInfoTween:Tween;
    private function layoutFadeout():void{



        mainProfile.removeFromParent(true);

        var chTween:Tween=new Tween(character,0.3,Transitions.EASE_IN_OUT);
        chTween.scaleTo(1);
        chTween.animate("x",260);
        Starling.juggler.add(chTween);

        for(var i:uint=0;i<clouds.length;i++){

            clouds[i].removeFromParent(true)

        }


        bgEfftween=new Tween(bgEffectImg,0.3,Transitions.EASE_IN_OUT);
        bgEfftween.animate("alpha",0);
        bgEfftween.onComplete=onTweenComplete;
        titleIcontween=new Tween(titleIcon,0.3,Transitions.EASE_IN_OUT);
        titleIcontween.animate("alpha",0);
        titleIcontween.onComplete=onTweenComplete;
        relactionInfoTween=new Tween(relactionInfo,0.3,Transitions.EASE_IN_OUT);
        relactionInfoTween.animate("alpha",0);
        relactionInfoTween.onComplete=onTweenComplete;
        Starling.juggler.add(bgEfftween);
        Starling.juggler.add(titleIcontween);
        Starling.juggler.add(relactionInfoTween);


    }

    private function onTweenComplete():void{
        Starling.juggler.removeTweens(bgEfftween);
        Starling.juggler.removeTweens(titleIcontween);
        Starling.juggler.removeTweens(relactionInfoTween);
        Starling.juggler.remove(character);

        var _data:Object=new Object();
        _data.com=com;
        this.dispatchEventWith(DatingScene.COMMIT,false,_data);

    }


    private function confirmDating():void
    {
        /*
         starnger      X
         new friend    1600
         good firend   1200
         clsoe firned  800
         girlfriend    400
         lover         200
         couples          100
         mood/rel=x/100
         */
        var relExp:Object=
        {
            "new friend":1600,
            "good firend":1200,
            "close friend":800,
            "girlfriend":400,
            "lover":200,
            "couples":100
        }
        var dating:String=DataContainer.currentDating;
        var relObj:Object=flox.getSaveData("rel");
        var moodObj:Object=flox.getSaveData("mood")
        var mood:Number=Number(moodObj[dating]);
        var rel:String=relObj[dating];
        if(rel=="wife" || rel=="husband")
        {
            rel="couples";
        }
        DebugTrace.msg("DatingScene.confirmDating dating:"+dating);
        DebugTrace.msg("DatingScene.confirmDating mood:"+mood+" ;rel:"+rel);
        goDating=0;
        //fake
        //rel="couples";
        if(rel=="stranger")
        {
            //can't dating
            goDating=0;
        }
        else
        {
            //can dating
            if(mood<=0)
            {
                //low mood can't dating
                goDating=0;
            }
            else
            {
                DebugTrace.msg("DatingScene.confirmDating relExp:"+relExp[rel]);
                goDating=Math.floor((mood*100/relExp[rel]));


            }
            //if
        }
        //if
        DebugTrace.msg("DatingScene.confirmDating goDating:"+goDating);

        var result:Number=uint(Math.random()*100)+1;
        DebugTrace.msg("DatingScene.confirmDating result:"+result);
        var talking:Object=flox.getSyetemData("date_response");
        var chatlist:Array=new Array();
        var index:Number=0;
        //fake
        //result=1
        if(result<=goDating)
        {
            //success dating
            chatlist=talking.y;
            /*	var savegame:SaveGame=FloxCommand.savegame;
             savegame.date=dating;
             FloxCommand.savegame=savegame;
             */
            flox.save("dating",dating);

            var gameinfo:Sprite=ViewsContainer.gameinfo;
            var _data:Object=new Object();
            _data.dating=dating;
            gameinfo.dispatchEventWith("UPDATE_DATING",false,_data);


        }
        else
        {
            //lose dating
            chatlist=talking.n;
        }
        //if
        index=uint(Math.random()*chatlist.length);
        chat=chatlist[index];

        initBubble();


        command.addedCancelButton(this,doCancelDating);
        /*
         cancel=new Button(Assets.getTexture("XAlt"));
         cancel.name="cancel";
         cancel.x=964;
         cancel.y=720;
         addChild(cancel);
         cancel.addEventListener(Event.TRIGGERED,doCancelDating);*/

    }
    private function  initBubble():void
    {


        var texture:Texture=Assets.getTexture("Bubble");

        //bubbleSprite=new Sprite();
        bubble=new Image(texture);
        bubble.smoothing=TextureSmoothing.TRILINEAR;
        bubble.pivotX=bubble.width/2;
        bubble.pivotY=bubble.height/2;

        bubble.x=768;
        bubble.y=260;

        bubble.scaleX=0;
        bubble.scaleY=0;
        bubble.alpha=0;
        addChild(bubble);



        var tween:Tween=new Tween(bubble,0.5,Transitions.EASE_OUT_ELASTIC);
        tween.animate("scaleX",-1);
        tween.animate("scaleY",1);
        tween.animate("alpha",1);
        tween.onComplete=onBubbleComplete;
        Starling.juggler.add(tween);
    }
    private function onBubbleComplete():void
    {

        Starling.juggler.removeTweens(bubble);



        chatTxt=new TextField(255,190,chat,font,20,0x000000)
        chatTxt.hAlign="left";
        chatTxt.x=634;
        chatTxt.y=110;
        addChild(chatTxt);



    }
    private function doCancelDating():void
    {
        character.removeFromParent();
        //cancel.removeFromParent();


        var _data:Object=new Object();
        _data.name=DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }
    private function getTexture(src:String):Texture
    {
        var textture:Texture=Assets.getTexture(src);
        return textture;
    }

}
}