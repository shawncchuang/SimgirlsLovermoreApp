package services
{
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.net.SharedObjectFlushStatus;
import flash.net.URLLoader;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.net.URLRequestMethod;
import flash.net.URLVariables;
import flash.net.navigateToURL;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import data.Config;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	public class LoaderRequest
	{
	 private var loaderdata:URLLoader;
		private var onComplete:Function;
		public function LoaderHandle(target:MovieClip=null,url:String="",callback:Function=null):void
		{
			var loader:Loader=new Loader();
			var req:URLRequest=new URLRequest(url);
			if(callback)
			{
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,callback);
			}
			if(url!=""){

				loader.load(req);
				target.addChild(loader);
			}

		}
		public function URLLoaderHandle(url:String="",callback:Function=null):void{
			var loader:URLLoader = new URLLoader();
			//loader.dataFormat = URLLoaderDataFormat.VARIABLES;
			if(callback)
			{	loader.addEventListener(Event.COMPLETE, callback);
			}

			var req:URLRequest = new URLRequest(url);
			loader.load(req);

		}
		public function paymentWeb(type:String):void
		{

			var flox:FloxInterface=new FloxCommand();
			var  authKey:String=flox.getPlayerData("id");
			if(type=="coin")
			{
				var url:String=Config.payCoinURL+authKey;
			}
			else
			{
				url=Config.payGameURL+authKey;
				
			}
			DebugTrace.msg("LoaderReuest.paymentWeb url:"+url);
			var req:URLRequest=new URLRequest(url);
			navigateToURL(req,"_blank");
			
			
		}
		
		public function sendtoSharedObject(auth:String,email:String):void
		{
			 
			var so:SharedObject = SharedObject.getLocal("simgirls");
			var flushStatus:String = null;
			try 
			{
				flushStatus=so.flush(100);
			} catch (error:Error) {
				DebugTrace.msg("Error...Could not write SharedObject to disk\n");
			}
			//try,catch
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING:
						DebugTrace.msg("Requesting permission to save object...\n");
						
						break;
					case SharedObjectFlushStatus.FLUSHED:
						so.data.auth=auth;
						so.data.email=email;
						DebugTrace.msg("Value flushed to disk.\n");
						break;
				}
				//switch

		}
		public function getSharedObject(attr:String):String
		{
			
			var so:SharedObject = SharedObject.getLocal("simgirls");
			var resault:String=so.data[attr];
			
			//DebugTrace.msg("LoaderRequest.getSharedObject resault:"+resault);
			return resault;
		}
		public function setLoaderQueue(id:String,src:String,target:*,callback:Function=null):void
		{
			var autoplay:Boolean=false;
            if(id=="transform" || id=="battletutorial"){
                autoplay=true;
            }

			var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:callback, onError:errorHandler});
			queue.append( new SWFLoader(src, {name:id, container:target, autoPlay:autoplay}) );
			queue.load();
			
		   var queueObj:Object=ViewsContainer.loaderQueue;
			queueObj[id]=queue;
			ViewsContainer.loaderQueue=queueObj;
		}
		 
		private function progressHandler(e:LoaderEvent):void 
		{
			//trace("progress: " + e.target.progress);
		}
		/*
		private function completeHandler(e:LoaderEvent):void
		{
		//	var swfloader:ContentDisplay = LoaderMax.getContent(loadername);
			
			trace(e.target + " is complete!");
		}
		*/
		private function errorHandler(e:LoaderEvent):void 
		{
			trace("error occured with " + e.target + ": " + e.text);
		}

		public function LoaderDataHandle(url:String,callback:Function):void{

			onComplete=callback;
			loaderdata= new URLLoader();
			//loaderdata.dataFormat = URLLoaderDataFormat.VARIABLES;
			loaderdata.addEventListener(Event.COMPLETE, onLoadedComplete);

			var request:URLRequest = new URLRequest(url);
			loaderdata.load(request);

		}
		private function onLoadedComplete(e:Event):void{

			onComplete(e.target.data);

		}

		public function EmptyLoaderMax():void{
			var loaderQueueObj:Object= ViewsContainer.loaderQueue;
			for(var queueID:String in loaderQueueObj){
				var loaderqueue :LoaderMax=loaderQueueObj[queueID];
				loaderqueue.empty(true,true);
			}
			ViewsContainer.loaderQueue=new Object();

		}

		public function navigateToURLHandler(url:String,value:Object=null):void{

			var request:URLRequest = new URLRequest(url);
			var vars:URLVariables = new URLVariables();
			vars.exampleSessionId = new Date().getTime();
			if(value){
				vars.authKey=value.authKey;
			}
			request.data = vars;
			request.method = URLRequestMethod.POST;
			navigateToURL(request,"_self");
		}

	}
}