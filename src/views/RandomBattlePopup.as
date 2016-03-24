/**
 * Created by shawnhuang on 15-10-06.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;

import flash.text.TextFormat;

import model.BattleData;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;

public class RandomBattlePopup extends Sprite {

    private var popup:Sprite;
    private var font:String="SimMyriadPro";
    private var command:MainInterface=new MainCommand();

    public function RandomBattlePopup() {
    }
    public function init():void{

        var msg:String="Got into a street fight !!";
        var current_scene:String=DataContainer.currentScene;
        var scene:String=current_scene.split("Scene").join("");
        var criminals:Array=DataContainer.Criminals;
        var se:Number=0;
        for(var i:uint=0;i<criminals.length;i++){
            var location:String=criminals[i].location;
            if(location==scene){
                se=criminals[i].se;
                break
            }
        }
        msg+="\n Enemy's average SE\n"+se;

        popup=new Sprite();
        var bgTexture:Texture=Assets.getTexture("PopupBg");
        var bg:Image=new Image(bgTexture);

        var msgTxt:TextField=new TextField(370,200,msg);
        msgTxt.format.setTo(font,25);
        msgTxt.x=15;


        var okBtn:Button=new Button();
        okBtn.label="Fight";
        okBtn.x=90;
        okBtn.y=145;
        okBtn.setSize(80,40);
        okBtn.labelFactory =  getItTextRender;
        okBtn.addEventListener(Event.TRIGGERED, fightHandler);


        var flox:FloxInterface=new FloxCommand();
        var sysCommand:Object = flox.getSyetemData("command");
        var avoid:Number=sysCommand.RunAwayRandomBattle.values.cash;
        var cancelBtn:Button=new Button();
        cancelBtn.label="Pay Pizzo $"+avoid;
        cancelBtn.x=220;
        cancelBtn.y=145;
        cancelBtn.setSize(100,40);
        cancelBtn.labelFactory =  getItTextRender;
        cancelBtn.addEventListener(Event.TRIGGERED, runawayTriggeredHandler);


        popup.addChild(bg);
        popup.addChild(msgTxt);
        popup.addChild(okBtn);
        popup.addChild(cancelBtn);
        PopUpManager.addPopUp( popup, true, true );
    }
    private function fightHandler(e:Event):void{

        var battledata:BattleData=new BattleData();
        var survivor:Boolean=battledata.checkSurvivor();

        if(!survivor){
            e.currentTarget.removeEventListener(Event.TRIGGERED, fightHandler);
            command.consumeHandle("NoSurvivor");

        }else{
            PopUpManager.removePopUp(popup,true);


            var _data:Object = new Object();
            _data.name = "ChangeFormationScene";
            _data.from="random_battle";
            command.sceneDispatch(SceneEvent.CHANGED, _data);


        }



    }
    private function runawayTriggeredHandler(e:Event):void {

        DebugTrace.msg("RandomBattlePopup.runawayTriggeredHandler currentScene="+DataContainer.currentScene);
        PopUpManager.removePopUp(popup,true);
        DataContainer.battleType="";

        command.consumeHandle("RunAwayRandomBattle");

        var tween:Tween=new Tween(this,0.5);
        tween.delay=0.5;
        tween.onComplete=onCompletePay;
        Starling.juggler.add(tween);


    }
    private function onCompletePay():void{

        Starling.juggler.removeTweens(this);
        command.addShortcuts();

        var _data:Object = new Object();
        _data.name = DataContainer.currentScene;
        command.sceneDispatch(SceneEvent.CHANGED, _data);


    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }
}
}
