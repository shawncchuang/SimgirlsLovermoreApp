/**
 * Created by shawnhuang on 2016-01-06.
 */
package views {
import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.Config;

import events.SceneEvent;

import feathers.controls.Button;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.text.TextFormat;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;

import utils.DebugTrace;

import utils.DrawManager;
import utils.ViewsContainer;

public class TwinFlameForm extends Sprite{

    private var twinflameMask:Image;
    private var title:TextField;
    private var drawcom:DrawerInterface=new DrawManager();
    private var font:String="SimImpact";
    private var flox:FloxInterface=new FloxCommand();
    private var icons:Array=new Array();

    public function TwinFlameForm() {


        initLayout();
    }
    private function initLayout():void{

        var maskTexture:Texture=Assets.getTexture("SceneMask");
        twinflameMask=new Image(maskTexture);
        addChild(twinflameMask);

        var _title:String="Please...";
        title=new TextField(1024,45,_title,font,20,0xFFFFFF);
        title.y=640;
        addChild(title);


        var characters:Array=Config.datingCharacters;
        for(var i:uint=0;i<characters.length;i++) {
            var name:String = characters[i];
            var nameStr:String=name.split(name.charAt(0)).join("");
            var fisrtChar:String=name.charAt(0).toUpperCase();
            var nameformat:String=fisrtChar+nameStr;

            var ch:String=characters[i];
            var texture:Texture=Assets.getTexture(ch+"Facials");
            var xml:XML=Assets.getAtalsXML(ch+"FacialsXML");
            var atlas:TextureAtlas=new TextureAtlas(texture,xml);
            var _texture:Texture=atlas.getTexture(ch+"-pleased1");
            var img:Image=new Image(_texture);
            img.smoothing=TextureSmoothing.TRILINEAR;
            var btn:Button=new Button();
            btn.name=nameformat;
            btn.defaultIcon=img;
            btn.iconPosition=Button.ICON_POSITION_TOP;
            btn.label=nameformat;
            btn.x = i * 85+230;
            btn.y = 680;
            btn.scaleX=0.35;
            btn.scaleY=0.35;
            btn.labelFactory = function():ITextRenderer
            {
                var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
                textRenderer.textFormat = new TextFormat( font, 50, 0xFFFFFF );
                textRenderer.embedFonts = true;
                return textRenderer;
            }
            btn.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);

            icons.push(btn);
            addChild(btn);
        }


    }
    private function onTouchCharaterIcon(e:TouchEvent):void{

        var target:Button=e.currentTarget as Button;

        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);

        if(began)
        {

            //DebugTrace.msg("TwinFlameForm.onTouchCharacterIcon target="+target.name);
            if(!SimgirlsLovemore.previewStory){

                flox.save("twinflame",target.name);
            }
            removeHandler();

        }

    }
    private function removeHandler():void{



        for(var i:uint=0;i<icons.length;i++){
            icons[i].dispose();
            icons[i].removeFromParent(true);
        }
        title.removeFromParent(true);

        twinflameMask.dispose();
        twinflameMask.removeFromParent(true);


        var _data:Object=new Object();
        _data.type="twinflame";
        var mainStage:Sprite=ViewsContainer.MainStage;
        mainStage.dispatchEventWith(SceneEvent.CLEARED,false,_data);

    }
}
}
