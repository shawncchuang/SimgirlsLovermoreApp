package views
{
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.FilterInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.ParticleInterface;
	
	import model.SaveGame;

import starling.animation.DelayedCall;

import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	import utils.FilterManager;
	import utils.ParticleSystem;
	
	public class HeartParticle extends Sprite
	{
	 
		private var heart:Sprite;
	    private var heartImg:Image;
		private var calcelTween:Tween;
		private var target_hover:String;
		private var _target:Sprite;
		private var loveTxt:TextField;
		private var loveSprite:Sprite;
		private var delaycall:DelayedCall;
		public function HeartParticle()
		{
			var lv:uint=uint(Math.random()*4)+1;
			heart=new Sprite();
			heart.name="heart_lv"+lv;
			heart.x=Starling.current.stage.stageWidth/2;
			heart.y=Starling.current.stage.stageHeight/2+Starling.current.stage.stageHeight/2+200;
			
			var heartTexture:Texture=Assets.getTexture("HeartLv"+lv);
			heartImg=new Image(heartTexture);
			heartImg.pivotX=heartImg.width/2;
			heartImg.pivotY=heartImg.height/2;
			var scale:Number=1+(0.5*(lv-1));
			if(lv>4)
			{
			heartImg.scaleX=scale;
			heartImg.scaleY=scale;
			}
			heart.addChild(heartImg);
			
			var rotation:Number=Math.floor(Math.random()*180);
			heart.rotation=rotation;
			
			addChild(heart);
			
			
			var tween:Tween=new Tween(heart,1,Transitions.EASE_IN_OUT);
			var sw:Number=Starling.current.stage.stageWidth;
			var sh:Number=Starling.current.stage.stageHeight;
			
			var posX:Number=sw-Math.floor(Math.random()*sw*2);
			var posY:Number=sh-Math.floor(Math.random()*sh*2);
			//DebugTrace.msg("HeartParticle posX:"+posX+" ; posY:"+posY);
			tween.animate("x",posX);
			tween.animate("y",posY);
			tween.onComplete=onHeartStaied;
			Starling.juggler.add(tween);
			heart.addEventListener(TouchEvent.TOUCH,doTouchedHeart);
		}
		private function onHeartStaied():void
		{
			Starling.juggler.removeTweens(heart);

//			var filter:FilterInterface=new FilterManager();
//			filter.setSource(heartImg);
//			filter.changeColor(0x999999);

//			calcelTween=new Tween(heart,1.5);
//			calcelTween.onComplete=onHeartCanceled;
//			Starling.juggler.add(calcelTween);

			delaycall=new DelayedCall(onHeartCanceled,0.5);
			Starling.juggler.add(delaycall);
			
		}
	 
		private function onReadyCanceled():void
		{
		    
//			var filter:FilterInterface=new FilterManager();
//			filter.setSource(heartImg);
//			filter.changeColor(0x999999);

//			calcelTween=new Tween(heart,0.2);
//			calcelTween.animate("alpha",0);
//			calcelTween.onComplete=onHeartCanceled;
//			Starling.juggler.add(calcelTween);
			
		}
		private function onHeartCanceled():void
		{
			Starling.juggler.remove(delaycall);
			//Starling.juggler.removeTweens(heart);
			heart.removeEventListener(TouchEvent.TOUCH,doTouchedHeart);
			heart.removeFromParent(true);
		}
		private function doTouchedHeart(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			 
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			if(hover)
			{
				_target=target;
				target_hover=target.name;
				//DebugTrace.msg("HeartParticle.doTouchedHeart target:"+target.name);
				var point:Point=new Point(heart.x,heart.y);
				var ps:ParticleInterface=new ParticleSystem();
				var heart_src:String="flirt_heart";
				if(target.name.indexOf("lv4")!=-1)
				{
					heart_src="heart_break"
				}
				ps.init(this,heart_src,point);
				ps.showParticles();
				addLovePoint();
				onHeartCanceled();
				
			}
			//if
		}
		private function addLovePoint():void
		{
			
			var hoverlv:String=target_hover.split("_")[1];
			var lv:Number=Number(hoverlv.split("lv").join(""));
			
			var loveStr:String="Love +"+(lv*10*2);
			if(lv==4)
			{
                loveStr="Love -10";
			 
			}
            loveSprite=new Sprite();
			loveTxt=new TextField(200,40,loveStr);
			loveTxt.format.setTo("SimNeogreyMedium",30,0xFAF182);
			loveTxt.pivotX=loveTxt.width/2;
			loveTxt.pivotY=loveTxt.height/2;
			//loveTxt.x=_target.x;
			//loveTxt.y=_target.y;
            loveSprite.addChild(loveTxt);
            loveSprite.x=_target.x;
            loveSprite.y=_target.y;
            addChild(loveSprite);

            var filter:FilterManager=new FilterManager();
            filter.setShadow(loveSprite);

			var tween:Tween=new Tween(loveSprite,1);
			tween.animate("scaleX",1.2);
			tween.animate("scaleY",1.2);
			tween.animate("y",_target.y-50);
			tween.onComplete=onCanceledLovePoint;

			Starling.juggler.add(tween);
			
			var _data:Object=new Object();
			_data.lv=lv;
			var flirtscene:Sprite=KissScene.kissScene;
			flirtscene.dispatchEventWith(KissScene.UPDATE_LOVE,false,_data);
		}
		private function onCanceledLovePoint():void
		{
			Starling.juggler.removeTweens(loveSprite);
            loveSprite.removeFromParent(true);
			
		}
	}
}