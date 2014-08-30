package data
{
import flash.globalization.CurrencyFormatter;

import controller.FloxCommand;
import controller.FloxInterface;

import model.SaveGame;
import model.SystemData;

import utils.DebugTrace;

public class DataContainer
{



    private static var version:String;
    private static var _deadline:Boolean;
    private static var scene:String;
    private static var label:String;
    private static var player_talkllibrary:Array;
    private static var ch_talkllibrary:Array;
    private static var npc_talkinglibrary:Array;
    private static var playerdata:Object;

    private static var _battle:Boolean;
    private static var record:Array;
    private static var flox:FloxInterface=new FloxCommand();
    private static var sortedlikes:Array;
    private static var dating:String;
    private static var schedulelist:Array;
    private static var dateIndex:Object;
    private static var stones:Array;
    private static var surviveplayer:Array;
    private static var cpu_main_team:Array;
    private static var player_main_team:Array;
    private static var player_powers:Array;
    private static var memberseffect:Object;
    private static var members_mail:Array;
    private static var _current_power:Object;
    private static var _healArea:Array;
    private static var _stageID:Number;
    private static var cpuID:Number;
    private static var skills:Array;
    private static var _battleScene:String;
    private static var battlecode:String;


    public static function set currentVersion(ver:String):void
    {
        version=ver;
    }
    public static function get currentVersion():String
    {
        return version
    }
    public static function set deadline(boolean:Boolean):void
    {
        _deadline=boolean;
    }
    public static function get deadline():Boolean
    {
        return _deadline;
    }
    public static function set currentScene(value:String):void
    {

        scene=value;
    }
    public static function get currentScene():String
    {

        return scene;
    }
    public static function set currentLabel(value:String):void
    {
        label=value;

    }
    public static function get currentLabel():String
    {
        return label;

    }
    public static  function set playerTalklibrary(re:Array):void
    {
        player_talkllibrary=re;
    }
    public static  function get playerTalklibrary():Array
    {
        return player_talkllibrary;
    }

    public static  function set characterTalklibrary(re:Array):void
    {
        ch_talkllibrary=re;
    }
    public static  function get characterTalklibrary():Array
    {
        return ch_talkllibrary;
    }

    public static function set NpcTalkinglibrary(re:Array):void
    {

        npc_talkinglibrary=re;
    }
    public static function get NpcTalkinglibrary():Array
    {

        return npc_talkinglibrary;
    }
    public static function set player(_data:Object):void
    {

        playerdata=_data;
    }
    public static function get player():Object
    {

        return playerdata;
    }
    public static function set battleDemo(value:Boolean):void
    {
        _battle=value;
    }
    public static function get battleDemo():Boolean
    {
        return _battle;
    }
    public static function set SaveRecord(list:Array):void
    {
        record=list;
    }
    public static function get SaveRecord():Array
    {
        return 	record;
    }
    public static function currencyFormat(value:Number):String
    {
        var localID:String="CAD"
        var cf:CurrencyFormatter = new CurrencyFormatter(localID);
        cf.trailingZeros=false;
        /*
         if (cf.formattingWithCurrencySymbolIsSafe("CAD")) {
         trace(cf.actualLocaleIDName);     // "fr-CA French (Canada)"
         trace(cf.format(1254.56, false)); // "1 254,56 $"
         }
         else {
         trace(cf.actualLocaleIDName);     // "en-US English (USA)"
         cf.setCurrency("CAD", "C$")
         trace(cf.format(1254.56, true));  // "C$ 1,254.56"
         }
         */
        var currecy:String=cf.format(value);
        var num_currency:String=String(currecy.split(localID).join(""));
        return 	num_currency;
    }

    private var chlikesScene:Array;
    public function initChacacterLikeScene():void
    {
        /*
         every character has rating with all scenes
         every scene has random rating(all scenes's rating totle is 100)

         */
        var chls:Object=new Object();
        var characters:Array=Config.characters;
        var scenes:Object=Config.stagepoints;



        //DebugTrace.msg("rendom scene  : "+ran_sceneslist+" ; length : "+ran_sceneslist.length);
        //40% likes-random 100 ,
        for(var i:uint=0;i<characters.length;i++)
        {
            chlikesScene=new Array();
            var likes:Number=100;
            var ch_name:String=characters[i];
            //var scene_like:Object=new Object();
            var ran_sceneslist:Array=setupRandomSencenLikes();
            //DebugTrace.msg("DataContainer.initChacacterLikeScene ran_sceneslist:"+ran_sceneslist);
            for(var k:uint=0;k<ran_sceneslist.length;k++)
            {
                //every scene rating;

                var scene_rating:Object=new Object();

                var reLikes:uint=uint(Math.random()*likes);
                var scene_name:String=ran_sceneslist[k];
                //DebugTrace.msg("scene_name  : "+scene_name);
                if(scene_name=="PrivateIsland" || scene_name=="Airport" || scene_name=="LovemoreMansion" || scene_name=="Hotel" || scene_name=="PoliceStation" || scene_name=="SSCCArena")
                {
                    //no people at here
                    reLikes=0;
                }
                //scene_like[scene_name]=reLikes;
                //DebugTrace.msg("DataContainer.initChacacterLikeScene scene_name:"+scene_name);
                scene_rating.name=scene_name;
                scene_rating.likes=reLikes;

                likes-=reLikes;
                var gress:Number=Math.floor(ran_sceneslist.length*0.4);
                if(likes<50 && k<gress)
                {
                    //40% likes:random 50
                    likes=50;
                }
                if(k>gress)
                {
                    //60% likes:keeping random-20 to 0;
                    likes-=20;
                    if(likes<0)
                    {
                        likes=0;
                    }
                    //if
                }
                //if
                chlikesScene.push(scene_rating);

            }
            //for

            chlikesScene.sortOn("likes",Array.NUMERIC|Array.DESCENDING);
            //DebugTrace.msg("DataContainer.initChacacterLikeScene chlikesScene:"+JSON.stringify(chlikesScene));
            /*var _scene_like:Object=new Object();
             for(var m:uint=0;m<chlikesScene.length;m++)
             {
             var ratingObj:Object=chlikesScene[m];
             _scene_like[ratingObj.name]=ratingObj.likes;
             DebugTrace.msg("DataContainer.initChacacterLikeScene _scene_like:"+JSON.stringify(_scene_like));
             }*/
            chls[ch_name]=chlikesScene;

            //chls[ch_name]=scene_like;

        }
        //for
        var chLikes:String=JSON.stringify(chls);
        //DebugTrace.msg("DataContainer.initChacacterLikeScene chLikes:"+chLikes);

        //flox.saveSystemData("scenelikes",chls);

        flox.save("scenelikes",chls)

    }
    private function setupRandomSencenLikes():Array
    {
        var sceneslist:Array=new Array();
        var ran_sceneslist:Array=new Array();
        var scenes:Object=Config.stagepoints;
        for(var scene:String in scenes)
        {
            if(scene!="Hotel")
            {
                sceneslist.push(scene);
            }
        }
        //for
        //make random all scenes
        var max:uint=sceneslist.length;
        for(var j:uint=0;j<max;j++)
        {
            var index:uint=uint(Math.random()*sceneslist.length);
            ran_sceneslist.push(sceneslist[index]);
            //DebugTrace.msg("rendom scene  : "+sceneslist[index]);
            var _sceneslist:Array=sceneslist.splice(index);
            _sceneslist.shift();
            sceneslist=sceneslist.concat(_sceneslist);
            //DebugTrace.msg("_sceneslist  : "+_sceneslist);
            //DebugTrace.msg("DataContainer.sceneslist  : "+sceneslist +" ; length:"+sceneslist.length);
        }
        //for
        //DebugTrace.msg("DataContainer.sceneslist  : "+ran_sceneslist +" ; length:"+ran_sceneslist.length);
        return ran_sceneslist;
    }
    public static function set seceneLikseSorted(target:String):void
    {

        var scenelikes:Object=FloxCommand.savegame.scenelikes;
        var wholikes:Object=scenelikes[target];

        sortedlikes=new Array();
        for(var scene:String in wholikes)
        {
            var likes:Object=new Object();
            likes.scene=scene;
            likes.value=uint(wholikes[scene]);
            sortedlikes.push(likes);
        }
        sortedlikes.sortOn(["value"],Array.NUMERIC|Array.DESCENDING);
        /*for(var i:uint=0;i<sortedlikes.length;i++)
         {
         var sortedStr:String=JSON.stringify(sortedlikes[i]);
         DebugTrace.msg("DataContainer.seceneLikseSorted sortedStr:"+sortedStr);
         }*/
        //DebugTrace.msg("DataContainer.seceneLikseSorted _sortedlikes:"+_sortedlikes);

    }
    public function setupCharacterSecrets():void
    {
        var flox:FloxInterface=new FloxCommand();
        var secretsData:Object=flox.getSyetemData("secrets");
        var charts:Array=Config.characters;
        var secrets:Object=new Object();

        for(var i:uint=0;i<charts.length;i++)
        {
            //every character
            var chname:String=charts[i];

            var allAns:Array=new Array();
            for(var id:String in secretsData)
            {
                //secrets id
                var anslist:Array=praseSecretAnswer(secretsData[id]);
                var secretsObj:Object=new Object();
                secretsObj.id=id;
                secretsObj.ans=anslist[i];
                allAns.push(secretsObj);
            }
            secrets[chname]=allAns;
        }

        var savegame:SaveGame=FloxCommand.savegame;
        savegame.secrets=secrets;
        FloxCommand.savegame=savegame;
    }
    private function praseSecretAnswer(secrets:Object):Array
    {
        var ran_anslist:Array=new Array();
        var ans:String=secrets.ans;
        var anslist:Array=ans.split(",");
        var maxTimes:Number=anslist.length
        for(var i:uint=0;i<maxTimes;i++)
        {
            var index:uint=uint(Math.random()*anslist.length)
            var ran_ans:String=anslist[index];
            //DebugTrace.msg("DataContainer.praseSecretAnswer ran_ans:"+ran_ans);
            ran_anslist.push(ran_ans);
            var _anslist:Array=anslist.splice(index)
            //DebugTrace.msg("DataContainer.praseSecretAnswer _anslist:"+_anslist);
            //DebugTrace.msg("DataContainer.praseSecretAnswer anslist:"+anslist);
            _anslist.shift();
            anslist=anslist.concat(_anslist);
            //DebugTrace.msg("DataContainer.praseSecretAnswer anslist:"+anslist);
        }
        //for
        //DebugTrace.msg("DataContainer.praseSecretAnswer sortedStr:"+ran_anslist);

        return ran_anslist;
    }
    public static function getFacialMood(name:String):String
    {
        var moodStep:Object=Config.moodStep;
        var ch:String=name.toLowerCase();
        var facial:String="";
        var flox:FloxInterface=new FloxCommand();
        var moodObj:Object=flox.getSaveData("mood");
        var mood:Number=moodObj[ch];
        DebugTrace.msg("DataContainer.getFacialMood mood:"+mood);
        if(mood<=moodStep["sad-Max"])
        {
            facial="sad";
        }
        else if(mood>moodStep["angry-Min"] && mood<=moodStep["angry-Max"])
        {
            facial="angry";
        }
        else if(mood>=moodStep["sick-Min"]  && mood<=moodStep["sick-Max"])
        {
            facial="sick";
        }
        else if(mood>=moodStep["bored-Min"] && mood<=moodStep["bored-Max"])
        {
            facial="bored";
        }
        else if(mood>=moodStep["normal-Min"] && mood<=moodStep["normal-Max"])
        {
            facial="normal";
        }
        else if(mood>=moodStep["pleasant-Min"] && mood<=moodStep["pleasant-Max"])
        {
            facial="pleasant";
        }
        else if(mood>=moodStep["vhappy-Min"] && mood<=moodStep["vhappy-Max"])
        {
            facial="vhappy";
        }
        else if(mood>=moodStep["scared-Min"] && mood<=moodStep["scared-Max"])
        {
            facial="scared";
        }else if(mood>=moodStep["blush-Min"]){
            facial="blush";
        }
        return  facial;
    }
    public static function acceptGift(item_id:String):Boolean{

        //"consumable","misc","fashion","fuxury"
        var success:Boolean=false;
        var dating:String=DataContainer.currentDating;
        var flox:FloxInterface=new FloxCommand();
        var pts:Number=flox.getSaveData("pts")[dating];
        var assets:Object=flox.getSyetemData("assets");
        var cate:String=assets[item_id].cate;
        var relStep:Object=Config.relationshipStep;

        switch(cate){
            case "consumable":
                    if(pts>=relStep["acquaintance-Min"]){

                        success=true;
                    }
                break
            case "misc":
                    if(pts>=relStep["friend-Min"]){
                        success=true;
                    }
                break
            case "fashion":
                if(pts>=relStep["closefriend-Min"]){
                    success=true;
                }
                break
            case "luxury":
                if(pts>=relStep["datingpartner-Min"]){
                    success=true;
                }
                break

        }

        return success




    }
    public static function get getLikseSorted():Array
    {
        return sortedlikes;

    }
    public static function set currentDating(name:String):void
    {

        dating=name;
    }
    public static function get currentDating():String
    {

        return dating;
    }
    public static function set currentDateIndex(obj:Object):void
    {
        dateIndex=obj;
    }
    public static function get currentDateIndex():Object
    {
        return dateIndex;
    }
    public static  function set scheduleListbrary(data:Array):void
    {
        schedulelist=data;

    }
    public static  function get scheduleListbrary():Array
    {
        return schedulelist;

    }
    public static function set stonesList(list:Array):void
    {
        stones=list;
    }
    public static function get stonesList():Array
    {
        return stones;
    }
    public static function set survivePlayer(list:Array):void
    {
        surviveplayer=list;
    }
    public static function get survivePlayer():Array
    {
        return surviveplayer;
    }
    public static function set cpuMainTeam(teams:Array):void
    {
        cpu_main_team=teams;

    }
    public static function get cpuMainTeam():Array
    {
        return cpu_main_team;

    }
    /*public static function set playerMainTeam(teams:Array):void
     {
     player_main_team=teams;
     }
     public static function get playerMainTeam():Array
     {
     return player_main_team;
     }*/
    public static function set PlayerPower(powers:Array):void
    {
        player_powers=powers;
    }
    public static function get PlayerPower():Array
    {
        return player_powers;
    }
    public static function set MembersEffect(eff:Object):void
    {
        memberseffect=eff;
    }
    public static function get MembersEffect():Object
    {
        return memberseffect;

    }
    public static function set MembersMail(arr:Array):void
    {
        members_mail=arr;
    }
    public static function get MembersMail():Array
    {
        return members_mail;
    }
    public static function set currentPower(power:Object):void
    {
        _current_power=power;
    }
    public static function get currentPower():Object
    {
        return _current_power;
    }
    public static function set healArea(area:Array):void
    {

        _healArea=area;
    }
    public static function get healArea():Array
    {

        return _healArea;
    }
    public static function set stageID(value:Number):void
    {
        _stageID=value;
    }
    public static function get stageID():Number
    {
        return _stageID;
    }
    public static function set setCputID(value:Number):void
    {
        cpuID=value;
    }
    public static function get setCputID():Number
    {
        return  cpuID;
    }
    public static function set skillsLabel(list:Array):void
    {
        skills=list;
    }
    public static function get skillsLabel():Array
    {
        return skills;
    }
    public static function set BatttleScene(name:String):void
    {
        //Story , Arena
        _battleScene=name;
    }
    public static function get BatttleScene():String
    {
        return _battleScene;
    }
    public static  function set battleCode(code:String):void
    {
        battlecode=code;
    }
    public static  function get battleCode():String
    {
        return battlecode;
    }
}
}