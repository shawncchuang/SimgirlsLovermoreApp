/**
 * Created by shawnhuang on 15-09-24.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import feathers.controls.Alert;

import feathers.controls.Button;

import feathers.controls.PanelScreen;
import feathers.controls.ScrollContainer;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.core.PopUpManager;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;

import flash.text.TextFormat;

import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;

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
    private var font:String="SimMyriadPro";
    private var popup:Sprite;
    private var price:Number;

    public function BlackMarketListLayout() {

        this.height=340;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);

    }
    private function initializeHandler(e:Event):void{

        initMarketList();


    }
    private function initMarketList():void{


        marketlist=flox.getSyetemData("blackmarket");
        itemlist=new Array();

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
            nameHeader.x = itemImg.width + 10;
            nameHeader.hAlign = "left";
            itemRender.addChild(nameHeader);

            var nametTxt:TextField = new TextField(120, renderH, item.name, font, 20, 0, false);
            nametTxt.x = nameHeader.x;
            nametTxt.hAlign = "left";
            nametTxt.vAlign = "center";

            var priceHeader:TextField = new TextField(100, 16, "Price:", font, 12, 0x333333, true);
            priceHeader.x = 265;
            priceHeader.hAlign = "left";
            itemRender.addChild(priceHeader);
            var priceTxt:TextField = new TextField(100, renderH, item.price, font, 20, 0, false);
            priceTxt.x = priceHeader.x;
            priceTxt.hAlign = "left";
            priceTxt.vAlign = "center";

            var buyBtn:Button = new Button();
            buyBtn.x = priceTxt.x + 120;
            buyBtn.y = 20;
            buyBtn.scaleX = 0.4;
            buyBtn.scaleY = 0.4;
            var buyBtnUpTexture:Texture = Assets.getTexture("BuyButtonDe_Skin");
            var buyBtnDownTexture:Texture = Assets.getTexture("BuyButtonDown_Skin");
            buyBtn.defaultSkin = new Image(buyBtnUpTexture);
            buyBtn.downSkin = new Image(buyBtnDownTexture);
            buyBtn.addEventListener(Event.TRIGGERED, onTapBuyHandler);


            itemRender.addChild(itemImg);
            itemRender.addChild(nametTxt);
            itemRender.addChild(priceTxt);
            itemRender.addChild(buyBtn);
            addChild(itemRender);

            itemRender.addEventListener(TouchEvent.TOUCH,onTouchedHoverItem);

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

            msg = "Not enough Coin.";
            var scene:Sprite = ViewsContainer.MainScene;
            var alertMsg:AlertMessage=new AlertMessage(msg);
            scene.addChild(alertMsg);



        }

    }
    private function onTouchedHoverItem(e:TouchEvent):void{

        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        //var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        if(hover)
        {
            item_id=target.name;
            //DebugTrace.msg( "ShoppingListLayout.onTouchedHoverItem current_item="+current_item);
        }

    }
    private function addConfirmPoup(msg:String):void{

        var bgTexture:Texture=Assets.getTexture("PopupBg");
        var popup:Sprite=new Sprite();
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

            var _data:Object=new Object();
            _data.price=price;

            var scene:Sprite = ViewsContainer.currentScene;
            scene.dispatchEventWith("UPDAT_BLANCE_BLACKMARKET",false,_data);

        }

        function cancelButton_triggeredHandler():void{

            PopUpManager.removePopUp(popup,true);

        }

    }

    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 16, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }


}
}
