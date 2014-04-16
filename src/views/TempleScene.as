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
	
	public class TempleScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand();
		
	   private var payAP:Number;
		public function TempleScene()
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
			
			scencom.init("TempleScene",speaker_sprite,28,onCallback);
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
		private var attr:String;
		private function doTopViewDispatch(e:TopViewEvent):void
		{
			DebugTrace.msg("TempleScene.doTopViewDispatch removed:"+e.data.removed);
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
				case "Meditate":
					attr=e.data.removed;
					checkMeditatePermit();
					break
				case "ani_complete":
				 
					
					/*var value_data:Object=new Object();
					value_data.attr="honor";
					value_data.values="+10";
					command.displayUpdateValue(this,value_data);*/
					init();
					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
			}
			
		}
		private function checkMeditatePermit():void
		{
			var sysCommand:Object=flox.getSyetemData("command");
			payAP=sysCommand[attr].values.ap;
			var cash:Number=flox.getSaveData("cash");
			var ap:Number=flox.getSaveData("ap");
			var image:Number=flox.getSaveData("image");
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
						 
				command.doMeditate();
				
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