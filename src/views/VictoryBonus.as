package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.plugins.MotionBlurPlugin;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextFormat;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.MembersInterface;
	import controller.MemebersCommand;
	
	import data.DataContainer;
	
	import events.BattleEvent;
	import events.GameEvent;
	import events.SceneEvent;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;

	TweenPlugin.activate([MotionBlurPlugin, TransformAroundPointPlugin, TransformAroundCenterPlugin, ShortRotationPlugin]);
	public class VictoryBonus extends MovieClip
	{
		private var memberscom:MembersInterface=new MemebersCommand();
		private var flox:FloxInterface=new FloxCommand();
		private var bonusMax:Number=0;
		private var bonus:Bonus;
		private var num:Number=0;
		private var bonustitle:MovieClip;
		private var score:Number=0;
		public static var bonusEvt:BattleEvent;
		private var bunosAlert:MovieClip;
		public function VictoryBonus()
		{
			init();
			
		}
		private function init():void
		{
			
			var cpu_team:Object=flox.getSaveData("cpu_teams");
			var cpuID:Number=DataContainer.setCputID
			for(var i:uint=0;i<8;i++)
			{
				var seMax:Number=cpu_team["t"+cpuID+"_"+i].seMax;
				bonusMax+=seMax;
			}
			//for	
			bonusMax=50;
			DebugTrace.msg("VictoryBonus.init bonusMax="+bonusMax);
			var battlescene:Sprite=ViewsContainer.battlescene;
			var satageID:Number=DataContainer.stageID;
			var batllestage:MovieClip=new BattleStage();
			batllestage.gotoAndStop(satageID);
			batllestage.y=-786+150;
			addChild(batllestage);
			
			bonus=new Bonus();
			addChild(bonus);
			 
			bonustitle=new BonusTitle();
			bonustitle.honour.text="+0";
			addChild(bonustitle);
			
			var evt:BattleEvent=new BattleEvent();
			evt.addEventListener(BattleEvent.UPADATE_BONUS,updateBonus);
			bonusEvt=evt;
			callNewStar();
			
			 
		}
		private function updateBonus(e:Event):void
		{
			
			DebugTrace.msg("VictoryBonus.updateBonus score="+score);
			score++;
			bonustitle.honour.text="+"+score;
			
			
			
			TweenMax.to(bonustitle, 0.5, {transformAroundCenter:{scaleX:1.2,scaleY:1.2},
			glowFilter:{color:0xFFFFFF, alpha:1, blurX:30, blurY:30},onComplete:onTitleShowup,ease:Elastic.easeOut});
		 
			
		}
		private function onTitleShowup():void
		{
			TweenMax.killChildTweensOf(bonustitle);
			
			TweenMax.to(bonustitle, 0.2, {transformAroundCenter:{scaleX:1,scaleY:1},
				glowFilter:{color:0xFFFFFF, alpha:0, blurX:0, blurY:0},onComplete:onShowupComplete});
			function onShowupComplete():void
			{
				TweenMax.killChildTweensOf(bonustitle);
			}
		}
		private function callNewStar():void
		{
			TweenMax.delayedCall(0.2,createNewStar);
		}
		private function createNewStar():void
		{
			//DebugTrace.msg("VictoryBonus.createNewStar");	
			TweenMax.killDelayedCallsTo(createNewStar);
			bonus.setUP(bonusMax);
			bonus.doFalling();
			num++;
			if(num<bonusMax)
			{
				//DebugTrace.msg("VictoryBonus.createNewStar num="+num);	
				callNewStar();
			}
			else
			{
				DebugTrace.msg("VictoryBonus.createNewStar Stop Bonus");
				var honors:Object=flox.getSaveData("honor");
				var player_power:Array=DataContainer.PlayerPower;
				var per_honor:Number=Math.floor(score/player_power.length);
				for(var i:uint=0;i<player_power.length;i++)
				{
					DebugTrace.msg("VictoryBonus.createNewStar power="+JSON.stringify(player_power[i]));
					var _name:String=player_power[i].name;
					honors[_name]+=per_honor;
					
				}
				//for
				
				flox.save("honor",honors);
	        
				
				bunosAlert=new BonusAlert();
				bunosAlert.honor.text="+"+score;
				addChild(bunosAlert);
				TweenMax.delayedCall(3,onBonusFadeout)
			}
			//if
			
		}
		private function onBonusFadeout():void
		{
			TweenMax.killDelayedCallsTo(onBonusFadeout);
			var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvt._name="remove_battle";
			gameEvt.displayHandler();
			
			var command:MainInterface=new MainCommand();	
			var _data:Object=new Object();
			_data.name= "SSCCArenaScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
		}
		private function onStarFadeout(bonus:Bonus):void
		{
			TweenMax.killTweensOf(bonus);
			removeChild(bonus);
			
		}
	}
}