/**
 * Created by shawnhuang on 2014-08-21.
 */
package views {
import controller.Assets;

import data.DataContainer;

import flash.events.TimerEvent;

import flash.utils.Timer;

import starling.core.Starling;

import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class CharacterFacials extends Sprite {

    public static var UPDATE:String="update";
    public var chname:String;
    private var facial:MovieClip;
    private var openTimer:Timer;
    private var closeTimer:Timer;
    private var sec:uint=3;
    private var textreAtlas:TextureAtlas;
    public function CharacterFacials() {
        super();
        this.addEventListener(Event.REMOVED, onFacialsRemoved);
        this.addEventListener(CharacterFacials.UPDATE,doUpdateFacials);
    }

    public function initlailizeView():void{

        var mood:String=DataContainer.getFacialMood(chname);
        var xml:XML=Assets.getAtalsXML(chname+"FacialsXML");
        var texture:Texture=Assets.getTexture(chname+"Facials");
        textreAtlas=new TextureAtlas(texture,xml);
        var mood_type:String=chname+"-"+mood;

        facial=new MovieClip(textreAtlas.getTextures(mood_type));
        //facial.x=Math.floor((287-facial.width)/2);
        //facial.y=Math.floor((287-facial.height)/2);
        facial.pivotX=facial.width/2;
        facial.pivotY=facial.height/2;
        facial.stop();
        addChild(facial);

        Starling.juggler.add(facial);
        startToCloseCounting();



    }
    private function doUpdateFacials(e:Event):void{

        facialsRemovedHandle();
        initlailizeView();


    }
    private function startToCloseCounting():void{


        openTimer=new Timer(1000,sec);
        openTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToCloseHandle);
        openTimer.start();
    }
    private function onTimoutToCloseHandle(e:TimerEvent):void{

        facial.play();
        openTimer.stop();
        openTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToCloseHandle);


        closeTimer=new Timer(200,1);
        closeTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToOpenHandle);
        closeTimer.start();
    }
    private function onTimoutToOpenHandle(e:TimerEvent):void{

        facial.stop();
        closeTimer.stop();
        closeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToOpenHandle);

        sec=Math.floor(Math.random()*4)+2;

        startToCloseCounting();
    }
    private function onFacialsRemoved(e:Event):void{

        facialsRemovedHandle()

    }
    private function facialsRemovedHandle():void{

        openTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToCloseHandle);
        closeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToOpenHandle);

        Starling.juggler.removeTweens(facial);
        facial.removeFromParent(true);


    }

}
}
