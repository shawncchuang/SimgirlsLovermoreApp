/**
 * Created by shawnhuang on 15-09-24.
 */
package views {
import com.gamua.flox.TimeScope;

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import feathers.controls.Button;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;
import feathers.events.FeathersEventType;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;


import flash.text.TextFormat;

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

import views.PopupManager;

public class BlackMarketListLayout extends PanelScreen {

    private var flox:FloxInterface=new FloxCommand();
    private var itemlist:Array;
    private var marketlist:Object;
    private var item_id:String;
    public static var font:String="SimMyriadPro";
    private var price:Number;

    public var type:String;

    private var BUTTON_MOUSEUP_TEXTURE:String="";
    private var BUTTON_MOUSEDOWN_TEXTURE:String="";

    private var popup:Sprite=null;
    private var popupTM:TimeMachinePopup=null;
    private var popupPlus:BlackMarketPlusPopup=null;

    private var itemRenderlist:Array;
    private var renderBtns:Array;

    private var discount:Boolean=false;
    private var discount_rate:Number=0;


    private var popupMsg:String="Use this item?\nWarning! Once it is used it will be gone for good.\n"+
            "<font color='#FF0000'>We highly recommend saving the game progress after using them.</font>";

    public function BlackMarketListLayout() {


        this.height=340;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
        this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedStageHandler);


    }
    private function initializeHandler(e:Event):void{


        if(type=="Buy"){

            var parentId:String=flox.getPlayerData("parentId");
            var rewards:Object= flox.getBundlePool("rewards");
            if(parentId && parentId!=""){
                //have discount
                discount=true;
                discount_rate=BlackMarketScene.discount_rate;
            }
            marketlist=flox.getSyetemData("blackmarket");
            BUTTON_MOUSEUP_TEXTURE="BuyButtonDe_Skin";
            BUTTON_MOUSEDOWN_TEXTURE="BuyButtonDown_Skin";

        }else{
            marketlist=flox.getPlayerData("items");
            BUTTON_MOUSEUP_TEXTURE="UseButtonDe_Skin";
            BUTTON_MOUSEDOWN_TEXTURE="UseButtonDown_Skin";
        }

        initMarketList();


    }
    private function initMarketList():void{


        itemlist=new Array();
        itemRenderlist=new Array();
        renderBtns=new Array();


        for(var id:String in marketlist){
            var _item:Object = marketlist[id];

            var item:Object=new Object();
            item.id = id;
            item.name = _item.name;
            item.price = _item.price;
            item.exc = _item.exc;
            item.texture= _item.texture;
            itemlist.push(item);
        }
        itemlist.sortOn("price",Array.NUMERIC|Array.DESCENDING);
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

        for(var j:uint=0;j<itemlist.length;j++) {
            item = itemlist[j];

            var itemRender:Sprite = new Sprite();
            itemRender.name = item.id;


//            var itemTt:Texture = Assets.getTexture(item.texture);
//            var itemImg:Image = new Image(itemTt);
//            var renderH:Number = itemImg.height;
            var renderH:Number =60;

            var quad:Quad = new Quad(550, renderH, 0xffffff);
            itemRender.addChild(quad);

            var nameHeader:TextField = new TextField(50, 16, "Name:");
            nameHeader.x =  10;
            nameHeader.format.setTo(font,12,0x333333,"left");
            itemRender.addChild(nameHeader);

            var nameTxt:TextField = new TextField(150, renderH, item.name);
            nameTxt.x = nameHeader.x;
            nameTxt.format.setTo(font,20,0x000000,"left");

            var priceHeader:TextField = new TextField(100, 16, "Price:");
            priceHeader.x = 265;
            priceHeader.format.setTo(font,12,0x333333,"left");


            var price_color:Number=0x000000;
            var price:Number=Number(item.price);

            if(discount){
                price_color=0xD0021B;
                price*=(1-discount_rate);
                item.price=price.toFixed(2);
            }

            var priceTxt:TextField = new TextField(100, renderH,item.price);
            priceTxt.x = priceHeader.x;
            priceTxt.format.setTo(font,20,price_color,"left");

            var renderBtn:Button = new Button();
            renderBtn.x = priceTxt.x + 120;
            renderBtn.y = 20;
            renderBtn.scaleX = 0.4;
            renderBtn.scaleY = 0.4;
            var renderBtnUpTexture:Texture = Assets.getTexture(BUTTON_MOUSEUP_TEXTURE);
            var renderBtnDownTexture:Texture = Assets.getTexture(BUTTON_MOUSEDOWN_TEXTURE);
            renderBtn.defaultSkin = new Image(renderBtnUpTexture);
            renderBtn.downSkin = new Image(renderBtnDownTexture);
            if(type=="Buy")
            {
                renderBtn.addEventListener(Event.TRIGGERED, onTapBuyHandler);
            }else{
                //use layout
                renderBtn.addEventListener(Event.TRIGGERED, onTapUseHandler);
            }

            //itemRender.addChild(itemImg);
            itemRender.addChild(nameTxt);
            if(type=="Buy")
            {
                itemRender.addChild(priceHeader);
                itemRender.addChild(priceTxt);
                itemRender.addChild(renderBtn);
            }else{
                //use
                if(item.id!="bm_10"){
                    itemRender.addChild(renderBtn);
                }
            }

            addChild(itemRender);

            itemRender.addEventListener(TouchEvent.TOUCH,onTouchedHoverItem);

            itemRenderlist.push(itemRender);
            renderBtns.push(renderBtn);
        }

    }
    private function onTapBuyHandler(e:Event):void{


        var coin:Number=flox.getPlayerData("coin");

        DebugTrace.msg("BlackTileList.onPurchaseItem item_id:"+item_id);
        price=Number(marketlist[item_id].price);

        if(discount){

            price*=(1-discount_rate);
            price=Number(price.toFixed(2));
        }

        //DebugTrace.msg("BlackTileList.onPurchaseItem coin:"+coin+" ; price:"+price);

        var msg:String ="Are you sure you want to parchase this item ?\nNo refund or exchange at the Black market.";
        var alertMsg:AlertMessage;
        var paid:Boolean=flox.getPlayerData("paid");
        var scene:Sprite = ViewsContainer.MainScene;
        //the player is  a citizenship
        if(coin>=price)
        {
            //enough USD to purchase this item

            if(!paid){
                //the player is not a citizenship
                if(item_id=="bm_10"){
                    //citizenship card
                    addConfirmPoup(msg);
                }else{
                    //other items
                    msg="You must have a citizenship to approve using Black Market.";
                    alertMsg=new AlertMessage(msg);
                    scene.addChild(alertMsg);
                }

            }else{
                //the player is a citizenship
                if(item_id=="bm_10"){
                    msg="You already owned a Citizenship Card.";
                    alertMsg=new AlertMessage(msg);
                    scene.addChild(alertMsg);
                }else{
                    addConfirmPoup(msg);
                }

            }

        }
        else
        {

            msg = "Not enough USD.";
            alertMsg=new AlertMessage(msg);
            scene.addChild(alertMsg);

        }

    }
    private function onTapUseHandler(e:Event):void{
        //tap use

        switch(item_id){
            case "bm_1":
                //TimeMachine

                popupTM=new TimeMachinePopup();
                popupTM.item_id=item_id;
                popupTM.msg=popupMsg;
                popupTM.init();

                break
            case "bm_2":
            case "bm_3":
            case "bm_4":
            case "bm_5":
            case "bm_6":
            case "bm_7":
            case "bm_2_1":
            case "bm_4_1":
            case "bm_5_1":
            case "bm_6_1":
            case "bm_7_1":
                popupPlus=new BlackMarketPlusPopup();
                popupPlus.item_id=item_id;
                popupPlus.msg=popupMsg;
                popupPlus.init();
                break

            case "bm_8":
            case "bm_9":
                //bm_8 :primero ; bm_9:simman
                popupMsg="Enable primero or simman";
                popupPlus=new BlackMarketPlusPopup();
                popupPlus.item_id=item_id;
                popupPlus.msg=popupMsg;
                popupPlus.init();
                break

        }


    }
    private function onTouchedHoverItem(e:TouchEvent):void{

        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);

        //var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        var _data:Object=new Object();
        var scene:Sprite=ViewsContainer.currentScene;
        if(hover)
        {
            item_id=target.name;
            _data._visible=true;
            _data.desc=marketlist[item_id].desc;
            scene.dispatchEventWith("UPDATE_DESC",false,_data);
            //DebugTrace.msg( "ShoppingListLayout.onTouchedHoverItem current_item="+current_item);
        }else {

            _data._visible = false;
            scene.dispatchEventWith("UPDATE_DESC", false, _data);


        }


    }
    private function addConfirmPoup(msg:String):void{

        var bgTexture:Texture=Assets.getTexture("PopupBg");
        popup=new Sprite();
        var bg:Image=new Image(bgTexture);
        var msgTxt:TextField=new TextField(370,80,msg);
        msgTxt.x=15;
        msgTxt.y=30;
        msgTxt.format.setTo(font,16,0);

        var okBtn:Button=new Button();
        okBtn.label="OK";
        okBtn.x=90;
        okBtn.y=145;
        okBtn.setSize(80,40);
        okBtn.labelFactory =  getItTextRender;
        okBtn.addEventListener(Event.TRIGGERED, okButton_triggeredHandler);

        var cancelBtn:Button=new Button();
        cancelBtn.label="Cancel";
        cancelBtn.x=220;
        cancelBtn.y=145;
        cancelBtn.setSize(80,40);
        cancelBtn.labelFactory =  getItTextRender;
        cancelBtn.addEventListener(Event.TRIGGERED, cancelButton_triggeredHandler);

        popup.addChild(bg);
        popup.addChild(msgTxt);
        popup.addChild(okBtn);
        popup.addChild(cancelBtn);
        PopUpManager.addPopUp( popup, true, true );

        function okButton_triggeredHandler(e:Event):void{

            PopUpManager.removePopUp(popup,true);

            var success:Boolean=checkCurrentItem();

            if(success){

                //GodRewards
                var command:MainInterface=new MainCommand();
                command.playSound("GodRewards");

                if(item_id=="bm_10"){
                    //citizenship card
                    flox.savePlayer({"paid":true});
                }

                var _data:Object=new Object();
                _data.price=price;
                _data.item_id=item_id;
                _data.createAt=new Date().toLocaleString();
                var scene:Sprite=ViewsContainer.currentScene;
                scene.dispatchEventWith("BUY_BLACKMARKET_ITEM",false,_data);

                var parentId:String=flox.getPlayerData("parentId");
                if(parentId && parentId!=""){
                    var rewards:Object=flox.getBundlePool("rewards");

                    if(rewards[parentId]) {
                        if (rewards[parentId].enable) {
                            var dePrice:Number = Number(marketlist[item_id].price);
                            dePrice *= (BlackMarketScene.rewards_rate);
                            var extra_coin:Number = rewards[parentId].coin;
                            extra_coin += dePrice;
                            rewards[parentId].coin = Number(extra_coin.toFixed(2));

                            var withdraw:Number= rewards[parentId].withdraw;
                            withdraw+=dePrice;
                            rewards[parentId].withdraw=Number(withdraw.toFixed(2));

                            flox.saveBundlePool("rewards", rewards);


                            /*
                            var msg:String="The Shambala ID you bundled increasing USD bonus.";
                            var reminder:PopupManager=new PopupManager();
                            reminder.msg=msg;
                            reminder.init();
                            */
                        }

                    }

                }


            }else{

                var msg:String= "You already owned this.";
                var mainscene:Sprite = ViewsContainer.MainScene;
                var alertMsg:AlertMessage=new AlertMessage(msg);
                mainscene.addChild(alertMsg);

            }


        }


    }

    private function checkCurrentItem():Boolean{

        var success:Boolean=true;
        var flox:FloxInterface=new FloxCommand();
        var items:Object=flox.getPlayerData("items");
        for(var id:String in items){

            if(id==item_id){
                success=false;
                break
            }
        }
        return success;

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
    private function onRemovedStageHandler(e:Event):void{

        DebugTrace.msg("BlackMarketListLayout.onRemovedStageHandler");

        for(var i:uint=0;i<itemRenderlist.length;i++){
            var itembtn:Button= renderBtns[i];
            itembtn.removeFromParent(true);

            var itemrender:Sprite=itemRenderlist[i];
            itemrender.removeFromParent(true);
        }


        try{
            PopUpManager.removePopUp(popup,true);

        }catch (error:Error){

        }
        if(popupTM){
            popupTM.dispatchEventWith("REMOVED_FROM_SCENE");

        }

        if(popupPlus){
            popupPlus.dispatchEventWith("REMOVED_FROM_SCENE");
        }

    }
    private function cancelButton_triggeredHandler(e:Event):void{


        PopUpManager.removePopUp(popup,true);

    }



}
}
