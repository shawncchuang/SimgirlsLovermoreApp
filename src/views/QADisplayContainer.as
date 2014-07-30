package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.DataContainer;
	
	import events.SceneEvent;
	
	import model.SaveGame;
	
	import utils.DebugTrace;

	public class QADisplayContainer extends MovieClip
	{
		private var qa_label:String="";
		private var onComplete:Function;
		private var qacom:QAComponent;
		private var templete:MovieClip;
		private var floxcom:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
		private var scenecom:SceneInterface=new SceneCommnad();
		private var tempOption:Object={
			"nickname":"nickname",
			"airplane-phonenumber":"Yes&No",
			"battle-s003-1":"Yes&No"
			
		}
		public function QADisplayContainer(label:String,callback:Function=null)
		{
			qa_label=label
			onComplete=callback;
			init();
			
		}
		private function init():void
		{
			
			qacom=new QAComponent();
			qacom.gotoAndStop(tempOption[qa_label]);
			addChild(qacom);
		    templete=qacom.templete;
			switch(qa_label)
			{
				case "nickname":
					templete.submit.addEventListener(MouseEvent.CLICK,doNickNameSubmit);
					break
				case "airplane-phonenumber":
					templete.yesbtn.mouseChildren=false;
					templete.nobtn.mouseChildren=false;
					templete.yesbtn.addEventListener(MouseEvent.CLICK,doSelectedHandle);
					templete.nobtn.addEventListener(MouseEvent.CLICK,doSelectedHandle);
					break
			}
			//switch
			if(qa_label.indexOf("battle")!=-1)
			{
				var battle_code:String=qa_label.split("-")[1]+"-"+qa_label.split("-")[2];
				DataContainer.battleCode=battle_code;
				
				templete.yesbtn.mouseChildren=false;
				templete.nobtn.mouseChildren=false;
				templete.yesbtn.addEventListener(MouseEvent.CLICK,doBattleHandle);
				templete.nobtn.addEventListener(MouseEvent.CLICK,doCancelHandle);
			}
		}
		private function doNickNameSubmit(e:MouseEvent):void
		{
			
			var succuss:Boolean=true;
			if(templete.firstname.text=="" || templete.lastname.text=="")
			{
				var msg:String="Please input your fisrt name or last name";	
				MainCommand.addAlertMsg(msg);
				succuss=false;
			}
			if(succuss)
			{
				
				var _data:Object=new Object();
				_data.first_name=templete.firstname.text;
				_data.last_name=templete.lastname.text;
				//DataContainer.player=_data;
				//floxcommand.save(_data,onSaveComplete);
				floxcom.updateSavegame(_data);
				onComplete();
				
			}
			//if	
		}
		private function doSelectedHandle(e:MouseEvent):void
		{
			//airplane-phonenumber
			var target:String=e.target.name;
			DebugTrace.msg("QADisplayContainer.doSelectedHandle target:"+target);
			if(target=="yesbtn")
			{
				
			}
			else
			{
				
				
			}
			//if
			onComplete();
			
		}
		private function onSaveComplete(savegame:SaveGame):void
		{
			floxcom.refreshEntites();
			onComplete();
		}
		
		private function doBattleHandle(e:MouseEvent):void
		{
			scenecom.initStory();
			scenecom.onStoryFinished();
			
	 
			onComplete();
			DataContainer.BatttleScene="Story";
			
			var _data:Object=new Object();
			_data.name="ChangeFormationScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
		}
		private function doCancelHandle(e:MouseEvent):void
		{
			onComplete();
		 
			scenecom.initStory();
			scenecom.onStoryFinished();
		 
			
		}
	}
}