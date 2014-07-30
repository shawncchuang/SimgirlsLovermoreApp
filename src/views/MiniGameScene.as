package views
{
	
	import flash.desktop.NativeApplication;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import flash.utils.Timer;
	
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import events.GameEvent;
	import events.MiniGameEvent;
	
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	public class MiniGameScene  extends Scenes
	{
		private var game:String="";
		private var base_sprite:Sprite;
		private var bgTexture:Texture;
		private var bgImg:Image;
		private var keys:Array=[87,38,65,37,68,39,83,40];
		
		[Embed(source="../../media/textures/scenes/road_stage.png")]
		public static const TraceGameRoad:Class;
		
		[Embed(source="../../media/textures/scenes/road_stage_BG.png")]
		public static const TraceGameBG:Class;
		
		[Embed(source="../../media/textures/scenes/schoo_stage.jpg")]
		public static const TrainingGameBG:Class;
		
		
		private var timeTxt:TextField;
		private var gameTimer:Timer;
		private var sec:Number=60;
		public static var GAME_COMPLETE:String="game_complete";
		public static var GAME_READY:String="game_ready";
		public static var UPDATE_SE:String="update_se";
		private static var mgEvt:Event;
		private var miniGameEvt:MiniGameEvent; 
		private var flox:FloxInterface=new FloxCommand();
	 
		public function MiniGameScene(type:String)
		{
			//TraceGame or TrainingGame
			
			game=type;
			ViewsContainer.currentScene=this;
			base_sprite=new Sprite();
			addChild(base_sprite);
			base_sprite.flatten();
			
			
			
			if(game=="TraceGame")
			{
				initTraceBackGround();
			}
			else
			{
				initTrainingBackGround();
			}
			
			initGame();
			
		}
		private function onGameComplete(e:Event):void
		{
			
			gameComplete();
			
			
		}
		private function initTraceBackGround():void
		{
			
			var bgTedture:Texture=Texture.fromBitmap(new TraceGameBG());
			var skyBg:Image=new Image(bgTedture);
			addChild(skyBg);
			
			
			bgTexture=Texture.fromBitmap(new TraceGameRoad(),true,false,1,"bgra",true);
			
			bgImg=new Image(bgTexture);
			bgImg.width <<=1;
			bgImg.setTexCoords(1, new Point(2, 0));
			bgImg.setTexCoords(2, new Point(0, 1));
			bgImg.setTexCoords(3, new Point(2, 1));
			addChild(bgImg);
			this.addEventListener((EnterFrameEvent.ENTER_FRAME), gameBgLoop);
		}
		private function initTrainingBackGround():void
		{
			
			bgTexture=Texture.fromBitmap(new TrainingGameBG(),true,false,1,"bgra",true);
			
			bgImg=new Image(bgTexture);
			bgImg.width <<=1;
			bgImg.setTexCoords(1, new Point(2, 0));
			bgImg.setTexCoords(2, new Point(0, 1));
			bgImg.setTexCoords(3, new Point(2, 1));
			addChild(bgImg);
			this.addEventListener((EnterFrameEvent.ENTER_FRAME), gameBgLoop);
			
			
		}
		private function gameBgLoop(e:EnterFrameEvent):void
		{
			//bgImg.x=(bgImg.x>-bgImg.width/2)?bgImg.x-10:0;
			var speed:Number=Number((bgImg.width/50).toFixed(2));
			if(bgImg.x>-bgImg.width/2)
			{
				bgImg.x-=speed;
			}
			else
			{
				bgImg.x=0;
			}
			//if
			
		}
		private var kbgImg:Image;
		private var kbgtween:Tween;
		private function initGame():void
		{
			
			this.addEventListener(MiniGameScene.GAME_COMPLETE,onGameComplete);
			this.addEventListener(MiniGameScene.GAME_READY,onGameReady);
			this.addEventListener(MiniGameScene.UPDATE_SE,onUpdateSE);
			
			var kbgTexture:Texture=Assets.getTexture("KeyboardGuild");
			kbgImg=new Image(kbgTexture);
			kbgImg.x=(kbgImg.width/2);
			kbgImg.y=(kbgImg.height/2);
			kbgImg.pivotX=kbgImg.width/2;
			kbgImg.pivotY=kbgImg.height/2;
			kbgImg.scaleX=0.1;
			kbgImg.scaleY=0.1;
			addChild(kbgImg);
			
			
			kbgtween=new Tween(kbgImg,1,Transitions.EASE_IN_OUT_ELASTIC);
			kbgtween.animate("scaleX",1);
			kbgtween.animate("scaleY",1);
			kbgtween.onComplete=onKBGuildComplete;
			Starling.juggler.add(kbgtween);
				
			
		}
		private function onGameReady(e:Event):void
		{
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,doKeyDownHandle);
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_UP,doKeyUpHandle);
			
		}
		private function onKBGuildComplete():void
		{
			
			NativeApplication.nativeApplication.addEventListener(KeyboardEvent.KEY_DOWN,doKeyGuildDownHandle);
			
		}
		private function doKeyGuildDownHandle(e:KeyboardEvent):void
		{
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,doKeyGuildDownHandle);
			 
			kbgtween=new Tween(kbgImg,0.5,Transitions.EASE_OUT_ELASTIC);
			kbgtween.animate("scaleX",.2);
			kbgtween.animate("scaleY",.2);
			kbgtween.animate("alpha",0);
			kbgtween.onComplete=onKBGuildFadeoutComplete;
			Starling.juggler.add(kbgtween);
			
		
		}
		private function onKBGuildFadeoutComplete():void
		{
			Starling.juggler.remove(kbgtween);
			removeChild(kbgImg);
			
			setupGame();
		}
		private function setupGame():void
		{
			
			
			var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvt._name=game;
			gameEvt.displayHandler();
			
		
			if(game=="TraceGame")
			{
				miniGameEvt=TraceGame.MiniGameEvt;
			}
			else
			{
				miniGameEvt=TrainingGame.MiniGameEvt;
			}
			startGame();
			
		}
		private function doKeyDownHandle(e:KeyboardEvent):void
		{
			//DebugTrace.msg("MiniGameScene.doKeyDownHandle "+e.keyCode);
			
			miniGameEvt.keyDown="";
			
			switch(e.keyCode)
			{
				case Keyboard.UP:
				case Keyboard.W:
					//w;up
					miniGameEvt.keyDown="up";
					break
				case Keyboard.LEFT:
				case Keyboard.A:
					//a;left
					miniGameEvt.keyDown="left";
					break
				case Keyboard.RIGHT:
				case Keyboard.D:
					//d;right
					miniGameEvt.keyDown="right";
					break
				case Keyboard.DOWN:
				case Keyboard.S:
					//s;down
					miniGameEvt.keyDown="dwn";
					break
				
			}
			
			miniGameEvt.doKeyDownHandle();
			
		}
		private function doKeyUpHandle(e:KeyboardEvent):void
		{
			
			miniGameEvt.keyUp="";
			switch(e.keyCode)
			{
				case 87:
				case 38:
					//w;up
					miniGameEvt.keyUp="up";
					break
				case 65:
				case 37:
					//a;left
					miniGameEvt.keyUp="left";
					break
				case 68:
				case 39:
					//d;right
					miniGameEvt.keyUp="right";
					break
				case 83:
				case 40:
					//s;down
					miniGameEvt.keyUp="dwn";
					break
			}
			
			miniGameEvt.doKeyUpHandle();
		}
		private var seTxt:TextField;
		private var current_se:Number=0;
		private function startGame():void
		{
			var timeStr:String=setTimeFormat(sec);
			var color:Number=0xFFFFFF;
			if(game=="TrainingGame")
			{
				color=0xBC3327;
				
				var se:Object=flox.getSaveData("se");
				current_se=se.player;
				seTxt=new TextField(120,60,timeStr,"SimNeogreyMedium",30,color);
				seTxt.autoSize=TextFieldAutoSize.BOTH_DIRECTIONS;
				seTxt.x=20;
				seTxt.text="SE : "+current_se;
				addChild(seTxt);
				
				
			}
			timeTxt=new TextField(120,60,timeStr,"SimNeogreyMedium",30,color);
			timeTxt.autoSize=TextFieldAutoSize.BOTH_DIRECTIONS;
			timeTxt.x=Starling.current.stage.stageWidth-timeTxt.width;
			addChild(timeTxt);
			gameTimer=new Timer(1000);
			gameTimer.addEventListener(TimerEvent.TIMER,onGameTimeCounter);
			gameTimer.start();
			
		}
		private function onGameTimeCounter(e:TimerEvent):void
		{
			//time out
			sec--;
			var timeStr:String=setTimeFormat(sec);
			timeTxt.text=timeStr;
			timeTxt.x=Starling.current.stage.stageWidth-timeTxt.width;
			
			if(sec==0)
			{
				
				gameComplete();
				
				miniGameEvt.onCompleteHandle();
				
				miniGameEvt.onVictory();
			}
			//if
		}
		private function setTimeFormat(sec:Number):String
		{
			var timeStr:String="";
			var min:Number=0;
			min=int(sec/60);
			sec=(sec%60>0)?sec%60:0;
			
			var minStr:String=(min<10)?"0"+min:String(min);
			
			var secStr:String=(sec<10)?"0"+sec:String(sec);
			
			timeStr=minStr+" : "+secStr;
			//DebugTrace.msg("timeStr : "+timeStr);
			return timeStr;
		}
		private function gameComplete():void
		{
			DebugTrace.msg("MiniGameScene.gameComplete");
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_DOWN,doKeyDownHandle);
			NativeApplication.nativeApplication.removeEventListener(KeyboardEvent.KEY_UP,doKeyUpHandle);
			this.removeEventListener((EnterFrameEvent.ENTER_FRAME), gameBgLoop);
			gameTimer.stop();
			
			var se:Object=flox.getSaveData("se");
			se.player=current_se;
			//DebugTrace.msg("MiniGameScene.gameComplete current_se="+current_se);
			//DebugTrace.msg("MiniGameScene.gameComplete se="+JSON.stringify(se));
			flox.save("se",se);
		
			
		}
		private function onUpdateSE(e:Event):void
		{
			var max_se:Number=flox.getSaveData("love").player;
			var se:Object=flox.getSaveData("se");
			
			var score:Number=e.data.score;
			current_se+=score;
		
			if(current_se>max_se)
			{
				current_se=max_se;
			}
			seTxt.text="SE : "+current_se;
		}
	}
}