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
    private var vlayout:VerticalLayout;
    private var itemslist:Array;
    public function HuntCriminalsListLayout() {
        this.height=355;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
        this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);
    }
    private function initializeHandler(e:Event):void
    {

        //criminalsData=flox.getSaveData("criminals");
        criminalsData=DataContainer.Criminals;

        vlayout=new VerticalLayout();
        vlayout.gap=2;
        vlayout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
        vlayout.verticalAlign=TiledRowsLayout.VERTICAL_ALIGN_TOP;
        vlayout.paddingTop = 0;
        vlayout.paddingRight = 0;
        vlayout.paddingBottom = 0;
        vlayout.paddingLeft =0;

        this.layout = vlayout;
        this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
        this.snapScrollPositionsToPixels = true;

        itemslist=new Array();

        for(var i:uint=0;i<criminalsData.length;i++){

            var criminal:Object=criminalsData[i];
            var itemRender:Sprite=new Sprite();

            var locationTxt:TextField=new TextField(180,30,criminal.location);
            locationTxt.format.setTo(font,24,0x333333);
            locationTxt.autoScale=true;
            locationTxt.x=10;
            itemRender.addChild(locationTxt);

            var rankingTxt:TextField=new TextField(180,30,criminal.rank);
            rankingTxt.format.setTo(font,24,0x333333);
            rankingTxt.x=locationTxt.x+locationTxt.width;
            itemRender.addChild(rankingTxt);

            var fRewards:String=DataContainer.currencyFormat(criminal.rewards);
            var rewards:TextField=new TextField(180,30,fRewards);
            rewards.format.setTo("SimNeogreyMedium",24,0x333333);
            rewards.autoScale=true;
            rewards.x=rankingTxt.x+rankingTxt.width;
            itemRender.addChild(rewards);
            itemslist.push(itemRender);
            addChild(itemRender);
        }

    }
    private function onRemovedHandler(e:Event):void{

        for(var i:uint=0;i<itemslist.length;i++){
           var item:Sprite= itemslist[i];
            item.removeFromParent(true);
            this.dispose();
        }

    }
}
}
