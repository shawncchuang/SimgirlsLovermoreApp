/**
 * Created by shawn on 2014-09-05.
 */
package views {
import controller.Assets;

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

        var rewardTxt:TextField=new TextField(100,60,String(value),font,40,0xFFFFFF,true);
        rewardTxt.autoSize=TextFieldAutoSize.BOTH_DIRECTIONS;
        rewardTxt.hAlign="left";
        rewardTxt.vAlign="top";
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

        }
        reward.pivotX=reward.width/2;
        reward.pivotY=reward.height/2;

        addChild(reward);

        fliter.setShadow(reward);


        var tween:Tween=new Tween(reward,1,Transitions.EASE_OUT_BACK);
        tween.delay=index*0.4;
        tween.animate("y",reward.y-50);
        tween.animate("scaleX",1.2);
        tween.animate("scaleY",1.2);
        tween.onComplete=onRewardFadeOut;
        Starling.juggler.add(tween);

    }

    private function onRewardFadeOut():void{

        Starling.juggler.removeTweens(reward);

        reward.removeFromParent(true);

    }


}
}
