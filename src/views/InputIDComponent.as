/**
 * Created by shawnhuang on 2016-05-30.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;


import feathers.controls.TextInput;
import feathers.controls.text.StageTextTextEditor;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextEditor;
import feathers.core.ITextRenderer;

import flash.text.TextFormat;

import starling.display.Button;

import starling.display.Image;
import starling.display.Sprite;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class InputIDComponent extends Sprite {
    private var font:String="SimMyriadPro";
    private var inputTxt:TextInput;
    private var command:MainInterface=new MainCommand();
    private var flox:FloxInterface=new FloxCommand();

    public function InputIDComponent() {
        init();
    }
    private function init():void{


        var texture:Texture=Assets.getTexture("InputID_UI");
        var inputBg:Image=new Image(texture);

        var format:Object=new Object();
        format.font=font;
        format.size=18;
        format.color=0x000000;

        inputTxt=new TextInput();
        inputTxt.prompt="Enter Citizenship Code here.";
        inputTxt.isEditable=true;
        inputTxt.x=28;
        inputTxt.y=45;
        inputTxt.setSize(290,22);

        var parentId:String=flox.getPlayerData("parentId");
        if(parentId){
            inputTxt.text=parentId;
        }

        inputTxt.promptFactory=function():ITextRenderer{
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.styleProvider = null;
            textRenderer.textFormat = new flash.text.TextFormat( format.font, format.size, 0xD7D6D6 );
            textRenderer.embedFonts = true;
            return textRenderer;
        };

        inputTxt.textEditorFactory=function():ITextEditor
        {
            var textEditor:StageTextTextEditor = new StageTextTextEditor();
            textEditor.styleProvider = null;
            textEditor.fontFamily = format.font;
            textEditor.fontSize = format.size;
            textEditor.color = format.color;
            textEditor
            return textEditor;
        };

        var confirmTexture:Texture=Assets.getTexture("IconConfirm");
        var confirm:Button=new Button(confirmTexture,"");
        confirm.x=330;
        confirm.y=42;
        confirm.addEventListener(TouchEvent.TOUCH, onTouchConfirm);


        var dismissTexture:Texture=Assets.getTexture("IconDismiss");
        var dismiss:Button=new Button(dismissTexture,"");
        dismiss.x=415;
        dismiss.y=42;
        dismiss.addEventListener(TouchEvent.TOUCH, onTouchDismiss);


        var helpTexture:Texture=Assets.getTexture("IconHelp");
        var help:Button=new Button(helpTexture,"");
        help.x=588;
        help.addEventListener(TouchEvent.TOUCH,onTouchHelp);


        this.addChild(inputBg);
        this.addChild(inputTxt);
        this.addChild(confirm);
        this.addChild(dismiss);
        this.addChild(help);

    }
    private function onTouchConfirm(e:TouchEvent):void{
        var btn:Button=e.currentTarget as Button;
        var began:Touch=e.getTouch(btn,TouchPhase.BEGAN);

        if(began){

            var spaces:RegExp = / /gi;
            var id:String=inputTxt.text;
            id=id.replace(spaces,"");

            //query player ID
            var cons:String="ownerId == ?";
            flox.indicesPlayer(cons,id,onIndicsComplete,onIndicesError);


        }
    }
    private function onIndicsComplete(players:Array):void{

        if(players.length>0){

            var response:String=command.praseBundlePool(players[0].ownerId);
            var popup:PopupManager=new PopupManager();
            popup.attr="bundle";
            popup.msg=response;
            popup.init();

            var current_scene:Sprite=ViewsContainer.currentScene;
            var parentId:String=flox.getPlayerData("parentId");
            if(parentId && parentId!=""){

                current_scene.dispatchEventWith("REFLASH_LISTLAYOUT");

            }

        }

    }
    private function onIndicesError(error:String):void
    {

        DebugTrace.msg("IndicesError: " + error);
        var msg:String="This Shambala ID is invalid.\nPlease input correct Shambala ID.";
        var popup:PopupManager=new PopupManager();
        popup.attr="bundle";
        popup.msg=msg;
        popup.init();


    }

    private function  onTouchDismiss(e:TouchEvent):void{
        var btn:Button= e.currentTarget as Button;
        var began:Touch= e.getTouch(btn,TouchPhase.BEGAN);

        if(began){

            var parentId:String=flox.getPlayerData("parentId");
            if(parentId!="" || parentId){
                command.dismissBundle();
                flox.savePlayerData("parentId","");
                inputTxt.text="";
                var current_scene:Sprite=ViewsContainer.currentScene;
                current_scene.dispatchEventWith("REFLASH_LISTLAYOUT");

                var msg:String="Success!\n Your bundle Shambala ID dismissed.";
                var popup:PopupManager=new PopupManager();
                popup.attr="bundle";
                popup.msg=msg;
                popup.init();
            }

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
