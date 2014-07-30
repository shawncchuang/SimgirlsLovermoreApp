package views
{
	
	
	import com.doitflash.consts.Easing;
	import com.doitflash.consts.Orientation;
	import com.doitflash.events.ScrollEvent;
	import com.doitflash.starling.utils.scroller.Scroller;
	
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import controller.AssetEmbeds;
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.MediaCommand;
	import controller.MediaInterface;
	
	import data.Config;
	
	import events.SceneEvent;
	
	import model.SaveGame;
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	public class MainScene extends Scenes
	{
		private var command:MainInterface=new MainCommand();
		private var target:String;
		private var points:Sprite;
		private var preview:Image;
		private var container:Sprite;
		private var stageW:Number;
		private var stageH:Number;
		private var bgX:Number=0;
		private var bgY:Number=0;
		private var gx:Number=0;
		private var gy:Number=0;
		private var signTween:Tween;
		private var posY:Number;
		private var currentImg:Image;
		private var sign_name:String="";
		private var scroll_area:uint=350;
		private var speed:Number=.2;
		private var mediacom:MediaInterface=new MediaCommand();
		public function MainScene()
		{
			
			stageW=Starling.current.stage.stageWidth;
			stageH=Starling.current.stage.stageHeight;
			
			
			
			initScene();
			initWaving();
			initSigns();
			
			//initPoints();
			
		}
		private function initWaving():void
		{
			//mediacom.VideoPlayer(container,"video/map_anim.mp4");
			
			// mediacom.VideoPlayer(new Point(1536,1195),new Point(0,0));
			//mediacom.play("video/map_anim.flv",false);
			//var player:MediaCommand=new MediaCommand();
			//player.VideoPlayer(new Point(1536,1195),new Point(0,0));
			//player.play("video/map_anim.mp4",true);
			//container.addChild(player);
			//var  waveing:MovieClip=Assets.getDynamicAtlas("WavingCrash1");
			//Starling.juggler.add(waveing);
			//container.addChild(waveing);
			
		}
		 
		private var movieX:Number;
		private var movieY:Number;
		private var scrollX:Number;
		private var scrollY:Number;
		private function initScene():void
		{
			
			var scene:Sprite=ViewsContainer.MainScene;
			container=scene.getChildByName("scene_container") as Sprite; 
			command.filterScene(container);
			
			DebugTrace.msg("initScene: "+container.width+" ; "+container.height)
			
			bgX=container.x;
			bgY=container.y;
			
			
			scrollX=stageW;
			scrollY=stageH;
			
			movieX=(container.width-stageW)/scrollX;
			movieY=(container.height-stageH)/scrollY;
		
			
			var gameInfo:Sprite=ViewsContainer.gameinfo;
			gameInfo.addEventListener(TouchEvent.TOUCH,onGameInfobarTouched);
			scene.addEventListener(TouchEvent.TOUCH,onSceneTouched);
			scene.addEventListener(Event.ENTER_FRAME,doSceneEnterFrame);
		}
		private  var new_gx:Number=0;
		private  var new_gy:Number=0;
		//private var hover:Touch;
		private function onGameInfobarTouched(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
			if(hover)
			{
				
				gx=movieX*hover.globalX;
				gy=movieY*hover.globalY;
				
			}
			//for
		}
		private function onSceneTouched(e:TouchEvent):void
		{
			var scene:Sprite=ViewsContainer.MainScene;
			var target:Sprite=e.currentTarget as Sprite;
			var touch:Touch=e.getTouch(target);
			var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
			//DebugTrace.msg("MainScene  onSceneTouched:"+target.name);
			//var moved:Touch = e.getTouch(target, TouchPhase.MOVED);
			
			
			bgX=container.x;
			bgY=container.y;
			/*if(moved)
			{
			gx=moved.globalX;
			gy=moved.globalY;
			
			}*/
			 
			if(hover)
			{
		 
				gx=movieX*hover.globalX;
				gy=movieY*hover.globalY;
				
			}
			else
			{
				 
				//gx=0;
			    //gy=0;
				 
				
			}
			
		 
			
		}
		private function doSceneEnterFrame(e:Event):void
		{
	 
			 
			 
			bgX=-gx;
			bgY=-gy;
			container.x+=(bgX-container.x)*speed;
			container.y+=(bgY-container.y)*speed;
			//container.x=bgX;
			//container.y=bgY;
			
			
			if(bgX>0)
			{
				bgX=0;
			}
			else if(bgX<container.width-stageW)
			{
				
				bgX=-(container.width-stageW);
			}
			if(bgY>0)
			{
				bgY=0;
			}
			else if(bgY<container.height-stageH)
			{
				bgY=-(container.height-stageH);
				
			}
			
		  
				var waving:MovieClip=SimgirlsLovemore.filtesContainer;
				waving.x=container.x;
				waving.y=container.y;
				
				
		 
			
			
		}
		private function initSigns():void
		{
			/*
			var texture:Texture = Texture.fromBitmap(new AtlasTexture());
			var xml:XML = XML(new AtlasXml());
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			*/
			
			
			
			var textureClass:Class=AssetEmbeds;
			
			var texture:Texture=Assets.getTexture("SignsSheet");
			var xml:XML = XML(Assets.getAtalsXML("SignsSheetXML"));
			var atlas:TextureAtlas = new TextureAtlas(texture, xml);
			var stagepoints:Object=Config.stagepoints;
			
			for(var p:String in stagepoints)
			{
				//DebugTrace.msg(p);
				var signTexture:Texture = atlas.getTexture(p);
				var signImg:Image=new Image(signTexture);
				signImg.useHandCursor=true;
				signImg.name=p
				signImg.x=stagepoints[p][0]-signImg.width/2;
				signImg.y=stagepoints[p][1]-signImg.height;
				signImg.addEventListener(TouchEvent.TOUCH,doTouchSign);
				container.addChild(signImg);
			}
			
			
		}
		private function doTouchSign(e:TouchEvent):void
		{
			currentImg=e.currentTarget as Image;
			var touch:Touch = e.getTouch(currentImg, TouchPhase.HOVER);
			var began:Touch=e.getTouch(currentImg,TouchPhase.BEGAN);
			if(began)
			{
				//DebugTrace.msg("MainScene.doTouchSign began: "+currentImg.name);
				
				var savegame:SaveGame=FloxCommand.savegame;
				var date:String=savegame.date;
				var time:String=date.split("|")[1];
				var target:String=currentImg.name+"Scene";
				var msg:String
				if(target=="LoungeScene")
				{
					msg="Sorry,The Lounge'll  open at night.";
					changeScene(target,false,true,time,msg);
				}
				else if(target=="NightclubScene")
				{
					msg="Sorry,The NightClub'll  open at night.";
					changeScene(target,false,true,time,msg);
					
				}
				else if(target=="BlackMarketScene")
				{
					msg="Sorry,The BlackMarket'll  open at night.";
					changeScene(target,false,true,time,msg);
					
				}
				else if(target=="SportBarScene")
				{
					msg="Sorry,The SportBar'll  open at night.";
					changeScene(target,false,true,time,msg);
					
				}
				else if(target=="BankScene")
				{
					msg="Sorry,The Bank'll  open in the morring.";
					changeScene(target,true,false,time,msg);
					
				}
				else if(target=="FitnessClubScene")
				{
					msg="Sorry,The FitnessClub'll  open in the morring.";
					changeScene(target,true,false,time,msg);
				}
				else	
				{
					
					changeScene(target,true,true,time);
					
					
				}
			}
			if(touch)
			{	
				if(sign_name=="")
				{
					//DebugTrace.msg("MainScene.doTouchSign touch: "+currentImg.name);
					sign_name=currentImg.name
					var stagepoints:Object=Config.stagepoints;
					posY=stagepoints[currentImg.name][1]-currentImg.height;
					signTween=new Tween(currentImg,0.4,Transitions.EASE_IN_OUT);
					signTween.animate("y",posY-10);
					signTween.onComplete=onHaverSignComplete;
					Starling.juggler.add(signTween);
				}
				//if
			}
			else
			{
				//DebugTrace.msg("MainScene.doTouchSign !touch: "+currentImg.name);
				sign_name=""
				Starling.juggler.remove(signTween);
				currentImg.y=posY;
			}
			//if 
			
		}
		private function changeScene(target:String,openDay:Boolean,openNight:Boolean,time:String,msg:String=null):void
		{
			var _data:Object=new Object();
			if(!openDay && openNight)
			{
				//day close ,night open
				if(time=="24")
				{
					//night
					
					_data.name= target;
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					currentImg.removeEventListener(TouchEvent.TOUCH,doTouchSign);
				}
				else
				{
					var alert:AlertMessage=new AlertMessage(msg);
					addChild(alert);
				}
				//if
			}
			//if
			if(openDay && !openNight)
			{
				//day open , nihght close
				
				if(time=="24")
				{
					//night
					alert=new AlertMessage(msg);
					addChild(alert);
					
				}
				else
				{
					_data.name= target;
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					currentImg.removeEventListener(TouchEvent.TOUCH,doTouchSign);
				}
				//if
			}
			//if
			if(openDay && openNight)
			{
				//all day
				_data.name= target;
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				currentImg.removeEventListener(TouchEvent.TOUCH,doTouchSign);
				
				
			}
		}
		private function onHaverSignComplete():void
		{
			Starling.juggler.remove(signTween);
			signTween=new Tween(currentImg,0.2,Transitions.EASE_IN);
			signTween.animate("y",posY);
			signTween.onComplete=onSignComplete;
			Starling.juggler.add(signTween);
		}
		private function onSignComplete():void
		{
			Starling.juggler.remove(signTween);
			
		}
		/*private function initPoints():void
		{
		points=new Sprite();
		addChild(points);
		
		var stagepoints:Object=Config.stagepoints;
		
		for(var p:String in stagepoints)
		{
		//DebugTrace.msg(p+"; "+stagepoints[p]);
		
		
		//point name textfield
		var textfied:TextField=new TextField(150,24,p,"Verdana",14,0xFFFFFF);
		textfied.x=stagepoints[p][0]+25;
		textfied.y=stagepoints[p][1];
		textfied.hAlign="left";
		
		
		points.addChild(textfied);
		
		
		}
		//for
		for(var _p:String in  stagepoints)
		{
		
		//points background
		var button:Button=new Button(Assets.getTexture("PointsBg")); 
		button.name=_p;
		button.x = stagepoints[_p][0];
		button.y = stagepoints[_p][1];
		button.addEventListener(Event.TRIGGERED, onPointsTriggered);
		button.addEventListener(TouchEvent.TOUCH,doTouchPoints);
		
		points.addChild(button);
		}
		//for
		
		
		
		}*/
		private function addPreview(p:String):void
		{
			//show preview
			var stagepoints:Object=Config.stagepoints;
			preview=new Image(Assets.getTexture(p+"Preview"));
			preview.name="preview";
			preview.x=stagepoints[p][0];
			preview.y=stagepoints[p][1]+30;
			preview.alpha=0;
			points.addChild(preview);
			addTween(preview,1);
		}
		
		private function doTouchPoints(e:TouchEvent):void
		{
			
			var target:Button=e.currentTarget as Button;
			
			
			var touch:Touch = e.getTouch(target, TouchPhase.HOVER);
			
			//DebugTrace.obj(touch);
			
			if(!touch)
			{
				fadeoutTween(preview,1);
			}
			else
			{
				
				if(!preview)
				{
					//DebugTrace.msg(target.name);
					addPreview(target.name);
				}
				//if
			}
			//if
		}
		
		private function onPointsTriggered(e:Event):void
		{
			points.visible=false;
			var button:Button = e.target as Button;
			target=button.name+"Scene";
			DebugTrace.msg(button.name);
			
			var _data:Object=new Object();
			_data.name=target;
			command.sceneDispatch(SceneEvent.CHANGED,_data)
			
		}
		
		private function addTween(target:Object,value:uint):void
		{
			var tween:Tween=new Tween(target,0.2,Transitions.EASE_IN);
			tween.animate("alpha",value);
			Starling.juggler.add(tween);
		}
		private function fadeoutTween(target:Object,value:uint):void
		{
			var tween:Tween=new Tween(target,0.2,Transitions.EASE_IN);
			tween.animate("alpha",value);
			tween.onComplete=onFadoutComplete;
			Starling.juggler.add(tween);
			
		}
		private function onFadoutComplete():void
		{
			
			var _preview:DisplayObject=points.getChildByName("preview");
			//points.removeChild(_preview);
			points.removeFromParent();
			preview=null
		}
		
		
	}
}