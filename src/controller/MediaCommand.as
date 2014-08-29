package controller
{

import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.NetStatusEvent;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.media.Video;
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


public class MediaCommand implements MediaInterface
{
    private var path:String;

    private const VIDEO_FINISHED:String = "NetStream.Play.Stop";
    private const VIDEO_NOT_FOUND:String = "NetStream.Play.StreamNotFound";

    /*== Video Loading==*/
    private var nc:NetConnection;
    private var ns:NetStream;

    /*== Video Holder ==*/
    private var video:Video;

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

    public function SWFPlayer(id:String,src:String,callback:Function):void{

        _id=id;
        onTransFormComplete=callback;
        act=new flash.display.MovieClip();
        var loaderReq:LoaderRequest=new LoaderRequest();
        loaderReq.setLoaderQueue(id,src,act,onLoaderComplete);

        Starling.current.nativeOverlay.addChild(act);
    }
    private function onLoaderComplete(e:LoaderEvent):void{

        trace("MediaCommmand.onLoaderComplete id="+_id);
        var swfloader:SWFLoader = LoaderMax.getLoader(_id);

        swfloader.rawContent.addEventListener(flash.events.Event.ENTER_FRAME, onActComplete);

    }
    private function onActComplete(e:flash.events.Event):void{


       if(e.target.currentFrame==e.target.totalFrames){

           e.target.removeEventListener(flash.events.Event.ENTER_FRAME, onActComplete);
           e.target.stop();
           //TweenMax.to(act,0.5,{alpha:0,onComplete:onCompleteSwfFadeOut})
           onCompleteSwfFadeOut();
       }

    }
    private function onCompleteSwfFadeOut():void{


        LoaderMax.getLoader(_id).unload();

        Starling.current.nativeOverlay.removeChild(act);
        onTransFormComplete();

    }

    public function VideoPlayer(size:Point, position:Point, fps:int = 30):void
    {
        this.size = size;
        this.position = position;
        this.loop = loop;
        this.fps = fps;

        bootstrap();
    }

    private function onVideoComplete(e:Event):void
    {
        if(onFinished != null){
            onFinished();
        }
    }

    private function bootstrap():void
    {
        nc = new NetConnection();
        nc.connect(null); //local files

        ns = new NetStream(nc);
        ns.client = {
            NetStatusEvent : onPlayStatus
        };

        ns.addEventListener(NetStatusEvent.NET_STATUS, onPlayStatus);
        var sw:Number=Starling.current.stage.stageWidth;
        var sh:Number=Starling.current.stage.stageHeight;


        video = new Video(size.x,size.y);
        video.x=position.x;
        video.y=position.y;
        video.attachNetStream(ns);

        Starling.current.nativeOverlay.addChild(video);

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
        Starling.current.nativeOverlay.removeChild(video);
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

            onFinished();


        }
    }


}
}