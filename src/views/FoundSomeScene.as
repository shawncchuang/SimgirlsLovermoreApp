package views
{
	
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.DrawerInterface;
	import controller.FilterInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.Config;
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	import utils.DrawManager;
	import utils.FilterManager;
	
	
	public class FoundSomeScene extends Scenes
	{
		private var flox:FloxInterface=new FloxCommand();
		private var base_sprite:Sprite;
		private var scencom:SceneInterface=new SceneCommnad();
		private var current_scene:String;
		private var arrivedCh:Array=new Array();
		private var command:MainInterface=new MainCommand();
		private var index:uint=0;
		private var iconTween:Tween;
		private var iconslist:Array=new Array();
		private var filters:FilterInterface=new FilterManager();
		private var cancelbtn:Image;
		private var npcID:String="";
		private var switchID:String="";
		private var sIndex:Number=-1;
		private var bubble:CharacterBubble;
		private var speaking:Array=new Array();
		private var bubbleTween:Tween;
		private var schedule:Array;
		public function FoundSomeScene()
		{
			current_scene=DataContainer.currentScene.split("Scene").join("");
			DebugTrace.msg("FoundSomeScene scene:"+current_scene);
			
			base_sprite=new Sprite();
			addChild(base_sprite);
			
			//command.setNowMood();
			schedule=flox.getSyetemData("schedule");
			initLayout();
			
			setNPC();
			setCharacterInside();
			initCancelHandle();
			checkEmpty();
		}
		private function initLayout():void
		{
			
			//DebugTrace.msg("FoundSomeScene.initLayout currentScene:"+DataContainer.currentScene);
			var drawcom:DrawerInterface=new DrawManager();
			var bgImg:*=drawcom.drawBackground();
			
			var bgSprtie:Sprite=new Sprite();
			bgSprtie.addChild(bgImg);
			filters.setSource(bgSprtie);
			filters.setBulr();
			command.filterScene(bgSprtie);
			addChild(bgSprtie);
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			
			
			
		}
		private function onCallback():void
		{
			DebugTrace.msg("FoundSomeScene.onCallback");
			
		}
		private var npcIDList:Array;
		private var switchIDList:Array;
		private function setNPC():void
		{
			var npclocated:Object=flox.getSyetemData("npcLocated");
			if(npclocated[current_scene])
			{
				var npcIDs:String=npclocated[current_scene].id;
				var switchIDs:String=npclocated[current_scene].switchID;
				npcIDList=new Array();
				switchIDList=new Array();
				if(npcIDs.indexOf(",")!=-1)
				{
					npcIDList=npcIDs.split(",");
					switchIDList=switchIDs.split(",");
				}
				else
				{
		 
					npcIDList.push(npcIDs);
					switchIDList.push(switchIDs);
				}
				for(var i:uint=0;i<npcIDList.length;i++)
				{
					npcID=npcIDList[i];
					DebugTrace.msg("FoundSomeScene.setNPC npcID="+npcID);
					var chlikes:Object=new Object();
					chlikes.name=npcID;
					chlikes.value=0;
					arrivedCh.push(chlikes);
					
					drawNPCIcon();
					
					
				}
				//for
			}
			
		}
		private function setCharacterInside():void
		{
			//var current_scene:String=DataContainer.currentScene;
			//current_scene=current_scene.split("Scene").join("");
			//var savegame:SaveGame=FloxCommand.savegame;
			//var scenelikes:Object=savegame.scenelikes;
			var scenelikes:Object=flox.getSaveData("scenelikes");
			var sceneliksStr:String=JSON.stringify(scenelikes);
			DebugTrace.msg("FoundSomeScene.setCharacterInside sceneliksStr:"+sceneliksStr);
			var allChacters:Array=Config.characters;
			
			
			var chlist:Array=new Array();
			//check schedule
			for(var j:uint=0;j<allChacters.length;j++)
			{
				
				var character:String=allChacters[j];
				characterInSchedule(character);
				var liksObj:Object=checkSchedule(character);
				
				if(liksObj)
				{
					var liksObjStr:String=JSON.stringify(liksObj);
					
					arrivedCh.push(liksObj);
					chlist.push(liksObj.name);
				}
				else
				{
					//people likes
					DebugTrace.msg("FoundSomeScene.setCharacterInside liksObjStr:"+liksObjStr);
					
					if(chlist.indexOf(character)==-1)
					{
						//popele don't have schedule 
						//but likes this scene with character;
						for(var k:uint=0;k<scenelikes[character].length;k++)
						{
							var likes:Number=scenelikes[character][k].likes;
							var scene:String=scenelikes[character][k].name;
							//DebugTrace.obj(likes);
							//DebugTrace.obj(scene);
							if(scene==current_scene && likes>0 && k==0)
							{
								// most like
								var chlikes:Object=new Object();
								chlikes.name=character;
								chlikes.value=likes;
								//trace("FoundSomeScene.setCharacterInside scene: ",scene,"; character:",character," : ",likes);
								arrivedCh.push(chlikes);
								
							}
							//if
						}
						//for
					}
					//if
					
				}
				//if
				
			}
			//for
			
			//fake
			//chlikeslist.push({"value":80,"name":"lenus"});
			arrivedCh.sortOn("value",Array.NUMERIC|Array.DESCENDING);
			
			
			var arrivedChStr:String=JSON.stringify(arrivedCh);
			//DebugTrace.msg("FoundSomeScene.setCharacterInside arrivedChStr:"+arrivedChStr);
			//chlikesStr:[{"value":43,"name":"sao"},{"value":42,"name":"tomoru"},{"value":32,"name":"lenus"},{"value":14,"name":"klaire"},{"value":0,"name":"sirena"},{"value":0,"name":"zack"},{"value":0,"name":"ceil"},{"value":0,"name":"dea"}]
			
			if(arrivedCh.length>0)
			{
				//found some characters at here
				drawCharacterIcon();
				//	initCancelHandle();
			}
			else
			{
				//nobody
				
				//var msg:String="sorry,nobody here!!";
				//var talkingAlert:Sprite=new AlertMessage(msg,onDisabledAlertTalking);
				//addChild(talkingAlert);
				
			}
			//if
		}
		private function checkEmpty():void
		{
			if(arrivedCh.length==0)
			{
				//nobody
				
				var msg:String="sorry,nobody here!!";
				var talkingAlert:Sprite=new AlertMessage(msg,onDisabledAlertTalking);
				addChild(talkingAlert);
				
				
			}
			
		}
		private function checkSchedule(name:String):Object
		{
			//DebugTrace.msg("FoundSomeScene.checkSchedule likesObj:"+JSON.stringify(likesObj));
			
			var _likesObj:Object=new Object();
			var dateIndx:Object=DataContainer.currentDateIndex;
			//var schedule:Array=DataContainer.scheduleListbrary;
			//var schedule:Array=flox.getSyetemData("schedule");
			var schIndex:Object=Config.scheduleIndex;
			var index:Number=schIndex[name];
			var schedule_scene:String=schedule[index+dateIndx.month][dateIndx.date];
			var scene:String=DataContainer.currentScene;
			scene=scene.split("Scene").join("");
			//DebugTrace.msg("FoundSomeScene.checkSchedule date:"+dateIndx.date);
			//DebugTrace.msg("FoundSomeScene.checkSchedule schedule:"+schedule[index+dateIndx.month][dateIndx.date]);
			//DebugTrace.msg("FoundSomeScene.checkSchedule dateIndx:"+JSON.stringify(dateIndx));
			//DebugTrace.msg("FoundSomeScene.checkSchedule schedule_scene:"+schedule_scene+" ;scene:"+scene);
			if(schedule_scene==scene)
			{
				_likesObj.value=100;
				_likesObj.name=name;
			}
			else
			{
				/*var scenelikes:Object=savegame.scenelikes;
				index=schIndex[name];
				schedule_scene=schedule[index+dateIndx.month][dateIndx.date];
				for(var i:uint=0;i<scenelikes[name].length;i++)
				{
				//character has schedule
				scenelikes[name][i].likes=0;
				}
				savegame.scenelikes=scenelikes;
				FloxCommand.savegame=savegame;*/
				_likesObj=null;
			}
			return _likesObj;
		}
		private function characterInSchedule(name:String):void
		{
			//var savegame:SaveGame=FloxCommand.savegame;
			//var scenelikes:Object=savegame.scenelikes;
			var scenelikes:Object=flox.getSaveData("scenelikes");
			var dateIndx:Object=DataContainer.currentDateIndex;
			//var schedule:Array=DataContainer.scheduleListbrary;
			var schIndex:Object=Config.scheduleIndex;
			var index:Number=schIndex[name];
			var schedule_scene:String=schedule[index+dateIndx.month][dateIndx.date];
			DebugTrace.msg("FoundSomeScene.characterInSchedule  date:"+dateIndx.date);
			DebugTrace.msg("FoundSomeScene.characterInSchedule  schedule_scene:"+schedule_scene);
			if(schedule_scene)
			{
				//character has schedule
				for(var i:uint=0;i<scenelikes[name].length;i++)
				{
					
					scenelikes[name][i].likes=0;
				}
				//savegame.scenelikes=scenelikes;
				//FloxCommand.savegame=savegame;
				flox.save("scenelikes",scenelikes);
			}
			//if
		}
		private function onDisabledAlertTalking():void
		{
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			var _data:Object={name:DataContainer.currentScene};
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
			
		}
		private function drawCharacterIcon():void
		{
			
			var arrivedChStr:String=JSON.stringify(arrivedCh);
			DebugTrace.msg("FoundSomeScene.drawCharacterIcon arrivedChStr:"+arrivedChStr);
			//var savedata:SaveGame=FloxCommand.savegame;
			var ptsObj:Object=flox.getSaveData("pts");
			for(var i:uint=0;i<arrivedCh.length;i++)
			{
				var name:String=arrivedCh[i].name;
				if(name.indexOf("npc")==-1)
				{
					
					var pts:Number=Number(ptsObj[name]);
					var enable_ch:String="ProEmpty";
					var enabled:Boolean=false;
					//if(pts!=-1)
					
					var firstChar:String=name.charAt(0).toLocaleUpperCase();
					var _name:String=name.slice(1,name.length);
					enable_ch="Pro"+firstChar.concat(_name);
					
					
					//base sprite
					var sprite:Sprite=new Sprite();
					sprite.name=name;
					sprite.useHandCursor=true;
					sprite.x=index*100+90;
					sprite.y=200;
					sprite.scaleX=0.1;
					sprite.scaleY=0.1;
					
					var drawcom:DrawerInterface=new DrawManager();
					drawcom.drawCharacterProfileIcon(sprite,name,0.45);
					//sprite.addChild(bgImg);
					//sprite.addChild(img);
					addChild(sprite);
					sprite.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
					
					index++;
					iconslist.push(sprite);


					iconTween=new Tween(sprite,0.5,Transitions.EASE_IN);
					iconTween.delay=0.1*index;
					iconTween.scaleTo(1);
					//iconTween.onComplete=onFadinComplete
					Starling.juggler.add(iconTween);
					
				}				
				//if
			}
			//for
		}
		private function drawNPCIcon():void
		{
			//base sprite
			var sprite:Sprite=new Sprite();
			sprite.name=npcID;
			sprite.useHandCursor=true;
			sprite.x=index*100+90;
			sprite.y=200;
			sprite.scaleX=0.1;
			sprite.scaleY=0.1;
			
			var drawcom:DrawerInterface=new DrawManager();
			drawcom.drawNPCProfileIcon(sprite,npcID,0.45);
			
			addChild(sprite);
			index++;
			iconslist.push(sprite);
			sprite.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
			
			iconTween=new Tween(sprite,0.3,Transitions.EASE_IN);
			iconTween.delay=0.1*index;
			iconTween.scaleTo(1);
			//iconTween.onComplete=onFadinComplete;
			Starling.juggler.add(iconTween);
			
		}
		
		/*private function onFadinComplete():void
		{
		 
			if(index==arrivedCh.length)
			{
				for(var i:uint=0;i<iconslist.length;i++)
				{
					var _sprite:Sprite=iconslist[i];
					//Starling.juggler.removeTweens(_sprite);
					_sprite.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
				}
			}
		}*/
		private function onTouchCharaterIcon(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			if(hover)
			{
				
				var tween:Tween=new Tween(target,0.2,Transitions.LINEAR);
				tween.scaleTo(1.2);
				Starling.juggler.add(tween);
				
				
			}
			else
			{
				tween=new Tween(target,0.2,Transitions.LINEAR);
				tween.scaleTo(1);
				Starling.juggler.add(tween);
			}
			//if
			if(began)
			{
				Starling.juggler.remove(iconTween);
				Starling.juggler.remove(tween);
				target.removeEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
				DebugTrace.msg("FoundSomeScene.onTouchCharaterIcon name:"+target.name);
				if(target.name.indexOf("npc")==-1)
				{
					
					DataContainer.currentDating=target.name;

                    //command.setNowMood();

					var _data:Object=new Object();
					_data.name="DatingScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data)
				}
				else
				{
					//NPC
					npcID=target.name;
					npcSpeakingHandle();
					
				}
				//if
				
			}
			//if
		}
		private var npcTween:Tween;
		private function npcSpeakingHandle():void
		{
			
			removeChild(cancelbtn);
			for(var i:uint=0;i<iconslist.length;i++)
			{
				var icon:Sprite=iconslist[i];
				removeChild(icon);
			}
			
			
			var clickmouse:ClickMouseIcon=new ClickMouseIcon();
			clickmouse.x=973;
			clickmouse.y=704;
			addChild(clickmouse);
			
			
			var npcTexture:Texture=Assets.getTexture(npcID);
			var npcImg:Image=new Image(npcTexture);
			npcImg.x=Starling.current.stage.width/2-npcImg.width/2;
			npcImg.alpha=0;
			addChild(npcImg);
			
			npcTween=new Tween(npcImg,0.5,Transitions.EASE_IN);
			npcTween.animate("alpha",1);
			npcTween.onComplete=onNPCFadeIn;
			Starling.juggler.add(npcTween);
			 
			var index:Number=npcIDList.indexOf(npcID);
			var switchID:String=switchIDList[index];
			var nps:Object=flox.getSyetemData("npcs");
			speaking=nps[npcID][switchID];
			DebugTrace.msg("FoundSomeScene.npcSpeakingHandle speaking="+speaking);
			DataContainer.NpcTalkinglibrary=speaking;
			
			this.addEventListener(TouchEvent.TOUCH,onNextSpeaking);
			
			
			
			
			
		}
		private function addNewBubble():void
		{
			//trace("addBubble sIndex=",sIndex)
			var pos:Point=new Point(278,235); 
			bubble=new CharacterBubble("NPC",sIndex,0,pos,1);
			bubble.x=pos.x;
			bubble.y=pos.y;
			addChild(bubble);
			
		}
		private function onNextSpeaking(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			
			if(began)
			{
				if(sIndex<speaking.length-1)
				{
					sIndex++;
					if(sIndex==0)
					{
						addNewBubble();	
					}
					else
					{
						bubbleTween=new Tween(bubble,0.2);
						bubbleTween.scaleTo(0.3);
						bubbleTween.onComplete=onBubbleFadeout;
						Starling.juggler.add(bubbleTween);
					}
					//if
				}
				else
				{
					this.removeEventListener(TouchEvent.TOUCH,onNextSpeaking);
					Starling.juggler.remove(bubbleTween);
					doCanceleHandler();
				}
				
				//if		
			}	
			//if
		}
		private function onBubbleFadeout():void
		{
			Starling.juggler.remove(bubbleTween);
			removeChild(bubble);
			addNewBubble();
		}
		private function onNPCFadeIn():void
		{
			Starling.juggler.remove(npcTween);
			
			
		}
		private function initCancelHandle():void
		{
			//cancel button
			
			cancelbtn=command.addedCancelButton(this,doCanceleHandler);
			
		}
		private function doCanceleHandler():void
		{
			
			var _data:Object=new Object();
			_data.name=DataContainer.currentScene;
			command.sceneDispatch(SceneEvent.CHANGED,_data);	
			
		}
		
	}
}