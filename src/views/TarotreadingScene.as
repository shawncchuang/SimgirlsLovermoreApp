package views
{
	
	//import com.emibap.textureAtlas.DynamicAtlas;
	
	 
	import controller.SceneCommnad;
	import controller.SceneInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	 
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.Scenes;
	
	import starling.display.Sprite;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	public class TarotreadingScene extends Scenes
	{
		
		/*private var myTalkIndex:uint=0;
		private var talkmask:MyTalkingDisplay;
		private var talkfield:MyTalkingDisplay;
		private var button:Button;
		private var view:MovieClip;
		private var talking:Array;
		private var lookaround_mc:MovieClip;
		private var lookaroundTween:Tween;
		private var sirena:Image;
		private var sao:Image;
		private var talk_index:uint=0;
		private var part_index:uint=0;
		private var bubble:CharacterBubble=null;
		private var bubble_tween:Tween;
		private var inputMask:MyTalkingDisplay;
		private var clickmouse:ClickMouseIcon;
		private var sky:Image=null;
		private var photoframe:PhotoMessage;
		private var visiblebtn:Button;*/
		
		
		
		private var speaker_sprite:Sprite=new Sprite();
		private var command:MainInterface=new MainCommand(); 
		private var chater:SceneInterface=new SceneCommnad();
		
		public function TarotreadingScene()
		{
 
			ViewsContainer.currentScene=this;
			this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
			
		 
			
			speaker_sprite=new Sprite();
			addChild(speaker_sprite);
		 
			chater.init("TarotReading",speaker_sprite,0,onChatFinished);
			chater.start();
			
		}
		/*private function onPlayerSpeakFinished():void
		{
	 
			command.addDisplayObj("TarotReading","ComCloud");
			chater.init("TarotReading",speaker_sprite,0,onChatFinished);
			
			
		}*/
		private function onChatFinished():void
		{
			
			var _data:Object=new Object();
			//_data.name="CharacterDesignScene";
			_data.name= "MainScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);

			command.addShortcuts();
		}
		 
		 
		 
		private function doTopViewDispatch(e:TopViewEvent):void
		{
			DebugTrace.msg("TarotreadingScene.doTopViewDispatch removed:"+e.data.removed);
			 switch(e.data.removed)
			 {
				case "LookAround":
					chater.enableTouch();
					break;
				case "QA":
					chater.enableTouch();
					break;
				case "tarot_cards":
					var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
					gameEvent._name="remove_tarot_card";
					gameEvent.displayHandler();
					chater.enableTouch();
					break
				 
			 }
		 
		}
		
	  
	}
}