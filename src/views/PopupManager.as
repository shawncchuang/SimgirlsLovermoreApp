/**
 * Created by shawnhuang on 15-12-02.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;

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
import utils.ViewsContainer;


public class PopupManager extends Sprite{

    private var popup:Sprite=null;
    private var font:String="SimMyriadPro";
    public var attr:String;
    public var data:*;
    public var msg:String;
    private var bg:*;
    private var msgTxt:TextField;
    private var btn:Button;


    public function init():void {



        popup=new Sprite();

        var isCentered:Boolean=false;
        var isModal:Boolean=false;
        switch(attr){

            case "payout":
            case "bonus":
            case "bundle":
                isCentered=true;
                isModal=true;
                bonusLayout();

                break;
            default:
                defaultLayout();

                break

        }

        popup.addChild(bg);
        popup.addChild(msgTxt);
        popup.addChild(btn);



        PopUpManager.addPopUp(popup,isModal,isCentered);
        DataContainer.popupMessage=true;


    }
    private function defaultLayout():void{
        var stageW:Number=Starling.current.stage.stageWidth;
        bg = new Quad(stageW, 60, 0x000000 );
        if(attr=="memory"){
            bg=new Quad( stageW, 60, 0xEF1F22 );
        }

        msgTxt=new TextField(stageW,60,msg);
        msgTxt.format.setTo(font,20,0xFFFFFF);
        msgTxt.autoScale=true;
        btn=new Button();
        btn.setSize(stageW, 60);
        btn.addEventListener(Event.TRIGGERED, doTryAgainHandler);


        //popup.x=Starling.current.stage.stageWidth-bg.width-5;
        popup.y=Starling.current.stage.stageHeight-bg.height-3;
    }
    private function bonusLayout():void{


        var bgTexture:Texture=Assets.getTexture("PopupBg");
        bg=new Image(bgTexture);


        msgTxt=new TextField(400,80,msg);
        msgTxt.format.setTo(font,20,0x000000);
        msgTxt.autoScale=true;
        msgTxt.x=15;
        msgTxt.y=30;


        btn=new Button();
        btn.label="Close";
        btn.setSize(200,40);
        btn.x=bg.width/2-100;
        btn.y=145;
        btn.labelFactory =  getItTextRender;
        if(attr=="payout"){
            btn.addEventListener(Event.TRIGGERED, doTryAgainHandler);
        }else{
            btn.addEventListener(Event.TRIGGERED, doBonusConfirmHandler);
        }

    }

    private function doTryAgainHandler(e:Event):void{
        DebugTrace.msg("PopupManager.doTryAgainHandler data="+JSON.stringify(data));

        //flox.save(this.attr,this.data);
        PopUpManager.removePopUp(popup,true);
        DataContainer.popupMessage=false;

    }
    private function doBonusConfirmHandler(e:Event):void{
        PopUpManager.removePopUp(popup,true);
        DataContainer.popupMessage=false;


        var flox:FloxInterface=new FloxCommand();
        var rewards:Object=flox.getPlayerData("rewards");
        var coin:Number=flox.getPlayerData("coin");
        coin+=Config.BONUS_COIN;
        if(!rewards){
            rewards=new Object();
        }
        rewards.bonus_coin=true;
        flox.savePlayer({"coin":coin,"rewards":rewards});


    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }

}
}
