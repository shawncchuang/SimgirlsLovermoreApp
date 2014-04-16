package views
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.DataContainer;
	
	import events.SceneEvent;
	
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	import views.DatingScene;
	
	public class FlirtScene extends Sprite
	{
		private var heartView:Sprite;
		public static var UPDATE_MOOD:String="update_mood";
		public static var UPDATE_LOVE:String="update_love";
		public static var flirtscene:Sprite;
		private var flox:FloxInterface=new FloxCommand();
		private var mood:Number=0;
		private var love:Number=0;
		private var bubble:Image;
		private var playtimes:uint=10;
		private var timer:Timer;
		private var cancelbtn:Button;
		private var command:MainInterface=new MainCommand();
		public function FlirtScene()
		{
			
			this.addEventListener(FlirtScene.UPDATE_MOOD,onUpdateMood);
			this.addEventListener(FlirtScene.UPDATE_LOVE,onUpdateLove);
			FlirtScene.flirtscene=this;
			//initCharacter();
			initHearts();
			initCancelHandle();
		}
		private function onUpdateMood(e:Event):void
		{
			var lv:Number=e.data.lv
			var dating:String=DataContainer.currentDating;
			var image:Number=flox.getSaveData("image").player;
			var _image:Number=Math.floor(image/20);
			if(lv==4)
			{
				
				mood--;
				
			}
			else
			{
				mood+=lv;
			}
			mood=_image+mood;
			
		}
		private function onUpdateLove(e:Event):void
		{
			var lv:Number=e.data.lv
			 
			if(lv==4)
			{
				
				love--;
				
			}
			else
			{
				love++;
			}
		 
		}
		private function initCharacter():void
		{
			
			var dating:String=DataContainer.currentDating;
			var character:MovieClip=Assets.getDynamicAtlas(dating);
			character.x=260;
			addChild(character);
		}
		private function initHearts():void
		{
			heartView=new Sprite();
			addChild(heartView);
			
			timer=new Timer(1000,playtimes);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
			timer.start();
			var tween:Tween=new Tween(this,0.5);
			tween.repeatCount=1000;
			tween.onUpdate=doShowHearts;
			//tween.onComplete=onTimeout;
			Starling.juggler.add(tween);
		}
		private function doShowHearts():void
		{
			
			var heart:HeartParticle=new HeartParticle();
			heartView.addChild(heart);
			
			
		}
		private function onTimeOut(e:TimerEvent):void
		{
			
			DebugTrace.msg("FlirtScene.onTimeOut love:"+love);
			clearHeartView();
			initBubble();
			var tween:Tween=new Tween(this,1);
			tween.delay=0.5;
			tween.onComplete=onReadyToUpdatLove;
			Starling.juggler.add(tween);
			
		}
		private function onReadyToUpdatLove():void
		{
			Starling.juggler.removeTweens(this);
			var _data:Object=new Object();
			_data.com="FlirtLove";
			_data.love=love;
			var base_sprite:Sprite=ViewsContainer.baseSprite;
			base_sprite.dispatchEventWith(DatingScene.COMMIT,false,_data);
			
			
		}
		private function initBubble():void
		{
			
			var bubbleTextue:Texture=Assets.getTexture("Bubble");
			bubble=new Image(bubbleTextue);
			bubble.smoothing=TextureSmoothing.TRILINEAR;
			bubble.pivotX=bubble.width/2;
			bubble.pivotY=bubble.height/2;
			bubble.x=768;
			bubble.y=260;
			bubble.scaleX=-1;
			addChild(bubble);
			var chat:String="Bye.";
			var chatTxt:TextField=new TextField(255,190,chat,"Futura",20,0x000000)
			chatTxt.hAlign="center";
			chatTxt.x=634;
			chatTxt.y=110;
			addChild(chatTxt);
			
		}
		private function initCancelHandle():void
		{
			//cancel button
			
			command.addedCancelButton(this,doCancelAssetesForm);
 
			
		}
		private function doCancelAssetesForm():void
		{
			clearHeartView();
			
			var _data:Object=new Object();
			_data.name=DataContainer.currentLabel;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
			
		}
		private function clearHeartView():void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeOut);
			Starling.juggler.removeTweens(this);
			heartView.removeFromParent(true);
			
		}
	}
}