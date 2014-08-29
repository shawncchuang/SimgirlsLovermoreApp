﻿package services
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
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import data.Config;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	public class LoaderRequest
	{
	 
		public function LoaderHandle(target:MovieClip,url:String,callback:Function=null):void
		{
			var loader:Loader=new Loader();
			var req:URLRequest=new URLRequest(url);
			if(callback)
			{
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE,callback);
			}
			
			loader.load(req);
			target.addChild(loader);
			
		}
		public function paymentWeb(type:String):void
		{
			
			var flox:FloxInterface=new FloxCommand();
			var  authKey:String=flox.getPlayerData("authId");
			if(type=="coin")
			{
				var url:String=Config.payCoinURL+authKey;
			}
			else
			{
				url=Config.payGameURL+authKey;
				
			}
			DebugTrace.msg("BlackTileList onClickItemHandler url:"+url);
			var req:URLRequest=new URLRequest(url);
			navigateToURL(req,"_blank");
			
			
		}
		
		public function sendtoSharedObject(email:String):void
		{
			 
			var so:SharedObject = SharedObject.getLocal("simgirls");
			 
			var flushStatus:String = null;
			try 
			{
				flushStatus = so.flush();
			} catch (error:Error) {
				DebugTrace.msg("Error...Could not write SharedObject to disk\n");
			}
			//try,catch
			if (flushStatus != null) {
				switch (flushStatus) {
					case SharedObjectFlushStatus.PENDING:
						DebugTrace.msg("Requesting permission to save object...\n");
						
						break;
					case SharedObjectFlushStatus.FLUSHED:
						so.data.email=email;
						DebugTrace.msg("Value flushed to disk.\n");
						break;
				}
				//switch
			}
			//if
		}
		public function getSharedObject():String
		{
			
			var so:SharedObject = SharedObject.getLocal("simgirls");
			var email:String=so.data.email;
			
			DebugTrace.msg("LoaderRequest.getSharedObject email:"+email);
			return email;
		}
		public function setLoaderQueue(id:String,src:String,target:MovieClip,callback:Function=null):void
		{
			var autoplay:Boolean=false;
            if(id=="transform"){
                autoplay=true;
            }
			var queue:LoaderMax = new LoaderMax({name:"mainQueue", onProgress:progressHandler, onComplete:callback, onError:errorHandler});
			queue.append( new SWFLoader(src, {name:id, container:target, autoPlay:autoplay}) );
			queue.load();
			
		   ViewsContainer.loaderQueue=queue;
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
	}
}