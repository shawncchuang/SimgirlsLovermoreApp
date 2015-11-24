/**
 * Created by shawn on 2014-08-15.
 */
package controller {

import data.DataContainer;

import flash.geom.Rectangle;
import flash.geom.Point;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;

import data.Config;

import starling.events.TouchPhase;

import starling.textures.Texture;
import starling.textures.TextureSmoothing;

import utils.DrawManager;

public class ViewCommand  implements ViewInterface{

    private var flox:FloxInterface=new FloxCommand();
    private var drawcom:DrawerInterface=new DrawManager();
    private var player_icon:Sprite;
    private var rootTarget:Sprite;
    private var skillTarget:Sprite;
    private var character:String;
    private var icons:Array=new Array();

    public function fullSizeCharacter(target:Sprite,params:Object=null):void{



        var gender:String=flox.getSaveData("avatar").gender;

        var modelRec:Rectangle=Config.modelObj[gender];
        var modelAttr:Object=new Object();
        modelAttr.gender=gender;
        modelAttr.width=modelRec.width;
        modelAttr.height=modelRec.height;

        drawcom.drawCharacter(target,modelAttr);
        drawcom.updateBaseModel("Eyes");
        drawcom.updateBaseModel("Hair");
        drawcom.updateBaseModel("Pants");
        drawcom.updateBaseModel("Clothes");
        drawcom.updateBaseModel("Features");
        target.x=params.pos.x;
        target.y=params.pos.y;
        target.clipRect=params.clipRect;

    }
    private var _cate:String="";
    public function characterIcons(target:Sprite,cate:String=null):void{

        rootTarget=target;
        _cate=cate;

        var gender:String=flox.getSaveData("avatar").gender;

        var modelObj:Object=Config.modelObj;
        var modelRec:Rectangle=modelObj[gender];


        var modelAttr:Object=new Object();
        modelAttr.gender=gender;
        modelAttr.width=modelRec.width;
        modelAttr.height=modelRec.height;

        var basemodel:Sprite=new Sprite();
        basemodel.x=modelRec.x;
        basemodel.y=modelRec.y;
        drawcom.drawCharacter(basemodel,modelAttr);
        drawcom.updateBaseModel("Eyes");
        drawcom.updateBaseModel("Hair");
        drawcom.updateBaseModel("Features");

        var player_point:Point=new Point(60,710);
        var dp:Point=new Point(-80,-22);
        if(gender=="Female")
        {
            dp=new Point(-77,-9);
        }

        player_icon=new Sprite();
        player_icon.name="Player";
        drawcom.drawPlayerProfileIcon(player_icon,1,player_point,dp);
        player_icon.scaleX=0.89;
        player_icon.scaleY=0.89;


        player_icon.x=180;
        target.addChild(player_icon);
        player_icon.clipRect=new Rectangle(-55,-(player_icon.height/2),player_icon.width,player_icon.height);
        player_icon.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
        icons.push(player_icon);


        var characters:Array=Config.characters;
        for(var i:uint=0;i<characters.length;i++)
        {
            var name:String=characters[i].toLowerCase();

            var pts:Number=flox.getSaveData("skillPts")[name];
            var enable_ch:String="ProEmpty";
            var enabled:Boolean=false;

            var icon:Sprite=new Sprite();
            icon.name=characters[i];
            icon.useHandCursor=enabled;
            icon.x=i*100+280;
            icon.y=player_point.y;

            if(pts!=-1)
            {
                enabled=true;
                drawcom.drawCharacterProfileIcon(icon,characters[i],0.45);
            }
            else
            {

                var texture:Texture=Assets.getTexture(enable_ch);
                var img:Image=new Image(texture);
                img.smoothing=TextureSmoothing.TRILINEAR;
                img.pivotX=img.width/2;
                img.pivotY=img.height/2;
                img.scaleX=0.45;
                img.scaleY=0.45;
                icon.addChild(img);
            }
            //if

            if(cate){
                player_icon.scaleX=0.45;
                player_icon.scaleY=0.45;
                player_icon.x=50;
                player_icon.y=120;
                icon.scaleX=0.5;
                icon.scaleY=0.5;
                icon.x=(i*icon.width+5)+(player_icon.x+player_icon.width/2);
                icon.y=120;

            }

            target.addChild(icon);
            icons.push(icon);
            if(enabled)
            {
                icon.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
            }
            //if
        }
        //for


    }

    private function onTouchCharaterIcon(e:TouchEvent):void
    {


        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        if(hover)
        {
            var _scale:Number=1.1;
            if(_cate){
                //for blackmarket
                _scale=0.6;
                if(target.name=="Player")
                {
                    _scale=0.5;
                }
            }

            var tween:Tween=new Tween(target,0.2,Transitions.LINEAR);
            tween.scaleTo(_scale);
            Starling.juggler.add(tween);


        }
        else
        {
            var scale:Number=1;
            if(target.name=="Player")
            {
                scale=0.89;
            }
            if(_cate){
                //for blackmarket
                scale=0.5;
                if(target.name=="Player")
                {
                    scale=0.45;
                }
            }

            tween=new Tween(target,0.2,Transitions.LINEAR);
            tween.scaleTo(scale);
            Starling.juggler.add(tween);
        }
        //if
        if(began)
        {
            character=target.name.toLowerCase();
            var _data:Object=new Object();
            _data.ch_index=Config.characters.indexOf(target.name);
            _data.character=character;
            rootTarget.dispatchEventWith("TouchedIcon",false,_data);

            if(_cate){
                //for market
                for(var i:uint=0 ; i<icons.length;i++){
                    tween=new Tween(icons[i],0.2,Transitions.LINEAR);
                    tween.animate("alpha",0.3);
                    Starling.juggler.add(tween);
                }
                tween=new Tween(target,0.2,Transitions.LINEAR);
                tween.animate("alpha",1);
                Starling.juggler.add(tween);
            }
        }
        //if
    }


    public function skillIcons(target:Sprite):void{

        skillTarget=target;
        var elements:Array=Config.elements;
        for(var i:uint=0;i<elements.length;i++)
        {


            var texture:Texture=Assets.getTexture("Cate_"+elements[i]);
            var elementsbtn:Button=new Button(texture);
            elementsbtn.name=elements[i];
            elementsbtn.pivotX=elementsbtn.width/2;
            elementsbtn.pivotY=elementsbtn.height/2;
            elementsbtn.x=i*60+315;
            elementsbtn.y=76;
            target.addChild(elementsbtn);
            elementsbtn.addEventListener(TouchEvent.TOUCH,onTriggeredElements);
        }
        //for

    }
    private function onTriggeredElements(e:TouchEvent):void{


        var target:Button=e.currentTarget as Button;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
        if(hover)
        {

            var tween:Tween=new Tween(target,0.2,Transitions.LINEAR);
            tween.scaleTo(1.1);
            Starling.juggler.add(tween);


        }
        else
        {

            tween=new Tween(target,0.2,Transitions.LINEAR);
            tween.scaleTo(1);
            Starling.juggler.add(tween);
        }


        if(began){

            var _data:Object=new Object();
            _data.cate=target.name;
            skillTarget.dispatchEventWith("ToucbedSkillIcon",false,_data)
        }

    }
    public function replaceCharacter(model:Sprite):void{


        var old_chmc:Image=model.getChildByName("character") as Image;
        if(old_chmc)
        {

            old_chmc.removeFromParent(true);

        }

        var style:String=DataContainer.styleSechedule[character];
        var clothTexture:Texture=Assets.getTexture(style);
        var characterImg:Image=new Image(clothTexture);

        characterImg.name="character";
        //characterImg.width=356;
        //characterImg.height=608;
        characterImg.scaleX=0.8;
        characterImg.scaleY=0.8;
        model.addChild(characterImg);

    }
}
}
