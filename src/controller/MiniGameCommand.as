package controller
{
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;

import data.DataContainer;

import flash.desktop.NativeApplication;
import flash.display.DisplayObject;
import flash.display.MovieClip;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.media.SoundChannel;
import flash.media.SoundTransform;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.Timer;

import events.GameEvent;
import events.MiniGameEvent;
import events.SceneEvent;

import services.LoaderRequest;

import starling.animation.Tween;

import starling.core.Starling;
import starling.display.Sprite;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.MiniGameScene;
import views.Weapon;

public class MiniGameCommand implements MiniGameInterface
{

	private var flox:FloxInterface=new FloxCommand();
	private	var command:MainInterface=new MainCommand();
	private var status:String="playing";
	private var focus_square:MovieClip;
	private var gameStage:MovieClip;
	private var game:String="";
	private var playerSrc:Object={"tracing_Male":"../swf/MINI_n_bike.swf","tracing_Female":"../swf/MINI_n_bike.swf",
		"training_Male":"../swf/B_mini.swf",
		"training_Female":"../swf/G_mini.swf"};
	private var enemySrc:Object={"tracing":"../swf/MINI_b_bike.swf",
		"training":"../swf/ROBO.swf"}
	private var player:MovieClip;
	private var enemy:MovieClip;
	private var PPoX:Number=0;
	private var PPoY:Number=0;
	private var moving:Number=30;
	private var keyDown:String="";
	private var keyUp:String="";
	private var evt:MiniGameEvent;
	private var enemyPoint:Point;
	private var fireArea:MovieClip;
	private var timer:Timer;
	private var weapon:Weapon;
	private var scoreTxt:TextField;
	private var goScene:String="";
	private var enemy_sch:SoundChannel=new SoundChannel();
	private var player_sch:SoundChannel=new SoundChannel();
	private var mace_sch:SoundChannel=new SoundChannel();
	private var robospeak:SoundChannel=new SoundChannel();
	private var game_result:String="";
	public function init(stage:MovieClip,type:String):void
	{

		gameStage=stage;
		game=type;
		if(game=="tracing")
		{
			goScene="TraceGame";
		}
		else
		{
			goScene="TrainingGame";
		}
		var evtObj:Object=new Object();
		evtObj[goScene]="start";
		submitEvent(evtObj);



		gameStage.addEventListener(Event.ENTER_FRAME,swapPlayerEnemy);
	}
	public function drawFocusbackground(_scene:*,_stage:*):void
	{

		focus_square = new MovieClip();
		_scene.addChild(focus_square);

		focus_square.graphics.beginFill(0x0000FF);
		focus_square.graphics.drawRect(0,0,Starling.current.stage.stageWidth,Starling.current.stage.stageHeight);
		focus_square.graphics.endFill();

	}
	public function createEnemyBike(point:Point):void
	{
		enemyPoint=point;
		loaderRequest("enemy",enemySrc[game],onEnemyComplete);
	}
	private function onEnemyComplete(e:LoaderEvent):void
	{

		if(goScene=="TraceGame")
		{
			var st:SoundTransform=new SoundTransform(0.3);
			enemy_sch=command.playSound("B_Bike",1000,st);


		}
		var swfloader:SWFLoader = LoaderMax.getLoader("enemy");
		enemy=swfloader.getSWFChild("bike") as MovieClip;
		enemy.x=enemyPoint.x;
		enemy.y=enemyPoint.y;
		enemy.act.gotoAndStop("sht");
		enemy.act.body.gotoAndStop(1);
		ViewsContainer.EnemyBike=enemy;


		setUpEnergyBall();
		enemyMovingHandle();

	}
	private function enemyMovingHandle():void
	{
		var duration:Number=Math.floor(Math.random()*5)+1;
		var movX:Number=(50-(Math.floor(Math.random()*100)+1));
		var movY:Number=(60-(Math.floor(Math.random()*120)+1));
		var posX:Number=enemyPoint.x+movX;
		var posY:Number=enemyPoint.y+movY;
		TweenMax.to(enemy,duration,{x:posX,y:posY,onComplete:onMovingComplete});

		if(game=="training")
		{
			var speek:Number=Math.floor(Math.random()*100);
			if(speek<90)
			{
				var ran:Number=Math.floor(Math.random()*3)+1;
				command.playSound("Robo"+ran);
			}
		}

	}
	private function onMovingComplete():void
	{
		TweenMax.killTweensOf(enemy);
		enemyMovingHandle();
	}
	private function setUpEnergyBall():void
	{
		fireArea=new MovieClip();
		enemy.addChild(fireArea);

		timer=new Timer(750);
		timer.addEventListener(TimerEvent.TIMER,doAddedEnergyBall);
		timer.start();

	}

	private function doAddedEnergyBall(e:TimerEvent):void
	{
		var messing:Number=Math.floor(Math.random()*100);
		enemy.act.body.play();
		if(game=="training")
		{
			messing=0;
		}

		if(messing<95)
		{


			weapon=new Weapon();

			weapon.setTarget(player);
			if(game=="tracing")
			{
				weapon.EnergyBalls();

				weapon.x=580;
				weapon.y=65;
			}
			else
			{
				var ran:Number=Math.floor(Math.random()*2)+1;
				command.playSound("RoboThrow");

				weapon.BenefitItem();
				weapon.x=145;
				weapon.y=80;
			}

			fireArea.addChild(weapon);
		}
		else
		{

			initEnemyMessingMotion();
		}
	}

	public function createPlayerBike():void
	{
		var avatar:Object=flox.getSaveData("avatar");
		var gender:String=avatar.gender;
		loaderRequest("player",playerSrc[game+"_"+gender],onPlayerComplete);

	}
	private function onPlayerComplete(e:LoaderEvent):void
	{

		if(game=="tracing")
		{
			var st:SoundTransform=new SoundTransform(0.3);
			player_sch=command.playSound("N_Bike",1000,st);

		}

		var swfloader:SWFLoader = LoaderMax.getLoader("player");
		player=swfloader.getSWFChild("bike") as MovieClip;
		player.x=Starling.current.stage.stageWidth-player.width;
		player.y=768/2;
		PPoX=player.x;
		PPoY=player.y;
		player.gotoAndStop("str");
		player.addEventListener(Event.ENTER_FRAME,onPlayerMoving);


		var scene:Sprite=ViewsContainer.currentScene;
		scene.dispatchEventWith(MiniGameScene.GAME_READY);

	}
	private function onPlayerMoving(e:Event):void
	{
		var area:Boolean=true;
		var posX:Number=0;
		var posY:Number=0;
		var speed:Number=0.2;
		var dir:Number=1;

		if(keyDown!="")
		{
			//trace("keyDown ="+keyDown);
			switch(keyDown)
			{
				case "up":
					PPoY-=(moving+5);
					break
				case "dwn":

					PPoY+=(moving+5);
					break
				case "left":

					PPoX-=moving;

					break
				case "right":

					PPoX+=(moving+10);
					break
			}
			//swich
		}
		//if

		//376-(player.width/2)
		if(game=="tracing")
		{
			var xLeft:Number=-player.width/4;
			var yTop:Number=120;
			var y_Bottom:Number=550;
		}
		else
		{
			xLeft=0;
			yTop=200;
			y_Bottom=Starling.current.stage.stageHeight-player.height;
		}

		if(player.x<xLeft)
		{


			PPoX=player.x+moving;
		}
		else if(player.x>1024-player.width)
		{


			PPoX=player.x-moving;

		}

		if(player.y<yTop)
		{

			PPoY=player.y+moving;


		}
		else if(player.y>y_Bottom)
		{


			PPoY=player.y-moving;
		}

		posX=PPoX-player.x;
		posY=PPoY-player.y;


		player.x+=posX*speed;
		player.y+=posY*speed;


		if(enemy.hit1.hitTestObject(player.hit) || enemy.hit2.hitTestObject(player.hit) || enemy.hit3.hitTestObject(player.hit))
		{
			DebugTrace.msg("MiniGameCommand.onplayerMoving player hit anemy");
			//fail
			evt.onHitHandle();
		}
		//if

		if(enemy.act.currentLabel=="mace_loop")
		{
			if(enemy.act.hit.hitTestObject(player.hit))
			{
				//fail
				evt.onHitHandle();
			}
		}
	}

	public function initGameEvent():MiniGameEvent
	{
		evt=new MiniGameEvent();
		evt.addEventListener(MiniGameEvent.KEY_DOWN,doKeyDownHandle);
		evt.addEventListener(MiniGameEvent.KEY_UP,doKeyUpHandle);
		evt.addEventListener(MiniGameEvent.HITTED,onHitHandle);
		evt.addEventListener(MiniGameEvent.GAME_COMPLETE,onCompleteHandle);
		evt.addEventListener(MiniGameEvent.SCORE,onGetScore);
		evt.addEventListener(MiniGameEvent.VICTORY,onVictory);
		return evt;
	}
	private function onCompleteHandle(e:Event):void
	{

		gameComplete();
	}
	private function doKeyDownHandle(e:Event):void
	{

		keyDown=e.target.keyDown;

		//DebugTrace.msg("TraceGame.doKeyboardhandle keyDown="+keyDown);

		if(keyDown=="up" || keyDown=="dwn")
		{
			var act:String="str_"+keyDown;
			player.gotoAndStop(act);

		}
		//if

		if(game=="training")
		{
			if(keyDown=="left")
			{
				//player.scaleX=-1;
				//if(player.scaleX!=-1)
				//TweenMax.to(player, .1, {transformAroundCenter:{scaleX:-1},onComplete:onChangedDirection});
			}

			if(keyDown=="right")
			{

				//if(player.scaleX!=1)
				//TweenMax.to(player, .1, {transformAroundCenter:{scaleX:1},onComplete:onChangedDirection});
			}

		}
		else
		{
			if(keyDown=="up" || keyDown=="dwn")
				command.playSound("Brake");
		}
//		function onChangedDirection():void
//		{
//			TweenMax.killChildTweensOf(player);
//		}

	}

	private function doKeyUpHandle(e:Event):void
	{
		keyDown="";
		keyUp=e.target.keyUp;

		DebugTrace.msg("MiniGameCommand.doKeyboardhandle keyUp="+keyUp);

		player.gotoAndStop("str");


	}
	private function onHitHandle(e:Event):void
	{
		//fail


		gameComplete();
		var scene:Sprite=ViewsContainer.currentScene;
		scene.dispatchEventWith(MiniGameScene.GAME_COMPLETE);

		if(game=="tracing")
		{
			addExplosion();
		}
		else
		{

			player.gotoAndStop("DEATH");
			//player.act.gotoAndStop(1);
			//var playerloader:SWFLoader=LoaderMax.getLoader("player");
			//var root_player:DisplayObject=playerloader.content;
			//gameStage.removeChild(root_player);
			TweenMax.delayedCall(2,onFailHandle);
			TweenMax.to(enemy,0.5,{x:-200});



		}
	}
	private var bikeExpl:MovieClip;
	private function addExplosion():void
	{

		var st:SoundTransform=new SoundTransform(1,0.1);

		command.playSound("Explostion",0,st);
		bikeExpl=new BikeExpl();
		if(game=="tracing")
		{
			bikeExpl.x=player.x+200;
			bikeExpl.y=player.y-20;
		}
		else
		{
			bikeExpl.x=player.x-10;
			bikeExpl.y=player.y-10;
		}
		gameStage.addChild(bikeExpl);


		player.alpha=0;
		/*
		 player.act.gotoAndStop(1);
		 var playerloader:SWFLoader=LoaderMax.getLoader("player");
		 var root_player:DisplayObject=playerloader.content;
		 gameStage.removeChild(root_player);
		 */

		TweenMax.to(enemy,1,{x:-1300,onComplete:onFailHandle});



	}

	public function initEnemyMessingMotion():void
	{

		enemy.act.gotoAndStop("idle");
		timer.stop();
		timer.removeEventListener(TimerEvent.TIMER,doAddedEnergyBall);
		enemy.removeChild(fireArea);

		TweenMax.killTweensOf(enemy);

		TweenMax.to(enemy,1,{x:-1000,y:200,onComplete:onEnemyBikeGoback});

		function onEnemyBikeGoback():void
		{

			TweenMax.killTweensOf(enemy);

			enemy.act.gotoAndStop("mace_start");
			//enemy.act.body.gotoAndStop(1);
			//enemy.act.body.guy.gotoAndStop(1);

			enemy.act.body.gotoAndPlay(2);
			enemy.act.body.guy.gotoAndPlay(2);
			enemy.act.body.addEventListener(Event.ENTER_FRAME,onStartBodyEnterFrame);

			var ran:Number=Math.floor(Math.random()*100);
			if(ran<65)
			{
				var posIndex:Number=0;
			}
			else
			{
				posIndex=1;
			}
			var toPosX:Array=[140,-265];
			TweenMax.to(enemy,1,{x:toPosX[posIndex],onComplete:onEnemyBikeGoforward});
		}

		function onEnemyBikeGoforward():void
		{
			TweenMax.killTweensOf(enemy);

			//enemy.act.body.gotoAndPlay(2);
			//enemy.act.body.guy.gotoAndPlay(2);
			//enemy.act.body.addEventListener(Event.ENTER_FRAME,onStartBodyEnterFrame);


		}
		function onStartBodyEnterFrame(e:Event):void
		{
			checkStauts(onStartBodyEnterFrame);
			if(enemy.act.body.currentFrame==enemy.act.body.totalFrames)
			{
				enemy.act.body.removeEventListener(Event.ENTER_FRAME,onStartBodyEnterFrame);
				onEnemyBikeReaied();
			}


		}
		function onEnemyBikeReaied():void
		{
			TweenMax.killTweensOf(enemy.act.body);
			enemy.act.gotoAndStop("mace_loop");
			//var st:SoundTransform=new SoundTransform(0.5);
			mace_sch=command.playSound("MaceLoops",1000);

			TweenMax.delayedCall(3,onStopMessing);

		}

		function onStopMessing():void
		{

			TweenMax.killDelayedCallsTo(onStopMessing);
			enemy.act.gotoAndStop("mace_stop");
			tryStopSoundEffect(mace_sch);

			enemy.act.body.addEventListener(Event.ENTER_FRAME,onStopBodyEnterFrame);

		}
		function onStopBodyEnterFrame(e:Event):void
		{
			checkStauts(onStopBodyEnterFrame);
			if(enemy.act.body.currentFrame==enemy.act.body.totalFrames)
			{
				enemy.act.body.removeEventListener(Event.ENTER_FRAME,onStopBodyEnterFrame);
				onEnemyBikeStopMessing();
			}
		}
		function onEnemyBikeStopMessing():void
		{
			TweenMax.killTweensOf(enemy.act.body);

			TweenMax.to(enemy,1,{x:-1000,y:190,onComplete:onEnemyBikeGobackChangeWeapon});
		}
		function onEnemyBikeGobackChangeWeapon():void
		{
			TweenMax.killTweensOf(enemy);
			enemy.act.gotoAndStop("idle");
			TweenMax.to(enemy,1,{x:-420,y:190,onComplete:onEnemyBikeReadyToAttack});

		}
		function onEnemyBikeReadyToAttack():void
		{

			TweenMax.killTweensOf(enemy);
			enemy.act.gotoAndStop("sht");
			enemy.act.body.gotoAndStop(1);
			setUpEnergyBall();
			enemyMovingHandle();
		}
		function checkStauts(fun:Function):void
		{

			if(status=="stop")
			{
				enemy.act.body.gotoAndStop(1);
				try
				{
					enemy.act.body.guy.gotoAndStop(1);
				}
				catch(e:Error){}
				enemy.act.body.removeEventListener(Event.ENTER_FRAME,fun);

			}
		}
	}
	private function loaderRequest(id:String,src:String,callback:Function):void
	{

		var loaderReq:LoaderRequest=new LoaderRequest();
		loaderReq.setLoaderQueue(id,src,gameStage,callback);
	}
	private function swapPlayerEnemy(e:Event):void
	{


		try
		{

			var enemyloader:SWFLoader = LoaderMax.getLoader("enemy");
			var playerloader:SWFLoader=LoaderMax.getLoader("player");

			var root_enemy:DisplayObject=enemyloader.content;
			var root_player:DisplayObject=playerloader.content;


			var enemyIndex:Number=gameStage.getChildIndex(root_enemy);
			var playerIndex:Number=gameStage.getChildIndex(root_player);

			if(player.y<Starling.current.stage.stageHeight/2)
			{

				if(playerIndex>enemyIndex)
					gameStage.swapChildren(root_player,root_enemy);

			}
			else
			{
				if(playerIndex<enemyIndex)
				{
					gameStage.swapChildren(root_player,root_enemy);
				}
				//if
			}
			//if
		}
		catch(e:Error)
		{
			trace("MiniGameCommand.onPlayerBikeMoving Error");
		}
	}

	public function gameComplete():void{

		DebugTrace.msg("MiniGameCommand.gameComplete");
		status="stop";
		TweenMax.killAll(true);
		TweenMax.killDelayedCallsTo(doAddedEnergyBall);
		if(game=="tracing")
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,doAddedEnergyBall);
			enemy.act.gotoAndStop("idle");
			tryStopSoundEffect(enemy_sch);
			tryStopSoundEffect(player_sch);
			tryStopSoundEffect(mace_sch);

		}
		else
		{

			if(scoreTxt)
			{
				gameStage.removeChild(scoreTxt);
			}
			tryStopSoundEffect(robospeak);
			command.stopSound("Robo1");
			command.stopSound("Robo2");
			command.stopSound("Robo3");
		}

		command.stopBackgroudSound();
		gameStage.removeEventListener(Event.ENTER_FRAME,swapPlayerEnemy);
		timer.removeEventListener(TimerEvent.TIMER,doAddedEnergyBall);
		timer.stop();
		if(weapon)
			weapon.stopFire();
		try
		{
			enemy.removeChild(fireArea);
		}
		catch(e:Error){}
		player.removeEventListener(Event.ENTER_FRAME,onPlayerMoving);

	}
	private var gameAlert:MovieClip;

	private function onFailHandle():void
	{
		TweenMax.killDelayedCallsTo(onFailHandle);
		TweenMax.killTweensOf(player);
		TweenMax.killTweensOf(enemy);
		game_result="defeat";
		if(game=="tracing")
		{
			gameStage.removeChild(bikeExpl);
		}
		command.playBackgroudSound("BattleDefeat");

		gameAlert=new DefeatAlert();
		gameAlert.x=-1718;
		gameAlert.y=-455;
		gameStage.addChild(gameAlert);


		setupCompleteAlertCtrl();


		var evtObj:Object=new Object();
		evtObj[goScene]=game_result;
		submitEvent(evtObj);
	}

	private function onVictory(e:Event):void
	{

		if(game=="tracing")
		{
			command.playSound("RaceCarDriveBy");
		}

		TweenMax.to(player,1,{x:1200});
		TweenMax.to(enemy,1,{x:-1300,onComplete:victoryHandle});
	}
	private function victoryHandle():void
	{
		game_result="victory";

		TweenMax.killTweensOf(player);
		TweenMax.killTweensOf(enemy);

		command.playBackgroudSound("BattleVictory");
		gameAlert=new VictoryAlert();
		gameStage.addChild(gameAlert);
		gameAlert.x=-1718;
		gameAlert.y=-455;


		setupCompleteAlertCtrl();

		var evtObj:Object=new Object();
		evtObj[goScene]="victory";
		submitEvent(evtObj);


	}
	private function setupCompleteAlertCtrl():void
	{

		var enemyloader:SWFLoader = LoaderMax.getLoader("enemy");
		var playerloader:SWFLoader=LoaderMax.getLoader("player");

		var root_enemy:DisplayObject=enemyloader.content;
		var root_player:DisplayObject=playerloader.content;

		player.act.gotoAndStop(1);
		gameStage.removeChild(root_enemy);
		gameStage.removeChild(root_player);

		var replaybtn:MovieClip=gameAlert.animc.replaybtn;
		var quitbtn:MovieClip=gameAlert.animc.quitbtn;
		replaybtn.buttonMode=true;
		quitbtn.buttonMode=true;
		replaybtn.visible=false;
		//replaybtn.addEventListener(MouseEvent.MOUSE_DOWN,doReplayHandle);
		quitbtn.addEventListener(MouseEvent.MOUSE_DOWN,doQuitHandle);

	}

