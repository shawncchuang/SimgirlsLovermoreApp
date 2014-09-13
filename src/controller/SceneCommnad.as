package controller
{


import data.Config;

import flash.desktop.NativeApplication;
import flash.events.MouseEvent;
import flash.geom.Point;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;

import model.SaveGame;
import model.Scenes;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.BlendMode;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.filters.ColorMatrixFilter;
import starling.textures.Texture;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.FilterManager;
import utils.ViewsContainer;

import views.CharacterBubble;
import views.ClickMouseIcon;
import views.MyTalkingDisplay;
import views.PhotoMessage;

public class SceneCommnad implements SceneInterface
{
    private var flox:FloxInterface=new FloxCommand();
    private var scene:String;
    private var scene_sprite:Sprite;
    private var display_container:Object=new Object();
    private var talks:Array;
    private var end_index:Number;
    private var player_library:Array=new Array();
    private var _target:Sprite=null;
    private var part_index:Number=0;
    private var talk_index:Number=0;
    private var talking:Array;
    private var talkmask:MyTalkingDisplay=null;
    private var talkfield:MyTalkingDisplay;
    private var command:MainInterface=new MainCommand();
    private var com_content:String=new String();
    private var character:Image;

    private var hitArea:Image;

    private var clickmouse:ClickMouseIcon=null;
    private var ch_pos:Object={"center":new Point(330,0),"left":new Point(-54,0),"right":new Point(650,0)};
    private var bubble:CharacterBubble=null;
    private var spbubble_pos:Object={"spC":new Point(278,235),"spL":new Point(480,440),"spR":new Point(580,235)};
    private var thbubble_pos:Object={"thC":new Point(278,235),"thL":new Point(480,440),"thR":new Point(580,235)};
    private var shbubble_pos:Object={"shC":new Point(278,235),"shL":new Point(480,440),"shR":new Point(580,235)};
    private var moving_tween:Tween;
    private var fishedcallback:Function;
    private var photoframe:PhotoMessage=null;
    //private var background:MovieClip=null;
    private var background:Sprite;
    private var bgSprtie:Image;
    private var scene_container:Sprite
    private var day:String;
    private var switchID:String="";
    private var location:String="";
    private var part:Number=0;

    public function init(current:String,target:Sprite,lbr_part:Number,finshed:Function=null):void
    {

        switchID=flox.getSaveData("current_switch");
        currentSwitch=switchID;
        scene_sprite=ViewsContainer.currentScene;
        talk_index=0;
        scene=current;
        display_container=new Object();
        fishedcallback=finshed;

        _target=target;
        part_index=lbr_part;



        talks=new Array();

        // DebugTrace.msg("SceneCommand.init talks:"+talks);


        datingComCloudHandle();
    }
    private function datingComCloudHandle():void
    {


        var library:Array=flox.getSyetemData("scenelibrary");
        talks=library[part_index];
        DebugTrace.msg("SceneCommand.datingComCloudHandle library["+part_index+"]:"+talks);

        var dating:String=flox.getSaveData("dating");
        DebugTrace.msg("SceneCommand.datingComCloudHandle dating="+dating);
        if(dating!="")
        {
            if(scene.indexOf("Scene")!=-1 && talks.indexOf("choice|ComCloud_R1_Start^Dating")==-1)
            {
                //at any scene

                talks.unshift("choice|ComCloud_R1_Start^Dating");
                var rIndex:Number=0;

                for(var j:uint=0;j<talks.length;j++){

                    if(talks[j]!="END"){

                        var dir:String=talks[j].split("_")[1];

                        if(dir.charAt(0)=="R"){
                            rIndex++;
                            talks[j]=talks[j].split(dir).join("R"+rIndex);
                        }

                    }
                }
            }
        }else{

            if(talks.indexOf("choice|ComCloud_R1_Start^Dating")!=-1){
                rIndex=0;
                talks.shift();

                for(var k:uint=0;k<talks.length;k++){

                    if(talks[k]!="END"){

                        dir=talks[k].split("_")[1];

                        if(dir.charAt(0)=="R"){
                            rIndex++;
                            talks[k]=talks[k].split(dir).join("R"+rIndex);
                        }

                    }
                }

            }
        }
        DebugTrace.msg("SceneCommand.datingHandle talks:"+talks);


    }
    public function start():void
    {
        addTouchArea();
        showChat();

    }
    private function addTouchArea():void
    {


        var texture:Texture=Assets.getTexture("Whitebg");

        //hitArea=new Button(texture);

        hitArea=new Image(texture);
        //hitArea.useHandCursor=true;
        //hitArea.name="hitArea";
        hitArea.width=Starling.current.stage.stageWidth;
        hitArea.height=Starling.current.stage.stageHeight;
        hitArea.alpha=0;
        scene_sprite.addChild(hitArea)
        //hitArea.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);

        scene_sprite.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
    }

    private function onChatSceneTouched(e:TouchEvent):void
    {

        var target:Sprite=e.currentTarget as Sprite;
        //DebugTrace.msg("SceneCommand.onChatSceneTouched name:"+target.name);

        var BEGAN:Touch = e.getTouch(target, TouchPhase.BEGAN);
        if(BEGAN)
        {
            onTouchedScene();
        }


    }
    public function onTouchedScene():void
    {
        talk_index++;
        DebugTrace.msg("SceneCommand.onChatSceneTouched talk_index:"+talk_index);
        end_index=talks.indexOf("END");
        if(talk_index<end_index)
        {
            if(bubble)
            {
                _target.removeChild(bubble);
                bubble=null;
            }
            //if
            showChat();
        }
        else
        {
            //finish
            doClearAll();
            DebugTrace.msg("SceneCommand finished");
            //_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
            disableAll();
            fishedcallback();
        }
        //if

    }
    private function showChat():void
    {
        trace("SceneCommand.showChat talk_index=",talk_index)
        com_content=talks[talk_index];
        DebugTrace.msg("SceneCommand.showChat com_content:"+com_content);
        var comlists:Array=com_content.split("|");
        var todo:String=comlists[0];
        if(todo!="player")
        {

            _target.removeChild(talkmask);
            talkmask=null;
        }
        try
        {
            _target.removeChild(talkfield);
        }
        catch(e:Error){

        }
        switch(todo)
        {
            case "player":
                creartePlayerChat();
                break
            case "com":
                commandHandle();
                break
            case "spC":
            case "spL":
            case "spR":
                createBubble(comlists);
                break
            case "thC":
            case "thL":
            case "thR":
                createBubble(comlists);
                break
            case "choice":
                addDisplayContainer(comlists[1]);
                break
        }

        if(scene.indexOf("Scene")==-1)
        {
            //not form map scene
            clearMouseClickIcon();
            createMouseClickIcon();
        }

    }
    public function createMouseClickIcon():void
    {
        //DebugTrace.msg("SceneCommand.createMouseClickIcon");
        clickmouse=new ClickMouseIcon();
        clickmouse.x=973;
        clickmouse.y=704;
        _target.addChild(clickmouse);
    }
    public function clearMouseClickIcon():void
    {
        //DebugTrace.msg("SceneCommand.clearMouseClickIcon");
        if(clickmouse)
        {
            _target.removeChild(clickmouse);
            clickmouse=null;
        }

    }

    private function creartePlayerChat():void
    {



        var sentence:String=com_content.split("player|").join("")
        talks[talk_index]=sentence;
        talking=command.filterTalking(talks);
        //DebugTrace.msg("TarotreadingScene.creartePlayerChat talking:"+talking);

        //_target.removeChild(talkfield);

        if(!talkmask)
        {
            talkmask=new MyTalkingDisplay();
            _target.addChild(talkmask);
            talkmask.addMask();

            try
            {
                _target.swapChildren(talkmask,photoframe)
            }
            catch(e:Error){

            }
        }
        //if
        createTalkField();



    }

    private function createTalkField():void
    {
        talkfield=new MyTalkingDisplay();
        talkfield.addTextField(talking[talk_index])
        _target.addChild(talkfield);
        display_container.player=talkfield;
    }

    private function commandHandle():void
    {
        var commands:Array=com_content.split(",");
        for(var i:uint=0;i<commands.length;i++)
        {
            var actions:Array=commands[i].split("|");
            var act:String=actions[1];
            var todo:String=act.split("_")[0];
            var target:String=act.split("_")[1];
            var pos:String="";
            if(act.split("_").length==3)
            {
                pos=act.split("_")[2];
            }
            //if
            switch(todo)
            {
                case "remove":
                    if(target=="player")
                    {
                        _target.removeChild(talkmask);
                        talkmask=null;
                    }
                    _target.removeChild(display_container[target]);
                    display_container[target]=null;
                    break
                case "display":
                    createCharacter(target,pos)
                    break
                case "move":
                    movingCharacter(target,pos)
                    break
                case "photo-on":
                    createPhotoMessage(target);
                    break
                case "photo-off":
                    if(photoframe)
                    {
                        onPhotoRemoved();
                    }
                    break
                case "music-on":
                    command.playBackgroudSound(target);
                    break
                case "music-off":
                    command.stopBackgroudSound();
                    break
                case "sfx":
                    command.playSound(target);
                    break
                case "video":
                    displayVideo(target);
                    break
                case "bg":
                    createBackground(target);
                    break
            }
            //switch
        }
        //for
        if(todo!="video")
        {
            talk_index++;
            showChat();
        }
        //if
        if(photoframe)
        {
            if(talkmask)
            {
                _target.swapChildren(talkmask,photoframe);
                //_target.swapChildren(talkmask,hitArea);
            }
            else if(bubble)
            {
                _target.swapChildren(bubble,photoframe);
            }
            //if
        }
        //if
    }
    public function createCharacter(name:String,p:String):void
    {

        DebugTrace.msg("SceneCommand.createCharacter :"+name);


        var npc:String="";
        if(Config.characters.indexOf(name)!=-1){

            //character
            var style:String=DataContainer.styleSechedule[name];
            var texture:Texture=Assets.getTexture(style);

        }else{

            //NPC
            style=Config.NPC[name];
            var texture:Texture=Assets.getTexture(style);

        }

        character=new Image(texture);
        character.name=name;
        character.alpha=0;
        character.x=ch_pos[p].x;
        character.y=ch_pos[p].y;
        _target.addChild(character);
        display_container[name]=character;


        var tween:Tween=new Tween(character,2,Transitions.EASE_OUT);
        tween.animate("alpha",1);
        tween.onComplete=onCharacterDisplayed;
        Starling.juggler.add(tween);


    }
    private function onCharacterDisplayed():void
    {
        Starling.juggler.removeTweens(character);
    }
    public function createBubble(comlists:Array):void
    {



        var _pos:String=comlists[0];
        DebugTrace.msg("SceneCommand.createBubble talk_index:"+talk_index+" ; _pos:"+_pos+" ; scene:"+scene);
        var dir:Number=1;
        var bubble_pos:Object;
        if(_pos.indexOf("sp")!=-1)
        {
            bubble_pos=spbubble_pos;
        }
        else if(_pos.indexOf("th")!=-1)
        {
            bubble_pos=thbubble_pos;
        }

        if(_pos.indexOf("L")!=-1)
        {
            dir=-1;
        }
        var new_pos:Point=new Point(bubble_pos[_pos].x,bubble_pos[_pos].y);
        bubble=new CharacterBubble(scene,talk_index,part_index,new_pos,dir);
        bubble.x=new_pos.x;
        bubble.y=new_pos.y;
        _target.addChild(bubble);

    }
    public function movingCharacter(target:String,dir:String):void
    {
        DebugTrace.msg("ChatCommand.movingCharacter target:"+target+" ;dir:"+dir);
        var current_ch:Image=display_container[target]
        moving_tween=new Tween(current_ch,0.5,Transitions.EASE_OUT);
        moving_tween.animate("x",ch_pos[dir].x);
        moving_tween.onComplete=onMovingComplete
        Starling.juggler.add(moving_tween)

    }
    private function onMovingComplete():void
    {
        Starling.juggler.remove(moving_tween);
    }
    private function createPhotoMessage(target:String):void
    {
        DebugTrace.msg("ChatCommand.createPhotoMessage")
        photoframe=new PhotoMessage(target,onPhotoRemoved);
        photoframe.name="photoframe"
        photoframe.x=Starling.current.stage.stageWidth/2;
        photoframe.y=Starling.current.stage.stageHeight/2;

        _target.addChild(photoframe);


        //swapHitAreaTouch(0)



    }
    private function onPhotoRemoved():void
    {
        _target.removeChild(photoframe);
        photoframe=null;
        //swapHitAreaTouch(1)
    }
    /*
     private function swapHitAreaTouch(id:Number):void
     {

     if(id==0)
     {
     _target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
     hitArea.addEventListener(Event.TRIGGERED,onHitAreaTouched);
     }
     else
     {
     _target.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
     hitArea.removeEventListener(Event.TRIGGERED,onHitAreaTouched);
     }

     }
     */
    private function onHitAreaTouched(e:Event):void
    {
        var target:Button=e.currentTarget as Button;
        DebugTrace.msg("SceneCommand.onHitAreaTouched name:"+target.name);
        onTouchedScene();

    }
    private function displayVideo(src:String):void
    {
        //DebugTrace.msg("SceneCommand.displayVideo src:"+src);
        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvent._name="show_video";
        gameEvent.video=src;
        gameEvent.displayHandler();
        command.stopBackgroudSound();
        //_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
        //NativeApplication.nativeApplication.removeEventListener(MouseEvent.MOUSE_DOWN,onChatSceneTouched);
        disableAll();
    }

    public function addDisplayContainer(src:String):void
    {
        DebugTrace.msg("SceneCommand.addDisplayContainer src:"+src+" ; scene:"+scene);
        command.addDisplayObj(scene,src);
        if(_target)
        {
            //_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
            //disableAll();
            var src_index:Number=src.indexOf("ComCloud");
            //DebugTrace.msg("SceneCommand.addDisplayContainer src_index:"+src_index);
            var scene_index:Number=scene.indexOf("Scene");

            if(scene!="Story")
            {
                if(src_index==-1 || scene.indexOf("Scene")!=-1)
                {
                    onTouchedScene();
                }
            }
            else
            {
                disableAll();
                //onTouchedScene();
            }
            //if
        }

    }
    public function enableTouch():void
    {
        DebugTrace.msg("SceneCommand.enableTouch ");
        //_target.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
        NativeApplication.nativeApplication.addEventListener(MouseEvent.MOUSE_DOWN,onChatSceneTouched);
        onTouchedScene();

    }
    private var filter:FilterInterface=new FilterManager();
    private var bgSrc:String="";
    public function createBackground(src:String):void
    {
        location=src;
        var scene:Sprite=ViewsContainer.MainScene;
        scene_container=scene.getChildByName("scene_container") as Sprite;

        var savedata:SaveGame=FloxCommand.savegame;
        var dateStr:String=savedata.date.split("|")[1];
        day="Day";
        if(dateStr=="24")
        {
            //night
            day="Night";
        }
        bgSrc=src;

        /*
         if(background)
         {
         background.removeFromParent(true);
         background=null;
         //scene_container.removeChild(background);
         }
         */
        try
        {
            bgSprtie.removeFromParent(true);

        }catch(e:Error){
            DebugTrace.msg("SceneCommand.createBackground remove bgSprtie Error");
        }
        // background= new Sprite();

        //background=Assets.getDynamicAtlas(src);
        //background.stop();
        //scene_container.addChild(background);


        onBackgroundComplete();
    }
    public function filterBackground():void
    {
        filter.setSource(background);
        filter.setBulr();

    }
    private function onBackgroundComplete():void
    {


        if(bgSrc.indexOf("Scene")!=-1){
            bgSrc=bgSrc.split("Scene").join("Bg");
        }
        else{
            bgSrc="Bg";
        }

        DebugTrace.msg("SceneCommand.createBackground bgSrc="+bgSrc);


        if(scene=="Story")
        {
            /*
             if(location=="hotel" || location=="park" || location=="beach" || location=="pier" || location=="lovemoremansion")
             {
             var bg_scene:String=bgSrc.split("Scene").join("").toLowerCase();
             trace("SceneCommand.onBackgroundComplete bgSrc="+bgSrc)
             if(bg_scene!=location)
             {
             bgTexture=Assets.getTexture(bgSrc);
             }
             else
             {
             bgTexture=Assets.getTexture(bgSrc+day);
             }
             //if
             bgSprtie=new Image(bgTexture);
             scene_container.addChild(bgSprtie);
             }
             //if
             */
            praseSceneDayNight();
        }
        else{
            praseSceneDayNight()

        }

        if(bgSrc=="ChangeFormationBg"){

            bgSrc="NormalBg";
        }

        var bgTexture:Texture=Assets.getTexture(bgSrc);
        bgSprtie=new Image(bgTexture);
        scene_container.addChild(bgSprtie);

        function praseSceneDayNight():void{

            switch(location){
                case "HotelScene":
                case "ParkScene":
                case "BeachScene":
                case "PierScene":
                case "LovemoreMansionScene":
                case "GardenScene":
                    bgSrc=(bgSrc+day);
                    break
            }

        }





    }
    public function doClearAll():void
    {
        for(var i:String in display_container)
        {
            if(display_container)
            {
                _target.removeChild(display_container[i]);
            }
            //if
        }
        //for
        if(bubble)
        {
            _target.removeChild(bubble);
        }

    }
    public function disableAll():void
    {
        //trace("SceneCommand.disableAll")
        //hitArea.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
        try
        {
            scene_sprite.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
        }
        catch(e:Error)
        {
            DebugTrace.msg("SceneCommand.disableAll scene_sprite NUll");
        }
        try
        {
            scene_sprite.removeChild(hitArea)
        }
        catch(e:Error)
        {
            DebugTrace.msg("SceneCommand.disableAll hitArea NUll");
        }
        //_target.removeChild(hitArea)
    }

    public function set currentSwitch(id:String):void
    {
        switchID=id.split("|")[0];
    }
    public function get currentSwitch():String
    {
        return switchID.split("|")[0];
    }
    public function switchGateway(type:String ,callback:Function=null):*
    {

        var flox:FloxInterface=new FloxCommand();
        switchID=flox.getSaveData("current_switch").split("|")[0];

        var next_switch:String=flox.getSaveData("next_switch");
        DebugTrace.msg("SceneCommand.switchGateway switchID="+switchID);
        DebugTrace.msg("SceneCommand.switchGateway next_switch="+next_switch);
        switchID=next_switch;
        var switchs:Object=flox.getSyetemData("switchs");
        scene=DataContainer.currentScene;
        var value:Object=switchs[switchID];
        var _scene:String=scene.split("Scene").join("").toLowerCase();
        location=value.location;


        var verify:Boolean=false;
        var local_verify:Boolean=false;
        var date_verify:Boolean=false;
        var time_verify:Boolean=false;
        var date:String=flox.getSaveData("date");
        var switch_date:String=value.date;
        var switch_time:String=String(value.time);

        //------------Local------------------------------------------
        if(location!="")
        {
            if(_scene==location)
            {
                local_verify=true;
                var turn_switch:String=flox.getSaveData("current_switch").split("|")[1];
                //trace("SceneCommand.switchGateway turn_switch="+turn_switch);
            }
        }
        else
        {
            local_verify=true;
        }
        //if
        //------------Date------------------------------------------
        if(switch_date!="")
        {
            //should check date and time
            var _date:String=date.split("|")[0];
            var _day:Number=Number(_date.split(".")[1]);
            var _month:String=_date.split(".")[2];
            var switch_day:Number=Number(switch_date.split(".")[1]);
            var switch_mon:String=switch_date.split(".")[2];
            trace("SceneCommand.switchGateway _day="+_day);
            trace("SceneCommand.switchGateway switch_day="+switch_day);
            if(switch_day==Number(_day) && switch_mon==_month)
            {

                date_verify=true;
            }

        }
        else
        {
            date_verify=true;
        }
        //if
        //--------------Time----------------------------------------
        if(switch_time!="")
        {

            var _time:Number=Number(date.split("|")[1]);

            if(Number(switch_time)==_time)
            {
                time_verify=true;
            }
            //if
        }
        else
        {
            time_verify=true;
        }
        //if
        //------------------------------------------------------
        DebugTrace.msg("SceneCommand.switchGateway date_verify="+date_verify+",time_verify="+time_verify+
                ",local_verify="+local_verify);

        if(date_verify && time_verify && local_verify)
        {
            verify=true;
            ViewsContainer.gameinfo.visible=false;

            clearCommandCloud();
            doClearAll();
            part=Number(switchID.split("s").join(""))-1;
            initStory(callback);

        }
        // verify: math switch  ;  !verify:no match switch
        if(type=="Rest||Stay")
        {
            if(date_verify && time_verify)
            {

                verify=true;
                updateCurrentSwitch();
            }

        }
        return [verify,date_verify,time_verify,local_verify]
    }
    private function updateCurrentSwitch():void
    {

        var switchs:Object=flox.getSyetemData("switchs");
        var value:Object=switchs[switchID];
        var result:Object=value.result;
        var turn_on_id:String=result.on;
        var turn_off_id:String=result.off;
        var current_switch:String=""
        if(turn_off_id!="")
        {
            current_switch=turn_off_id+"|off";

        }
        if(turn_on_id!="")
        {
            current_switch=turn_on_id+"|on";

        }
        currentSwitch=current_switch;
        flox.save("current_switch",current_switch);
    }
    private var switchIDlist:Array;
    public function initStory(finshed:Function=null):void
    {
        _target=scene_sprite;
        talk_index=0;
        scene="Story";
        display_container=new Object();
        fishedcallback=onStoryFinished;

        part_index=part;
        var library:Array=flox.getSyetemData("main_story");
        talks=library[part_index];

        var switchs:Object=flox.getSyetemData("switchs");
        switchIDlist=new Array();
        for(var id:String in switchs)
        {
            switchIDlist.push(id);
        }
        switchIDlist.sort();

    }
    public function onStoryFinished():void
    {
        DebugTrace.msg("SceneCommand.onStoryComplete switchIDlist="+switchIDlist);

        var next_switch:String="";
        //var current_switch:String=flox.getSaveData("current_switch").split("|")[0];
        switchID=flox.getSaveData("next_switch").split("|")[0];


        var current_index:Number=switchIDlist.indexOf(switchID);
        current_index++;
        if(current_index<switchIDlist.length)
        {
            next_switch=switchIDlist[current_index];
        }
        DebugTrace.msg("SceneCommand.onStoryComplete switchID="+switchID);
        DebugTrace.msg("SceneCommand.onStoryComplete next_switch="+next_switch);

        flox.save("next_switch",next_switch,onUpdatedNextSwitch);

        disableAll();
        var _data:Object=new Object();
        _data.name=DataContainer.currentScene;
        command.sceneDispatch(SceneEvent.CHANGED,_data);
        ViewsContainer.gameinfo.visible=true;
    }
    private function onUpdatedNextSwitch():void
    {
        updateCurrentSwitch();
    }
    private function clearCommandCloud():void
    {

        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvent._name="clear_comcloud";
        gameEvent.displayHandler();
    }
}
}