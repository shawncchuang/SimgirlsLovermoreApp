package controller
{
import com.greensock.TweenMax;
import com.greensock.easing.Cubic;
import com.greensock.easing.Expo;

import data.StoryDAO;

import flash.desktop.NativeApplication;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Point;
import flash.media.SoundMixer;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;


import data.Config;
import data.DataContainer;

import events.BattleEvent;
import events.GameEvent;
import events.SceneEvent;

import model.BattleData;
import model.SaveGame;

import starling.animation.DelayedCall;
import starling.core.Starling;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.BattleScene;
import views.Character;
import views.Member;
import views.VictoryBonus;

public class MemebersCommand implements MembersInterface
{
    private var cpupos:Array=[new Point(308,784),new Point(278,918),new Point(248,1044),
        //new Point(140,70),new Point(160,200),new Point(180,330),
        new Point(98,784),new Point(67,913),new Point(37,1044)
    ]
    private var playerpos:Array=[new Point(630,784),new Point(601,914),new Point(568,1044),
        //new Point(750,70),new Point(730,200),new Point(710,330),
        new Point(839,784),new Point(810,914),new Point(780,1044)
    ]
    private var battlescene:Sprite;
    private var flox:FloxInterface=new FloxCommand();
    private var cpucom:CpuMembersInterface=new CpuMembersCommand();
    //cpu team ,extends Member
    private static var cputeam:Array;
    //cpu main team data, didn't extends Memeber ;
    private var cpu_team:Array;
    private var characters:Array;
    private var current_player:Member;
    private var play_power:Array;
    private var top_index:uint=0;
    private static var playerteam:Array;
    private var battleteam:Object;
    private var player_index:uint=0
    private var battleover:Boolean=false;
    private var hurtplayer:Array=new Array();
    public static var battleEvt:BattleEvent;
    private var delaycall:DelayedCall;
    public function init(scene:MovieClip):void
    {
        battlescene=scene;


        var evt:BattleEvent=new BattleEvent();
        evt.addEventListener(BattleEvent.SWITCH_INDEX,switchMemberIndex);
        battleEvt=evt;

        cpucom.setupBattleTeam();

    }

    public function nextRound():void
    {
        player_index=0;


        for(var id:String in battleteam)
        {

            battleteam[id].updateRound();
        }
        //for
        cpucom.nextRound();
        cpucom.healSetUp();
        cpucom.setupSkillCard();
        cpucom.setupCpuTarget();
        cpucom.commanderSkill();

    }
    public function  reseatCPUPower(id:String):void
    {
        //after commander skill
        battleteam[id].updateRound();
        cpucom.nextRound();
        cpucom.healSetUp();
        cpucom.setupSkillCard();
        cpucom.setupCpuTarget();
    }

    public function ShotDownPower():void{

        cpucom.reseatPower();

        for(var i:uint=0;i<playerteam.length;i++) {
            var player_power:Object = playerteam[i].power;
            player_power.skillID="";
            player_power.target="";
            player_power.targetlist=null;
        }

    }


    public function setPlayerIndex(index:uint):void
    {
        player_index=index;
    }
    public static function set playerTeam(members:Array):void
    {
        playerteam=members;
    }
    public static function get playerTeam():Array
    {
        return playerteam;
    }
    public function getPlayerTeam():Array
    {

        return playerteam;

    }
    public static function set cpuTeam(members:Array):void
    {
        cputeam=members;
    }

    public function getCpuTeam():Array
    {
        return cputeam;
    }

    public function getTopIndex():uint
    {

        return top_index;
    }
    public function getBattleTeam():Object
    {
        //all members
        return battleteam;
    }
    public function set BattleOver(type:Boolean):void{

        battleover=type;
    }
    public function getBattleOver():Boolean
    {
        return battleover
    }
    public function initPlayerMember(clickPlayer:Function):void
    {
        playerteam=new Array();
        battleteam=new Object();
        var membersEffect:Object=DataContainer.MembersEffect;
        var seObj:Object=flox.getSaveData("se");
        var formation:Array=flox.getSaveData("formation");
        characters=new Array();

        var player_power:Array=new Array();

        for(var j:uint=0;j<formation.length;j++)
        {
            var formationStr:String=JSON.stringify(formation[j]);
            //DebugTrace.msg("MemebersCommand.initPlayerMember formation["+j+"]:"+formationStr);

            if(formation[j])
            {


                var power:Object=new Object();
                power=formation[j];
                var member:Member=new Member();
                member.name="player"+formation[j].combat;
                //member.mouseChildren=false;
                member.initPlayer(j);
                power.se=seObj[formation[j].name];
                power.seMax=seObj[formation[j].name];
                power.id="player"+formation[j].combat;
                power.speeded="false";
                power.shielded="false";
                power.skillID="";
                power.reincarnation="false";
                member.updatePower(power);
                member.x=playerpos[j].x+member.width;
                member.y=playerpos[j].y+40;
                battlescene.addChild(member);
                battleteam[member.name]=member;
                playerteam.push(member);
                var battleEvt:BattleEvent=member.memberEvt;
                battleEvt.act="ready";
                battleEvt.updateMemberAct();
                //member.addEventListener(MouseEvent.CLICK,clickPlayer);
                //member.membermc.addEventListener(MouseEvent.CLICK,clickPlayer);
                player_power.push(power);
            }
            //if
        }
        //for
        //for testing bonus game------------------------------
        DataContainer.PlayerPower=player_power;

        playerTeam=playerteam;
        ViewsContainer.battleteam=battleteam;
        DataContainer.MembersEffect=membersEffect;
    }
    public function removePlayerMemberListener(clickPlayer:Function):void
    {

        DebugTrace.msg("MembesCommand.removePlayerMemberListener");
        for(var i:uint=0;i<playerteam.length;i++)
        {
            //playerteam[i].buttonMode=false;
            //playerteam[i].removeEventListener(MouseEvent.CLICK,clickPlayer);

            //playerteam[i].membermc.buttonMode=false;

            playerteam[i].membermc.removeEventListener(MouseEvent.CLICK,clickPlayer);
        }
        //for

    }
    public function addPlayerMemberListener(clickPlayer:Function):void
    {

        for(var i:uint=0;i<playerteam.length;i++)
        {
            if(playerteam[i].power.se>0)
            {
                //playerteam[i].buttonMode=true;
                //playerteam[i].addEventListener(MouseEvent.CLICK,clickPlayer);

                //playerteam[i].membermc.buttonMode=true;
                playerteam[i].getMemberMC();
                playerteam[i].membermc.addEventListener(MouseEvent.CLICK,clickPlayer);
            }
            //if
        }
        //for


    }
    public function initCpuMember():void
    {

        cputeam=new Array();
        var copy_cpupos:Array=new Array();
        for(var m:uint=0;m<cpupos.length;m++)
        {
            var obj:Object=new Object();
            obj.x=cpupos[m].x;
            obj.y=cpupos[m].y+40;
            obj.index=m;
            copy_cpupos.push(obj)
        }
        //for

        var cpu_team:Array=cpucom.getCpuMainTeam();
        var new_cpupos:Array=new Array();
        for(var j:uint=0;j<cpu_team.length;j++)
        {
            var index:Number=Math.floor(Math.random()*copy_cpupos.length);
            new_cpupos.push(copy_cpupos[index]);
            var _cpupos:Array=copy_cpupos.splice(index);
            _cpupos.shift();
            copy_cpupos=copy_cpupos.concat(_cpupos);
        }
        //for

        new_cpupos.sortOn("index",Array.NUMERIC);

        var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");

        //DebugTrace.msg("BattleScene.initCpuMember new_cpupos="+JSON.stringify(new_cpupos));
        for(var i:uint=0;i<cpu_team.length;i++)
        {

            //DebugTrace.msg("BattleScene.initCpuMember new_cpupos["+i+"].index="+new_cpupos[i].index);
            var se:Number=cpu_teams_saved[cpu_team[i].id].se;

            cpu_team[i].combat=new_cpupos[i].index;
            cpu_team[i].se=se;
            cpu_team[i].skillID="";
            var member:Member=new Member();
            member.mouseChildren=false;
            member.initCpuPlayer(cpu_team,i);
            member.updatePower(cpu_team[i]);
            var boss:String=cpu_team[i].ch_name;

            var pos:Point=new Point();
            switch(boss)
            {
                case "fat":
                case "rfs":
                case "rvn":
                    pos.x=Config.bossSkill[boss].pos.x;
                    pos.y=Config.bossSkill[boss].pos.y;
                    break;
                default:
                    pos.x=new_cpupos[i].x;
                    pos.y=new_cpupos[i].y;
                    break

            }
            member.x=pos.x;
            member.y=pos.y;
            battlescene.addChild(member);
            battleteam[member.name]=member;
            //DebugTrace.msg("BattleScene.initCpuMember member:"+member.name);
            cputeam.push(member);
            var battleEvt:BattleEvent=member.memberEvt;
            battleEvt.act="ready";
            battleEvt.updateMemberAct();
            top_index=battlescene.getChildIndex(member);

        }
        //for
        cpuTeam=cputeam;
        CpuMembersCommand.cputeamMember=cputeam;
        ViewsContainer.battleteam=battleteam;


        cpucom.healSetUp();
        cpucom.setupSkillCard();
        cpucom.setupCpuTarget();
        cpucom.commanderSkill();

    }
    public function switchMemberIndex(e:Event):void
    {
        DebugTrace.msg("BattleScene.switchMemberIndex id:"+e.target.id+",top_index:"+top_index);
        battlescene.setChildIndex(battleteam[e.target.id],top_index);

    }
    public function playerReadyPickupCard(id:String):void
    {


        //DebugTrace.msg("BattleScene.playerReadyPickupCard combat:"+power.combat);


        if(id!="all")
        {
            current_player=battleteam[id];

            //battlescene.setChildIndex(current_player,top_index);
            var memberEvt:BattleEvent=current_player.memberEvt;
            memberEvt.processAction();

        }
        else
        {

            for(var i:uint=0;i<playerteam.length;i++)
            {
                //DebugTrace.msg("BattleScene.playerReadyPickupCard formation:"+JSON.stringify(formation[i]));

                //playerteam[i].processAction();
                memberEvt=playerteam[i].memberEvt;
                memberEvt.processAction();
            }
            //for
        }
        //if

    }
    public function choiceTarget(setupTarget:Function,overTarget:Function,outTraget:Function):void
    {
        for(var i:uint=0;i<cputeam.length;i++)
        {

            cputeam[i].addEventListener(MouseEvent.MOUSE_DOWN,setupTarget);
            cputeam[i].addEventListener(MouseEvent.MOUSE_OVER,overTarget);
            cputeam[i].addEventListener(MouseEvent.MOUSE_OUT,outTraget);

        }

    }
    public function reseatCpuTeam(setupTarget:Function,overTarget:Function,outTraget:Function):void
    {
        for(var i:uint=0;i<cputeam.length;i++)
        {
            //TweenMax.to(cputeam[i],0.2,{tint:null});
            cputeam[i].removeEventListener(MouseEvent.MOUSE_DOWN,setupTarget);
            cputeam[i].removeEventListener(MouseEvent.MOUSE_OVER,overTarget);
            cputeam[i].removeEventListener(MouseEvent.MOUSE_OUT,outTraget);
        }
        //for
    }
    private var battlealert:MovieClip;
    private var seObj:Object;
    private var member:Member;
    public function checkTeamSurvive():void
    {
        var command:MainInterface=new MainCommand();
        var type:String=DataContainer.battleType;
        var cpu_gameover:Boolean=true;
        //var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
        var player_gameover:Boolean=true;
        seObj=flox.getSaveData("se");


        var current_se:Number;
        for(var i:uint=0;i<cputeam.length;i++)
        {
            member=cputeam[i];
            //setxt= membermc.getChildByName("se") as TextField;
            var OnArmour:Boolean=member.getOnArmour();
            if(member.chname=="rfs" && OnArmour){
                member.power.se=9999;
                member.power.seMax=9999;
                var cpu_teams:Object=flox.getSaveData("cpu_teams");
                cpu_teams["t12_0"].seMax=9999;
            }

            current_se=member.power.se;
            if(current_se>0)
            {
                cpu_gameover=false;
                break
            }
            //if
        }
        //for
        DebugTrace.msg("BattleScene checkTeamSurvive cputeam power:"+JSON.stringify(member.power));
        var player_power:Array=new Array();
        for(var j:uint=0;j<playerteam.length;j++)
        {
            member=playerteam[j];

            //DebugTrace.msg("BattleScene checkTeamSurvive power:"+JSON.stringify(member.power));
            current_se=member.power.se;

            //current SE doesn't update to Flox when this's Beta Version.-------------------------
            //seObj[member.power.name]=member.power.seMax;
            seObj[member.power.name]=current_se;

            player_power.push(member.power);
            if(current_se>0)
            {
                player_gameover=false;
                break
            }
            //if
        }
        //for
        DataContainer.PlayerPower=player_power;

        if(type.indexOf("story_battle")!=-1){

            var storyId:String="";
            var toScene:String="";
            switch(type){
                case "story_battle_s023":
                    storyId="s024|on";
                    toScene="RestaurantScene";
                    break;
                case "story_battle_s033":
                    storyId="s034|on";
                    toScene="SportsBarScene";
                    break;
                case "story_battle_s036":
                    storyId="s036b|on";
                    toScene="PrivateIslandScene";
                    break;
                case "story_battle_s046":
                    storyId="s046b|on";
                    toScene="LovemoreMansionScene";
                    break

            }
            if(cpu_gameover){

                flox.save("current_switch",storyId);
            }

            if(player_gameover){


                flox.save("current_switch","s9999|on");
            }

            if(cpu_gameover || player_gameover){
                command.stopBackgroudSound();
                BattleScene.battleEvt.battleEndHandle();

                var battleEvt:BattleEvent;
                for(i=0;i<cputeam.length;i++) {
                    member = cputeam[i];
                    battleEvt=member.memberEvt;
                    battleEvt.disabledActionHandle();
                }
                for( j=0;j<playerteam.length;j++) {
                    member = playerteam[j];
                    battleEvt=member.memberEvt;
                    battleEvt.disabledActionHandle();
                }


                delaycall=new DelayedCall(onBattleComplete,1,[toScene]);
                Starling.juggler.add(delaycall);


            }

            function onBattleComplete(toScene:String):void{

                Starling.juggler.remove(delaycall);

                var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
                gameEvt._name="remove_battle";
                gameEvt.displayHandler();


                var _data:Object=new Object();
                _data.name= toScene;
                _data.from="battle";
                command.sceneDispatch(SceneEvent.CHANGED,_data);
                DataContainer.battleType="";
            }


            cpu_gameover=false;
            player_gameover=false;
        }


        if(type=="final_battle"){
            BattleScene.battleEvt.battleEndHandle();
            if(cpu_gameover){

//                for(var i:uint=0;i<cputeam.length;i++) {
//                    member = cputeam[i];
//                    if( member.power.id=="t12_0")
//                    {
//                        member.power.se=9999;
//                        cputeam[i]=member;
//                        break
//                    }
//
//                }
                // member.character.gotoAndStop("SPArmour");
                // member.character.body.act.addEventListener(Event.ENTER_FRAME,doActPlaying);
            }
            if(player_gameover){
                DataContainer.battleType="";
                battleover=true;
                SoundMixer.stopAll();

                delaycall=new DelayedCall(onFinalBattleComplete,1);
                Starling.juggler.add(delaycall);



                function onFinalBattleComplete():void{
                    Starling.juggler.remove(delaycall);

                    var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
                    gameEvt._name="remove_battle";
                    gameEvt.displayHandler();

                    var armour:Boolean=DataContainer.Armour;
                    if(!armour){
                        flox.save("current_switch","s9999|on");
                    }


                    var _data:Object=new Object();
                    _data.name= "SSCCArenaScene";
                    _data.from="battle";
                    command.sceneDispatch(SceneEvent.CHANGED,_data);


                }


            }



            cpu_gameover=false;
            player_gameover=false;

        }

        if(cpu_gameover ||  player_gameover)
        {
            //GameOver--------------------------------
            BattleScene.battleEvt.battleEndHandle();

            SoundMixer.stopAll();
            command.stopBackgroudSound();
            // DebugTrace.msg("BattleScene checkTeamSurvive-------- Batttle Over seObj:"+JSON.stringify(seObj));
            battleover=true;


            var battlescene:Sprite=ViewsContainer.battlescene;
            var replaybtn:MovieClip;
            var quitbtn:MovieClip;

            var scene:String=DataContainer.currentScene;

            var evtObj:Object = new Object();

            var winner:String="";
            var team_id:String=cputeam[0].name.split("_")[0];


            if(cpu_gameover)
            {
                evtObj.event = "Victory@"+scene;
                evtObj.type=type;
                flox.logEvent("Battle", evtObj);

                battlealert=new VictoryAlert();
                command.playBackgroudSound("BattleVictory");
                saveRecord("victory");

                winner="player";
            }
            if(player_gameover)
            {
                evtObj.event = "Defeat@"+scene;
                evtObj.type=type;
                flox.logEvent("Battle", evtObj);

                battlealert=new DefeatAlert();
                command.playBackgroudSound("BattleDefeat");
                saveRecord("defeat");

                winner="cpu";
            }


            DataContainer.BattleWinner=winner;
            battlealert.x=-1718;
            battlealert.y=-455;
            battlealert.alpha=0;
            replaybtn=battlealert.animc.replaybtn;
            quitbtn=battlealert.animc.quitbtn;
            replaybtn.buttonMode=true;
            quitbtn.buttonMode=true;
            battlescene.addChild(battlealert);

            if(type!="random_battle" && type!="practice" && type.indexOf("story_battle")==-1 && type!="final_battle"){
                var battleData:BattleData=new BattleData();
                battleData.finishedBattle(winner,team_id);
            }

            startVictoryDace();
            // Battle honur bonus---------------------------------------
            replaybtn.visible=false;
            quitbtn.visible=false;
            TweenMax.to(battlealert,1,{alpha:1,delay:6,onComplete:onBattleAlertFadIn});
            //-------------------


            function onBattleAlertFadIn():void
            {
                TweenMax.to(battlealert,0.5,{alpha:0,delay:2,onComplete:onBattleAlertFadeout});

            }
            function onBattleAlertFadeout():void
            {
                //disabled on Beta version
                TweenMax.killAll();
                var command:MainInterface=new MainCommand();
                command.stopBackgroudSound();
                var battle_type:String=DataContainer.battleType;

                if(battle_type=="schedule"){
                    var rank:Number=command.checkRanking();
                    var dateStr:String=flox.getSaveData("date");
                    var day:String=dateStr.split(".")[1];
                    var month:String=dateStr.split(".")[2];
                    var today:String=month+"_"+day;
                    var battleDays:Array=Config.battleDays;
                    if(rank>2 && today==battleDays[battleDays.length-1]){
                        //the last battle
                        flox.save("current_switch","s9999|on");
                    }

                }

                if(cpu_gameover)
                {

//                    var ranking:Array=flox.getSaveData("ranking");
//
//                    for(var i:uint=0;i< ranking.length;i++){
//                        if(ranking[i].team_id == "player"){
//                            var win:Number= ranking[i].win;
//                            win++;
//                            ranking[i].win=win;
//                            break
//                        }
//                    }
//                    flox.save("ranking",ranking);


                    var battleEvt:BattleEvent=BattleScene.battleEvt;
                    battleEvt.onStartBonusGame();

                }
                else
                {

                    var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
                    gameEvt._name="remove_battle";
                    gameEvt.displayHandler();

                    var scene:String=DataContainer.BatttleScene;
//                    DebugTrace.msg("MembersCommand.memberCommand battle_type="+battle_type+" ,scene="+scene);
                    if(battle_type=="schedule")
                    {

                        scene="SSCCArenaScene";


                    }else if(battle_type=="practice"){

                        scene="AcademyScene";

                    }else if(battle_type=="random_battle"){

                        scene="MainScene";

                    }else{

                        if(scene=="Story"){

                            var battleData:BattleData=new BattleData();
                            scene=battleData.backStoryScene();
                        }


                    }

                    var _data:Object=new Object();
                    _data.name= scene;
                    _data.from="battle";
                    command.sceneDispatch(SceneEvent.CHANGED,_data);
                }
                //if
            }

        }
        else
        {

            flox.save("se",seObj);


        }
        //if
        //DataContainer.survivePlayer=playerteam;
    }
//    private function doActPlaying(e:Event):void{
//
//
//        if(e.target.currentFrame==e.target.totalFrames)
//        {
//            e.target.removeEventListener(Event.ENTER_FRAME,doActPlaying);
//
//            TweenMax.to( member.character, 0.5, {colorTransform:{tint:0x000000, tintAmount:0.6}});
//
//            member.character.gotoAndStop("RDY")
//        }
//
//    }
    private function startVictoryDace():void
    {

        for(var id:String in battleteam)
        {
            var memberEvt:BattleEvent=battleteam[id].memberEvt;
            memberEvt.battleEndHandle();

        }
        //for

    }
    private function doReplayHandle(e:MouseEvent):void
    {

        flox.logEvent("BattleReplay");
        TweenMax.killAll();
        var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvt._name="remove_battle";
        gameEvt.displayHandler();

        var command:MainInterface=new MainCommand();
        command.stopBackgroudSound();
        var _data:Object=new Object();
        _data.name= "BetaScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function doQuitHandle(e:MouseEvent):void
    {
        flox.logEvent("BattleQuit");
        NativeApplication.nativeApplication.exit();

    }
    private var equipedlist:Array=new Array();
    private var equipedcard:MovieClip;
    public function equipedCard(target:String,card:MovieClip):void
    {
        var posX:Number=-20;
        var posY:Number=150/2;

        var equipedcard:MovieClip=new EquipedCard();
        equipedcard.name=target+"_card";
        //equipedcard.x=card.x+card.parent.x+(card.width/2);
        //equipedcard.y=battlescene.height-card.parent.y/2;
        //battlescene.addChild(equipedcard);
        equipedcard.x=posX;
        equipedcard.y=posY;
        playerteam[player_index].addChild(equipedcard);

        equipedlist[player_index]=equipedcard;
        //DebugTrace.msg("MemebersCommand.removeEquipedCard  equipedlist["+player_index+"]="+equipedlist[player_index]);

        TweenMax.to(equipedcard,1,{scaleX:0.5,scaleY:0.5,ease:Expo.easeOut});


    }
    public function removeEquipedCard():void
    {
        equipedcard=equipedlist[player_index];
        //DebugTrace.msg("MemebersCommand.removeEquipedCard  equipedcard["+player_index+"]"+equipedcard);
        if(equipedcard)
        {
            var posX:Number=equipedcard.x;
            var posY:Number=equipedcard.y;
            TweenMax.to(equipedcard,0.25,{x:posX+50,y:posY+10,scaleX:0.8,scaleY:0.8,onComplete:onMotionEquiped,ease:Cubic.easeOut});
            function onMotionEquiped():void
            {
                TweenMax.to(equipedcard,0.5,{x:posX+300,y:posY+20,scaleX:0.1,scaleY:0.1,onComplete:onEquipedFadeout,ease:Cubic.easeOut});
            }

        }
        //if
    }
    private function onEquipedFadeout():void
    {
        TweenMax.killTweensOf(equipedcard);
        try
        {
            playerteam[player_index].removeChild(equipedcard);
        }
        catch(e:Error)
        {

        }
        equipedlist[player_index]=null;
    }
    public function removeAllEquidedCards():void
    {

        for(var i:uint=0;i<playerteam.length;i++)
        {
            var plaer_memeber:Member=playerteam[i];
            //var _equipedcard:MovieClip=equipedlist[i];
            var eqcard:MovieClip=plaer_memeber.getChildByName(plaer_memeber.name+"_card") as MovieClip;

            if(eqcard)
            {
                plaer_memeber.removeChild(eqcard);

            }

            //if


        }
        //for
        equipedlist=new Array();

    }
    public function clearPlayerTarget():void
    {

        for(var i:uint=0;i<playerteam.length;i++)
        {
            var player_member:Member=playerteam[i];
            player_member.power.target="";
            player_member.power.targetlist=new Array();
            player_member.updatePower(player_member.power);
            if(player_member.status=="mind_ctrl")
            {
                player_member.updateStatus("");


                var memberEvt:BattleEvent=player_member.memberEvt;
                memberEvt.processAction();
            }
            //if

        }


    }
    private function seTextfield(str:String):TextField
    {
        var format:TextFormat=new TextFormat();
        format.color=0xFFFFFF;
        format.size=14;
        format.font="Neogrey Medium";
        var  txt:TextField=new TextField();
        txt.name="se";
        txt.defaultTextFormat=format;
        txt.autoSize=TextFieldAutoSize.LEFT;
        txt.y=20;
        txt.text=str;

        return txt
    }

    private function saveRecord(type:String):void
    {
        DebugTrace.msg("MembersCommand.saveRecord");
        var record:Object=flox.getSaveData(type);
        var members:Array=playerteam;
        for(var i:uint=0;i<members.length;i++)
        {
            var name:String=members[i].power.name;
            var num:Number=record[name];
            num++;
            record[name]=num;
        }
        //for
        flox.save(type,record,onSaveComplete);
    }
    private function onSaveComplete(savegame:*=null):void
    {
        DebugTrace.msg("MembersCommand.onSaveComplete");
        flox.save("se",seObj);
    }
}
}