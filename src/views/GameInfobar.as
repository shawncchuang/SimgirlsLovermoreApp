package views
{
	
	
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import controller.Assets;
	import controller.DrawerInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	
	import model.SaveGame;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.extensions.pixelmask.PixelMaskDisplayObject;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	import utils.DrawManager;
	import utils.ViewsContainer;
	
	public class GameInfobar extends Sprite
	{
		private var font:String="Neogrey Medium";
		private var attrlist:Array;
		private var valuelist:Array;
		private var flox:FloxInterface=new FloxCommand();
		private var dateTxt:TextField;
		private var cashTxt:TextField;
		private var apTxt:TextField;
		private var imageTxt:TextField;
		private var intTxt:TextField;
		private var honorTxt:TextField;
		private var loveTxt:TextField;
		private var ypos:Number=25;
		private var diplaymc:Image;
		private var displayConvert:Image;
		private var dayImg:Image;
		private var nightImg:Image;
		private var moreIcon:Image;
		private var morebar:Sprite;
		
		private var covertTween:Tween;
		private var apSprite:Sprite=null;
		private var cashSprite:Sprite=null;
		private var imageSprite:Sprite=null;
		private var intSprite:Sprite=null;
		private var moodSprite:Sprite=null;
		private var rotation:Number=360;
		private var command:MainInterface=new MainCommand();
		private var basemodel:Sprite;
		private var drawcom:DrawerInterface=new DrawManager();
		private var player_icon:Sprite;
		private var scenecom:SceneInterface=new SceneCommnad();
		private var infoDataView:Sprite;
		private var comDirView:Sprite;
		private var comDirTxt:TextField;
		private var payApTxt:TextField;
		public function GameInfobar()
		{
			
			
			
			ViewsContainer.gameinfo=this;
			
			infoDataView=new Sprite();
			addChild(infoDataView);
			ViewsContainer.InfoDataView=infoDataView;
			
			
			showWheel();
			showDisplay();
			showDate();  
			showCash();
			showAP();
			showDayIcon();
			
			showMore();
			showAppearance();
			showIntelligence();
			showHonor();
			showLove();
			
			
			drawProfile();
			showCommandDirections();
			
			
			
			this.addEventListener("UPDATE_INFO",onUpdateInformation);
			//this.addEventListener("DISPLAY_VALUE",onShowDisplayValue);
			this.addEventListener("UPDATE_DIRECTION",onUpdateDirections);
			this.addEventListener("UPDATE_DATING",onUpdateDating);
			this.addEventListener("CANCEL_DATING",onCancelDating);
			this.dispatchEventWith("UPDATE_INFO");
			this.dispatchEventWith("UPDATE_DATING");
		}
		private function showDisplay():void
		{
			var framesX:Array=[169,390,607];
			var barbgTexture:Texture=Assets.getTexture("GameInfobarBg");
			diplaymc=new Image(barbgTexture);
			infoDataView.addChild(diplaymc);
			
			
		}
		 
		private function onUpdateInformation(e:Event):void
		{
			DebugTrace.msg("GameInfobar.onUpdateInformation");
			
			dateTxt.removeFromParent();
			showDate();			
			var savedata:SaveGame=flox.getSaveData();
			
			var time:String=String(savedata.date.split("|")[1]);
			cashTxt.text=DataContainer.currencyFormat(savedata.cash);
			//cashTxt.text=String(savedata.cash);
			apTxt.text=String(savedata.ap+" / "+savedata.max_ap);
			imageTxt.text=String(savedata.image.player);
			intTxt.text=String(savedata.int.player);
			honorTxt.text=String(savedata.honor.player);
			loveTxt.text=String(savedata.love.player);
			dayImg.visible=true;
			nightImg.visible=true;
			if(time=="12")
			{
				nightImg.visible=false;
			}
			else
			{
				dayImg.visible=false;
			}
		}
		
		private function showDate():void
		{
			
			var savedata:SaveGame=FloxCommand.savegame;
			var dateStr:String=savedata.date.split("|")[0];
			var datelist:Array=dateStr.split(".");
			datelist.pop();
			
			var show_date:String=String(datelist.toString().split(",").join("."));
			//DebugTrace.msg("GameInfobar.showDate show_date:"+show_date)
			dateTxt=new TextField(200,40,show_date,font,22,0xFFFFFF);
			dateTxt.hAlign="left";
			dateTxt.vAlign="center";
			dateTxt.x=311;
			dateTxt.y=ypos;
			infoDataView.addChild(dateTxt);
		}
		private function showCash():void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			var cashStr:String=String(savedata.cash);
			cashTxt=new TextField(170,40,cashStr,font,22,0xFFFFFF);
			cashTxt.hAlign="left";
			cashTxt.x=555;
			cashTxt.y=ypos;
			infoDataView.addChild(cashTxt);
			var cashTextute:Texture=Assets.getTexture("Cashsign");
			var cash_sign:Image=new Image(cashTextute);
			cash_sign.smoothing=TextureSmoothing.TRILINEAR;
			cash_sign.width=54;
			cash_sign.height=54;
			cash_sign.x=480;
			cash_sign.y=15;
			infoDataView.addChild(cash_sign);
			
			
			var dollarTextute:Texture=Assets.getTexture("Dollarsign");
			var dollar_sign:Image=new Image(dollarTextute);
			dollar_sign.smoothing=TextureSmoothing.TRILINEAR;
			dollar_sign.x=532;;
			dollar_sign.y=17;
			infoDataView.addChild(dollar_sign);
		}
		private function showAP():void
		{
			
			var apTexture:Texture=Assets.getTexture("ApIcon");
			var apIcon:Image=new Image(apTexture);
			apIcon.x=750;
			apIcon.y=20;
			infoDataView.addChild(apIcon);
			
			var savedata:SaveGame=FloxCommand.savegame;
			var cashStr:String=String(savedata.ap);
			var value:String=cashStr+" / "+savedata.max_ap;
			apTxt=new TextField(200,40,value,font,22,0xFFFFFF);
			apTxt.hAlign="left";
			apTxt.x=808;
			apTxt.y=ypos;
			infoDataView.addChild(apTxt);
		}
		private function showAppearance():void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			var imageStr:String=String(savedata.image);
			
			imageTxt=new TextField(55,30,imageStr,font,17,0xFFFFFF);
			//imageTxt.hAlign="left";
			imageTxt.x= 2;
			imageTxt.y=43;
			morebar.addChild(imageTxt);
			
			
		}
		
		private function showIntelligence():void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			var intStr:String=String(savedata.int);
			
			
			intTxt=new TextField(55,30,intStr,font,17,0xFFFFFF);
			//intTxt.hAlign="left";
			intTxt.x=2;
			intTxt.y=123;
			morebar.addChild(intTxt);
		}
		private function showHonor():void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			var honorStr:String=String(savedata.honor);
			
			
			honorTxt=new TextField(55,30,honorStr,font,17,0xFFFFFF);
			//honorTxt.hAlign="left";
			honorTxt.x=2
			honorTxt.y=203;
			morebar.addChild(honorTxt);
		}
		private function showLove():void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			var loveStr:String=String(savedata.love);
			
			
			loveTxt=new TextField(55,30,loveStr,font,17,0xFFFFFF);
			//loveTxt.hAlign="left";
			loveTxt.x=2;
			loveTxt.y=282;
			morebar.addChild(loveTxt);
		}
		private function showDayIcon():void
		{
			var __x:Number=255;
			var __y:Number=4;
			var _scale:Number=68;
			var day_texture:Texture=Assets.getTexture("DaySign");
			dayImg=new Image(day_texture);
			dayImg.smoothing=TextureSmoothing.TRILINEAR;
			dayImg.x=__x;
			dayImg.y=__y;
			dayImg.width=_scale;
			dayImg.height=_scale;
			var night_texture:Texture=Assets.getTexture("NightSign");
			nightImg=new Image(night_texture);
			nightImg.smoothing=TextureSmoothing.TRILINEAR;
			nightImg.x=__x;
			nightImg.y=__y;
			nightImg.width=_scale;
			nightImg..height=_scale;
			infoDataView.addChild(dayImg);
			infoDataView.addChild(nightImg);
			
			
		}
		private function showWheel():void
		{
			var texture:Texture=Assets.getTexture("GameInfobarWheel");
			displayConvert=new Image(texture);
			//displayConvert.useHandCursor=true;
			displayConvert.pivotX=displayConvert.width/2;
			displayConvert.pivotY=displayConvert.height/2;
			displayConvert.x=65;
			displayConvert.y=20;
			infoDataView.addChild(displayConvert);
			
			startConertRotation();
			
		}
		
		private function startConertRotation():void
		{
			covertTween=new Tween(displayConvert,360);
			covertTween.animate("rotation",rotation);
			covertTween.onComplete=doCovertRotationComplete
			Starling.juggler.add(covertTween);
			
			
		}
		private function doCovertRotationComplete():void
		{
			Starling.juggler.removeTweens(displayConvert);
			//rotation=0;
			displayConvert.rotation=0;
			startConertRotation();
		}
		
		private function showMore():void
		{
			
			
			var texture:Texture=Assets.getTexture("MoreIcon");
			moreIcon=new Image(texture);
			moreIcon.useHandCursor=true;
			moreIcon.smoothing=TextureSmoothing.TRILINEAR;
			moreIcon.width=60;
			moreIcon.height=60;
			moreIcon.x=959;
			moreIcon.y=12;
			addChild(moreIcon);
			moreIcon.addEventListener(TouchEvent.TOUCH,doTouchMoreIcon);
			
			
			morebar=new Sprite();
			morebar.y=85;
			var barTexture:Texture=Assets.getTexture("MorebarIcon");
			var morebarbg:Image=new Image(barTexture);
			morebar.addChild(morebarbg);
			morebar.x=966+morebarbg.width;
			addChild(morebar);
			
			
		}
		private function doTouchMoreIcon(e:TouchEvent):void
		{
			var target:Image=e.currentTarget as Image;
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			if(hover)
			{
				Starling.juggler.removeTweens(morebar);
				var tween:Tween=new Tween(morebar,0.2,Transitions.EASE_OUT)
				tween.animate("x",966);
				Starling.juggler.add(tween);
				
				
			}
			else
			{
				Starling.juggler.removeTweens(morebar);
				tween=new Tween(morebar,0.2,Transitions.EASE_OUT)
				tween.animate("x",966+target.width);
				Starling.juggler.add(tween);
				
			}
			//began
			
		}
		
		private function drawProfile():void
		{
			
			var savedata:SaveGame=FloxCommand.savegame;
			var gender:String=savedata.avatar.gender;
			
			var modelObj:Object={"Male":new Rectangle(0,0,270,797),
				"Female":new Rectangle(0,0,214,768)}
			var modelRec:Rectangle=modelObj[gender];
		
			basemodel=new Sprite();
			basemodel.x=modelRec.x;
			basemodel.y=modelRec.y;
			//addChild(basemodel);
			
			
			var modelAttr:Object=new Object();
			modelAttr.gender=gender;
			modelAttr.width=modelRec.width;
			modelAttr.height=modelRec.height;
			
			drawcom.drawCharacter(basemodel,modelAttr);
			drawcom.updateBaseModel("Hair");
			drawcom.updateBaseModel("Eyes");
			drawcom.updateBaseModel("Features");
			playerProfile();
			
			
		}
		private function playerProfile():void
		{
			player_icon=new Sprite();
			player_icon.name="Player";
			addChild(player_icon);
			drawcom.drawPlayerProfileIcon(player_icon,1,new Point(54,50));
			
			player_icon.addEventListener(TouchEvent.TOUCH,displayCharacterInfo);
			 
		}
		private function displayCharacterInfo(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			var ended:Touch=e.getTouch(target,TouchPhase.ENDED);
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			var currentScene:String=DataContainer.currentScene;
			if(hover)
			{
				Starling.juggler.removeTweens(player_icon);
				var tween:Tween=new Tween(player_icon,0.1,Transitions.LINEAR);
				tween.scaleTo(1);
				Starling.juggler.add(tween);
				
				
			}
			else
			{
				Starling.juggler.removeTweens(player_icon);
				tween=new Tween(player_icon,0.1,Transitions.LINEAR);
				tween.scaleTo(0.89);
				Starling.juggler.add(tween);
				
			}
			
			
			if(began)
			{
				var main_index:Number=currentScene.indexOf("MainScene");
				if(main_index==-1)
				{
					var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
				}
				
				var _data:Object=new Object();
				_data.name="MenuScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data)
			}
			//if
		}
		private function showCommandDirections():void
		{
			comDirView=new Sprite();
			comDirView.x=252;
			comDirView.y=45;
			var comdirTexture:Texture=Assets.getTexture("ComDirections");
			var comdir:Image=new Image(comdirTexture);
			comDirView.addChild(comdir);
			var msg:String="";
			comDirTxt=new TextField(530,59,msg,"Futura",20,0xFFFFFF);
			comDirTxt.x=15;
			comDirTxt.y=2;
			comDirTxt.hAlign="left";
			comDirView.addChild(comDirTxt);
			comDirView.visible=false;
			
			
			payApTxt=new TextField(80,40,"","Neogrey Medium",25,0xFFFFFF);
			payApTxt.hAlign="left"
			payApTxt.x=622;
			payApTxt.y=10;
			comDirView.addChild(payApTxt);
			
			addChild(comDirView);
			
		}
		private function onUpdateDirections(e:Event):void
		{
			
			
			var attr:String=e.data.content.split(" ").join("");
			
			DebugTrace.msg("GameInfobar.onUpdateDirections attr:"+attr);
			var commandData:Object=flox.getSyetemData("command");
			comDirView.visible=e.data.enabled;
			var currentscene:String=DataContainer.currentLabel;
			
			if(currentscene=="HotelScene" && attr=="Rest")
			{
				attr="PayRest";
			}
			else if(attr=="Work")
			{
				var _attr:String=currentscene.split("Scene").join("Work");
				attr=_attr;
			}
			else
			{
				if(attr=="Rest")
				{
					
					attr="FreeRest";
					
				}
			}
			
			 
			
			if(e.data.enabled)
			{
				
				var dec:String=commandData[attr].dec;
				var value:Number=Number(commandData[attr].ap);
				comDirTxt.text=dec;
				payApTxt.text=String(value);
				if(value>0)
				{
					payApTxt.text="+"+value;
				}
				
				
				comDirView.alpha=0;
				var tween:Tween=new Tween(comDirView,0.5,Transitions.EASE_OUT)
				tween.animate("alpha",1);
				tween.onComplete=onDirViewComplete;
				Starling.juggler.add(tween);
			}
			//if	
			
			
		}
		private function onDirViewComplete():void
		{
			Starling.juggler.removeTweens(comDirView)
			
			
			
		}
		private var dating_icon:Sprite;
		private function onUpdateDating(e:Event):void
		{
			var savegame:SaveGame=FloxCommand.savegame;
			if(savegame.dating)
			{
				dating_icon=new Sprite();
				dating_icon.x=151;
				dating_icon.y=50;
				addChild(dating_icon);
				var drawcom:DrawerInterface=new DrawManager();
				drawcom.drawCharacterProfileIcon(dating_icon,savegame.dating,0.45);
			}
			
		}
		private function onCancelDating(e:Event):void
		{
			removeChild(dating_icon);
			
		}
	}
}