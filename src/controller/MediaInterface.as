package controller
{
	import flash.geom.Point;
	
	 

	public interface MediaInterface
	{
		function VideoPlayer(src:String,target:*,size:Point=null, position:Point=null, fps:int = 30):void
		function play(path:String, loop:Boolean = true, callback:Function = null):void
        function SWFPlayer(id:String,src:String,callback:Function):void

	}
}