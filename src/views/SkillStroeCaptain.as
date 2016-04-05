/**
 * Created by shawnhaung on 2015-12-23.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.ViewCommand;
import controller.ViewInterface;

import events.SceneEvent;

import feathers.controls.Button;

import flash.geom.Point;
import flash.geom.Rectangle;


import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.ViewsContainer;

public class SkillStroeCaptain extends Sprite {

    private var basemodel:Sprite;
    private var chmodel:Sprite;
    private var flox:FloxInterface = new FloxCommand();
    private var viewcom:ViewInterface = new ViewCommand();
    private var panelbase:Sprite;
    private var panelSkills:Image;
    private var sptsTxt:TextField;
    private var skills:Sprite;
    private var font:String = "SimMyriadPro";
    private var skillexcbox:Sprite;
    private var skillItems:Object = new Object();
    private var buyBtnlist:Array = new Array();
    private var command:MainInterface=new MainCommand();
    private var current_item:String;
    private var alertmsg:Sprite;
    private var itemRenders:Array=new Array();
    public function SkillStroeCaptain() {


        initBaseModel();
        initLayout();
        initSkills();
        initCancelHandle();

        this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
    }
    private function onRemovedHandler(e:Event):void{
        removedHandler();
    }

    private function initBaseModel():void {

        //player
        basemodel=new Sprite();
        addChild(basemodel);

        //other character
        chmodel=new Sprite();
        chmodel.mask=new Quad(356,540);
        chmodel.x=5;
        chmodel.y=120;
        addChild(chmodel);


        var params:Object=new Object();
        var gender:String=flox.getSaveData("avatar").gender;
        var _point:Point=new Point(54,180);
        var rec:Rectangle=new Rectangle(0,-30,276,510);
        if(gender=="Female"){
            _point=new Point(64,240);
            rec=new Rectangle(-30,-50,350,510);
        }
        basemodel.x=_point.x;
        basemodel.y=_point.y;
        params.pos=_point;
        params.clipRect=rec;
        viewcom.fullSizeCharacter(basemodel,params);

    }

    private function initLayout():void {

        ViewsContainer.UIViews.visible = false;
        panelbase = new Sprite();
        panelbase.x = 360;
        panelbase.y = 159;
        addChild(panelbase);


        var texture:Texture = Assets.getTexture("PanelCaptainSkillsStore");
        panelSkills = new Image(texture);
        panelSkills.name = "skills";
        panelbase.addChild(panelSkills);


    }

    private function initSkills():void {

        skills = new Sprite();
        panelbase.addChild(skills);

        var skillPts:Object = flox.getSaveData("skillPts");
        sptsTxt = new TextField(70, 24, String(skillPts.player));
        sptsTxt.format.setTo(font, 20);
        sptsTxt.x = 198;
        sptsTxt.y = 62;
        skills.addChild(sptsTxt);

        skillItems = flox.getSyetemData("commander_items");

        var count:Number=-1;
        for (var id:String in skillItems) {
            count++;
            var itemRender:Sprite = new Sprite();
            itemRender.x=40;
            itemRender.y=130+count*65;
            itemRender.name = id;

            var itemTt:Texture = Assets.getTexture("CaptainSkillItemIcon");
            var itemImg:Image = new Image(itemTt);
            var renderH:Number = itemImg.height;

            var quad:Quad = new Quad(530, renderH, 0xffffff);
            itemRender.addChild(quad);

            var nameHeader:TextField = new TextField(50, 16, "Name:");
            nameHeader.format.setTo(font, 12, 0x333333,"left");
            nameHeader.x = itemImg.width + 10;
            itemRender.addChild(nameHeader);

            var nametTxt:TextField = new TextField(100, renderH, skillItems[id].label);
            nametTxt.format.setTo(font, 20, 0,"left");
            nametTxt.x = nameHeader.x;

            var priceHeader:TextField = new TextField(80, 16, "Skill Points:");
            priceHeader.format.setTo(font, 12, 0x333333,"left");
            priceHeader.x = 290;
            itemRender.addChild(priceHeader);
            var _price:String = skillItems[id].pts;
            var priceTxt:TextField = new TextField(90, renderH, _price);
            priceTxt.format.setTo("SimNeogreyMedium", 16, 0,"left");
            priceTxt.autoScale = true;
            priceTxt.x = priceHeader.x;

            var buyBtn:Button = new Button();
            buyBtn.x = priceTxt.x + 120;
            buyBtn.y = 20;
            buyBtn.scaleX = 0.4;
            buyBtn.scaleY = 0.4;
            buyBtnlist.push(buyBtn);

            var buyBtnUpTexture:Texture = Assets.getTexture("BuyButtonDe_Skin");
            var buyBtnDownTexture:Texture = Assets.getTexture("BuyButtonDown_Skin");
            buyBtn.defaultSkin = new Image(buyBtnUpTexture);
            buyBtn.downSkin = new Image(buyBtnDownTexture);
            buyBtn.addEventListener(Event.TRIGGERED, onTapBuyHandler);
            itemRender.addEventListener(TouchEvent.TOUCH,onTouchedHoverItem);


            itemRender.addChild(itemImg);
            itemRender.addChild(nametTxt);
            itemRender.addChild(priceTxt);
            itemRender.addChild(buyBtn);
            panelbase.addChild(itemRender);
            itemRenders.push(itemRender);
        }


    }

    private function onTapBuyHandler(e:Event):void {
        var skillPts:Object = flox.getSaveData("skillPts");
        var current_pts:Number=skillPts.player;
        var pts:Number= skillItems[current_item].pts;


        if(current_pts>=pts){

            var value_data:Object = new Object();
            value_data.attr = "skillPts";
            value_data.values =  String(pts*-1);
            var command:MainInterface = new MainCommand();
            command.playSound("GodRewards");
            command.displayUpdateValue(this, value_data);
            current_pts-=pts;
            skillPts.player=current_pts;
            flox.save("skillPts",skillPts);
            sptsTxt.text=String(current_pts);

            var skills:Object=flox.getSaveData("skills");
            var captain_skills:Array=skills.captain;
            var index:Number=Number(current_item.split("com").join(""));
            var com_item:Object=captain_skills[index];
            com_item.qty+=1;
            captain_skills[index]=com_item;
            skills.captain=captain_skills;
            flox.save("skills",skills);


        }else{
            var msg:String="You need more Skill Points.";
            alertmsg=new AlertMessage(msg);
            addChild(alertmsg);

        }


    }
    private function onTouchedHoverItem(e:TouchEvent):void{

        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        var _data:Object=new Object();
        var scene:Sprite=ViewsContainer.currentScene;
        if(hover)
        {
            current_item=target.name;
            //DebugTrace.msg( "ShoppingListLayout.onTouchedHoverItem current_item="+current_item);

            _data._visible=true;
            _data.desc=skillItems[current_item].desc;
            scene.dispatchEventWith("UPDATE_DESC",false,_data);
        }else{
            _data._visible = false;
            scene.dispatchEventWith("UPDATE_DESC", false, _data);

        }

    }
    private function initCancelHandle():void
    {
        command.addedCancelButton(this,doCannelHandler);

    }
    private function doCannelHandler():void
    {

        removedHandler();

        var _data:Object=new Object();
        _data.name="LovemoreMansionScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }

    private function removedHandler():void{

        for(var i:uint=0;i<itemRenders.length;i++){

            var buyBtn:Button=buyBtnlist[i];
            buyBtn.dispose();
            buyBtn.removeFromParent(true);
            var itemRender:Sprite=itemRenders[i];
            itemRender.dispose();
            itemRender.removeFromParent(true);
        }

        panelbase.removeFromParent(true);
        this.dispose();

    }

}
}
