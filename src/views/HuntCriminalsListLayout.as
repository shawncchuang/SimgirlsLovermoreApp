/**
 * Created by shawnhuang on 15-11-23.
 */
package views {
import controller.FloxCommand;
import controller.FloxInterface;

import data.DataContainer;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.events.FeathersEventType;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;

import starling.display.Sprite;

import starling.events.Event;
import starling.text.TextField;

public class HuntCriminalsListLayout extends PanelScreen{

    private var criminalsData:Array=new Array();
    private var flox:FloxInterface=new FloxCommand();
    private var font:String="SimMyriadPro";
    public function HuntCriminalsListLayout() {
        this.height=355;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
    }
    private function initializeHandler(e:Event):void
    {

        //criminalsData=flox.getSaveData("criminals");
        criminalsData=DataContainer.Criminals;

        var layout:VerticalLayout=new VerticalLayout();
        layout.gap=2;
        layout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
        layout.verticalAlign=TiledRowsLayout.VERTICAL_ALIGN_TOP;
        layout.paddingTop = 0;
        layout.paddingRight = 0;
        layout.paddingBottom = 0;
        layout.paddingLeft =0;

        this.layout = layout;
        this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
        this.snapScrollPositionsToPixels = true;

        for(var i:uint=0;i<criminalsData.length;i++){

            var criminal:Object=criminalsData[i];
            var itemRender:Sprite=new Sprite();

            var locationTxt:TextField=new TextField(180,30,criminal.location,font,24,0x333333,true);
            locationTxt.autoScale=true;
            locationTxt.x=10;
            itemRender.addChild(locationTxt);

            var rankingTxt:TextField=new TextField(180,30,criminal.rank,font,24,0x333333,true);
            rankingTxt.x=locationTxt.x+locationTxt.width;
            itemRender.addChild(rankingTxt);

            var fRewards:String=DataContainer.currencyFormat(criminal.rewards);
            var rewards:TextField=new TextField(180,30,fRewards,"SimNeogreyMedium",24,0x333333,true);
            rewards.autoScale=true;
            rewards.x=rankingTxt.x+rankingTxt.width;
            itemRender.addChild(rewards);
            addChild(itemRender);
        }

    }
}
}
