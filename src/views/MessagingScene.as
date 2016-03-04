/**
 * Created by shawnhuang on 15-12-03.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import events.SceneEvent;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextFormat;


import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

public class MessagingScene extends Sprite{
    private var base_sprite:Sprite;
    private var scenecom:SceneInterface=new SceneCommnad();
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var command:MainInterface=new MainCommand();
    private var hyperlink:String="https://storage.googleapis.com/lovemore/sim73.swf";
    public function MessagingScene() {


        super();

        base_sprite=new Sprite();
        addChild(base_sprite);

        initailizeLayoutHandler();

    }
    private function initailizeLayoutHandler():void{


        scenecom.init("ContactsScene",base_sprite,20);
        //messaging

        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="MESSAGING";
        templete.label="MESSAGING";
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

        var massaging:Sprite=new Sprite();
        massaging.x=253;
        massaging.y=179;

        var panelBg:Image=new Image(Assets.getTexture("ContactsPanelBg"));
        massaging.addChild(panelBg);

        var str:String="Bonus gift for you! \n Download Simgirls 7.0 here:";
        var message:TextField=new TextField(panelBg.width,80,str);
        message.format.setTo(font,20);
        message.y=10;
        massaging.addChild(message);

        var btn:Button=new Button();
        btn.useHandCursor=true;
        btn.label="Download";
        btn.setSize(panelBg.width,30);
        btn.width=panelBg.width;
        btn.y=message.y+message.height+5;
        btn.labelFactory =  getItTextRender;
        btn.addEventListener(Event.TRIGGERED, doClickDownload);
        massaging.addChild(btn);
        addChild(massaging);

    }
    private function doClickDownload(e:Event):void{

        navigateToURL(new URLRequest(hyperlink));
    }

    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 30, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }

}
}
