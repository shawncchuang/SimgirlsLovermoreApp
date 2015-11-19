/**
 * Created by shawnhuang on 15-11-05.
 */
package views {

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import feathers.events.FeathersEventType;

import flash.geom.Rectangle;

import starling.display.Button;

import starling.display.Image;
import starling.display.Sprite;

import starling.events.Event;
import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

import utils.DebugTrace;
import utils.ViewsContainer;

public class ShoppingClothesListLayout extends Sprite {
    private var flox:FloxInterface = new FloxCommand();
    private var gender:String = "";
    //upperbody/lowerbody
    private var cate:String = "upperbody";

    private var items:Array = new Array();
    private var current_item:Object = new Object();
    private var itemname:TextField;
    private var price:TextField;
    private var numbers:TextField;

    private var itemIndex:Number = 0;
    private var itemMax:Number = 0;
    private var font:String = "SimMyriadPro";

    private var arrowLeft:Button;
    private var arrowRight:Button;

    //private var itemImg:Image;
    private var itemSprite:Sprite;

    public function ShoppingClothesListLayout() {

        var avatar:Object = flox.getSaveData("avatar");
        gender = avatar.gender;
        initItems();
        initItemInfo();
        initCateHandler();
        initSwitchController();
        initBuyHandler();

    }

    public function initItems():void {

        items=new Array();
        var itemsdata:Array = flox.getSyetemData(cate + "items");
        for (var i:uint = 0; i < itemsdata.length; i++) {
            if (itemsdata[i].gender == gender) {

                items.push(itemsdata[i]);

            }

        }
        itemMax=items.length;
        initItemImage();

    }

    private function initItemImage():void {

        var posY:Number=460 / 2;
        var scale:Number=0.7;
        if (cate == "upperbody") {
            var _cate:String = "Clothes";
            if(gender=="Female"){
                posY+=50;
                scale=0.6;
            }
            if(gender=="Male" && _cate=="Clothes"){
                posY+=20;
            }

        } else {
            _cate = "PantsStyle";
        }
        current_item = items[itemIndex];
        var texture:Texture = Assets.getTexture(gender + _cate);
        var atalsXML:XML = Assets.getAtalsXML(gender + _cate + "XML");
        var textureAtlas:TextureAtlas = new TextureAtlas(texture, atalsXML);
        var itemTexture:Texture = textureAtlas.getTexture(current_item.type + current_item.id);
        var itemImg:Image = new Image(itemTexture);
        itemSprite=new Sprite();
        itemSprite.addChild(itemImg);
        itemSprite.pivotX = itemSprite.width / 2;
        itemSprite.pivotY = itemSprite.height / 2;
        itemSprite.x = 611 / 2;
        itemSprite.y = posY;
        itemSprite.scaleX = scale;
        itemSprite.scaleY = scale;
        if(itemSprite.height>220){

            itemSprite.clipRect=new flash.geom.Rectangle(-(itemSprite.pivotX/2),-(itemSprite.pivotY/2),itemSprite.width*2,440);
        }

        addChild(itemSprite);


    }

    private function initItemInfo():void {

        itemname = new TextField(245, 30, current_item.name, font, 25, 0x4A4A4A, true);
        itemname.pivotX = itemname.width / 2;
        itemname.x = 611 / 2;
        itemname.y = 94;


        var signTexture:Texture = Assets.getTexture("DollarSign");
        var dollaSign:Image = new Image(signTexture);
        dollaSign.x = 460;
        dollaSign.y = 82;

        var priceStr:String = DataContainer.currencyFormat(current_item.price);
        price = new TextField(140, 43, priceStr, "SimNeogreyMedium", 36, 0x4A4A4A, true);
        price.hAlign = "right";
        price.x = dollaSign.x + dollaSign.width;
        price.y = 86;
        price.autoSize = TextFieldAutoSize.HORIZONTAL;


        var current:String = (itemIndex + 1) + " / " + items.length;
        numbers = new TextField(200, 24, current, "SimNeogreyMedium", 20, 0x97CAF3, true);
        numbers.pivotX = numbers.width / 2;
        numbers.x = 611 / 2;
        numbers.y = 389;

        addChild(itemname);
        addChild(price);
        addChild(numbers);
        addChild(dollaSign);
    }
    private function initCateHandler():void{

        var upperTexture:Texture = Assets.getTexture("cateUpperbodyIcon");
        var uppercate:Button=new Button(upperTexture);
        uppercate.name="upperbody";
        uppercate.width=90;
        uppercate.height=37.42;
        uppercate.x=338;
        uppercate.y=21;

        var lowerTexture:Texture = Assets.getTexture("cateLowerbodyIcon");
        var lowercate:Button=new Button(lowerTexture);
        lowercate.name="lowerbody";
        lowercate.width=90;
        lowercate.height=37.42;
        lowercate.x=460;
        lowercate.y=21;

        uppercate.addEventListener(Event.TRIGGERED,onChangedCate);
        lowercate.addEventListener(Event.TRIGGERED,onChangedCate);

        addChild(uppercate);
        addChild(lowercate);

    }

    private function onChangedCate(e:Event):void{

        var target:Button=e.currentTarget as Button;
        cate=target.name;
        itemIndex = 0;
        itemSprite.removeFromParent(true);
        arrowLeft.visible = false;
        arrowRight.visible = true;

        initItems();
        updateItemInfo();




    }
    public function initSwitchController():void {

        var arrowTexture:Texture = Assets.getTexture("IconArrowPhotos");
        arrowLeft = new Button(arrowTexture);
        arrowLeft.name = "prev";
        arrowLeft.x = 70;
        arrowLeft.y = 168;
        arrowLeft.color = 0x4A90E2;
        arrowLeft.useHandCursor = true;
        arrowLeft.visible = false;

        arrowRight = new Button(arrowTexture);
        arrowRight.name = "next";
        arrowRight.scaleX = -1;
        arrowRight.x = 490 + arrowRight.width;
        arrowRight.y = 168;
        arrowRight.color = 0x4A90E2;
        arrowRight.useHandCursor = true;


        addChild(arrowLeft);
        addChild(arrowRight);

        arrowLeft.addEventListener(Event.TRIGGERED, doSelectLowerStyle);
        arrowRight.addEventListener(Event.TRIGGERED, doSelectLowerStyle);
    }

    private function doSelectLowerStyle(e:Event):void {

        var target:Button = e.currentTarget as Button;
        var dir:String = target.name;

        arrowLeft.visible = true;
        arrowRight.visible = true;
        switch (dir) {
            case "prev":
                itemIndex--;
                if (itemIndex < 0) {
                    itemIndex = 0;

                }
                if(itemIndex==0)
                    arrowLeft.visible = false;
                break
            case "next":
                itemIndex++;
                if(itemIndex == itemMax-1)
                    arrowRight.visible = false;
                if (itemIndex >= itemMax - 1) {
                    itemIndex = itemMax - 1;

                }
                break

        }


        updateItemInfo();
    }

    private function updateItemInfo():void {


        current_item = items[itemIndex];
        itemname.text = current_item.name;
        var priceStr:String = DataContainer.currencyFormat(current_item.price);
        price.text = priceStr;
        numbers.text = (itemIndex + 1) + " / " + itemMax;

        itemSprite.removeFromParent(true);
        initItemImage();

    }

    private function initBuyHandler():void {

        var buyBtnUpTexture:Texture = Assets.getTexture("BuyButtonDe_Skin");
        var buyBtnDownTexture:Texture = Assets.getTexture("BuyButtonDown_Skin");
        var buyBtn:Button = new Button(buyBtnUpTexture, "", buyBtnDownTexture);
        buyBtn.width = 80;
        buyBtn.height = 40;
        buyBtn.x = 480;
        buyBtn.y = 383;
        addChild(buyBtn);
        buyBtn.addEventListener(Event.TRIGGERED, onTapBuyHandler)
    }

    private function onTapBuyHandler(e:Event):void {

        var cash:Number=flox.getSaveData("cash");
        var avatar:Object=flox.getSaveData("avatar");
        var list:Array=avatar[cate];
        var cashpass:Boolean=false;
        var bought:Boolean=false;
        var scene:Sprite = ViewsContainer.MainScene;
        var msg:String="";
        if(current_item.price<cash){
            cashpass=true;
        }else{

            //can't purchars in this time

            msg = "Not enough money.";
            var alertMsg:AlertMessage=new AlertMessage(msg);
            scene.addChild(alertMsg);
        }

        if(list.indexOf(current_item.id)!=-1){
            // already bought before
            bought=true;

            msg = "You already have this one.";
            alertMsg=new AlertMessage(msg);
            scene.addChild(alertMsg);

        }
        if(cashpass && !bought){
            list.push(current_item.id);
            avatar[cate]=list;
            flox.save("avatar",avatar);

            var amount:Number=current_item.price;
            var value_data:Object = new Object();
            value_data.attr = "cash";
            value_data.values = String(amount*-1);
            var command:MainInterface = new MainCommand();
            command.displayUpdateValue(scene, value_data);

            cash-=amount;
            flox.save("cash",cash);


            var gameinfo:Sprite = ViewsContainer.gameinfo;
            gameinfo.dispatchEventWith("UPDATE_INFO", false);

            scene.dispatchEventWith("SHOPPING_PAIED");

            var evtObj:Object = new Object();
            var scene_name:String = DataContainer.currentScene;
            evtObj.command = "Clothes@"+scene_name+"_"+JSON.stringify(current_item);
            flox.logEvent("Buy", evtObj);



        }

    }
}
}
