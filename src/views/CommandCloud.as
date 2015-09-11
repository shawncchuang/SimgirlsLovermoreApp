package views
{
import com.greensock.TweenMax;
import com.greensock.plugins.TweenPlugin;
import com.greensock.plugins.TransformAroundCenterPlugin;
import com.greensock.easing.Back;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;

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

import model.BattleData;


//import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;

import utils.DebugTrace;
import utils.ViewsContainer;

public class CommandCloud extends MovieClip
{
    private var _label:String
    private var comcloud:MovieClip;
    private var cloudTxt:TextField;
    private var command:MainInterface=new MainCommand();
    private var scenecom:SceneInterface=new SceneCommnad();
    private var pos:Object={"L1":new Point(3,374),"L2":new Point(-11,469),"L3":new Point(-8,278),"L4":new Point(2,565),"L5":new Point(1,182),
        "R1":new Point(872,375),"R2":new Point(860,469),"R3":new Point(826,279),"R4":new Point(872,566),"R5":new Point(872,183)}
    private var de_label:String="";
    private var directions:MovieClip;

    public static var HIDED:String="hided";
    TweenPlugin.activate([TransformAroundCenterPlugin]);

    public function CommandCloud(src:String):void{
        //L1_^Departures
        var p:String=src.split("_")[0]
        _label=src.split("_")[1];
        //DebugTrace.msg("CommandCloud.addDisplayObj _label:"+_label);

        var format:TextFormat=new TextFormat();
        format.font="SimImpact";
        format.align=TextFormatAlign.CENTER;
        format.color=0x66CCFF;
        format.size=25;
        cloudTxt=new TextField();
        cloudTxt.x=22;
        cloudTxt.y=20;
        cloudTxt.width=114;
        cloudTxt.height=80;
        cloudTxt.embedFonts=true;
        cloudTxt.multiline=true;
        cloudTxt.defaultTextFormat=format;

        if(p.indexOf("L")!=-1){
            var posX:Number=-200;
            var id:Number=Number(p.split("L").join(""));
        }else{
            posX=1000;
            id=Number(p.split("R").join(""));
        }
        if(_label.indexOf("^")!=-1)
        {
            if(_label.split("^")[0]!="")
                cloudTxt.y=35;

            _label=String(_label.split("^").join("\n"));

        }
        //if
        cloudTxt.text=_label;

        comcloud=new ComCloud();
        comcloud.name=_label;
        //comcloud.x=pos[p].x;
        comcloud.x=posX;
        comcloud.y=pos[p].y;
        comcloud.buttonMode=true;
        comcloud.mouseChildren=false;
        comcloud.addEventListener(MouseEvent.MOUSE_DOWN,doClickComCloud);
        comcloud.addEventListener(MouseEvent.MOUSE_OVER,doOverComCloud);
        comcloud.addEventListener(MouseEvent.MOUSE_OUT,doOutComCloud);

        comcloud.addChild(cloudTxt);

        comcloud.scaleX=0.1;
        comcloud.scaleY=0.1;

        addChild(comcloud);

        TweenMax.to(comcloud,id*0.1+0.2,{x:pos[p].x,transformAroundCenter:{scale:1},easing:Back.easeInOut});



    }


    private var com:String;
    private var targetCloud:MovieClip;
    private function doClickComCloud(e:MouseEvent):void
    {
        targetCloud=e.target as MovieClip;

        com=e.target.name.split("^").join("");
        if(com.indexOf("\n")!=-1){
            com=com.split("\n").join("");
        }
        var flox:FloxInterface=new FloxCommand();
        var turn_switch:String=flox.getSaveData("current_switch").split("|")[1];
        if(com=="Rest" || com=="Stay")
        {

            var switch_verifies:Array=scenecom.switchGateway("Rest||Stay");
            DebugTrace.msg("CommandCloud.doClickComCloud switch_verify="+switch_verifies);
            if(!switch_verifies[0])
            {

                onCloudClicked();
            }
            //if

        }
        else
        {
            var battle_target:Number=-1;
            var success:Boolean=true;
            var battledata:BattleData=new BattleData();

            switch(com){
                case "Battle":
                    battle_target= battledata.checkBattleSchedule("Battle","");
                    if(battle_target==-1){
//                    var _data:Object=new Object();
//                    _data.removed="CannotParticipate";
//                    var current_scene:Sprite=ViewsContainer.currentScene;
//                    current_scene.dispatchEventWith(TopViewEvent.REMOVE,false,_data);

                        success=command.consumeHandle("CannotPaticipate");

                    }else{

                        success=command.consumeHandle(com);

                    }
                    break;
                case "Practice":
                    success=battledata.checkSurvivor();
                    if(!success){
                        command.consumeHandle("NoSurvivor");
                    }

                    break;
                default :
                    success=command.consumeHandle(com);
                    break;
            }

            if(success){
                onCloudClicked();
            }

        }
        //if
        visibleCommandDirecation();
    }
    private function onCloudClicked():void{

        cloudTxt.visible=false;

        disabledComCloud();

        TweenMax.to(comcloud,0.3,{frameLabel:"broke",onComplete:onCloudComplete});
        //comcloud.gotoAndPlay("broke");
        command.playSound("Break");


    }
    private function onCloudComplete():void{

        comcloud.visible=false;
        TweenMax.killChildTweensOf(comcloud);

        DebugTrace.msg("CommandCloud.onCloudComplete com="+com);


        if(com=="LookAround" || com=="Leave"){

            doCloudCommandHandler()

        }else{

            TweenMax.delayedCall(1,onPaidAPComplete);

        }

    }
    private function onPaidAPComplete():void{

        TweenMax.killDelayedCallsTo(onPaidAPComplete);
        doCloudCommandHandler();
    }
    private function doOverComCloud(e:MouseEvent):void
    {

        if(_label.indexOf("\n")!=-1)
        {
            var over_target:String=String(_label.split("\n").join(" "));
        }

        DebugTrace.msg("CommandCloud.doOverComCloud _label:"+over_target);

        var _data:Object=new Object();
        _data.enabled=true;
        _data.content=over_target;
        var gameinfo:Sprite=ViewsContainer.gameinfo;
        if(over_target!=" Leave")
        {
            gameinfo.dispatchEventWith("UPDATE_DIRECTION",false,_data);
        }
    }
    private function doOutComCloud(e:MouseEvent):void
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
    private function disabledComCloud():void
    {
        comcloud.removeEventListener(MouseEvent.MOUSE_DOWN,doClickComCloud);
        comcloud.removeEventListener(MouseEvent.MOUSE_OVER,doOverComCloud);
        comcloud.removeEventListener(MouseEvent.MOUSE_OUT,doOutComCloud);

    }
    private function doCloudCommandHandler():void
    {

        comcloud.visible=false;

        var _data:Object=new Object();
        de_label=_label.split("\n").join("");
        DebugTrace.msg("CommandCloud.doComCloudEnterFrame de_label:"+de_label);


        if(de_label=="StartDating"){


            var flox:FloxInterface=new FloxCommand();
            var dating:String=flox.getSaveData("dating");
            if(dating!=""){

                DataContainer.currentDating=dating;
            }


            var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
            gameEvent._name="clear_comcloud";
            gameEvent.displayHandler();

            _data.name="DatingScene";
            command.sceneDispatch(SceneEvent.CHANGED,_data);

        }else{

            _data.removed=de_label;
            command.topviewDispatch(TopViewEvent.REMOVE,_data);

            var currentScene:String=DataContainer.currentScene;
            var scene_index:Number=currentScene.indexOf("Scene");
            if(scene_index!=-1)
            {
                checkSceneCommand();
            }

        }

    }

    private function checkSceneCommand():void
    {
        var currentlable:String=DataContainer.currentLabel;
        var currentScene:String=DataContainer.currentScene;
        var scene_index:Number=currentlable.indexOf("Scene");
        var looking_index:Number=_label.indexOf("Look");
        var start_dating:Number=_label.indexOf("Dating");
        DebugTrace.msg("CommandCloud.checkSceneCommand currentlable:"+currentlable+" ; currentScene:"+currentScene);


        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvent._name="clear_comcloud";
        gameEvent.displayHandler();

        var sussess:Boolean=false;
        var _data:Object=new Object();
        if(looking_index!=-1)
        {
            //Looking for someone at scene

            _data.name="FoundSomeScene";
            command.sceneDispatch(SceneEvent.CHANGED,_data);



        }
        //if
        /*
         if(start_dating!=-1)
         {
         //start dating
         _data=new Object();
         _data.name="DatingScene";
         //command.sceneDispatch(SceneEvent.CHANGED,_data)

         }
         //if
         */
    }

    private function onInitCurrentScene():void
    {
        DebugTrace.msg("CommandCloud.onInitCurrentScene");

        TweenMax.killAll();
        //Starling.juggler.remove(valueTween);

        var _data:Object=new Object();
        _data.com=de_label;
        var basesprite:Sprite=ViewsContainer.baseSprite;
        basesprite.dispatchEventWith(DatingScene.COMMIT,false,_data);

        /*switch(de_label)
         {
         case "Give":
         case "Chat":
         case "Leave":
         case "Flirt":
         case "Dating":

         var _data:Object=new Object();
         _data.com=de_label;
         var basesprite:Sprite=ViewsContainer.baseSprite;
         basesprite.dispatchEventWith("commit",false,_data);

         break
         }
         //switch
         */


    }
}
}