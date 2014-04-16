package controller
{
	import flash.geom.Point;
	
	import starling.display.Sprite;
	
	public interface MainInterface
	{
		function topviewDispatch(type:String,data:Object=null):void
		function addDisplayObj(current:String,target:String):void
		function filterTalking(source:Array):Array
		function sceneDispatch(type:String,data:Object=null):void
		//function initPlayerTalkLibrary(callback:Function=null):void
		function initSceneLibrary():void
		function playBackgroudSound(src:String):void
		function playSound(src:String):void
		function stopBackgroudSound():void
		function dateManager(type:String):void
		function filterScene(target:Sprite):void
		function listArrowEnabled(index:Number,pages:Number,left:*,right:*):void
		function setNowMood():void
		function  moodCalculator(item_id:String,dating:String):Number
		function updateRelationship(mood:Number):void
		function searchAssetRating(item_id:String):Number
		function displayUpdateValue(target:Sprite,_data:Object):void
		function addedConfirmButton(target:Sprite,callback:Function,pos:Point=null):void
		function addedCancelButton(target:Sprite,callback:Function,pos:Point=null):void
	    function initSchedule():void
		function doRest(free:Boolean):void
		function showCommandValues(target:Sprite,attr:String,value:Object=null):void
		function doStay(days:Number):void
		function doTrain():void
		function doWork(income:Number):void
		function doLearn(increaseINT:Number):void
		function doMeditate():void
		function copyPlayerAndCharacter():void
		function clearCopyPixel():void
		function addLoadind(msg:String):void
		function removeLoading():void
	}
}