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
	
	public class ThemedParkScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scenecom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		private var payAP:Number;
	   // private var income:Number;
		public function ThemedParkScene()
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

			scenecom.init("ThemedParkScene",speaker_sprite,46,onStartStory);
			scenecom.start();

		}
		private function onStartStory():void
		{
			var switch_verifies:Array=scenecom.switchGateway("ThemedParkScene");
			DebugTrace.msg("ThemedParkScene.onStartStory switch_verifies="+switch_verifies);
			if(switch_verifies[0]) {

				scenecom.disableAll();
				scenecom.start();
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
		private var attr:String
		private function doTopViewDispatch(e:Event):void
		{
			DebugTrace.msg("ThemedParkScene.doTopViewDispatch removed:"+e.data.removed);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			var _data:Object=new Object();
		
			switch(e.data.removed)
			{
				case "Leave":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
				case "Work":
					

                    command.doWork();
					break
				case "ani_complete":

					command.showCommandValues(this,"ThemedParkWork",e.data.rewards);
					init();
					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
				case "story_complete":
					onStoryComplete();
					break
			}
			
		}

		private function onStoryComplete():void {

			var _data:Object = new Object();
			var current_switch:String = flox.getSaveData("current_switch");
			DebugTrace.msg("ThemedParkWork.onStoryComplete switchID=" + current_switch);

			switch (current_switch) {
				case "s9999|off":
					this.removeFromParent(true);
					var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
					gameEvent._name = "restart-game";
					gameEvent.displayHandler();
					break;
				default:
					_data.name= "ThemedParkScene";
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