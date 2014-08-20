/*
 * Created by shawn on 2014-08-11.
 */
package views {
import controller.AssetEmbeds;
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.DataContainer;

import feathers.controls.List;
import feathers.data.ListCollection;
import feathers.controls.PanelScreen;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.layout.TiledRowsLayout;
import feathers.controls.ScrollContainer;
import feathers.layout.TiledColumnsLayout;
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
    public function AssetsTiledLayout() {



        //this.width=530;
        this.height=300;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);


    }
    private function initializeHandler(e:Event):void{


        /*
         this.layout=new AnchorLayout();

         this._list=new List();

         var item:Object=new Object();
         item.text="Test";
         this._list.itemRendererProperties.labelField = "text";

         item.iconTexture = Assets.getTexture("Cons1_1");
         this._list.itemRendererProperties.iconSourceField = "iconTexture";


         item.accessoryText = "Accessory Text";
         this._list.itemRendererProperties.accessoryLabelField = "accessoryText";
         this._list.itemRendererProperties.accessoryPosition=BaseDefaultItemRenderer.ACCESSORY_POSITION_RIGHT;

         this._list.itemRendererProperties.horizontalAlign = BaseDefaultItemRenderer.HORIZONTAL_ALIGN_LEFT;
         this._list.itemRendererProperties.verticalAlign = BaseDefaultItemRenderer.VERTICAL_ALIGN_MIDDLE;
         this._list.itemRendererProperties.layoutOrder = BaseDefaultItemRenderer.LAYOUT_ORDER_LABEL_ICON_ACCESSORY;

         this._list.itemRendererProperties.gap = Number.POSITIVE_INFINITY;
         this._list.itemRendererProperties.accessoryGap = Number.POSITIVE_INFINITY;


         this._list.dataProvider = new ListCollection([item]);
         this._list.layoutData = new AnchorLayoutData(0, 0, 0, 0);
         this._list.isSelectable = true;
         this._list.clipContent = false;
         this._list.autoHideBackground = true;
         addChild(this._list);
         */
        DebugTrace.msg("AssetsTiledLayout.sendItemHandle chname="+chname);
        DebugTrace.msg("AssetsTiledLayout.sendItemHandle type="+type);

        assetsData=flox.getSyetemData("assets");
        ownedAssets=flox.getSaveData("owned_assets")[chname];

        assetslist=new Array();
        for(var i:uint=0;i<ownedAssets.length;i++)
        {
            var id:String=ownedAssets[i].id;
            if(assetsData[id].cate==cate) {
                var item:Object = new Object();
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
                    if(sort_index==-1){
                        assetslist=assetslist.sortOn(sort,Array.NUMERIC | Array.DESCENDING);
                    }else if (sort_index==0){
                        assetslist=assetslist.sortOn(sort,Array.NUMERIC);
                    }
                    break
                default:
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
        layout.manageVisibility = true;

        this.layout = layout;
        this.verticalScrollPolicy = ScrollContainer.SCROLL_POLICY_ON;
        this.snapScrollPositionsToPixels = true;

        var font:String="SimMyriadPro";

        for(var j:uint=0;j<assetslist.length;j++) {

            var item:Object=assetslist[j];

            var itemRender:Sprite=new Sprite();
            itemRender.name=item.id;
            itemRender.useHandCursor=true;

            var quad:Quad = new Quad(530, 60, 0xffffff);
            itemRender.addChild(quad);

            // var itemTt:Texture = Assets.getTexture(item.id);
            var itemTt:Texture = Assets.getTexture("cons_1_1");
            var img:Image = new Image(itemTt);

            var nameHeader:TextField=new TextField(50,16,"Name:",font,12,0x333333,true);
            nameHeader.x=img.width+10;
            nameHeader.hAlign="left";
            itemRender.addChild(nameHeader);
            var nametTxt:TextField=new TextField(100,60,item.name,font,20,0,false);
            nametTxt.x=nameHeader.x;
            nametTxt.hAlign="left";
            nametTxt.vAlign="center";


            var brandHeader:TextField=new TextField(50,16,"Brand:",font,12,0x333333,true);
            brandHeader.x=220;
            brandHeader.hAlign="left";
            itemRender.addChild(brandHeader);
            var brandTxt:TextField=new TextField(100,60,item.brand,font,20,0,false);
            brandTxt.x=brandHeader.x;
            brandTxt.hAlign="left";
            brandTxt.vAlign="center";


            var expirHeader:TextField=new TextField(80,16,"Expiration:",font,12,0x333333,true);
            expirHeader.x=340;
            expirHeader.hAlign="left";
            itemRender.addChild(expirHeader);
            var expirTxt:TextField=new TextField(80,60,item.expiration,font,20,0,false);
            expirTxt.x=expirHeader.x;
            expirTxt.vAlign="center";
            expirTxt.hAlign="left";


            var qtyHeader:TextField=new TextField(50,16,"Qty:",font,12,0x333333,true);
            qtyHeader.x=470;
            qtyHeader.hAlign="left";
            itemRender.addChild(qtyHeader);
            var qtyTxt:TextField=new TextField(30,60,item.qty,font,20,0,false);
            qtyTxt.x=qtyHeader.x;
            qtyTxt.vAlign="center";
            qtyTxt.hAlign="left";

            itemRender.addChild(img);
            itemRender.addChild(nametTxt);
            itemRender.addChild(brandTxt);
            itemRender.addChild(expirTxt);
            itemRender.addChild(qtyTxt);
            itemRender.addEventListener(TouchEvent.TOUCH,onTouchedItem);
            addChild(itemRender)
        }
    }
    private var gX:Number=0;
    private var gY:Number=0;
    private function onTouchedItem(e:TouchEvent):void{

        var excerpbox:Sprite= ViewsContainer.ExcerptBox;
        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        if(hover){

            var _data:Object=new Object();
            _data.id=target.name;
            _data.type="assets";
            excerpbox.dispatchEventWith("UPDATE",false,_data);

        }else{

            excerpbox.dispatchEventWith("CLEAR");

        }
        if(type=="give"){

            if(began){
                gX=began.globalX;
                gY=began.globalY;
                item_id=target.name;
                sendItemHandle();


            }
        }

    }
    private function sendItemHandle():void{


        var dating:String=DataContainer.currentDating;
        var assets_item:Object=assetsData[item_id];

        var owned_assets:Object=flox.getSaveData("owned_assets");
        var myItem:Object=searchMyOwnedAssets(owned_assets.player)
        var datingItems:Array=owned_assets[dating];
        var enabled:Boolean=true;

        for(var i:uint=0;i<datingItems.length;i++){

            if(datingItems[i].id==item_id){
                enabled=false;
                break
            }

        }

        //DebugTrace.msg("AssetsTiledLayout.sendItemHandle enabled="+enabled);
        if(enabled){
            //send item to some one


            var assetslist:Array=owned_assets.player;
            var index:Number=searchID(assetslist,item_id);


            var qty:Number=assetslist[index].qty;
            qty--;
            if(qty==0)
            {

                var _assetslist:Array=assetslist.splice(index);
                _assetslist.shift();
                var new_assetslist:Array=assetslist.concat(_assetslist);

                owned_assets.player=new_assetslist;
            }
            else
            {
                assetslist[index].qty=qty;
                owned_assets.player=assetslist;

            }

            var datingItems:Array=owned_assets[dating];
            var index1:Number=searchID(datingItems,item_id);
            if(index1==-1)
            {
                //dating person didn't have this item
                var new_item:Object=new Object();
                new_item.id=item_id;
                new_item.qty=1;
                new_item.expiration=myItem.expiration;
                datingItems.push(new_item);
                owned_assets[dating]=datingItems;

            }

            // flox.save("owned_assets",owned_assets);

            var _data:Object=new Object();
            _data.com="GotGift";
            _data.item_id=item_id;
            _data.began=new Point(gX,gY);
            var basesprite:Sprite=ViewsContainer.baseSprite;
            basesprite.dispatchEventWith("commit",false,_data);


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
