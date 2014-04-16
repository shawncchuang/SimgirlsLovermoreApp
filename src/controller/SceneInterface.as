package controller
{
	import starling.display.Sprite;
 

	public interface SceneInterface
	{
		
	    function init(current:String,target:Sprite,part_inedx:Number,fished:Function=null):void
	    function start():void
	    function enableTouch():void
		function disableAll():void
	    function createMouseClickIcon():void
	    function clearMouseClickIcon():void
	    function filterBackground():void
		function addDisplayContainer(src:String):void
	}
}