/**
 * Created by shawnhuang on 2016-05-30.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import feathers.controls.TextInput;
import feathers.controls.text.StageTextTextEditor;
import feathers.core.ITextEditor;

import flash.desktop.Clipboard;
import flash.desktop.ClipboardFormats;

import services.LoaderRequest;

import starling.display.Button;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

public class ShareIDComponent extends Sprite{

    private var font:String="SimMyriadPro";
    private var flox:FloxInterface=new FloxCommand();
    private var ownerId:String="";

    private var clipboardTxt:String="After 14 years as the Most Played Dating Sim of all time;\n"+
        "The sequel to Simgirls, Lovemore, is finally out!!\n"+
        "For a limited time, try the first ever RS-RPG for free at\n"+
        "www.Blackspears.com\n"+
        "Get 5% off the game and every item by entering the code upon purchase.\n";

    public function ShareIDComponent() {
        init();
    }
    private function init():void{

        var texture:Texture=Assets.getTexture("SharedID_UI");
        var sharedBg:Image=new Image(texture);

        var format:Object=new Object();
        format.font=font;
        format.size=18;
        format.color=0x000000;

        ownerId=flox.getPlayerData("ownerId");

        var sharedTxt:TextField=new TextField(290,22,"");
        sharedTxt.format.setTo(font,format.size,format.color,"left");
        sharedTxt.x=28;
        sharedTxt.y=45;
        sharedTxt.text=ownerId;

        var copyTexture:Texture=Assets.getTexture("IconCopy");

        var copybtn:Button=new Button(copyTexture,"");
        copybtn.x=330;
        copybtn.y=42;
        copybtn.addEventListener(TouchEvent.TOUCH, onTouchCopy);

        var eMailTexture:Texture=Assets.getTexture("IconEmail");
        var eMailbtn:Button=new Button(eMailTexture,"");
        eMailbtn.x=415;
        eMailbtn.y=42;
        eMailbtn.addEventListener(TouchEvent.TOUCH, onTouchEmail);

        var helpTexture:Texture=Assets.getTexture("IconHelp");
        var help:Button=new Button(helpTexture,"");
        help.x=588;
        help.addEventListener(TouchEvent.TOUCH,onTouchHelp);

        this.addChild(sharedBg);
        this.addChild(sharedTxt);
        this.addChild(copybtn);
        this.addChild(eMailbtn);
        this.addChild(help);

    }
    private function onTouchCopy(e:TouchEvent):void{

        var btn:Button=e.currentTarget as Button;
        var began:Touch=e.getTouch(btn,TouchPhase.BEGAN);

        if(began){



            Clipboard.generalClipboard.clear();
            Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,clipboardTxt+ownerId);

            var copiedTexture:Texture=Assets.getTexture("IconCopied");
            btn.upState=copiedTexture;
        }

    }

    private function onTouchEmail(e:TouchEvent):void{

        var btn:Button=e.currentTarget as Button;
        var began:Touch=e.getTouch(btn,TouchPhase.BEGAN);

        if(began){
            var loaderReq:LoaderRequest=new LoaderRequest();
            var subject:String="It's my Citizenship Code";
            var body:String=clipboardTxt+ownerId;

            loaderReq.navigateToMail(subject,body);

        }

    }
    private function onTouchHelp(e:TouchEvent):void{
        var btn:Button= e.currentTarget as Button;
        var began:Touch= e.getTouch(btn,TouchPhase.BEGAN);
        if(began){


        }
    }
}
}
