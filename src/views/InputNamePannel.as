package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	
	import data.DataContainer;
	
	import model.SaveGame;
	public class InputNamePannel extends MovieClip
	{
		private var inputnameUI:MovieClip;
		private var floxcommand:FloxInterface=new FloxCommand();
	    private var saveComplete:Function;
		public function InputNamePannel(callback:Function)
		{
			saveComplete=callback;
			inputnameUI=new InputNameUI();
			//inputnameUI.x=290;
			//inputnameUI.y=667;
			inputnameUI.submit.addEventListener(MouseEvent.CLICK,doSubmit);
			
			addChild(inputnameUI);
		}
		private function doSubmit(e:MouseEvent):void
		{
			
			var succuss:Boolean=true;
			if(inputnameUI.firstname.text=="" || inputnameUI.lastname.text=="")
			{
			    var msg:String="Please input your fisrt name or last name";	
				MainCommand.addAlertMsg(msg);
				succuss=false;
			}
			if(succuss)
			{
				var _data:Object=new Object();
				_data.first_name=inputnameUI.firstname.text;
				_data.last_name=inputnameUI.lastname.text;
				DataContainer.player=_data;
				floxcommand.save(_data,onSaveComplete);
				
			}
		//if	
		}
		private function onSaveComplete(savegame:SaveGame):void
		{
			floxcommand.refreshEntites();
			saveComplete();
			var _data:Object=new Object();
			_data.talk_index=0
		}
	}
}