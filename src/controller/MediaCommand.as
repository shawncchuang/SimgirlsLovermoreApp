package controller
{
	
	import flash.display.BitmapData;
	import flash.events.NetStatusEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.utils.Dictionary;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	
	
	public class MediaCommand extends Sprite implements MediaInterface
	{
		private var path:String;
		
		private const VIDEO_FINISHED:String = "NetStream.Play.Stop";
		private const VIDEO_NOT_FOUND:String = "NetStream.Play.StreamNotFound";
		
		/*== Video Loading==*/
		private var nc:NetConnection;
		private var ns:NetStream;
		
		/*== Video Holder ==*/
		private var video:Video;
		private var videoImage:Image;
		private var bmd:BitmapData;
		
		/*== Video Lists ==*/
		private var currentPath:String;
		private var videosList:Dictionary = new Dictionary();
		private var tmpVector:Vector.<Texture>;
		
		/*== Video Properties ==*/
		private var size:Point;
		private var position:Point;
		private var fps:int;
		private var callback:Function;
		
		/*== Play Properties ==*/
		private var loop:Boolean;
		
		public function VideoPlayer(size:Point, position:Point, fps:int = 30):void
		{
			this.size = size;
			this.position = position;
			this.loop = loop;
			this.fps = fps;
			
			bootstrap();
		}
		
		private function onVideoComplete(e:Event):void
		{
			if(callback != null){
				callback();
			}
		}
		
		private function bootstrap():void
		{
			nc = new NetConnection();
			nc.connect(null); //local files
			
			ns = new NetStream(nc);
			ns.client = {
				NetStatusEvent : onPlayStatus
			};
			
			ns.addEventListener(NetStatusEvent.NET_STATUS, onPlayStatus);
			var sw:Number=Starling.current.stage.stageWidth;
			var sh:Number=Starling.current.stage.stageHeight;
			var pixelX:Number=800;
			var pixelY:Number=600;
			
			
			video = new Video(640,480); 
			video.attachNetStream(ns);
			
			
			
		}
		
		public function play(path:String, loop:Boolean = true, callback:Function = null):void
		{
			this.loop = loop;
			this.currentPath = path;
			
			if(callback != null){
				this.callback = callback;
			}
			
			if(videosList[currentPath]){
				showMovieClip();
				return;
			}
			
			addEventListener(Event.ENTER_FRAME, onFrame);
			ns.play(path);
			
			setupVideoImageCarrier();
			
			//Register for caching. Dont put it into dictionary until all frames were populated
			tmpVector = new Vector.<Texture>();
		}
		
		public function stop(cleanup:Boolean = false):void
		{
			ns.close();
			onVideoComplete(null);
			removeEventListener(Event.ENTER_FRAME, onFrame);
			
			if(cleanup){
				removeChildren(0, -1, true);
			}
		}
		
		/*== Alias Methods ==*/
		
		private function setupVideoImageCarrier():void
		{
			
			bmd = new BitmapData(video.width, video.height, true, 0x000000);
			bmd.draw(video);
			
			videoImage = new Image(Texture.fromBitmapData(bmd));
			
			//videoImage.smoothing=TextureSmoothing.TRILINEAR;
			videoImage.x = position.x;
			videoImage.y = position.y;
			
			videoImage.width = size.x;
			videoImage.height = size.y;
			
			addChild(videoImage);
		}
		
		private function onFrame(e:Event):void
		{
			//takes screenshot of the current frame
			
			
			if(!bmd){
				bmd = new BitmapData(video.width, video.height, true, 0x000000);
			}
			bmd.draw(video);
			
			
			var texture:Texture = Texture.fromBitmapData(bmd);
			
			videoImage.texture = texture;
			createFrameAtlas(texture);
		}
		
		private function onPlayStatus(e:NetStatusEvent):void
		{
			
			//DebugTrace.msg(""+video.width+" "+video.height);
			
			if(e.info.code == VIDEO_NOT_FOUND){
				stop(true);
				throw new Error("Video not found at:"+ this.currentPath);
			}
			
			if(e.info.code == VIDEO_FINISHED){
				videosList[currentPath] = tmpVector;
				stop();
				
				if(loop){
					showMovieClip();
				}
			}
		}
		
		private function createFrameAtlas(texture:Texture):void
		{
			var diff:Object = bmd.compare(new BitmapData(video.width, video.height, true, 0x000000));
			
			//No blank frames, prevent flickering
			if(diff == 0)
			{
				return;
			}
			
			var cTexture:Texture = texture;
			tmpVector.push(cTexture);
		}
		
		private function showMovieClip():void
		{
			removeChildren();
			
			var cachedVideo:MovieClip = new MovieClip(videosList[currentPath], this.fps);
			
			cachedVideo.loop = this.loop;
			
			cachedVideo.x = position.x;
			cachedVideo.y = position.y;
			
			cachedVideo.width = size.x;
			cachedVideo.height = size.y;
			
			cachedVideo.addEventListener(Event.COMPLETE, onVideoComplete);
			
			addChild(cachedVideo);
			
			Starling.current.juggler.add(cachedVideo);
		}
	}
}