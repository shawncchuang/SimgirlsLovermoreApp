package controller
{
	import flash.geom.Point;
	
	 

	public interface MediaInterface
	{
		function PlayVideo(src:String,target:*,size:Point=null, position:Point=null, fps:int = 30,format:String="flv",callpack:Function=null):void
		function play(path:String, loop:Boolean = true, callback:Function = null):void
        function SWFPlayer(id:String,src:String,callback:Function):void

	}
}