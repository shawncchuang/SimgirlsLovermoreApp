/**
 * Created by shawnhuang on 15-10-22.
 */
package views {
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import events.SceneEvent;

import feathers.controls.ImageLoader;

import feathers.controls.LayoutGroup;

import feathers.layout.TiledRowsLayout;

import flash.geom.Point;

import starling.animation.Transitions;

import starling.animation.Tween;

import starling.core.Starling;

import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;

import utils.ViewsContainer;

public class PreciousPhotosScene extends Sprite{

    private var base_sprite:Sprite;
    private var scencom:SceneInterface=new SceneCommnad();
    private var command:MainInterface=new MainCommand();
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var domainPath:String="";
    public static var PHOTO_ZOOM_IN:String="photo_zoom_in";
    private var preload:Sprite;

    private var flox:FloxInterface=new FloxCommand();

    public function PreciousPhotosScene() {

        domainPath=flox.getSyetemData("photodomain");
        ViewsContainer.currentScene=this;

        this.addEventListener(PreciousPhotosScene.PHOTO_ZOOM_IN,onPhotoZooomInHandle);

        initailizeLayoutHandler();
        initPreciousPhotos();
    }
    private function initailizeLayoutHandler():void{

        base_sprite=new Sprite();
        addChild(base_sprite);
        scencom.init("PreciousPhotosScene",base_sprite,20);


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="PHOTOS";
        templete.label="Precious Moments";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-420,110),to:new Point(-180,150)},
            {from:new Point(1440,150),to:new Point(1200,150)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();

        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(114,80),to:new Point(114,80)});
        templete.addMiniMenu();
        addChild(templete);
    }
    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }
    private function initPreciousPhotos():void{


        var photoslayout:PhotosTiledRowsLayout=new PhotosTiledRowsLayout();
        photoslayout.domainPath=domainPath;
        photoslayout.width=780;
        photoslayout.height=500;
        photoslayout.x=140;
        photoslayout.y=180;

        addChild(photoslayout);

    }
    private var bg:Quad;
    private var imgloader:ImageLoader;
    private var photo:Sprite;
    private function onPhotoZooomInHandle(e:Event):void{

        var file:String=e.data.file.split("@S").join("");

        photo=new Sprite();
        photo.y=160;
        bg = new Quad( 1024,567, 0x000000 );
        bg.alpha=0;
        photo.addChild(bg);

        imgloader=new ImageLoader();
        imgloader.useHandCursor=true;
        imgloader.width=972;
        imgloader.height=547;
        imgloader.x=26;
        imgloader.y=10;
        imgloader.alpha=0;
        imgloader.source=domainPath+file+".jpg";
        imgloader.addEventListener(Event.COMPLETE, onPhotoLoadedComplete);
        photo.addChild(imgloader);

        this.addChild(photo);
        templete.visbleBackStepButton(false);

        preload=new LoadingBuffer();
        addChild(preload);

        var tween:Tween=new Tween(bg,0.5,Transitions.EASE_IN);
        tween.fadeTo(1);
        Starling.juggler.add(tween);
    }

    private function onPhotoLoadedComplete(e:Event):void{

        preload.removeFromParent(true);
        Starling.juggler.removeTweens(bg);

        var tween:Tween=new Tween(imgloader,0.5,Transitions.EASE_IN);
        tween.fadeTo(1);
        Starling.juggler.add(tween);

        photo.addEventListener(TouchEvent.TOUCH, onTouchPhotoHandler);
    }
    private function onTouchPhotoHandler(e:TouchEvent):void{
        var target:Sprite=e.currentTarget as Sprite;

        //var hovor:Touch = e.getTouch(loader, TouchPhase.HOVER);
        var began:Touch = e.getTouch(target, TouchPhase.BEGAN);
        if(began){
            target.removeEventListener(TouchEvent.TOUCH, onTouchPhotoHandler);
            var tween:Tween=new Tween(target,0.5,Transitions.EASE_IN);
            tween.fadeTo(0);
            tween.onComplete=onPhotoZoomInFadeout;
            Starling.juggler.add(tween);

        }

    }
    private function onPhotoZoomInFadeout():void{

        Starling.juggler.removeTweens(photo);
        photo.removeFromParent(true);
        templete.visbleBackStepButton(true);
    }

}
}
