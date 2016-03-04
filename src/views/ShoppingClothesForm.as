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


import utils.ViewsContainer;

public class ShoppingClothesForm extends Sprite {
    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panelAssets:Image;
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var casshtext:TextField;
    private var font:String="SimNeogreyMedium";
    private var clotheslayout:ShoppingClothesListLayout;

    public function ShoppingClothesForm() {

        base_sprite=new Sprite();
        addChild(base_sprite);
        this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);

        initPanel();
        initCashFormat();
    }
    private function initPanel():void{

        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);



        panelAssets=new Image(Assets.getTexture("ShoppingAssets"));
        panelbase.addChild(panelAssets);

        clotheslayout=new ShoppingClothesListLayout();
        panelbase.addChild(clotheslayout);

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



        var _data:Object=new Object();
        _data.name= "ShoppingCentreScene_fromlist";
        command.sceneDispatch(SceneEvent.CHANGED,_data);


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
