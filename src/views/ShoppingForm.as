/**
 * Created by shawnhuang on 15-08-14.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import events.SceneEvent;

import flash.geom.Point;

import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Button;

import starling.display.Image;
import starling.display.Sprite;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.ViewsContainer;

public class ShoppingForm extends Sprite{

    private var flox:FloxCommand=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panelAssets:Image;
    private var casshtext:TextField;
    private var font:String="SimMyriadPro";
    private var shoppinglist:ShoppingListLayout;
    private var catelist:Array=["consumable","misc","fashion","luxury"];
    private var cate:String=catelist[0];

    private var sortings:Array=new Array();
    private var sort:String="id";
    private var sort_index:Number=-2;
    private var tag_names:Array=["Consumable","Misc","Fashion","Luxury"];

    public function ShoppingForm() {
        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();


        initPanel();
        initCashFormat();
        initShoppingListLayout();
        initSortingTags();
        initTags();

    }
    private function initPanel():void
    {
        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);



        panelAssets=new Image(Assets.getTexture("ShoppingAssets"));
        panelbase.addChild(panelAssets);

        var scene:Sprite=ViewsContainer.currentScene;
        scene.addEventListener("SHOPPING_PAIED",onUpdateCash);


        var templete:MenuTemplate=new MenuTemplate();
        templete.addBackStepButton(doCannelHandler);
        addChild(templete);



    }

    private function onUpdateCash(e:Event):void
    {

        var cash:Number=flox.getSaveData("cash");
        casshtext.text=DataContainer.currencyFormat(cash);

    }

    private function doCannelHandler(e:Event):void
    {

        shoppinglist.removeFromParent();

        var _data:Object=new Object();
        _data.name= "ShoppingCentreScene_fromlist";
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }


    private function initShoppingListLayout():void
    {

        shoppinglist=new ShoppingListLayout();
        shoppinglist.clipRect=new Rectangle(0,0,550,320);

        shoppinglist.cate=cate;
        shoppinglist.sort=sort;
        shoppinglist.sort_index=sort_index;
        shoppinglist.x=390;
        shoppinglist.y=270;
        addChild(shoppinglist);

    }
    private function initCashFormat():void{



        var cash:Number=flox.getSaveData("cash");
        var format:Object=new Object();
        format.font=font;
        format.size=20;
        format.color=0x000000;

        casshtext=addTextField(this,new Rectangle(117,30,158,25),format);
        casshtext.name="cash";
        casshtext.text=DataContainer.currencyFormat(cash);
        panelbase.addChild(casshtext);
    }

    private function initSortingTags():void{

        sortings=[{cate:"Name",index:0}];

        for(var i:uint=0;i<sortings.length;i++) {

            var texture:Texture=Assets.getTexture("IconSort"+sortings[i].cate);
            var tagbtn:Button=new Button(texture);
            tagbtn.name=sortings[i].cate;
            tagbtn.x=390+i*(tagbtn.width+5);
            tagbtn.y=240;
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


        shoppinglist.removeFromParent(true);
        sort=target.name.toLowerCase();
        sort_index=index;
        initShoppingListLayout();


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
            tagbtn.x=700+i*(tagbtn.width+10);
            tagbtn.y=200;
            addChild(tagbtn);
            tagbtn.addEventListener(TouchEvent.TOUCH,onCateTagTouched);
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
            shoppinglist.removeFromParent(true);
            initShoppingListLayout();
        }

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
