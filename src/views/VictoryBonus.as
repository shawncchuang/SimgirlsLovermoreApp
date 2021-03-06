package views
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SWFLoader;
	import com.greensock.plugins.MotionBlurPlugin;
	import com.greensock.plugins.ShortRotationPlugin;
	import com.greensock.plugins.TransformAroundCenterPlugin;
	import com.greensock.plugins.TransformAroundPointPlugin;
	import com.greensock.plugins.TweenPlugin;

import data.Config;

import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
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
	
	import model.BattleData;
	
	import services.LoaderRequest;

import starling.display.Sprite;


import utils.DebugTrace;
	import utils.ViewsContainer;
	
	TweenPlugin.activate([MotionBlurPlugin, TransformAroundPointPlugin, TransformAroundCenterPlugin, ShortRotationPlugin]);
	public class VictoryBonus extends MovieClip
	{
		private var memberscom:MembersInterface=new MemebersCommand();
		private var flox:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
		private var bonusMax:Number=0;
		private var bonus:Bonus;
		private var num:Number=0;
		private var bonustitle:MovieClip;
		private var score_num:Number=0;
		private var score:Number=0;
		public static var bonusEvt:BattleEvent;
		private var bunosAlert:MovieClip;
        private var honors:Object;
		public function VictoryBonus()
		{
			init();
			
		}
		private function init():void
		{
			num=0;
			bonusMax=Math.floor(Math.random()*21)+10;

			var cpu_team:Object=flox.getSaveData("cpu_teams");
			var cpuID:Number=DataContainer.setCputID;
            var seMax:Number=0;
			for(var i:uint=0;i<8;i++)
			{
                seMax+=cpu_team["t"+cpuID+"_"+i].seMax;

			}
			//for
            bonusMax+=Math.floor(seMax/200);
			DebugTrace.msg("VictoryBonus.init bonusMax="+bonusMax);

			
			
			/*
			var batllestage:MovieClip=new BattleStage();
			batllestage.gotoAndStop(satageID);
			batllestage.y=-786+150;
			addChild(batllestage);
			*/
			
			var loaderReq:LoaderRequest=new LoaderRequest();
			loaderReq.setLoaderQueue("background","../swf/BattleStage.swf",this,onStageBGComplete);
			
			
		}
		private function onStageBGComplete(e:LoaderEvent):void
		{
			var satageID:Number=DataContainer.stageID;
			var swfloader:SWFLoader = LoaderMax.getLoader("background");
			var background:MovieClip=swfloader.getSWFChild("bg") as MovieClip;
			background.gotoAndStop(1);
			background.mc.gotoAndStop(satageID);
			
			initLayout();
			
		}
		private function initLayout():void
		{
			
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
			
			//DebugTrace.msg("VictoryBonus.updateBonus score="+score);
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
				DebugTrace.msg("VictoryBonus.createNewStar Stop Bonus ---> score="+score);


				var format:TextFormat=new TextFormat();
				format.color=0xFFFFFF;
				format.font="SimImpact";
				bunosAlert=new BonusAlert();
				bunosAlert.honor.embedFonts=true;
				bunosAlert.honor.defaultTextFormat=format;
			 
				addChild(bunosAlert);

				TweenMax.to(bunosAlert,0.1,{repeat:score,onRepeat:doScoreRunning,onComplete:onScoreReady});
				//bunosAlert.addEventListener(Event.ENTER_FRAME,doScoreRunning);
				bunosAlert.confirm.addEventListener(MouseEvent.MOUSE_DOWN,doConfirmHandle);

				function doScoreRunning():void
				{
					score_num++;
					bunosAlert.honor.text="+"+score_num;

				}
				function onScoreReady():void{
					TweenMax.killTweensOf(bunosAlert);
					starPhysicsHandle();
				}

				saveBonusHonor();
			}
			//if
			
		}

		private function starPhysicsHandle():void
		{
		
			bonus.starPhysics(this,new Point(bunosAlert.star.x,bunosAlert.star.y),50);
		}
		private function doConfirmHandle(e:MouseEvent):void
		{

			bunosAlert.confirm.removeEventListener(MouseEvent.MOUSE_DOWN,doConfirmHandle);

			onBonusFadeout();
			
		}
		private function saveBonusHonor():void{

			var characters:Array=Config.characters;
			var honors:Object=flox.getSaveData("honor");
			var memberpower:Array=memberscom.getPlayerTeam();
			for(var i:uint=0;i<memberpower.length;i++)
			{
				//DebugTrace.msg("VictoryBonus.createNewStar power="+JSON.stringify(player_power[i]));

				var _name:String=memberpower[i].chname;
				if(characters.indexOf(_name)!=-1 || _name=="player"){
					var honor:Number = honors[_name];
					honor += score;
					honors[_name] = honor;
				}
			}
			//for
			flox.save("honor",honors);
		}
		private function onBonusFadeout():void
		{

			TweenMax.killAll(true);
			TweenMax.killDelayedCallsTo(onBonusFadeout);

			removeChild(bonustitle);
			removeChild(bonus);

			var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvt._name="remove_battle";
			gameEvt.displayHandler();
			
		    var battleType:String=DataContainer.battleType;
            var scene:String=DataContainer.BatttleScene;
            if(battleType=="schedule"){

                scene="SSCCArenaScene";

            }else if(battleType=="random_battle"){

                scene="MainScene";


            }else{

                if(scene=="Story"){

                    var battleData:BattleData=new BattleData();
                    scene=battleData.backStoryScene();
                }


            }


			var command:MainInterface=new MainCommand();	
			var _data:Object=new Object();
			_data.name= scene;
			command.updateInfo();
			command.sceneDispatch(SceneEvent.CHANGED,_data);




		}
		private function onStarFadeout(bonus:Bonus):void
		{
			TweenMax.killTweensOf(bonus);
			removeChild(bonus);
			
		}
	}
}