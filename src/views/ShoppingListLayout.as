/**
 * Created by shawnhuang on 15-08-14.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import feathers.controls.Button;
import feathers.controls.Label;

import feathers.controls.NumericStepper;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.controls.TextInput;
import feathers.events.FeathersEventType;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;
import feathers.text.BitmapFontTextFormat;


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

public class ShoppingListLayout extends PanelScreen {

    public var cate:String;
    private var flox:FloxCommand=new FloxCommand();
    private var assetsData:Object;
    private var assetslist:Array;
    private var payment:Object;
    private var current_item:String;
    private var steppers:Array;
    private var reseat_stepper:Boolean=false;

    public var sort:String;
    public var sort_index:Number=0;

    public function ShoppingListLayout() {


        this.height=320;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
    }
    private function initializeHandler(e:Event):void
    {
        assetsData=flox.getSyetemData("assets");
        payment=new Object();
        steppers=new Array();
        assetslist=new Array();

        for(var id:String in assetsData){
            var _assets:Object = assetsData[id];
            if(_assets.cate==cate) {
                var item:Object=new Object();
                item.id = id;
                item.name = assetsData[id].name;
                item.brand = assetsData[id].brand;
                item.price = assetsData[id].price;
                item.qty = 1;
                assetslist.push(item);
                //DebugTrace.msg( "ShoppingListLayout.initializeHandler id="+id+" ,name="+item.name);
            }

        }

        var layout:VerticalLayout=new VerticalLayout();
        layout.gap=2;
        layout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
        layout.verticalAlign=TiledRowsLayout.VERTICAL_ALIGN_TOP;
        layout.paddingTop = 0;
        layout.paddingRight = 0;
        layout.paddingBottom = 0;
        layout.paddingLeft =0;

        this.layout = layout;
        this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
        this.snapScrollPositionsToPixels = true;

        if(assetslist.length>0){

            switch(sort){
                case "expiration":
                    //expiration (Number)
                    if(sort_index==-1){
                        assetslist=assetslist.sortOn(sort,Array.NUMERIC | Array.DESCENDING);
                    }else if (sort_index==0){
                        assetslist=assetslist.sortOn(sort,Array.NUMERIC);
                    }
                    break;
                default:
                    //others (String)
                    if(sort_index==-1){
                        assetslist=assetslist.sortOn(sort,Array.CASEINSENSITIVE | Array.DESCENDING);
                    }else if (sort_index==0){
                        assetslist=assetslist.sortOn(sort,Array.CASEINSENSITIVE);
                    }

                    break
            }

        }

        var font:String="SimMyriadPro";
        for(var j:uint=0;j<assetslist.length;j++)
        {
            item=assetslist[j];


            var itemRender:Sprite=new Sprite();
            itemRender.name=item.id;

            var itemTt:Texture = Assets.getTexture(assetsData[item.id].texture);
            var itemImg:Image = new Image(itemTt);
            var renderH:Number=itemImg.height;


            var quad:Quad = new Quad(550, renderH, 0xffffff);
            itemRender.addChild(quad);

            var nameHeader:TextField=new TextField(50,16,"Name:",font,12,0x333333,true);
            nameHeader.x=itemImg.width+10;
            nameHeader.hAlign="left";
            itemRender.addChild(nameHeader);

            var nametTxt:TextField=new TextField(100,renderH,item.name,font,20,0,false);
            nametTxt.x=nameHeader.x;
            nametTxt.hAlign="left";
            nametTxt.vAlign="center";

            var brandHeader:TextField=new TextField(50,16,"Brand:",font,12,0x333333,true);
            brandHeader.x=215;
            brandHeader.hAlign="left";
            itemRender.addChild(brandHeader);
            var brandTxt:TextField=new TextField(100,renderH,item.brand,font,20,0,false);
            brandTxt.x=brandHeader.x;
            brandTxt.hAlign="left";
            brandTxt.vAlign="center";


            var priceHeader:TextField=new TextField(80,16,"Price:",font,12,0x333333,true);
            priceHeader.x=310;
            priceHeader.hAlign="left";
            itemRender.addChild(priceHeader);
            var _price:String=DataContainer.currencyFormat(item.price);
            var priceTxt:TextField=new TextField(80,renderH,_price,font,20,0,false);
            priceTxt.x=priceHeader.x;
            priceTxt.vAlign="center";
            priceTxt.hAlign="left";


            var qtyHeader:TextField=new TextField(40,16,"Qty:",font,12,0x333333,true);
            qtyHeader.x=380;
            qtyHeader.hAlign="left";
            itemRender.addChild(qtyHeader);
            var qtyStepper:NumericStepper = new NumericStepper();
            qtyStepper.buttonLayoutMode = NumericStepper.BUTTON_LAYOUT_MODE_SPLIT_HORIZONTAL;
            var incrementTexture:Texture = Assets.getTexture("IncrementButton");
            var decrementTexture:Texture = Assets.getTexture("DecrementButton");
            qtyStepper.incrementButtonProperties.defaultSkin = new Image(incrementTexture);
            qtyStepper.decrementButtonProperties.defaultSkin = new Image(decrementTexture);
            qtyStepper.textInputFactory = function():TextInput
            {
                var input:TextInput = new TextInput();
                //skin the text input here
                //input.backgroundSkin = new Scale9Image( backgroundTextures )
                input.verticalAlign =  TextInput.VERTICAL_ALIGN_MIDDLE;
                input.isEditable = false;
                input.padding=12;
                input.setSize(40,30);
                input.textEditorProperties.fontSize = 18;

                return input;
            }


            qtyStepper.x=qtyHeader.x;
            qtyStepper.y=qtyHeader.y+20;
            qtyStepper.width=140;
            qtyStepper.height=30;
            qtyStepper.minimum = 1;
            qtyStepper.maximum = 99;
            qtyStepper.step = 1;
            qtyStepper.value = 1;
            qtyStepper.scaleX = 0.8;
            qtyStepper.scaleY = 0.8;
            steppers.push(qtyStepper);
            qtyStepper.addEventListener( Event.CHANGE, onStepperChangeHandler);
            //qtyStepper.decrementButtonLabel = "-";
            //qtyStepper.incrementButtonLabel = "+";

            var buyBtn:Button=new Button();
            buyBtn.x=qtyHeader.x+120;
            buyBtn.y=20;
            buyBtn.scaleX = 0.4;
            buyBtn.scaleY = 0.4;
            var buyBtnUpTexture:Texture=Assets.getTexture("BuyButtonDe_Skin");
            var buyBtnDownTexture:Texture=Assets.getTexture("BuyButtonDown_Skin");
            buyBtn.defaultSkin = new Image(buyBtnUpTexture);
            buyBtn.downSkin = new Image(buyBtnDownTexture);
            buyBtn.addEventListener(Event.TRIGGERED, onTapBuyHandler);

            itemRender.addChild(itemImg);
            itemRender.addChild(nametTxt);
            itemRender.addChild(brandTxt);
            itemRender.addChild(priceTxt);
            itemRender.addChild(qtyStepper);
            itemRender.addChild(buyBtn);
            addChild(itemRender);

            itemRender.addEventListener(TouchEvent.TOUCH,onTouchedHoverItem);
        }

    }
    private function onTapBuyHandler(e:Event):void{

        //var target:Sprite=e.currentTarget as Sprite;

        var scene:Sprite = ViewsContainer.MainScene;
        var cash:Number=flox.getSaveData("cash");
        var price:Number= assetsData[current_item].price;
        var amount:Number=0;
        if(!payment[current_item])
        {
            payment[current_item]=1;
        }
        amount=payment[current_item] * price;


//        for(var attr:String in payment)
//        {
//            DebugTrace.msg("ShoppingListLayout.onTapBuyHandler attr="+attr+", value="+payment[attr]);
//
//        }

        if(cash>amount)
        {
            //can pay for it

            var value_data:Object = new Object();
            value_data.attr = "cash";
            value_data.values = String(amount*-1);
            var command:MainInterface = new MainCommand();
            command.displayUpdateValue(scene, value_data);

            cash-=amount;
            flox.save("cash",cash);
            onSavedComplete();
        }
        else
        {
            //can't purchars in this time
            var msg:String = "Not enough money.";
            var alertMsg:AlertMessage=new AlertMessage(msg);
            scene.addChild(alertMsg);

        }
        initLayout();

    }
    private function initLayout():void
    {
        reseat_stepper=true;

        for(var i:uint=0;i<steppers.length;i++)
        {
            steppers[i].value=1;
        }
        payment=new Object();
        reseat_stepper=false;

    }

    private function onTouchedHoverItem(e:TouchEvent):void{
        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        if(hover)
        {
            current_item=target.name;
            //DebugTrace.msg( "ShoppingListLayout.onTouchedHoverItem current_item="+current_item);
        }


    }
    private function onStepperChangeHandler(e:Event):void
    {
        var stepper:NumericStepper = NumericStepper(e.currentTarget);

        if(!reseat_stepper){
            //DebugTrace.msg( "ShoppingListLayout.onStepperChangeHandler ,value changed:"+ stepper.value);
            payment[current_item]=stepper.value;
        }


    }


    private function onSavedComplete():void
    {


        var gameinfo:Sprite = ViewsContainer.gameinfo;
        gameinfo.dispatchEventWith("UPDATE_INFO", false);

        var scene:Sprite=ViewsContainer.currentScene;
        scene.dispatchEventWith("SHOPPING_PAIED");


        var evtObj:Object = new Object();
        var scene_name:String = DataContainer.currentScene;
        evtObj.command = "Gifts@"+scene_name+"_"+current_item;
        flox.logEvent("Buy", evtObj);


        saveMyAssets();


    }
    private function saveMyAssets():void{

        var ownedAssets:Object=flox.getSaveData("owned_assets");
        var my_assets:Array=ownedAssets.player;
        var payment_list:Array=new Array();

        if(payment)
        {
            for(var id:String in payment)
            {
                DebugTrace.msg( "ShoppingListLayout.saveMyAssets id="+id+" ,payment="+payment[id]);
                payment_list.push(id);
            }

        }

        var assets_index:Number=-1;
        for(var i:uint=0;i<my_assets.length;i++)
        {
            var assetsObj:Object=my_assets[i];
            if(payment_list==assetsObj.id)
            {
                //already had this

                assets_index=i;
                break

            }
        }
        if(assets_index!=-1)
        {
            //already had this
            assetsObj=my_assets[assets_index];
            assetsObj.qty+=payment[assetsObj.id];
            assetsObj.expiration=100;
            my_assets[assets_index]=assetsObj;

        }else{
            //new assets
            var _assets:Object=new Object();
            _assets.id=payment_list[0];
            _assets.qty=payment[payment_list[0]];
            _assets.expiration=100;
            my_assets.push(_assets);

        }

        ownedAssets.player=my_assets;
        flox.save("owned_assets",ownedAssets);
    }

}


}
