/**
 * Created by shawn on 2014-09-05.
 */
package views {
import controller.Assets;

import starling.animation.Juggler;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;
import starling.display.Image;
import starling.display.Sprite;
import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;

import utils.FilterManager;

public class Reward extends Sprite{

    public var type:String;
    public var value:String;
    public var target:Sprite;
    public var index:Number;

    private var reward:Sprite;
    //private var font:String="SimImpact";
    private var font:String="SimNeogreyMedium";
    private var stageCW:Number;
    private var stageCH:Number;
    private var fliter:FilterManager=new FilterManager();
    private var tweenID:uint=0;

    private var textures:Object={
        "ap":"ApIcon",
        "cash":"Cashsign",
        "image":"Appearance",
        "int":"Intelligence",
        "love":"HeartLv1",
        "skillPts":"SkillPtsIcon",
        "honor":"Honor"
    }

    public function Reward() {

    }

    public function addNode():void{


        reward=new Sprite();

        var rewardTxt:TextField=new TextField(100,60,String(value));
        rewardTxt.autoSize=TextFieldAutoSize.BOTH_DIRECTIONS;
        rewardTxt.format.setTo(font,40,0xFFFFFF,"left");
        reward.addChild(rewardTxt);
        if(type!="mood"){

            var texture:Texture=Assets.getTexture(textures[type]);
            var icon:Image=new Image(texture);
           // icon.smoothing=TextureSmoothing.TRILINEAR;
            reward.addChild(icon);


            rewardTxt.x=icon.width+5;
            if(icon.height>rewardTxt.height){
                rewardTxt.y=(icon.height-rewardTxt.height)/2;
            }else{
                icon.y=(rewardTxt.height-icon.height)/2;
            }

        }else{
            rewardTxt.width=400;
        }
        reward.pivotX=reward.width/2;
        reward.pivotY=reward.height/2;
        reward.scale=0.8;
        addChild(reward);

        fliter.setShadow(reward);



//
//        var tween:Tween=new Tween(reward,1,Transitions.EASE_OUT_BACK);
//        tween.delay=index*0.4;
//        tween.animate("y",reward.y-50);
//        tween.animate("scaleX",1.2);
//        tween.animate("scaleY",1.2);
//        tween.onComplete=onRewardFadeOut;
//        Starling.juggler.add(tween);

        var juggler:Juggler=Starling.juggler;
        tweenID=juggler.tween(reward,1,{delay:index*0.4,y:reward.y-80,scale:1.5,transition:Transitions.EASE_OUT_BACK,onComplete:onRewardFadeOut});


    }

    private function onRewardFadeOut():void{

        //Starling.juggler.removeTweens(reward);
        var juggler:Juggler=Starling.juggler;
        juggler.removeByID(tweenID);
        reward.dispose();
        reward.removeFromParent(true);

    }


}
}
