package controller
{
	import flash.geom.Point;
	
	 

	public interface MediaInterface
	{
		function VideoPlayer(size:Point, position:Point, fps:int = 30):void
		function play(path:String, loop:Boolean = true, callback:Function = null):void
        function SWFPlayer(id:String,src:String,callback:Function):void

	}
}