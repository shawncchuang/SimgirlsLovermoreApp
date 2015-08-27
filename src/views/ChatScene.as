package views
{

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.Config;

import data.DataContainer;

import events.SceneEvent;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.ScrollImage;
import starling.display.Sprite;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;
import starling.utils.Color;

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
    private var cancelbtn:Button;
    private var command:MainInterface=new MainCommand();
    private var relist:Array=new Array();
    private var flox:FloxInterface=new FloxCommand();
    private var chatbubbleTex:Texture;
    private var result:Number;
    private var clickmouse:Sprite;
    private var quad:Quad;
    public function ChatScene()
    {
        initBingo();
       //initCharacter();
        initBubble();
        initBingoMachine();
        initCancelHandle();

        this.addEventListener(Event.REMOVED_FROM_STAGE, onChatSceneRemoved)
    }
    private function initBingo():void
    {
        //60% bingo,40% trash talking
        var bingo:uint=60;
        var moodBingo:uint=40;
        var chat_bingo:Number=uint(Math.random()*100)+1;

        if(chat_bingo<=bingo)
        {
            //chate bingo, item bingo
            var item_bingo:Number=uint(Math.random()*100)+1;

            if(item_bingo>=1 && item_bingo<=moodBingo)
            {
                // location match 40%
                setResult(0);
            }
            else if(item_bingo>moodBingo && item_bingo<=moodBingo+30)
            {
                //secrets match 30%
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
        var _relist:Array=new Array(0,1,2);
        for(var i:uint=0;i<bingoMax;i++)
        {

            if(re!=-1)
            {
                relist.push(re);
            }
            else
            {
                var index:Number=uint(Math.random()*_relist.length);
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

            var style:String=DataContainer.styleSechedule[dating];
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
        bubble.smoothing=TextureSmoothing.TRILINEAR;
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
            var bingomotion:ScrollImage=new ScrollImage(motionTexture);
            bingomotion.name="motion"+i;
            bingomotion.x=i*bingomotion.width;
            bingomotion.clipMaskTop=0
            bingomotion.clipMaskLeft=0;
            bingomotion.clipMaskBottom=100
            bingomotion.clipMaskRight=100;
            bingomotion.visible=false;


            var bingoitems:ScrollImage=new ScrollImage(items_texture);
            bingoitems.name="bingo"+i;
            bingoitems.x=i*bingoitems.width;
            bingoitems.clipMaskTop=0
            bingoitems.clipMaskLeft=0;
            bingoitems.clipMaskBottom=100
            bingoitems.clipMaskRight=100;

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


        var target:ScrollImage=e.currentTarget as ScrollImage;
        top+=speed;
        bottom+=speed;
        target.y=-(top);


        if(bottom>300)
        {
            top=0
            bottom=100;
            target.y=0;

        }
        //if
        //DebugTrace.msg("ChatScene.doBingoStart bottom:"+bottom);
        target.clipMaskTop=top;
        target.clipMaskBottom=bottom;




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
            var _bingoitems:ScrollImage=bingo.getChildByName("bingo"+i) as ScrollImage;
            var _bingomotion:ScrollImage=bingo.getChildByName("motion"+i) as ScrollImage;

            _bingoitems.visible=_bingo;
            _bingomotion.visible=_motion;

            if(_bingo)
            {

                _bingoitems.y=0;
                _bingoitems.clipMaskTop=0;
                _bingoitems.clipMaskBottom=100;
            }
            if(!enterframe)
            {
                _bingoitems.y=-(relist[i]*100);
                _bingoitems.clipMaskTop=relist[i]*100;
                _bingoitems.clipMaskBottom=relist[i]*100+100;

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

        var datingchat:Array=flox.getSyetemData("secrets_chat");
        var systemAssets:Object=flox.getSyetemData("assets");

        var ratingLv:Number;
        var likes:String;
        var dating:String=DataContainer.currentDating;
        var assets:Object
        var chat:Object=flox.getSyetemData("chat_"+dating);
        var item:Object;

        switch(relist.toString())
        {
            case "0,0,0":
                //mood reward

                var moodObj:Object=flox.getSaveData("mood");
                var ptsObj:Object=flox.getSaveData("pts");
                var pts:Number=ptsObj[dating];
                var mood:Number=moodObj[dating];
                var result:Object=praseRelAndMood({mood:mood,pts:pts,dating:dating});
                DebugTrace.msg("SimgirlsLovemore.onChatWithPlayer result:"+JSON.stringify(result));
                var sentences:Array=chat[result.rel][result.mood];
                index=Math.floor(Math.random()*sentences.length);
                sentence=sentences[index];

                var _int:Number=flox.getSaveData("int").player;
                var reward:Number=Math.floor(_int/4);
                var _data:Object=new Object();
                _data.com="Reward_Mood";
                _data.mood=reward;
                var datingScene:Sprite=ViewsContainer.baseSprite;
                datingScene.dispatchEventWith(DatingScene.COMMIT,false,_data);

                break
            case "1,1,1":
                // item 100~-100

                item=praseItemRating();
                ratingLv=DataContainer.assetsRatingLevel(item.rating);
                assets=systemAssets[item.id];
                //DebugTrace.msg("ChatScene.onChatWithPlayer assets:"+JSON.stringify(assets));

                sentence=datingchat[ratingLv];
                sentence=sentence.split("^brand").join(assets.brand);
                sentence=sentence.split("^item").join(assets.name);
                DebugTrace.msg("ChatScene.onChatWithPlayer sentence:"+sentence);
                break
            case "2,2,2":
                //secrets
                var sysSecrets:Object=flox.getSyetemData("secrets");
                var secrets:Object=flox.getSaveData("secrets");
                var dating_secrets:Array=secrets[dating];
                var index:uint=uint(Math.random()*dating_secrets.length);
                var id:String=dating_secrets[index].id;
                var secretsQ:String=sysSecrets[id].q;
                var ans:String=dating_secrets[index].ans;
                sentence=secretsQ.split("|~|").join(ans);
                break
            default:
                //no bingo talking
                sentence="...............";
                break
        }
        //switch

        DebugTrace.msg("ChatScene.onChatWhithPlayer sentence:"+sentence);
        bubble.scaleX=0;
        bubble.scaleY=0;
        bubble.alpha=0;
        bubble.texture=chatbubbleTex;

        var tween:Tween=new Tween(bubble,0.5,Transitions.EASE_OUT_ELASTIC);
        tween.animate("scaleX",-1);
        tween.animate("scaleY",1);
        tween.animate("alpha",1);
        tween.onComplete=onBubbleComplete;
        Starling.juggler.add(tween);
    }
    private function onBubbleComplete():void
    {
        Starling.juggler.removeTweens(bubble);

        var chatTxt:TextField=new TextField(255,190,sentence,"SimImpact",20,0x000000)
        chatTxt.hAlign="left";
        chatTxt.x=634;
        chatTxt.y=110;
        addChild(chatTxt);

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
        /*for(var i:uint=0;i<sceneslist.length;i++)
         {
         DebugTrace.msg("ChatScene.praseSceneRating sceneslikes:"+JSON.stringify(sceneslist[i]));

         }
         //for*/
        var scene_index:uint=uint(sceneslist.length*ratinglv/100)-1;
        /*for(scene in datinglikes)
         {

         var like:Number=Number(datinglikes[scene]);
         if(like<=ratinglv+50 && like>=ratinglv-50)
         {
         DebugTrace.msg("ChatScene.praseSceneRating scene:"+scene+" ; like:"+like);
         sceneslist.push(scene);
         }
         //if
         }
         //for
         var scene_index:Number=uint(Math.random()*sceneslist.length);*/
        DebugTrace.msg("ChatScene.praseSceneRating scene_index:"+scene_index);
        scene=sceneslist[scene_index].scene;
        return scene
    }
    private function praseItemRating():Object
    {

        var item:Object;
        var unreleased_assets:Object=flox.getSaveData("unreleased_assets");
        var assets_rating:Object=flox.getSaveData("assets");
        var dating:String=DataContainer.currentDating;
        var assets:Array=unreleased_assets[dating];

        if(assets.length<1){
            unreleased_assets=assets_rating;
            assets=unreleased_assets[dating];
        }


        var item_index:Number=Math.floor(Math.random()*assets.length);
        item=assets[item_index];
        DebugTrace.msg("ChatScnen.praseItemRating  item="+JSON.stringify(item));
        var rating_index:Number=0;
        for(var j:uint=0;j<assets.length;j++){

            if(assets[j].id==item.id){
                rating_index=j;
                break
            }
        }
        var _assets:Array=assets.splice(rating_index);
        _assets.shift();
        assets=assets.concat(_assets);
        unreleased_assets[dating]=assets;
        flox.save("unreleased_assets",unreleased_assets);


        return item
    }
    private function initCancelHandle():void
    {
        //cancel button


        //added cancel button
        //command.addedCancelButton(this,doCancelHandler);
        var width:Number=Starling.current.stage.stageWidth;
        var height:Number=Starling.current.stage.stageHeight;
        quad= new Quad(width,height,Color.AQUA);
        quad.alpha=0;
        addChild(quad);

        clickmouse=new ClickMouseIcon();
        clickmouse.x=973;
        clickmouse.y=704;
        addChild(clickmouse);
        this.addEventListener(TouchEvent.TOUCH,doCancelHandler);


    }
    private function doCancelHandler(e:TouchEvent):void
    {

        var began:Touch=e.getTouch(this,TouchPhase.BEGAN);
        if(began)
        {
            quad.removeFromParent(true);
            clickmouse.removeFromParent(true);
            this.removeEventListener(Event.TRIGGERED,doCancelHandler);

            displayBingo(false,false,false);
            Starling.juggler.removeTweens(bingo);

            var _data:Object=new Object();
            _data.name=DataContainer.currentLabel;
            command.sceneDispatch(SceneEvent.CHANGED,_data);

        }

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

    }

}
}