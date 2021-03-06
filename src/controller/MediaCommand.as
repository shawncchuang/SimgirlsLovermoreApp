package controller
{

import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;

import feathers.controls.ImageLoader;
import feathers.media.VideoPlayer;

import flash.display.BitmapData;
import flash.display.StageDisplayState;
import flash.events.NetStatusEvent;
import flash.geom.Point;

import flash.net.NetConnection;
import flash.net.NetStream;
import flash.utils.Dictionary;

import services.LoaderRequest;

import starling.core.Starling;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureSmoothing;

import utils.DebugTrace;
import utils.ViewsContainer;


public class MediaCommand implements MediaInterface
{
    private var path:String;

    private const VIDEO_FINISHED:String = "NetStream.Play.Complete";
    private const VIDEO_NOT_FOUND:String = "NetStream.Play.StreamNotFound";

    /*== Video Loading==*/
    private var nc:NetConnection;
    private var ns:NetStream;

    /*== Video Holder ==*/
    private var player:VideoPlayer;
    private var videoImg:Image;
    private var loader:ImageLoader;

    /*== Video Lists ==*/
    private var currentPath:String;

    /*== Video Properties ==*/
    private var size:Point;
    private var position:Point;
    private var fps:int;
    private var onFinished:Function;

    /*== Play Properties ==*/
    private var loop:Boolean;

    private var _id:String;
    private var act:flash.display.MovieClip;
    private var onTransFormComplete:Function;

    private var _target:*;
    private var format:String;

    public function SWFPlayer(id:String,src:String,callback:Function):void{

        _id=id;
        onTransFormComplete=callback;
        act=new flash.display.MovieClip();
        var loaderReq:LoaderRequest=new LoaderRequest();
        loaderReq.setLoaderQueue(id,src,act,onLoaderComplete);

        Starling.current.nativeOverlay.addChild(act);
    }
    private function onLoaderComplete(e:LoaderEvent):void{

        DebugTrace.msg("MediaCommmand.onLoaderComplete id="+_id);
        var swfloader:SWFLoader = LoaderMax.getLoader(_id);

        if(swfloader.rawContent){
            swfloader.rawContent.addEventListener(flash.events.Event.ENTER_FRAME, onActComplete);
            //swfloader.rawContent.addEventListener(flash.events.Event.REMOVED_FROM_STAGE,onLoaderRemoved);
        }


    }

    private function onActComplete(e:flash.events.Event):void{

        var totalframes:Number=e.target.totalFrames;
                if(_id=="battletutorial"){
                    totalframes=e.target.totalFrames-106;
                }

       if(e.target.currentFrame==totalframes){

           e.target.removeEventListener(flash.events.Event.ENTER_FRAME, onActComplete);
           e.target.stop();
           //TweenMax.to(act,0.5,{alpha:0,onComplete:onCompleteSwfFadeOut})

           onCompleteSwfFadeOut();

       }

    }
    private function onLoaderRemoved(e:flash.events.Event):void{
        e.target.removeEventListener(flash.events.Event.ENTER_FRAME, onActComplete);
        e.target.removeEventListener(flash.events.Event.REMOVED_FROM_STAGE, onLoaderRemoved);
        e.target.stop();
        try{

            LoaderMax.getLoader(_id).unload();

            Starling.current.nativeOverlay.removeChild(act);

        }catch(error){
            DebugTrace.msg("MediaCommand.onCompleteSwfFadeOut LoaderMax upload Null");
        }

    }
    private function onCompleteSwfFadeOut():void{


        try{

            LoaderMax.getLoader(_id).unload();

            Starling.current.nativeOverlay.removeChild(act);

        }catch(error){
            DebugTrace.msg("MediaCommand.onCompleteSwfFadeOut LoaderMax upload Null");
        }
        onTransFormComplete();

    }

    public function PlayVideo(src:String,target:*,size:Point=null, position:Point=null, fps:int = 30,format:String="flv",callpack:Function=null):void
    {
        this.currentPath=src;
        this._target=target;
        this.size = size;
        this.position = position;
        this.loop = loop;
        this.fps = fps;
        this.format = format;
        onFinished=callpack;
        bootstrap();
    }

    private function onVideoComplete(e:Event):void
    {

        loader.dispose();
        player.dispose();
        if(onFinished != null){
            onFinished();
        }
    }

    private function bootstrap():void
    {
//        nc = new NetConnection();
//        nc.connect(null); //local files
//
//        var file:File = File.applicationDirectory.resolvePath("video/"+ this.currentPath+"."+this.format);
//        ns = new NetStream(nc);
//        ns.client = {
//            NetStatusEvent : onPlayStatus
//        };
//
//        ns.addEventListener(NetStatusEvent.NET_STATUS, onPlayStatus);
//        ns.play(file.url);
//
//        var texture:Texture = Texture.fromNetStream(ns, 1, function():void
//        {
//
//            this._target.addChild(new Image(texture));
//        });

        player=new VideoPlayer();
        player.videoSource="video/"+ this.currentPath+"."+this.format;
        //player.setSize( this.size.x, this.size.y );
        //player.fullScreenDisplayState = StageDisplayState.FULL_SCREEN;
        this._target.addChild(player);

        loader=new ImageLoader();
        player.addChild(loader);
        player.addEventListener(Event.COMPLETE, onVideoComplete);
        player.addEventListener( Event.READY, videoPlayer_readyHandler );
    }
    private function videoPlayer_readyHandler(e:Event):void{
        loader.source = player.texture;
    }

    public function play(path:String, loop:Boolean = true, callback:Function = null):void
    {
        this.loop = loop;
        this.currentPath = path;


        if(callback != null){
            onFinished = callback;
        }

        ns.play(path);


    }

    public function stop(cleanup:Boolean = false):void
    {
        ns.close();
        //Starling.current.nativeOverlay.removeChild(video);
        /*
         onVideoComplete(null);
         removeEventListener(Event.ENTER_FRAME, onFrame);

         if(cleanup){
         removeChildren(0, -1, true);
         }
         */
    }


    private function onPlayStatus(e:NetStatusEvent):void
    {

        //DebugTrace.msg(""+video.width+" "+video.height);

        if(e.info.code == VIDEO_NOT_FOUND){
            stop(true);
            throw new Error("Video not found at:"+ this.currentPath);
        }

        if(e.info.code == VIDEO_FINISHED){
            //videosList[currentPath] = tmpVector;
            stop(true);
            this.videoImg.dispose();
            this.videoImg.removeFromParent(true);
            if(onFinished)
            onFinished();


        }
    }


}
}