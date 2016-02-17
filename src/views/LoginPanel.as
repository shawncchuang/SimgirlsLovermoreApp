package views
{
	import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
	import flash.net.SharedObject;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	
	import services.LoaderRequest;

import starling.core.Starling;
import starling.display.Sprite;

import utils.DebugTrace;

	public class LoginPanel extends MovieClip
	{
		private var panel:LoginUI;
		//beta version
		private var newaccount:MovieClip;
		private var signin:MovieClip;
		private var signup_submit:MovieClip;
		private var signin_submit:MovieClip;
		private var type:String="preorder";
		private var flox:FloxInterface=new FloxCommand();
		private var preorder:MovieClip;
		private var preorder_submit:MovieClip;
		public function LoginPanel()
		{
			
			
		
			
			panel=new LoginUI();
			panel.signup_ui.visible=false;
			
			panel.x=1024/2;
			panel.y=768/2;
			addChild(panel);
			
			newaccount=panel.signup;
			signin=panel.signin;
			signup_submit=panel.signup_ui.signup_submit;
			signin_submit=panel.signin_submit;
			
			preorder=panel.preorder;
			preorder_submit=panel.preorder_signin_ui.submit;
			
			signup_submit.buttonMode=true;
			signup_submit.mouseChildren=false;
			signup_submit.addEventListener(MouseEvent.CLICK,doSubmitSignup);
			signup_submit.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
			signup_submit.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
			
			signin.buttonMode=true;
			signin.mouseChildren=false;
			signin.addEventListener(MouseEvent.CLICK,doBackSignin);
			signin.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
			signin.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
			
			newaccount.visible=false;
			newaccount.buttonMode=true;
			newaccount.mouseChildren=false;
			newaccount.addEventListener(MouseEvent.CLICK,doSignup);
			newaccount.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
			newaccount.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
			
			signin_submit.buttonMode=true;
			signin_submit.mouseChildren=false;
			signin_submit.addEventListener(MouseEvent.CLICK,doSignin);
			signin_submit.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
			signin_submit.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
			
			preorder.buttonMode=true;
			preorder.mouseChildren=false;
			preorder.addEventListener(MouseEvent.CLICK,doBackPreOrder);
			preorder.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
			preorder.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
			
			
			preorder_submit.buttonMode=true;
			preorder_submit.mouseChildren=false;
			preorder_submit.addEventListener(MouseEvent.CLICK,doPreOrderSubmit);
			preorder_submit.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
			preorder_submit.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);

			praseNowType();

		}
		 
		private function doBackSignin(e:MouseEvent):void
		{
			type=e.target.name;
		 
			praseNowType();
		}
		private function doSubmitSignup(e:MouseEvent):void
		{
			
			var mail:String=panel.signup_ui.account.text;
			var pwd:String=panel.signup_ui.pswd.text;
			//var player_name:String=panel.signup_ui.player_name.text;
			DebugTrace.msg("LoingPaenl.doSubmitSignup mail="+mail+" , pwd="+pwd);
			var success:Boolean=false;
			var msg:String="";
			if(mail!="" && pwd!="")
			{
				success=true
			}
			
			if(!success)
			{
				msg=" Please input correct email and password !!";
				MainCommand.addTalkingMsg(msg);
				
			}
			else
			{	
				
				if(validateEmail(mail))
				{
					
					success=true;
				}
				else
				{
					success=false;
					msg=" Please input correct email !!";
					MainCommand.addTalkingMsg(msg);
				}
				//if
				
				flox.signupAccount(mail,pwd);
			}
			//if
		}
		private function doSignin(e:MouseEvent):void
		{
			
			flox.loginWithKey(panel.account.text,panel.pswd.text);
			
		}
		private function doSignup(e:MouseEvent):void
		{
			type=e.target.name;
			 
			//flox.signupAccount(panel.account.text,panel.pswd.text);
			addLoadingAni();
			praseNowType();
		}
		private function doBackPreOrder(e:MouseEvent):void
		{
			type=e.target.name;
		 
			praseNowType();
		}
		private function doPreOrderSubmit(e:MouseEvent):void
		{
			
			flox.loginWithEmail(panel.preorder_signin_ui.account.text);
			
		}
		private function validateEmail(str:String):Boolean 
		{
			var pattern:RegExp = /(\w|[_.\-])+@((\w|-)+\.)+\w{2,4}+/;
			var result:Object = pattern.exec(str);
			if(result == null) 
			{
				return false;
			}
			//if
			return true;
		}
		private function doMouseOverHandle(e:MouseEvent):void
		{
			e.target.gotoAndStop(2);
			
		}
		private function doMouseOutHandle(e:MouseEvent):void
		{
			
			e.target.gotoAndStop(1);
			
			praseNowType();

		}
		private function praseNowType():void
		{
			
			//newaccount.gotoAndStop(1);
			signin.gotoAndStop(1);
			preorder.gotoAndStop(1);
			
			panel.preorder_signin_ui.visible=false;
			panel.signup_ui.visible=false;
			
			if(type=="signin")
			{
				signin.gotoAndStop(2);
			}
			else if(type=="signup")
			{
				//newaccount.gotoAndStop(2);
				panel.signup_ui.visible=true;
			}
			else
			{
				preorder.gotoAndStop(2);
				panel.preorder_signin_ui.visible=true;
			}
			//if
			displaySharedObejct();
		}
		private function displaySharedObejct():void{
			var loaderReq:LoaderRequest=new LoaderRequest();
			var so_email:String=loaderReq.getSharedObject("email");
			if(so_email){
				panel.account.text=so_email;
				panel.preorder_signin_ui.account.text=so_email;
			}

		}
		private var buffer:MovieClip;
		private function addLoadingAni():void
		{


			buffer=new LoadingAni();
			addChild(buffer);
		}

		private function onRemovedHandler(e:Event):void{


            if(buffer)
			removeChild(buffer);
		}
	}
}