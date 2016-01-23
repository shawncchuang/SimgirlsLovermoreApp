package model
{
import controller.CpuMembersCommand;
import controller.CpuMembersInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MembersInterface;
import controller.MemebersCommand;

import data.Config;
import data.DataContainer;

import utils.DebugTrace;

import views.Member;

import flash.utils.Dictionary;
public class BattleData
{
    //base point
    private static var bp:Number=29;
    private var flox:FloxInterface=new FloxCommand();
    private var allpowers:Array;
    private static var _stoneElements:Array;
    private var cpucom:CpuMembersInterface=new CpuMembersCommand();
    private static var memberscom:MembersInterface=new MemebersCommand();
    private static var from:String;
    public static var surviveCombats:Array
    private var targetArea:Array;
    private var skillarea:Array=new Array();
    private var extra_damage:Number=1.5;
    public static function rangeMatrix(power:Object):Array
    {
        var matrix:Array=new Array();
        from=power.from;
        var skillID:String=power.skillID;
        var area:Number=power.area;
        var areaMatrix:Object={
            0:[0,1,2],
            1:[3,4,5],
            2:[0,1,2,3,4,5]
        }
        if(skillID.indexOf("n")!=-1)
        {
            //assist
            if(from=="player")
            {
                surviveCombats=checkPlayerSurvive();
            }
            else
            {
                surviveCombats=checkCpuSurvive();
            }
            //if
        }
        else
        {
            //attck->target
            if(from=="player")
            {
                surviveCombats=checkCpuSurvive();
            }
            else
            {

                surviveCombats=checkPlayerSurvive();
            }
            //if
        }
        //if
        var survive:Boolean=false;
        //DebugTrace.msg("BattleData.rangeMatrix surviveCombats:"+surviveCombats+" ; from:"+from);
        if(area==0)
        {
            // check front row
            var _matrix:Array=[0,1,2];
            for(var i:uint=0;i<surviveCombats.length;i++)
            {
                if(_matrix.indexOf(surviveCombats[i])!=-1)
                {

                    survive=true;
                    break
                }
                //if
            }
            //for
            if(!survive)
            {
                area=1;
            }
            //if
        }
        if(area==1)
        {
            //check back row
            _matrix=[3,4,5];

            for(var j:uint=0;j<surviveCombats.length;j++)
            {
                if(_matrix.indexOf(surviveCombats[j])!=-1)
                {
                    survive=true;
                    break
                }
                //if
            }
            //for
            if(!survive)
            {
                area=0;
            }
            //if
        }
        //if

        var _area:Array=areaMatrix[area];
        for(var k:uint=0;k<_area.length;k++)
        {
            var target:Number=_area[k];
            if(surviveCombats.indexOf(target)!=-1)
            {
                matrix.push(target);
            }
            //if

        }
        //for
        //matrix=areaMatrix[aera];
        return matrix
    }
    /*public function skillCard(member:Member,skill:Object):Object
     {
     //var member_power:Object=cupsys;
     var _skill:Object=new Object();
     var se:Number=member.power.se;
     var power:Number=Number(skill.power);
     if(member.power.skillID.indexOf("n")!=-1)
     {
     se=member.power.seMax;
     }


     var dp:Number=BattleData.bp;
     //power=Math.floor(power+power*bp*Number((se/9999).toFixed(2)));
     power=Math.floor(power*bp*Number((se/9999).toFixed(2)));
     var extra:Number=10-Math.floor(Math.random()*20);
     skill.power=power+extra;

     for(var attr:String in skill)
     {
     _skill[attr]=skill[attr];
     }


     return _skill;
     }*/
    public function skillCard(member:Member,power:Number):Number
    {
        //var member_power:Object=cupsys;
        var skill_power:Number=power;
        var de_power:Number=power;
        var _skill:Object=new Object();
        var se:Number=member.power.se;

        if(member.power.skillID.indexOf("n")!=-1)
        {
            se=member.power.seMax;
        }


        var dp:Number=BattleData.bp;

        //power=Math.floor(power+power*bp*Number((se/9999).toFixed(2)));
        power=Number(Math.floor(power*bp*Number((se/9999).toFixed(2))));
        //var extra_power:Number=Math.floor(power/10);
        //var extra:Number=extra_power-Math.floor(Math.random()*(extra_power*2));
        var extra:Number=0;
        skill_power=skill_power+power+extra;
        if(skill_power==0)
        {
            skill_power=de_power
        }

        return skill_power;
    }
    public function damageCaculator(member_power:Object):Number
    {
        var damage:Number;

        var power:Number=Math.floor(member_power.power*extra_damage);
        var extra_power:Number=Math.floor(power/10);
        var extra:Number=extra_power-(Math.floor(Math.random()*(extra_power*2)));

        //DebugTrace.msg("BattleData.damageCaculator power="+power);
        //DebugTrace.msg("BattleData.damageCaculator extra="+extra);

        damage=power+extra;

        return damage;
    }
    private function getTargetPower(target:String):Object
    {
        var power:Object=new Object();
        for(var i:uint=0;i<allpowers.length;i++)
        {
            if(allpowers[i].id==target)
            {
                power=allpowers[i];
                break
            }
        }
        //for
        return power;
    }
    public static function set stoneElements(list:Array):void
    {
        _stoneElements=list;
    }
    public static function get stoneElements():Array
    {
        return _stoneElements;
    }
    public function stoneCaculator():void
    {
        var stones:Array=new Array();
        var elements:Array=Config.elements;
        elements=new Array("fire","air","earth","water","neutral");
        for(var i:uint=0;i<7;i++)
        {

            var ran:Number=Math.floor(Math.random()*100);
            if(ran<=12)
            {
                var ele:String="neutral";
            }
            else
            {
                var other_elements:Array=new Array("fire","air","earth","water");
                var index:Number=Math.floor(Math.random()*other_elements.length);
                ele=other_elements[index];
            }
            //if
            stones.push(ele);
        }
        //for
        //---------fake gems
        //stones=["air","water","earth","air","water","earth","neutral"];
        stoneElements=stones;
    }
    public function praseRequestStones(elements:Array,reqs:Array):Array
    {
        //elements:elements stones in this round
        //reqs: how many stones do the skill need?
        //DebugTrace.msg("reqs.length :"+reqs.length);
        var stoneslsit:Array=DataContainer.stonesList;
        var elelist:Array=new Array();
        for(var i:uint=0;i<reqs.length;i++)
        {
            for(var j:uint=0;j<elements.length;j++)
            {
                DebugTrace.msg(elements[j]+" ; "+reqs[i].ele);
                if(elements[j]==reqs[i].ele && stoneslsit[j].status=="empty")
                {
                    var eleObj:Object=new Object();
                    eleObj.ele=elements[j];
                    eleObj.index=j;
                    DebugTrace.msg("Battle.praseRequestStones elelist["+j+"]="+JSON.stringify(eleObj));
                    elelist.push(eleObj);
                }
                //if
            }
            //for
        }
        //for
        var new_elelist:Array=new Array();

        for(var q:uint=0;q<reqs.length;q++)
        {
            //elelist.sortOn(reqs[q].ele);
            //DebugTrace.msg("Battle.praseRequestStones reqs["+q+"]="+JSON.stringify(reqs[q]));
            //DebugTrace.msg("Battle.praseRequestStones elelist["+q+"]="+JSON.stringify(elelist[0]));
            for(var p:uint=0;p<reqs[q].qty;p++)
            {
                if(elelist[p])
                {
                    DebugTrace.msg("Battle.praseRequestStones new_elelist["+q+"]="+JSON.stringify(elelist[p]));
                    new_elelist.push(elelist[p]);
                }
                else
                {
                    DebugTrace.msg("Battle.praseRequestStones");
                    new_elelist.push(null);
                }
                //if
            }
            //for

        }
        //for
        return new_elelist
    }

    public function praseTargetList(power:Object,combat:Number):Array
    {
        //combat ; target's combat
        DebugTrace.msg("BattleData.praseTargetList combat= "+combat);
        DebugTrace.msg("BattleData.praseTargetList power= "+JSON.stringify(power));
        from=power.from;

        targetArea=new Array();
        var area:Number=power.area;
        var enemy:Number=power.enemy;
        var skillID:String=power.skillID;
        skillarea=rangeMatrix(power);
        var areaMatrix:Object=new Object();
        var target:Number;

        DebugTrace.msg("BattleData.praseTargetList skillarea= "+skillarea);
        switch(enemy)
        {
            case 0:
                targetArea=surviveCombats;
                break
            case 1:

                if(skillarea.indexOf(combat)!=-1)
                {
                    targetArea.push(combat);
                }


                break
            case 2:
                targetArea.push(combat);
                if(combat<3)
                {
                    targetArea.push(combat+3);
                }
                else
                {
                    targetArea.push(combat-3);
                }
                break
            case 3:

                createTargetArea(skillID,combat);

                break
            case 4:

                areaMatrix={
                    0:[0,1,3,4],
                    1:[1,2,4,5],
                    2:[1,2,4,5],
                    3:[0,1,3,4],
                    4:[0,1,3,4],
                    5:[1,2,4,5]
                }
                targetArea=areaMatrix[combat];

                break
            case 5:
                for(var n:uint=0;n<skillarea.length;n++)
                {
                    targetArea.push(skillarea[n]);
                }
                //for
                break

        }
        //switch
        if(surviveCombats.length==1)
        {
            targetArea=new Array();
            targetArea.push(surviveCombats[0]);
        }
        DebugTrace.msg("BattleData.surviveCombats: "+surviveCombats);
        DebugTrace.msg("BattleData.targetArea: "+targetArea);

        //DebugTrace.msg("BattleData._targetArea="+_targetArea);
        return targetArea;
    }
    private function createTargetArea(skillID:String,combat:Number):void
    {

        switch(skillID)
        {
            case "f2":

                if(combat<3)
                {
                    //font row
                    var _skillarea:Array=[0,1,2];
                }
                else
                {
                    _skillarea=[3,4,5];

                }
                //if
                for(var v:uint=0;v<_skillarea.length;v++)
                {
                    if(surviveCombats.indexOf(_skillarea[v])!=-1)
                    {
                        targetArea.push(_skillarea[v]);
                    }
                    //if
                }
                //for
                break
            case "gor_s_1":
            case "tgr_s_1":
                //front row
                _skillarea=[0,1,2];

                for(var w:uint=0;w<_skillarea.length;w++)
                {
                    if(surviveCombats.indexOf(_skillarea[w])!=-1)
                    {
                        targetArea.push(_skillarea[w]);
                    }
                    //if
                }
                //for
                if(targetArea.length==0)
                {
                    //front row all death
                    _skillarea=[3,4,5];
                    for(w=0;w<_skillarea.length;w++)
                    {
                        if(surviveCombats.indexOf(_skillarea[w])!=-1)
                        {
                            targetArea.push(_skillarea[w]);
                        }
                        //if
                    }
                    //for
                }
                //if
                break
            default:
                for(var t:uint=0;t<skillarea.length;t++)
                {
                    if(t<3)
                    {
                        targetArea.push(skillarea[t]);
                    }
                }
                //for
                break
        }
        //switch

    }
    public function checkPlayerTeam():Array
    {
        //var formation:Array=flox.getSaveData("formation");
        //var seObj:Object=flox.getSaveData("se");
        var playerteam:Array=MemebersCommand.playerTeam;
        var player_team:Array=new Array();

        for(var j:uint=0;j<playerteam.length;j++)
        {

            player_team.push(playerteam[j].power);
        }
        //for
        //DataContainer.playerMainTeam=player_team;
        return player_team;

    }
    public function checkCPUTeam():Array
    {
        var cpu_team:Array=new Array();
        var cputeam:Array=memberscom.getCpuTeam();
        for(var j:uint=0;j<cputeam.length;j++)
        {

            var cpu:Object=new Object();
            cpu=cputeam[j].power;
            cpu_team.push(cpu);
        }
        return cpu_team;
    }
    public static function checkPlayerSurvive():Array
    {

        //var playerteam:Array=MemebersCommand.playerTeam;
        var playerteam:Array=memberscom.getPlayerTeam();
        //var mainPlayer:Array=DataContainer.playerMainTeam;

        var surviveCombats:Array=new Array();
        for(var j:uint=0;j<playerteam.length;j++)
        {

            var power:Object=playerteam[j].power
            //DebugTrace.msg("BattleData.checkPlayerSurvive playerteam["+j+"]="+JSON.stringify(power));
            if(power.se>0)
            {
                surviveCombats.push(power.combat)
            }
            //if
        }
        //for
        //DebugTrace.msg("BattleData.checkPlayerSurvive surviveCombats="+surviveCombats);
        return surviveCombats;
    }
    public static function checkCpuSurvive():Array
    {
        var surviveCombats:Array=new Array();

        var cputeam:Array=CpuMembersCommand.cputeamMember;
        for(var j:uint=0;j<cputeam.length;j++)
        {

            var cpu_power:Object=cputeam[j].power;
            //DebugTrace.msg("BattleData.praseTargetList mainTeam["+j+"]="+JSON.stringify(cpu_power));
            if(cpu_power.se>0)
            {
                surviveCombats.push(cpu_power.combat);
            }
            //if
        }
        //for

        return surviveCombats;
    }
    public function getPlayerChacterName(member_id:String):String
    {
        var _name:String="";
        var formation:Array=flox.getSaveData("formation");
        var attack_combat:Number=Number(member_id.split("player").join(""));
        for(var i:uint=0;i<formation.length;i++)
        {
            if(formation[i])
            {
                if(formation[i].combat==attack_combat)
                {
                    _name=formation[i].name;
                    break;

                }
                //if
            }//if
        }
        //for
        return _name;

    }
    public function shuffleHandle(sample:Array):Array
    {
        var re:Array=new Array();


        while (sample.length > 0)
        {
            re.push(sample.splice(Math.round(Math.random() * (sample.length - 1)),1)[0]);
        }
        //while


        return re

    }
    public function backStoryScene():String
    {
        //back to scent and switch story
        var scene:String="";
        var current_switch:String=flox.getSaveData("current_switch").split("|")[0];
        var switchs:Object=flox.getSyetemData("switchs");
        var location:String=switchs[current_switch].location;
        var sceneObj:Object=Config.stagepoints;
        for(var _name:String in sceneObj)
        {
            if(_name.toLowerCase()==location)
            {
                scene=_name+"Scene";
                break
            }

        }
        return scene;
    }
    private var ranking:Array;
    private var current_battle:Object;
    public function checkBattleSchedule(type:String,target:String):Number
    {
        //type:Battle || BattleResault ; target:player_team || cpu_team
        var cpuIndex:Number=-1;
        var date:String=flox.getSaveData("date").split(".")[1];
        var month:String=flox.getSaveData("date").split(".")[2];

        var schedule:Dictionary=Config.battleSchedule();

        var dayStr:String=month+"_"+date;
        var player_index:Number=-1;
        var battled:Array=flox.getSaveData("current_battle")[dayStr];

        if(dayStr==Config.gameEndDay)
        {
            //final battle

        }

        var team_battle:Array=schedule[dayStr];
        //DebugTrace.msg("BattleData.checkBattleSchedule team_battle="+JSON.stringify(team_battle));
        if(team_battle) {
            for (var i:uint = 0; i < team_battle.length; i++) {
                var key:String = team_battle[i].split("|")[0];

                if (key == "p") {
                    player_index = Number(i);
                }

                if(type == "BattleResult"){
                    checkBattleResult(i,target,dayStr,key,team_battle[i].split("|")[1]);


                }

            }

            for(var j:uint=0;j<battled.length;j++){
                //check already battle today
                key= battled[j].split("|")[0];
                if(key=="p"){
                    //already battled today
                    player_index=-1;
                }

            }

            if(player_index!=-1) {
                //cpu found out
                cpuIndex = Number(team_battle[player_index].split("|")[1]);
            }
            var battles:Array=flox.getSaveData("current_battle")[dayStr];
            if(battles[0]!="0|0"){
                //already battled today;
                cpuIndex=-2;
            }


        }


        var battleDays:Array=Config.battleDays;
        var monthsList:Array= Config.Monthslist;
        if(type == "BattleRanking" || type=="TimeTravelBattleRanking"){

            if(type=="TimeTravelBattleRanking"){
                //uesd timemachine reset current_battle
                var defaultCurrentBattle:Object=Config.defaultCurrentBattle();
                flox.save("current_battle",defaultCurrentBattle);
            }

            var pastIndex:Number=0;
            var currentMonthIndex:Number=monthsList.indexOf(month);
            for(var n:uint=0;n<battleDays.length;n++){
                //Jan,Feb....Nov
                var battle_month:String=battleDays[n].split("_")[0];
                var battle_date:Number=Number(battleDays[n].split("_")[1]);
                var scheduleMonthIndex:Number=monthsList.indexOf(battle_month);

                if(currentMonthIndex>8 || currentMonthIndex==0){
                    //after Sep and Jan

                    if(currentMonthIndex>=scheduleMonthIndex){
                        pastIndex++;

                        if(currentMonthIndex==scheduleMonthIndex){

                            if(Number(date)<battle_date){
                                pastIndex--;
                                break;
                            }
                        }
                    }else{

                        pastIndex--;
                        break;

                    }



                }

            }
            //DebugTrace.msg("BattleData.checkBattleResult pastIndex="+pastIndex);
            if(pastIndex>0){
                var current_battle:Object=flox.getSaveData("current_battle");
                for(var k:uint=0;k<pastIndex;k++){
                    var battleDay:String=battleDays[k];
                    team_battle=schedule[battleDay];
                    battled=current_battle[battleDay];
                    for(var m:uint = 0; m < team_battle.length; m++) {
                        //DebugTrace.msg("BattleData.checkBattleResult team_battle[m]="+team_battle[m]);
                        if(battled[m]=="0|0" || type=="TimeTravelBattleRanking"){
                            //did not battle yet
                            var team1ID:String = team_battle[m].split("|")[0];
                            if(team1ID!="p"){
                                //not included player
                                var team2ID:String = team_battle[m].split("|")[1];
                                checkBattleResult(m, target, battleDay, team1ID, team2ID);
                            }
                        }

                    }
                }


            }

        }

        return cpuIndex;
    }
    private function checkBattleResult(index:uint,target:String,day:String,team1:String,team2:String):void{

        var cpu_team:Object=flox.getSaveData("cpu_teams");
        current_battle=flox.getSaveData("current_battle");
        var current_teams:Array=current_battle[day];
        var team:String=current_teams[index];
        ranking=flox.getSaveData("ranking");
        var win_wadge1:Number=Math.floor(Math.random()*40)+1;
        var win_wadge2:Number=Math.floor(Math.random()*40)+1;
        var win_index:uint=0;
        var team1SE:Number=0;
        var team2SE:Number=0;

        if(target=="cpu_team" && team1!="p"){

            //cpu team battle result
            for(var k:uint=0;k<5;k++) {
                team1SE += Number(cpu_team["t" + team1+"_"+k].seMax);
            }
            for(var m:uint=0;m<5;m++) {
                team2SE += Number(cpu_team["t" + team2+"_"+m].seMax);
            }

        }
        if(target=="player_team" && team1=="p"){

            var player_love:Object=flox.getSaveData("love");
            var player_se:Array=new Array();
            for(var name:String in player_love){
                var player:Object=new Object();
                player[name]=name;
                player.se=player_love[name];
                player_se.push(player);
            }
            player_se=player_se.sortOn("se",Array.DESCENDING | Array.NUMERIC);
            for(var n:uint=0;n<player_se.length-5;n++){
                player_se.pop();
            }
            for(k=0;k<5;k++) {
                team1SE += Number(player_se[k].se);
            }
            for(m=0;m<5;m++) {
                team2SE += Number(cpu_team["t" + team2+"_"+m].seMax);
            }



        }
        //DebugTrace.msg("BattleData.checkBattleResult team1SE="+team1SE+" ; team2SE="+team2SE);
        //DebugTrace.msg("BattleData.checkBattleResult win_wadge1="+win_wadge1+" ; win_wadge2="+win_wadge2);
        var team1_rate:Number=Number((team1SE*(1+win_wadge1/100)).toFixed(2));
        var team2_rate:Number=Number((team2SE*(1+win_wadge2/100)).toFixed(2));
        DebugTrace.msg("BattleData.checkBattleResult team1_rate="+team1_rate+" ; team2_rate="+team2_rate);
        if(team1_rate>team2_rate){

            win_index=0;

        }else{
            win_index=1;
        }
        if(win_index==0){
            //win
            var win_team:String=team1;
            var lose_team:String=team2;
        }else{
            win_team=team2;
            lose_team=team1;
        }

        if(win_team=="p")
        {
            win_team="player";

        }else {
            win_team="t"+win_team;

        }
        if(lose_team=="p")
        {
            lose_team="player";

        }else{
            lose_team=="t"+lose_team;
        }

        if(target=="cpu_team")
        {
            //don't need player result
            if(win_team=="player" || lose_team=="player")
            {
                win_team="";

            }
        }
        if(target=="player_team")
        {
            //don't need cpu result
            if(win_team.indexOf("t")!=-1 || lose_team.indexOf("t")!=-1)
            {
                win_team="";
            }

        }

        if(win_team!="")
        {
            if(win_index==0){
                team="W|L";
            }else{
                team="L|W";
            }
            current_teams[index]=team;
            current_battle[day]=current_teams;

            flox.save("current_battle",current_battle);
            //DebugTrace.msg("BattleData.checkBattleResult current_battle="+JSON.stringify(current_battle));
        }
        for(var i:uint=0;i<ranking.length;i++) {
            if (ranking[i].team_id == win_team) {
                var win_times:Number=Number(ranking[i].win);
                win_times++;
                ranking[i].win=win_times;

                break
            }
        }
        flox.save("ranking",ranking);

        //DebugTrace.msg("BattleData.checkBattleResult ranking="+JSON.stringify(ranking));
    }

    public function checkSurvivor():Boolean{

        var survivor:Boolean=false;
        var seObj:Object=flox.getSaveData("se");

        var pts:Object=flox.getSaveData("pts");
        var reLv:Object=flox.getSyetemData("relationship_level");

        for(var name:String in seObj){

            if(seObj[name]>0){

                if(pts[name]>reLv["closefriend-Min"] || name=="player"){
                    survivor=true;
                    break
                }


            }
        }


        return survivor

    }
    public function finishedBattle(winner:String,opponetID:String):void{

        DebugTrace.msg("BattleScene finishedBattle--------winner="+winner+" ,opponetID="+opponetID);
        var ranking:Array=flox.getSaveData("ranking");
        var current_battle:Object=flox.getSaveData("current_battle");
        var date:String=flox.getSaveData("date").split(".")[1];
        var month:String=flox.getSaveData("date").split(".")[2];
        var dateStr:String=month+"_"+date;
        var battles:Array=current_battle[dateStr];
        var team_result:String="";
        var targetID:String="";

        if(winner=="player"){
            targetID="player";
            team_result="W|L";
        }else{
            targetID=opponetID;
            team_result="L|W";

        }
        battles[0]=team_result;
        current_battle[dateStr]=battles;
        flox.save("current_battle",current_battle);
        //DebugTrace.msg("BattleScene finishedBattle ranking="+JSON.stringify(ranking));
        for(var i:uint=0;i<ranking.length;i++){
            var team:Object=ranking[i];

            if(team.team_id==targetID){
                var win_time:Number=team.win;
                win_time++;
                team.win=win_time;
                ranking[i]=team;

                break;
            }

        }

        flox.save("ranking",ranking);

    }

}
}