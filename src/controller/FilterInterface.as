package controller
{
import starling.display.Image;
import starling.display.Sprite;


public interface FilterInterface
{

    function setSource(src:*):void
    function startFlash():void
    function onCompleteFlash():void
    function setShadow(src:*):void
    function setBulr():void
    function changeColor(colot:uint):void
    function doDispose():void
}
}