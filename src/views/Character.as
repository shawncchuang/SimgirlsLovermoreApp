package views
{
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.greensock.loading.display.ContentDisplay;

import data.Config;

import feathers.controls.Label;

import fl.motion.Color;

import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.Timer;

import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.MembersInterface;
import controller.MemebersCommand;

import data.Config;
import data.DataContainer;

import events.BattleEvent;

import model.BattleData;
import services.LoaderRequest;
import utils.DebugTrace;
import utils.ViewsContainer;

import views.BattleScene;



public class Character extends MovieClip
{


    protected var flox:FloxInterface=new FloxCommand();
    protected var memberscom:MembersInterface=new MemebersCommand();
    private var command:MainInterface=new  MainCommand();
    private var characters:Array=new Array();
    protected var status:String="";
    protected var ch_name:String;
    protected var gender:String;
    protected var id:String;
    //private var playermc:MovieClip;
    protected var skillAni:MovieClip;
    protected var character:MovieClip;
    //private var cpumc:MovieClip;
    //power={"id":"t0_4","enemy":1,"se":100,"target":"player1","combat":4,"effect":"dizzy","area":0,"targetlist":[1],
    //"speed":130,"ele":"air","label":"Whirlwind Punch","from":"cpu","power":35,"jewel":"2|a"}
    protected var power:Object=new Object();
    protected var selected:Boolean=false;
    protected var membermc:MovieClip;
    protected var arrow:MovieClip;
    protected var dissytap:EffectTapView;
    private var round:Number=0;
    private var rage_round:Number=0;
    private var rage_round_max:Number=3;
    private var dizzy_round_max:Number=3;
    private var scared_round_max:Number=3;
    private var timer:Timer;
    private var scared_reduce_speed:Number=0.5;
    protected var plus_speed:Number=100;
    protected var ett:MovieClip;
    private var _from:String;
    protected var effShield:MovieClip=null;

    private var part_pack:Array=new Array();
    private var bpart_pack:Array=["zack","xns","vdk","smn","shn","sao","prms","prml",
        "playerb","playera","lenus","helmb","helma","fan","bdh"];
    private var gpart_pack:Array=["mia","san","dea","sirena","tomoru","ciel","klr","chef","akr","playerb","playera"];

    private var allpart_pack:Object={
        "B":bpart_pack,
        "G":gpart_pack
    };
    private var otherCharacters:Array=["zack","xns","vdk","smn","prms","prml","fan","bdh","mia","san","chef","akr"];
    private var boy_names:Array=["lenus","sao","zack","Male_player","Female_player","prms","smn"];
    private var girl_names:Array=["sirena","tomoru","dea","klr","ceil"];


    private  static var ready:String="RDY";
    private  static var knockback:String="KnockBack";
    private  static var hit:String="HIT";
    private  static var hop:String="HOP";
    private  static var hurt:String="HURT";
    private  static var rage:String="RAGE";
    private static var dizzy:String="DIZZY";
    private static var scared:String="SCARED";
    private  static var death:String="DEATH";
    private static var charge:String="CHARGE";
    private  static var BattleCry:String="BattleCry";
    private  static var heal:String="HEAL";
    protected var heal_tint:MovieClip;

    private var boss_model:Boolean=false;
    protected var OnArmour:Boolean=false;

    public function Character()
    {


    }
    public function updatePower(_data:Object):void
    {

        if(id.indexOf("player")!=-1)
        {
            var loves:Object=flox.getSaveData("love");
            var maxSE:Number=Number(loves[power.name]);

        }
        else
        {
            //cpu
            var cpuSE:Object=flox.getSaveData("cpu_teams");
            maxSE=Number(cpuSE[id].seMax);

        }
        //if
        if(_data)
        {
            if(!_data.target)
            {
                var target:String="";
            }
            else
            {
                target=_data.target;
            }
            //if
            for(var attr:String in _data)
            {

                if(status=="scared" && attr=="speed")
                {
                    _data[attr]=Math.floor(_data[attr]*scared_reduce_speed);
                }
                //if

                if(attr=="se")
                {
                    if(_data[attr]>maxSE)
                        _data[attr]=maxSE;
                }

                power[attr]=_data[attr];

            }
            //for
            if(power.shielded=="true")
            {
                DebugTrace.msg("Character.updatePower name:"+power.name);
                if(!effShield)
                {

                    switch(power.skillID.charAt(0))
                    {
                        case "a":
                            effShield=new A_Shield_Effect();
                            break;
                        case "w":
                            effShield=new W_Shield_Effect();
                            break
                    }

                    //effShield=new EffectShield();
                    effShield.name="shield_"+name;
                    if(id.indexOf("player")!=-1)
                    {
                        effShield.x=-(effShield.width);
                    }
                    //if
                    addChild(effShield);
                    effShield.visible=false;
                }
                //if
            }



            var seText:TextField=membermc.getChildByName("se") as TextField;
            //seText.visible=true;
            seText.text=String(power.se);
        }
        else
        {
            power=new Object();
        }
        //if
        //DebugTrace.msg("Character.updatePower status="+status);
        DebugTrace.msg("Character.updatePower power="+ JSON.stringify(power));


    }
    /*public function onSelected():void
     {
     if(!selected)
     {

     selected=true;
     var arrow:MovieClip=membermc.getChildByName("arrow") as MovieClip;
     arrow.visible=false;
     }
     else
     {
     selected=false;
     }

     }*/

    public function initPlayer(index:Number):void
    {
        var membersEffect:Object=DataContainer.MembersEffect;
        var seObj:Object=flox.getSaveData("se");
        var formation:Array=flox.getSaveData("formation");
        var formation_info:String=JSON.stringify(formation[index]);

        ch_name=formation[index].name;
        membermc=new MovieClip();
        var playerId:String="player"+formation[index].combat;
        id=playerId;
        membermc.name=playerId;
        membersEffect[playerId]="";
        gender=flox.getSaveData("avatar").gender;
        if(ch_name=="player")
        {
            ch_name=gender+"_"+ch_name;
        }

        if(boy_names.indexOf(ch_name)!=-1)
        {
            characters=["lenus","sao","player","prms","smn"];
            part_pack=bpart_pack;
            character=new Boy();
        }
        //if
        if(girl_names.indexOf(ch_name)!=-1)
        {
            characters=["sirena","tomoru","dea","ceil","klr","player"];
            part_pack=gpart_pack;
            character=new Girl();
        }
        //if
        var effect:MovieClip=new Effect();
        //effect.x=-150;
        effect.name="effect";
        membermc.addChild(effect);
        character.name="character";
        character.scaleX=-1;
        if(ch_name.indexOf("player")!=-1)
        {
            ch_name=ch_name.split("_")[1];
        }
        var se:String=String(seObj[ch_name]);
        var seTxt:TextField=seTextfield(se);
        seTxt.x=-(Math.floor(character.width/2+seTxt.width/2));
        arrow=new ArrowFinger();
        arrow.name="arrow";
        arrow.x=-character.width;
        arrow.y=character.height/2;
        arrow.visible=false;
        membermc.addChild(character);
        membermc.addChild(seTxt);
        membermc.addChild(arrow);

        addChild(membermc);

        membermc.addEventListener(MouseEvent.MOUSE_OVER,onOverPlayer);
        membermc.addEventListener(MouseEvent.MOUSE_OUT,onOutPlayer);
    }
    private var healArea:Array;
    private var heal_target:Array;
    private function onOverPlayer(e:MouseEvent):void
    {
        
        var memberscom:MembersInterface=new MemebersCommand();
        var battleteam:Object=memberscom.getBattleTeam();
        var top_index:uint=memberscom.getTopIndex();
        var battleView:MovieClip=ViewsContainer.battleView;
        //battleView.setChildIndex(battleteam[e.target.name],top_index);
        memberscom.setPlayerIndex(top_index);

        if(!BattleScene.fighting)
        {
            //var arrow:MovieClip=e.target.getChildByName("arrow") as MovieClip;
            arrow.visible=true;
        }
        //if

        var current_power:Object=DataContainer.currentPower;
        if(current_power.skillID=="n2" && current_power.skillID!=undefined)
        {

            var battledata:BattleData=new BattleData();
            var combat:Number=Number(e.target.name.split("player").join(""));

            healArea=battledata.praseTargetList(current_power,combat);

            heal_target=new Array();
            if(current_power.id!=name)
            {
                for(var i:uint=0;i<healArea.length;i++)
                {
                    //var memberscom:MembersInterface=new MemebersCommand();
                    var player_team:Array=memberscom.getPlayerTeam();
                    for(var j:uint=0;j<player_team.length;j++)
                    {
                        if(player_team[j].power.combat==healArea[i])
                        {
                            heal_target.push(player_team[j]);

                            var battleEvt:BattleEvent=player_team[j].memberEvt;
                            battleEvt.enabledAreaMemberHeal();

                        }
                        //if
                    }
                    //for
                }
                //for
            }
            //if
            DataContainer.healArea=heal_target;

        }
        //if
        if(current_power.skillID=="n1" || current_power.skillID=="n2")
        {
            //var arrow:MovieClip=e.target.getChildByName("arrow") as MovieClip;
            if(current_power.id==name)
            {
                arrow.visible=false;
                command.playSound("BattlePointer");
            }
        }

    }
    private function onOutPlayer(e:MouseEvent):void
    {
        if(!BattleScene.fighting)
        {
            //var arrow:MovieClip=e.target.getChildByName("arrow") as MovieClip;
            arrow.visible=false;
        }
        var current_power:Object=DataContainer.currentPower;
        if(current_power.skillID=="n2")
        {
            //if(e.target.name.indexOf("Heal")!=-1)
            //{
            var memberscom:MembersInterface=new MemebersCommand();
            var player_team:Array=memberscom.getPlayerTeam();
            for(var j:uint=0;j<player_team.length;j++)
            {
                var battleEvt:BattleEvent=player_team[j].memberEvt;
                battleEvt.disabledMemberHeal();
            }

            //}
            //if
        }
        //if
    }
    private function clickPlayer(e:MouseEvent):void
    {

        DebugTrace.msg("Character.clickPlayer id="+ id);
        var battelEvt:BattleEvent=MemebersCommand.battleEvt;
        battelEvt.id=id;
        battelEvt.switchMemberIndex();
    }
    public function initCpuPlayer(main_team:Array,index:Number):void
    {

        OnArmour=false;
        var cpu_teams:Object=flox.getSyetemData("cpu_teams");
        //var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
        membermc=new MovieClip();
        id=main_team[index].id;
        ch_name=main_team[index].ch_name;
        membermc.name=id;
        boss_model=checkBossModel();
        DebugTrace.msg("Character.initCpuPlayer id="+ id+" ,ch_name="+ch_name+" ,boss_model="+boss_model);
        part_pack=bpart_pack;
        if(id.split("_")[1]=="0")
        {
            //commander
            //boss
            //characters=otherCharacters;
            //ch_name=otherCharacters[Math.floor(Math.random()*otherCharacters.length)];
            var boy_model:Number=bpart_pack.indexOf(ch_name);
            var girl_model:Number=gpart_pack.indexOf(ch_name);
            if(boy_model==-1 && girl_model==-1)
            {
                //boss model
                characters=new Array();
                //var boss:Object={"gor":new GOR(),"fat":new FAT(),"tgr":new TGR(),"rfs":new RFS(),"rvn":new RVN()};
                //skillAni=character=boss[ch_name];
                if(ch_name=="gor")
                    character=new GOR();
                if(ch_name=="fat")
                    character=new FAT();
                if(ch_name=="tgr")
                    character=new TGR();
                if(ch_name=="rfs")
                    character=new RFS();
                if(ch_name=="rvn")
                    character=new RVN();
                if(ch_name=="nhk")
                    character=new NHK();
                skillAni=character;
                switch(ch_name)
                {
                    case "gor":
                    case "tgr":
                        character.width=180;
                        character.height=180;
                        break;
                    case "rfs":
                    case "rvn":
                    case "nhk":
                        character.width=150;
                        character.height=150;
                        break
                }



            }
            else
            {
                //character boss model
                //ch_name="vdk";
                if(bpart_pack.indexOf(ch_name)!=-1)
                {
                    characters=["zack","xns","vdk","smn","shn","prms","prml","fan","bdh"];
                    character=new Boy();
                }
                else
                {
                    part_pack=gpart_pack;
                    characters=["mia","san","chef","akr"];
                    character=new Girl();

                }
                //if

            }
            //if

        }
        else
        {
            //other members
            switch(id) {
                case "t7_1":

                    //XS Sana & Xenos
                    part_pack = gpart_pack;
                    characters = ["mia", "san", "chef", "akr"];
                    character = new Girl();

                    break
                case "t8_1":
                    //gor and zack

                    part_pack = bpart_pack;
                    characters = ["zack", "xns", "vdk", "smn", "shn", "prms", "prml", "fan", "bdh"];
                    character = new Boy();

                    break
                default:
                    characters=["helm"];
                    character=new Boy();
                    ch_name="badguy";
                    break

            }




        }
        //if

        var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
        character.name=id;
        var effect:MovieClip=new Effect();
        effect.name="effect";
        membermc.addChild(effect);

        var se:String=String(cpu_teams_saved[id].se);
        var seTxt:TextField=seTextfield(se);
        seTxt.x=Math.floor(character.width/2-seTxt.width/2);
        seTxt.y=5;
        var arrow:MovieClip=new ArrowFinger();
        arrow.name="arrow";

        arrow.x=character.width;
        arrow.y=character.height/2;
        arrow.scaleX=-1;
        arrow.visible=false;
        membermc.addChild(character);
        membermc.addChild(seTxt);
        membermc.addChild(arrow);
        addChild(membermc);


    }


    /*
     public function initBoss(info:Object,index:Number):void
     {



     }
     */

    public function updateStatus(type:String):void
    {
        status=type;
    }

    public function updateDamage(effect:String,damage:Number):void
    {
        //DebugTrace.msg("Character.updateDamage id:"+name+"; effect="+ effect+"; status="+status);
        DebugTrace.msg("Character.updateDamage power:"+JSON.stringify(power));
        var current_se:Number=power.se;
        var se:Number=current_se-damage;
        var seText:TextField=membermc.getChildByName("se") as TextField;
        var effectMC:MovieClip=membermc.getChildByName("effect") as MovieClip;
        if(boss_model)
        {
            effect="";
        }
        if(se<=0)
        {
            se=0;

            disabledEffect();

            if(id.indexOf("player")!=-1)
            {
                try
                {
                    timer.stop();
                }
                catch(e:Error)
                {
                    //
                }
            }

            removeSkillAni();
            status="death";
            processMember(status);

            var collapses:Object=flox.getSaveData("collapses");
            var num:Number=collapses[power.name];
            num++;
            collapses[power.name]=num;
            flox.save("collapses",collapses);
        }
        else
        {

            switch(effect)
            {
                case "dizzy":
                    round=1;
                    if(id.indexOf("player")!=-1)
                    {
                        //effectMC.x=-150;
                    }
                    if(status!="dizzy")
                    {

                        status="dizzy";

                        dissytap=new EffectTapView("dizzy_"+id);
                        dissytap.name="dizzy_"+id;


                        if(id.indexOf("player")!=-1)
                        {
                            dissytap.x=-dissytap.width;

                        }
                        addChild(dissytap);

                    }
                    //if
                    if(id.indexOf("player")==-1)
                    {
                        //cpu

                        var index:Number=0;
                        //var time:Number=Math.floor((Math.random()*30))+20;


                        //timer=new Timer(1000,time);
                        //timer.addEventListener(TimerEvent.TIMER_COMPLETE,onHealStatus);
                        //timer.start();



                    }
                    else
                    {
                        //player


                        var battleEvt:BattleEvent=BattleScene.battleEvt;
                        battleEvt.listen=false;
                        battleEvt.doDefinePlayerControler();
                    }
                    //if

                    processMember("dizzy");
                    break
                case "scared":

                    if(status!="scared")
                    {
                        round=1;
                    }
                    processMember("scared");
                    power.speeded="false";
                    removeClickTap();
                    break

            }
            //switch
            if(effect!="")
            {
                status=effect;

            }
            else
            {
                //processMember("");
            }
            //if
        }
        //if

        seText.text=String(se);
        power.se=se;
    }
    private function onHealStatus(e:TimerEvent):void
    {
        //TweenMax.killTweensOf(dissytap);

        removeClickTap();
    }
    public function removeClickTap():void
    {
        status="";

        try
        {
            removeChild(dissytap);
            timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onHealStatus);

        }
        catch(e:Error)
        {
            DebugTrace.msg("Character.removeClickTap Error");
        }
        //try
        if(id.indexOf("player")!=-1)
        {
            //player
            var act:String="ready";
            /*
             var battleEvt:BattleEvent=BattleScene.battleEvt;
             battleEvt.listen=true;
             battleEvt.doDefinePlayerControler();
             */
        }
        else
        {
            //cpu
            act="ready";

        }
        //if
        processMember(act);
    }
    public function updateRound():void
    {
        //DebugTrace.msg("Character.updateRound status:"+status);
        if(id.indexOf("player")!=-1)
        {
            //player
            switch(status)
            {
                case "dizzy":
                    round++;
                    if(round==dizzy_round_max)
                    {
                        removeClickTap();
                    }
                    //if
                    break
                case "scared":
                    round++;
                    if(round==scared_round_max)
                    {
                        status="";
                        processMember("ready");
                    }
                    //if
                    break

            }
            //switch
        }
        else
        {
            //cpu
            switch(status)
            {
                case "dizzy":
                    //timer.stop();
                    round++;

                    if(round>dizzy_round_max)
                    {
                        removeClickTap();
                    }
                    DebugTrace.msg("Character.updateRound round="+round+" ; dizzy_round_max="+dizzy_round_max);
                    break
                case "scared":
                    round++;
                    if(round==scared_round_max)
                    {
                        status="";
                        processMember("ready");
                    }
                    break

            }
            //switch

        }
        //if
        if(power.speeded=="true" && status!="death")
        {
            rage_round++;
            //DebugTrace.msg("Character.updateRound name="+power.name+" ; rage_round_max="+rage_round_max);
            if(rage_round==rage_round_max)
            {
                rage_round=0;
                power.speeded="false";

                var effect:MovieClip=membermc.getChildByName("effect") as MovieClip;
                try
                {
                    effect.gotoAndStop(ready);
                    effect.visible=false;
                }
                catch(e:Error)
                {
                    DebugTrace.msg("Character.updateRound effect RDY Null");
                }
                status="";
                processMember("");
            }
            //if
        }

        try
        {
            removeChild(effShield);
            effShield=null;
        }
        catch(e:Error)
        {
            DebugTrace.msg("Character.updateRound  effShield = NULL");
        }


        power.shielded="false";
        power.target="";
        power.targetlist=new Array();
        power.label="";
        power.skillID="";
        power.jewel="";
        power.speed=0;
        power.power=0;
        power.enemy=0;
        power.area=0;
        //DebugTrace.msg("Character.updateRound power:"+JSON.stringify(power));
    }
    public function startFight():void
    {

        if(status=="dizzy")
        {

            //timer.start();

        }
        //if

    }
    private function seTextfield(str:String):TextField
    {
        var format:TextFormat=new TextFormat();
        format.color=0xFFFFFF;
        format.bold=true;
        format.size=14;
        format.font="SimNeogreyMedium";
        var txt:TextField=new TextField();
        txt.embedFonts=true;
        txt.name="se";
        txt.defaultTextFormat=format;
        txt.autoSize=TextFieldAutoSize.LEFT;
        txt.y=20;
        txt.text=str;

        return txt
    }
    protected function processAction():void
    {
        var act:String="";
        boss_model=checkBossModel();
        if(status!="")
        {
            if(status=="scared" && power.speeded=="true")
            {
                status="";
            }
            //if
            act=status;

            if(boss_model)
            {
                status="";
                act="ready";

            }
        }
        else
        {

            act="ready";

        }
        //if
        //DebugTrace.msg("Character.processAction  act="+ act);


        bossOnArmour(character);

        if(power.se>0){
            processMember(act);
        }


    }
    private var actModel:MovieClip;
    protected function processMember(act:String=null):void
    {
        //play_power=BattleScene.play_power;
        //status="scared";
        DebugTrace.msg("Character.processMember "+name+" ,status="+status+" , act="+ act);
        boss_model=checkBossModel();
        var avatar:Object=flox.getSaveData("avatar");

        var _part:String;
        var effect:MovieClip=membermc.getChildByName("effect") as MovieClip;

        var eleLabel:Array=["A","E","F","W","N","S"];

        character.visible=false;
        character.gotoAndStop(1);
       if(skillAni)
           skillAni.visible=false;


        updatelColorEffect(character,avatar);
        var actlabel:String="";
        actlabel=act;

        if(power.skillID!="")
        {
            //skill ready
            var index:Number=eleLabel.indexOf(act.charAt(0));

            if(index!=-1)
            {
                //skill  with skill animation
                skillAni.visible=true;
                actModel=skillAni;
                if(status=="scared")
                {
                    character.visible=false;
                }
                //if
            }
            else
            {

                if(boss_model)
                {
                    //boss
                    character.visible=true;
                    actModel=character;
                    actlabel=Character[act];
                    if(!actlabel)
                    {
                        //except static action
                        actlabel=act;
                    }
                    //if


                }
                else
                {
                    // not boss ,normal action
                    character.visible=true;
                    actModel=character;
                    actlabel=Character[act];

                }
                //if
            }
            //if

        }
        else
        {
            character.visible=true;
            actModel=character;
            actlabel=Character[act];
        }
        //if

        //try
        //{
        //if
        try
        {
            effect.x=0;
        }
        catch(e:Error)
        {
            DebugTrace.msg("Character.processMember effect Null");
        }

        if(status!=death)
        {
            if(actModel)
               actModel.gotoAndStop(1);
            if(effect)
                effect.gotoAndStop(1);
        }


        if(act=="ready_to_attack")
        {
            actModel.gotoAndStop(Character.ready);
            effect.gotoAndStop(Character.ready);
            //DebugTrace.msg(part_pack.toString())
            for(var j:uint=0;j<part_pack.length;j++)
            {
                if(_part=="ceil")
                {
                    _part="ciel";
                }
                //if
                actModel.body.act[part_pack[j]].play();
            }
            //for

        }
        else
        {

            if(actlabel!=heal)
            {
                //heal(label:HEAL) belong effects file
                if(!actlabel)
                {
                    //except static action
                    actlabel=act;
                }
                //if
                try
                {

                    effect.visible=false;
                }
                catch(e:Error) {
                    DebugTrace.msg("Character.processMember effect Null");
                }

                try
                {

                    DebugTrace.msg("Character.processMember actModel actlabel="+actlabel);

                    actModel.gotoAndStop(actlabel);

                } catch(e:Error) {
                    DebugTrace.msg("Character.processMember actModel Null");
                }

            }
            //if

            if(status=="scared")
            {

                effect.visible=true;
                if(id.indexOf("player")!=-1)
                {
                    effect.x=-150;
                }
                effect.gotoAndStop(scared);
            }
            else if(status=="dizzy")
            {
                effect.visible=true;
                if(id.indexOf("player")!=-1)
                {
                    effect.x=-150;
                }
                effect.gotoAndStop(dizzy);
            }
            else if(status=="rage")
            {
                effect.visible=true;
                if(id.indexOf("player")!=-1)
                {
                    effect.x=-150;
                }
                effect.gotoAndStop(rage);
            }
            else
            {

                if(character.visible && actlabel!="BattleCry" && actlabel!=hit && actlabel!=death)
                {
                    if(id.indexOf("player")!=-1 && actlabel==heal)
                    {
                        effect.x=-150;
                    }
                    //if

                    //effect.gotoAndStop(actlabel);


                }

                //if

            }
            //if
        }
        //if
        DebugTrace.msg("Character.processMember part_pack="+part_pack);
        DebugTrace.msg("Character.processMember boss_model="+boss_model);
        if(!boss_model)
        {
            for(var k:uint=0;k<part_pack.length;k++)
            {

                _part=part_pack[k];
                //DebugTrace.msg("Character.processMember actModel.body.act _part="+_part);
                actModel.body.act[_part].visible=false;

            }
            //for
        }

        //if

        if(ch_name=="ceil")
        {
            ch_name="ciel";
        }
        //if
        //DebugTrace.msg("Character.processMember ch_name="+ch_name);
        //DebugTrace.msg("Character.processMember actlabel="+actlabel);
        //actModel.visible=true;
        if(id.indexOf("player")!=-1)
        {


            if(ch_name=="player")
            {

                if(actModel)
                {
                    actModel.body.act.playera.visible=true;
                    actModel.body.act.playerb.visible=true;
                }
            }
            else
            {
                if(actModel)
                {
                    actModel.body.act[ch_name].visible=true;
                }
            }
            //if


        }
        else
        {
            //cpu
            //DebugTrace.msg("Character.processMember cpu ch_name="+ch_name);
            if(ch_name=="badguy")
            {
                if(actModel)
                {
                    actModel.body.act.helmb.visible=true;
                    actModel.body.act.helma.visible=true;
                }

            }
            else
            {

                if(actModel)
                {

                    if(!boss_model)
                    {
                        try
                        {
                            actModel.body.act[ch_name].visible=true;
                        }
                        catch(e:Error)
                        {
                            DebugTrace.msg("Character.processMember actModel.body.act Null");
                        }
                    }
                    else
                    {
                        //boss
                        if(actlabel==Character.death && ch_name=="rfs"){


                            actlabel="SPArmour";
                            OnArmour=true;
                            memberscom.BattleOver=true;
                            memberscom.ShotDownPower();
                            DataContainer.Armour=OnArmour;
                            actModel.gotoAndStop(actlabel);
                            var _duration:Number=Number((actModel.body.act.totalFrames/24).toFixed(2));
                            var bodyMC:MovieClip=actModel.body;
                            bodyMC.addEventListener(Event.ENTER_FRAME, doArmourComplete);

                        }else{

                            if(ch_name!="rvn")
                                actModel.gotoAndStop(actlabel);
                        }

                        function doArmourComplete(e:Event):void{
                            if(e.target.currentFrame== e.target.totalFrames){
                                e.target.removeEventListener(Event.ENTER_FRAME, doArmourComplete);
                                actModel.gotoAndStop(Character.ready);
                                memberscom.BattleOver=false;
                                bossOnArmour(actModel);
                                processAction();
                            }


                        }

                    }
                }
            }


        }

        var arrow:DisplayObject=membermc.getChildByName("arrow");
        arrow.visible=false;

        if(!boss_model)
        {
            if(actModel && power.skillID!="s0" && power.skillID!="s1")
            {
                updatelColorEffect(actModel,avatar);
            }
            if(actlabel=="S_RDY")
            {
                updatelColorEffect(actModel,avatar);
            }


        }

        switch(actlabel)
        {
            case knockback:
                actComplete("CompleteKnockback");
                break
            case charge:
                //BootComplete
                actComplete("BootComplete");
                break
        }
        //switch

        /*catch(e:Error)
         {
         DebugTrace.msg("Character.processMember Error");
         }
         //try*/
        if(ch_name=="rfs")
            bossOnArmour(character);

    }
    private function updatelColorEffect(actModel:MovieClip,avatar:Object):void
    {
        DebugTrace.msg("Character.updatelColorEffect "+name);

        if(name.indexOf("player")!=-1)
        {

            //var skinCT:ColorTransform = actModel.body.act.skin.transform.colorTransform;
            //skinCT.color = avatar.skincolor;
            //actModel.body.act.skin.transform.colorTransform = skinCT;

            //var skinColor:Color = new Color();
            //skinColor.setTint(avatar.skincolor, 0.5);
            //actModel.body.act.skin.transform.colorTransform = skinColor;

            //TweenMax.to(actModel.body.act.skin,0.1, {onComplete:onChangedColor,colorTransform:{tint:avatar.skincolor, tintAmount:0.5}});
            //var acc_color:Number=0x1397C0;
            //TweenMax.to(actModel.body.act.acc,0.2, {colorTransform:{tint:acc_color, tintAmount:0.5}});

            //var accColor:Color = new Color();
            //accColor.setTint(acc_color, 0.5);
            //actModel.body.act.acc.transform.colorTransform = accColor;


            //var accCT:ColorTransform = actModel.body.act.acc.transform.colorTransform;
            //accCT.color = 0x1397C0;
            //actModel.body.act.acc.transform.colorTransform = accCT;

            function onChangedColor():void{
                TweenMax.killTweensOf(onChangedColor);
            }

        }
        else
        {


            //trace("boss_model =",boss_model)

            if(!boss_model)
            {

                var team:String=power.id.split("_")[0];
                var colorPkg:Object=Config.teamColors[team];

                if(colorPkg.skin)
                    TweenMax.to(actModel.body.act.skin,0, {colorTransform:{tint:colorPkg.skiin, tintAmount:colorPkg.skin_tint},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.skin]});
                if(ch_name=="badguy")
                {

                    var helmACT:ColorTransform = actModel.body.act.helma.transform.colorTransform;

                    if(colorPkg.member[0])
                        TweenMax.to(actModel.body.act.helma,0, {colorTransform:{tint:colorPkg.member[0], tintAmount:colorPkg.member_tint[0]},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.helma]});
                    if(colorPkg.member[1])
                        TweenMax.to(actModel.body.act.helmb,0, {colorTransform:{tint:colorPkg.member[1], tintAmount:colorPkg.member_tint[1]},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.helmb]});
                }

                if(colorPkg.acc)
                    TweenMax.to(actModel.body.act.acc,0, {colorTransform:{tint:colorPkg.acc, tintAmount:colorPkg.acc_tint},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.acc]});
                if(colorPkg.body)
                    TweenMax.to(actModel.body.act.body,0, {colorTransform:{tint:colorPkg.body, tintAmount:colorPkg.body_tint},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.body]});


            }
            if(power.id=="t3_0"){
                //shn Tint Hair color
                TweenMax.to(actModel.body.act.shn,0, {colorTransform:{tint:0x666666, tintAmount:0.9},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.shn]});
            }
            if(power.name=="lenus"){
                //lenus Tint Hair color
                TweenMax.to(actModel.body.act.lenus,0, {colorTransform:{tint:0xCC9900, tintAmount:0.55},onComplete:onColorTFComplete,onCompleteParams:[actModel.body.act.shn]});
            }
        }
        //if

    }
    private function onColorTFComplete(target):void
    {
        //TweenMax.killChildTweensOf(onColorTFComplete);
        TweenMax.killTweensOf(onColorTFComplete);
    }
