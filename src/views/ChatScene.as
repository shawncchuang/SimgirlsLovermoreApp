package views
{

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import data.DataContainer;

import events.SceneEvent;

import flash.geom.Rectangle;

import starling.animation.DelayedCall;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;

import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;


import utils.DebugTrace;
import utils.ViewsContainer;

public class ChatScene extends Sprite
{
    private var bubble:Image;
    private var bingo:Sprite;
    private var bingoMax:Number=3;
    private var items_texture:Texture;
    private var top:Number=0;
    private var bottom:Number=100;

    private var speed:Number=20;
//    private var cancelbtn:Button;
    private var command:MainInterface=new MainCommand();
    private var relist:Array=new Array();
    private var flox:FloxInterface=new FloxCommand();
    private var chatbubbleTex:Texture;
    private var result:Number;
//    private var clickmouse:Sprite;
//    private var quad:Quad;
    private var alert:Sprite;
    private var tweenID:uint=0;

    public function ChatScene()
    {
        initBingo();
        //initCharacter();
        initBubble();
        initBingoMachine();

        ViewsContainer.datingScene=this;
        this.addEventListener(Event.REMOVED_FROM_STAGE, onChatSceneRemoved);
        this.addEventListener("DATING_CHAT_COMPLETE",onChatComplete);
    }
    private function initBingo():void
    {
        //80% bingo,20% trash talking
        var bingo:uint=80;
        var moodBingo:uint=60;
        var chat_bingo:Number=Math.ceil(Math.random()*100);

        if(chat_bingo<=bingo)
        {
            //chate bingo, item bingo
            var item_bingo:Number=Math.ceil(Math.random()*100);

            if(item_bingo>=1 && item_bingo<=moodBingo)
            {
                // moood reward ,location match 60%
                setResult(0);
            }
            else if(item_bingo>moodBingo && item_bingo<=moodBingo+10)
            {
                //secrets match 10%
                setResult(2);

            }
            else
            {
                //gift match 30%
                setResult(1);

            }
            //if
        }
        else
        {
            //nothing match

            setResult(-1);

        }


    }
    private function setResult(re:Number):void
    {
        result=re;
        var _relist:Array=[0,1,2];

        for(var i:uint=0;i<bingoMax;i++)
        {

            if(re!=-1)
            {
                relist.push(re);
            }
            else
            {
                var index:Number=Math.floor(Math.random()*_relist.length);
                relist.push(_relist[index]);
                var new_relist:Array=_relist.splice(index);
                new_relist.shift();
                _relist=_relist.concat(new_relist);

            }
            //if
        }
        //for
        DebugTrace.msg("ChatScene.setResult relist:"+relist);

    }
    private function initCharacter():void
    {

        var dating:String=DataContainer.currentDating;
        if(dating)
        {

            var style:String=DataContainer.styleSchedule[dating];
            var clothTexture:Texture=Assets.getTexture(style);
            var character:Image=new Image(clothTexture);

            character.x=260;

            addChild(character);
        }
    }

    private function initBubble():void
    {
        chatbubbleTex=Assets.getTexture("Bubble");
        var texture:Texture=Assets.getTexture("BubbleThink");
        //bubbleSprite=new Sprite();
        bubble=new Image(texture);
        bubble.pivotX=bubble.width/2;
        bubble.pivotY=bubble.height/2;

        bubble.x=768;
        bubble.y=260;
        //bubble.width=380;
        //bubble.height=372;
        bubble.scaleX=-1;

        addChild(bubble);
    }

    private function initBingoMachine():void
    {

        bingo=new Sprite();
        bingo.scaleX=0.9;
        bingo.scaleY=0.9;
        bingo.x=633;
        bingo.y=160;

        var bgTexture:Texture=Assets.getTexture("BingoBg");
        var bingobg:Image=new Image(bgTexture);
        var motionTexture:Texture=Assets.getTexture("BingoItemsMoving");
        bingo.addChild(bingobg);


        items_texture=Assets.getTexture("BingoItems");
        for(var i:uint=0;i<bingoMax;i++)
        {

            var bingomotion:Sprite=new Sprite();
            var bingomotionImg:Image=new Image(motionTexture);
            bingomotion.addChild(bingomotionImg);
            bingomotion.name="motion"+i;
            bingomotion.x=i*bingomotionImg.width;
            //bingomotion.clipRect=new flash.geom.Rectangle(0,0,100,100);
            bingomotion.mask=new Quad(100,100);
            bingomotion.visible=false;

            var bingoitems:Sprite=new Sprite();
            var bingoitemsImg:Image=new Image(items_texture);
            bingoitems.addChild(bingoitemsImg);
            bingoitems.name="bingo"+i;
            bingoitems.x=i*bingoitems.width;
            //bingoitems.clipRect=new flash.geom.Rectangle(0,0,100,100);
            bingoitems.mask=new Quad(100,100);
            bingoitems.visible=false;

            bingo.addChild(bingoitems);
            bingo.addChild(bingomotion);

            bingoitems.addEventListener(Event.ENTER_FRAME,doBingoStart);
            bingomotion.addEventListener(Event.ENTER_FRAME,doBingoStart);
        }
        //for
        addChild(bingo);



        //start bingo moving
        addTweenCall(0.1,0.1,onBigoMoving);

    }
    private var repeat:Number=-1;

    private function doBingoStart(e:Event):void
    {


        //var target:ScrollImage=e.currentTarget as ScrollImage;
        var target:Sprite=e.currentTarget as Sprite;
        top+=speed;
        bottom+=speed;
        target.y=-(top);


        if(bottom>300)
        {
            top=0;
            bottom=100;
            target.y=0;

        }
        //if


        //target.clipRect=new flash.geom.Rectangle(0,top,100,100);
        target.mask=new Quad(100,100);
        target.mask.y=top;

    }
    private function onRepeatBingoMoving():void
    {

        speed-=2;
        DebugTrace.msg("ChatScene.nRepeatBingoMoving speed:"+speed);
    }
    private function onBigoMoving():void
    {

        displayBingo(false,true);
        Starling.juggler.removeTweens(bingo);
        repeat=1;
        addTweenCall(0.1,0.1,onBigoSlowMoving);
    }
    private function onBigoSlowMoving():void
    {
        repeat=-1;
        Starling.juggler.removeTweens(bingo);

        addTweenCall(0.1,0.1,onBigoResult);
    }
    private function onBigoResult():void
    {

        if(result!=-1)
        {
            command.playSound("BingoSound");
        }
        Starling.juggler.removeTweens(bingo);
        displayBingo(true,false,false);


    }
    private function addTweenCall(time:Number,delay:Number,callback:Function):void
    {

        var tween:Tween=new Tween(bingo,time);
        tween.delay=delay;
        if(repeat>0)
        {
            tween.repeatCount=repeat;
            tween.onRepeat=onRepeatBingoMoving;
        }
        tween.onComplete=callback;
        Starling.juggler.add(tween);
    }

    private function displayBingo(_bingo:Boolean,_motion:Boolean,enterframe:Boolean=true):void
    {

        for(var i:uint=0;i<bingoMax;i++)
        {
            var _bingoitems:Sprite=bingo.getChildByName("bingo"+i) as Sprite;
            var _bingomotion:Sprite=bingo.getChildByName("motion"+i) as Sprite;

            _bingoitems.visible=_bingo;
            _bingomotion.visible=_motion;

            if(_bingo)
            {

                _bingoitems.y=0;
                //_bingoitems.clipRect=new flash.geom.Rectangle(0,0,100,100);
                _bingoitems.mask=new Quad(100,100);
            }
            if(!enterframe)
            {
                _bingoitems.y=-(relist[i]*100);
                //_bingoitems.clipRect=new flash.geom.Rectangle(0,relist[i]*100,100,100);
                _bingoitems.mask=new Quad(100,100);
                _bingoitems.mask.y=relist[i]*100;
                _bingoitems.removeEventListener(Event.ENTER_FRAME,doBingoStart);
                _bingomotion.removeEventListener(Event.ENTER_FRAME,doBingoStart);


                var tween:Tween=new Tween(bingo,0.25);
                tween.delay=0.25;
                tween.onComplete=onChatWithPlayer;
                Starling.juggler.add(tween);
            }
            //if
        }
        //for
    }
    private var sentence:String;
    private function onChatWithPlayer():void
    {

        Starling.juggler.removeTweens(bingo);
        removeChild(bingo);

        var seretchat:Array=flox.getSyetemData("secrets_chat");
        var systemAssets:Object=flox.getSyetemData("assets");

        var ratingLv:Number;
        var likes:String;
        var dating:String=DataContainer.currentDating;
        var assets:Object;
        var item:Object;
        var chatDataAttr:String="chat_"+dating;
        var switchRate:Number=Math.floor(Math.random()*100);

        if(switchRate<50){
            chatDataAttr="chat_"+dating+"_loc";
        }
        var chat:Object=flox.getSyetemData(chatDataAttr);
        var datingScene:Sprite=ViewsContainer.baseSprite;
        var _data:Object=new Object();
        //Chat Formula
        switch(relist.toString())
        {
            case "0,0,0":
                //mood reward
                var moodObj:Object=flox.getSaveData("mood");
                var ptsObj:Object=flox.getSaveData("pts");
                var pts:Number=ptsObj[dating];
                var mood:Number=moodObj[dating];
                var result:Object=praseRelAndMood({mood:mood,pts:pts,dating:dating});
                //DebugTrace.msg("SimgirlsLovemore.onChatWithPlayer result:"+JSON.stringify(result));
                var condition:String=result["mood"];
                if(switchRate<50) {
                    condition=DataContainer.currentScene.split("Scene").join("");
                }

                var sentences:Array=chat[result.rel][condition];
                index=Math.floor(Math.random()*sentences.length);
                sentence=sentences[index];

                var _int:Number=flox.getSaveData("int").player;
                var _img:Number=flox.getSaveData("image").player;
                var reward:Number=Math.floor((_int+_img)/24);

                _data.com="Reward_Mood";
                _data.mood=reward;
                datingScene.dispatchEventWith(DatingScene.COMMIT,false,_data);

                break;
            case "1,1,1":
                // item 100~-100

                item=praseItemRating();
                    var rating:Number=0;
                for(var id:String in item){
                    var item_id:String=id;
                    rating=item[id];
                }

                ratingLv=DataContainer.assetsRatingLevel(rating);
                assets=systemAssets[item_id];
                //DebugTrace.msg("ChatScene.onChatWithPlayer assets:"+JSON.stringify(assets));
                sentence=seretchat[ratingLv];
                sentence=sentence.split("^brand").join(assets.brand);
                sentence=sentence.split("^item").join(assets.name);
                initCancelHandle();
                break
            case "2,2,2":
                //secrets
                var sysSecrets:Object=flox.getSyetemData("secrets");
                var secrets:Object=flox.getSaveData("secrets");
                var dating_secrets:Array=secrets[dating];
                var index:uint=uint(Math.random()*dating_secrets.length);
                id=dating_secrets[index].id;
                var secretsQ:String=sysSecrets[id].q;
                var ans:String=dating_secrets[index].ans;
                sentence=secretsQ.split("|~|").join(ans);
                initCancelHandle();
                break
            default:
                //no bingo talking
                var trashtalkings:Array=flox.getSyetemData("trashtalking");
                var talkingIndex:Number=Math.floor(Math.random()*trashtalkings.length);
                sentence=trashtalkings[talkingIndex];
                initCancelHandle();
                break
        }
        //switch

        DebugTrace.msg("ChatScene.onChatWithPlayer sentence:"+sentence);
        bubble.scaleX=0;
        bubble.scaleY=0;
        bubble.alpha=0;
        bubble.texture=chatbubbleTex;

        tweenID=Starling.juggler.tween(bubble,0.5,{scaleX:-1,scaleY:1,alpha:1,
            transition:Transitions.EASE_OUT_ELASTIC,onComplete:onBubbleComplete});

    }
    private function onBubbleComplete():void
    {
        Starling.juggler.removeByID(tweenID);

        var chatTxt:TextField=new TextField(255,190,sentence);
        chatTxt.format.setTo("SimImpact",20,0x000000,"left");
        chatTxt.x=634;
        chatTxt.y=110;
        addChild(chatTxt);

    }
    private function nothinghHappenHandler():void{

        initCancelHandle();

    }
    private function praseSceneRating(ratinglv:Number):String
    {
        var scene:String;
        var scenelikes:Object=flox.getSaveData("scenelikes");
        var dating:String=flox.getSaveData("dating");
        var datinglikes:Object=scenelikes[dating];
        //var sceneslikes:Array=new Array();
        var sceneslist:Array=new Array();
        DebugTrace.msg("ChatScene.praseSceneRating ratinglv:"+ratinglv);
        for(scene in datinglikes)
        {
            var likesObj:Object=new Object();
            likesObj.scene=scene;
            likesObj.likes=datinglikes[scene];
            sceneslist.push(likesObj);
        }
        //for
        sceneslist.sortOn("likes",Array.NUMERIC);

        var scene_index:Number=Math.floor(sceneslist.length*ratinglv/100)-1;

        DebugTrace.msg("ChatScene.praseSceneRating scene_index:"+scene_index);
        scene=sceneslist[scene_index].scene;
        return scene
    }
    private function praseItemRating():Object
    {

        var item:Object;
        //var unreleased_assets:Object=flox.getSaveData("unreleased_assets");
        var assets_rating:Object=flox.getSaveData("assets");
        var dating:String=DataContainer.currentDating;
        var assets:Array=assets_rating[dating];

        var item_index:Number=Math.floor(Math.random()*assets.length);
        item=assets[item_index];
        DebugTrace.msg("ChatScnen.praseItemRating  item="+JSON.stringify(item));

        return item
    }
    private function initCancelHandle():void
    {
        //cancel button

        alert = new AlertMessage("", doCancelHandler,"screen_type");
        addChild(alert);

    }
    private function doCancelHandler():void
    {

        alert.removeFromParent(true);
        displayBingo(false,false,false);

        Starling.juggler.removeTweens(bingo);

        var _data:Object=new Object();
        _data.name=DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function praseRelAndMood(attr:Object):Object
    {
        DebugTrace.msg("SimgirlsLovemore.praseRelAndMood attr:"+JSON.stringify(attr));

        var re:Object=new Object();

        re.mood=DataContainer.getFacialMood(attr.dating);
        re.rel=flox.getSaveData("rel")[attr.dating];

        return re;
    }

    private function onChatSceneRemoved(e:Event):void{

        Starling.juggler.removeTweens(bingo);
        Starling.juggler.removeTweens(bubble);
        bubble.removeFromParent(true);
        bingo.removeFromParent(true);

    }
    private function onChatComplete(e:Event):void{

        initCancelHandle();

    }

}
}