package controller
{
	import starling.display.Sprite;
 

	public interface SceneInterface
	{
		
	    function init(current:String,target:Sprite,part_inedx:Number,fished:Function=null):void
		function reseat():void
		function start():void
	    function enableTouch():void
		function disableAll():void
	    function createMouseClickIcon():void
	    function clearMouseClickIcon():void
	    function filterBackground():void
		function addDisplayContainer(src:String):void
		function set currentSwitch(id:String):void
		function get currentSwitch():String
		function switchGateway(type:String ,callback:Function=null):*
		function doClearAll():void
		function initStory(finshed:Function=null):void
		function onStoryFinished():void
		function createAnimateEffect(src:String):void
	}
}