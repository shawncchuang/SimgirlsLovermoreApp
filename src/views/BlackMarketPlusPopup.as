/**
 * Created by shawnhuang on 15-09-30.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.ViewCommand;
import controller.ViewInterface;

import events.SceneEvent;

import feathers.controls.Button;
import feathers.controls.ToggleSwitch;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import feathers.core.PopUpManager;

import flash.text.TextFormat;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class BlackMarketPlusPopup extends Sprite {

    public var msg:String;
    public var item_id:String;
    private var popup:Sprite=null;
    private var font:String;
    private var viewcom:ViewInterface=new ViewCommand();
    private var character:String="";
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var toggle:ToggleSwitch;
    private var toggled:Boolean=false;
    public function BlackMarketPlusPopup() {

        this.addEventListener("REMOVED_FROM_SCENE",onRemovedStageHandler);

    }
    public function init():void{
        character=null;

        popup=new Sprite();
        var bgTexture:Texture=Assets.getTexture("PopupBg");
        var bg:Image=new Image(bgTexture);
        font=BlackMarketListLayout.font;
        var msgTxt:TextField=new TextField(370,80,msg,font,16,0,false);
        msgTxt.x=15;
        msgTxt.y=30;
        popup.addEventListener("TouchedIcon",onTouchCharaterIcon);


        var okBtn:Button=new Button();
        okBtn.label="OK";
        okBtn.x=90;
        okBtn.y=145;
        okBtn.setSize(80,40);
        okBtn.labelFactory =  getItTextRender;
        okBtn.addEventListener(Event.TRIGGERED, usePlusItemHandler);

        var cancelBtn:Button=new Button();
        cancelBtn.label="Cancel";
        cancelBtn.x=220;
        cancelBtn.y=145;
        cancelBtn.setSize(80,40);
        cancelBtn.labelFactory =  getItTextRender;
        cancelBtn.addEventListener(Event.TRIGGERED, cancelButton_triggeredHandler);


        popup.addChild(bg);
        popup.addChild(msgTxt);

        switch(item_id){
            case "bm_1":
            case "bm_7":
                character="player";
                break
            case "bm_2":
            case "bm_3":
            case "bm_4":
            case "bm_5":
            case "bm_6":
                viewcom.characterIcons(popup,"blackmarket");
                break
            case "bm_8":
            case "bm_9":
                addToggleSwitch();
                break

        }

        popup.addChild(okBtn);
        popup.addChild(cancelBtn);
        PopUpManager.addPopUp( popup, true, true );


    }
    private function onTouchCharaterIcon(e:Event):void
    {

        var ch_index:Number = e.data.ch_index;
        character = e.data.character;
        DebugTrace.msg("BlackMarketPlusPopu. onTouchCharaterIcon ch_index="+ch_index+" ,character="+character);


    }
    private function usePlusItemHandler(e:Event):void{


        if(character) {

            var blackmarket:Object=flox.getSyetemData("blackmarket");
            var command_type:String=blackmarket[item_id]["command"];
            var command_entities:Object=flox.getSyetemData("command");
            var values:Object=command_entities[command_type].values;
            var rewards:Object = new Object();

            for(var attr:String in values){

                rewards[attr] = values[attr];

            }
            if(attr=="cash"){
                var current_cash:Number=flox.getSaveData(attr);
                current_cash += rewards[attr];
                flox.save(attr, current_cash);
            }else{
                var savedata:Object=flox.getSaveData(attr);
                var current_data:Number= savedata[character];
                savedata[character]=current_data+values[attr];
                flox.save(attr,savedata);

                if(attr=="love"){
                    flox.save("se",savedata);
                }

            }
            PopUpManager.removePopUp(popup,true);


            var current_scene:Sprite=ViewsContainer.currentScene;
            command.showCommandValues(current_scene,attr,rewards);

            var gameinfo:Sprite = ViewsContainer.gameinfo;
            gameinfo.dispatchEventWith("UPDATE_INFO");

            var _data:Object=new Object();
            _data.item_id=item_id;
            current_scene.dispatchEventWith("CONSUME_BLACKMARKET_ITEM",false,_data);

            var tween:Tween= new Tween(this,1,Transitions.LINEAR);
            tween.onComplete=onRewardAniComplete;
            Starling.juggler.add(tween);


        }else if(item_id=="bm_8" || item_id=="bm_9") {

            var items:Object=flox.getPlayerData("items");
            items[item_id]["enable"]=toggled;
            flox.savePlayer("items");

            var _se:Number=0;
            var _pts:Number=0;
            var _skills:Object=new Object();
            if(item_id=="bm_8" && toggled){
                character="prms";
                _se=5555;
                _pts=9999;
                _skills={
                    "neutral": "",
                    "air": "a0,a1,a2,a3",
                    "com": "",
                    "water": "w0,w1,w2,w3",
                    "earth": "e0,e1,e2,e3",
                    "exp": "n",
                    "fire": "f0,f1,f2,f3"
                }

            }else if (item_id=="bm_8" && !toggled){
                character="prms";
                _se=0;
                _pts=0;
            }

            if(item_id=="bm_9" && toggled){
                character="smn";
                _se=9999;
                _pts=9999;
                _skills={
                    "neutral": "n0,n1,n2,n3",
                    "air": "a0,a1,a2,a3",
                    "com": "",
                    "water": "w0,w1,w2,w3",
                    "earth": "e0,e1,e2,e3",
                    "exp": "n",
                    "fire": "f0,f1,f2,f3"
                }


            }else if (item_id=="bm_8" && !toggled){
                character="smn";
                _se=0;
                _pts=0;
            }

            var se:Object=flox.getSaveData("se");
            se[character]=_se;

            var pts:Object=flox.getSaveData("pts");
            pts[character]=_pts;

            flox.save("se",se);
            flox.save("pts",pts);

            var loves:Object=flox.getSaveData("love");
            loves[character]=_se;
            flox.save("love",loves);

            var skills:Object=flox.getSaveData("skills");
            skills[character]=_skills;
            flox.save("skills",skills);


            toggle.dispose();
            toggle.removeFromParent(true);
            PopUpManager.removePopUp(popup,true);

        }else
        {

            PopUpManager.removePopUp(popup,true);
            var msg:String = "Opps! Choose a character icon first.";
            var scene:Sprite = ViewsContainer.MainScene;
            var alertMsg:AlertMessage=new AlertMessage(msg);
            scene.addChild(alertMsg);


        }


    }
    private function  addToggleSwitch():void{

        toggle = new ToggleSwitch();
        toggle.showLabels=false;
        toggle.trackLayoutMode = ToggleSwitch.TRACK_LAYOUT_MODE_ON_OFF;
        toggle.toggleDuration=0;
        var deBtnImg:Image= new Image( Assets.getTexture("IconToggleDefault") );
        toggle.onTrackProperties.defaultSkin = deBtnImg;
        toggle.offTrackProperties.defaultSkin = new Image(Assets.getTexture("IconToggleDown") );
        toggle.x=popup.width/2- deBtnImg.width/2;
        toggle.y=85;
        toggle.addEventListener( Event.CHANGE, toggle_changeHandler );

        var items:Object=flox.getPlayerData("items");
        if(items[item_id].enable){
            toggled=toggle.isSelected =items[item_id].enable;
        }else{
            toggle.isSelected=toggled;
        }
        popup.addChild(toggle)
    }
    private function toggle_changeHandler(e:Event):void{

        var toggle:ToggleSwitch = ToggleSwitch( e.currentTarget );
        toggled=toggle.isSelected;
        DebugTrace.msg("toggle.isSelected changed:"+ toggle.isSelected +" ,item_id="+item_id );

    }

    private function onRewardAniComplete():void{

        Starling.juggler.removeTweens(this);
        var _data:Object=new Object();
        _data.name="BlackMarketScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }
    private function cancelButton_triggeredHandler(e:Event):void{


        if(toggle){
            toggle.dispose();
            toggle.removeFromParent(true);
        }

        PopUpManager.removePopUp(popup,true);

    }
    private function onRemovedStageHandler(e:Event):void{


        try{
            PopUpManager.removePopUp(popup,true);
        }catch(eorrpr:Error){

        }

    }


}
}
