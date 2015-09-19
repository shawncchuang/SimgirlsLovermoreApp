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

import flash.geom.Point;

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
    private var enabled:Boolean=true;
    public function SettingsScene():void{

        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();

        initializeHandler();

    }
    private function initializeHandler():void{



        scencom.init("SettingsScene",base_sprite,20);
//        scencom.start();
//        scencom.disableAll();


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="SETTINGS";
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



        toggle=new Image(Assets.getTexture("IconSoundToggleDefault"));
        toggle.useHandCursor=true;
        toggle.x=525;
        toggle.y=290;
        addChild(toggle);
        toggle.addEventListener(TouchEvent.TOUCH, toggleSwitchChangeHandler);
        /*
         var toggle:ToggleSwitch=new ToggleSwitch();
         toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_ON_OFF;
         toggle.setSize(91,55);
         toggle.x=525;
         toggle.y=402;
         toggle.isSelected=false;
         toggle.addEventListener(Event.CHANGE,toggleSwitchChangeHandler);
         // setInitializerForClass( Button, toggleSwitchCustomThumbInitializer, "my-custom-thumb" );
         addChild(toggle);



         toggle.thumbFactory=function():Button{
         var btn:Button=new Button();
         // btn.defaultSkin=new Image(Assets.getTexture("IconSoundToggleDefault"));
         // btn.downSkin=new Image(Assets.getTexture("IconSoundToggleDown"));
         btn.defaultIcon=new Image(Assets.getTexture("IconSoundToggleDefault"));
         // btn.downIcon=new Image(Assets.getTexture("IconSoundToggleDown"));
         return btn;
         }
         */

    }
    private function toggleSwitchChangeHandler(e:TouchEvent):void{

        var toggle:Image =  e.currentTarget as Image;

        var began:Touch=e.getTouch(toggle,TouchPhase.BEGAN);
        //trace("SettingScene.toggleSwitchChangeHandler -> toggle.isSelected:",toggle.isSelected);
        if(began){

            if(enabled){
                enabled=false;

                toggle.texture=Assets.getTexture("IconSoundToggleDown");
                SoundController.Mute=true;

            }else{
                enabled=true;
                toggle.texture=Assets.getTexture("IconSoundToggleDefault");
                SoundController.Mute=false;
            }
            trace(enabled);



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
