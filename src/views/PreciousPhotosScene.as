/**
 * Created by shawnhuang on 15-10-22.
 */
package views {
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import events.SceneEvent;

import flash.geom.Point;

import starling.display.Sprite;

public class PreciousPhotosScene extends Sprite{

    private var base_sprite:Sprite;
    private var scencom:SceneInterface=new SceneCommnad();
    private var command:MainInterface=new MainCommand();
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";

    public function PreciousPhotosScene() {

        initailizeLayoutHandler();
    }
    private function initailizeLayoutHandler():void{

        base_sprite=new Sprite();
        addChild(base_sprite);
        scencom.init("PreciousPhotosScene",base_sprite,20);


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="PHOTOS";
        templete.label="Precious Moments";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-420,110),to:new Point(-180,150)},
            {from:new Point(1440,150),to:new Point(1200,150)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();

        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(114,80),to:new Point(114,80)});
        templete.addMiniMenu();
        addChild(templete);
    }
    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }
}
}
