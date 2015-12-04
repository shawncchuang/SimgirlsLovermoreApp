/**
 * Created by shawnhuang on 15-10-22.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;

import feathers.controls.ImageLoader;
import feathers.controls.PanelScreen;
import feathers.layout.TiledRowsLayout;

import starling.display.Image;

import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

import utils.DebugTrace;

import utils.ViewsContainer;

public class PhotosTiledRowsLayout extends PanelScreen{


    public var domainPath:String="";
    private var flox:FloxInterface=new FloxCommand();

    public function PhotosTiledRowsLayout() {
        super();
    }
    override protected function initialize():void{

        super.initialize();


        var layout:TiledRowsLayout= new TiledRowsLayout();
        layout.padding=0;
//        layout.paddingTop=0;
//        layout.paddingRight=0;
//        layout.paddingBottom=0;
//        layout.paddingLeft=0;
        //layout.gap=2;
        layout.horizontalGap=5;
        layout.verticalGap=5;
        layout.horizontalAlign = TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
        layout.verticalAlign = TiledRowsLayout.VERTICAL_ALIGN_TOP;

        layout.tileHorizontalAlign=TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
        layout.tileVerticalAlign=TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;

        layout.requestedColumnCount=0;

        layout.paging = TiledRowsLayout.PAGING_NONE;

        this.layout = layout;
        //this.snapToPages=TiledRowsLayout.PAGING_NONE;
        //this.snapScrollPositionsToPixels = true;

        var relHeirarchy:Array=Config.relHierarchy;
        var characters:Array=Config.datingCharacters;
        var photosstore:Object=flox.getSyetemData("preciousphotos");
        var allRel:Object=flox.getSaveData("rel");
        var photosList:Array=new Array();
        for(var i:uint=0;i<characters.length;i++){


            var character:String=characters[i];
            var currentRel:String=allRel[character];
            var relLv:Number=relHeirarchy.indexOf(currentRel);

            var photoType:String="S";
            if(currentRel=="foe" || currentRel=="acquaintance"){
                photoType="Lock";
            }

            for(var m:uint=2;m<relHeirarchy.length;m++){
                var relName:String= relHeirarchy[m];
                var amount:Number=photosstore[character][relName];

                if(relName=="close friend"){
                    relName=relName.split(" ").join("");
                }else if(relName=="dating partner"){
                    relName="dating";
                }
                if(m>relLv){
                    photoType="Lock";
                }


                for(var k:uint=0;k<amount;k++){

                    var photos:Object=new Object();
                    var fileName:String=character+"_"+relName+(k+1)+"@"+photoType;
                    //var fileName:String="ceil_"+relName+(k+1)+"@"+photoType;
                    //sphotos.character=character;
                    photos.id=photosList.length;
                    photos.fileName=fileName;
                    photosList.push(photos);
                }

            }


        }

        photosList=photosList.sortOn("id",Array.NUMERIC);
        //DebugTrace.msg("PhotosTiledRowsLayout.initialize photosList="+JSON.stringify(photosList));


        for(var j:int = 0; j < photosList.length; j++)
        {

            var photofile:String=photosList[j].fileName.split("@")[0];
            var type:String=photosList[j].fileName.split("@")[1];
            photofile+="@S";


            var preSprite:Sprite=new Sprite();

            preSprite.name=photofile;
            preSprite.scaleX=0.9;
            preSprite.scaleY=0.9;

            var frameTexture:Texture=Assets.getTexture("PreviewFrame");
            var frame:Image=new Image(frameTexture);
            preSprite.addChild(frame);


            var imgloader:ImageLoader=new ImageLoader();
            imgloader.x=9;
            imgloader.y=38;
            imgloader.snapToPixels=true;
            //imgloader.delayTesxtureCreation = true;
            imgloader.source=domainPath+photofile+".png";
            preSprite.addChild(imgloader);


            var lockTexture:Texture=Assets.getTexture("PreviewLock");
            var lock:Image=new Image(lockTexture);
            lock.x=4;
            lock.y=2;
            preSprite.addChild(lock);

            if(type=="S"){
                lock.alpha=0;
                preSprite.useHandCursor=true;
                preSprite.addEventListener(TouchEvent.TOUCH,onTouchImageHandler);
            }


            this.addChild( preSprite );
        }


    }
    private function onTouchImageHandler(e:TouchEvent):void{

        var target:Sprite=e.currentTarget as Sprite;

        //var hovor:Touch = e.getTouch(loader, TouchPhase.HOVER);
        var began:Touch = e.getTouch(target, TouchPhase.BEGAN);

        if(began){


            var  scene:Sprite=ViewsContainer.currentScene;
            var _data:Object=new Object();
            _data.file=target.name;
            scene.dispatchEventWith(PreciousPhotosScene.PHOTO_ZOOM_IN,false,_data);

        }

    }

}
}
