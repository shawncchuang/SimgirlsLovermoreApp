package views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import fl.video.FLVPlayback;
	
	import utils.DebugTrace;
	public class SceneVideo extends MovieClip
	{
		private var completeCallback:Function;
		public function SceneVideo(target:String,callback:Function=null)
		{
			DebugTrace.msg("SceneVideo.onVideoComplete target:"+target);
			completeCallback=callback;
			var flvplayer:FLVPlayback=new FLVPlayback();
			flvplayer.width=1024;
			flvplayer.height=768;
			flvplayer.autoPlay=true;
			flvplayer.source="video/"+target+".flv";
			flvplayer.addEventListener(Event.COMPLETE,onVideoComplete);
			addChild(flvplayer);
			var videoMask:MovieClip=new SceneMask();
			addChild(videoMask);
			/*var videoframe:MovieClip=new VideoFrame();
			videoframe.videoloader.source="video/"+target+".f4v";
			videoframe.videoloader.addEventListener(Event.COMPLETE,onVideoComplete);
			addChild(videoframe);*/
		}
		private function onVideoComplete(e:Event):void
		{
			DebugTrace.msg("onVideoComplete");
			if(completeCallback)
			{
				completeCallback();
			}
		}
	}
}