//    private function onRageComplete(e:Event):void
//    {
//        if(e.target.currentFrame==e.target.totalFrames)
//        {
//            DebugTrace.msg("Character.onRageComplete");
//            e.target.removeEventListener(Event.ENTER_FRAME,onRageComplete);
//            processMember("stand");
//
//        }
//        //if
//    }
    protected function enabledMemberHeal():void
    {
        DebugTrace.msg("Character.enabledMemberHeal");
        ett=new HealTargetTap();
        ett.buttonMode=true;
        ett.mouseChildren=false;
        ett.name=id;
        ett.alpha=0;
        if(id.indexOf("player")!=-1)
        {
            ett.x=-ett.width;
        }
        //if
        ett.addEventListener(MouseEvent.CLICK,doClickHealTarget);
        ett.addEventListener(MouseEvent.MOUSE_OVER,onOverPlayer);
        ett.addEventListener(MouseEvent.MOUSE_OUT,onOutPlayer);
        addChild(ett);

        showHealTint();

    }
    protected function showHealTint():void
    {

        if(character.visible)
        {

            heal_tint=character;
        }
        else
        {
            heal_tint=skillAni;
        }

        TweenMax.to(this,0.25,{colorTransform:{tint:0x3FCED6, tintAmount:0.9}});
        TweenMax.to(this,0.25,{delay:0.25,removeTint:true,onComplete:onCompleteTint});
        function onCompleteTint():void
        {
            TweenMax.killTweensOf(this);
            showHealTint();
        }

    }
    protected function removeMemberHeal():void
    {

        arrow.visible=false;

        if(ett)
        {
            ett.removeEventListener(MouseEvent.CLICK,doClickHealTarget);
            ett.removeEventListener(MouseEvent.MOUSE_OVER,onOverPlayer);
            ett.removeEventListener(MouseEvent.MOUSE_OUT,onOutPlayer);
            removeChild(ett);
            ett=null;

        }
        /*
         try
         {
         removeChild(ett);
         ett=null;
         }
         catch(e:Error)
         {
         DebugTrace.msg("Character.removeMemberHeal NULL");
         }
         */

    }
    private function doClickHealTarget(e:MouseEvent):void
    {
        DebugTrace.msg("Character.doClickHealTarget target:"+e.target.name);

        var currentPower:Object=DataContainer.currentPower;

        DebugTrace.msg("Character.doClickHealTarget currentPower:"+JSON.stringify(currentPower));

        var battleEvt:BattleEvent=BattleScene.battleEvt;
        if(currentPower.skillID=="n2")
        {
            battleEvt.id=null;
            battleEvt.healarea=heal_target;
        }
        else
        {
            battleEvt.id=e.target.name;

        }
        //if
        battleEvt.usedHealHandle();

        command.playSound("BattleConfirm");

    }

    protected function enabledAreaMemberHeal():void
    {
        arrow.visible=true;
    }
    protected function disabledAreaMemberHeal():void
    {
        arrow.visible=false;
    }
    protected function actComplete(from:String):void
    {
        _from=from;
        DebugTrace.msg("Character.actComplete from:"+_from);

        var _duration:Number=Number((character.body.act.totalFrames/24).toFixed(2));
        TweenMax.to( character.body.act,_duration,{frame:character.body.act.totalFrames,onComplete:onActComplete})

    }

    protected function onActComplete():void
    {


        DebugTrace.msg("Character.onActComplete _from="+_from +", name="+name);

        TweenMax.killTweensOf(onActComplete);

        switch(_from)
        {
            case "Assist":
            case "CombineSkill":
            case "Mind Control":
                processAction();
                break;
            case "Rage":
                status="rage";
                if(power.se>0) {
                    processMember(status);
                }
                break;
            case "CompleteKnockback":
            case "BootComplete":
                DebugTrace.msg("Character.onActComplete status="+status);
                if(power.se>0 && status!="death")
                {
                    if(status!="" && status!="heal")
                    {

                        processMember(status);
                    }
                    else
                    {
                        //normal status
                        if(power.target!="")
                        {
                            var act:String=power.label;
                            DebugTrace.msg("Character.onActComplete act="+act);
                            if(!boss_model && act!=null)
                            {
                                act=act.charAt(0)+"_RDY";
                                //setupSkillAni();
                                reasetSkillAni();
                            }
                            else
                            {
                                if(status=="")
                                {
                                    processMember(ready);
                                }
                                else
                                {
                                    processMember(status);
                                }
                            }
                            //if
                        }
                        else
                        {

                            processMember(ready);
                        }
                        //if
                    }
                    //if
                }
                break
        }
        //switch

    }
    private var ele:String;
    private var skillSWf:String;
    private var sp:String;
    //private var gender:String="";
    private var _gender:String="";
    private function initGender():void
    {

        if(ch_name=="player")
        {
            //player
            var acatar:Object=flox.getSaveData("avatar");
            part_pack=bpart_pack;
            gender="B";
            _gender="Boy";

        }
        else
        {
            //other character
            if(bpart_pack.indexOf(ch_name)!=-1 || ch_name=="badguy")
            {
                part_pack=bpart_pack;
                gender="B";
                _gender="Boy";
            }

            else
            {
                part_pack=gpart_pack;
                gender="G";
                _gender="Girl";
            }
            //if
        }
        //if


    }
    public function setupSkillAni():void
    {

        if(!boss_model)
        {
            removeSkillAni();
            ele=power.ele.charAt(0);
            sp="";
            if(power.label.indexOf("SP")!=-1)
            {
                sp="_SP";
            }
            //if
            DebugTrace.msg("Character.setupSkillAni ch_name="+ch_name);
            initGender();
            if(ele!="s")
            {
                skillSWf=gender+ele+sp;
            }
            else
            {
                //speciale super skill
                skillSWf=gender+power.skillID;
            }
            if(ch_name=="xns" && power.skillID=="s0"){
                skillSWf=gender+power.skillID+"SP";
            }

            DebugTrace.msg("Character.setupSkillAni LoaderQueue ID="+power.id+"_skillAni");
            var loaderReq:LoaderRequest=new LoaderRequest();
            loaderReq.setLoaderQueue(power.id+"_skillAni","../swf/skills/"+skillSWf+".swf",membermc,onSkillComplete);
        }


    }
    private function onSkillComplete(e:LoaderEvent):void
    {
        DebugTrace.msg("Character.onSkillComplete sp="+sp+" ; skillSWf="+skillSWf);
        var queueID:String=power.id+"_skillAni";
        var loaderQueue:LoaderMax=ViewsContainer.loaderQueue[queueID];
        var content:ContentDisplay=loaderQueue.getContent(queueID);
        var swfloader:SWFLoader = loaderQueue.getLoader(queueID);
        skillAni=swfloader.getSWFChild(_gender) as MovieClip;

        if(id.indexOf("player")!=-1)
        {
            content.scaleX=-1;
        }
        if(ele!=""){
            ele= ele.toUpperCase()+"_";
        }
        if(power.skillID=="s0"){
            ele="S_";
        }

        skillAni.gotoAndStop(ele+"RDY");

        processMember(ele+"RDY");

    }
    private function reasetSkillAni():void
    {

        if(ele!=""){
            ele= ele.charAt(0).toUpperCase()+"_";
        }
        skillAni.gotoAndStop(ele+"RDY");
        processMember(ele+"RDY");

    }
    public function setupVictoryDace():void
    {
        if(power.se>0)
        {

            disabledEffect();
            removeSkillAni();
            initGender();

            DebugTrace.msg("Character.setupVictoryDace name="+name+"_dance");


            skillSWf=gender+"_VicDance";

            var loaderReq:LoaderRequest=new LoaderRequest();
            loaderReq.setLoaderQueue(name+"_dance","../swf/skills/"+skillSWf+".swf",membermc,onVicDanceComplete);
        }
    }
    private function onVicDanceComplete(e:LoaderEvent):void
    {
        //DebugTrace.msg("Character.onVicDanceComplete name="+name+"_dance"+" ; _gender="+_gender);
        var queueID:String=name+"_dance";
        var loaderQueue:LoaderMax=ViewsContainer.loaderQueue[queueID];
        var content:ContentDisplay=loaderQueue.getContent(queueID);
        var swfloader:SWFLoader = loaderQueue.getLoader(queueID);
        skillAni=swfloader.getSWFChild(_gender) as MovieClip;

        if(id.indexOf("player")!=-1)
        {
            content.scaleX=-1;
        }
        //character.visible=false;
        membermc.removeChild(character);
        var seTxt:TextField=membermc.getChildByName("se") as TextField;
        membermc.removeChild(seTxt);

        //skillAni.gotoAndStop(ele.toUpperCase()+"_RDY");
        //var ch_name:String=power.name;
        DebugTrace.msg("Character.onVicDanceComplet ch_name="+ch_name);
        for(var i:uint=0;i<part_pack.length;i++)
        {
            //DebugTrace.msg("Character.onVicDanceComplet part_pack["+i+"]="+part_pack[i]);
            var _part:String=part_pack[i];
            if(_part=="ceil")
            {
                _part="ciel";
            }
            //if
            try
            {
                skillAni.body.act[_part].visible=false;
            }
            catch(e:Error)
            {
                DebugTrace.msg("Character.onVicDanceComplet slillAni Null");
            }

        }
        //for
        if(ch_name=="badguy")
        {
            skillAni.body.act.helmb.visible=true;
            skillAni.body.act.helma.visible=true;
        }
        else if(ch_name=="player")
        {
            skillAni.body.act.playera.visible=true;
            skillAni.body.act.playerb.visible=true;

        }
        else
        {

            skillAni.body.act[ch_name].visible=true;


        }
        //if
        var avatar:Object=flox.getSaveData("avatar");
        updatelColorEffect(skillAni,avatar);


        //skillAni.body.addEventListener(Event.ENTER_FRAME,doCheckDancing);

    }
    private function doCheckDancing(e:Event):void
    {
        if(e.target.currentFrame==e.target.totalFrames)
        {
            e.target.removeEventListener(Event.ENTER_FRAME,doCheckDancing);

            var queueID:String=name+"_dance";
            var loaderQueue:LoaderMax=ViewsContainer.loaderQueue[queueID];
            loaderQueue.getLoader(queueID).unload();

            var battlealert:MovieClip=ViewsContainer.BattleAlert;
            TweenMax.to(battlealert,1,{alpha:1,delay:5});
        }
        //if

    }
    private function setupAllAniLayer(mc:MovieClip,layeries:Array):void
    {
        skillAni.body.gotoAndStop(1);
        skillAni.body.act.gotoAndStop(1);
        for(var i:uint=0;i<layeries.length;i++)
        {


            skillAni.body.act[layeries[i]].gotoAndStop(1);

        }
        //for
        skillAni.body.act.skin.gotoAndStop(1);
        skillAni.body.act.acc.gotoAndStop(1);
        skillAni.body.act.body.gotoAndStop(1);
    }
    public function removeSkillAni():void
    {
        DebugTrace.msg("Character.removeSkillAni :"+power.id+"_skillAni");
        if(power.shielded=="true")
        {
            effShield.visible=true;
        }

        var boss:Array=Config.bossModels;
        if(boss.indexOf(ch_name)==-1){
            var loaderQueue:LoaderMax=ViewsContainer.loaderQueue[power.id+"_skillAni"];
            if(loaderQueue){
                loaderQueue.getLoader(power.id+"_skillAni").unload();
                skillAni=null;
            }

        }

    }
    protected function hitHandle():void
    {
        DebugTrace.msg("Character.hitHandle");


        //TweenMax.delayedCall(1,onHitComplete);

        //setFrame(1);
        TweenMax.to(character.body,0,{frame:2,onComplete:onHitComplete});

    }
    private function onHitComplete():void
    {
        //TweenMax.killDelayedCallsTo(onHitComplete);

        //DebugTrace.msg("Character.onHitComplete");
        onSitHitFrame(2);
        //TweenMax.killChildTweensOf(character.body);
        TweenMax.to(character.body,0,{frame:1,onComplete:onSitHitFrame,onCompleteParams:[1]});


    }
    private function  onSitHitFrame(f:Number):void
    {
        //character.body.gotoAndStop(f);
        TweenMax.killChildTweensOf(character.body);
        var _act:MovieClip=character.body.act;
        /*for(var i:uint=0;i<part_pack.length;i++)
         {
         _act[part_pack[i]].gotoAndStop(f);
         }*/
        DebugTrace.msg("Character.onHitComplete ch_name:"+ch_name);
        var ch_part:String=ch_name;
        if(ch_part=="badguy")
        {
            _act.helmb.gotoAndPlay(f);
            _act.helma.gotoAndPlay(f);
        }
        else if(ch_part=="player")
        {
            _act.playerb.gotoAndPlay(f);
            _act.playera.gotoAndPlay(f);

        }
        else
        {
            if(!boss_model)
            {
                _act[ch_part].gotoAndPlay(f);
            }
            else
                _act.gotoAndPlay(f);

            //if
        }
        //if
        if(!boss_model)
        {
            _act.skin.gotoAndPlay(f);
            _act.acc.gotoAndPlay(f);
            _act.body.gotoAndPlay(f);
        }
        //if
    }
    private function disabledEffect():void
    {
        //remove dizzy shiled effect
        var effect:MovieClip=membermc.getChildByName("effect") as MovieClip;
        removeClickTap();
        if(effect)
        {
            membermc.removeChild(effect);
        }
        try
        {
            removeChild(effShield);
        }
        catch(e:Error)
        {
            DebugTrace.msg("Character.disabledEffect effShield Nil");
        }
        //try


    }
    private function checkBossModel():Boolean
    {
        var b:Boolean=false;
        var boss_index:Number=Config.bossModels.indexOf(ch_name);
        if(boss_index!=-1)
        {
            //boss model
            b=true
        }

        return b
    }

    private function bossOnArmour(target:MovieClip):void{

        if(OnArmour && power.id=="t12_0"){
            //TweenMax.to( target.body.act , 0.5, {colorTransform:{tint:0x000000, tintAmount:0.5},onComplete:onCompleteArmour,onCompleteParams:[target.body.act]});
            //var colorTransfrom:ColorTransform=target.body.act.transform.colorTransform;
            // colorTransfrom.color=0x000000;

            var color:Color=new Color();
            color.setTint(0x000000,0.5);
            try{
                target.body.act.transform.colorTransform = color;
            }catch (e:Error){
                DebugTrace.msg("Character.bossOnArmour tint null");
            }

        }
    }
    private function onCompleteArmour(target:MovieClip):void{
        //TweenMax.killTweensOf(target);
    }

    public function stopActionHandle():void{

        try{
            character.body.act.removeEventListener(Event.ENTER_FRAME,onActComplete);
            character.body.gotoAndStop(1);
        }catch (e:Error){}


    }

}
}