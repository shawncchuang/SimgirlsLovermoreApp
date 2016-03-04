/*
 * Created by shawn on 2014-08-11.
 */
package views {

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.DataContainer;



import feathers.controls.List;

import feathers.controls.PanelScreen;

import feathers.layout.TiledRowsLayout;
import feathers.controls.ScrollContainer;
import feathers.layout.VerticalLayout;
import feathers.events.FeathersEventType;

import flash.geom.Point;
import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.display.Quad;


import utils.DebugTrace;

import utils.ViewsContainer;

public class AssetsTiledLayout extends PanelScreen{

    public var chname:String="";
    public var sort:String="";
    public var sort_index:Number=0;
    public var cate:String="";
    private var flox:FloxInterface=new FloxCommand();
    private var assetsData:Object;
    private var _list:List;
    private var assetslist:Array;
    private var ownedAssets:Array;
    public var type:String;
    private var item_id:String;
    private var sendIcons:Array;
    private var submited:Boolean=false;
    public function AssetsTiledLayout() {



        this.height=300;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);


    }
    private function initializeHandler(e:Event):void{



        DebugTrace.msg("AssetsTiledLayout.initializeHandler chname="+chname);
        DebugTrace.msg("AssetsTiledLayout.initializeHandler type="+type);

        assetsData=flox.getSyetemData("assets");
        ownedAssets=flox.getSaveData("owned_assets")[chname];

        assetslist=new Array();
        var item:Object;
        for(var i:uint=0;i<ownedAssets.length;i++)
        {
            var id:String=ownedAssets[i].id;
            if(assetsData[id].cate==cate) {
                item = new Object();
                item.id = id;
                item.name = assetsData[item.id].name;
                item.brand = assetsData[item.id].brand;
                item.expiration = ownedAssets[i].expiration;
                item.qty = ownedAssets[i].qty;
                assetslist.push(item);
            }
        }
        //for

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


        var font:String="SimMyriadPro";
        sendIcons=new Array();
        for(var j:uint=0;j<assetslist.length;j++) {

            item=assetslist[j];

            var itemRender:Sprite=new Sprite();
            itemRender.name=item.id;
            itemRender.useHandCursor=true;

            var itemTt:Texture = Assets.getTexture(assetsData[item.id].texture);
            var itemImg:Image = new Image(itemTt);
            var renderH:Number=itemImg.height;


            var quad:Quad = new Quad(530, renderH, 0xffffff);
            itemRender.addChild(quad);


            var nameHeader:TextField=new TextField(50,16,"Name:");
            nameHeader.x=itemImg.width+10;
            nameHeader.format.setTo(font,12,0x333333,"left");


            var nametTxt:TextField=new TextField(100,renderH,item.name);
            nametTxt.x=nameHeader.x;
            nametTxt.format.setTo(font,20,0x000000,"left");


            var brandHeader:TextField=new TextField(50,16,"Brand:");
            brandHeader.x=220;
            brandHeader.format.setTo(font,12,0x333333,"left");
            itemRender.addChild(brandHeader);
            var brandTxt:TextField=new TextField(100,renderH,item.brand);
            brandTxt.x=brandHeader.x;
            brandTxt.format.setTo(font,20,0x000000,"left");


            var expirHeader:TextField=new TextField(80,16,"Expiration:");
            expirHeader.x=340;
            expirHeader.format.setTo(font,12,0x333333,"left");
            itemRender.addChild(expirHeader);

            var expirTxt:TextField=new TextField(80,renderH,item.expiration);
            expirTxt.x=expirHeader.x;
            expirTxt.format.setTo(font,20,0x000000,"left");


            var qtyHeader:TextField=new TextField(50,16,"Qty:");
            qtyHeader.x=450;
            qtyHeader.format.setTo(font,12,0x333333,"left");

            itemRender.addChild(qtyHeader);
            var qtyTxt:TextField=new TextField(30,renderH,item.qty);
            qtyTxt.x=qtyHeader.x;
            qtyTxt.format.setTo(font,20,0x000000,"left");


            var btnTexture:Texture=Assets.getTexture("CheckAltUp");
            var sendImg:Image=new Image(btnTexture);
            sendImg.name=item.id;
            sendImg.width=45;
            sendImg.height=45;
            sendImg.x=485;
            sendImg.y=Math.floor((renderH-sendImg.height)/2);


            itemRender.addChild(nameHeader);
            itemRender.addChild(itemImg);
            itemRender.addChild(nametTxt);
            itemRender.addChild(brandTxt);
            itemRender.addChild(expirTxt);
            itemRender.addChild(qtyTxt);
            itemRender.addChild(qtyHeader);
            itemRender.addEventListener(TouchEvent.TOUCH,onTouchedHoverItem);
            if(type=="give"){
                itemRender.addChild(sendImg);
                sendIcons.push(sendImg);
                sendImg.addEventListener(TouchEvent.TOUCH,onTouchedItem);
            }


            addChild(itemRender);
        }
    }
    private var gX:Number=0;
    private var gY:Number=0;
    private function onTouchedHoverItem(e:TouchEvent):void{
        var excerpbox:Sprite= ViewsContainer.ExcerptBox;
        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        if(hover){
            var _data:Object=new Object();
            _data.id=target.name;
            _data.type="assets";
            excerpbox.dispatchEventWith("UPDATE",false,_data);

        }else{

            excerpbox.dispatchEventWith("CLEAR");

        }

    }
    private function onTouchedItem(e:TouchEvent):void{


        var target:Image=e.currentTarget as Image;
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);

        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        if(hover){
            var texture:Texture=Assets.getTexture("CheckAltOver");

        }else{

            texture=Assets.getTexture("CheckAltUp");
        }
        target.texture=texture;

        if(began){

            //target.removeEventListener(TouchEvent.TOUCH,onTouchedItem);

            gX=began.globalX;
            gY=began.globalY;
            item_id=target.name;

            var enabled:Boolean=DataContainer.acceptGift(item_id);
            if(enabled){

                sendItemHandle();

            }else{

                var basesprite:Sprite=ViewsContainer.baseSprite;
                basesprite.dispatchEventWith(DatingScene.REJECT_GIFT);

            }

        }


    }
    private function sendItemHandle():void{


        var dating:String=DataContainer.currentDating;

        var owned_assets:Object=flox.getSaveData("owned_assets");
        var myItem:Object=searchMyOwnedAssets(owned_assets.player);
        var datingTargetItems:Array=owned_assets[dating];
        var index:Number=searchID(datingTargetItems,item_id);
        var enabled:Boolean=true;
        if(index!=-1)
            enabled=false;

        //DebugTrace.msg("AssetsTiledLayout.sendItemHandle enabled="+enabled);
        var basesprite:Sprite=ViewsContainer.baseSprite;
        DebugTrace.msg("AssetsTiledLayout.sendItemHandle submited="+submited);
        if(!submited){

            if(enabled){
                // witch dating person who didn't have this item, send item to some him/her
                //disableSubmit();
                submited=true;

                var assetslist:Array=owned_assets.player;
                index=searchID(assetslist,item_id);

                var qty:Number=myItem.qty;
                qty--;
                if(qty==0)
                {

                    var _assetslist:Array=assetslist.splice(index);
                    _assetslist.shift();
                    var new_assetslist:Array=assetslist.concat(_assetslist);

                    owned_assets.player=new_assetslist;
                }else
                {
                    assetslist[index].qty=qty;
                    owned_assets.player=assetslist;

                }

                var new_item:Object=new Object();
                new_item.id=item_id;
                new_item.qty=1;
                new_item.expiration=myItem.expiration;
                datingTargetItems.push(new_item);
                owned_assets[dating]=datingTargetItems;

                DebugTrace.msg("AssetsTiledLayout.sendItemHandle owned_assets="+JSON.stringify(owned_assets));
                flox.save("owned_assets",owned_assets);


                var _data:Object=new Object();
                _data.com="SendGift";
                _data.item_id=item_id;
                _data.began=new Point(gX,gY);

                basesprite.dispatchEventWith(DatingScene.COMMIT,false,_data);

            }
            else{
                //the dataing character who owned this item

                DebugTrace.msg("AssetsTiledLayout.sendItemHandle DISPLAY_ALERT");
                basesprite.dispatchEventWith(DatingScene.DISPLAY_ALERT);
            }

        }
    }

    private function searchMyOwnedAssets(ownedlist:Array):Object{


        for(var i:uint=0;i<ownedlist.length;i++){

            if(ownedlist[i].id==item_id) {
                var item:Object = ownedlist[i];

                break

            }

        }

        return item


    }
    private function searchID(list:Array,item_id:String):Number
    {
        var index:Number=-1;
        for(var i:uint=0;i<list.length;i++)
        {
            var id:String=list[i].id;
            if(item_id==id)
            {
                index=i;
                break
            }
            //if
        }
        //for
        return index
    }
}
}
