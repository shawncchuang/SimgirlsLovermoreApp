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
	
	 
	import model.Scenes;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	import data.DataContainer;
	
	public class NightClubScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scenceom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		private var payAP:Number;
		private var income:Number;
		public function NightClubScene()
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

			scenceom.init("NightClubScene",speaker_sprite,14,onStartStory);
			scenceom.start();

		}
		private function onStartStory():void
		{

			var switch_verifies:Array=scenceom.switchGateway("NightclubScene");
			if(switch_verifies[0]){
				scenceom.disableAll();
				scenceom.start();
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
		private var attr:String;
		private function doTopViewDispatch(e:Event):void
		{
			DebugTrace.msg("NightclubScene.doTopViewDispatch removed:"+e.data.removed);
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

					command.showCommandValues(this,attr,e.data.rewards);
					init();
					command.addShortcuts();
					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
				case "story_complete":
					onStoryComplete();
					break
			}
			
		}
		private function onStoryComplete():void
		{
			DebugTrace.msg("HotelScene.onStoryComplete");

			var _data:Object=new Object();
			_data.name= "NightclubScene";
			_data.from="story";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
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