package controller
{
import flash.geom.Point;
import flash.media.SoundChannel;
import flash.media.SoundTransform;

import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;

public interface MainInterface
{

    function topviewDispatch(type:String,data:Object=null):void
    function updateInfo():void
    function addDisplayObj(current:String,target:String):void
    function filterTalking(source:Array):Array
    function sceneDispatch(type:String,data:Object=null):void

    function initSceneLibrary():void
    function initStyleSchedule(callback:Function=null):void
    function playBackgroudSound(src:String,st:SoundTransform=null):void
    function playSound(src:String,repeat:Number=0,st:SoundTransform=null):SoundChannel
    function stopBackgroudSound():void
    function dateManager(type:String):void
    function filterScene(target:Sprite):void
    function listArrowEnabled(index:Number,pages:Number,left:*,right:*):void
    function setNowMood():void
    function moodCalculator(item_id:String,dating:String):Number
    function updateRelationship():void
    function searchAssetRating(item_id:String):Number
    function displayUpdateValue(target:Sprite,_data:Object):void
    function addedConfirmButton(target:Sprite,callback:Function,pos:Point=null):void
    function addedCancelButton(target:Sprite,callback:Function,pos:Point=null):Image

    function initSchedule():void
    function doRest(free:Boolean):void
    function showCommandValues(target:Sprite,attr:String,value:Object=null):void
    function doStay(days:Number):void
    function doTrain():void
    function doWork():void
    function doLearn():void
    function doMeditate():void
    function drawPlayer(target:Sprite,avatar:Object=null):Sprite
    function drawCharacter(target:Sprite,style:String):Image
    function copyPlayerAndCharacter():void
    function clearCopyPixel():void
    function addLoadind(msg:String):void
    function removeLoading():void
    function addAttention(msg:String):void
    function stopSound(name:String):void
    function initMainStory():void
    function verifySwitch():Boolean
    function consumeHandle(com:String):Boolean
    function syncSpiritEnergy():void
    function checkSystemStatus():void
    function initCharacterLocation(type:String,arrived:Array=null):void
    function addShortcuts():void
    function removeShortcuts():void
    function initCriminalsRecord():void
    function criminalAbility():Object;
    function showSaveError(attr:String,data:*,msg:String):void

    function initContextMenu():void

}
}