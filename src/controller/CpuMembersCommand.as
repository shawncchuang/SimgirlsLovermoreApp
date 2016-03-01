package controller
{


import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;
import data.DataContainer;

import events.BattleEvent;

import flash.utils.Dictionary;

import model.BattleData;
import model.SaveGame;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.BattleScene;
import views.Member;
public class CpuMembersCommand implements CpuMembersInterface
{

    //private var teamsno:uint=14;
    // maxsium members in a team
    private var mem_perteam:uint=8;
    private var flox:FloxInterface=new FloxCommand();
    //main team  properties;
    private var main_team:Array=new Array();
    private var backup_team:Array=new Array();
    private var team:Array;
    private static var cputeam:Array=new Array();
    //private var cpu_power:Array;
    //private var memberscom:MembersInterface=new MemebersCommand();
    //private var combinTeam:String="t0";
    private var cpuIndex:Number=0;
    private var gems_req:Number=0;
    //Attack
    //private var atkPers:Array=[15,15,40,75,50];
    //private var atkPers:Array=[15,15,40,75,30];
    private var atkPers:Array=[10,15,30,60,30];
    private var atklist:Array=["f3,a3,w3,e3","f2,e2","f1,a1,w1,e1","f0,a1,w1,e0","a0,w0"];
    //Healing
    //SE current lv_gems requirement
    private var se_lv:String="0";
    private var healgems:Object={"0_1":0,"0_2":0,"0_3":0,"0_5":3,
        "1_1":0,"1_2":20,"1_3":12,"1_5":4,
        "2_1":10,"2_2":25,"2_3":8,"2_5":2,
        "3_1":30,"3_2":25,"3_3":8,"3_5":1};
    private var bossName:Object=new Object();
    private var cpu:String="";
    private var command:MainInterface=new MainCommand();
    public static function set cputeamMember(members:Array):void
    {
        //cpu member
        cputeam=members;
    }
    public static function get cputeamMember():Array
    {

        return cputeam;
    }
    public function nextRound():void
    {
        gems_req=0;

    }
    public  function setupCPU():void
    {


        var cpu_teams:Object=flox.getSaveData("cpu_teams");
        var elements:Array=Config.elements;
        //setup  se,id,element
        var bosses:Array=new Array();
        var bosseNames:Object=Config.bossName;

        for(var _name:String in bosseNames){
            bosses.push(_name);
        }

        for(var i:uint=0;i<bosses.length;i++)
        {

            for(var j:uint=0;j<mem_perteam;j++)
            {
                var id:String="t"+i+"_"+j;
                var cpu_team:Object=cpu_teams[id];
                if(!cpu_team){
                    var playerObj:Object=Config.PlayerAttributes();
                    cpu_team=playerObj.cpu_teams[id];
                }

                var member:Object=new Object();
                member.id=id;
                member.from="cpu";
                member.target="";
                member.se=cpu_team.se;
                member.seMax=cpu_team.seMax;
                member.ele=elements[uint(Math.random()*elements.length)];
                member.skillID="";
                cpu_teams[id]=member;

            }
            //for

        }
        //for
        var savegame:SaveGame=FloxCommand.savegame;
        savegame.cpu_teams=cpu_teams;
        FloxCommand.savegame=savegame;

    }
    public function setupFinalBoss():void{

        var teams:Object=flox.getSaveData("cpu_teams");
        for(var j:uint=0;j<mem_perteam;j++){

            var se:Number=8000;
            if(j>0){
                se=0;
            }
            var id:String="t12_"+j;
            var member:Object=new Object();
            member.id=id;
            member.from="cpu";
            member.target="";
            member.se=se;
            member.seMax=se;
            member.ele="";
            member.skillID="";
            teams[id]=member;
        }

        flox.save("cpu_teams",teams);
    }
    public  function setupBattleTeam():void
    {
        var membersEffect:Object=DataContainer.MembersEffect;
        var love:Number=flox.getSaveData("love").player;
        //DebugTrace.msg("CpuMembersCommand. setupBattleTeam month:"+month+", date:"+date);
        //var scene:String=DataContainer.BatttleScene;(scene==Arena)
        var teams:Object=flox.getSaveData("cpu_teams");
        var date:String=flox.getSaveData("date").split(".")[1];
        var month:String=flox.getSaveData("date").split(".")[2];
        var dateStr:String=month+"_"+date;
        var schedule:Dictionary=Config.battleSchedule();
        var battle_schedule:Array=schedule[dateStr];


        bossName=Config.bossName;
        var battleType:String=DataContainer.battleType;
        //DebugTrace.msg("CpuMembersCommand. battleType :"+battleType);
        var se:Number=0;

        switch(battleType){
            case "schedule":
                var batteData:BattleData=new BattleData();
                cpuIndex=batteData.checkBattleSchedule("Battle","");

                //---------------------fake CPU team
                //cpuIndex=Math.floor(Math.random()*10);
                cpuIndex=Number(battle_schedule[0].split("|")[1]);

                if(cpuIndex==9)
                    cpuIndex=10;
                break;
            case "final_battle":
                cpuIndex=12;
                break;
            case "story_battle_s023":
                cpuIndex=10;
                break;
            case "story_battle_s033":
                cpuIndex=15;
                break;
            case "story_battle_s036":
                cpuIndex=14;
                break;
            case "story_battle_s046":
                cpuIndex=13;
                break;
            case "practice":
            case "random_battle":
                var ability:Object=command.criminalAbility();
                cpuIndex=11;

                for(var j:uint=0;j<mem_perteam;j++){

                    var id:String="t"+cpuIndex+"_"+j;

                    if(battleType=="random_battle"){
                        if(id=="t11_0"){
                            //leader
                            se=ability.se;
                        }else{
                            se=ability.se;
                        }
                    }else{
                        //practice
                        if(id=="t9_0") {
                            //leader
                            se = Math.floor(love * 0.7);
                        }else{
                            se=Math.floor(love*0.4);
                        }

                    }

                    teams[id].se=se;
                    teams[id].seMax=se;

                }
                DebugTrace.msg("CpuMembersCommand. setupBattleTeam teams:"+JSON.stringify(teams));
                flox.save("cpu_teams",teams);

                break;
            default:
                var battleCode:String=DataContainer.battleCode;
                cpuIndex=flox.getSyetemData("story_battle")[battleCode];
                break
        }

        DebugTrace.msg("CpuMembersCommand. setupBattleTeam cpuIndex:"+cpuIndex);
        DataContainer.setCputID=cpuIndex;

        team=new Array();

        for(var t:uint=0;t<mem_perteam;t++)
        {
            id="t"+cpuIndex+"_"+t;
            if(teams[id].se>0)
            {
                teams[id].id=id;
                teams[id].combat=0;
                var boss_index:Number=Config.bossModels.indexOf(bossName[id]);
                teams[id].ch_name=bossName[id];

                team.push(teams[id]);
            }
            //if
        }
        //for
        main_team.push(team[0]);

        if(main_team[0].ch_name=="xns")
        {
            team[1].ch_name="san";
            main_team.push(team[1]);

        }

        if(main_team[0].ch_name=="gor" && battleType!="story_battle_s033")
        {
            team[1].ch_name="zack";
            main_team.push(team[1]);
        }

        var _backup_team:Array=team.splice(main_team.length);
        backup_team=_backup_team;
        //backup_team=team.concat(_backup_team);
        var mamerMax:Number=5-main_team.length;

        for(var i:uint=0;i<mamerMax;i++)
        {
            var index:Number=Math.floor(Math.random()*backup_team.length);
            main_team.push(backup_team[index]);
            var __backup_team:Array=backup_team.splice(index);
            __backup_team.shift();
            var new_backup_team:Array=backup_team.concat(__backup_team);
            backup_team=new_backup_team;
        }
        //for
        var _main_team:Array=new Array();
        for(var m:uint=0;m<5;m++)
        {
            index=Math.floor(Math.random()*main_team.length);
            if(main_team[index])
                _main_team.push(main_team[index]);
            var main_team1:Array=main_team.splice(index);
            main_team1.shift();
            var new_main_team:Array=main_team.concat(main_team1);
            main_team=new_main_team;
        }
        //for
        main_team=_main_team;

        //main team's sel from savegame
        DebugTrace.msg("CpuMembersCommand.setupBattleTeam main_team:"+main_team);
        for(var k:uint=0;k<main_team.length;k++)
        {
            DebugTrace.msg("CpuMembersCommand.setupBattleTeam main_team:"+JSON.stringify(main_team[k]));
            membersEffect[main_team[k].id]="";
        }
        //for
        DataContainer.MembersEffect=membersEffect;
    }
    public function commanderSkill():void
    {

        var cupsys:Object=flox.getSyetemData("cpu_teams");
        var comsItems:Object=flox.getSyetemData("commander_items");

        for(var i:uint=0;i<cputeam.length;i++)
        {
            var member:Member=cputeam[i];
            member.getStatus();
            var id:String=member.name;
            var skillID:String="";
            if(id.split("_")[1]=="0" && member.power.se>0 && member.status!="dizzy")
            {
                //commander
                var formaiton:Boolean=commanderChangeFromation();
                DebugTrace.msg("CpuMembersCommand.commanderSkill formaiton="+formaiton);
                var skill:Object=new Object();
                if(!formaiton)
                {
                    var batttlecry:Boolean=commanderBattleCry();
                    //batttlecry=true;
                    DebugTrace.msg("CpuMembersCommand.commanderSkill batttlecry="+batttlecry);
                    if(batttlecry)
                    {
                        //use  battle cry
                        skill=comsItems.com1;
                        skill.skillID="com1";
                    }
                    //if
                }
                else
                {
                    //use change formatoin

                    skill=comsItems.com0;
                    skill.skillID="com0";

                }
                //if
                formaiton=false;
                batttlecry=false;
                var itemid:String="";
                if(formaiton || batttlecry)
                {
                    var power:Object=member.power;
                    for(var j:String in skill)
                    {
                        power[j]=skill[j];
                    }
                    //for
                    member.updatePower(power);
                    if(formaiton)
                    {
                        itemid="com0";
                    }
                    //if
                    if(batttlecry)
                    {
                        itemid="com1";
                    }
                    //if

                    DebugTrace.msg("CpuMembersCommand.commanderSkill member:"+member.name);
                    //DebugTrace.msg("CpuMembersCommand.commanderSkill power:"+JSON.stringify(power));
                }
                //if
                var battleEvt:BattleEvent=BattleScene.battleEvt;
                //battleEvt.itemid=itemid;
                battleEvt.itemid="";
                battleEvt.commander=member;
                battleEvt.onCPUCommaderItems();
                break
            }
            //if

        }
        //for

    }
    private var sIndex:Number=0;
    private var skillIDs:Array;
    private var match:Boolean=false;
    private var atk_index:Number=0;

    private var member_id:String;
    private function getMemberSkills():void
    {
        skillIDs=new Array();
        member_id=cputeam[atk_index].name;

        var skillID:String=cupsys[member_id].skill;
        if(skillID.indexOf(",")!=-1)
        {
            skillIDs=skillID.split(",");
        }
        else
        {
            skillIDs.push(skillID);
        }
        //if
    }
    private var  atkskills:Array;
    private  function checkSkillChance():void
    {
        //skill chance

        atk_index=0;
        getMemberSkills();
        //DebugTrace.msg("CpuMembersCommand.checkSkillChance atk_index="+atk_index+" ; gems_req="+gems_req+" ; sIndex="+sIndex);
        var atkper:Number=atkPers[sIndex];
        var ran:Number=Math.floor(Math.random()*100);
        //DebugTrace.msg("CpuMembersCommand.checkSkillChance ran="+ran+" <-> atkper="+atkper);

        var squskill:Array=new Array();
        atkskills=atklist[sIndex].split(",");
        var battledata:BattleData=new BattleData();
        atkskills=battledata.shuffleHandle(atkskills);

        //DebugTrace.msg("CpuMembersCommand.checkSkillChance skillIDs="+skillIDs);
        //DebugTrace.msg("CpuMembersCommand.checkSkillChance atkskills="+atkskills);

        if(ran<atkper)
        {
            //check match
            checkSkillMatch();
        }
        else
        {
            //no chance , check next skill
            //DebugTrace.msg("CpuMembersCommand.checkSkillChance : No Chance --> Next Skill ; sIndex="+sIndex);

            if(sIndex==atkPers.length-1)
            {
                //no any skills chance
                //DebugTrace.msg("CpuMembersCommand.checkSkillChance : No Any Chance Check around gems_req="+gems_req);
                gems_req++;
            }
            //if

            checkNextSkillChance();

        }
        //if

    }
    private function checkSkillMatch():void
    {
        //member match what skill it's
        //DebugTrace.msg("CpuMembersCommand.checkSkillMatch atk_index="+atk_index+" ; gems_req="+gems_req+" ; sIndex="+sIndex);
        match=false;
        var skillID:String="";
        var member:Member=getMember(member_id);
        member.getStatus();
        //DebugTrace.msg("CpuMembersCommand.checkSkillMatch: create cputeam["+member_id+"].power ="+JSON.stringify(member.power));
        //DebugTrace.msg("CpuMembersCommand.checkSkillMatch: status:"+member.status);
        var battledata:BattleData=new BattleData();
        atkskills=battledata.shuffleHandle(atkskills);
        //DebugTrace.msg("CpuMembersCommand.checkSkillMatch: atkskills:"+atkskills);
        for(var i:uint=0;i<atkskills.length;i++)
        {
            //check each atkskills
            skillID=atkskills[i];
            if(skillIDs.indexOf(skillID)!=-1)
            {
                //skill match
                //DebugTrace.msg("CpuMembersCommand.checkSkillMatch:  skill match  skillID="+skillID);
                var current_req:Number=Number(skillsSys[skillID].jewel.split("|")[0]);
                var _gems_req:Number=gems_req+current_req;

                if(_gems_req<7 && member.power.skillID=="" && member.power.se>0 && member.status!="dizzy")
                {

                    //gems are enough && not set up skill yet --> set up current skill , check next skill
                    match=true;
                    gems_req+=current_req;


                    createPower(skillID,member);

                    checkNextSkillChance();
                    break
                }
                //if
            }
            //if
        }
        //for
        //DebugTrace.msg("CpuMembersCommand.checkSkillMatch: match="+match);
        if(!match)
        {
            //current member didn't match skill	--> check next member;

            atk_index++;
            if(atk_index<cputeam.length)
            {
                //check next member
                getMemberSkills();
                checkSkillMatch();
            }
            else
            {
                //check all members already  -->check next skill

                checkNextSkillChance();
            }
            //if
        }
        //if


    }
    private function checkNextSkillChance():void
    {
        sIndex++;
        //DebugTrace.msg("CpuMembersCommand.checkNextSkillChance: gems_req="+gems_req);
        if(sIndex>atklist.length-1)
        {
            sIndex=0;
        }
        //if
        if(gems_req<7)
        {
            checkSkillChance();
        }
        //if
    }
    private var  cupsys:Object;
    private var skillsSys:Object;
    private function shuffleCpuTeam():void
    {
        //random cpu team
        var battledata:BattleData=new BattleData();
        var shuffle_cputeam:Array=new Array();
        var _cputeam:Array=battledata.shuffleHandle(cputeam);

        for(var i:uint=0;i<_cputeam.length;i++)
        {
            if(_cputeam[i].name.split("_")[1]=="0")
            {
                shuffle_cputeam.push(_cputeam[i]);
                _cputeam.splice(i,1)[0];
                break
            }
            //if
        }
        //for
        for(var j:uint=0;j<_cputeam.length;j++)
        {
            shuffle_cputeam.push(_cputeam[j])
        }
        //for
        cputeamMember=shuffle_cputeam;
        MemebersCommand.cpuTeam=shuffle_cputeam;

    }
    public function setupSkillCard():void
    {
        sIndex=0;
        atk_index=0;
        cupsys=flox.getSyetemData("cpu_teams");
        //var teams:Object=flox.getSaveData("cpu_teams");
        skillsSys=flox.getSyetemData("skillsys");

        shuffleCpuTeam();
        checkSkillChance();

        DebugTrace.msg("CpuMembersCommand.setupSkillCard match="+match);


    }
    private function createPower(skillID:String,member:Member):void
    {
        var power:Object=member.power;
        var skillsSys:Object=flox.getSyetemData("skillsys");
        var battledata:BattleData=new BattleData();
        var skill:Object=skillsSys[skillID];
        power.skillID=skillID;
        if(skillID!="")
        {
            for(var j:String in skill)
            {
                power[j]=skill[j];
            }
            //for

            //var skillpower:Object=battledata.skillCard(member,skill);
            var skillPower:Number=battledata.skillCard(member,skill.power);
            /*	for(var m:String in skillpower)
             {
             power[m]=skillpower[m];
             }
             //for
             */
            var boss_index:Number=Config.bossModels.indexOf(power.ch_name);
            var update_power:Boolean=false;
            var skillLv:Number=Number(power.skillID.charAt(1));

            if(power.id=="t7_0" || power.id=="t4_0")
            {
                //xns:combo skill ,mia:mind control

                if(skillLv==3)
                {

                    if(power.id=="t4_0")
                    {
                        var sID:String="s1";
                    }
                    else
                    {
                        sID="s0";
                        power.type=skillsSys[sID].type;
                    }

                    power.skillID=sID;
                    power.ele=skillsSys[sID].ele;
                    power.effect=skillsSys[sID].effect;
                    power.enemy=skillsSys[sID].enemy;
                    power.jewel=skillsSys[sID].jewel;
                    power.area=skillsSys[sID].area;
                    power.label=skillsSys[sID].label;

                }
                //if
            }
            //if
            if(boss_index!=-1)
            {
                //boss
                var bossSkill:Object=Config.bossSkill;
                var boss:String=power.ch_name;
                var jewel:Number=Number(power.jewel.split("|")[0]);
                var level:String="";
                switch(boss)
                {
                    case "gor":
                        if(jewel<=2)
                        {
                            level="lv1";
                        }
                        else
                        {
                            level="lv2";
                        }
                        break;
                    case "fat":
                        level="lv1";
                        break;
                    case "tgr":

                        if(jewel<=2)
                        {
                            level="lv1";
                        }else if(jewel==3){
                            level="lv2";
                        }else
                        {
                            level="lv3";
                        }
                        break;
                    case "rfs":
                        if(jewel<=2)
                        {
                            level="lv1";
                        }else if(jewel==3)
                        {
                            level="lv2";
                        }else
                        {
                            level="lv3";
                        }
                        break;
                    case "rvn":
                        if(jewel<=2)
                        {
                            level="lv1";
                        }else
                        {
                            level="lv2";
                        }

                        break;
                    case "nhk":
                        if(jewel<=2)
                        {
                            level="lv1";
                        }else if(jewel==3) {
                            level = "lv2";
                        }else
                        {
                            level="lv3";
                        }
                        break
                }

                power.skillID=bossSkill[power.ch_name][level].skillID;
                power.label=bossSkill[power.ch_name][level].label;
                power.type=bossSkill[power.ch_name][level].type;
                var enemy:Number=bossSkill[power.ch_name][level].enemy;
                var area:Number=bossSkill[power.ch_name][level].area;

                if(enemy)
                    power.enemy=enemy;
                if(area)
                {
                    power.area=area;
                }
            }
            //if
            if(skillPower==0)
            {
                //shield skill
                skillPower=Math.floor(Math.random()*100)+100;
            }
            power.power=skillPower;
            //trace("CPU power :",JSON.stringify(power));
        }
        //if
        //power.id=id;
        power.target="";
        //power.speeded="false";
        power.shielded="false";
        //power.reincarnation="false";
        power.seMax=power.seMax;

        if(!power.speeded)
        {
            power.speeded="false";
        }
        //if

        member.updatePower(power);

        DebugTrace.msg("CpuMembersCommand.createPower id:"+member.name+" , power:"+JSON.stringify(power));



    }
    private function delCombinSkill(index:Number,skills:Array):Array
    {
        var _skills:Array=skills.splice(index);
        _skills.shift();
        var new_skills:Array=skills.concat(_skills);
        return new_skills;
    }
    private function getMember(id:String):Member
    {
        var member:Member
        for(var i:uint=0;i<cputeam.length;i++)
        {
            if(cputeam[i].name==id)
            {
                member=cputeam[i];
                break
            }
            //if
        }
        //for

        return member
    }
    private function commanderChangeFromation():Boolean
    {
        var used:Array=new Array(0,10,30,70);
        var formation:Boolean=false;
        var front_died:Number=0;
        var back_died:Number=0;
        for(var i:uint=0;i<cputeam.length;i++)
        {
            var member:Member=cputeam[i];
            if(member.power.comabat<3 && member.power.se==0)
            {
                //front row
                front_died++;
            }
            //if
            if(member.power.comabat>2 && member.power.se==0)
            {
                //back row
                back_died++;
            }
            //if
        }
        //for
        if(front_died>2 || back_died>2)
        {
            //only one row
            formation=true;
        }
        else
        {
            var died:Number=front_died+back_died;
            if(died>0 && died<4)
            {
                var used_per:Number=used[died];
                var ran:Number=Math.floor(Math.random()*100);
                if(ran<used_per)
                {
                    formation=true;
                }

            }
            //if

        }
        //if

        return formation;
    }
    private function commanderBattleCry():Boolean
    {
        var bc:Boolean=false;
        var used:Array=new Array(10,15,35,60,80,100);
        var effNum:Number=0;
        var front:Boolean=false;
        for(var i:uint=0;i<cputeam.length;i++)
        {
            var member:Member=cputeam[i];
            var _id:String=member.name.split("_")[1];
            if( _id=="0" && member.power.combat<3)
            {
                //front row
                front=true;
            }
            //if
            if(member.power.effect=="dizzy" || member.power.effect=="scared")
            {
                effNum++;
            }
            //if
        }
        //for
        var ran:Number=Math.floor(Math.random()*100);
        var used_per:Number=used[effNum];
        if(front && ran<used_per)
        {
            bc=true;
        }

        return bc;
    }
    private function getBossPower(boss_id):Object
    {
        var power:Object;
        for(var i:uint=0;i<cputeam.length;i++)
        {
            var cpu_power:Object=cputeam[i].power;
            if(cpu_power.id==boss_id)
            {
                power=cpu_power;
                break
            }
            //if
        }
        //for
        return power
    }
    private var checkHeal:Number=0;
    public function healSetUp():void
    {
        //Healing set up;

        healingHandle();

    }
    private function healingHandle():void
    {

        var skillsys:Object=flox.getSyetemData("skillsys");
        var cpu_teamsSys:Object=flox.getSyetemData("cpu_teams");
        var memberscom:MembersInterface=new MemebersCommand();
        var assist:Boolean=false;
        var boss_id:String="t"+cpuIndex+"_0";
        var boss_power:Object=getBossPower(boss_id);
        var boss_se:Number=boss_power.se;
        var boss_seMax:Number=boss_power.seMax;
        var seper:Number=Math.floor(Number((boss_se/boss_seMax).toFixed(2))*100);
        var gems_reqs:Array=["1","2","3","5"];
        var lvP:Array=[80,55,30,0];
        if(seper<100 && seper>=lvP[0])
        {
            se_lv="0";
        }
        else if(seper<lvP[0] && seper>=lvP[1])
        {
            se_lv="1";
        }
        else if(seper<lvP[1] && seper>=lvP[2])
        {
            se_lv="2";
        }
        else if(seper<lvP[2] && seper>=lvP[3])
        {
            se_lv="3";
        }
        //DebugTrace.msg("CpuMembersCommand.assistHandle gems_req="+gems_req);
        var attr_index:Number=0;
        if(gems_req>=Number(gems_reqs[0]))
        {
            attr_index=1;
        }
        for(var i:uint=attr_index;i<gems_reqs.length;i++)
        {
            var skill_attr:String=se_lv+"_"+gems_reqs[i];
            var skill_per:Number=Math.floor(Math.random()*100);
            var pre:Number=healgems[skill_attr];

            //DebugTrace.msg("CpuMembersCommand.assistHandle skill_per="+skill_per+" ; pre="+pre);
            if(skill_per<pre)
            {
                assist=true;
                break
            }
            //if

        }
        //for
        if(!assist)
        {
            if(checkHeal<2)

            {
                checkHeal++;
                healingHandle();
            }
            //if
        }
        //if
        DebugTrace.msg("CpuMembersCommand.assistHandle assist="+assist+" ; skill_attr="+skill_attr);
        if(assist)
        {
            //assist chance
            var now_gems_req:Number=Number(skill_attr.split("_")[1]);
            var _gems_req:Number=gems_req+now_gems_req;

            var jewel:String=now_gems_req+"|n";
            var skillID:String="";
            if(_gems_req<7)
            {
                for(var skill_id:String in skillsys)
                {
                    var skill:Object=skillsys[skill_id];
                    if(skill_id.indexOf("n")!=-1 && skill.jewel==jewel)
                    {
                        //neutral
                        skillID=skill_id;
                        break
                    }
                    //if

                }
                //for
            }
            //if
            DebugTrace.msg("CpuMembersCommand.assistHandle skillID="+skillID);

            for(var k:uint=0;k<cputeam.length;k++)
            {
                var cpu_power:Object=cputeam[k].power;
                var member:Member=cputeam[k];
                member.getStatus();
                if(cpu_power.se>0 && member.status!="dizzy")
                {
                    var skillstr:String=cpu_teamsSys[cpu_power.id].skill;
                    if(skillstr.indexOf(skillID)!=-1)
                    {
                        cpu_power.skillID=skillID;
                        var skills:Object=skillsys[skillID];
                        for(var m:String in skills)
                        {
                            cpu_power[m]=skills[m];
                        }
                        //for
                        cputeam[k].updatePower(cpu_power);
                        gems_req+=now_gems_req;
                        DebugTrace.msg("CpuMembersCommand.assistHandle cputeam["+k+"].power="+JSON.stringify(cpu_power));
                        break
                    }
                    //if
                }
                //if
            }
            //for
        }
        //if

    }
    private var player_team:Array;
    private function getMemberCombate(index:String):Number
    {
        var combat:Number=0;
        var memberscom:MembersInterface=new MemebersCommand();
        var cputeam:Array=memberscom.getCpuTeam();
        for(var i:uint=0;i<cputeam.length;i++)
        {
            var id:String=cputeam[i].power.id;
            var _id:String=id.split("_")[1];
            if(_id==index)
            {

                combat=cputeam[i].power.combat;
                break
            }
            //if
        }
        //for

        return combat
    }
    private function getMemberID(combat:Number):String
    {
        var id:String="";
        var memberscom:MembersInterface=new MemebersCommand();
        var cputeam:Array=memberscom.getCpuTeam();
        for(var i:uint=0;i<cputeam.length;i++)
        {
            var cpu_power:Object=cputeam[i].power;
            if(cpu_power.combat==combat)
            {
                id=cpu_power.id;
                break
            }
        }
        //for
        return id
    }
    private function sumMemberSE(combatlist:Array):Number
    {
        var sum:Number=0;
        var memberscom:MembersInterface=new MemebersCommand();
        var cputeam:Array=memberscom.getCpuTeam();
        var healarea:Array=new Array();
        for(var m:uint=0;m<combatlist.length;m++)
        {
            for(var k:uint=0;k<cputeam.length;k++)
            {
                var cpu_power:Object=cputeam[k].power;
                if(combatlist[m]==cpu_power.combat && cpu_power.se>0)
                {
                    sum+=cpu_power.se;

                }
                //if
            }
            //for
        }
        //for

        return sum
    }
    private function currentTeamCombat(combats:Array):Array
    {
        var _combats:Array=new Array();

        var memberscom:MembersInterface=new MemebersCommand();
        var cputeam:Array=memberscom.getCpuTeam();
        for(var i:uint=0;i<cputeam.length;i++)
        {
            var cpu_power:Object=cputeam[i].power;
            if(combats.indexOf(cpu_power.combat)!=-1)
            {
                _combats.push(cpu_power.combat);
            }
            //if
        }
        //for

        return _combats
    }
    public function setupCpuTarget():void
    {

        var battledata:BattleData=new BattleData();
        player_team=battledata.checkPlayerTeam();
        //var survivePlayer:Array=BattleData.checkPlayerSurvive();
        //var _targetlist:Array=new Array();
        var memberscom:MembersInterface=new MemebersCommand();
        var cputeam:Array=memberscom.getCpuTeam();

        for(var i:uint=0;i<cputeam.length;i++)
        {
            var cpu_power:Object=cputeam[i].power;
            if(cpu_power.skillID!="" && cpu_power.se>0)
            {
                DebugTrace.msg("CpuMembersCommand.setupCpuTarget cpu_power:"+JSON.stringify(cpu_power));

                var skillarea:Array=BattleData.rangeMatrix(cpu_power);

                DebugTrace.msg("CpuMembersCommand.setupCpuTarget skillarea:"+skillarea);

                var ran:Number=Math.floor(Math.random()*skillarea.length);
                var combat:Number=skillarea[ran];
                var target:String="";
                var targetlist:Array=new Array();
                //DebugTrace.msg("CpuMembersCommand.setupCpuTarget effect: "+cpu_power.effect);

                if(cpu_power.effect=="regenerate")
                {
                    //n0
                    targetlist.push(Number(cpu_power.combat));
                    target=cpu_power.id;
                }
                else if(cpu_power.effect=="heal")
                {


                    var battleteam:Object=ViewsContainer.battleteam;

                    target=cpu_power.id;
                    //DebugTrace.msg("CpuMembersCommand.setupCpuTarget cpu_power: "+JSON.stringify(cpu_power));


                    if(cpu_power.skillID=="n1" || cpu_power.skillID=="n2")
                    {
                        var combatlist:Array;
                        var boss_combat:Number=getMemberCombate("0");
                        if(boss_combat==1 || boss_combat==4)
                        {

                            var combatlist1:Array=battledata.praseTargetList(cpu_power,0);
                            var combats1:Array=currentTeamCombat(combatlist1);
                            var combatlist2:Array=battledata.praseTargetList(cpu_power,1);
                            var combats2:Array=currentTeamCombat(combatlist2);
                            var sum1:Number=sumMemberSE(combats1);
                            var sum2:Number=sumMemberSE(combats2);
                            combatlist=combats1;
                            if(sum2<sum1)
                            {
                                combatlist=combats2;
                            }
                            //if
                        }
                        else
                        {
                            if(cpu_power.skillID=="n1")
                            {
                                var _combat:Number=cpu_power.combat;

                            }
                            else
                            {
                                _combat=boss_combat;
                            }
                            combatlist=battledata.praseTargetList(cpu_power,_combat);

                        }
                        //if
                        //DebugTrace.msg("CpuMembersCommand.setupCpuTarget combatlist: "+combatlist);
                        var healarea:Array=new Array();

                        for(var k:uint=0;k<cputeam.length;k++)
                        {
                            var _cpu_power:Object=cputeam[k].power;
                            if(combatlist.indexOf(_cpu_power.combat)!=-1 && _cpu_power.se>0)
                            {
                                if(cpu_power.skillID=="n1" && cpu_power.id!=_cpu_power.id)
                                {
                                    healarea.push(_cpu_power.combat);
                                }
                                if(cpu_power.skillID=="n2")
                                {
                                    healarea.push(_cpu_power.combat);
                                }

                            }
                            //if
                        }
                        //for

                        //DataContainer.healArea=healarea;
                        combat=healarea[Math.floor(Math.random()*healarea.length)];
                        target=getMemberID(combat);
                        if(cpu_power.skillID=="n2")
                        {
                            targetlist=healarea;
                        }
                        else
                        {

                            //n1
                            for(var j:uint=1;j<healarea.length;j++)
                            {
                                healarea=new Array();
                                healarea.push(combat)
                            }
                            //DebugTrace.msg("CpuMembersCommand.setupCpuTarget n1 healarea="+healarea);
                            targetlist=healarea;
                        }
                    }
                    //if
                }
                else
                {//n3
                    if(cpu_power.skillID=="n3")
                    {
                        target=cpu_power.id;
                    }
                    else
                    {
                        targetlist=battledata.praseTargetList(cpu_power,combat);
                        ran=Math.floor(Math.random()*targetlist.length);

                        target="player"+targetlist[ran];
                    }
                    //if
                }
                //if
                //------->target's combate
                //DebugTrace.msg("CpuMembersCommand.setupCpuTarget targetlist: "+targetlist);
                //DebugTrace.msg("CpuMembersCommand.setupCpuTarget target: "+target);
                if(cpu_power.se==0)
                {
                    targetlist=new Array();
                    target="";

                }
                else if(cpu_power.skillID=="w0" || cpu_power.skillID=="a0")
                {
                    target=cpu_power.id;
                    targetlist=new Array();
                }
                else
                {
                    var player_team:Array=memberscom.getPlayerTeam();
                    var skilllID:String=cpu_power.skillID;
                    var neutrals:Array=["n0","n1","n2","n3"];
                    if(neutrals.indexOf(skilllID)==-1)
                    {
                        //skill isn't neutral
                        var __targetlist:Array=new Array();

                        for(var p:uint=0;p<player_team.length;p++)
                        {
                            var player_power:Object=player_team[p].power;
                            //DebugTrace.msg("CpuMembersCommand.setupCpuTarget player_team["+p+"].power="+JSON.stringify(player_power));
                            var playerID:String=player_power.id;
                            var _id:Number=Number(playerID.split("player").join(""));
                            if(targetlist.indexOf(_id)!=-1)
                            {
                                //target should be in player team
                                __targetlist.push(_id);
                            }
                            //if
                        }
                        //for

                        targetlist=new Array();
                        for(var v:uint=0;v<__targetlist.length;v++){
                            targetlist.push(__targetlist[v]);
                        }

                        if(targetlist.length>0){
                            //ran=Math.floor(Math.random()*__targetlist.length);
                            target="player"+targetlist[0];
                        }

                    }
                    //if
                }
                //if
                //--------->target's id
                //DebugTrace.msg("CpuMembersCommand.setupCpuTarget -- targetlist: "+targetlist);
                //DebugTrace.msg("CpuMembersCommand.setupCpuTarget -- target: "+target);
                //DebugTrace.msg("CpuMembersCommand.setupCpuTarget -- cpu_power: "+JSON.stringify(cpu_power));
                cpu_power.targetlist=targetlist;
                cpu_power.target=target;
                if(cpu_power.status!="dizzy")
                {
                    cputeam[i].updatePower(cpu_power);
                }
                //if
                DebugTrace.msg("CpuMembersCommand.setupCpuTarget cpu_power["+i+"]="+JSON.stringify(cpu_power));

                if(cpu_power.skillID=="")
                {
                    var cpuMemberEvt:BattleEvent=cputeam[i].memberEvt;
                    cpuMemberEvt.act="ready";
                    cpuMemberEvt.updateMemberAct();
                }
                else
                {
                    cputeam[i].setupSkillAni();
                }
            }
            //if can use skill && survive
        }
        //for

    }


    private function searchSurviveTarget():Array
    {

        var new_player_team:Array=new Array();
        for(var i:uint=0;i<player_team.length;i++)
        {
            if(player_team[i].se>0)
            {
                //target survive
                new_player_team.push(player_team[i]);
            }
            //if
        }
        //for

        return new_player_team;

    }
    /*public function showupMember():void
     {
     cpu_team=new Array();

     for(var i:uint=0;i<main_team.length;i++)
     {


     //DebugTrace.msg("formation_info:"+formation_info);
     //fake
     var boymc:MovieClip=new Boy();
     cpu_team.push(boymc);


     }
     //cpu_team[0].visible=true;
     //player_team[0].gotoAndStop("A_SPDragon");


     }
     public function getCpuTeam():Array
     {

     return cpu_team;
     }*/
    public function getCpuMainTeam():Array
    {
        //DebugTrace.msg("CpuMembersCommand.getCpuMainTeam mainTeam="+main_team.length);
        return main_team;
    }
    /*public function getCpuPower():Array
     {
     return cpu_power;

     }*/
    /*public function overidePower(powers:Array):void
     {
     cpu_power=powers;
     }*/
    /*public function overideMainTeam(teams:Array):void
     {
     main_team=teams;
     DataContainer.cpuMainTeam=main_team;
     }*/
    /*public function set cputeamMember(members:Array):void
     {
     cputeam=members;
     }*/
    public function upgradeCpu():void
    {
        var cpu_teams:Object=flox.getSaveData("cpu_teams");
        for(var team_id:String in cpu_teams){
            var team:String=team_id.split("_")[0];
            var index:Number=Number(team.split("").join(""));

            if(index<=8) {
                var se:Number = Number(cpu_teams[team_id].se);
                se *= 2;
                cpu_teams[team_id].se = se;
            }
        }
        flox.save("cpu_teams",cpu_teams);

    }
    public function finalBossAmour():void{




    }
    public function reseatPower():void{
        for(var i:uint=0;i<cputeam.length;i++) {
            var cpu_power:Object = cputeam[i].power;
            cpu_power.skillID="";
            cpu_power.target="";
            cpu_power.targetlist=null;
        }
    }

}
}