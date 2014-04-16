package views
{
	import controller.Assets;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	
	public class PhotoMessage extends Sprite
	{
		private var alertframe:Image;
		private var btn:Button;
		private var onRemoved:Function;
		public function PhotoMessage(target:String,callback:Function=null):void
		{
			onRemoved=callback;
			var texture:Texture=Assets.getTexture("photoframe");
			alertframe=new Image(texture);
			alertframe.pivotX=alertframe.width/2;
			alertframe.pivotY=alertframe.height/2;
			alertframe.scaleX=0.2;
			alertframe.scaleY=0.2;
			
			var btntexture:Texture=Assets.getTexture("XAlt");
			btn=new Button(btntexture);
			btn.name="closebtn";
			btn.x=184;
			btn.y=206;
			btn.addEventListener(Event.TRIGGERED,onTouchAlertFrame);
			btn.visible=false;
			addChild(alertframe);
			addChild(btn);
			
			var tween:Tween=new Tween(alertframe,0.5,Transitions.EASE_OUT_ELASTIC);
			tween.animate("scaleX",1);
			tween.animate("scaleY",1);
			tween.onComplete=onAlertMessageFadeIn;
			Starling.juggler.add(tween);
		}
		private function onAlertMessageFadeIn():void
		{
			btn.visible=true;
			Starling.juggler.removeTweens(alertframe);
			
		}
		private function onTouchAlertFrame(e:Event):void
		{
	
			var target:Button=e.currentTarget as Button;
			//DebugTrace.msg("PhotoMessage.onTouchAlertFrame"+target.name)
			//var BEGAN:Touch=e.getTouch(target,TouchPhase.BEGAN);
			removeChild(alertframe);
			removeChild(btn);
			onRemoved();
		}
	}
}