/**
 * Created by shawn on 2014-09-12.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import events.SceneEvent;

import flash.geom.Point;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;

import starling.display.MovieClip;


import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;

import utils.ViewsContainer;

public class FlirtScene extends Sprite{

    private var font:String="SimImpact";
    private var types:Array=["eyecontact","love","smile","touch"];
    private var bubble:Image;
    private var chatTxt:TextField;
    private var dating_card:String;
    private var card:Image;
    private var target:Image;
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var cardX:Number;
    private var card_name:String;
    private var selType:String;
    public function FlirtScene() {

        initDatingCard();
        initCards();
        initCancelHandle();

    }
    private function initDatingCard():void
    {
        var texture:Texture=Assets.getTexture("BubbleThink");
        bubble=new Image(texture);
        bubble.smoothing=TextureSmoothing.TRILINEAR;
        bubble.pivotX=bubble.width/2;
        bubble.pivotY=bubble.height/2;

        bubble.x=768;
        bubble.y=260;

        bubble.scaleX=-1;
        addChild(bubble);

        chatTxt=new TextField(245,145,"",font,20,0x000000);
        chatTxt.hAlign="left";
        chatTxt.vAlign="center"
        chatTxt.x=648;
        chatTxt.y=123;
        addChild(chatTxt);


        dating_card=types[Math.floor(Math.random()*types.length)];
        card=getCard(dating_card);
        card.pivotX=card.width/2;
        card.pivotY=card.height/2;
        card.x=bubble.x;
        card.y=bubble.y-50;
        card.scaleX=0.8;
        card.scaleY=0.8;
        addChild(card);



    }
    private function initCards():void{

        for(var i:uint=0;i<4;i++){

            var card:Image=getCard("back");
            card.name="card"+i;
            var posX:Number=Math.floor(i*250+(card.width/2+50));
            card.pivotX=card.width/2;
            card.x=1000;
            card.y=500;
            addChild(card);
            var tween:Tween=new Tween(card,0.8,Transitions.EASE_IN_OUT);
            tween.animate("x",posX);
            tween.delay=(i*0.4);
            Starling.juggler.add(tween);
            card.useHandCursor=true;
            card.addEventListener(TouchEvent.TOUCH, onTouchCardHandle);

        }

    }
    private function onTouchCardHandle(e:TouchEvent):void{

        target= e.currentTarget as Image;
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);

        if(began){

            cardX=target.x;
            card_name=target.name;
            var tween:Tween=new Tween(target,0.8,Transitions.EASE_IN_OUT);
            tween.animate("scaleX",-1);
            tween.onComplete=onFlipCard;
            Starling.juggler.add(tween);

            selType=types[Math.floor(Math.random()*types.length)];
            var card:Image=getCard(selType);
            card.pivotX=card.width/2;
            card.x=target.x;
            card.y=target.y;
            card.scaleX=0;
            addChild(card);

            var cardTween:Tween=new Tween(card,0.4,Transitions.EASE_IN_OUT);
            cardTween.animate("scaleX",1);
            Starling.juggler.add(cardTween);

            otherCardsFadeout();

            resaultHandle();
        }

    }
    private function onFlipCard():void{

        Starling.juggler.removeTweens(target);

    }
    private function otherCardsFadeout():void{


        var index:uint=uint(card_name.split("card").join(""));

        for(var i:uint=0;i<4;i++){

            if(i!=index){

                var card:Image=this.getChildByName("card"+i) as Image;
                var cardTween:Tween=new Tween(card,0.5,Transitions.EASE_IN_OUT);
                cardTween.animate("x",cardX);

                Starling.juggler.add(cardTween);
            }

        }

    }

    private function getCard(src:String):Image{

        var xml:XML=Assets.getAtalsXML("FlirtCardsXML");

        var texture:Texture=Assets.getTexture("FlirtCards");
        var atlas:TextureAtlas=new TextureAtlas(texture,xml);
        var card:Image=new Image(atlas.getTexture(src));

        return card

    }
    private function initCancelHandle():void
    {
        //cancel button


        command.addedCancelButton(this,doCancelHandler,new Point(970,55));


    }
    private function resaultHandle():void{


        var dating:String=DataContainer.currentDating;
        var moodObj:Object=flox.getSaveData("mood");
        var loveObj:Object=flox.getSaveData("love");
        var imgObj:Object=flox.getSaveData("image");
        var image:Number=imgObj.player;
        var reward:Number=Math.floor(image/3);
        var value_data:Object=new Object();
        var love:Object=new Object();
        if(selType==dating_card){
            reward*=3;
            switch (dating_card){
                case "love":

                    var reward_love:Number=Math.floor(reward/5);
                    loveObj.player+=reward_love;
                    loveObj[dating]+=reward_love;
                    flox.save("love",loveObj);

                    love.player= loveObj.player;
                    love.dating= loveObj[dating];

                    moodObj[dating]+=reward;
                    flox.save("mood",moodObj);

                    var rewardStr:String="+"+reward_love;
                    value_data.attr="love,mood";
                    value_data.values= rewardStr+",MOOD +"+reward;
                    command.displayUpdateValue(this,value_data);

                    break

                default:
                    love=null;

                    moodObj[dating]+=reward;
                    flox.save("mood",moodObj);

                    value_data.attr="mood";
                    value_data.values= "MOOD +"+reward;
                    command.displayUpdateValue(this,value_data);
                    break
            }

        }else{

            love=null;

            moodObj[dating]+=reward;
            flox.save("mood",moodObj);

            value_data.attr="mood";
            value_data.values= "MOOD +"+reward;
            command.displayUpdateValue(this,value_data);

        }

        var _data:Object=new Object();
        _data.com="TakeFlirtReward";
        _data.mood= moodObj[dating];
        _data.love=love;
        var base_sprite:Sprite=ViewsContainer.baseSprite;
        base_sprite.dispatchEventWith(DatingScene.COMMIT,false,_data);

    }

    private function doCancelHandler():void
    {

        var _data:Object=new Object();
        _data.name=DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }
}
}
