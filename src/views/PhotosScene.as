/**
 * Created by shawn on 2014-09-11.
 */
package views {
import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.Config;

import data.DataContainer;

import events.SceneEvent;

import flash.display.BitmapData;

import flash.geom.Point;
import flash.geom.Rectangle;

import model.SaveGame;

import starling.animation.Transitions;

import starling.animation.Tween;
import starling.core.Starling;

import starling.display.Button;

import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.DrawManager;

public class PhotosScene extends Sprite {

    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();
    private var base_sprite:Sprite;
    private var scencom:SceneInterface=new SceneCommnad();
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var photo:Sprite;
    private var photo_index:Number=0;

    private var pages:TextField;
    private  var leftArrow:Button;
    private var rightArrow:Button;
    private var trash:Button;
    private var download:Button;
    private var bgSprite:Sprite;

    public function PhotosScene() {

        initailizeLayoutHandler();
        initPhotos();

    }
    private function initailizeLayoutHandler():void{



        base_sprite=new Sprite();
        addChild(base_sprite);
        scencom.init("PhotosScene",base_sprite,20);
//        scencom.start();
//        scencom.disableAll();


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="PHOTOS";
        templete.label="SELFIES";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-420,110),to:new Point(-180,150)},
            {from:new Point(1440,150),to:new Point(1200,150)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();

        var quad:Quad=new Quad(1024,567,0x000000);
        quad.y=160;
        templete.addChild(quad);

        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(114,80),to:new Point(114,80)});
        templete.addMiniMenu();
        addChild(templete);


        var pfTexture:Texture=Assets.getTexture("PhotoField");
        var photoField:Image=new Image(pfTexture);
        photoField.x=205;
        photoField.y=190;
        addChild(photoField);

        pages=new TextField(pfTexture.width,50,"");
        pages.format.setTo(font,20);
        pages.x=205;
        pages.y=645;
        addChild(pages);

        var downloadTexture:Texture=Assets.getTexture("IconDownload");
        download=new Button(downloadTexture);
        download.width=80;
        download.height=80;
        download.x=930;
        download.y=166;
        addChild(download);
        download.addEventListener(Event.TRIGGERED,onTriggeredDownload);

        var emptyTexture:Texture=Assets.getTexture("IconTrashEmpty");
        trash=new Button(emptyTexture);
        trash.width=80;
        trash.height=80;
        trash.x=930;
        trash.y=645;
        addChild(trash);
        trash.addEventListener(Event.TRIGGERED,onTriggeredTrash);

        var arrowTexture:Texture=Assets.getTexture("IconArrowPhotos");
        leftArrow=new Button(arrowTexture);
        leftArrow.x=78;
        leftArrow.y=382;
        rightArrow=new Button(arrowTexture);
        rightArrow.scaleX=-1;
        rightArrow.x=924;
        rightArrow.y=382;

        addChild(leftArrow);
        addChild(rightArrow);

        leftArrow.addEventListener(Event.TRIGGERED,onTriggeredPrev);
        rightArrow.addEventListener(Event.TRIGGERED,onTriggeredNext);

        var photos:Array=flox.getSaveData("photos");
        if(photos.length<=1)
        {
            if(photos.length==0)
                photo_index=-1;
            leftArrow.visible=false;
            rightArrow.visible=false;

        }else{
            leftArrow.visible=false;
        }
        pages.text=(photo_index+1)+" / "+photos.length;

        this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoveHandler);

    }
    private function  onTriggeredDownload(e:Event):void{
        command.downloadImagFile(photo);

        var popup:PopupManager=new PopupManager();
        popup.attr="saved_picture";
        popup.msg="Saved into your Desktop/Lovemore Pictures folder";
        popup.init();
        this.addChild(popup);
    }
    private function onTriggeredTrash(e:Event):void{

        var photos:Array=flox.getSaveData("photos");
        if(photos.length>0){


            var fullTexture:Texture=Assets.getTexture("IconTrashFull");
            trash.upState=fullTexture;

            var _photos:Array=photos.splice(photo_index);
            _photos.shift();
            photos=photos.concat(_photos);

            flox.save("photos",photos,onSavePhotoComplete);

            photo_index++;
            if(photo_index>photos.length-1){
                photo_index=photos.length-1;
            }
            updatePhotos();

        }

    }
    private function onSavePhotoComplete(result:SaveGame=null):void{

        var emptyTexture:Texture=Assets.getTexture("IconTrashEmpty");
        trash.upState=emptyTexture;

    }
    private function onTriggeredPrev(e:Event):void{


        photo_index--;
        updatePhotos();

    }
    private function onTriggeredNext(e:Event):void{


        photo_index++;
        updatePhotos();

    }

    private function updatePhotos():void{

        var photos:Array=flox.getSaveData("photos");
        leftArrow.visible=true;
        rightArrow.visible=true;
        if(photo_index<=0){
            leftArrow.visible=false;
        }
        if(photo_index>=photos.length-1){
            photo_index=photos.length-1;
            rightArrow.visible=false;
        }
        pages.text=(photo_index+1)+" / "+photos.length;

        try{

            var tween:Tween=new Tween(photo,0.3,Transitions.EASE_IN_OUT);
            tween.fadeTo(0);
            tween.onComplete=onPhotoFadeOut;
            photo.removeFromParent(true);
            Starling.juggler.add(tween);

        }catch(e:Error){

            DebugTrace.msg("PhotosScene.onTriggeredPrev photo=NULL");
        }


    }
    private function onPhotoFadeOut():void{

        initPhotos();

    }
    private function doCannelHandler():void
    {


        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);
    }
    private function initPhotos():void{

        var time:String=flox.getSaveData("date").split("|")[1];
        var photos:Array=flox.getSaveData("photos");
        var pic:Object=photos[photo_index];
        DebugTrace.msg("PhotosScene.initPhotos pic="+JSON.stringify(pic));

        if(time=="12"){

            time="Day";

        }else{

            time="Night";

        }
        if(pic) {
            var rec:Rectangle=new Rectangle(222,215,575,430);
            photo = new Sprite();
            photo.x = rec.x;
            photo.y = rec.y;
            addChild(photo);

            var scene:String=pic.scene.split("Scene").join("");
            var drawmanager:DrawerInterface=new DrawManager();
            drawmanager.setSource(scene);
            bgSprite=drawmanager.drawBackground();
            //var bgTexture:Texture=Assets.getTexture(scene);
            //var bg:Image=new Image(bgTexture);
            //addChild(bgSprite);
            photo.addChild(bgSprite);



            var avatar:Object=new Object();
            avatar.clothes=pic.player.clothes;
            avatar.pants=pic.player.pants;
            avatar.uppercolor=pic.player.uppercolor;
            avatar.lowercolor=pic.player.lowercolor;

            var player:Sprite=command.drawPlayer(photo,avatar);
            player.y-=20;
            player.scaleX=1.3;
            player.scaleY=1.3;

            var style:String = pic.character.style;
            command.drawCharacter(photo, style);

            //photo.clipRect=new Rectangle(0,0,1024,768);
            photo.mask=new Quad(1024,768);
            photo.scaleX=0.56;
            photo.scaleY=0.56;
            //photo.width=rec.width;
            //photo.height=rec.height;
        }



    }
    private function onRemoveHandler(e:Event):void{

        if(bgSprite)
            bgSprite.removeFromParent(true);
        if(photo)
            photo.removeFromParent(true);
    }






}
}
