package controller
{
	//import flash.display.MovieClip;
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public interface ElementStones
	{
		function initStoneBar(menu:Sprite):void
		function readyElementStones(cate:String=null):void
		function releaseStones(readystones:Array):void
		function spentStones():void
		function doSpentStones():void
		function onNewRoundWithStones():void
		function getSonesList():Array
		function getElementslist():Array
		function showElementRequest(reqJewel:Array):void
		function getNewReqList():Array
		function releaseElementRequest():void
		function getStonebar():MovieClip
	}
}