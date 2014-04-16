package controller
{
	
	
	import flash.geom.Point;
	
	import data.DataContainer;
	
	import events.GameEvent;
	
	import model.SaveGame;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.BlendMode;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.filters.ColorMatrixFilter;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	import utils.FilterManager;
	import utils.ViewsContainer;
	
	import views.CharacterBubble;
	import views.ClickMouseIcon;
	import views.MyTalkingDisplay;
	import views.PhotoMessage;
	
	public class SceneCommnad implements SceneInterface
	{
		private var scene:String;
		private var display_container:Object=new Object();
		private var talks:Array=new Array();
		private var end_index:Number;
		private var player_library:Array=new Array();
		private var _target:Sprite=null;
		private var part_index:Number=0;
		private var talk_index:Number=0;
		private var talking:Array;
		private var talkmask:MyTalkingDisplay=null;
		private var talkfield:MyTalkingDisplay;
		private var command:MainInterface=new MainCommand();
		private var com_content:String=new String();
		private var character:Image;
		
		//private var hitArea:Image;
		private var hitArea:Button;
		private var clickmouse:ClickMouseIcon=null;
		private var ch_pos:Object={"center":new Point(330,0),"left":new Point(-54,0),"right":new Point(650,0)};
		private var bubble:CharacterBubble=null;
		private var spbubble_pos:Object={"spC":new Point(278,235),"spL":new Point(480,440),"spR":new Point(580,235)};
		private var thbubble_pos:Object={"thC":new Point(278,235),"thL":new Point(480,440),"thR":new Point(580,235)};
		private var shbubble_pos:Object={"shC":new Point(278,235),"shL":new Point(480,440),"shR":new Point(580,235)};
		private var moving_tween:Tween;
		private var fishedcallback:Function;
		private var photoframe:PhotoMessage=null;
		private var background:MovieClip=null;
		private var bgSprtie:Image=null;
		private var scene_container:Sprite
		private var day:String;
		public function init(current:String,target:Sprite,part:Number,finshed:Function=null):void
		{
			talk_index=0;
			scene=current;
			display_container=new Object();
			fishedcallback=finshed;
			
			_target=target;
			part_index=part;
			
			var library:Array=DataContainer.characterTalklibrary;
			talks=library[part_index];
			
			
		}
		
		public function start():void
		{
			addTouchArea();
			showChat();
			
		}
		private function addTouchArea():void
		{
			
			var texture:Texture=Assets.getTexture("Whitebg");
			
			hitArea=new Button(texture);
			hitArea.name="hitArea";
			//hitArea=new Image(texture);
			hitArea.width=Starling.current.stage.stageWidth;
			hitArea.height=Starling.current.stage.stageHeight;
			hitArea.alpha=0;
			
			_target.addChild(hitArea)
			_target.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
			
		}
		
		private function onChatSceneTouched(e:TouchEvent):void
		{
			
			var target:Sprite=e.currentTarget as Sprite;
			//DebugTrace.msg("SceneCommand.onChatSceneTouched name:"+target.name);
			var BEGAN:Touch = e.getTouch(target, TouchPhase.BEGAN);
			if(BEGAN)
			{
				onTouchedScene();
			}
			
			
		}
		private function onTouchedScene():void
		{
			talk_index++;
			DebugTrace.msg("SceneCommand.onChatSceneTouched talk_index:"+talk_index);
			end_index=talks.indexOf("END");
			if(talk_index<end_index)
			{
				if(bubble)
				{
					_target.removeChild(bubble);
					bubble=null;
				}
				//if
				showChat();
			}
			else
			{
				//finish
				doClearAll();
				DebugTrace.msg("SceneCommand finished");
				_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
				fishedcallback();
			}
			//if
			
		}
		private function showChat():void
		{
			
			com_content=talks[talk_index];
			DebugTrace.msg("SceneCommand.showChat com_content:"+com_content);
			var comlists:Array=com_content.split("|");
			var todo:String=comlists[0];
			if(todo!="player")
			{
				
				_target.removeChild(talkmask);
				talkmask=null;
			}
			switch(todo)
			{
				case "player":
					creartePlayerChat();
					break
				case "com":
					commandHandle();
					break
				case "spC":
				case "spL":
				case "spR":
					createBubble(comlists);
					break
				case "thC":
				case "thL":
				case "thR":
					createBubble(comlists);
					break
				case "choice":
					addDisplayContainer(comlists[1]);
					break
			}
			
			if(scene.indexOf("Scene")==-1)
			{
				//not form map scene
				clearMouseClickIcon();
				createMouseClickIcon();
			}
			
		}
		public function createMouseClickIcon():void
		{
			DebugTrace.msg("SceneCommand.createMouseClickIcon");
			clickmouse=new ClickMouseIcon();
			clickmouse.x=973;
			clickmouse.y=704;
			_target.addChild(clickmouse);
		}
		public function clearMouseClickIcon():void
		{
			DebugTrace.msg("SceneCommand.clearMouseClickIcon");
			if(clickmouse)
			{
				_target.removeChild(clickmouse);
				clickmouse=null;
			}
			
		}
		
		private function creartePlayerChat():void
		{
			
			
			
			var sentence:String=com_content.split("player|").join("")
			talks[talk_index]=sentence;
			talking=command.filterTalking(talks);
			//DebugTrace.msg("TarotreadingScene.creartePlayerChat talking:"+talking);
			
			_target.removeChild(talkfield);
			
			if(!talkmask)
			{
				talkmask=new MyTalkingDisplay();
				_target.addChild(talkmask);
				talkmask.addMask();
			}
			//if
			createTalkField();
			
		}
		
		private function createTalkField():void
		{
			talkfield=new MyTalkingDisplay();
			talkfield.addTextField(talking[talk_index])
			_target.addChild(talkfield);
			display_container.player=talkfield;
		}
		
		private function commandHandle():void
		{
			var commands:Array=com_content.split(",");
			for(var i:uint=0;i<commands.length;i++)
			{
				var actions:Array=commands[i].split("|");
				var act:String=actions[1];
				var todo:String=act.split("_")[0];
				var target:String=act.split("_")[1];
				var pos:String="";
				if(act.split("_").length==3)
				{
					pos=act.split("_")[2];
				}
				//if
				switch(todo)
				{
					case "remove":
						if(target=="player")
						{
							_target.removeChild(talkmask);
							talkmask=null;
						}
						_target.removeChild(display_container[target]);
						display_container[target]=null;
						break
					case "display":
						createCharacter(target,pos)
						break
					case "move":
						movingCharacter(target,pos)
						break
					case "photo-on":
						createPhotoMessage(target);
						break
					case "photo-off":
						if(photoframe)
						{
							onPhotoRemoved();
						}
						break
					case "music-on":
						command.playBackgroudSound(target);
						break
					case "music-off":
						command.stopBackgroudSound();
						break
					case "sfx":
						command.playSound(target);
						break
					case "video":
						displayVideo(target);
						break
					case "bg":
						createBackground(target);
						break
				}
				//switch
			}
			//for
			if(todo!="video")
			{
				talk_index++;
				showChat();
			}
			//if
			if(photoframe)
			{
				if(talkmask)
				{
					_target.swapChildren(talkmask,photoframe);
					_target.swapChildren(talkmask,hitArea);
				}
				else if(bubble)
				{
					_target.swapChildren(bubble,photoframe);
				}
				//if
			}
			//if
		}
		public function createCharacter(name:String,p:String):void
		{
			DebugTrace.msg("createCharacter : "+name);
			character=Assets.getDynamicAtlas(name)
			//var texture:Texture=Assets.getTexture(name);
			//character=new Image(texture);
			character.name=name;
			character.alpha=0;
			character.x=ch_pos[p].x;
			character.y=ch_pos[p].y;
			_target.addChild(character);
			display_container[name]=character;
			
			
			var tween:Tween=new Tween(character,2,Transitions.EASE_OUT);
			tween.animate("alpha",1);
			tween.onComplete=onCharacterDisplayed;
			Starling.juggler.add(tween);
			
			
		}
		private function onCharacterDisplayed():void
		{
			Starling.juggler.removeTweens(character);
		}
		public function createBubble(comlists:Array):void
		{
			
			
			
			var _pos:String=comlists[0];
			DebugTrace.msg("ChatCommand.createBubble talk_index:"+talk_index+" ; _pos:"+_pos+" ; scene:"+scene);
			var dir:Number=1;
			var bubble_pos:Object;
			if(_pos.indexOf("sp")!=-1)
			{
				bubble_pos=spbubble_pos;
			}
			else if(_pos.indexOf("th")!=-1)
			{
				bubble_pos=thbubble_pos;
			}
			
			if(_pos.indexOf("L")!=-1)
			{
				dir=-1;
			}
			var new_pos:Point=new Point(bubble_pos[_pos].x,bubble_pos[_pos].y);
			bubble=new CharacterBubble(scene,talk_index,part_index,new_pos,dir);
			bubble.x=new_pos.x;
			bubble.y=new_pos.y;
			_target.addChild(bubble);	
			
		}
		public function movingCharacter(target:String,dir:String):void
		{
			DebugTrace.msg("ChatCommand.movingCharacter target:"+target+" ;dir:"+dir);
			var current_ch:Image=display_container[target]
			moving_tween=new Tween(current_ch,0.5,Transitions.EASE_OUT);
			moving_tween.animate("x",ch_pos[dir].x);
			moving_tween.onComplete=onMovingComplete
			Starling.juggler.add(moving_tween)
			
		}
		private function onMovingComplete():void
		{
			Starling.juggler.remove(moving_tween);
		}
		private function createPhotoMessage(target:String):void
		{
			DebugTrace.msg("ChatCommand.createPhotoMessage")
			photoframe=new PhotoMessage(target,onPhotoRemoved);
			photoframe.name="photoframe"
			photoframe.x=Starling.current.stage.stageWidth/2;
			photoframe.y=Starling.current.stage.stageHeight/2;
			
			_target.addChild(photoframe);
			swapHitAreaTouch(0)
		}
		private function onPhotoRemoved():void
		{
			_target.removeChild(photoframe);
			photoframe=null;
			swapHitAreaTouch(1)
		}
		private function swapHitAreaTouch(id:Number):void
		{
			
			if(id==0)
			{
				_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
				hitArea.addEventListener(Event.TRIGGERED,onHitAreaTouched);
			}
			else
			{
				_target.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
				hitArea.removeEventListener(Event.TRIGGERED,onHitAreaTouched);
			}
			
		}
		private function onHitAreaTouched(e:Event):void
		{
			var target:Button=e.currentTarget as Button;
			DebugTrace.msg("SceneCommand.onHitAreaTouched name:"+target.name);
			onTouchedScene();
			
		}
		private function displayVideo(src:String):void
		{
			//DebugTrace.msg("SceneCommand.displayVideo src:"+src);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="show_video";
			gameEvent.video=src;
			gameEvent.displayHandler();
			command.stopBackgroudSound();
			_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
		}
		
		public function addDisplayContainer(src:String):void
		{
			DebugTrace.msg("SceneCommand.addDisplayContainer src:"+src+" ; scene:"+scene);
			command.addDisplayObj(scene,src);
			if(_target)
			{
				_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
				var src_index:Number=src.indexOf("ComCloud");
				//DebugTrace.msg("SceneCommand.addDisplayContainer src_index:"+src_index);
				var scene_index:Number=scene.indexOf("Scene");
				
				
				if(src_index==-1)
				{
					onTouchedScene();
				}
				if(scene.indexOf("Scene")!=-1)
				{
					onTouchedScene();
				}
			}
			
		}
		public function enableTouch():void
		{
			DebugTrace.msg("SceneCommand.enableTouch ");
			_target.addEventListener(TouchEvent.TOUCH,onChatSceneTouched);
			onTouchedScene();
			
		}
		private var filter:FilterInterface=new FilterManager();
		public function createBackground(src:String):void
		{
			var scene:Sprite=ViewsContainer.MainScene;
			scene_container=scene.getChildByName("scene_container") as Sprite;
			
			var savedata:SaveGame=FloxCommand.savegame;
			var dateStr:String=savedata.date.split("|")[1];
			day="Day";
			if(dateStr=="24")
			{
				//night	
				day="Night";
			}
			
			DebugTrace.msg("SceneCommand.createBackground day:"+src+day);
			if(background)
			{
				background.removeFromParent(true);
				background=null;
				//scene_container.removeChild(background);
			}
			if(bgSprtie)
			{
				bgSprtie.removeFromParent(true);
				bgSprtie=null;
			}
			background=Assets.getDynamicAtlas(src);
			//background.loop=false;
			background.stop();
			scene_container.addChild(background);
			
			/*
			background.alpha=0;
			var tween:Tween=new Tween(background,1);
			tween.animate("alpha",1);
			tween.onComplete=onBackgroundComplete;
			Starling.juggler.add(tween);*/
			onBackgroundComplete();
		}
		public function filterBackground():void
		{
			filter.setSource(background);
			filter.setBulr();
			
		}
		private function onBackgroundComplete():void
		{
			
			//Starling.juggler.removeTweens(background);
			if(scene=="HotelScene" || scene=="ParkScene" || scene=="BeachScene" || scene=="PierScene" || scene=="LovemoreMansionScene")
			{
				
				var bgTexture:Texture=Assets.getTexture(scene+day);
				bgSprtie=new Image(bgTexture);
				scene_container.addChild(bgSprtie);
			}
			else
			{
				//day night filter
				//command.filterScene(scene_container);
			}
		}
		private function doClearAll():void
		{
			for(var i:String in display_container)
			{
				if(display_container)
				{
					_target.removeChild(display_container[i]);
				}
				//if
			}
			//for
			if(bubble)
			{
				_target.removeChild(bubble);
			}
			
		}
		public function disableAll():void
		{
			_target.removeEventListener(TouchEvent.TOUCH,onChatSceneTouched);
			_target.removeChild(hitArea)
		}
	}
}