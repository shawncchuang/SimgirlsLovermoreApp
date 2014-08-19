/**
 * Created by shawn on 2014-08-12.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;

import events.SceneEvent;

import flash.geom.Point;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.text.TextFieldAutoSize;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;


public class MenuTemplate extends Sprite{


    public static var EFFECT_BG_FADEOUT:String="effect_bg_fadeout";
    public  static var EFFECT_TITLEBAR_FADEOUT:String="effect_titlebar_fadeout";
    public  static var EFFECT_TITLEICON_FADEOUT:String="effect_titleicon_fadeout";
    private var bgEff1:Image;
    private var bgEff2:Image;
    public var cate:String="";
    public var font:String="";
    private var titlebar:Sprite;
    private var titleIcon:Image;
    private var command:MainInterface=new MainCommand();
    private var mini_menu:Sprite;
    public function MenuTemplate() {


        this.addEventListener(MenuTemplate.EFFECT_BG_FADEOUT,onEffectBgFadeoutHandele);
        this.addEventListener(MenuTemplate.EFFECT_TITLEBAR_FADEOUT,onTitlebarFadeoutHandele);
        this.addEventListener(MenuTemplate.EFFECT_TITLEICON_FADEOUT,onTitleiconFadeoutHandele)
    }

    public function addBackground():void{

        var quad:Quad=new Quad(Starling.current.stage.stageWidth,Starling.current.stage.stageHeight,0x649CD3);
        addChild(quad);

    }
    public function backgroundEffectFadein(attrs:Array):void{

        var bgEffTxtr:Texture=getTexture("MenuBgEffect");
        bgEff1=new Image(bgEffTxtr);
        bgEff1.x=attrs[0].from.x;
        bgEff1.y=attrs[0].from.y;


        bgEff2=new Image(bgEffTxtr);
        bgEff2.scaleX=-1;
        bgEff2.x=attrs[1].from.x;
        bgEff2.y=attrs[1].from.y;

        addChild(bgEff1);
        addChild(bgEff2);

        var tween1:Tween=new Tween(bgEff1,0.5,Transitions.EASE_IN);
        tween1.moveTo(attrs[0].to.x,attrs[0].to.y);

        var tween2:Tween=new Tween(bgEff2,0.5,Transitions.EASE_IN);
        tween2.moveTo(attrs[1].to.x,attrs[1].to.y);

        Starling.juggler.add(tween1);
        Starling.juggler.add(tween2);
    }
    private function onEffectBgFadeoutHandele(e:Event):void{


        var bgEff1Tween:Tween=new Tween(bgEff1,0.3,Transitions.EASE_IN_OUT_BACK);
        //bgEff1Tween.delay=0.3;
        bgEff1Tween.animate("x",-580);
        Starling.juggler.add(bgEff1Tween);

        var bgEff2Tween:Tween=new Tween(bgEff2,0.3,Transitions.EASE_IN_OUT_BACK);
        //bgEff1Tween.delay=0.3;
        bgEff2Tween.animate("x",1600);
        bgEff2Tween.onComplete=onFadeoutComplete;
        Starling.juggler.add(bgEff2Tween);
    }
    private function onFadeoutComplete():void{


        Starling.juggler.removeTweens(bgEff1);
        Starling.juggler.removeTweens(bgEff2);


    }
    public function addTitlebar(pos:Point):void{


        titlebar=new Sprite();
        titlebar.x=pos.x;
        titlebar.y=pos.y;
        var title:Image=new Image(getTexture("MenuTitleBG"));
        title.pivotY=title.height/2;
        titlebar.addChild(title);

        var title_txt:TextField=new TextField(95,40,this.cate,this.font,35,0x292929,false);
        title_txt.autoSize=TextFieldAutoSize.HORIZONTAL;
        title_txt.x=245;
        title_txt.y=-20;
        titlebar.addChild(title_txt);
        addChild(titlebar);
    }
    private function onTitlebarFadeoutHandele(e:Event):void{


        var titlebarTween:Tween=new Tween(titlebar,0.1,Transitions.EASE_IN_BACK);
        titlebarTween.animate("scaleY",0.1);
        titlebarTween.animate("alpha",0);
        titlebarTween.onComplete=onTitleFadeouutComplete;
        Starling.juggler.add(titlebarTween);

    }
    private function  onTitleFadeouutComplete():void{
        Starling.juggler.removeTweens(titlebar);
        titlebar.removeFromParent(true);
    }

    public function addFooter():void{

        var footer:Sprite=new Sprite();
        var footerbg:Image=new Image(getTexture("FooterBg"));
        footer.x=512;
        footer.y=742;
        footer.addChild(footerbg);
        addChild(footer);

    }

    public function addBackStepButton(callback:Function):void{

        var cancel:Button=new Button(getTexture("IconPrevBtn"));
        cancel.name="cancel";
        cancel.x=16;
        cancel.y=678;
        addChild(cancel);
        cancel.addEventListener(Event.TRIGGERED,callback);

    }

    public function addTitleIcon(attr:Object):void{

        /*

         switch (this.cate){

         case "MENU":
         iconScr="IconMenuTitle";
         break
         case "PROFILE":
         iconScr="IconProfileTitle";
         break
         case "SETTING":
         iconScr="IconSettingTitle";
         break
         }
         */
        var iconScr:String="Icon"+this.cate+"Title";
        titleIcon=new Image(getTexture(iconScr));
        titleIcon.pivotX=titleIcon.width/2;
        titleIcon.pivotY=titleIcon.height/2;
        titleIcon.x=attr.from.x;
        titleIcon.y=attr.from.y;
        titleIcon.scaleX=0.1;
        titleIcon.scaleY=0.1;
        addChild(titleIcon);


        var tween:Tween=new Tween(titleIcon,0.3,Transitions.EASE_IN_OUT_BACK);
        tween.scaleTo(1);
        tween.moveTo(attr.to.x,attr.to.y);
        tween.onComplete=onTitleConFadeinComplete;
        Starling.juggler.add(tween);
    }
    private function onTitleConFadeinComplete():void{

        Starling.juggler.removeTweens(titleIcon);

    }

    private function onTitleiconFadeoutHandele(e:Event):void{

        var pos:Object=e.data.pos;

        var tween:Tween=new Tween(titleIcon,0.3,Transitions.EASE_IN_BACK);
        tween.scaleTo(0.1);
        if(pos){
            tween.moveTo(pos.x,pos.y);
        }
        tween.onComplete=onTitleConFadeoutComplete;
        Starling.juggler.add(tween);
    }
    private function onTitleConFadeoutComplete():void{
        Starling.juggler.removeTweens(titleIcon);
        titleIcon.removeFromParent(true);
    }

    public function addMiniMenu():void{
        var pos:Object={"PROFILE":new Point(-27,-40),
            "CONTACTS":new Point(-50,-3),
            "CALENDAR":new Point(-26,46),
            "PHOTOS":new Point(25,46),
            "MESSAGING":new Point(50.5,2),
            "SETTINGS":new Point(24,-41)
        }

        var xml:XML=Assets.getAtalsXML("MiniMenusXML");
        var mmTexture:Texture=getTexture("MiniMenus");
        var mmTextAltas:TextureAtlas=new TextureAtlas(mmTexture,xml);

        mini_menu=new Sprite();
        mini_menu.x=930.5;
        mini_menu.y=79.5;
        var bg:Image=new Image(mmTextAltas.getTexture(this.cate.toLowerCase()));
        bg.pivotX=bg.width/2;
        bg.pivotY=bg.height/2;
        mini_menu.scaleX=0.1;
        mini_menu.scaleY=0.1;
        mini_menu.alpha=0;
        mini_menu.addChild(bg);
        addChild(mini_menu);

        var minibgTween:Tween=new Tween(mini_menu,0.5,Transitions.EASE_IN_OUT_BACK);
        minibgTween.scaleTo(1);
        minibgTween.animate("alpha",1);
        Starling.juggler.add(minibgTween);


        for(var _cate:String in pos){
            if(this.cate != _cate) {
                var iconTexture:Texture=mmTextAltas.getTexture("icon"+_cate);
                var mmIcon:Button = new Button(iconTexture);
                mmIcon.name=_cate;
                mmIcon.pivotX=mmIcon.width/2;
                mmIcon.pivotY=mmIcon.height/2;
                mmIcon.x = pos[_cate].x;
                mmIcon.y = pos[_cate].y;
                mini_menu.addChild(mmIcon);
                mmIcon.addEventListener(TouchEvent.TOUCH,onTouchMiniMenu);
            }
        }


    }
    private function  onTouchMiniMenu(e:TouchEvent):void {

        var icon:Button = e.currentTarget as Button;

        var hovor:Touch = e.getTouch(icon, TouchPhase.HOVER);
        var began:Touch = e.getTouch(icon, TouchPhase.BEGAN);


        if (hovor){
            var tween:Tween=new Tween(icon,0.2,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(1.1);
            Starling.juggler.add(tween);
        }
        else{
            tween=new Tween(icon,0.2,Transitions.EASE_IN_OUT_BACK);
            tween.scaleTo(1);
            Starling.juggler.add(tween);
        }

        if(began){
            DebugTrace.msg("MenuTemplate.onTouchMiniMenu icon="+icon.name);
            var cate_index:Number=MenuScene.labelsName.indexOf(icon.name);
            cate=MenuScene.iconsname[cate_index];
            DebugTrace.msg("MenuTemplate.onTouchMiniMenu scene="+cate);
            if(cate.indexOf("Scene")!=-1){


                tween=new Tween(mini_menu,0.2,Transitions.EASE_IN_OUT);
                tween.scaleTo(0.1);
                tween.animate("rotation",180);
                tween.animate("alpha",0);
                tween.onComplete=onMiniMenuFadout;
                Starling.juggler.add(tween);


            }

        }

    }
    private function onMiniMenuFadout():void{


        Starling.juggler.removeTweens(mini_menu);

        var _data:Object=new Object();
        _data.name=cate;
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function getTexture(src:String):Texture
    {
        var textture:Texture=Assets.getTexture(src);
        return textture;
    }

}
}
