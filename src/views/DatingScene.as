package views
{
	
	
	import controller.Assets;
	import controller.DrawerInterface;
	import controller.FilterInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.ParticleInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	
	import model.SaveGame;
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	import utils.DrawManager;
	import utils.FilterManager;
	import utils.ParticleSystem;
	import utils.ViewsContainer;
	
	public class DatingScene extends Scenes
	{
		private var base_sprite:Sprite;
		private var character:MovieClip;
		private var filter:FilterInterface=new FilterManager();
		private var command:MainInterface=new MainCommand();
		private var proSprtie:Sprite;
		private var moodPie:MovieClip;
		private var mood:Number;
		//raise or less 
		private var _mood:Number;
		private var _love:Number;
		private var drawcom:DrawerInterface=new DrawManager();
		private var fIndex:uint=0;
		
		private var moodPieImg:Image;
		private var cancelbtn:Button;
		private var pts_txt:TextField;
		private var scenecom:SceneInterface=new SceneCommnad();
		private var comcloud:String="ComCloud_L1_^Give,"+
			"ComCloud_L2_^Chat,"+
			"ComCloud_R1_^Dating,"+
			"ComCloud_R2_^Leave,"+
			"ComCloud_R3_^Flirt";
		public static var COMMIT:String="commit";
		private var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
		private var excerptbox:ExcerptBox;
		private var flox:FloxInterface=new FloxCommand();
		private var item_id:String;
		private var loveSprite:Sprite;
		private var cancel:Image;
		private var bubble:Image;
		private var goDating:Number=0;
		private var chat:String;
		private var chatTxt:TextField;
		private var player_love:Number=0;
		private var ch_love:Number=0;
		public function DatingScene()
		{
			//ViewsContainer.InfoDataView.visible=false;
			
			base_sprite=new Sprite();
			addChild(base_sprite);
			this.addEventListener(DatingScene.COMMIT,doCommitCommand);
			ViewsContainer.baseSprite=this;
			ProfileScene.CharacterName="player";
			
			
			var dating:String=DataContainer.currentDating;
			var savegame:SaveGame=FloxCommand.savegame;
			mood=Number(savegame.mood[dating]);
			
			
			
			initLayout();
			
		}
		private function doCommitCommand(e:Event):void
		{
			ViewsContainer.UIViews.visible=false;
			datingTopic.visible=true;
			var com:String=e.data.com;
			DebugTrace.msg("DatingScene.doCommitCommand com:"+com);
			switch(com)
			{
				case "Give":
					initAssetsForm();
					
					break
				case "Leave":
					var _data:Object=new Object();
					_data.name=DataContainer.currentScene;
					command.sceneDispatch(SceneEvent.CHANGED,_data)
					break
				case "Chat":
					var chat:ChatScene=new ChatScene();
					addChild(chat);
					break
				case "Flirt":
					var flirt:FlirtScene=new FlirtScene();
					addChild(flirt);
					break
				case "Dating":
					
					confirmDating();
					break
				case "GotGift":
					item_id=e.data.item_id;
					updateMood();
					var tween:Tween=new Tween(base_sprite,0.25);
					tween.delay=0.25;
					tween.onComplete=onCompleteUpdateMood;
					Starling.juggler.add(tween);
					
					break
				case "FlirtLove":
					_love=e.data.love;
					updateLovefromFlirt();
					break
				
			}
			//switch
		}
		
		private function onCompleteUpdateMood():void
		{
			Starling.juggler.removeTweens(base_sprite);
			startPaticles();
		}
		private function initAssetsForm():void
		{
			
			excerptbox=new ExcerptBox();
			excerptbox.x=56;
			excerptbox.y=275;
			addChild(excerptbox);
			
			gameEvent._name="dating_assets_form";
			gameEvent.displayHandler();
			
			
			
			//added cancel button
			command.addedCancelButton(this,doCancelAssetesForm);
			
			/*cancel=new Button(Assets.getTexture("XAlt"));
			cancel.name="cancel";
			cancel.x=964;
			cancel.y=720;
			addChild(cancel);
			cancel.addEventListener(Event.TRIGGERED,doCancelAssetesForm);*/
			
		}
		private function doCancelAssetesForm():void
		{
			removeChild(excerptbox);
			removeChild(cancel);
			gameEvent._name="removed_assets_form";
			gameEvent.displayHandler();
			
			
			var _data:Object=new Object();
			_data.name=DataContainer.currentLabel;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
			
		}
		private function startPaticles():void
		{
			//	var assets:Object=flox.getSaveData("assets");
			
			var rating:Number=command.searchAssetRating(item_id)
			var type:String="like"
			if(rating<0)
			{
				type="unlike"
			}
			var ps:ParticleInterface=new ParticleSystem();
			ps.init(proSprtie,type);
			ps.showParticles();
			
			showUpdateMood();
			
		}
		private function showUpdateMood():void
		{
			var content:String="Love +";
			if(_love<0)
			{
				content="Love";
			}
			content+=_love;
			loveSprite=new Sprite();
			var moodTxt:TextField=new TextField(200,50,content,"Neogrey Medium",20,0xFFFFFF);
			moodTxt.hAlign="center";
			loveSprite.addChild(moodTxt);
			
			loveSprite.pivotX=loveSprite.width/2;
			loveSprite.pivotY=loveSprite.height/2;
			loveSprite.x=130;
			loveSprite.y=77;
			addChild(loveSprite);
			
			var tween:Tween=new Tween(loveSprite,0.5,Transitions.EASE_OUT_BACK);
			tween.animate("y",loveSprite.y-50);
			//tween.animate("alpha",0.9);
			tween.scaleTo(1.5);
			tween.onComplete=onMoodUPdateComplete
			Starling.juggler.add(tween);
			
		}
		private function onMoodUPdateComplete():void
		{
			Starling.juggler.removeTweens(loveSprite);
			removeChild(loveSprite);
		}
		private function updateMood():void
		{
			
			
			var dating:String=DataContainer.currentDating;
			
			_mood=Number(command.moodCalculator(item_id,dating));
			mood+=_mood;
			
			DebugTrace.msg("DatingScene.updateMood mood:"+mood);
		
			 
			var moodObj:Object=flox.getSaveData("mood");
			moodObj[dating]=mood;
			var savegame:SaveGame=FloxCommand.savegame;
			savegame.mood=moodObj;
			FloxCommand.savegame=savegame;
			
			
			
			drawcom.updatePieChart(mood);
			drawProfile();
			updateRelPoint();
		}
		private var pts_index:Number;
		private  var old_pts:Number;
		private function updateRelPoint():void
		{
			pts_index=0;
			var dating:String=DataContainer.currentDating;
			var savegame:SaveGame=FloxCommand.savegame;
			var ptsObj:Object=savegame.pts;
			old_pts=Number(ptsObj[dating]);
			DebugTrace.msg("DatingScene.updateRelPoint old_pts:"+old_pts);
			this.addEventListener(Event.ENTER_FRAME,doUpdatePts);
			
		}
		private function updateLovefromFlirt():void
		{
			startPaticles();
			
			var dating:String=DataContainer.currentDating;
			DebugTrace.msg("DatingScene.updateMood dating:"+dating);
			
			var loveObj:Object=flox.getSaveData("love");
			var moodObj:Object=flox.getSaveData("love");
			player_love=loveObj.player;
			ch_love=loveObj[dating];
			
			player_love+=_love;
			ch_love+=_love;
			loveObj.player=player_love;
			loveObj[dating]=ch_love;
			
			playerloveTxt.text=String(player_love);
			chloveTxt.text=String(ch_love);
			
			mood=loveObj[dating];
			mood+=_love;
			moodObj[dating]=mood;
			var savegame:SaveGame=FloxCommand.savegame;
			savegame.mood=moodObj;
			savegame.love=loveObj;
			FloxCommand.savegame=savegame;
			
			 
			DebugTrace.msg("DatingScene.updateLovefromFlirt _mood:"+_love);
			DebugTrace.msg("DatingScene.updateLovefromFlirt mood:"+mood);
			drawcom.updatePieChart(mood);
			updateRelPoint();
			
		}
		private function doUpdatePts(e:Event):void
		{
			
			
			if(_mood<0)
			{
				pts_index--;
			}
			else if(_mood>0) 
			{
				pts_index++;
				
			}
			//if
			if(_mood>1000)
			{
				pts_index=_mood;
			}
			var re_pts:Number=old_pts+pts_index;
			if(re_pts<0)
			{
				re_pts=0;
			}
			else if(re_pts>9999)
			{
				re_pts=9999;
			}
			//pts_txt.text=String(re_pts);
			//DebugTrace.msg("DatingScene.doUpdatePts pts_index:"+pts_index);
			if(pts_index==_mood)
			{
				command.updateRelationship(_mood);
				updateRelationShip();
				this.removeEventListener(Event.ENTER_FRAME,doUpdatePts);
				
			}
			
		}
		private function updateRelationShip():void
		{
			var dating:String=DataContainer.currentDating;
			var savegame:SaveGame=FloxCommand.savegame;
			var rel:Object=savegame.rel;
			var rel_str:String=rel[dating].toUpperCase();
			//rel_txt.text=rel_str;
		}
		private var playerloveTxt:TextField;
		private var datingTopic:Sprite;
		private var chloveTxt:TextField;
		private var profile:Sprite=null;
		private function initLayout():void
		{
			
			
			/*var bgMC:MovieClip=Assets.getDynamicAtlas(DataContainer.currentScene);
			bgMC.stop();*/
			
			var bgImg:*=drawcom.drawBackground();
			
			var bgSprtie:Sprite=new Sprite();
			bgSprtie.addChild(bgImg);
			
			filter.setSource(bgSprtie);
			filter.setBulr();
			addChild(bgSprtie);
			initCharacter();
			
			
			datingTopic=new Sprite();
			this.addChild(datingTopic);
			
			var title:Image=new Image(getTexture("DatingTitleBg"));
			title.y=35;
			datingTopic.addChild(title);
			
			
			var dating:String=DataContainer.currentDating;
			var savegame:SaveGame=FloxCommand.savegame;
			
			/*var rel:Object=savegame.rel;
			var rel_str:String=rel[dating].toUpperCase();
			rel_txt=new TextField(247,45,rel_str,"Neogrey Medium",25,0xFFFFFF);
			rel_txt.hAlign="center";
			rel_txt.x=247;
			rel_txt.y=60;
			datingTopic.addChild(rel_txt);*/
			var loveObj:Object=flox.getSaveData("love");
			
			playerloveTxt=new TextField(120,55,loveObj.player,"Futura",40,0xFFFFFF);
			playerloveTxt.x=290;
			playerloveTxt.y=54;
			datingTopic.addChild(playerloveTxt);
			 
			var ch_love_txt:TextField=new TextField(55,55,dating+"\nLove","Futura",18,0xFFFFFF);
			ch_love_txt.x=420;
			ch_love_txt.y=54;
			datingTopic.addChild(ch_love_txt);
				
			
			chloveTxt=new TextField(120,55,loveObj[dating],"Futura",40,0xFFFFFF);
			chloveTxt.x=500;
			chloveTxt.y=54;
			datingTopic.addChild(chloveTxt);
			
			
			var texture:Texture=Assets.getTexture("EnergyPieChartBg");
			var pieBg:Image=new Image(texture);
			pieBg.x=8.5;
			pieBg.y=5;
			datingTopic.addChild(pieBg);
			
			mood=Number(savegame.mood[dating]);
			DebugTrace.msg("DatingScene.initLayout mood:"+mood)
			proSprtie=new Sprite();
			proSprtie.x=130;
			proSprtie.y=127;
			datingTopic.addChild(proSprtie);
			
			drawcom.drawPieChart(proSprtie,"MoodPieChart");
			drawcom.updatePieChart(mood);
			
			
			var first_str:String=dating.charAt(0).toUpperCase();
			var _dating:String=dating.slice(1);
			var pro_dating:String="Pro"+first_str.concat(_dating);
			DebugTrace.msg("DatingScene.initLayout pro_dataing:"+pro_dating);
			
			/*var texture_profile:Texture=Assets.getTexture(pro_dating);
			var profile:Image=new Image(texture_profile);
			profile.smoothing=TextureSmoothing.TRILINEAR;
			profile.pivotX=profile.width/2;
			profile.pivotY=profile.height/2;
			profile.x=132;
			profile.y=128;*/
			drawProfile();
			
			datingTopic.visible=false;
			
			displayCloud();
			
			/*profile.addEventListener(TouchEvent.TOUCH,doRandom);
			function doRandom(e:TouchEvent):void
			{
			var target:Image=e.currentTarget as Image;
			
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			if(began)
			{
			mood=Number(uint(Math.random()*100+1)-50);
			drawcom.updatePieChart(mood);
			
			}
			}*/
		}
		private function drawProfile():void
		{
			
			var dating:String=DataContainer.currentDating;
			
			if(profile)
			{
				
				datingTopic.removeChild(profile);
			}
			
			profile=new Sprite();
			profile.x=130;
			profile.y=126;
			drawcom.drawCharacterProfileIcon(profile,dating,0.5);
			datingTopic.addChild(profile);
		}
		private function initCharacter():void
		{
			var dating:String=DataContainer.currentDating;
		 
			character=Assets.getDynamicAtlas(dating);
			character.x=260;
			
			addChild(character);
			
			
		}
		private function displayCloud():void
		{
			
			var cloudlist:Array=comcloud.split(",")
			for(var i:uint=0;i<cloudlist.length;i++)
			{
				scenecom.addDisplayContainer(cloudlist[i]);
			}
			//for
			
			
		}
		private function confirmDating():void
		{
			/*
			starnger      X 
			new friend    1600
			good firend   1200
			clsoe firned  800
			girlfriend    400
			lover         200
			couples          100
			mood/rel=x/100
			*/
			var relExp:Object=
				{
					"new friend":1600,
					"good firend":1200,
					"close friend":800,
					"girlfriend":400,
					"lover":200,
					"couples":100
				}
			var dating:String=DataContainer.currentDating;
			var relObj:Object=flox.getSaveData("rel");
			var moodObj:Object=flox.getSaveData("mood")
			var mood:Number=Number(moodObj[dating]);
			var rel:String=relObj[dating];
			if(rel=="wife" || rel=="husband")
			{
				rel="couples";
			}
			DebugTrace.msg("DatingScene.confirmDating dating:"+dating);
			DebugTrace.msg("DatingScene.confirmDating mood:"+mood+" ;rel:"+rel);
			goDating=0;
			//fake
			//rel="couples";
			if(rel=="stranger")
			{
				//can't dating
				goDating=0;
			}
			else
			{
				//can dating
				if(mood<=0)
				{
					//low mood can't dating
					goDating=0;
				}
				else
				{
					DebugTrace.msg("DatingScene.confirmDating relExp:"+relExp[rel]);
					goDating=Math.floor((mood*100/relExp[rel]));
					
					
				}
				//if
			}
			//if
			DebugTrace.msg("DatingScene.confirmDating goDating:"+goDating);
			
			var result:Number=uint(Math.random()*100)+1;
			DebugTrace.msg("DatingScene.confirmDating result:"+result);
			var talking:Object=flox.getSyetemData("date_response");
			var chatlist:Array=new Array();
			var index:Number=0;
			//fake
			//result=1
			if(result<=goDating)
			{
				//success dating
				chatlist=talking.y;
				var savegame:SaveGame=FloxCommand.savegame;
				savegame.date=dating;
				FloxCommand.savegame=savegame;
				
				var gameinfo:Sprite=ViewsContainer.gameinfo;
				var _data:Object=new Object();
				_data.dating=dating;
				gameinfo.dispatchEventWith("UPDATE_DATING",false,_data);
				
			
			}
			else
			{
				//lose dating
				chatlist=talking.n;
			}
			//if
			index=uint(Math.random()*chatlist.length);
			chat=chatlist[index];
			
			initBubble();
			
			
			command.addedCancelButton(this,doCancelDating);
			/*
			cancel=new Button(Assets.getTexture("XAlt"));
			cancel.name="cancel";
			cancel.x=964;
			cancel.y=720;
			addChild(cancel);
			cancel.addEventListener(Event.TRIGGERED,doCancelDating);*/
			
		}
		private function  initBubble():void
		{
			
			
			var texture:Texture=Assets.getTexture("Bubble");
			
			//bubbleSprite=new Sprite();
			bubble=new Image(texture);
			bubble.smoothing=TextureSmoothing.TRILINEAR;
			bubble.pivotX=bubble.width/2;
			bubble.pivotY=bubble.height/2;
			
			bubble.x=768;
			bubble.y=260;
			
			bubble.scaleX=0;
			bubble.scaleY=0;
			bubble.alpha=0;
			addChild(bubble);
			
			
			
			var tween:Tween=new Tween(bubble,0.5,Transitions.EASE_OUT_ELASTIC);
			tween.animate("scaleX",-1);
			tween.animate("scaleY",1);
			tween.animate("alpha",1);
			tween.onComplete=onBubbleComplete;
			Starling.juggler.add(tween);
		}
		private function onBubbleComplete():void
		{
			
			Starling.juggler.removeTweens(bubble);
			
			
			
			chatTxt=new TextField(255,190,chat,"Futura",20,0x000000)
			chatTxt.hAlign="left";
			chatTxt.x=634;
			chatTxt.y=110;
			addChild(chatTxt);
			
			
			
		}
		private function doCancelDating():void
		{
			character.removeFromParent();
			//cancel.removeFromParent();
			
			
			var _data:Object=new Object();
			_data.name=DataContainer.currentLabel;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
			
		}
		private function getTexture(src:String):Texture
		{
			var textture:Texture=Assets.getTexture(src);
			return textture;
		}
		
	}
}