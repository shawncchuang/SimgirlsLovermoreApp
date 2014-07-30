package views
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.plugins.Physics2DPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import events.BattleEvent;
	
	import utils.DebugTrace;
	
	public class Star extends Sprite
	{
		public var score:Number=1;
		protected var max:Number=0;
		
		protected var starmc:MovieClip;
		private var speed:Number=1;
		private var startX:Number;
		private var startY:Number;
		private var posX:Number;
		private var posY:Number;
		private var bonusTxt:TextField;
		TweenPlugin.activate([Physics2DPlugin]);
		public var star_target:DisplayObjectContainer;
		public function Star()
		{
			
			
		}
		public function setUP(max:Number):void
		{
			max=max;
			starmc=new BonusStar();
			starmc.name="star";
			starmc.scaleX=.5;
			starmc.scaleY=.5;
			starmc.buttonMode=true;
			starmc.mouseChildren=false;
			var startX:Number=Math.floor(Math.random()*1024);
			var startY:Number=-starmc.height-Math.floor(Math.random()*200);
			starmc.x=startX;
			starmc.y=startY;
			addChild(starmc);
			
			var format:TextFormat=new TextFormat();
			format.color=0xFFFFFF;
			format.font="SimNeogreyMedium";
			format.size=40;
			bonusTxt=new TextField();
			bonusTxt.embedFonts=true
			bonusTxt.name="bonus";
			bonusTxt.width=50;
			bonusTxt.height=50;
			bonusTxt.defaultTextFormat=format;
			bonusTxt.text="+1";
			addChild(bonusTxt);
			bonusTxt.visible=false;
			
		}
		public function doFalling():void
		{
			
			posX=Math.floor(Math.random()*1024);
			posY=Math.floor(Math.random()*500)+768+starmc.height;
			var _duration:Number=Math.floor(Math.random()*5)+1;
			var _delay:Number=Math.floor(Math.random()*5);
			
			var _r:Number=Math.floor(Math.random()*360);
			TweenMax.to(starmc,_duration,{delay:_delay,x:posX,y:posY,rotation:_r,onComplete:onStarFadeout,onCompleteParams:[starmc]});
			
			//var _star:MovieClip=this.getChildByName("star") as MovieClip;
			starmc.addEventListener(MouseEvent.MOUSE_OVER,onGetBonus);
			
		}
		private function onStarFadeout(_star:MovieClip):void
		{
			
			
			//var _star:MovieClip=this.getChildByName("star") as MovieClip;
			TweenMax.killTweensOf(_star);
			removeChild(_star);
			_star.removeEventListener(MouseEvent.MOUSE_OVER,onGetBonus);
			//this.parent.removeChild(bonusTxt);
		}
		private function onGetBonus(e:MouseEvent):void
		{
			//DebugTrace.msg("VictoryBonus.onGetBonus");	
			var bonusEvt:BattleEvent=VictoryBonus.bonusEvt;
			bonusEvt.updateBonus();
			
			var _star:MovieClip=e.target as MovieClip;
			TweenMax.killTweensOf(_star);
			_star.removeEventListener(MouseEvent.MOUSE_OVER,onGetBonus);
			//TweenMax.to(_star,0.5,{alpha:0,onComplete:onStarFadeout,onCompleteParams:[_star]}); 
			TweenMax.to(_star,0.5,{x:70,y:45,onComplete:onStarPhysics,onCompleteParams:[_star]}); 
			
			TweenMax.killTweensOf(bonusTxt);
			bonusTxt.visible=true;
			bonusTxt.x=_star.x-_star.width/2;
			bonusTxt.y=_star.y-_star.height/2;
			var posY:Number=bonusTxt.y-30;
			TweenMax.to(bonusTxt,0.5,{y:posY,onComplete:onBonusFadeout,onCompleteParams:[bonusTxt]});
			
			//TweenLite.killTweensOf(starmc);
			//removeChild(starmc);
			
			
		}
		private function onStarPhysics(_star:MovieClip):void
		{
			
			TweenMax.killTweensOf(_star);
			removeChild(_star);
			
			starPhysics(this,new Point(_star.x,_star.y),20)
			
		}
		public function starPhysics(target:DisplayObjectContainer,pos:Point,maximum:Number):void
		{
			 
			for (var i:int = 0; i <maximum; i++) 
			{
				var starDot:MovieClip=new BonusStar();
				starDot.scaleX=0.3;
				starDot.scaleY=0.3;
				starDot.x = pos.x;
				starDot.y = pos.y;
				starDot.alpha=0.8;
				target.addChild(starDot);
				tweenDot(starDot, getRandom(0, 1));
				//TweenLite.to(starDot,0.5,{x:75,y:50});
			}
			
		}
		private function onBonusFadeout(_bonus:TextField):void
		{
			TweenMax.killTweensOf(_bonus);
			//var _bonus:TextField=this.getChildByName("bonus") as TextField;
			try	
			{
				removeChild(_bonus);
			}
			catch(e:Error)
			{
				
			}
			//try
		}
		
		private function tweenDot(dot:MovieClip, delay:Number):void 
		{
			
			TweenLite.to(dot,0.5, {physics2D:{velocity:getRandom(650, 950), angle:getRandom(-60, 205),friction:0.15},alpha:0, delay:delay, onComplete:onTweenDotFadout, onCompleteParams:[dot, 0]});
			
		}
		private function onTweenDotFadout(starDot:MovieClip,delay:Number):void
		{
			TweenMax.killTweensOf(starDot);
			starDot.parent.removeChild(starDot);
		}
		private function getRandom(min:Number, max:Number):Number 
		{
			return min + (Math.random() * (max - min));
		}
		
	}
}