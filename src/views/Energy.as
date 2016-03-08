package views
{
	
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.SoundTransform;
	
	import controller.MainCommand;
	import controller.MainInterface;
	
	import events.MiniGameEvent;
	
	import utils.ViewsContainer;
	
	
	public class Energy extends MovieClip
	{
		private var command:MainInterface=new MainCommand();
		public var game:String="";
		private var target:MovieClip;
		private var eb:MovieClip;
		private var posX:Number=0;
		private var posY:Number=0;
		private var duration:Number;
		
		public function setTarget(ta:MovieClip):void
		{
			target=ta;
			
		}
		public function BenefitItem():void
		{
			game="training";
			eb=new BenefitItmes();
		
			eb.scaleX=.5;
			eb.scaleY=.5;
		
			addChild(eb);
			
			var enemybike:MovieClip=ViewsContainer.EnemyBike;
			posX=(enemybike.x*-1)+target.x;
			posY=(enemybike.y*-1)+target.y;
			
			duration=Number((Math.floor(Math.random()*2)/100).toFixed(2));
			duration+=0.02;
			
			shottingHandle();
			
		}
		public function EnergyBalls():void
		{
			game="tracing";
			eb=new EnergyBall();
			eb.scaleX=.1;
			eb.scaleY=.1;
			addChild(eb);
			
			var enemybike:MovieClip=ViewsContainer.EnemyBike;
			posX=(enemybike.x*-1)+target.x-376+100;
			posY=(enemybike.y*-1)+target.y;
		
			duration=Number((Math.floor(Math.random()*2)/100).toFixed(2));
			duration+=0.02;
			shottingHandle();
			
		}
		private function shottingHandle():void
		{
			
			
			var _super:Number=Math.floor(Math.random()*100);
			var itemsID:Number=Math.floor(Math.random()*3)+2;
			if(game=="tracing")
			{
				var superMax:Number=60;
			}
			else
			{
				superMax=20;
			}
			if(_super<superMax)
			{
			 
				duration=0.02;
				if(game=="training")
				{
					itemsID=1;	
					duration=0.02;
				}
	
				var dist:Number=Math.sqrt(Math.pow(posX-eb.x,2)+Math.pow(posY-eb.y,2));
				var radians:Number = Math.atan2(posY-eb.y,posX-eb.x);
				var degrees:Number=radians/Math.PI*180;
				//var radians:Number=degrees*Math.PI/180;
				//posY=Math.sin(radians)*dist , posX=Math.cos(radians)*dist
				var sin_radians:Number=posY/dist;
				var cos_raians:Number=posX/dist;
				posY=sin_radians*(dist+500);
				posX=cos_raians*(dist+500);
				
			}
			else
			{
				 
				degrees=Math.floor(Math.random()*90)-30;
				radians=degrees*Math.PI/180;
				dist=Math.floor(Math.random()*100)+1500;
				posY=Math.sin(radians)*dist;
				posX=Math.cos(radians)*dist;
			}
			eb.name="item"+itemsID;
			eb.rotation=degrees;
		 
			if(game=="tracing")
			{
				eb.addEventListener(Event.ENTER_FRAME,doCheckTracingGameHit);
			}
			else
			{
				eb.gotoAndStop(itemsID);
				eb.addEventListener(Event.ENTER_FRAME,doCheckTrainingGameHit);
			}
			eb.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedFromStage);
		}
		private function onRemovedFromStage(e:Event):void
		{
			
			eb.removeEventListener(Event.ENTER_FRAME,doCheckTracingGameHit);
			eb.removeEventListener(Event.ENTER_FRAME,doCheckTrainingGameHit);
			 
		}
		private function onEnegyBallFadeOut():void
		{
			
			
			TweenMax.killChildTweensOf(eb);
			removeChild(eb);
		}
		private function doCheckTracingGameHit(e:Event):void
		{
			var vX:Number=(posX-e.target.x)*duration;
			var vY:Number=(posY-e.target.y)*duration;
			e.target.x+=vX;
			e.target.y+=vY;
			e.target.scaleX+=(0.7-e.target.scaleX)*0.5;
			e.target.scaleY+=(0.7-e.target.scaleY)*0.5;
		
			
			//if(eb.hitTestPoint(target.x+160,target.y+80) || eb.hitTestPoint(240,15) || eb.hitTestPoint(285,20) || eb.hitTestPoint(260,60))
			if(eb.hit.hitTestObject(target.hit))
				//if(target.hit.hitTestPoint(-(eb.width/2),-(eb.height/2)))
			{
				e.target.removeEventListener(Event.ENTER_FRAME,doCheckTracingGameHit);
				removeChild(eb);
				
				
				var miniGameEvt:MiniGameEvent=TraceGame.MiniGameEvt;
				miniGameEvt.onHitHandle();
				
				
			}
			if(Math.floor(vX)==0.0 && Math.floor(vX)==0)
			{
				e.target.removeEventListener(Event.ENTER_FRAME,doCheckTracingGameHit);
			 
				removeChild(eb);
				
			}
			
		}
		private function doCheckTrainingGameHit(e:Event):void
		{
			var miniGameEvt:MiniGameEvent=TrainingGame.MiniGameEvt;
			//trace("Item:",eb.name);
			var vX:Number=(posX-e.target.x)*duration;
			var vY:Number=(posY-e.target.y)*duration;
			e.target.x+=vX;
			e.target.y+=vY;
			e.target.scaleX+=(0.6-e.target.scaleX)*0.5;
			e.target.scaleY+=(0.6-e.target.scaleY)*0.5;
			
			if(game=="training")
			e.target.rotation+=20;
			
			
			if(eb.name=="item1" && eb.hit.hitTestObject(target.hit))
			{
				e.target.removeEventListener(Event.ENTER_FRAME,doCheckTrainingGameHit);
				removeChild(eb);
				
				miniGameEvt.onHitHandle();
			}
			if(eb.name!="item1" && eb.hit.hitTestObject(target.hit))
			{
				var st:SoundTransform=new SoundTransform(0.5);
				command.playSound("GotFoods",0,st);
				
				e.target.removeEventListener(Event.ENTER_FRAME,doCheckTrainingGameHit);
				removeChild(eb);
				var id:Number=Number(eb.name.split("item").join(""));
				 
				miniGameEvt.score=id-1;
				miniGameEvt.onGetScore();
			}
			
			if(Math.floor(vX)==0.0 && Math.floor(vX)==0)
			{
				e.target.removeEventListener(Event.ENTER_FRAME,doCheckTrainingGameHit);
				//eb.visible=false;
				
				removeChild(eb);
				
			}
			
			
		}
		public function stopFire():void
		{
			eb.removeEventListener(Event.ENTER_FRAME,doCheckTracingGameHit);
			eb.removeEventListener(Event.ENTER_FRAME,doCheckTrainingGameHit);
		}
	}
}