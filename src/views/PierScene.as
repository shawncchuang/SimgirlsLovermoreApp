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

	public class PierScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scenecom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		private var attr:String="";
		public function PierScene()
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

			scenecom.init("PierScene",speaker_sprite,40,onStartStory);
			scenecom.start();

		}
		private function onStartStory():void
		{
			var switch_verifies:Array=scenecom.switchGateway("PrivateIsland");
			DebugTrace.msg("PrivateIslandScene.onStartStory switch_verifies="+switch_verifies);
			if(switch_verifies[0]){

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
		private function doTopViewDispatch(e:Event):void
		{
			DebugTrace.msg("PierScene.doTopViewDispatch removed:"+e.data.removed);
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
				case "Rest":
					attr="FreeRest";
					command.doRest(true);

					break
				case "Sail":
					attr="Sail";
					command.doRest(false,"Sail");
					break
				case "ani_complete":

					command.showCommandValues(this,attr);
					init();
					break
				case "story_complete":
					onStoryComplete();

					break
			}

		}
		private function onStoryComplete():void {

			var _data:Object = new Object();
			var current_switch:String = flox.getSaveData("current_switch");
			DebugTrace.msg("PrivateIslandScene.onStoryComplete switchID=" + current_switch);

			switch (current_switch) {

				default:

					_data.name= "PierScene";
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