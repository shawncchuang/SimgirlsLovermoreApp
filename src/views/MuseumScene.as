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
	
	public class MuseumScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		
		private var payAP:Number;
		private var payCash:Number;
		//image return 5-10;
		private var deInt:Number=5;
		private var increaseINT:Number;
		public function MuseumScene()
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
			
			scencom.init("MuseumScene",speaker_sprite,10,onStartStory);
			scencom.start();
			 
		}
		private function onStartStory():void
		{
			
			scencom.disableAll();	
			var switch_verifies:Array=scencom.switchGateway("MuseumScene");
			DebugTrace.msg("MuseumScene.onStartStory switch_verifies="+switch_verifies[0]);
			if(switch_verifies[0])
				scencom.start();
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
			DebugTrace.msg("FitnessClubScene.doTopViewDispatch removed:"+e.data.removed);
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
				case "Research":

                    command.doLearn();

					break
				case "ani_complete":


					command.showCommandValues(this,"Research",e.data.rewards);

                      init();
                    //_data.name=DataContainer.currentScene;
                    //command.sceneDispatch(SceneEvent.CHANGED,_data);

					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
				case "story_complete":
					_data.name= "MuseumScene";
					_data.from="story";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
			}
			
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