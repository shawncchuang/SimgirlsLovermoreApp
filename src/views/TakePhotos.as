/**
 * Created by shawn on 2014-09-11.
 */
package views {
import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.Config;

import data.DataContainer;

import events.SceneEvent;

import flash.geom.Point;
import flash.geom.Rectangle;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;

import starling.display.Sprite;
import starling.textures.Texture;

import utils.DrawManager;
import utils.ViewsContainer;

public class TakePhotos extends Sprite{

    private var character:Image;
    private var player:Sprite;
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var style:String;

    public function TakePhotos() {



        var base_sprite:Sprite=ViewsContainer.baseSprite;
        player=command.drawPlayer(base_sprite);
        player.y-=20;
        player.scaleX=1.3;
        player.scaleY=1.3;
        initCharacter();

        initCancelHandle();
        addPhotos();

        updateReward();

    }
    private function  initCharacter():void{


        var dating:String=DataContainer.currentDating;
        style=DataContainer.styleSechedule[dating];
        var base_sprite:Sprite=ViewsContainer.baseSprite;
        character=command.drawCharacter(base_sprite,style);

    }


    private function initCancelHandle():void
    {
        //cancel button

        command.addedCancelButton(this,doCancelAssetesForm);

    }
    private function doCancelAssetesForm():void
    {


        var _data:Object=new Object();
        _data.name=DataContainer.currentLabel;
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function addPhotos():void{

        var photos:Array=flox.getSaveData("photos");
        var avatar:Object=flox.getSaveData("avatar");
        if(photos.length<1){

            photos=new Array();

        }
        if(photos.length<100) {
            var pic:Object = new Object();
            pic.scene = DataContainer.currentScene;
            pic.player = {x: player.x,
                 y: player.y,
                "clothes":avatar.clothes,
                "pants":avatar.pants,
                "uppercolor":avatar.uppercolor,
                "lowercolor":avatar.lowercolor
            };
            pic.character = {x: character.x, y: character.y, style: style};
            photos.push(pic);

            flox.save("photos", photos);

        }else{

            var msg:String="Yours photos space was full !!";
            new AlertMessage(msg);

        }


    }

    private function updateReward():void{



        var dating:String=DataContainer.currentDating;
        var moodObj:Object=flox.getSaveData("mood");
        var intObj:Object=flox.getSaveData("int");
        var imgObj:Object=flox.getSaveData("image");
        var playerImg:Number=imgObj.player;
        var playerInt:Number=intObj.player;
        var reward_mood:Number=Math.floor((playerImg+playerInt)/24);

        var mood:Number=moodObj[dating];
        mood+=reward_mood;
        moodObj[dating]=mood;

        flox.save("mood",moodObj);

        var _mood:String=String(reward_mood);
        if(reward_mood>=0){
            _mood="+"+_mood;
        }
        var rewardData:Object=new Object();
        rewardData.attr="mood";
        rewardData.values= "MOOD "+_mood;
        command.displayUpdateValue(this,rewardData);
        command.updateRelationship();


        var _data:Object=new Object();
        _data.com="TakePhotosReward";
        _data.mood=mood;
        var base_sprite:Sprite=ViewsContainer.baseSprite;
        base_sprite.dispatchEventWith(DatingScene.COMMIT,false,_data);



    }
}
}
