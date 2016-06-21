/**
 * Created by shawnhuang on 2016-06-16.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;

import events.SceneEvent;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;

public class LeaderboardForm extends Sprite {
    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panel:Image;
    private var command:MainInterface=new MainCommand();
    private var leaderboardLayout:LeaderboardListLayout;
    public function LeaderboardForm() {

        base_sprite=new Sprite();
        addChild(base_sprite);

        initPanel();
        initLeaderboardLayout();
    }
    private function initPanel():void{
        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);



        panel=new Image(Assets.getTexture("LeaderboardPanel"));
        panelbase.addChild(panel);


        var templete:MenuTemplate=new MenuTemplate();
        templete.addBackStepButton(doCannelHandler);
        addChild(templete);

    }
    private function doCannelHandler(e:Event):void
    {

        panelbase.removeFromParent(true);

        var _data:Object=new Object();
        _data.name= "BlackMarketScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }

    private function initLeaderboardLayout():void{

        leaderboardLayout=new LeaderboardListLayout();
        leaderboardLayout.mask=new Quad(550,355);
        leaderboardLayout.x=32;
        leaderboardLayout.y=72;
        panelbase.addChild(leaderboardLayout);



    }
}
}
