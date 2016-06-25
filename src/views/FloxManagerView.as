package views
{
import com.gamua.flox.utils.SHA256;
import com.greensock.TweenMax;

import data.Config;

import fl.controls.ComboBox;

import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.DataContainer;
	
	import utils.DebugTrace;
	
	public class FloxManagerView extends MovieClip
	{
		private var flox:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
		private var index:Number=-1;
		private var managerUI:MovieClip;
		private var mail:String;
		private var type:String="Player";
		private var key:String="";
		private var msg:String="";
		private var fadeIn:Boolean=false;
		private var accType:*="pre_order";
		private var ownerId:String="";
		public function FloxManagerView()
		{
			key=FloxCommand.heroKey;
			flox.LoginForDestroyPlayer(key,"");
			
		}
		public function init():void
		{
			
			
			managerUI=new MUIContainer();
			managerUI.createbtn.addEventListener(MouseEvent.CLICK,doCreateEmailAccount);
			managerUI.preorderbtn.addEventListener(MouseEvent.CLICK,doPreOrderEmailAccount);
			managerUI.typebox.addEventListener(Event.CHANGE,doTypeChanged);
			managerUI.loginbtn.addEventListener(MouseEvent.CLICK,doLoginAccount);
			managerUI.sysbtn.addEventListener(MouseEvent.CLICK,doSaveSystemData);
			managerUI.delbtn.addEventListener(MouseEvent.CLICK,doDestoryEntites);
			managerUI.scenelbr.addEventListener(MouseEvent.CLICK,doSaveSceneLibraryEntites);
			managerUI.schedulelbr.addEventListener(MouseEvent.CLICK,doSaveScheduleEntites);
			managerUI.mainstory.addEventListener(MouseEvent.CLICK,doSaveMainStoryEntites);
			managerUI.updateitems.addEventListener(MouseEvent.CLICK,doUpdatePlayerItems);

			managerUI.initbonus.addEventListener(MouseEvent.CLICK,initBonusList);
			managerUI.updateplayer.addEventListener(MouseEvent.CLICK,doUpdatePlayer);
			managerUI.accounttype.addEventListener(Event.CHANGE,onAccountTypeChanged);

			managerUI.indicesplayer.addEventListener(MouseEvent.CLICK,doIndicesPlayer);
			managerUI.resultMC.closebtn.addEventListener(MouseEvent.CLICK,doFadeoutResultArea);
			managerUI.resultMC.closebtn.buttonMode=true;
			managerUI.resultMC.trashcan.addEventListener(MouseEvent.CLICK,doClearResultArea);
			managerUI.resultMC.trashcan.buttonMode=true;
			managerUI.resultMC.x=955;
			addChild(managerUI);
			
			
		}
		private function doCreateEmailAccount(e:MouseEvent):void
		{
			index=-1;

			var mailStr:String=managerUI.mailtxt.text;
			var maillist:Array=new Array();
			if(mailStr.indexOf(",")!=-1){
				maillist=mailStr.split(",");
			}else{
				maillist.push(mailStr);
			}
			//DebugTrace.msg("FloxManagerView.doCreateEmailAccount maillist="+maillist);
			DataContainer.MembersMail=maillist;
			currentAccount();
			
			
		}
		private  function createAccount():void
		{
			flox.signupWithEmail(mail);
			managerUI.createbtn.label="Saving";
			
		}
		private function onSignupComplete():void
		{
			
		}
		private function doPreOrderEmailAccount(e:MouseEvent):void
		{
			MainCommand.initPreOrderAccount();
			
		}
		public function currentAccount():void
		{
			managerUI.preorderbtn.label="Complete";
			managerUI.createbtn.label="Create";
			index++;
			var emails:Array=DataContainer.MembersMail;
			mail=emails[index];
			
			
			if(index<emails.length && mail) 
			{
				managerUI.mailtxt.text="List["+index+"]/"+emails.length+":"+mail+" created Account";		
				DebugTrace.msg("FloxManagerView.currentAccount mail="+mail);
				showResult("FloxManagerView.currentAccount mail="+mail);
				createAccount();
			}
		}
		private function doTypeChanged(e:Event):void
		{
			type=managerUI.typebox.selectedLabel;
			//DebugTrace.msg("FloxManagerView.doTypeChanged type="+managerUI.typebox.selectedLabel);
		}
		private function doLoginAccount(e:MouseEvent):void
		{
			if(managerUI.playerkey.text!="")
			key=managerUI.playerkey.text;
			//var email:String=managerUI.playermail.text;
			flox.LoginForDestroyPlayer(key,"");
		}
		private function doSaveSystemData(e:MouseEvent):void
		{
			//flox.saveSystemDataEntities();
			
		}
		private function doDestoryEntites(e:MouseEvent):void
		{
			
			var entitiesID:String=managerUI.entitiesID.text;
			flox.destoryEntities(type,entitiesID);
		}
		private function doSaveSceneLibraryEntites(e:MouseEvent):void
		{
			command.initSceneLibrary();
			
		}
		private function doSaveScheduleEntites(e:MouseEvent):void
		{
			command.initSchedule();
		}
		private function doSaveMainStoryEntites(e:MouseEvent):void
		{
			command.initMainStory();
		}
		private function doUpdatePlayerItems(e:MouseEvent):void
		{
			//var cons:String="from == ?"
			var cons:String=managerUI.con.text+" == ?";
			var key:String=managerUI.key.text;
			var items:Array=[  { "id": "com1", "qty": 3 },{ "id": "com2", "qty": 9999 }, { "id": "com3", "qty": 9999 } ];
			flox.updatePlayer(cons,key,items);

		}

		private var listIndex:Number=0;
		public function initBonusList(e:MouseEvent):void{
			//add coin;
			listIndex=0;
			command.initBonusList();
		}
		public function setupBonusList():void{

			DebugTrace.msg("FloxManagerView.setupBonusList");
			var bonuslist:Array=DataContainer.MembersMail;

			if(listIndex<bonuslist.length){

				flox.queryPlayerByEmail(bonuslist[listIndex],setupPlayerBonus);
			}

		}
		private function setupPlayerBonus():void{

			listIndex++;
			setupBonusList();
		}

		private function doUpdatePlayer(e:MouseEvent):void{
			var USD:Number=Number(managerUI.new_value.text);
			if(USD!=0){
				DataContainer.EDITED_VALUE=USD;
				flox.playerEditor(ownerId);
			}
			showResult("FloxManagerView.doUpdatePlayer USD="+USD+", ownerId="+ownerId);
		}
		private function onAccountTypeChanged(e:Event):void{
			var cb:ComboBox = e.currentTarget as ComboBox;
			var value:Number=Number(cb.value);
			if(value==0){
				accType="pre_order";
			}else{
				accType=null;
			}
		}

		private function doIndicesPlayer(e:MouseEvent):void{
			var email:String=managerUI.email.text;
			var spaces:RegExp = / /gi;
			email=email.replace(spaces,"");

			var cons:String="hashkey == ?";
			var permision:String=Config.permision;
			key=SHA256.hashString(String(email+permision));
			flox.indicesPlayer(cons,key,onQueryUserIndices,onIndicesError);
		}
		private function onQueryUserIndices(players:Array):void
		{


			if(players.length>0){
				if(players.length>1){

					for(var i:uint=0;i<players.length;i++){
						if(players[i].from==accType){
							var playerData:String=JSON.stringify(players[i]);
							ownerId=players[i].ownerId;
							break
						}
					}
				}else{
					playerData=JSON.stringify(players);
					ownerId=players[0].ownerId;
				}
			}

			DebugTrace.msg("FloxManagerView.onQueryUserIndices players="+playerData);
			showResult("FloxManagerView.onQueryUserIndices players="+playerData);


		}
		private function onIndicesError(error:String):void
		{
			DebugTrace.msg("FloxManagerView.onIndicesError error="+error);
			showResult("FloxManagerView.onIndicesError error="+error);
		}

		private function showResult(result:String):void{
			managerUI.resultMC.visible=true;
			msg+="\n"+result;
			managerUI.resultMC.textarea.text=msg
		}
		private function doFadeoutResultArea(e:MouseEvent):void{

			fadeIn=!fadeIn;
			if(fadeIn){
				var posX:Number=0;
				managerUI.resultMC.closebtn.gotoAndStop(2);
			}else{
				posX=955;
				managerUI.resultMC.closebtn.gotoAndStop(1);
			}

			TweenMax.to(managerUI.resultMC,0.5,{x:posX,onComplete:onTweenComplete});
			function onTweenComplete():void{
				TweenMax.killAll();
			}
		}
		private function doClearResultArea(e:MouseEvent):void{
			msg="";
			managerUI.resultMC.textarea.text=msg;
		}
	}
}