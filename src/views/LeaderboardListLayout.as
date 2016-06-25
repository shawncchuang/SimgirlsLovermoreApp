/**
 * Created by shawnhuang on 2016-06-16.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.events.FeathersEventType;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;

import starling.display.Image;

import starling.display.Sprite;

import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;


public class LeaderboardListLayout extends PanelScreen{

    private var vlayout:VerticalLayout;
    private var itemslist:Array;
    private var flox:FloxInterface = new FloxCommand();
    private var statistics:Array=new Array();
    private var font:String="SimMyriadPro";

    public function LeaderboardListLayout() {
        this.height=355;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
        this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedHandler);

    }
    private function initializeHandler(e:Event):void
    {


        flox.refleshBundlePool(onRefreshBundlePoolComplete);


        function onRefreshBundlePoolComplete():void{

            statistics=flox.getBundlePool("statistics");

            DebugTrace.msg("LeaderboardListLayout.initializeHandler " +
                    "onRefreshBundlePoolComplete statistics="+JSON.stringify(statistics));
            if(statistics.length>0){
                statistics.sortOn("numbers",Array.NUMERIC|Array.DESCENDING);

                initLayout();
            }

        }



    }
    private function initLayout():void{
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
        var leaderNumbers:Number=statistics.length;
         if(statistics.length>100)
             leaderNumbers=100;

        for(var i:uint=0;i<leaderNumbers;i++){

            var itemRender:Sprite=new Sprite();
            var parentNode:Object=statistics[i];
            var rankTxt:TextField=new TextField(100,30,String(i+1));
            rankTxt.format.setTo(font,24,0x333333);
            rankTxt.autoScale=true;
            itemRender.addChild(rankTxt);

            var nicknameTxt:TextField=new TextField(183,30,parentNode.nickname);
            nicknameTxt.format.setTo(font,24,0x333333);
            nicknameTxt.autoScale=true;
            nicknameTxt.x=112;
            itemRender.addChild(nicknameTxt);


            var numbersTxt:TextField=new TextField(194,30,String(parentNode.numbers));
            numbersTxt.format.setTo(font,24,0x333333);
            numbersTxt.x=344;
            itemRender.addChild(numbersTxt);

            if(i==0){
                var crownTexture:Texture=Assets.getTexture("Crown");
                var crown:Image=new Image(crownTexture);
                crown.x=numbersTxt.x+numbersTxt.width-30;
                crown.y=-7;
                itemRender.addChild(crown);

            }
            addChild(itemRender);
            itemslist.push(itemRender);

        }


    }
    private function onRemovedHandler(e:Event):void {

        if(itemslist){
            for(var i:uint=0;i<itemslist.length;i++){
                var item:Sprite= itemslist[i];
                item.removeFromParent(true);
                this.dispose();
            }
        }

    }
}
}
