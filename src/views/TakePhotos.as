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

public class TakePhotos extends Sprite{

    private var character:Image;
    private var player:Sprite;
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var style:String;

    public function TakePhotos() {


        initCharacter();

        player=command.drawPlayer(this);

        initCancelHandle();

        addPhotos();

    }
    private function  initCharacter():void{


        var dating:String=DataContainer.currentDating;
        style=DataContainer.styleSechedule[dating];

        character=command.drawCharacter(this,style);

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
       if(photos.length<1){

           photos=new Array();

       }
        if(photos.length<100) {
            var pic:Object = new Object();
            pic.scene = DataContainer.currentScene;
            pic.player = {x: player.x, y: player.y};
            pic.character = {x: character.x, y: character.y, style: style};
            photos.push(pic);

            flox.save("photos", photos);
        }else{

            var msg:String="Yours photos space was full !!"
            new AlertMessage(msg);

        }


    }
}
}
