package views
{
	
	
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;

import data.DataContainer;

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
	
	public class AcademyScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		
		private var store:Sprite;
		public function AcademyScene()
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

			scencom.init("AcademyScene",speaker_sprite,26,onStartStory);
			scencom.start();

		}
		private function onStartStory():void
		{
			var switch_verifies:Array=scencom.switchGateway("Academy");
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
			DebugTrace.msg("AcademyScene.doTopViewDispatch removed:"+e.data.removed);
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
                case "Practice":

                    DataContainer.battleType="practice";

                    gameEvent._name="clear_comcloud";
                    gameEvent.displayHandler();
                    _data.name="ChangeFormationScene";
                    command.sceneDispatch(SceneEvent.CHANGED,_data);

                    break
				case "LearnSkills":

					command.initStyleSchedule(onInitStyleComplete);
						function onInitStyleComplete():void{
							store=new SkillsStore();
							addChild(store);
						}

					
					break
				case "BattleTutorial":
					command.PlayBattleTutorial();

					break
				case "ani_complete":
					
//					var value_data:Object=new Object();
//					value_data.attr="honor";
//					value_data.values="+10";
//					command.displayUpdateValue(this,value_data);
					init();
					break
				case "story_complete":

						onStoryComplete();

					break
				
			}
			
		}
		private function onStoryComplete():void{
			var _data:Object=new Object();
			var current_switch:String=flox.getSaveData("current_switch");
			DebugTrace.msg("HotelScene.onStoryComplete switchID="+current_switch);
			var switchs:Object=flox.getSyetemData("switchs");
			var switchID:String=current_switch.split("|")[0];
			var nextSwitch:String=switchs[switchID].result.on;

			switch (current_switch){

				default:
					_data.name= "AcademyScene";
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