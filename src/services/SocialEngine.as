package services
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.system.Security;

	import utils.DebugTrace;
	public class SocialEngine
	{
		protected var api_key:String="MDhjMjM0OTk0ZDZiMzQ5YmZiZjZmZDI3";
		protected var api_url:String="http://simgirls.api.socialengine.com/";
		public function init():void
		{
		 
			//Security.allowDomain(api_url);
			//Security.loadPolicyFile("http://www.picanada.org/game/crossdomain.xml");
			//Security.loadPolicyFile("http://se5revolution.s3.amazonaws.com/uploads/2754/318144.xml");
			var req:URLRequest=new URLRequest(api_url+"members?api_key="+api_key)
		 
			var vars:URLVariables=new URLVariables();
			vars.api_key=api_key;
		 
			var loader:URLLoader=new URLLoader();
			loader.load(req);
			loader.addEventListener(Event.COMPLETE,onCallSocialEngineAPI);
			loader.addEventListener(IOErrorEvent.IO_ERROR,onIOError)
		}
		private function onCallSocialEngineAPI(e:Event):void
		{
	         
			DebugTrace.msg(e.target.data);
			var members:Object=JSON.parse(e.target.data);
			
			var member_id:String=members.data[0].member_id;
			var msg:String="member_id:"+member_id+" ;first_name:"+members.data[0].first_name+" ;last_name:"+members.data[0].last_name
			DebugTrace.msg(msg);
		}
		private function onIOError(e:IOErrorEvent):void
		{
		 
			DebugTrace.msg("onIOError:"+e);
		}
	}
}