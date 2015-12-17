package controller
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import dragonBones.Bone;

	import starling.display.DisplayObject;
import starling.display.Image;

import starling.display.Sprite;

	public interface DrawerInterface
	{

		function setSource(src:*):void
		function drawCircle(attr:Object):void
		function getBitmapdata():BitmapData
		function setBitmapPorperties(obj:Object):void

		function copyAsBitmapData(sprite:DisplayObject,rec:Rectangle=null,point:Point=null):BitmapData;
		function drawCharacter(basemodel:Sprite=null,attr:Object=null):void
		function updateBaseModel(target:String,avatar:Object=null):void
//		function updateModelColor(type:String,rgb:Object):void
		function drawPlayerProfileIcon(target:Sprite,scale:Number,p:Point,bp:Point=null):void
		function drawCircyleImage(target:Sprite):void
		function drawDragonBon(info:Object,callback:Function=null):void
		function getBodyBon(target:String):Bone
		function drawPieChart(target:Sprite,texture:String):void
		function updatePieChart(value:Number):void
		function drawCharacterProfileIcon(target:Sprite,ch:String,scale:Number):void
		function drawNPCProfileIcon(target:Sprite,id:String,scale:Number):void
		function drawBackground():Sprite
	    function playerModelCopy(target:Sprite,pos:Point):void
	}
}