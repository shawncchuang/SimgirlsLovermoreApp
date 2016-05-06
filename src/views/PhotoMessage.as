package views
{
import controller.Assets;
import controller.FilterInterface;
import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;

import data.DataContainer;

import feathers.controls.ImageLoader;

import flash.display.BitmapData;

import flash.display.Loader;



import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

import utils.FilterManager;


//import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;

import utils.DebugTrace;

public class PhotoMessage extends Sprite
{
	//private var alertframe:Image;
	private var btn:Button;
	private var onPhotoComplete:Function;
	private var photosloader:ImageLoader;
	private var domainPath:String;
	private var photo:Sprite;
	private var flox:FloxInterface=new FloxCommand();
	private var filters:FilterInterface=new FilterManager();
	public function PhotoMessage(todo:String,target:String,callback:Function=null):void
	{


		onPhotoComplete=callback;
		DebugTrace.msg("PhotoMessage  target="+target);

        if(target.indexOf("klr")!=-1){
            var fullname:String=Config.fullnames["klr"];
            target=target.split("klr").join(fullname);
        }
		photosloader=new ImageLoader();
		photosloader.alpha=0;
		photosloader.width=Starling.current.stage.stageWidth;
		photosloader.height=Starling.current.stage.stageHeight;
		photosloader.scaleContent=false;
		photosloader.verticalAlign=ImageLoader.VERTICAL_ALIGN_MIDDLE;
		photosloader.horizontalAlign=ImageLoader.HORIZONTAL_ALIGN_CENTER;
		photosloader.source="/images/story/"+target+".jpg";
		photosloader.addEventListener(Event.COMPLETE, onPhotoLoadedComplete);
		addChild(photosloader);

		filters.setShadow(photosloader);

		//this.addEventListener(Event.TRIGGERED,onTouchAlertFrame);
	}
	private function onPhotoLoadedComplete(e:Event):void{


		var tween:Tween=new Tween(photosloader,1,Transitions.EASE_IN_OUT);
		tween.fadeTo(1);
		tween.onComplete=onAlertMessageFadeIn;
		Starling.juggler.add(tween);
	}
	private function onAlertMessageFadeIn():void
	{
		if(onPhotoComplete)
			onPhotoComplete();
		Starling.juggler.removeTweens(photosloader);


	}
//		private function onTouchAlertFrame(e:Event):void
//		{
//
//			var target:Button=e.currentTarget as Button;
//			//DebugTrace.msg("PhotoMessage.onTouchAlertFrame"+target.name)
//			//var BEGAN:Touch=e.getTouch(target,TouchPhase.BEGAN);
//			photosloader.removeFromParent(true);
//			//removeChild(btn);
//			onRemoved();
//		}
}
}