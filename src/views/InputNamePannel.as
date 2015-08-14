package views {
import flash.display.MovieClip;
import flash.events.MouseEvent;

import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;

import data.DataContainer;

import flash.text.TextField;

import model.SaveGame;

public class InputNamePannel extends MovieClip {
    private var inputnameUI:MovieClip;
    private var flox:FloxInterface = new FloxCommand();
    private var saveComplete:Function;

    public function InputNamePannel(callback:Function) {
        saveComplete = callback;
        inputnameUI = new InputNameUI();
        //inputnameUI.x=290;
        //inputnameUI.y=667;
        var firstname:TextField = inputnameUI.firstname.text;
        firstname.maxChars = 15;
        var lastname:TextField = inputnameUI.lastname.text;
        lastname.maxChars = 15;
        inputnameUI.submit.addEventListener(MouseEvent.CLICK, doSubmit);

        addChild(inputnameUI);
    }

    private function doSubmit(e:MouseEvent):void {

        var succuss:Boolean = true;
        if (inputnameUI.firstname.text == "" || inputnameUI.lastname.text == "") {
            var msg:String = "Please input your fisrt name or last name";
            MainCommand.addAlertMsg(msg);
            succuss = false;
        }
        if (succuss) {
            var _data:Object = new Object();
            _data.first_name = inputnameUI.firstname.text;
            _data.last_name = inputnameUI.lastname.text;
            DataContainer.player = _data;

            flox.save("first_name", _data.first_name, onFisrtNameSaveComplete);


        }
        //if
    }

    private function onFisrtNameSaveComplete(savegame:SaveGame):void {
        var _data:Object = DataContainer.player;
        flox.save("last_name", _data.last_name, onLastNameSaveComplete);
    }

    private function onLastNameSaveComplete(savegame:SaveGame):void {

        saveComplete();
        var _data:Object = new Object();
        _data.talk_index = 0
    }
}
}