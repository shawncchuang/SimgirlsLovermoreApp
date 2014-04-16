package views
{
	
	
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.SaveGame;
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	public class HotelScene extends Scenes
	{
		private var speaker_sprite:Sprite;
		private var command:MainInterface=new MainCommand();
		private var button:Button;
		private var scencom:SceneInterface=new SceneCommnad();
		private var flox:FloxInterface=new FloxCommand(); 
		
		private var animation:String="stay_animation";
		private var type:String;
		private var options:Sprite=null;
		private var success:Boolean=false;
		private var pay:Number=0;
		private var getAP:Number=0;
		private var checkAlt:Image;
		private var checkOverTex:Texture;
		private var checkUpTex:Texture;
		private var days:Number=1;
		public function HotelScene()
		{
			/*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
			button=new Button(pointbgTexture);
			addChild(button);
			button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
			ViewsContainer.currentScene=this;
			this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
			speaker_sprite=new Sprite();
			addChild(speaker_sprite);
			speaker_sprite.flatten();
			init();
		}
		private function init():void
		{
			days=1;
			scencom.init("HotelScene",speaker_sprite,6,onCallBack);
			scencom.start();
			scencom.disableAll();
		}
		private function onCallBack():void
		{
			
			
		}
		private function onSceneTriggered(e:Event):void
		{
			
			button.visible=false;
			command.sceneDispatch(SceneEvent.CLEARED);
			
			
			var tween:Tween=new Tween(this,1);
			tween.onComplete=onClearComplete;
			Starling.juggler.add(tween);
			
			
		}
		private function doTopViewDispatch(e:TopViewEvent):void
		{
			DebugTrace.msg("HotelScene.doTopViewDispatch removed:"+e.data.removed);
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			
			var _data:Object=new Object();
			var sysCommand:Object=flox.getSyetemData("command");
			switch(e.data.removed)
			{
				case "Leave":
					gameEvent._name="clear_comcloud";
					gameEvent.displayHandler();
					_data.name="MainScene";
					command.sceneDispatch(SceneEvent.CHANGED,_data);
					break
				case "Rest":
				case "Stay":
					
					userHotelPermit(e.data.removed);
					break
				case "ani_complete":
					
					if(type=="Rest")
					{
						var attr:String="PayRest";
						command.showCommandValues(this,attr);
					}
					else
					{
						attr="Stay";
						var values:Object=sysCommand.Stay.values;
						//var pay:Number=values.cash*days;
						//DebugTrace.msg("HotelScene.doTopViewDispatch cash:"+values.cash+"; pay:"+pay);
						for(var i:String in values)
						{
							_data[i]=values[i];
						}
						_data.cash=pay;
						command.showCommandValues(this,attr,_data);
					}
					command.dateManager("deadline")
					var deadline:Boolean=DataContainer.deadline;
					if(!deadline)
					{
						init();
					}
					break
				case "restart":
					init();
					break
				case "ani_complete_clear_character":
					command.clearCopyPixel();
					break
				
			}
			
		}
		private function userHotelPermit(value:String):void
		{
			type=value;
			
			var cash:Number=flox.getSaveData("cash");
			var sysCommand:Object=flox.getSyetemData("command");
			
			success=false;
			
			DebugTrace.msg("HotelScene.userHotelPermit cash:"+cash);
			if(type=="Rest")
			{
				var payRest:Object=sysCommand.PayRest;
				
				getAP=payRest.values.ap;
				pay=payRest.values.cash;	
				animation="rest_animation";
				commitCommand();
			}else if(type=="Stay")
			{
				var stayObj:Object=sysCommand.Stay;
				getAP=stayObj.values.ap;
				pay=stayObj.values.cash;
				animation="stay_animation";
				success=false;
				stayOptions();
				
			}
			
		}
		private function stayOptions():void
		{
			
			options=new Sprite();
			//options.x=347;
			//options.y=159;
			addChild(options);
			
			/*var bgTexture:Texture=Assets.getTexture("AlertMsgBg");		
			var bgImg:Image=new Image(bgTexture);
			bgImg.pivotX=bgImg.width/2;
			bgImg.pivotY=bgImg.height/2;
			options.addChild(bgImg);*/
			
			
			for(var i:uint=0;i<5;i++)
			{
				var btnTexture:Texture=Assets.getTexture("OptionBg");	
				var value:Number=(i+1);
				var txt:String
				if(value<1)
				{
					txt=value+" Day";
				}
				else
				{
					txt=value+" Days";
				}
				var btn:Button=new Button(btnTexture,txt);
				btn.fontName="Neogrey Medium";
				btn.fontColor=0xFFFFFF;
				btn.fontSize=25;
				btn.name="day"+value;
				btn.x=347; 
				btn.y=159+i*100;
				btn.addEventListener(Event.TRIGGERED,onTriggeredDays);
				options.addChild(btn);
				
				checkUpTex=Assets.getTexture("CheckAltUp");	
				checkOverTex=Assets.getTexture("CheckAltOver");	
				checkAlt=new Image(checkUpTex);
				checkAlt.name="day"+value;
				checkAlt.useHandCursor=true;
				checkAlt.pivotX=checkAlt.width/2;
				checkAlt.pivotY=checkAlt.height/2;
				checkAlt.x=647;
				checkAlt.y=197+i*100;
				checkAlt.addEventListener(TouchEvent.TOUCH,onTouchCheckAlt);
				options.addChild(checkAlt);
			}
			//for
			
			
			
			//added cancel button
			command.addedCancelButton(options,onColseStayFrame);
			
			
			options.alpha=0;
			var tween:Tween=new Tween(options,0.5,Transitions.EASE_OUT_ELASTIC);
			tween.animate("alpha",1);
			tween.onComplete=onOptaionPanelFadeIn;
			Starling.juggler.add(tween);
			
		}
		private function onOptaionPanelFadeIn():void
		{
			Starling.juggler.removeTweens(options);
			
		}
		private function onTriggeredDays(e:Event):void
		{
			
			var target:Button=e.currentTarget as Button;
			DebugTrace.msg("HotelScene.onTriggeredDays: "+target.name);
			selectedOption(target.name);
			
			
			
		}
		private function onTouchCheckAlt(e:TouchEvent):void
		{
			var target:Image=e.currentTarget as Image;
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			if(began)
			{
				selectedOption(target.name);
			}
			//if
			if(hover)
			{
				
				target.texture=checkOverTex;
			}
			else
			{
				target.texture=checkUpTex;
			}
			//if
			
		}
		private function selectedOption(src:String):void
		{
			var sysCommand:Object=flox.getSyetemData("command");
			var values:Object=sysCommand.Stay.values;
			 
			days=Number(src.split("day").join(""));
			pay=days*values.cash;
			DebugTrace.msg("HotelScene.selectedOption pay:"+pay+" ; values.cash"+values.cash);
			type="Stay"+days;
			commitCommand();
			
		}
		private function onColseStayFrame():void
		{
			
			removeStayOption();
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			
			var _data:Object=new Object();
			_data.removed="restart";
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
			
			
		}
		
		private function commitCommand():void
		{
			var savegame:SaveGame=FloxCommand.savegame;
			var cash:Number=savegame.cash;
			
			if(cash>=Math.abs(pay))
			{
				success=true;
			}
			else
			{
				var msg:String="Sorry,you don't have enough chash.";
				var alert:AlertMessage=new AlertMessage(msg,onClosedAlert);
				addChild(alert);
				
				if(options)
				{
					removeStayOption();
				}
				
				
			}
			//if
			
			if(success)
			{
				if(options)
				{
					removeStayOption();
				}
				
				if(type=="Rest")
				{
					
					command.doRest(false);
					
				}
				else
				{
					//Stay
					command.doStay(days);
				}
				//if
				
				/*
				var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				gameEvent._name=animation;
				gameEvent.displayHandler();
				var _data:Object=new Object();
				_data.ap=savegame.ap+getAP;
				_data.cash=savegame.cash-pay;
				floxcom.updateSavegame(_data);
				command.dateManager(type);
				
				var gameinfo:Sprite=ViewsContainer.gameinfo;
				gameinfo.dispatchEventWith("UPDATE_INFO");
				*/
				
			}
			//if
			
		}
		private function onClearComplete():void
		{
			Starling.juggler.removeTweens(this);
			var _data:Object=new Object();
			_data.name= "MainScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}
		private function onClosedAlert():void
		{
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			
			init();
			
		}
		private function removeStayOption():void
		{
			
			
			options.removeFromParent();
			//removeChild(options);
			options=null;
			
		}
	}
}