//		private function doReplayHandle(e:MouseEvent):void
//		{
//
//			//trace("MiniGameCommand.doReplayHandle goScene=",goScene);
//			TweenMax.killAll();
//			var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
//			gameEvt._name="remove_mini_game";
//			gameEvt.displayHandler();
//
//
//			command.stopBackgroudSound();
//
//			//for beta version
//			goScene="BetaScene";
//			var _data:Object=new Object();
//			_data.name=goScene;
//			command.sceneDispatch(SceneEvent.CHANGED,_data);
//
//
//			var evtObj:Object=new Object();
//			evtObj[goScene]="replay";
//			submitEvent(evtObj);
//
//		}
	private function doQuitHandle(e:MouseEvent):void
	{


		DebugTrace.msg("MiniGameCommnad.doQuitHandle");
		command.stopBackgroudSound();


		var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
		gameEvt._name="remove_mini_game";
		gameEvt.displayHandler();
		var _data:Object=new Object();
		if(game=="tracing"){
			var current_switch:String=flox.getSaveData("current_switch");
			if(game_result=="victory"){
				if(current_switch=="s042|off"){flox.save("current_switch","s042b|on");}
				_data.name="CasinoScene";
				_data.from="minigame";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
			}else{
				//game over
				//flox.save("current_switch","s9999|on");

				_data.name="TraceGame";
				command.sceneDispatch(SceneEvent.CHANGED,_data);

			}

	    }else{

			//mediate game
			_data.name="SpiritTempleScene";
			_data.from="minigame";
			command.sceneDispatch(SceneEvent.CHANGED,_data);

		}


	}
	private function onGetScore(e:Event):void
	{
		DebugTrace.msg("MiniGameCommnad.onGetScore score="+e.target.score);

		var scorePerList:Array=["",0.03,0.05,0.07];

		var seMax:Number=flox.getSaveData("love").player;
		//var result:Number=Math.floor(e.target.score*0.03*seMax);
		var result:Number=Math.floor(scorePerList[e.target.score]*seMax);

		var posX:Number=player.x+50;
		var posY:Number=player.y;
		var format:TextFormat=new TextFormat();
		format.size=50;
		format.font="SimNeogreyMedium";
		format.bold=true;
		format.color=0xFFFFFF;
		scoreTxt=new TextField();
		scoreTxt.defaultTextFormat=format;
		scoreTxt.embedFonts=true;
		scoreTxt.autoSize=TextFieldAutoSize.CENTER;
		scoreTxt.text="+"+result;
		scoreTxt.x=posX;
		scoreTxt.y=posY;
		gameStage.addChild(scoreTxt);

		TweenMax.to(scoreTxt,0.5,{y:scoreTxt.y-50,alpha:0,onComplete:onScoreTextFadeout});

		var scene:Sprite=ViewsContainer.currentScene;
		var _data:Object=new Object();
		_data.score=result;
		scene.dispatchEventWith(MiniGameScene.UPDATE_SE,false,_data);
	}
	private function onScoreTextFadeout():void
	{

		TweenMax.killTweensOf(scoreTxt);
		try
		{
			gameStage.removeChild(scoreTxt);
			scoreTxt=null;
		}
		catch(e:Error){}

	}
	private function submitEvent(evtObj:Object):void
	{

		flox.logEvent("MiniGame",evtObj);
	}
	private function tryStopSoundEffect(effect:SoundChannel):void
	{
		try
		{
			effect.stop();
		}
		catch(e:Error){}
	}




}
}