package views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	
	import data.DataContainer;
	
	import utils.DebugTrace;

	public class FloxManagerView extends MovieClip
	{
		private var flox:FloxInterface=new FloxCommand();
		private var index:Number=-1;
		private var managerUI:MovieClip;
		private var mail:String;
		private var type:String="Player";
		public function FloxManagerView()
		{
			
			
		}
		public function init():void
		{
			
			
			managerUI=new MUIContainer();
			managerUI.createbtn.addEventListener(MouseEvent.CLICK,doCreateEmailAccount);
			managerUI.preorderbtn.addEventListener(MouseEvent.CLICK,doPreOrderEmailAccount);
			managerUI.typebox.addEventListener(Event.CHANGE,doTypeChanged);
			managerUI.loginbtn.addEventListener(MouseEvent.CLICK,doLoginAccount);
			managerUI.delbtn.addEventListener(MouseEvent.CLICK,doDestoryEntites);
		 
			addChild(managerUI);
			
			
		}
		private function doCreateEmailAccount(e:MouseEvent):void
		{
			
			DebugTrace.msg("FloxManagerView.doCreateEmailAccount mail="+mail);
			createAccount();
		
			
		}
		private  function createAccount():void
		{
			flox.signupWithEmail(mail)
			managerUI.createbtn.label="Saving";
			
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
			managerUI.mailtxt.text=mail;		
			//DebugTrace.msg("FloxManagerView.doCreateEmailAccount emails="+emails);
			if(index<emails.length)
			{
				//createAccount();
			}
			//if
		}
		private function doTypeChanged(e:Event):void
		{
			type=managerUI.typebox.selectedLabel;
			//DebugTrace.msg("FloxManagerView.doTypeChanged type="+managerUI.typebox.selectedLabel);
		}
		private function doLoginAccount(e:MouseEvent):void
		{
			var key:String=managerUI.playerkey.text;
			var email:String=managerUI.playermail.text;
			flox.LoginForDestroyPlayer(key,email);
		}
	
		private function doDestoryEntites(e:MouseEvent):void
		{
			
			var entitiesID:String=managerUI.entitiesID.text;
			flox.destoryEntities(type,entitiesID);
		}
		 
	}
}