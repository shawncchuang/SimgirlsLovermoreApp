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

import starling.animation.DelayedCall;

import starling.animation.Juggler;

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
import utils.ViewsContainer;


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

			var scene:String = DataContainer.currentScene;
			var evtObj:Object=new Object();
			evtObj.command = "LookAround@"+scene;
			flox.logEvent("CloudCommand", evtObj);
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



			command.initCharacterLocation("current_scene",arrivedCh);

			//var arrivedChStr:String=JSON.stringify(arrivedCh);
			//DebugTrace.msg("FoundSomeScene.setCharacterInside arrivedChStr:"+arrivedChStr);
			//chlikesStr:[{"value":43,"name":"sao"},{"value":42,"name":"tomoru"},{"value":32,"name":"lenus"},{"value":14,"name":"klaire"},{"value":0,"name":"sirena"},{"value":0,"name":"zack"},{"value":0,"name":"ceil"},{"value":0,"name":"dea"}]
			arrivedCh = DataContainer.CharacherLocation;
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
				
				var msg:String="Nobody's here.";
				var talkingAlert:Sprite=new AlertMessage(msg,onDisabledAlertTalking);
				addChild(talkingAlert);
				
				
			}
			
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
	private var delayedCall:DelayedCall;
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
					initNPCRewards();


					//doCanceleHandler();
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

			Starling.juggler.remove(delayedCall);

			var _data:Object=new Object();
			_data.name=DataContainer.currentScene;
			command.sceneDispatch(SceneEvent.CHANGED,_data);	
			
		}
		private function initNPCRewards():void{
			var rewardslist:Array=["image","int","cash"];
			//image 20-30 , int 20-30 , cash 50-100

			var attr:String="";
			var rate:Number=Math.floor(Math.random()*100)+1;
			var reward:Number=0;
			DebugTrace.msg("FoundSomeScene.initNPCRewards rate="+rate);
			if(rate<40){
				attr="";
			}else{
				attr=rewardslist[Math.floor(Math.random()*rewardslist.length)];
			}
			switch(attr){
				case "image":
				case "int":
					reward=Math.floor(Math.random()*11)+20;
					break
				case "cash":
					reward=Math.floor(Math.random()*51)+50;
					break
			}

			if(reward>0){
				if(attr=="cash"){
					var playerValue:Number=flox.getSaveData("cash");
				}else{
					var valueObj:Object=flox.getSaveData(attr);
					playerValue=valueObj.player;
				}
				var values:Object=new Object();
				values[attr]=reward;
				DebugTrace.msg("FoundSomeScene.initNPCRewards reward="+reward);
				DebugTrace.msg("FoundSomeScene.initNPCRewards values="+JSON.stringify(values));

				command.showCommandValues(this,attr,values);

				playerValue+=reward;
				if(attr=="cash"){
					flox.save(attr,playerValue);
				}else{
					valueObj.player=playerValue;
					flox.save(attr,valueObj);
				}


				var gameinfo:Sprite = ViewsContainer.gameinfo;
				gameinfo.dispatchEventWith("UPDATE_INFO");


				delayedCall = new DelayedCall(doCanceleHandler, 1.5);
				Starling.juggler.add(delayedCall);
			}else{


				doCanceleHandler();
			}

		}
		
	}
}