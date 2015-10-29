/**
 * Created by shawnhuang on 15-09-30.
 */
package views {
import model.BattleData;

import starling.display.Sprite;
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.Config;

import events.GameEvent;
import events.SceneEvent;

import feathers.controls.Button;


import feathers.controls.PanelScreen;
import feathers.controls.PickerList;
import feathers.controls.ScrollContainer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;


import flash.geom.Point;
import flash.text.TextFormat;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;

import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;


public class TimeMachinePopup extends Sprite {



    public var msg:String="";
    private var font:String;
    private var popup:Sprite;
    private var monthPicker:PickerList;
    private var datePicker:PickerList;

    private var monthStr:String="Mar";
    private var month:Number=-1;
    private var dateStr:String="1";
    private var date:Number=-1;
    private var yearStr:String="2033";

    public var item_id:String;

    private var flox:FloxInterface=new FloxCommand();

    public function TimeMachinePopup() {


        this.addEventListener("REMOVED_FROM_SCENE",onRemovedStageHandler);

    }
    public function init():void{

        popup=new Sprite();
        var bgTexture:Texture=Assets.getTexture("PopupBg");
        var bg:Image=new Image(bgTexture);
        font=BlackMarketListLayout.font;
        var msgTxt:TextField=new TextField(370,80,msg,font,16,0,false);
        msgTxt.x=15;
        msgTxt.y=30;


        var monthslist:Array=Config.PickerMonthslist;
        var listdata:Array=new Array();
        for(var i:uint=0;i<monthslist.length;i++){

            var collection:Object=new Object();

            collection["text"]=monthslist[i];
            listdata.push(collection);
        }
        monthPicker=addPickList("Month",new Point(65,110),listdata);
        monthPicker.addEventListener(Event.CHANGE, onMonthListChangedHandler);

        praseDataPakerList("add");


        var yearlist:Array=new Array("2033","2034");
        listdata=new Array();
        for(var j:uint=0;j<yearlist.length;j++){

            collection=new Object();

            collection["text"]=yearlist[j];
            listdata.push(collection);
        }
        var yearPicker:PickerList=addPickList("Year",new Point(270,110),listdata);
        yearPicker.addEventListener(Event.CHANGE, onYearListChangedHandler);


        var okBtn:Button=new Button();
        okBtn.label="OK";
        okBtn.x=90;
        okBtn.y=145;
        okBtn.setSize(80,40);
        okBtn.labelFactory =  getItTextRender;
        okBtn.addEventListener(Event.TRIGGERED, useTimeMachindHandler);

        var cancelBtn:Button=new Button();
        cancelBtn.label="Cancel";
        cancelBtn.x=220;
        cancelBtn.y=145;
        cancelBtn.setSize(80,40);
        cancelBtn.labelFactory =  getItTextRender;
        cancelBtn.addEventListener(Event.TRIGGERED, cancelButton_triggeredHandler);


        popup.addChild(bg);
        popup.addChild(msgTxt);
        popup.addChild(monthPicker);
        popup.addChild(datePicker);
        popup.addChild(yearPicker);
        popup.addChild(okBtn);
        popup.addChild(cancelBtn);
        PopUpManager.addPopUp( popup, true, true );


    }
    private function onMonthListChangedHandler(e:Event):void{

        var list:PickerList = PickerList( e.currentTarget );
        var item:Object = list.selectedItem;
        var index:int = list.selectedIndex;
        DebugTrace.msg("BlackMarketListLayout.onMonthListChangedHandler  item.text="+item.text+" ; index="+index);
        monthStr=item.text;
        month=index;

        praseDataPakerList("update");

    }

    private function praseDataPakerList(type:String):void{


        var dateMax:Object=Config.Months;
        var listdata:Array=new Array();

        for(var i:uint=0;i<dateMax[monthStr];i++){

            var collection:Object=new Object();

            collection["text"]=i+1;
            listdata.push(collection);
        }
        if(type=="add"){


            datePicker=addPickList("Date",new Point(165,110),listdata);
            datePicker.addEventListener(Event.CHANGE, onDateListChangedHandler);

        }else{
            //update
            var listcollection:ListCollection = new ListCollection(listdata);
            datePicker.dataProvider = listcollection;
            addRemindEffect(datePicker);

        }


    }
    private function onDateListChangedHandler(e:Event):void{
        var list:PickerList = PickerList( e.currentTarget );
        var item:Object = list.selectedItem;
        var index:int = list.selectedIndex;
        dateStr=item.text;
        date=index;

    }

    private function onYearListChangedHandler(e:Event):void{

        var list:PickerList = PickerList( e.currentTarget );
        var item:Object = list.selectedItem;
        //var index:int = list.selectedIndex;
        yearStr=item.text;
        updateMonthList();



    }
    private function updateMonthList():void{

        var monthslist:Array=Config.PickerMonthslist;
        var listdata:Array=new Array();


        if(yearStr=="2034"){
            monthslist=["Jan","Feb"];
        }
        for(var i:uint=0;i<monthslist.length;i++){

            var collection:Object=new Object();

            collection["text"]=monthslist[i];
            listdata.push(collection);
        }

        var listcollection:ListCollection = new ListCollection(listdata);
        monthPicker.dataProvider = listcollection;
        addRemindEffect(monthPicker);

    }

    private function useTimeMachindHandler(e:Event):void{

        PopUpManager.removePopUp(popup,true);
        var dateObj:Date=new Date(Number(yearStr),month,date);
        var daylist:Array=Config.Days;
        var dayStr:String=daylist[dateObj.day];
        //Tue.1.Mar.2033|24
        DebugTrace.msg(dayStr+"."+dateStr+"."+monthStr+"."+yearStr);
        var pickerDate:String=dayStr+"."+dateStr+"."+monthStr+"."+yearStr+"|12";
        if(month == -1 || date==-1){

            var msg:String= "You didn't choice a day yet.";
            var scene:Sprite = ViewsContainer.MainScene;
            var alertMsg:AlertMessage=new AlertMessage(msg);
            scene.addChild(alertMsg);


        }else{

            //close item list
            var currentScene:Sprite=ViewsContainer.currentScene;
            currentScene.dispatchEventWith("USE_BLACKMARTET_ITEM");

            flox.save("date",pickerDate,onTimeTravel);
        }

    }
    private function onTimeTravel(result:*=null):void{

        DebugTrace.msg("TimeMachinePopup.onTimeTravel");


        var _data:Object=new Object();
        _data.item_id=item_id;
        var scene:Sprite=ViewsContainer.currentScene;
        scene.dispatchEventWith("CONSUME_BLACKMARKET_ITEM",false,_data);



        var command:MainInterface=new MainCommand();
        command.updateInfo();

        var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvent._name="clear_comcloud";
        gameEvent.displayHandler();

        var scene_data:Object=new Object();
        scene_data.name="MainScene";
        command.sceneDispatch(SceneEvent.CHANGED,scene_data);


        var battleData:BattleData=new BattleData();
        battleData.checkBattleSchedule("TimeTravelBattleRanking","cpu_team");


    }




    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }
    private function getPickListTsxtRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 12, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;

    }

    private function addPickList(name:String,point:Point,data:Array):PickerList{

        var list:PickerList = new PickerList();
        list.x=point.x;
        list.y=point.y;
        list.width=70;
        list.height=30;
        var listcollection:ListCollection = new ListCollection(data);
        list.dataProvider = listcollection;

        //list.listProperties.backgroundSkin = new Quad( 10, 10, 0xFFFFFF );
        list.listProperties.itemRendererFactory = function():IListItemRenderer {

            var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            renderer.labelField = "text";
            renderer.setSize(68,30);
            renderer.defaultSkin=new Quad( 68, 30, 0xFFFFFF );
            renderer.hoverSkin=new Quad( 68, 30, 0xD8D8D8 );
            renderer.labelFactory=getPickListTsxtRender;
            return renderer;
        };
        list.labelField = "text";
        var defaultBg:Texture=Assets.getTexture("PickList_Time_BG_Skin");
        list.buttonProperties.defaultSkin = new Image( defaultBg );
        list.prompt = name;

        list.selectedIndex = -1;
        list.buttonFactory = function():Button
        {
            //default button
            var button:Button = new Button();
            button.labelFactory=getPickListTsxtRender;

            return button;
        };

//        list.popUpContentManager = new DropDownPopUpContentManager();
//        var popUpContentManager:VerticalCenteredPopUpContentManager = new VerticalCenteredPopUpContentManager();
//        popUpContentManager.marginTop = 20;
//        popUpContentManager.marginRight = 25;
//        popUpContentManager.marginBottom = 20;
//        popUpContentManager.marginLeft = 25;
//        list.popUpContentManager = popUpContentManager;
        return list;

    }




    private function cancelButton_triggeredHandler(e:Event):void{


        PopUpManager.removePopUp(popup,true);

    }


    private function addRemindEffect(target:PickerList):void{

        var tween:Tween=new Tween(target,0.5,Transitions.EASE_OUT_ELASTIC);
        tween.animate("y", target.y-5);
        tween.animate("y", target.y);
        //tween.reset(target,0.3,Transitions.LINEAR);
        // tween.onComplete=onTweenComplete;
        Starling.juggler.add(tween);


    }
    private function onRemovedStageHandler(e:Event):void{

        try{
            PopUpManager.removePopUp(popup,true);
        }catch(eorrpr:Error){

        }
    }
}
}
