package services
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	import utils.DebugTrace;
	public class TurboSMTP
	{
		private var url:String="turbo_email/sendapi_script.php";
		public function init(to:String,key:String):void
		{
			var req:URLRequest=new URLRequest(url);
			req.method=URLRequestMethod.POST;
			var vars:URLVariables=new URLVariables();
			vars.tolist=to;
			vars.authkey=key;
			req.data=vars;
			var loader:URLLoader=new URLLoader();
			loader.load(req);
			loader.addEventListener(Event.COMPLETE,onSendMailComplate);
			 
		}
		private function onSendMailComplate(e:Event):void
		{
			
			var _data:String=JSON.stringify(e.target);
			 
			var re:Object=JSON.parse(_data)
			//	(e.target);
			DebugTrace.obj(re.data);
		}
	}
}