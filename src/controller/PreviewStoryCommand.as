/**
 * Created by shawnhuang on 15-11-10.
 */
package controller {
import com.greensock.loading.LoaderMax;

import data.Config;
import data.DataContainer;
import events.GameEvent;


import flash.geom.Point;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Sprite;
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

public class PreviewStoryCommand implements PreviewStoryInterface {

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
    private var hitArea:Sprite;

    private var clickmouse:ClickMouseIcon=null;
    private var ch_pos:Object={"center":new Point(330,0),"left":new Point(-54,0),"right":new Point(650,0)};
    private var bubble:CharacterBubble=null;
    private var spbubble_pos:Object={"spC":new Point(278,235),"spL":new Point(480,440),"spR":new Point(580,235)};
    private var thbubble_pos:Object={"thC":new Point(278,235),"thL":new Point(480,440),"thR":new Point(580,235)};
    private var shbubble_pos:Object={"shC":new Point(278,235),"shL":new Point(480,440),"shR":new Point(580,235)};
    private var moving_tween:Tween;
    private var finishedcallback:Function;
    private var photoframe:PhotoMessage=null;
    //private var background:MovieClip=null;
    private var background:Sprite;
    private var bgSprite:Sprite;
    private var scene_container:Sprite;
    private var day:String;
    private var switchID:String="";
    private var location:String="";
    private var part:Number=0;

    private var filter:FilterInterface=new FilterManager();
    private var bgSrc:String="";

    public function set currentSwitch(id:String):void
    {
        switchID=id.split("|")[0];
    }
    public function get currentSwitch():String
    {
        return switchID.split("|")[0];
    }

    public function init(story:Array,current:String,target:Sprite,lbr_part:Number,finshed:Function=null):void {


        switchID="s001|on";
        currentSwitch=switchID;
        scene_sprite=ViewsContainer.currentScene;
        //var main_scene:Sprite=ViewsContainer.MainScene;
        scene_sprite.name="scene_container";
        //main_scene.addChild(scene_sprite);

        talk_index=0;
        scene=current;
        display_container=new Object();
        finishedcallback=finshed;

        _target=target;
        part_index=lbr_part;


        talks=story[part_index];
        DataContainer.previewStory=story;

        DebugTrace.msg("PreviewStoryCommand.init story:"+JSON.stringify(story));

        if(MenuScene.iconsname.indexOf(current)==-1 && current!="MenuScene"){
            //var loaderdata:LoaderRequest=new LoaderRequest();
            //loaderdata.LoaderDataHandle("",datingComCloudHandle)
        }

    }
    private function datingComCloudHandle(data:Array):void{

        DebugTrace.msg("PreviewStoryCommand.datingComCloudHandle data"+data);

        //talks


    }
    public function start():void
    {

        if(scene!="CharacterDesignScene")
            addTouchArea();
        showChat();
    }
    private function addTouchArea():void
    {
        DebugTrace.msg("PreviewStoryCommand.addTouchArea");

        Starling.current.stage.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);

    }

    private function onChatSceneTouched(e:TouchEvent):void
    {


        var BEGAN:Touch = e.getTouch( Starling.current.stage, TouchPhase.BEGAN);
       // var HOVER:Touch = e.getTouch( Starling.current.stage, TouchPhase.HOVER);
        if(BEGAN && BEGAN.target.name !="previousbtn")
        {

            onTouchedScene();
        }



    }
    public function onTouchedScene():void
    {
        talk_index++;
        end_index=talks.indexOf("END");
        DebugTrace.msg("PreviewStoryCommand.onChatSceneTouched talk_index:"+talk_index+",end_index="+end_index);
        //DebugTrace.msg("PreviewStoryCommand.onChatSceneTouched talks="+talks);
        if(talk_index<end_index)
        {
            if(bubble)
            {
                bubble.removeFromParent(true);
                bubble=null;
            }
            showChat();
        }
        else
        {
            //finish current part
            DebugTrace.msg("PreviewStoryCommand finished");
            doClearAll();
            nextStoryPart();
            if(finishedcallback)
                finishedcallback();

        }
        //if

    }
    private function showChat():void
    {
        DebugTrace.msg("PreviewStoryCommand.showChat talk_index="+talk_index);
        com_content=talks[talk_index];
        DebugTrace.msg("PreviewStoryCommand.showChat com_content:"+com_content);
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
        var commandsStr:String=com_content.split("#").toString();
        var commands:Array=commandsStr.split(",");
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
            DebugTrace.msg("PreviewStoryCommand.commandHandle todo="+todo);
            switch(todo)
            {
                case "remove":
                    if(target=="player") {
                        talkmask.removeFromParent(true);
                        talkmask=null;
                    }
                    if(display_container[target]){
                        display_container[target].removeFromParent(true);
                        //_target.removeChild(display_container[target]);
                        display_container[target]=null;
                    }
                    break
                case "display":
                    createCharacter(target,pos);
                    break
                case "move":
                    movingCharacter(target,pos);
                    break
                case "photo-on":
                    createPhotoMessage(target);
                    break
                case "photo-off":
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
//            talk_index++;
//            if(talk_index<commands.length){
//                showChat();
//            }

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
        var scentance:String=talks[talk_index];
        scentance=scentance.split("<>").join(",");
        scentance=scentance.split("player|").join("");
        talkfield.addTextField(scentance,onTalkingComplete);
        _target.addChild(talkfield);
        display_container.player=talkfield;
    }
    private function onTalkingComplete():void{
        DebugTrace.msg("SceneCommand.onTalkingComplete");

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
        if(Config.allCharacters.indexOf(target)!=-1){

            //character
            //var stylesechdule:Object=DataContainer.styleSechedule;
            //DebugTrace.msg("SceneCommand.createCharacter, style="+stylesechdule.stringify(stylesechdule));
            //var style:String=stylesechdule[name];
            var style:String=name;
            texture=Assets.getTexture(style);

        }else{

            //NPC
            style=Config.NPC[name];
            texture=Assets.getTexture(style);

        }

        var _ch_pos:Object=ch_pos;
        if(style=="npc014"){
            _ch_pos={"center":new Point(50.5,0),"left":new Point(0,0),"right":new Point(109,0)};
        }

        var pos:Point=new Point(_ch_pos[p].x,_ch_pos[p].y);
        character=new Image(texture);
        character.name=name;
        character.alpha=0;
        character.x=pos.x;
        character.y=pos.y;
        _target.addChild(character);
        display_container[name]=character;


        var tween:Tween=new Tween(character,0.5,Transitions.EASE_OUT);
        tween.fadeTo(1);
        tween.onComplete=onCharacterDisplayed;
        Starling.juggler.add(tween);


    }
    private function onCharacterDisplayed():void
    {
        Starling.juggler.removeTweens(character);
    }
    public function movingCharacter(target:String,dir:String):void
    {
        DebugTrace.msg("ChatCommand.movingCharacter target:"+target+" ;dir:"+dir);
        var current_ch:Image=display_container[target];
        moving_tween=new Tween(current_ch,0.5,Transitions.EASE_OUT);
        moving_tween.animate("x",ch_pos[dir].x);
        moving_tween.onComplete=onMovingComplete;
        Starling.juggler.add(moving_tween);

    }

    private function onMovingComplete():void
    {

        Starling.juggler.remove(moving_tween);
    }
    private function createPhotoMessage(target:String):void {
        DebugTrace.msg("ChatCommand.createPhotoMessage");
        photoframe = new PhotoMessage(target);
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
        //DebugTrace.msg("SceneCommand.displayVideo src:"+src);
//        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
//        gameEvent._name="show_video";
//        gameEvent.video=src;
//        gameEvent.displayHandler();

        var meidaPlayer:MediaInterface=new MediaCommand();
        meidaPlayer.VideoPlayer(src,_target);


        command.stopBackgroudSound();
        disableAll();
    }
    public function createBackground(src:String):void
    {
        location=src;
        var scene:Sprite=ViewsContainer.MainScene;
        scene_container=scene.getChildByName("scene_container") as Sprite;
        var drawmanager:DrawerInterface=new DrawManager();
        bgSprite=drawmanager.drawBackgroundgFroPreview(src);
        _target.addChild(bgSprite);

    }
    public function createAnimateEffect(src:String):void{


        DebugTrace.msg("PreviewStoryCommand.createAnimateEffect src="+src);

        var mediacom:MediaInterface = new MediaCommand();
        mediacom.SWFPlayer("transform", "../swf/"+src+".swf", onFinishAnimated);

    }
    private function onFinishAnimated():void{
        var queue:LoaderMax=ViewsContainer.loaderQueue;
        queue.empty(true,true);

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

            if(scene!="Story")
            {
                if(src_index==-1 || scene.indexOf("Scene")!=-1)
                {
                    //no command cloud , incloud xxxxScene
                    switch(src)
                    {
                        case "TarotCards":
                        case "QA_nickname":
                        case "QA_airplane-phonenumber":
                            disableAll();
                            break;
                        default:
                            onTouchedScene();
                            break
                    }

                }else{

                    //disableAll()
                }
            }

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
        }
        if(bgSprite){
            bgSprite.removeFromParent(true);
            bgSprite=null;
        }
        if(bubble)
        {
            bubble.removeFromParent(true);
        }
    }
    public function disableAll():void
    {

        DebugTrace.msg("SceneCommand.disableAll hitArea");

        Starling.current.stage.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
    }
    public function enableTouch():void
    {
        DebugTrace.msg("SceneCommand.enableTouch ");
        //_target.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
        //NativeApplication.nativeApplication.addEventListener(MouseEvent.MOUSE_DOWN,onChatSceneTouched);

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

        var verify:Boolean=true;
        var local_verify:Boolean=true;
        var date_verify:Boolean=true;
        var time_verify:Boolean=true;

        if(date_verify && time_verify && local_verify)
        {
            verify=true;
            ViewsContainer.gameinfo.visible=false;

            doClearAll();
            part=Number(switchID.split("s").join(""))-1;
            initStory(callback);

        }

        DebugTrace.msg("SceneCommand.switchGateway return ->"+[verify,date_verify,time_verify,local_verify]);
        return new Array(verify,date_verify,time_verify,local_verify)
    }
    private var switchIDlist:Array;
    public function initStory(finshed:Function=null):void
    {
        //_target=scene_sprite;
        talk_index=0;
        //scene="Story";
        display_container=new Object();
        finishedcallback=onStoryFinished;

        part_index=part;
        var library:Array=new Array();
        talks=library[part_index];


    }
    public function onStoryFinished():void
    {
        DebugTrace.msg("SceneCommand.onStoryComplete");
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
        DebugTrace.msg("PreviewStoryCommand.nextStoryPart talks="+talks);
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

}
}
