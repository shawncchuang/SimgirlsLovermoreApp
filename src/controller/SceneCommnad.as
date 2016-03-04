/**
 * Created by shawnhuang
 */
package controller {
import com.greensock.loading.LoaderMax;

import data.Config;
import data.DataContainer;
import data.StoryDAO;
import data.TwinDAO;

import events.GameEvent;
import events.SceneEvent;
import events.TopViewEvent;


import flash.geom.Point;

import starling.animation.DelayedCall;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.DrawManager;
import utils.FilterManager;

import utils.ViewsContainer;

import views.CharacterBubble;

import views.ClickMouseIcon;
import views.MenuScene;

import views.MyTalkingDisplay;
import views.PhotoMessage;

public class SceneCommnad implements SceneInterface
{
    private var flox:FloxInterface=new FloxCommand();
    public static var scene:String;
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
    private var hitArea:Sprite;

    private var clickmouse:ClickMouseIcon=null;
    private var ch_pos:Object={"center":new Point(330,0),"left":new Point(-54,0),"right":new Point(650,0)};
    private var bubble:CharacterBubble=null;
    private var spbubble_pos:Object={"spC":new Point(278,235),"spL":new Point(480,440),"spR":new Point(580,235)};
    private var thbubble_pos:Object={"thC":new Point(278,235),"thL":new Point(480,440),"thR":new Point(580,235)};
    private var shbubble_pos:Object={"shC":new Point(278,235),"shL":new Point(480,440),"shR":new Point(580,235)};
    private var moving_tween:Tween;
    private var onCompleteCallback:Function;
    private var photoframe:PhotoMessage=null;
    //private var background:MovieClip=null;
    private var background:Sprite;
    private var bgSprite:Sprite;
    private var scene_container:Sprite;
    private var day:String;
    private var switchID:String="";
    private var current_switch:String="";
    private var location:String="";
    private var part:Number=0;
    private var filter:FilterInterface=new FilterManager();
    private var bgSrc:String="";
    public static var disable_story:Boolean=false;
    private var delaycall:DelayedCall;
    private var XAltImag:Image=null;
    private var storyverify:Array=new Array();

    public function set currentSwitch(id:String):void
    {
        switchID=id.split("|")[0];
    }
    public function get currentSwitch():String
    {
        return switchID.split("|")[0];
    }
    public function init(current:String,target:Sprite,lbr_part:Number,complete:Function=null):void {
        switchID=flox.getSaveData("current_switch");
        currentSwitch=switchID;
        scene_sprite=ViewsContainer.currentScene;
        talk_index=0;
        scene=current;
        display_container=new Object();
        onCompleteCallback=complete;

        _target=target;
        part_index=lbr_part;



        talks=new Array();

        // DebugTrace.msg("SceneCommand.init talks:"+talks);

        if(MenuScene.iconsname.indexOf(current)==-1 && current!="MenuScene"){
            datingComCloudHandle();

        }

        scene_sprite.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
    }
    private function doTopViewDispatch(e:Event):void{
        switch(e.data.removed)
        {
            case "Choice":
                enableTouch();
                break


        }

    }
    public function reseat():void{
        switchID=flox.getSaveData("current_switch");
        currentSwitch=switchID;
        talk_index=0;
        talks=new Array();
    }
    private function datingComCloudHandle():void
    {

        var library:Array=flox.getSyetemData("scenelibrary");
        talks=library[part_index];
        DebugTrace.msg("SceneCommand.datingComCloudHandle library["+part_index+"]:"+talks);

        var dating:String=flox.getSaveData("dating");
        DebugTrace.msg("SceneCommand.datingComCloudHandle dating="+dating);
        if(dating!="" && scene!="ChangeFormationScene")
        {
            if(scene.indexOf("Scene")!=-1 && talks.indexOf("choice|ComCloud_R1_Start^Dating")==-1)
            {
                //at any scene

                var _bg:String=talks[0];
                talks.shift();

                var rIndex:Number=1;

                for(var j:uint=0;j<talks.length;j++){

                    if(talks[j]!="END"){

                        var dir:String=talks[j].split("_")[1];

                        if(dir.charAt(0)=="R"){
                            rIndex++;
                            talks[j]=talks[j].split(dir).join("R"+rIndex);
                        }

                    }
                }

                talks.unshift("choice|ComCloud_R1_Start^Dating");
                talks.unshift(_bg);

            }
        }else{

            if(talks.indexOf("choice|ComCloud_R1_Start^Dating")!=-1){
                rIndex=0;
                _bg=talks[0];
                var datingIndex:Number=talks.indexOf("choice|ComCloud_R1_Start^Dating");
                var _talks:Array=talks.splice(datingIndex);
                _talks.shift();
                talks=talks.concat(_talks);

                for(var k:uint=0;k<talks.length;k++){

                    if(talks[k]!="END"){

                        dir=talks[k].split("_")[1];

                        if(dir.charAt(0)=="R"){
                            rIndex++;
                            talks[k]=talks[k].split(dir).join("R"+rIndex);
                        }

                    }

                }

//                if(talks.indexOf("choice|ComCloud_R2_Look^Around")!=-1){
//                    var comStr:String="choice|ComCloud_R2_Look^Around";
//                    var index:Number=talks.indexOf(comStr);
//                    talks[index]=String(comStr.split("R2").join("R1"));
//                }
//
//                if(talks.indexOf("choice|ComCloud_R3_^Leave")!=1){
//                    comStr="choice|ComCloud_R3_^Leave";
//                    index=talks.indexOf(comStr);
//                    talks[index]=String(comStr.split("R3").join("R2"));
//                }

            }

        }
        library[part_index]=talks;
        DebugTrace.msg("SceneCommand.datingHandle talks:"+talks);


    }
    public function start():void
    {
        command.removeShortcuts();
        showChat();
        if(scene!="CharacterDesignScene"){

            var comcloud:Boolean=chechComCloudIn();
            var boss:Boolean=checkBossIn();
            var twinflameSel:Boolean=checkTwinflame();
            if(storyverify[0] && !comcloud && !XAltImag && !boss && !twinflameSel){
                addSkipButton();
            }

        }

        addTouchArea();
    }
    private function chechComCloudIn():Boolean{

        var comcloud:Boolean=false;
        for(var i:uint=0;i<talks.length;i++){

            if(talks[i].indexOf("ComCould")!=-1){
                comcloud=true;
                break
            }
        }
        return comcloud;
    }
    private function checkBossIn():Boolean{
        var boss:Boolean=false;
        var current_switch:String=flox.getSaveData("current_switch");
        var dangersScenes:Object=Config.dangersScenes;
        if(dangersScenes[current_switch]){
            boss=true;
        }
        return boss;
    }
    private function checkTwinflame():Boolean{
        var twinflame:Boolean=false;
        var current_switch:String=flox.getSaveData("current_switch");
        var current_switchID:String=current_switch.split("|")[0];
       if(current_switchID=="s051"){
           twinflame=true;
       }
        return twinflame;
    }

    private function addSkipButton():void{

        var texture:Texture=Assets.getTexture("XAltUp");
        XAltImag=new Image(texture);
        XAltImag.x=Starling.current.stage.stageWidth-XAltImag.width-5;
        XAltImag.y=5;
        XAltImag.addEventListener(TouchEvent.TOUCH,onSkipTouched);
        Starling.current.stage.addChild(XAltImag);

    }
    private function onSkipTouched(e:TouchEvent):void{
        var BEGAN:Touch = e.getTouch( Starling.current.stage, TouchPhase.BEGAN);
        if(BEGAN){


            var mainstage:Sprite=ViewsContainer.MainScene;
            mainstage.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);

            talk_index=talks.indexOf("END")-1;
            onTouchedScene();
        }

    }

    public function addTouchArea():void
    {
        DebugTrace.msg("SceneCommand.addTouchArea");

        //Starling.current.stage.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
        var mainstage:Sprite=ViewsContainer.MainScene;
        mainstage.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);

    }

    private function onChatSceneTouched(e:TouchEvent):void
    {

        var BEGAN:Touch = e.getTouch( Starling.current.stage, TouchPhase.BEGAN);
        // var HOVER:Touch = e.getTouch( Starling.current.stage, TouchPhase.HOVER);
        if(BEGAN && BEGAN.target.name !="previousbtn")
        {
            DebugTrace.msg("SceneCommand.onChatSceneTouched talk_index:"+talk_index);
            onTouchedScene();
        }



    }
    private function onTouchedScene():void
    {
        talk_index++;
        end_index=talks.indexOf("END");
        DebugTrace.msg("SceneCommand.onTouchedScene talk_index:"+talk_index+",end_index="+end_index);

        if(talk_index<end_index)
        {
            if(bubble)
            {
                bubble.removeFromParent(true);
                bubble=null;
            }

            showChat();
        }else{

            //finish current part

            try{
                XAltImag.removeEventListeners();
                XAltImag.removeFromParent(true);
            } catch(e:Error){}

            current_switch=flox.getSaveData("current_switch");
            DebugTrace.msg("SceneCommand.onTouchedScene [END] current_switch="+current_switch);
            var prv_talks:String= talks[end_index-1];
            if(prv_talks.indexOf("APOLLYON versus ZEPHON")!=-1 ){
                //Final Battle
                DataContainer.battleType="final_battle";
                updateCurrentSwitch();
                var _data:Object=new Object();
                _data.name="ChangeFormationScene";
                command.sceneDispatch(SceneEvent.CHANGED,_data);

            }else{


                if(scene=="Story"){

                    command.stopBackgroudSound();
                    doClearAll();
                    updateCurrentSwitch();

                }else if(scene=="TwinStory"){
                    command.stopBackgroudSound();
                    doClearAll();
                    //current_switch=flox.getSaveData("current_switch");
                    switchID=current_switch;
                    onStoryComplete();
                }
                else{
                    disableAll();
                }
                if(onCompleteCallback){

                    onCompleteCallback();
                }
            }

        }

    }
    private function showChat():void
    {
        DebugTrace.msg("SceneCommand.showChat talk_index="+talk_index);

        com_content=talks[talk_index];
        DebugTrace.msg("SceneCommand.showChat com_content:"+com_content);
        var comlists:Array=com_content.split("|");
        var todo:String=comlists[0];
        if(todo!="player")
        {

            if(talkmask){
                talkmask.removeFromParent(true);
                talkmask=null;
            }
        }
        if(talkfield)
        {
            talkfield.removeFromParent(true);
            talkfield=null;
        }


        switch(todo)
        {
            case "player":
                creartePlayerChat();
                break
            case "com":
                var com:String=comlists[1];
                var twinflame:String=flox.getSaveData("twinflame");
                var fullname:String=Config.fullnames[twinflame];
                if(com.indexOf("end-photo-on")!=-1 && com.indexOf(fullname)!=-1){
                    talk_index+=3;
                    showChat();
                    return
                }
                commandHandle();
                break
            case "spC":
            case "spL":
            case "spR":
            case "thC":
            case "thL":
            case "thR":
            case "shC":
            case "shL":
            case "shR":
                createBubble(comlists);
                break
            case "choice":
                addDisplayContainer(comlists[1]);
                break
            case "END":

                break
        }

        if(scene.indexOf("Scene")==-1)
        {
            //not form map scene
            clearMouseClickIcon();
            createMouseClickIcon();
        }

    }

    private function commandHandle():void
    {
        //var commandsStr:String=com_content.split("#").toString();
        //var commands:Array=commandsStr.split(",");
        var commands:Array=com_content.split("#");
        for(var i:uint=0;i<commands.length;i++)
        {
            var actions:Array=commands[i].split("|");
            //ex:display_sao_casual1_center
            if(actions.length>1){

                var act:String=actions[1];
                var todo:String=act.split("_")[0];

                var target:String=act.split("_")[1];
                var pos:String="";
                if(act.split("_").length==4)
                {
                    pos=act.split("_")[3];
                }else{
                    pos=act.split("_")[2];
                }

                //if
            }else{
                //END
                todo=actions[0];
            }
            if(todo=="player" || todo=="display"){

                if(act.split("_").length==4)
                    target+="_"+act.split("_")[2];
            }
            if(todo=="move" || todo=="remove"){
                if(act.split("_").length>3){
                    // characters
                    target+="_"+act.split("_")[2];
                }

            }
            if(target)
                target=praseTwinFlameFormat(target);
            switch(todo)
            {
                case "remove":
                    //target=praseTwinFlameFormat(target);
                    if(target=="player") {
                        talkmask.dispose();
                        talkmask.removeFromParent(true);
                        talkmask=null;
                    }
                    if(display_container[target]){
                        var _character:Image= display_container[target];
                        Starling.juggler.removeTweens(_character);
                        _character.dispose();
                        _character.removeFromParent(true);
                        display_container[target]=null;
                    }
                    break
                case "display":
                    //target=praseTwinFlameFormat(target);
                    createCharacter(target,pos);
                    break
                case "move":
                    //target=praseTwinFlameFormat(target);
                    movingCharacter(target,pos);
                    break
                case "photo-on":
                case "twin-photo-on":
                case "end-photo-on":
                    createPhotoMessage(todo,target);
                    break
                case "photo-off":
                case "twin-photo-off":
                    onPhotoRemoved();
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
                case "swf-on":
                    createAnimateEffect(target);
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
            var photoframeIndex:Number=_target.getChildIndex(photoframe);
            var talkmaskeIndex:Number=_target.getChildIndex(talkmask);

            if(talkmask)
            {
                if(photoframeIndex<talkmaskeIndex){
                    _target.swapChildren(talkmask,photoframe);
                }

            }
            else if(bubble)
            {
                _target.swapChildren(bubble,photoframe);
            }
            //if
        }
        //if
    }
    private function creartePlayerChat():void
    {
        createTalkField();
    }
    private function createTalkField():void
    {

        talkfield=new MyTalkingDisplay();
        talkfield.addTextField(talks[talk_index],onTalkingComplete);
        _target.addChild(talkfield);
        display_container.player=talkfield;
    }
    private function onTalkingComplete():void{

        DebugTrace.msg("SceneCommand.onTalkingComplete talk_index="+talk_index);

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
        }else if(_pos.indexOf("sh")!=-1)
        {
            bubble_pos=shbubble_pos;
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
    private function onBubbleComplete():void{

        addTouchArea();
    }
    public function createCharacter(name:String,p:String):void
    {

        DebugTrace.msg("SceneCommand.createCharacter :"+name);

        var npc:String="";
        var texture:Texture;
        var target:String=name.split("_")[0];
        var style:String="";
        if(Config.allCharacters.indexOf(target)!=-1) {

            //character
            //var stylesechdule:Object=DataContainer.styleSechedule;
            //DebugTrace.msg("SceneCommand.createCharacter, style="+stylesechdule.stringify(stylesechdule));
            //var style:String=stylesechdule[name];
            style = name;


        }else{

            //NPC
            style=Config.NPC[name];
        }
        texture=Assets.getTexture(style);
        var _ch_pos:Object=ch_pos;
        if(style=="npc014"){
            _ch_pos={"center":new Point(50.5,0),"left":new Point(0,0),"right":new Point(109,0)};
        }


        var pos:Point=new Point(_ch_pos[p].x,_ch_pos[p].y);
        character=new Image(texture);
        character.name=name;
        character.alpha=0;
        character.pivotX=int(character.width/2);
        setupPosition(p);

        character.y=pos.y;
        _target.addChild(character);
        display_container[name]=character;


        var tween:Tween=new Tween(character,0.2);
        tween.fadeTo(1);
        Starling.juggler.add(tween);


    }
    private  function setupPosition(pos:String):void{

        switch(pos){
            case "center":

                character.x=int(Starling.current.stage.stageWidth/2);
                break
            case "left":
                character.x=int(character.width/2);
                break
            case "right":
                character.x=Starling.current.stage.stageWidth-character.width/2;
                break
        }

        ch_pos[pos]=new Point(character.x,0);
    }

    public function movingCharacter(target:String,pos:String):void
    {
        DebugTrace.msg("SceneCommand.movingCharacter target:"+target+" ;pos:"+pos);
        setupPosition(pos);
        var current_ch:Image=display_container[target];
        moving_tween=new Tween(current_ch,1,Transitions.EASE_OUT);
        moving_tween.animate("x",ch_pos[pos].x);
        moving_tween.onComplete=onMovingComplete;
        Starling.juggler.add(moving_tween);

    }

    private function onMovingComplete():void
    {

        Starling.juggler.remove(moving_tween);
    }
    private function createPhotoMessage(todo:String,target:String):void {
        DebugTrace.msg("SceneCommand.createPhotoMessage");

        photoframe = new PhotoMessage(todo,target);
        photoframe.name = "photoframe";
        _target.addChild(photoframe);

    }

    private function onPhotoRemoved():void
    {
        if(photoframe) {
            photoframe.removeFromParent(true);
            photoframe = null;
        }
    }
    private function displayVideo(src:String):void
    {

//        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
//        gameEvent._name="show_video";
//        gameEvent.video=src;
//        gameEvent.displayHandler();
        command.stopBackgroudSound();
        disableAll();

        var mediaplayer:MediaInterface=new MediaCommand();
        mediaplayer.PlayVideo(src,_target,new Point(1024,768),null,30,"mp4",onVideoComplete);

    }
    private function onVideoComplete():void{


        var current_scene:String=DataContainer.currentScene;
        if(current_scene == "Tarotreading" || current_scene == "AirplaneScene"){
            var _data:Object=new Object();
            if(current_scene=="Tarotreading"){
                _data.name="AirplaneScene";
            }else if(current_scene=="AirplaneScene"){
                _data.name="MainScene";
            }
            command.sceneDispatch(SceneEvent.CHANGED,_data);
        }else{
            addTouchArea();
            talk_index++;
            showChat();
        }

    }
    public function createBackground(src:String):void
    {
        location=src;
//        var _src:String=null;
//        if(DataContainer.currentScene=="Tarotreading" || scene=="Story") {
//            _src=location;
//        }
        var main_scene:Sprite=ViewsContainer.MainScene;
        scene_container=main_scene.getChildByName("scene_container") as Sprite;
        var drawmanager:DrawerInterface=new DrawManager();
        bgSprite=drawmanager.drawBackground(src);
        _target.addChild(bgSprite);

    }
    public function createAnimateEffect(src:String):void{


        DebugTrace.msg("PreviewStoryCommand.createAnimateEffect src="+src);

        var mediacom:MediaInterface = new MediaCommand();
        mediacom.SWFPlayer("transform", "../swf/"+src+".swf", onFinishAnimated);

    }
    private function onFinishAnimated():void{
//        var queue:LoaderMax=ViewsContainer.loaderQueue;
//        queue.empty(true,true);

    }

    public function addDisplayContainer(src:String):void
    {
        DebugTrace.msg("SceneCommand.addDisplayContainer src:"+src+" ; scene:"+scene);
        //preview skip QA
        command.addDisplayObj(scene,src);
        if(_target)
        {

            var src_index:Number=src.indexOf("ComCloud");
            //DebugTrace.msg("SceneCommand.addDisplayContainer src_index:"+src_index);
            var scene_index:Number=scene.indexOf("Scene");

            //if(scene!="Story")
            //{
            if(src_index==-1 || scene.indexOf("Scene")!=-1)
            {
                //no command cloud , incloud xxxxScene

                if(src.indexOf("QA")!=-1 || src=="TarotCards" || src=="twinflame") {

                    disableAll();

                }else{
                    onTouchedScene();
                }
            }else{

                //disableAll()
            }
            //}

        }

    }
    public function clearMouseClickIcon():void
    {
        //DebugTrace.msg("SceneCommand.clearMouseClickIcon");
        if(clickmouse)
        {
            clickmouse.removeFromParent(true);
            clickmouse=null;
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

    public function doClearAll():void
    {
        for(var i:String in display_container)
        {
            if(display_container[i])
            {

                display_container[i].removeFromParent(true);
            }
            //if
        }
        //for
        if(photoframe){
            photoframe.removeFromParent(true);
            photoframe=null;
        }
        if(bgSprite){
            bgSprite.removeFromParent(true);
            bgSprite=null;
        }
        if(bubble)
        {
            bubble.removeFromParent(true);
            bubble=null;
        }
    }
    public function disableAll():void
    {

        DebugTrace.msg("SceneCommand.disableAll hitArea");

        try{
            XAltImag.removeEventListeners();
            XAltImag.removeFromParent(true);
        }catch (e:Error){}


        var mainstage:Sprite=ViewsContainer.MainScene;
        mainstage.removeEventListeners();
    }
    public function enableTouch():void
    {
        DebugTrace.msg("SceneCommand.enableTouch ");

        addTouchArea();
        onTouchedScene();

    }
    public function filterBackground():void
    {
        //filter.setSource(background);
        //filter.setBulr();

    }
    public function switchGateway(type:String ,callback:Function=null):*
    {
        var verify:Boolean=false;
        var local_verify:Boolean=false;
        var date_verify:Boolean=false;
        var time_verify:Boolean=false;
        var switch_date:String="";
        var switch_time:String="";

        var flox:FloxInterface=new FloxCommand();
        current_switch=flox.getSaveData("current_switch");
        switchID="";
        if(current_switch.split("|")[1]=="on"){
            switchID=current_switch.split("|")[0];
        }
        //switchID=flox.getSaveData("next_switch");

        DebugTrace.msg("SceneCommand.switch   Gateway switchID="+switchID);
        //DebugTrace.msg("SceneCommand.switchGateway next_switch="+next_switch);

        if(switchID!=""){
            var switchs:Object=flox.getSyetemData("switchs");
            scene=DataContainer.currentScene;
            var value:Object=switchs[switchID];
            var _scene:String=scene.split("Scene").join("").toLowerCase();
            location=value.location;
            var date:String=flox.getSaveData("date");
            switch_date=value.date;
            switch_time=String(value.time);

        }


        //------------Location------------------------------------------
        if(location!="")
        {
            if(_scene==location.toLowerCase())
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
            DebugTrace.msg("SceneCommand.switchGateway _day="+_day);
            DebugTrace.msg("SceneCommand.switchGateway switch_day="+switch_day);
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


        //disable story system-------------------------------
        if(disable_story){
            verify=false;
            date_verify=false;
            time_verify=false;
            local_verify=false;
            type="";
        }

        //----------------------------------------------


        var battle_verify:Boolean=verifyRankingBattle();
        if(date_verify && time_verify && local_verify && switchID!="" && battle_verify)
        {
            verify=true;
            // ViewsContainer.gameinfo.visible=false;

            doClearAll();
            part=Number(switchID.split("s").join(""))-1;

            var talks:Array=StoryDAO.switchStory(switchID);
            if(!talks){
                talks=new Array();
            }
            if(talks.length>0){
                initStory(callback);

                var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
                gameEvent._name="clear_comcloud";
                gameEvent.displayHandler();
            }
        }else{
            verify=false;
        }
        // verify: math switch  ;  !verify:no match switch

        if(type=="Rest")
        {
            if(date_verify && time_verify)
            {

                verify=true;
                //updateCurrentSwitch();
            }else{
                verify=false;
            }

        }

        if(switchID=="" || ! battle_verify){
            verify=false;
            date_verify=false;
            time_verify=false;
            local_verify=false;
            type="";
        }

        storyverify=new Array(verify,date_verify,time_verify,local_verify,battle_verify);
        DebugTrace.msg("SceneCommand.switchGateway storyverify ->"+storyverify);

        return storyverify;
    }
    private function verifyRankingBattle():Boolean{

        var verify:Boolean=true;
        var battleDays:Array=Config.battleDays;
        var current_battle:Object=flox.getSaveData("current_battle");
        var date:String=flox.getSaveData("date");
        var _date:String=date.split("|")[0];
        var _day:Number=Number(_date.split(".")[1]);
        var _month:String=_date.split(".")[2];
        var current_date:String=_month+"_"+_day;

        if(battleDays.indexOf(current_date)!=-1){

            var resultlist:Array=current_battle[current_date];
            var battle_result:String=resultlist.toString();
            if(battle_result=="0|0,0|0,0|0,0|0,0|0"){
                verify=false;
            }
        }

        return verify;
    }
    private var turn_on_id:String="";
    private function updateCurrentSwitch():void
    {

        var switchs:Object=flox.getSyetemData("switchs");
        var value:Object=switchs[switchID];
        if(value){
            var result:Object=value.result;
            turn_on_id=result.on;
            var turn_off_id:String=result.off;


            if(turn_off_id!="")
            {
                current_switch=turn_off_id+"|off";


            }
            if(turn_on_id!="")
            {
                current_switch=turn_on_id+"|on";
                DataContainer.NextSwitch=turn_on_id;

            }

            switchID=current_switch;


            onStoryComplete();

        }else{

            onStoryComplete();
        }

    }
    private function saveNextSwitch():void{

        //flox.save("next_switch",turn_on_id);

        delaycall=new DelayedCall(onStoryComplete,0.5);
        Starling.juggler.add(delaycall);

    }
    private function onStoryComplete():void{

        DebugTrace.msg("SceneCommand.onStoryComplete");
        flox.save("current_switch",current_switch);

        SceneCommnad.scene="";
        Starling.juggler.remove(delaycall);
        disableAll();

        var battleType:String=DataContainer.battleType;
        //if(battleType!="final_battle" && battleType!="story_battle_s023"){
        if(battleType!="final_battle"){
            var current_scene:Sprite=ViewsContainer.currentScene;
            var _data:Object=new Object();
            _data.removed="story_complete";
            current_scene.dispatchEventWith(TopViewEvent.REMOVE,false,_data);
        }


    }
    private var switchIDlist:Array;
    public function initStory(finshed:Function=null):void
    {
        //_target=scene_sprite;
        ViewsContainer.gameinfo.visible=false;

        talk_index=0;
        scene="Story";

        display_container=new Object();


        part_index=part;
        talks=StoryDAO.switchStory(switchID);


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
        DebugTrace.msg("SceneCommand.onStoryFinished");


    }
    private function nextStoryPart():void{

        doClearAll();
        talk_index=0;
        display_container=new Object();
        part_index++;
        var previewStory:Array=DataContainer.previewStory;

        if(part_index>previewStory.length-1){

            part_index=0;
        }
        talks=previewStory[part_index];
        DebugTrace.msg("SceneCommand.nextStoryPart talks="+talks);
        showChat();
    }
    public function prevStoryStep():void{

        talk_index--;
        display_container=new Object();

        if(bubble)
        {
            bubble.removeFromParent(true);
            bubble=null;
        }
        var previewStory:Array=DataContainer.previewStory;
        if(talk_index<0){
            talk_index=0;
            part_index--;
            if(part_index<0){
                part_index=0;
            }

        }
//        talks=new Array();
//        for(var i:uint=0;i<previewStory[part_index].length;i++){
//            talks.push(previewStory[part_index][i])
//        }
        talks=previewStory[part_index];
        //DebugTrace.msg("PreviewStroyCoommand.prevStoryStep talks["+talk_index+"]="+talks[talk_index]);

        if(character){
            character.removeFromParent();

        }

        showChat();
    }
    private function praseTwinFlameFormat(name:String):String{

        if(name.indexOf("@@@")!=-1){

            var twinflame:String=flox.getSaveData("twinflame");
            if(twinflame){
                twinflame=twinflame.toLowerCase();
                name=name.split("@@@").join(twinflame);
            }
        }
        return name;
    }
    public function initDatingTwinStory(id:String):void{

        talk_index=0;
        scene="TwinStory";

        display_container=new Object();

        //part_index=part;

        talks=TwinDAO.switchTwinDAO(id);

    }


}
}
