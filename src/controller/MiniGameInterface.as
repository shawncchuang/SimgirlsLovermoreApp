package controller
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import events.MiniGameEvent;

	public interface MiniGameInterface
	{
		function drawFocusbackground(_scene:*,_stage:*):void
		function init(stage:MovieClip,type:String):void
		function createEnemyBike(point:Point):void
		function createPlayerBike():void
		function initGameEvent():MiniGameEvent
		function initEnemyMessingMotion():void
		function gameComplete():void
			
	}
}