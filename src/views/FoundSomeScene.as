package views
{
	
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
	
	import model.SaveGame;
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	 
	import starling.display.Sprite;
	 
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	 
	
	import utils.DebugTrace;
	import utils.DrawManager;
	import utils.FilterManager;
	
	
	public class FoundSomeScene extends Scenes
	{
		private var base_sprite:Sprite;
		private var scencom:SceneInterface=new SceneCommnad();
		private var current_scene:String;
		private var arrivedCh:Array=new Array();
		private var command:MainInterface=new MainCommand();
		private var index:uint=0;
		private var iconTween:Tween;
		private var iconslist:Array=new Array();
		private var filter:FilterInterface=new FilterManager();
		private var cancelbtn:Button;
		public function FoundSomeScene()
		{
			current_scene=DataContainer.currentScene.split("Scene").join("");
			DebugTrace.msg("FoundSomeScene scene:"+current_scene)
			base_sprite=new Sprite();
			addChild(base_sprite);
			
			command.setNowMood();
			initLayout();
			setCharacterInside();
			
		}
		private function initLayout():void
		{
			
			//DebugTrace.msg("FoundSomeScene.initLayout currentScene:"+DataContainer.currentScene);
			var drawcom:DrawerInterface=new DrawManager();
			var bgImg:*=drawcom.drawBackground();
			
			var bgSprtie:Sprite=new Sprite();
			bgSprtie.addChild(bgImg);
			filter.setSource(bgSprtie);
			filter.setBulr();
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
		private function setCharacterInside():void
		{
			var current_scene:String=DataContainer.currentScene;
			current_scene=current_scene.split("Scene").join("");
			var savegame:SaveGame=FloxCommand.savegame;
			var scenelikes:Object=savegame.scenelikes;
			var sceneliksStr:String=JSON.stringify(scenelikes);
			DebugTrace.msg("FoundSomeScene.setCharacterInside sceneliksStr:"+sceneliksStr);
			var allChacters:Array=Config.characters;
			
			arrivedCh=new Array();
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
								trace("scene: ",scene,"; character:",character," : ",likes);
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
			
			/*if(arrivedCh.length>1)
			{
				while(arrivedCh.length-1)
				{
					arrivedCh.pop();
					
				}
				//while
			}*/
			
			var arrivedChStr:String=JSON.stringify(arrivedCh);
			DebugTrace.msg("FoundSomeScene.setCharacterInside arrivedChStr:"+arrivedChStr);
			//chlikesStr:[{"value":43,"name":"sao"},{"value":42,"name":"tomoru"},{"value":32,"name":"lenus"},{"value":14,"name":"klaire"},{"value":0,"name":"sirena"},{"value":0,"name":"zack"},{"value":0,"name":"ceil"},{"value":0,"name":"dea"}]
			
			if(arrivedCh.length>0)
			{
				//found some characters at here
				drawCharacterIcon();
				initCancelHandle();
			}
			else
			{
				//nobody
				
				var msg:String="sorry,nobody here!!";
				var talkingAlert:Sprite=new AlertMessage(msg,onDisabledAlertTalking);
				addChild(talkingAlert);
				
			}
			//if
		}
		private function checkSchedule(name:String):Object
		{
			//DebugTrace.msg("FoundSomeScene.checkSchedule likesObj:"+JSON.stringify(likesObj));
			var savegame:SaveGame=FloxCommand.savegame;
			var _likesObj:Object=new Object();
			var dateIndx:Object=DataContainer.currentDateIndex;
			var schedule:Array=DataContainer.scheduleListbrary;
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
			var savegame:SaveGame=FloxCommand.savegame;
			var scenelikes:Object=savegame.scenelikes;
			var dateIndx:Object=DataContainer.currentDateIndex;
			var schedule:Array=DataContainer.scheduleListbrary;
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
				savegame.scenelikes=scenelikes;
				FloxCommand.savegame=savegame;
			
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
			var savedata:SaveGame=FloxCommand.savegame;
			for(var i:uint=0;i<arrivedCh.length;i++)
			{
				
				var name:String=arrivedCh[i].name;
				var pts:Number=Number(savedata.pts[name]);
				var enable_ch:String="ProEmpty";
				var enabled:Boolean=false;
				//if(pts!=-1)
				
				var firstChar:String=name.charAt(0).toLocaleUpperCase();
				var _name:String=name.slice(1,name.length);
				enable_ch="Pro"+firstChar.concat(_name);
				//fake
				//enable_ch="ProLenus";
				
				//character profile image
				/*var texture:Texture=Assets.getTexture(enable_ch);
				var img:Image=new Image(texture);
				img.smoothing=TextureSmoothing.TRILINEAR;
				img.pivotX=img.width/2;
				img.pivotY=img.height/2;
				img.width=80;
				img.height=80;
				
				
				
				//icon bachground 
				var bgtexture:Texture=Assets.getTexture("IconCircle");
				var bgImg:Image=new Image(bgtexture);
				bgImg.smoothing=TextureSmoothing.TRILINEAR;
				bgImg.pivotX=bgImg.width/2;
				bgImg.pivotY=bgImg.height/2;
				bgImg.width=100;
				bgImg.height=100;*/
				
				
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
				index++;
				iconslist.push(sprite);
				
				
				iconTween=new Tween(sprite,0.5,Transitions.EASE_IN);
				iconTween.delay=0.1*index;
				iconTween.scaleTo(1);
				iconTween.onComplete=onFadinComplete
				Starling.juggler.add(iconTween);
				
				//}
				
				//if
			}
			//for
		}
		private function onFadinComplete():void
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
				DebugTrace.msg("FoundSomeScene.onTouchCharaterIcon name:"+target.name);
				
				DataContainer.currentDating=target.name;
				var _data:Object=new Object();
				_data.name="DatingScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data)
				
				
			}
			//if
		}
		private function initCancelHandle():void
		{
			//cancel button
			
			command.addedCancelButton(this,doCencaleHandler);
			
		}
		private function doCencaleHandler():void
		{
			var _data:Object=new Object();
			
			_data.name=DataContainer.currentScene;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
			
		}
	}
}