/**
 * Created by shawnhuang on 2016-09-14.
 */
package views {
import controller.Assets;

import feathers.controls.Button;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;


import starling.display.Image;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class MessagingShare extends PanelScreen{
    private var vlayout:VerticalLayout;
    private var font:String="SimMyriadPro";
    private var item_name:String="";
    public function MessagingShare() {

//        this.height=500;

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


        var itemRender:Sprite = new Sprite();
        itemRender.name = "BlackSpears";
        itemRender.useHandCursor=true;

        var quad:Quad = new Quad(515, 50, 0xffffff);
        quad.alpha=0;
        itemRender.addChild(quad);

        var iconTexture:Texture=Assets.getTexture("IconBlackSpears");
        var icon:Image=new Image(iconTexture);
        icon.x=5;
        itemRender.addChild(icon);

        var nicknameTxt:TextField=new TextField(150,50,"BlackSpears");
        nicknameTxt.format.setTo(font,24,0x333333);
        nicknameTxt.x=icon.x+icon.width+20;
        itemRender.addChild(nicknameTxt);

        var btn:Button=new Button();
        btn.name = "BlackSpears";
        btn.useHandCursor=true;
        btn.width=quad.width;
        btn.height=quad.height;
        btn.addEventListener(Event.TRIGGERED, triggeredBlackSpearsHandler);
        itemRender.addChild(btn);


        addChild(itemRender);

    }

    private function triggeredBlackSpearsHandler(e:Event):void{


            item_name= "BlackSpears";

            var current_scene:Sprite=ViewsContainer.currentScene;
            current_scene.dispatchEventWith("MESSAGE_NAV", false,{item_name:"MassageShareList_"+item_name});


    }
}
}
