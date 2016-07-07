/**
 * Created by shawnhuang on 2016-06-16.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import events.SceneEvent;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;

public class LeaderboardForm extends Sprite {
    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panel:Image;
    private var command:MainInterface=new MainCommand();
    private var leaderboardLayout:LeaderboardListLayout;
    private var font:String="SimNeogreyMedium";
    private var flox:FloxInterface=new FloxCommand();

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

        var jrNumbersTexture:Texture=Assets.getTexture("PersonalJrNumbersField");
        var jrNumnerField:Image=new Image(jrNumbersTexture);
        jrNumnerField.y=470;
        panelbase.addChild(jrNumnerField);

        var ownerId:String=flox.getPlayerData("ownerId");
        var statistics:Array=flox.getBundlePool("statistics");
        var myRank:Object=new Object();
        for(var i:uint=0;i<statistics.length;i++){
            if(statistics[i].id==ownerId){
                myRank=statistics[i];
                break
            }
        }
        //DebugTrace.msg("LeaderboardForm.initPanel statistics="+JSON.stringify(statistics));
        DebugTrace.msg("LeaderboardForm.initPanel myRank="+JSON.stringify(myRank));
        var numStr:String="My number of Paid Juniors : ";
        if(myRank.id){
            numStr+=myRank.numbers;
        }else{
            numStr+="0";
        }
        var numbersTxt:TextField=new TextField(550,30,numStr);
        numbersTxt.format.setTo(font,20,0,"left");
        numbersTxt.x=15;
        numbersTxt.y=484;

        panelbase.addChild(numbersTxt);

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
