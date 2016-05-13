/**
 * Created by shawnhuang on 2014-08-15.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;
import controller.SoundController;

import events.SceneEvent;

import feathers.controls.PanelScreen;

import feathers.controls.ScrollContainer;

import feathers.controls.ToggleSwitch;
import feathers.events.FeathersEventType;
import feathers.layout.HorizontalLayout;
import feathers.layout.VerticalLayout;

import flash.display.StageDisplayState;

import flash.geom.Point;

import starling.core.Starling;

import starling.display.Button;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

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
        panel.y=270;
        addChild(panel);



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
}
}
