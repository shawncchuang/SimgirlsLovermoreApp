/**
 * Created by shawnhuang on 15-12-02.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;

import flash.text.TextFormat;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;


public class PopupManager extends Sprite{

    private var popup:Sprite;
    private var font:String="SimMyriadPro";
    public var attr:String;
    public var data:*;
    public var msg:String;
    private var flox:FloxInterface=new FloxCommand();

    public function init():void {


        popup=new Sprite();

        var bgTexture:Texture=Assets.getTexture("PopupBg");
        var bg:Image=new Image(bgTexture);

        var msgTxt:TextField=new TextField(370,80,msg,font,16,0,false);
        msgTxt.x=15;
        msgTxt.y=30;

        var tryagain:Button=new Button();
        tryagain.label="Click Here & Try Again";
        tryagain.setSize(200,40);
        tryagain.x=bg.width/2-100;
        tryagain.y=145;
        //tryagain.defaultIcon
        //tryagain.downIcon
        tryagain.labelFactory =  getItTextRender;
        tryagain.addEventListener(Event.TRIGGERED, doTryAgainHandler);

        popup.addChild(bg);
        popup.addChild(msgTxt);
        popup.addChild(tryagain);

        PopUpManager.addPopUp(popup,true);


    }
    private function doTryAgainHandler(e:Event):void{
        DebugTrace.msg("PopupManager.doTryAgainHandler data="+JSON.stringify(data));

        //flox.save(this.attr,this.data);
        PopUpManager.removePopUp(popup,true);

    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }
}
}
