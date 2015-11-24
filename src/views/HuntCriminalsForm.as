/**
 * Created by shawnhuang on 15-11-23.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;

import events.SceneEvent;

import flash.geom.Rectangle;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;

public class HuntCriminalsForm extends Sprite{

    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panelAssets:Image;
    private var command:MainInterface=new MainCommand();
    private var huntcriminalslsit:HuntCriminalsListLayout;
    public function HuntCriminalsForm() {

        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();

        initPanel();
        initHuntCriminalsLayout();
    }
    private function initPanel():void{


        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);



        panelAssets=new Image(Assets.getTexture("HuntCriminalPanel"));
        panelbase.addChild(panelAssets);


        var templete:MenuTemplate=new MenuTemplate();
        templete.addBackStepButton(doCannelHandler);
        addChild(templete);

    }
    private function doCannelHandler(e:Event):void
    {

        panelbase.removeFromParent(true);

        var _data:Object=new Object();
        _data.name= "PoliceStationScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }
    private function initHuntCriminalsLayout():void{

        huntcriminalslsit=new HuntCriminalsListLayout();
        huntcriminalslsit.clipRect=new Rectangle(0,0,550,355);
        huntcriminalslsit.x=32;
        huntcriminalslsit.y=72;
        panelbase.addChild(huntcriminalslsit);

    }


}
}
