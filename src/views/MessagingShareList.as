/**
 * Created by shawnhuang on 2016-09-14.
 */
package views {
import controller.Assets;

import feathers.controls.Button;
import feathers.controls.ButtonState;


import feathers.controls.ImageLoader;

import feathers.controls.PanelScreen;
import feathers.controls.WebView;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalAlign;
import feathers.layout.RelativePosition;
import feathers.layout.VerticalAlign;

import flash.text.TextFormat;

import services.LoaderRequest;


import starling.display.Image;


import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

import utils.DebugTrace;

import utils.ViewsContainer;

public class MessagingShareList extends PanelScreen {
    private var font:String="SimMyriadPro";
    private var sharedata:Array=new Array();
    public function MessagingShareList() {
//        this.height=300;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);


    }
    private function initializeHandler(e:Event):void{
        var upTexture:Texture=Assets.getTexture("IconArrow");
        var backBtn:Button=new Button();
        backBtn.useHandCursor=true;
        backBtn.x=5;
        backBtn.defaultIcon = new Image( upTexture );
        backBtn.iconPosition = RelativePosition.LEFT;
        backBtn.horizontalAlign = HorizontalAlign.CENTER;
        backBtn.verticalAlign = VerticalAlign.MIDDLE;
        backBtn.gap = 10;
        backBtn.label="Back";
        backBtn.setSize(60,40);
        backBtn.labelFactory =  getItTextRender;
        backBtn.addEventListener(Event.TRIGGERED, backTriggeredHandler);
        addChild(backBtn);

//        var browser:WebView = new WebView();
//        browser.y=40;
//        browser.width = 515;
//        browser.height = 500;
//        this.addChild( browser );
//        browser.loadURL( "http://www.blackspears.com/files/sharelist/index.html" );

        var dataUrl:String="http://www.blackspears.com/files/sharelist/sharedata.json";
        var loaderReq:LoaderRequest=new LoaderRequest();
        loaderReq.LoaderDataHandle(dataUrl,responseHandler);


    }
    private function responseHandler(res:String):void{
        DebugTrace.msg("MessagingShareList res=>"+res);
        sharedata=JSON.parse(res).data;
        initShareList();

    }
    private function initShareList():void{
        DebugTrace.msg("MessagingShareList sharedata=>"+sharedata);
        var _h:Number=304;

        for(var i:uint=0;i<sharedata.length;i++){
            var imgLoader:ImageLoader=new ImageLoader();
            imgLoader.width=515;

            imgLoader.source=sharedata[i].src;
            imgLoader.y=i*_h+40;


            var sdTextr:Texture=Assets.getTexture("IconShareDe");
            var upTextr:Texture=Assets.getTexture("IconShareUp");
            var btn:feathers.controls.Button=new feathers.controls.Button();
            btn.useHandCursor=true;
            var skin_de:Image=new Image(Assets.getTexture("softlens"));
            skin_de.alpha=0;
            var skin_up:Image=new Image(Assets.getTexture("softlens"));
            skin_up.alpha=0.5;
            btn.defaultSkin=skin_de;
            btn.setSkinForState(ButtonState.HOVER,skin_up);

            btn.defaultIcon=new Image(sdTextr);
            btn.setIconForState(ButtonState.HOVER,new Image(upTextr));

            btn.width=imgLoader.width;
            btn.height=_h;

            btn.y=imgLoader.y;

            btn.addEventListener(Event.TRIGGERED, shareTriggeredHandler);
            addChild(imgLoader);
            addChild(btn);
            DebugTrace.msg("MessagingShareList btn.width="+btn.width+", btn.height="+ btn.height);

        }


    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }
    private function backTriggeredHandler(e:Event):void{

        var current_scene:Sprite=ViewsContainer.currentScene;
        current_scene.dispatchEventWith("MESSAGE_NAV",false,{item_name:"MassageShare"});
    }
    private function shareTriggeredHandler(e:Event):void{
        var loaderReq:LoaderRequest=new LoaderRequest();
        loaderReq.navigateToURLHandler("http://www.blackspears.com/files/sharelist/");

    }
}
}
