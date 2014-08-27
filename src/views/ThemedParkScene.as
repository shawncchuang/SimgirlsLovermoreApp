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
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		private var payAP:Number;
	    private var income:Number;
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
			speaker_sprite.flatten();
			init();
		}
		private function init():void
		{
			
			scencom.init("ThemedParkScene",speaker_sprite,46,onCallback);
			scencom.start();
			scencom.disableAll();
		}
		private function onCallback():void
		{
			
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
				case "Work":
					
					var scene:String=DataContainer.currentScene;
					
					attr=scene.split("Scene").join("Work");
					checkWorkPermit();
			 
					break
				case "ani_complete":
				 
					
					var sysCommand:Object=flox.getSyetemData("command");
					var values:Object=sysCommand[attr].values;
					values.cash=income;
					command.showCommandValues(this,"ThemedParkWork",values);
					init();
					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
			}
			
		}
		private function checkWorkPermit():void
		{
			
			var sysCommand:Object=flox.getSyetemData("command");
			payAP=sysCommand[attr].values.ap;
			var cash:Number=flox.getSaveData("cash");
			var ap:Number=flox.getSaveData("ap");
			var image:Number=flox.getSaveData("image").player;
			var success:Boolean=false;
			
			//DebugTrace.msg("NightClub.checkWorkPermit cash:"+cash+" ; ap:"+ap);
			if(ap>=Math.abs(payAP))
			{
				success=true;
			}
			else
			{
				
				var msg:String="Sorry,you don't have enough ap."; 
				var alert:AlertMessage=new AlertMessage(msg,onClosedAlert);
				addChild(alert)
			}
			//if
			if(success)
			{
				
				var vIncome:Number=Number(uint(Math.random()*4)+3);
				income=image*vIncome;
				command.doWork(income);
				
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