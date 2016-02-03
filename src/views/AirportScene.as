package views
{
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
	import starling.display.Sprite;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	
	
	public class AirportScene extends Scenes
	{
		private var speaker_sprite:Sprite=new Sprite();
		private var scencom:SceneInterface=new SceneCommnad();
		private var saveloadlist:Sprite;
		private var command:MainInterface=new MainCommand();
		public function AirportScene()
		{
			
			ViewsContainer.currentScene=this;
			this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
			speaker_sprite=new Sprite();
			addChild(speaker_sprite);
			init();
			
		}
		private function init():void
		{
			
			scencom.init("AirportScene",speaker_sprite,4,onCallback);
			scencom.start();
			scencom.disableAll();
		}
		private function onCallback():void
		{
			
			
			
		}
		private function doTopViewDispatch(e:TopViewEvent):void
		{
			DebugTrace.msg("AirportScene.doTopViewDispatch removed:"+e.data.removed);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			var _data:Object=new Object();
			switch(e.data.removed)
			{
				case "Save":
				case "Load":
					saveloadlist=new SaveandLoadList(e.data.removed);
					saveloadlist.x=Starling.current.stage.stageWidth/2;
					saveloadlist.y=Starling.current.stage.stageHeight/2;
					saveloadlist.alpha=0;
					addChild(saveloadlist);
					tweenCtrl(1,onFadeInComplete);
					
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					break

				case "back":
					tweenCtrl(0,onFadeOutComplete);
					break
				case "loadtoStart":
					removeChild(saveloadlist);

					var gameinfo:Sprite = ViewsContainer.gameinfo;
					gameinfo.dispatchEventWith("DISPLAY");
					gameinfo.dispatchEventWith("UPDATE_INFO");

					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
				case "Leave":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
			}
			//switch
		}
		private function tweenCtrl(value:Number,onTweenComplete:Function=null):void
		{
			
			var tween:Tween=new Tween(saveloadlist,0.5);
			tween.animate("alpha",value);
			tween.onComplete=onTweenComplete;
			Starling.juggler.add(tween);
		}
		private function onFadeInComplete():void
		{
			Starling.juggler.removeTweens(saveloadlist);
		}
		private function onFadeOutComplete():void
		{
			Starling.juggler.removeTweens(saveloadlist);
			removeChild(saveloadlist);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			
			init();
		}
	}
}