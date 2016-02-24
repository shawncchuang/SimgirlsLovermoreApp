package views
{
import data.Config;

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
		private var flox:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
		private var scenecom:SceneInterface=new SceneCommnad();
		private var tempOption:Object={
			"nickname":"nickname",
			"airplane-phonenumber":"phonenumber",
			"battle-s003-1":"Yes&No",
			"qa-s006b":"s006b",
			"qa-s008":"s008",
			"qa-s010":"s010",
			"qa-s025":"s025",
			"qa-s034-1":"s034-1",
			"qa-s034-2":"s034-2",
			"qa-s050":"s050",
			"qa-s1427-1-1":"s1427-1-1",
			"qa-s1427-1-2":"s1427-1-2"
		}
		public function QADisplayContainer(label:String,callback:Function=null)
		{
			qa_label=label;
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
					break;
				default:
//				case "airplane-phonenumber":
//				case "qa-s006b":
//				case "qa-s008":
//				case "qa-s010":
//				case "qa-s025":
						for(var i:uint=0;i<2;i++){
							var target:MovieClip=templete["btn"+(i+1)];
							target.buttonMode=true;
							target.mouseChildren=false;
							target.addEventListener(MouseEvent.CLICK,doSelectedHandle);
						}

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
				var msg:String="Please input your first name and last name";
				MainCommand.addAlertMsg(msg);
				succuss=false;
			}
			if(succuss)
			{
				
				var _data:Object=new Object();
				_data.first_name=templete.firstname.text;
				_data.last_name=templete.lastname.text;
				DataContainer.PlayerFullName=_data;
				flox.save("first_name",_data.first_name);
				flox.save("last_name",_data.last_name);
				//floxcom.updateSavegame(_data);

				if(onComplete)
				onComplete();
				
			}
			//if	
		}
		private function doSelectedHandle(e:MouseEvent):void
		{
			//QA-options style
			var option:Number=Number(e.target.name.split("btn").join(""));
			DebugTrace.msg("QADisplayContainer.doSelectedHandle option:"+option);
			if(option==1)
			{
				
			}
			else
			{
				//option==2
				
				
			}
			//if
			var goodevails:Object=Config.goodevails;
			if(goodevails[qa_label]){

				var goodevail:Number=goodevails[qa_label][option-1];
				var current_goodevail:Number=flox.getSaveData("goodevail");
				if(!current_goodevail){
					current_goodevail=0;
				}
				current_goodevail+=goodevail;
				flox.save("goodevail",current_goodevail);
			}
			onComplete();
			
		}

		
		private function doBattleHandle(e:MouseEvent):void
		{
			//scenecom.initStory();
			//scenecom.onStoryFinished();
			
	 
			onComplete();
			DataContainer.BatttleScene="Story";
			DataContainer.battleType="story_battle";
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