package views
{
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.MainCommand;
	import controller.MainInterface;
	
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
		private var command:MainInterface=new MainCommand();
        private var font:String="SimMyriadPro";
		public function AlertMessage(msg:String,callback:Function=null):void
		{
			onClosed=callback;
			comfirm=new Sprite();
			
			
			alertframe=Assets.getDynamicAtlas("AlertTalking");
			alertframe.loop=false;
			alertframe.stop();
			alertframe.pivotX=alertframe.width/2;
			alertframe.pivotY=alertframe.height/2;
			
			//var texture:Texture=Assets.getTexture("Alerframe");
			//alertframe=new Image(texture);
			alertframe.pivotX=alertframe.width/2;
			alertframe.pivotY=alertframe.height/2;
			
			
			
			var txt:TextField=new TextField(1024,80,msg,font,20,0xFFFFFF);
			txt.hAlign="center";
			txt.x=-512;
			txt.y=290;
			
			/*var btntexture:Texture=Assets.getTexture("XAlt");
			btn=new Button(btntexture);
			btn.name="closebtn";
			btn.x=438;
			btn.y=319;
			btn.addEventListener(Event.TRIGGERED,onTouchAlertFrame);*/
			
			
			comfirm.addChild(alertframe);
			comfirm.addChild(txt);
			command.addedCancelButton(comfirm,onTouchAlertFrame,new Point(438,319));
			//comfirm.addChild(btn);
			comfirm.x= Starling.current.stage.stageWidth/2;
			comfirm.y= Starling.current.stage.stageHeight/2;
			addChild(comfirm);
			comfirm.alpha=0.5;
			var tween:Tween=new Tween(comfirm,0.5,Transitions.EASE_OUT_ELASTIC);
			tween.animate("alpha",1);
			tween.onComplete=onAlertMessageFadeIn;
			Starling.juggler.add(tween);
		}
		private function onAlertMessageFadeIn():void
		{
			//btn.visible=true;
			Starling.juggler.removeTweens(alertframe);
			
		}
		private function onTouchAlertFrame():void
		{
			DebugTrace.msg("AlertMessage.onTouchAlertFrame")
			//var target:Sprite=e.currentTarget as Sprite;
			//var BEGAN:Touch=e.getTouch(target,TouchPhase.BEGAN);
			//removeChild(comfirm);
			removeChild(comfirm);
			 if(onClosed)
			onClosed();
			 
			
		}
	}
}