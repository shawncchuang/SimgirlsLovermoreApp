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

import starling.display.Image;
import starling.display.Sprite;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

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


    public function ShoppingForm() {
        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();


        initPanel();
        initCashFormat();
        initShoppingListLayout();


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
        _data.name= "ShoppingCentreScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);


    }


    private function initShoppingListLayout():void
    {

        shoppinglist=new ShoppingListLayout();
        shoppinglist.clipRect=new Rectangle(0,0,550,350);

        shoppinglist.cate=cate;
        shoppinglist.x=390;
        shoppinglist.y=240;
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
