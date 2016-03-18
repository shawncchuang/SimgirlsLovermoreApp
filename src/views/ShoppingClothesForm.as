/**
 * Created by shawnhuang on 15-11-05.
 */
package views {
import com.gamua.flox.Flox;

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import events.SceneEvent;

import flash.geom.Rectangle;
import flash.text.TextFieldAutoSize;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.text.TextFormat;


import utils.ViewsContainer;

public class ShoppingClothesForm extends Sprite {
    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panelAssets:Image;
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var pricetext:TextField;
    private var font:String="SimNeogreyMedium";
    private var clotheslayout:ShoppingClothesListLayout;
    private var price:Number=0;
    public function ShoppingClothesForm() {

        base_sprite=new Sprite();
        addChild(base_sprite);
        this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);

        var scene:Sprite=ViewsContainer.currentScene;
        scene.addEventListener("UPDATED_PRICE",onUpdatePrice);

        initPanel();

    }
    private function initPanel():void{

        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);

        panelAssets=new Image(Assets.getTexture("ShoppingAssets"));
        panelbase.addChild(panelAssets);

        initPriceFormat();

        clotheslayout=new ShoppingClothesListLayout();
        panelbase.addChild(clotheslayout);


        var templete:MenuTemplate=new MenuTemplate();
        templete.addBackStepButton(doCannelHandler);
        addChild(templete);
    }
    private function initPriceFormat():void{

        var priceStr:String=DataContainer.currencyFormat(price);
        pricetext=new TextField(150,25,priceStr);
        //pricetext.autoSize=TextFieldAutoSize.LEFT;
        pricetext.format.setTo(font,20,0,"left");
        pricetext.x=117;
        pricetext.y=30;

        panelbase.addChild(pricetext);
    }
    private function onUpdatePrice(e:Event):void
    {
        price= e.data.price;
        pricetext.text=DataContainer.currencyFormat(price);

    }

    private function doCannelHandler(e:Event):void
    {


        var _data:Object=new Object();
        _data.name= "ShoppingCentreScene_fromlist";
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }

    private function addTextField(target:Sprite,rec:Rectangle,format:Object):TextField
    {


        var txt:TextField=new TextField(rec.width,rec.height,"");
        txt.format.setTo(font,format.size,format.color,"left");
        txt.autoSize=TextFieldAutoSize.LEFT;
        txt.x=rec.x;
        txt.y=rec.y;
        target.addChild(txt);

        return txt
    }
    private function onRemovedHandler(e:Event):void{


        clotheslayout.removeFromParent(true);
        panelbase.removeFromParent(true);


    }

}
}
