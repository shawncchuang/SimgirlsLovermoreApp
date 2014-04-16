package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	
	import data.DataContainer;
	import model.SaveGame;
	import utils.DebugTrace;

	public class QADisplayContainer extends MovieClip
	{
		private var qa_label:String="";
		private var onComplete:Function;
		private var templete:MovieClip;
		private var floxcom:FloxInterface=new FloxCommand();
		public function QADisplayContainer(label:String,callback:Function=null)
		{
			qa_label=label
			onComplete=callback;
			init();
			
		}
		private function init():void
		{
			
			var qacom:QAComponent=new QAComponent();
			qacom.gotoAndStop(qa_label);
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
	}
}