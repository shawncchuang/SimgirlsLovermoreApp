/**
 * Created by shawn on 2014-08-18.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;

import events.SceneEvent;

import flash.geom.Point;

import starling.display.Image;

import starling.display.Sprite;

public class ContactsScene extends Sprite {
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var command:MainInterface=new MainCommand();
    public function ContactsScene() {
        super();
        initailizeLayoutHandler();

    }
    private function initailizeLayoutHandler():void{


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="CONTACTS";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-420,110),to:new Point(-180,150)},
            {from:new Point(1440,150),to:new Point(1200,150)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();
        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(116,82),to:new Point(116,82)});
        templete.addMiniMenu();
        addChild(templete);


        var contacts:Sprite=new Sprite();
        contacts.x=253;
        contacts.y=179;
        addChild(contacts);


        var panelBg:Image=new Image(Assets.getTexture("ContactsPanelBg"));
        contacts.addChild(panelBg);



    }

    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data)
    }

}
}
