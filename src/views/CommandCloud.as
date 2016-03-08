package views
{


import controller.Assets;



import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;

import flash.geom.Point;

import model.BattleData;

import starling.animation.DelayedCall;

import starling.animation.Juggler;
import starling.animation.Transitions;
import starling.animation.Tween;
import starling.display.MovieClip;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;


//import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;

import utils.DebugTrace;
import utils.ViewsContainer;

public class CommandCloud extends Sprite
{
    private var _label:String;
    private var cloudTxt:TextField;
    private var command:MainInterface=new MainCommand();
    private var scenecom:SceneInterface=new SceneCommnad();
    private var pos:Object={"L1":new Point(3,374),"L2":new Point(-11,469),"L3":new Point(-8,278),"L4":new Point(2,565),"L5":new Point(1,182),
        "R1":new Point(872,375),"R2":new Point(860,469),"R3":new Point(826,279),"R4":new Point(872,566),"R5":new Point(872,183)};
    private var de_label:String="";
    public static var REMOVED:String;
    private var directions:MovieClip;

//    public static var HIDED:String="hided";
//    TweenPlugin.activate([TransformAroundCenterPlugin]);

    private var delcall:DelayedCall;
    private var ran_battle_rate:Number=20;

    private var cloud:Sprite;
    private var cloudMC:MovieClip;
    private var cloudAltas:TextureAtlas;
    public function CommandCloud(src:String):void{
        //L1_^Departures
        var p:String=src.split("_")[0];
        _label=src.split("_")[1];
        //DebugTrace.msg("CommandCloud.addDisplayObj _label:"+_label);


        if(p.indexOf("L")!=-1){

            var id:Number=Number(p.split("L").join(""));
        }else{

            id=Number(p.split("R").join(""));
        }
        if(_label.indexOf("^")!=-1)
        {
            if(_label.split("^")[0]!=""){
                _label=String(_label.split("^").join("\n"));
            }else{
                _label=String(_label.split("^").join(""));
            }

        }


        cloud = new Sprite();
        cloud.useHandCursor = true;
        cloud.name = _label;
        cloud.x = pos[p].x;
        cloud.y=pos[p].y;

        var xml:XML = Assets.getAtalsXML("ComCloudXML");
        var cloudTexture:Texture = Assets.getTexture("ComCloud");
        cloudAltas = new TextureAtlas(cloudTexture, xml);

        cloudMC = new MovieClip(cloudAltas.getTextures("command_cloud"), 30);
        cloudMC.name="mc";
        cloudMC.pivotX = cloudMC.width / 2;
        cloudMC.pivotY = cloudMC.height / 2;
        cloudMC.stop();
        cloud.addChild(cloudMC);
        Starling.juggler.add(cloudMC);

        cloudTxt=new TextField(cloudMC.width, cloudMC.height-5,_label);
        cloudTxt.format.setTo("SimImpact",25,0x66CCFF);
        cloudTxt.name="txt";
        cloudTxt.pivotX = cloudTxt.width / 2;
        cloudTxt.pivotY = cloudTxt.height / 2;
        cloudTxt.autoScale=true;
        cloud.addChild(cloudTxt);

        cloud.x+=(cloudMC.width/2-10);
        addChild(cloud);
        cloud.addEventListener(TouchEvent.TOUCH, doClickComCloud);

        this.addEventListener(CommandCloud.REMOVED,onRemovedHandle);

        //TweenMax.to(comcloud,id*0.1+0.2,{x:pos[p].x,transformAroundCenter:{scale:1},easing:Back.easeInOut,onComplere:onCloudComplete});

//        function onCloudComplete():void{
//            TweenMax.killTweensOf(comcloud);
//        }


    }


    private var com:String;

    private function doClickComCloud(e:TouchEvent):void
    {
        cloud = e.currentTarget as Sprite;
        com=cloud.name.split("^").join("");
        var began:Touch = e.getTouch(cloud, TouchPhase.BEGAN);
        var hover:Touch = e.getTouch(cloud, TouchPhase.HOVER);

        if(hover){
            doOverComCloud();
        }else{
            doOutComCloud();
        }
        if (began) {

            if(com.indexOf("\n")!=-1){
                com=com.split("\n").join("");
            }
            var flox:FloxInterface=new FloxCommand();
            //var turn_switch:String=flox.getSaveData("current_switch").split("|")[1];
            DebugTrace.msg("CommandCloud.doClickComCloud com="+com);
            if(com=="Rest" || com=="Stay")
            {

                var switch_verifies:Array=scenecom.switchGateway("Rest");
                DebugTrace.msg("CommandCloud.doClickComCloud switch_verify="+switch_verifies);
                var battle_verfiy:Boolean=switch_verifies[switch_verifies.length-1];
                if(!switch_verifies[0] && battle_verfiy)
                {
                    //no story yet && no battle day
                    onCloudClicked();


                }else{
                    var switchID:String=flox.getSaveData("current_switch").split("|")[0];
                    var switchs:Object=flox.getSyetemData("switchs");
                    var values:Object=switchs[switchID];
                    var alert:Sprite = new AlertMessage(values.hints);
                    if(!battle_verfiy){
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
            else
            {
                var battle_target:Number=-1;
                var success:Boolean=true;
                var battledata:BattleData=new BattleData();
                var survivor:Boolean=false;
                switch(com){
                    case "Battle":
                        battle_target= battledata.checkBattleSchedule("Battle","");

                        DebugTrace.msg("CommandCloud.doClickComCloud survivor="+survivor);

                        if(battle_target==-1){

                            success=command.consumeHandle("CannotPaticipate");

                        }else if(battle_target==-2) {
                            //already battle today
                            success=command.consumeHandle("CannotBattleToday");

                        }else{

                            survivor=battledata.checkSurvivor();
                            if(!survivor){
                                success=command.consumeHandle("NoSurvivor_Normal");
                            }else{
                                success=command.consumeHandle(com);
                            }

                        }


                        break;
                    case "Practice":
                        survivor=battledata.checkSurvivor();
                        if(!survivor){
                            success=command.consumeHandle("NoSurvivor_Normal");
                        }else{
                            success=command.consumeHandle(com);
                        }

                        break;

                    default :
                        success=command.consumeHandle(com);
                        if(com=="LookAround"){
                            var gameinfo:Sprite = ViewsContainer.gameinfo;
                            gameinfo.dispatchEventWith("UPDATE_INFO");
                        }
                        break;
                }

                if(success){
                    onCloudClicked();
                }

            }
            //if
            visibleCommandDirecation();
        }

    }

    private function onCloudClicked():void{
        cloud.removeEventListeners();

        visibleCommandDirecation();
        command.playSound("Break");

        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvent._name="clear_comcloud";
        gameEvent.displayHandler();

        var mc:MovieClip = cloud.getChildByName("mc") as MovieClip;
        mc.play();
        mc.addEventListener(Event.COMPLETE, onCloudMovieComplete);
        Starling.juggler.add(mc);
        var txt:TextField = cloud.getChildByName("txt") as TextField;
        txt.removeFromParent(true);



    }
    private function onCloudMovieComplete(e:Event):void {

        DebugTrace.msg("DatingScene.onCloudMovieComplete");
        var target:MovieClip = e.currentTarget as MovieClip;
        target.pause();
        Starling.juggler.remove(target);
        target.dispose();
        target.removeFromParent(true);
        if(com=="Leave"){

            doCloudCommandHandler();

        }else{


            //delcall=new DelayedCall(onPaidAPComplete,0.5);
            //Starling.juggler.add(delcall);
            doCloudCommandHandler();
        }


    }
    private function onPaidAPComplete():void{


        Starling.juggler.remove(delcall);
        doCloudCommandHandler();
    }
    private function doOverComCloud():void
    {
        //DebugTrace.msg("CommandCloud.doOverComCloud com:"+com);
        var over_target:String=com;
        if(com.indexOf("\n")!=-1)
        {
            over_target=String(com.split("\n").join(" "));
        }

        //DebugTrace.msg("CommandCloud.doOverComCloud com:"+over_target);

        var _data:Object=new Object();
        _data.enabled=true;
        _data.content=over_target;
        var gameinfo:Sprite=ViewsContainer.gameinfo;
        if(over_target.indexOf("Leave")==-1)
        {
            gameinfo.dispatchEventWith("UPDATE_DIRECTION",false,_data);
        }
    }
    private function doOutComCloud():void
    {

        visibleCommandDirecation();
    }
    private function visibleCommandDirecation():void
    {

        var _data:Object=new Object();
        _data.enabled=false;
        _data.content="";
        var gameinfo:Sprite=ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_DIRECTION",false,_data);

    }
    public function onDisableHandle():void
    {
        DebugTrace.msg("CommandCloud.disableComCloud");



    }
    private function doCloudCommandHandler():void
    {

        cloud.visible=false;

        var _data:Object=new Object();
        de_label=_label.split("\n").join("");
        DebugTrace.msg("CommandCloud.doComCloudEnterFrame de_label:"+de_label);


        if(de_label=="StartDating"){
            _data.from="CommandCloud";
            _data.name="DatingScene";
            command.sceneDispatch(SceneEvent.CHANGED,_data);

        }else{


            var currentScene:String=DataContainer.currentScene;
            var scene_index:Number=currentScene.indexOf("Scene");
            if(scene_index!=-1)
            {

                if(de_label=="LookAround"){
                    checkSceneCommand();

                }else{
                    _data.removed=de_label;
                    command.topviewDispatch(TopViewEvent.REMOVE,_data);
                }

            }else{
                _data.removed=de_label;
                command.topviewDispatch(TopViewEvent.REMOVE,_data);
            }




        }

    }

    private function checkSceneCommand():void
    {
        DataContainer.DatingSuit="";
        var currentlable:String=DataContainer.currentLabel;
        var currentScene:String=DataContainer.currentScene;
        var scene_index:Number=currentlable.indexOf("Scene");
        var looking_index:Number=_label.indexOf("Look");
        var start_dating:Number=_label.indexOf("Dating");
        DebugTrace.msg("CommandCloud.checkSceneCommand currentlable:"+currentlable+" ; currentScene:"+currentScene);

        var sussess:Boolean=false;
        var _data:Object=new Object();
        if(looking_index!=-1)
        {
            //Looking for someone at scene
            var battledata:BattleData=new BattleData();
            //var ranbattle:Boolean=battledata.checkSurvivor();
            var perbattle:Number=Math.floor(Math.random()*100)+1;

            var enabled:Boolean=command.checkSceneEnable("PoliceStationScene");
            if(enabled){
                //scene enabled
                if(perbattle<=ran_battle_rate){
                    //could random battle

                    DataContainer.battleType="random_battle";
                    command.removeShortcuts();
                    command.consumeHandle("RandomBattle");

                }else{

                    _data.name="FoundSomeScene";
                    command.sceneDispatch(SceneEvent.CHANGED,_data);
                }
            }else{

                _data.name="FoundSomeScene";
                command.sceneDispatch(SceneEvent.CHANGED,_data);

            }


        }

    }
    private function onClosedRandomFightAlert():void{

        var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
        gameEvent._name = "clear_comcloud";
        gameEvent.displayHandler();

        var _data:Object = new Object();
        _data.name = DataContainer.currentScene;
        var command:MainInterface = new MainCommand();
        command.sceneDispatch(SceneEvent.CHANGED, _data);
    }

    private function onInitCurrentScene():void
    {
        DebugTrace.msg("CommandCloud.onInitCurrentScene");


        var _data:Object=new Object();
        _data.com=de_label;
        var basesprite:Sprite=ViewsContainer.baseSprite;
        basesprite.dispatchEventWith(DatingScene.COMMIT,false,_data);

    }
    private function onRemovedHandle(e:Event):void{

        visibleCommandDirecation();

        cloud.removeEventListeners();
        var tween:Tween=new Tween(cloud,0.5,Transitions.EASE_OUT);
        tween.scaleTo(0);
        tween.delay=0.25;
        tween.onComplete=onClodFadeoutComplete;
        Starling.juggler.add(tween);
    }
    private function onClodFadeoutComplete():void{
        Starling.juggler.removeTweens(cloud);
        //cloudAltas.dispose();
        cloudMC.dispose();
        cloud.removeFromParent(true);
    }
}
}