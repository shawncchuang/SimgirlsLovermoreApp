/**
 * Created by shawnhuang on 15-12-02.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.DataContainer;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;

import flash.text.TextFormat;

import starling.core.Starling;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;


public class PopupManager extends Sprite{

    private var popup:Sprite=null;
    private var font:String="SimMyriadPro";
    public var attr:String;
    public var data:*;
    public var msg:String;


    public function init():void {



        popup=new Sprite();

//        var bgTexture:Texture=Assets.getTexture("PopupBg");
//        var bg:Image=new Image(bgTexture);


        var bg:Quad = new Quad( 400, 80, 0x000000 );

        var msgTxt:TextField=new TextField(400,80,msg);
        msgTxt.format.setTo(font,20,0xFFFFFF);
        msgTxt.autoScale=true;
//        msgTxt.x=15;
//        msgTxt.y=30;

//        var tryagain:Button=new Button();
//        tryagain.label="Click Here & Try Again";
//        tryagain.setSize(200,40);
//        tryagain.x=bg.width/2-100;
//        tryagain.y=145;
//        tryagain.labelFactory =  getItTextRender;

        var tryagain:Button=new Button();
        tryagain.setSize(400, 80);
        tryagain.addEventListener(Event.TRIGGERED, doTryAgainHandler);

        popup.x=Starling.current.stage.stageWidth-bg.width-5;
        popup.y=Starling.current.stage.stageHeight-bg.height-5;
        popup.addChild(bg);
        popup.addChild(msgTxt);
        popup.addChild(tryagain);


        PopUpManager.addPopUp(popup,false,false);

        DataContainer.popupMessage=true;



    }
    private function doTryAgainHandler(e:Event):void{
        DebugTrace.msg("PopupManager.doTryAgainHandler data="+JSON.stringify(data));

        //flox.save(this.attr,this.data);
        PopUpManager.removePopUp(popup,true);
        DataContainer.popupMessage=false;

    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }

}
}
