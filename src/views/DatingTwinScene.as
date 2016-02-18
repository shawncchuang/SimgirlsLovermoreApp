/**
 * Created by shawnhuang on 2016-01-15.
 */
package views {
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;

import events.SceneEvent;

import events.TopViewEvent;

import flash.html.script.Package;

import model.Scenes;


import starling.display.Sprite;
import starling.events.Event;

import utils.DebugTrace;

import utils.ViewsContainer;

public class DatingTwinScene extends Scenes{

    private var flox:FloxInterface=new FloxCommand();
    private var base_sprite:Sprite;
    private var scencom:SceneInterface=new SceneCommnad();
    private var command:MainInterface=new MainCommand();
    public function DatingTwinScene() {

        base_sprite = new Sprite();
        addChild(base_sprite);

        ViewsContainer.currentScene=this;
        this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
        init();
    }
    private function doTopViewDispatch(e:Event):void{

        switch (e.data.removed){
            case "story_complete":
                onFinishedStory();
                break

        }

    }
    private function init():void{

        scencom.init("DatingTwinScene",base_sprite,63);
        scencom.initDatingTwinStory(DataContainer.DatingTwinID);
        scencom.start();
    }
    private function onFinishedStory():void{


        var dating:String=DataContainer.currentDating;
        var datingtwin:Object=flox.getSaveData("datingtwin");


        var rel:Object=flox.getSaveData("rel");
        var current_rel:String=rel[dating];
        datingtwin[current_rel].enabled=false;

        flox.save("datingtwin",datingtwin);

        DebugTrace.msg("DatingTwinScene.onFinishedStory dating="+dating+" ; " +
                "datingtwin="+JSON.stringify(datingtwin));
        var _data:Object = new Object();
        //_data.name = DataContainer.currentLabel;
        _data.name ="MainScene";
        command.sceneDispatch(SceneEvent.CHANGED, _data);


    }

}
}
