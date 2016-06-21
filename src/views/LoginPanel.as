package views
{
import com.gamua.flox.utils.Base64;
import com.gamua.flox.utils.SHA256;
import com.greensock.TweenMax;

import data.Config;
import data.DataContainer;

import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.net.SharedObject;

import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;

import flash.utils.Timer;

import services.LoaderRequest;

import starling.core.Starling;
import starling.display.Sprite;

import utils.DebugTrace;
import utils.ViewsContainer;

public class LoginPanel extends MovieClip
{
	private var panel:LoginUI;
	//beta version
	private var newaccount:MovieClip;
	private var signin:MovieClip;
	private var signup_submit:MovieClip;
	private var signin_submit:MovieClip;
	private var type:String="signin";
	private var flox:FloxInterface=new FloxCommand();
	private var preorder:MovieClip;
	private var preorder_submit:MovieClip;
	private var resetPanel:MovieClip;
	private var code:String;
	private var timer:Timer;
	public function LoginPanel()
	{




		panel=new LoginUI();
		panel.signup_ui.visible=true;
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
		//signup_submit.addEventListener(MouseEvent.CLICK,doSubmitSignup);
		//signup_submit.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
		//signup_submit.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);

		signin.buttonMode=true;
		signin.mouseChildren=false;
		signin.addEventListener(MouseEvent.CLICK,doBackSignin);
		signin.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
		signin.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);

		newaccount.visible=false;
		newaccount.buttonMode=true;
		newaccount.mouseChildren=false;
		//newaccount.addEventListener(MouseEvent.CLICK,doSignup);
		//newaccount.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
		//newaccount.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);

		signin_submit.buttonMode=true;
		signin_submit.mouseChildren=false;
		signin_submit.addEventListener(MouseEvent.CLICK,doSubmit);
		signin_submit.addEventListener(MouseEvent.ROLL_OVER,doMouseOverHandle);
		signin_submit.addEventListener(MouseEvent.ROLL_OUT,doMouseOutHandle);
		panel.reseticon.buttonMode=true;
		panel.reseticon.addEventListener(MouseEvent.CLICK,doResetPassword);

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

		initRestPasswordPanel();

		this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);
		praseNowType();
		displaySharedObejct();

		createVerifyCode();
	}

	private function initRestPasswordPanel():void{

		resetPanel=panel.resetpwd;
		resetPanel.submit.buttonMode=true;
		resetPanel.cancel.buttonMode=true;
		resetPanel.submit.addEventListener(MouseEvent.CLICK,doResetSubmit);
		resetPanel.cancel.addEventListener(MouseEvent.CLICK,doResetCancel);
		resetPanel.visible=false;
	}
	private function doResetSubmit(e:MouseEvent):void{

		resetPanel.visible=false;
		flox.resetPassword(resetPanel.email.text);
	}
	private function doResetCancel(e:MouseEvent):void{

		TweenMax.to(resetPanel,0.5,{visible:false,onComplete:onResetPanelFadIn});

		function onResetPanelFadIn():void{
			TweenMax.killChildTweensOf(resetPanel);
		}
	}

	private function doBackSignin(e:MouseEvent):void
	{
		type=e.target.name;

		praseNowType();
	}
	private function doSubmit(e:MouseEvent):void
	{

		var mail:String=panel.account.text;
		var pwd:String=panel.pswd.text;
		//var player_name:String=panel.signup_ui.player_name.text;
		DebugTrace.msg("LoingPal.doSubmitSignup mail="+mail+" , pwd="+pwd);
		var success:Boolean=false;
		var msg:String="";
		if(mail!="" && pwd!="")
		{
			success=true
		}

		var text_code:String=panel.input_code.text;
		var spaces:RegExp = / /gi;
		var input_code:String=text_code.replace(spaces,"");

		if(input_code!=code){
			success=false;

		}

		if(!success)
		{

			if(input_code!=code){
				msg=" Please input correct code !!";
			}else{
				msg=" Please input correct email and password !!";
			}
			MainCommand.addAlertMsg(msg);

		}
		else
		{

			if(DataContainer.validateEmail(mail))
			{

				success=true;
			}
			else
			{
				success=false;
				msg=" Please input correct email format!!";
				MainCommand.addAlertMsg(msg);
			}


		}
		if(success){
			timer.stop();
			flox.signupAccount(mail,pwd);
		}

		timer.reset();
		initCode();

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

	private function doResetPassword(e:MouseEvent):void{


		TweenMax.to(resetPanel,0.5,{visible:true,onComplete:onResetPanelFadIn});

		function onResetPanelFadIn():void{
			TweenMax.killChildTweensOf(resetPanel);
		}
	}

	private function createVerifyCode():void{

		timer=new Timer(20000);
		timer.addEventListener(TimerEvent.TIMER, reflashCodeHandler);
		timer.start();



		function reflashCodeHandler(e:TimerEvent):void{
			initCode();
		}

		initCode();
	}
	private function initCode():void{


		var timestamp:Number= new Date().getTime();
		var data:String=String(timestamp+1980092410160);
		var decode:String=SHA256.hashString(data);
		//DebugTrace.msg(decode);
		var index:Number=Math.floor(Math.random()*(decode.length-4));
		code=decode.slice(index,index+4);
		panel.code.text=code;
	}

}
}