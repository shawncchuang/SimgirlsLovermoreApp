package services
{
	 
	import flash.external.ExternalInterface;
	
	import controller.MainCommand;

	public class PayPal
	{
		 
		public function init():void
		{
			
			ExternalInterface.addCallback("onCheckout",onPayPalCheckout);
		}
		private function onPayPalCheckout():void
		{
			/*var topview:MovieClip=SimgirlsLovemore.topview;
			var alertMsg:MovieClip=new AlertMsgUI();
			alertMsg.x=1024/2;
			alertMsg.y=768/2;
			alertMsg.msg.text="PayPalCheckout";
			topview.addChild(alertMsg);*/
			
			MainCommand.addAlertMsg("PayPalCheckout");
		}
	}
}