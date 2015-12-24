/**
 * Created by shawnhuang on 15-09-24.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

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

    public function BlackMarketListLayout() {

        this.height=340;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
        this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedStageHandler);


    }
    private function initializeHandler(e:Event):void{


        if(type=="Buy"){
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


            var itemTt:Texture = Assets.getTexture(item.texture);
            var itemImg:Image = new Image(itemTt);
            var renderH:Number = itemImg.height;

            var quad:Quad = new Quad(550, renderH, 0xffffff);
            itemRender.addChild(quad);

            var nameHeader:TextField = new TextField(50, 16, "Name:", font, 12, 0x333333, true);
            nameHeader.x =  10;
            nameHeader.hAlign = "left";
            itemRender.addChild(nameHeader);

            var nametTxt:TextField = new TextField(120, renderH, item.name, font, 20, 0, false);
            nametTxt.x = nameHeader.x;
            nametTxt.hAlign = "left";
            nametTxt.vAlign = "center";

            var priceHeader:TextField = new TextField(100, 16, "Price:", font, 12, 0x333333, true);
            priceHeader.x = 265;
            priceHeader.hAlign = "left";

            var priceTxt:TextField = new TextField(100, renderH, item.price, font, 20, 0, false);
            priceTxt.x = priceHeader.x;
            priceTxt.hAlign = "left";
            priceTxt.vAlign = "center";

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
                renderBtn.addEventListener(Event.TRIGGERED, onTapUseHandler);
            }

            //itemRender.addChild(itemImg);
            itemRender.addChild(nametTxt);
            if(type=="Buy")
            {
                itemRender.addChild(priceHeader);
                itemRender.addChild(priceTxt);
            }


            itemRender.addChild(renderBtn);
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
        //DebugTrace.msg("BlackTileList.onPurchaseItem coin:"+coin+" ; price:"+price);

        var msg:String ="";
        if(coin>=price)
        {
            //enough pay this item

            msg="Are you sure you want to parchase this item ?\nNo refund or exchange at the Black market.";

            addConfirmPoup(msg);

        }
        else
        {

            msg = "Not enough USD.";
            var scene:Sprite = ViewsContainer.MainScene;
            var alertMsg:AlertMessage=new AlertMessage(msg);
            scene.addChild(alertMsg);

        }

    }
    private function onTapUseHandler(e:Event):void{
    //tap use
        var popupMsg:String="Use this item?\nWarning! Once it is used it will be gone for good.\n" +
                "Make sure you save your game afterwards.";

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
        var msgTxt:TextField=new TextField(370,80,msg,font,16,0,false);
        msgTxt.x=15;
        msgTxt.y=30;

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
                var _data:Object=new Object();
                _data.price=price;
                _data.item_id=item_id;
                var scene:Sprite=ViewsContainer.currentScene;
                scene.dispatchEventWith("BUY_BLACKMARKET_ITEM",false,_data);
                //var command:MainInterface=new MainCommand();
                //command.addToBlackMarketItemCollection(item_id);

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
