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
			speaker_sprite.flatten();
			init();
		}
		private function init():void
		{
			
			scencom.init("MuseumScene",speaker_sprite,10,onCallback);
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
		private function doTopViewDispatch(e:TopViewEvent):void
		{
			DebugTrace.msg("FitnessClubScene.doTopViewDispatch removed:"+e.data.removed);
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
				case "Learn":
					
					
				
					checkLearnPrmit();
					
					
					break
				case "ani_complete":
				 
					
					/*var value_data:Object=new Object();
					value_data.attr="ap,cash,int";
					value_data.values="-"+payAP+","+"-"+payCash+",+"+increaseINT;
					command.displayUpdateValue(this,value_data);*/
					
					var sysCommand:Object=flox.getSyetemData("command");
					var values:Object=sysCommand.Learn.values;
					values.int=increaseINT;
					command.showCommandValues(this,"Learn",values);
					
					init();
					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
			}
			
		}
		private function checkLearnPrmit():void
		{
		
			var sysCommand:Object=flox.getSyetemData("command");
			payAP=sysCommand.Train.values.ap;
			payCash=sysCommand.Train.values.cash;
			var cash:Number=flox.getSaveData("cash");
			var ap:Number=flox.getSaveData("ap");
			var _data:Object=new Object();
			var success:Boolean=false;
			
			DebugTrace.msg("MuseumScene.checkLearnPrmit cash:"+cash+" ; ap:"+ap);
			if(cash>=Math.abs(payCash) && ap>=Math.abs(payAP))
			{
				success=true;
			}
			else
			{
				if(cash<Math.abs(payCash))
				{
					var msg:String="Sorry,you don't have enough chash.";
					
				}
				else
				{
					msg="Sorry,you don't have enough ap.";
				}
				var alert:AlertMessage=new AlertMessage(msg,onClosedAlert);
				addChild(alert)
			}
			//if
			if(success)
			{
				/*var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				gameEvent._name="learning_animation";
				gameEvent.displayHandler();
				
				_data.ap=savegame.ap-payAP;
				_data.cash=savegame.cash-payCash;
				reInt=Number(uint(Math.random()*6)+getInt)
				//DebugTrace.msg("MuseumScene.doTopViewDispatch reInt:"+reInt);
				_data.int=savegame.int+reInt;
				floxcom.updateSavegame(_data);
				
				var gameinfo:Sprite=ViewsContainer.gameinfo;
				gameinfo.dispatchEventWith("UPDATE_INFO");*/
				
				increaseINT=Number(uint(Math.random()*6)+deInt);
				command.doLearn(increaseINT);
				
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