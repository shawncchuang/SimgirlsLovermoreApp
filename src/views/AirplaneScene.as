package views
{
	 
	
	 
	import controller.SceneCommnad;
	import controller.SceneInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	 
	 
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.Scenes;
	
	 
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	 
	import utils.DebugTrace;
	import utils.ViewsContainer;
	 
	public class AirplaneScene extends Scenes
	{
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var speaker_sprite:Sprite=new Sprite();
		//private var speaker:SpeakerInterface=new SpeakerCommand();
		private var chater:SceneInterface=new SceneCommnad();
		private var part_index:Number;
		public function AirplaneScene()
		{
			/*var pointbgTexture:Texture=Assets.getTexture("CheckAlt");
			button=new Button(pointbgTexture);
			addChild(button);
			button.addEventListener(Event.TRIGGERED, onSceneTriggered);	*/
			
			ViewsContainer.currentScene=this;
			this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
			
			init();
		}
		private function init():void
		{
			 	
			speaker_sprite=new Sprite();
			addChild(speaker_sprite);
		 
			chater.init("AirplaneScene",speaker_sprite,2,onChatFinished);
			chater.start();
		 
		}
		 
		 
		private function onSceneTriggered(e:Event):void
		{
			
			 
			 
		}
		 
		private function onChatFinished():void
		{
			 
			var _data:Object=new Object();
			_data.name= "MainScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}
		private function doTopViewDispatch(e:TopViewEvent):void
		{
			DebugTrace.msg("AirplaneScene.doTopViewDispatch removed:"+e.data.removed);
			switch(e.data.removed)
			{
				case "QA":
					chater.enableTouch();
					break
			}
			//switch
		}
	}
}