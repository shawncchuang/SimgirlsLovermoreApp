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
	
	public class RestaurantScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		
	 
		public function RestaurantScene()
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
			
			scencom.init("RestaurantScene",speaker_sprite,62,onStartStory);
			scencom.start();

		}
		private function onStartStory():void
		{
			var switch_verifies:Array=scencom.switchGateway("Restaurant");
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
			DebugTrace.msg("RestaurantScene.doTopViewDispatch removed:"+e.data.removed);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			var _data:Object=new Object();

			switch(e.data.removed)
			{
				case "Leave":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break;
				case "Dine":
						command.doDine();
					break;
				case "story_complete":

						onStoryComplete();

					break
				case "ani_complete":
				 
					
					//var value_data:Object=new Object();
					//value_data.attr="honor";
					//value_data.values="+10";
					//command.displayUpdateValue(this,value_data);
					init();
					break
				
			}
			
		}
		private function onStoryComplete():void{
			var current_switch:String=flox.getSaveData("current_switch");
			var _data:Object=new Object();
			var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;

			switch (current_switch){

				case "s023|off":
					DataContainer.battleType="story_battle_s023";

					_data=new Object();
					_data.name="ChangeFormationScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);

					break;
				case "s9999|off":
					this.removeFromParent(true);

					gameEvent._name = "restart-game";
					gameEvent.displayHandler();
					break;

				default:
					_data.name= "RestaurantScene";
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