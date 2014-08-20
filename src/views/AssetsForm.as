package views
{
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.DataContainer;


import events.GameEvent;

import flash.geom.Point;
import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.events.Event;
import starling.textures.Texture;

import utils.DebugTrace;

public class AssetsForm extends Sprite
{
    private var flox:FloxInterface=new FloxCommand();
    private var gameEvent:GameEvent;
    private  var assetsform:AssetsTiledLayout
    private var tag_names:Array=["Consumable","Misc","Apparel","Estatecar"];
    private var catelist:Array=["cons","misc","app","est"];
    private var tad_pos:Array=[];
    public var chname:String="player";
    private var sort:String="id";
    private var sort_index:Number=-2;
    private var cate:String="cons";
    private var sortings:Array=new Array();
    private var font:String="SimMyriadPro";
    private var casshtext:TextField;
    public var type:String;
    public function AssetsForm()
    {


        this.addEventListener("CHANGED",onChangedAssetsForm);
        this.addEventListener("INITAILIZE",onInitAssetsForm);


    }
    private function onInitAssetsForm(e:Event):void{

        type=e.data.type;

        initCashFormat();
        initAssetsTiledLayout();
        initTags();
        initSortingTags();


    }
    private function initCashFormat():void{



        var cash:Number=flox.getSaveData("cash");
        var format:Object=new Object();
        format.font=font;
        format.size=20;
        format.color=0x000000;

        casshtext=addTextField(this,new Rectangle(117,62,158,25),format);
        casshtext.name="cash";
        casshtext.text=DataContainer.currencyFormat(cash);

    }

    private function initAssetsTiledLayout():void{


        assetsform=new AssetsTiledLayout();
        assetsform.clipRect=new Rectangle(0,0,530,310);
        assetsform.type=type;
        assetsform.chname=chname;
        assetsform.cate=cate;
        assetsform.sort=sort;
        assetsform.sort_index=sort_index;
        assetsform.x=40;
        assetsform.y=160;
        addChild(assetsform);



    }
    private function initTags():void
    {
        for(var i:uint=0;i<tag_names.length;i++)
        {
            // DebugTrace.msg("AssetsForm.initTags tag_names:"+tag_names[i]+"Tag")
            var texture:Texture=Assets.getTexture("Icon"+tag_names[i]);
            var tagbtn:Button=new Button(texture);
            tagbtn.name=tag_names[i];
            tagbtn.pivotX=tagbtn.width/2;
            tagbtn.pivotY=tagbtn.height/2;
            tagbtn.x=334+i*(tagbtn.width+10);
            tagbtn.y=76;
            addChild(tagbtn);
            tagbtn.addEventListener(TouchEvent.TOUCH,onCateTagTouched)
        }
        //for


    }
    private function onCateTagTouched(e:TouchEvent):void{

        var target:Button=e.currentTarget as Button;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);

        if(hover){

            var tween:Tween=new Tween(target,0.3,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(1.2);
            Starling.juggler.add(tween);

        }else{

            tween=new Tween(target,0.3,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(1);
            Starling.juggler.add(tween);
        }
        if(began){

            var cate_index:Number=tag_names.indexOf(target.name);
            cate=catelist[cate_index];
            removeChild(assetsform);
            initAssetsTiledLayout();
        }

    }
    private function initSortingTags():void{

        sortings=[{cate:"Name",index:0},{cate:"Brand",index:0},{cate:"Expiration",index:0}];

        for(var i:uint=0;i<sortings.length;i++) {

            var texture:Texture=Assets.getTexture("IconSort"+sortings[i].cate);
            var tagbtn:Button=new Button(texture);
            tagbtn.name=sortings[i].cate;
            tagbtn.x=42+i*(tagbtn.width+5);
            tagbtn.y=125;
            addChild(tagbtn);

            tagbtn.addEventListener(Event.TRIGGERED, onSortingTriggered);
        }



    }
    private function onSortingTriggered(e:Event):void{

        var target:Button=e.currentTarget as Button;

        for(var i:uint=0;i<sortings.length;i++){
            if(sortings[i].cate==target.name){
                var index:Number=sortings[i].index;
                if(index<0){
                    index=0;
                }else{
                    index--;
                }
                sortings[i].index=index;
                break
            }

        }


        removeChild(assetsform);
        sort=target.name.toLowerCase();
        sort_index=index;
        initAssetsTiledLayout();


    }

    private function onChangedAssetsForm(e:Event):void
    {

        chname=e.data.chname;
        removeChild(assetsform);
        initAssetsTiledLayout();


    }
    private function addTextField(target:Sprite,rec:Rectangle,format:Object):TextField
    {


        var txt:TextField=new TextField(rec.width,rec.height,"",font,format.size,format.color);
        txt.hAlign="left";
        txt.vAlign="center";
        txt.autoSize=TextFieldAutoSize.LEFT;
        txt.x=rec.x;
        txt.y=rec.y;
        target.addChild(txt);

        return txt
    }

}
}