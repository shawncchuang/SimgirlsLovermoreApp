
/**
 * Created by shawnhuang on 2014-08-15.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;
import controller.SoundController;

import events.SceneEvent;

import feathers.controls.PanelScreen;

import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;

import feathers.controls.ToggleSwitch;
import feathers.controls.text.StageTextTextEditor;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextEditor;
import feathers.core.ITextRenderer;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import flash.display.StageDisplayState;

import flash.geom.Point;
import flash.text.TextFormat;

import starling.core.Starling;

import starling.display.Button;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;

public class SettingsScene extends Sprite{

    private var command:MainInterface=new MainCommand();
    private var scencom:SceneInterface=new SceneCommnad();
    private var base_sprite:Sprite;
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var toggle:Image;
    private var screenToggle:Image;
    private var enabled:Boolean=true;
    private var screenEnabled:Boolean=true;
    private var flox:FloxInterface=new FloxCommand();
    private var inputText:TextInput;
    private var nickname:String;
    public function SettingsScene():void{

        base_sprite=new Sprite();
        addChild(base_sprite);


        initializeHandler();

    }
    private function initializeHandler():void{



        scencom.init("SettingsScene",base_sprite,20);
//        scencom.start();
//        scencom.disableAll();


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="SETTINGS";
        templete.label="SETTINGS";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-456,408),to:new Point(-146,408)},
            {from:new Point(1478,-108),to:new Point(1168,-108)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();
        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(115,84),to:new Point(115,84)});
        templete.addMiniMenu();
        addChild(templete);


        var panel:Image=new Image(Assets.getTexture("SettingPanel"));
        panel.x=330;
        panel.y=200;
        addChild(panel);

        nickname = flox.getPlayerData("player_name");
        var title:String="Nickname (for online leaderboard)";
        var nicknametxt:TextField=new TextField(350,30,title);
        nicknametxt.format.setTo(font,20,0,"left");
        nicknametxt.x=330;
        nicknametxt.y=540;
        addChild(nicknametxt);

        var inputFieldTexture:Texture=Assets.getTexture("InputTextField");
        var inputField:Image=new Image(inputFieldTexture);
        inputField.x=330;
        inputField.y=565;
        addChild(inputField);

        inputText=new TextInput();
        inputText.width=inputField.width;
        inputText.height=inputField.height;
        inputText.x=inputField.x;
        inputText.y=inputField.y;
        inputText.maxChars=10;
        inputText.prompt=nickname;

        var textformat:Object=new Object();
        textformat.font=font;
        textformat.size=20;
        textformat.color=0x000000;
        inputText.promptFactory=function():ITextRenderer{
            var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
            textRenderer.styleProvider = null;
            textRenderer.textFormat = new TextFormat(textformat.font,textformat.size,0x999999);
            textRenderer.embedFonts = true;
            return textRenderer;
        };

        inputText.textEditorFactory=function():ITextEditor
        {
            var textEditor:StageTextTextEditor = new StageTextTextEditor();
            textEditor.styleProvider = null;
            textEditor.styleProvider = null;
            textEditor.fontFamily = textformat.font;
            textEditor.fontSize = textformat.size;
            textEditor.color = textformat.color;
            return textEditor;
        };

        addChild(inputText);

        var changeTexture:Texture=Assets.getTexture("IconChange");

        var change:Button=new Button(changeTexture);
        change.x=640;
        change.y=565;
        addChild(change);
        change.addEventListener(TouchEvent.TOUCH, onTouchChanged);


        /*
        var Mute:Boolean=SoundController.Mute;
        var soundtoggle:String="IconToggleDefault";
        if(Mute){
            soundtoggle="IconToggleDown";
        }
        toggle=new Image(Assets.getTexture(soundtoggle));
        toggle.useHandCursor=true;
        toggle.x=525;
        toggle.y=290;
        addChild(toggle);
        toggle.addEventListener(TouchEvent.TOUCH, toggleSwitchChangeHandler);
        */

        /*
        var fullscreenToggle:String="IconToggleDefault";
        screenToggle=new Image(Assets.getTexture(fullscreenToggle));
        screenToggle.useHandCursor=true;
        screenToggle.x=toggle.x;
        screenToggle.y=toggle.y+screenToggle.height+5;
        addChild(screenToggle);
        screenToggle.addEventListener(TouchEvent.TOUCH, screenToggleSwitchChangeHandler);
        */
    }
    private function toggleSwitchChangeHandler(e:TouchEvent):void{

        var toggle:Image =  e.currentTarget as Image;

        var began:Touch=e.getTouch(toggle,TouchPhase.BEGAN);
        //trace("SettingScene.toggleSwitchChangeHandler -> toggle.isSelected:",toggle.isSelected);
        if(began){

            if(enabled){
                enabled=false;

                toggle.texture=Assets.getTexture("IconToggleDown");
                SoundController.Mute=true;

            }else{
                enabled=true;
                toggle.texture=Assets.getTexture("IconToggleDefault");
                SoundController.Mute=false;
            }

        }
    }
    private function screenToggleSwitchChangeHandler(e:TouchEvent):void{

        var toggle:Image =  e.currentTarget as Image;

        var began:Touch=e.getTouch(toggle,TouchPhase.BEGAN);
        //trace("SettingScene.toggleSwitchChangeHandler -> toggle.isSelected:",toggle.isSelected);
        if(began){

            if(screenEnabled){
                screenEnabled=false;

                screenToggle.texture=Assets.getTexture("IconToggleDown");


            }else{
                screenEnabled=true;
                screenToggle.texture=Assets.getTexture("IconToggleDefault");

            }
            if(Starling.current.nativeStage.displayState == StageDisplayState.FULL_SCREEN)
            {
                Starling.current.nativeStage.displayState = StageDisplayState.NORMAL;
            }
            else
            {
                Starling.current.nativeStage.displayState = StageDisplayState.FULL_SCREEN;
            }


        }

    }


    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data)
    }

    private function onTouchChanged(e:TouchEvent):void{

        var btn:Button=e.currentTarget as Button;
        var began:Touch=e.getTouch(btn,TouchPhase.BEGAN);
        if(began){

            nickname=inputText.text;
            var spaces:RegExp = / /gi;
            nickname=nickname.replace(spaces,"");

            if(nickname!=""){

                var changedTexture:Texture=Assets.getTexture("IconChanged");
                btn.upState=changedTexture;
                flox.savePlayerData("player_name",nickname);
                command.updateStatistics();


//                flox.indicesPlayer("player_name == ?",nickname,onIndicesComplete,onIndicesError);
//                function onIndicesComplete(players:Array):void{
//                    if(players.length==0){
//
//                        var changedTexture:Texture=Assets.getTexture("IconChanged");
//                        btn.upState=changedTexture;
//                        flox.savePlayerData("player_name",nickname);
//                        command.updateStatistics();
//
//                    }else{
//
//                        var msg:String="Your nickname was already used. Please change another nickname.";
//                        var popup:PopupManager=new PopupManager();
//                        popup.msg=msg;
//                        popup.attr="";
//                        popup.init();
//
//                    }
//
//                }


            }

        }

    }
    private function onIndicesError(error:String,httpStatus:int):void {

        DebugTrace.msg("SettingScene.onIndicesError: " + error + " \nhttpStatus: " + httpStatus);
        var popup:PopupManager=new PopupManager();
        popup.msg=error;
        popup.attr="";
        popup.init();
    }

}
}
