/**
 * Created by raymondwu on 2014-08-21.
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

    public var chname:String;
    private var facial:MovieClip;
    private var openTimer:Timer;
    private var closeTimer:Timer;
    private var sec:uint=3;
    public function CharacterFacials() {
        super();
        this.addEventListener(Event.REMOVED, onFacialsRemoved);
    }

    public function initlailizeView():void{

        var mood:String=DataContainer.getFacialMood(chname);
        var xml:XML=Assets.getAtalsXML(chname+"FacialsXML");
        var texture:Texture=Assets.getTexture(chname+"Facials");
        var textreAtlas:TextureAtlas=new TextureAtlas(texture,xml);
        var mood_type:String=chname+"-"+mood;
        trace(mood_type);
        facial=new MovieClip(textreAtlas.getTextures(mood_type),24);
        //facial.x=Math.floor((287-facial.width)/2);
        //facial.y=Math.floor((287-facial.height)/2);
        facial.pivotX=facial.width/2;
        facial.pivotY=facial.height/2;
        facial.stop();
        addChild(facial);

        Starling.juggler.add(facial);
        startToCloseCounting();


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
    private function onFacialsRemoved():void{

        openTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToCloseHandle);
        closeTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, onTimoutToOpenHandle);
        Starling.juggler.remove(facial);
        facial.removeFromParent(true);

    }

}
}
