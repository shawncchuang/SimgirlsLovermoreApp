package views
{
	import controller.Assets;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	
	public class AlertMessage extends Sprite
	{
		private var comfirm:Sprite=new Sprite();
		private var alertframe:MovieClip;
		private var btn:Button;
		private var onClosed:Function;
		public function AlertMessage(msg:String,callback:Function=null):void
		{
			onClosed=callback;
			comfirm=new Sprite();
			
			
			alertframe=Assets.getDynamicAtlas("SceneMask");
			alertframe.pivotX=alertframe.width/2;
			alertframe.pivotY=alertframe.height/2;
			
			//var texture:Texture=Assets.getTexture("Alerframe");
			//alertframe=new Image(texture);
			alertframe.pivotX=alertframe.width/2;
			alertframe.pivotY=alertframe.height/2;
			
			
			
			var txt:TextField=new TextField(alertframe.width,70,msg,"Eras Demi ITC",20,0x000000);
			txt.hAlign="center";
			txt.x=-alertframe.width/2
			txt.y=-50
			var btntexture:Texture=Assets.getTexture("CheckAlt");
			btn=new Button(btntexture);
			btn.name="closebtn";
			
			btn.y=20;
			btn.addEventListener(Event.TRIGGERED,onTouchAlertFrame);
			
			
			comfirm.addChild(alertframe);
			comfirm.addChild(btn);
			comfirm.addChild(txt);
			comfirm.x= Starling.current.stage.stageWidth/2;
			comfirm.y= Starling.current.stage.stageHeight/2;
			addChild(comfirm);
			comfirm.scaleX=.8;
			comfirm.scaleY=.8;
			var tween:Tween=new Tween(comfirm,0.5,Transitions.EASE_OUT_ELASTIC);
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
			DebugTrace.msg("AlertMessage.onTouchAlertFrame")
			var target:Sprite=e.currentTarget as Sprite;
			//var BEGAN:Touch=e.getTouch(target,TouchPhase.BEGAN);
			//removeChild(comfirm);
			removeFromParent();
			onClosed();
		}
	}
}