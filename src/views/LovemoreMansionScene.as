package views
{
	
	
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.SaveGame;
	import model.Scenes;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	public class LovemoreMansionScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var floxcom:FloxInterface=new FloxCommand();
		private var skillstore:Sprite;
	 
		public function LovemoreMansionScene()
		{
			/*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
			button=new Button(pointbgTexture);
			addChild(button);
			button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
			ViewsContainer.currentScene=this;
			this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
			speaker_sprite=new Sprite();
			addChild(speaker_sprite);

			init();
		}
		private function init():void
		{
			
			scencom.init("LovemoreMansionScene",speaker_sprite,34,onStartStory);
			scencom.start();

		}
		private function onStartStory():void
		{
			var switch_verifies:Array=scencom.switchGateway("LovemoreMansion");
			if(switch_verifies[0]){
				scencom.disableAll();
				scencom.start();
			}
		}
		private function onSceneTriggered(e:Event):void
		{
			
			button.visible=false;
			command.sceneDispatch(SceneEvent.CLEARED);
			
			
			var tween:Tween=new Tween(this,1);
			tween.onComplete=onClearComplete;
			Starling.juggler.add(tween);
			
			
		}
		private function doTopViewDispatch(e:Event):void
		{
			DebugTrace.msg("LovemoreMansionScene.doTopViewDispatch removed:"+e.data.removed);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			var savegame:SaveGame=FloxCommand.savegame;
			var _data:Object=new Object();
		
			switch(e.data.removed)
			{
				case "Leave":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
				case "CaptainSkills":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();

					skillstore=new SkillStroeCaptain();
					addChild(skillstore);
			 
					break
				case "ani_complete":

					var value_data:Object=new Object();
					value_data.attr="honor";
					value_data.values="+10";
					command.displayUpdateValue(this,value_data);
					init();
					break
				case "story_complete":

					_data.name= "LovemoreMansionScene";
					_data.from="story";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
				
			}
			
		}
		 
		private function onClosedAlert():void
		{
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			 
			init();
			
		}
		private function onClearComplete():void
		{
			Starling.juggler.removeTweens(this);
			var _data:Object=new Object();
			_data.name= "MainScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}
	}
}