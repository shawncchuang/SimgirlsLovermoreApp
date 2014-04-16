package controller
{
	import com.greensock.TweenLite;
	import com.shortybmc.data.parser.CSV;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.globalization.CurrencyFormatter;
	import flash.media.SoundChannel;
	import flash.net.URLRequest;
	import flash.text.TextFormat;
	import flash.utils.getDefinitionByName;
	
	import controller.Assets;
	
	import data.Config;
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.SaveGame;
	import model.SystemData;
	
	import services.LoaderRequest;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	import starling.utils.Color;
	
	import utils.DebugTrace;
	import utils.DrawManager;
	import utils.ViewsContainer;
	
	import views.FloxManagerView;
	
	
	
	public class MainCommand implements MainInterface
	{
		private var item:flash.display.MovieClip;
		private static var alertmsg:flash.display.MovieClip;
		private static var csv:CSV;
		private var talkcsv:CSV;
		private var ch_talk_csv:CSV;
		private var schedule_csv:CSV;
		private var loading:flash.display.MovieClip;
	 
		public function sceneDispatch(type:String,data:Object=null):void
		{
			var mainstage:Sprite=ViewsContainer.MainStage;
			mainstage.dispatchEvent(new SceneEvent(type,true,false,data));
		}
		public function topviewDispatch(type:String,data:Object=null):void
		{
			var target:Sprite=ViewsContainer.currentScene;
			target.dispatchEvent(new TopViewEvent(type,true,false,data));
		}
		public function addDisplayObj(current:String,target:String):void
		{
			var topview:flash.display.MovieClip=SimgirlsLovemore.topview;
			var txt:String="";
			var target_pos:String="";
			if(target.indexOf("_")!=-1)
			{
				if(target.split("_")[2]!=undefined)
				{
					target_pos="_"+target.split("_")[2];
				}
				txt=target.split("_")[1]+target_pos;
				target=target.split("_")[0];
			}
			var style:String=current+"_"+target;
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			//DebugTrace.msg("MainCommand.addDisplayObj style:"+style);
			DebugTrace.msg("MainCommand.addDisplayObj txt:"+txt);
			
			switch(target)
			{
				case "ComCloud":
					
					gameEvent.data=txt;
					gameEvent._name="comcloud";
					gameEvent.displayHandler()
					break				
			}
			switch(style)
			{
				/*
				case "TarotReading_ComCloud":
				case "AirportScene_ComCloud":
				gameEvent.data=txt;
				gameEvent._name="comcloud";
				gameEvent.displayHandler();
				break;*/
				case "TarotReading_QA":
				case "AirplaneScene_QA":
					gameEvent._name="QA";
					gameEvent.qa_label=txt;
					gameEvent.displayHandler();
					break
				case "TarotReading_TarotCards":
					gameEvent._name="tarot_cards";
					gameEvent.displayHandler();
					break
				
				
			}
			
		}
		public function addLoadind(msg:String):void
		{
			var topview:flash.display.MovieClip=SimgirlsLovemore.topview;	
			loading=new LoadingAni();
			loading.txt.text=msg;
			topview.addChild(loading);
			
		}
		public function removeLoading():void
		{
			var topview:flash.display.MovieClip=SimgirlsLovemore.topview;
			try
			{
				topview.removeChild(loading);
			}
			catch(e:Error)
			{
				DebugTrace.msg("Error MainCommand.removeLoading");
				
			}
		}
		
		public static function addAlertMsg(msg:String):void
		{
			
			var format:TextFormat=new TextFormat();
			format.size=20;
			format.align="center";
			var topview:flash.display.MovieClip=SimgirlsLovemore.topview;	
			alertmsg=new AlertMsgUI();
			alertmsg.msg.defaultTextFormat=format;
			alertmsg.confirm.buttonMode=true;
			alertmsg.cancelbtn.buttonMode=true;
			alertmsg.confirm.addEventListener(MouseEvent.CLICK,doColseAlertmsg);
			alertmsg.cancelbtn.addEventListener(MouseEvent.CLICK,doColseAlertmsg);
			alertmsg.x=1024/2;
			alertmsg.y=768/2;
			alertmsg.msg.text=msg;
			topview.addChild(alertmsg);
			
		}
		
		public static function addTalkingMsg(msg:String):void
		{
			
			var format:TextFormat=new TextFormat();
			format.align="left";
			var topview:flash.display.MovieClip=SimgirlsLovemore.topview;	
			alertmsg=new AlertTalkingUI();
			alertmsg.msg.defaultTextFormat=format;
			
			alertmsg.cancelbtn.addEventListener(MouseEvent.CLICK,doColseAlertmsg);
			alertmsg.x=1024/2;
			alertmsg.y=768/2;
			alertmsg.msg.text=msg;
			topview.addChild(alertmsg);
			
		}
		private static function doColseAlertmsg(e:MouseEvent):void
		{
			var topview:flash.display.MovieClip=SimgirlsLovemore.topview;	
			topview.removeChild(alertmsg);
		}
		public static function initPreOrderAccount():void
		{
			csv = new CSV();
			//csv.headerOverwrite = false
			//csv.header = ['Email'];
			
			csv.addEventListener( Event.COMPLETE, completePreOrderAccount );
			csv.load ( new URLRequest('csv/member_emails.csv') );
			
		}
		private static function completePreOrderAccount(e:Event):void
		{
			//var emails:Array=csv.header[0].split("\n");
			var emails:Array=csv.data;
			DebugTrace.msg("completeBlackPreasAccount:\n"+csv.data);
			Config.AccType="";
			if(emails.indexOf(FloxCommand.my_email)!=-1)
			{
				Config.AccType="blackspears";
			}
			//if
			/*var floxcom:FloxInterface=new FloxCommand();
			var _data:Object=new Object();
			_data.from=Config.AccType;
			floxcom.savePlayer(_data);*/
			if(emails.length>1)
			{
			DataContainer.MembersMail=emails;
			var floxMg:FloxManagerView=ViewsContainer.FloxManager;
			floxMg.currentAccount();
			}
		}
		/*public function initPlayerTalkLibrary(callback:Function=null):void
		{
		talkcsv=new CSV();
		talkcsv.addEventListener( Event.COMPLETE, onPlayerTalkLibraryComplete );
		talkcsv.load ( new URLRequest('csv/talklibrary_player.csv') );
		
		}*/
		private function onPlayerTalkLibraryComplete(e:Event):void
		{
			//var library:Array=e.target.header[0].split("\n");
			//trace(talkcsv.dump());
			
			var library:Array=talkcsv.data;
			for(var i:uint=0;i<library.length;i++)
			{
				var _header:Array=library[i];
				library[i] =filterTalking(_header);
			}
			//for
			DataContainer.playerTalklibrary=library;
		}
		public function initSceneLibrary():void
		{
			ch_talk_csv=new CSV();
			ch_talk_csv.addEventListener( Event.COMPLETE, onChTalkLibrary );
			ch_talk_csv.load(new URLRequest('csv/scenelibrary.csv'));
			
			
		}
		private function onChTalkLibrary(e:Event):void
		{
			//trace("onChTalkLibrary library:")
			DebugTrace.msg("MainCommand.onChTalkLibrary :"+ch_talk_csv.dump());
			
			var library:Array=ch_talk_csv.data;
			for(var i:uint=0;i<library.length;i++)
			{
				var _header:Array=library[i];
				library[i] =filterTalking(_header);
				
			}
			//for
			DataContainer.characterTalklibrary=library;
			initSchedule();
		}
		public function filterTalking(source:Array):Array
		{
			var sentances:Array=new Array();
			for(var i:uint=0;i<source.length;i++)
			{
				var re:String=source[i];
				if(re.charAt(0)=='"')
				{
					var _re:String=re.split('"').join("");
					source[i]=_re 
				}
				if(re.charAt(re.length-1)=='"')
				{
					_re=re.split('"').join("");
					source[i]=_re;
				}
				if(source[i]!="")
				{
					sentances.push(source[i]);
				}
			}
			
			return sentances;
		}
		public function initSchedule():void
		{
			schedule_csv=new CSV();
			schedule_csv.addEventListener(Event.COMPLETE,onScheduleComplete);
			schedule_csv.load(new URLRequest('csv/schedule.csv'));
			
			
		}
		private function onScheduleComplete(e:Event):void
		{
			DebugTrace.msg("MainCommand.onScheduleComplete :"+schedule_csv.dump());
			var schedlue:Array=schedule_csv.data;
			for(var i:uint=0;i<schedlue.length;i++)
			{
				
				var months:Array=schedlue[i];
				months.shift();
				schedlue[i]=months;
				//DebugTrace.msg(months.toString()+" ; length:"+months.length);
			}
			DataContainer.scheduleListbrary=schedlue;
			
			
			
			
		}
		public function playBackgroudSound(src:String):void
		{
			//DebugTrace.msg("playBackgroudSound:"+src);
			var assets:Assets=new Assets();
			assets.initMusicAssetsManager(src);
			
		}
		public function stopBackgroudSound():void
		{
			var sound_channel:SoundChannel=Assets.MusicChannel;
			try
			{
				sound_channel.stop();
			}
			catch(errot:Error)
			{
				DebugTrace.msg("none sound_channel")
			}
			
		}
		public function playSound(src:String):void
		{
			var assets:Assets=new Assets();
			assets.initSoundAssetsManager(src);
			
		}
		public  function dateManager(type:String):void
		{
			//start Tur.1.Mar.2022|12
			DebugTrace.msg("MainCommand.dateManager  type:"+type);
			var Days:Array=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
			var Months:Object={"Jan":31,"Feb":28,"Mar":31,"Apr":30,"May":31,"Jun":30,
				"Jul":31,"Aug":31,"Sep":30,"Oct":31,"Nov":30,"Dec":31}
			var Manthslist:Array=["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];
			var savegame:SaveGame=FloxCommand.savegame; 
			var dateStr:String=savegame.date;
			var dayStr:String=dateStr.split("|")[0];
			var _day:String=dayStr.split(".")[0];
			var _data_index:Number=Days.indexOf(_day);
			var _date:Number=Number(dayStr.split(".")[1]);
			var _de_month:String="";
			var _month:String=_de_month=dayStr.split(".")[2];
			var _year:Number=Number(dayStr.split(".")[3]);
			var timeNum:Number=Number(dateStr.split("|")[1]);
			var _type:String=type;
			if(type.indexOf("Stay")!=-1)
			{
				
				_type="Stay";
			}
			switch(_type)
			{
				case "Rest":
					timeNum+=12;
					
					if(timeNum>24)
					{
						// over day
						timeNum=12;
						_date++;
						_data_index++;
						//prase obsloete 
						praseOwnedAssets(1);
						
						reeseatDating();
					}
					//if
					new DataContainer().initChacacterLikeScene();
					break
				case "Stay":
					var stay_days:Number=Number(type.split("Stay").join(""));
					_date+=stay_days;
					_data_index+=stay_days;
					new DataContainer().initChacacterLikeScene();
					
					praseOwnedAssets(stay_days);
					reeseatDating();
					break
				
			}
			//switch
			DebugTrace.msg("MainCommand.dateManager  _data_index:"+_data_index);
			var month_index:uint=Manthslist.indexOf(_month);
			if(_data_index>=Days.length)
			{
				_data_index-=Days.length;
			}
			if(_date>Months[_month])
			{
				_date=1;
				
				month_index++;
				if(month_index>Manthslist.length-1)
				{
					//Cross Year
					month_index=0;
					_year++;
				}
				//if
				_month=Manthslist[month_index];
			}
			//if
			var dateIndex:Object={"date":_date-1,"month":month_index};
			DataContainer.currentDateIndex=dateIndex;
			var new_date:String=Days[_data_index]+"."+_date+"."+_month+"."+_year+"|"+timeNum;
			DebugTrace.msg("MainCommand.dateManager  new_date:"+new_date);
			var _data:Object=new Object();
			_data.date=new_date;
			var flox:FloxInterface=new FloxCommand();
			flox.updateSavegame(_data);
			var pay:Boolean=flox.getPlayerData("paid");
			if(!pay && _type!="Rest" && _type!="Stay")
			{
				//didn't pay this game
				var deadline:Number=Config.deadline;
				for(var k:uint=Manthslist.indexOf(_de_month);k<Manthslist.length;k++)
				{
					var monthdays:Number=Months[Manthslist[k]];
					//DebugTrace.msg("MainCommand.dateManager monthdays:"+monthdays);
					if(deadline>monthdays)
					{
						deadline-=monthdays;
						//DebugTrace.msg("MainCommand.dateManager pay_day:"+pay_day);
						var end_month:String=Manthslist[k];
						var end_date:Number=deadline;
					}
					else
					{
						end_month=_month;
						end_date=deadline;
						break
					}
					//if
				}
				//for
				DebugTrace.msg("MainCommand.dateManager  end_month:"+end_month+"; end_day:"+end_date);
				DebugTrace.msg("MainCommand.dateManager  _type:"+_type);
				if(Manthslist.indexOf(_month)>=Manthslist.indexOf(end_month) && _date>=end_date)
				{
					//deadline
					DataContainer.deadline=true;
					var mainstage:Sprite=ViewsContainer.MainStage;
					mainstage.broadcastEventWith("PAY_CHECK");
					
					
				}
				//if
			}
			//if
			
			
		}
		private function praseOwnedAssets(days:Number):void
		{
			var flox:FloxInterface=new FloxCommand();
			var ownedAssets:Object=flox.getSaveData("owned_assets");
			for(var ch:String in ownedAssets)
			{
				var assetslist:Array=ownedAssets[ch];
				if(ch!="player")
				{
					for(var i:uint=0;i<assetslist.length;i++)
					{
						
						if(assetslist[i].obsoleteIn>0)
						{
							var obs:Number=assetslist[i].obsoleteIn;
							obs-=days;
							assetslist[i].obsoleteIn=obs;
						}
						//if
						ownedAssets[ch]=assetslist;
					}
					//for
				}
				//if
			}
			//for
			
			for(var _ch:String in ownedAssets)
			{
				assetslist=ownedAssets[_ch];
				if(_ch!="player")
				{
					for(var j:uint=0;j<assetslist.length;j++)
					{
						obs=assetslist[j].obsoleteIn;
						if(obs<=0)
						{
							var _assetslist:Array=assetslist.splice(j);
							_assetslist.shift();
							var new_assetslist:Array=assetslist.concat(_assetslist);
							ownedAssets[_ch]=new_assetslist;
						}
						//if	
					}
					//for
				}
				//if
			}
			//for
			var assetesStr:String=JSON.stringify(ownedAssets);
			DebugTrace.msg("MainComanad.praseOwnedAssets assetesStr:"+assetesStr);
			var savegame:SaveGame=FloxCommand.savegame;
			savegame.owned_assets=ownedAssets;
			FloxCommand.savegame=savegame;
			 
		}
		public function filterScene(target:Sprite):void
		{
			//day night filter
			var currentScene:String=DataContainer.currentScene;
			var scene:Sprite=ViewsContainer.MainScene;
			//var scene_container:Sprite=scene.getChildByName("scene_container") as Sprite;
			var scene_container:Sprite=target;
			var savedata:SaveGame=FloxCommand.savegame;
			var dateStr:String=savedata.date.split("|")[1];
			DebugTrace.msg("MainCommand.filterScene currentScene:"+currentScene+" dateStr:"+dateStr);
			if(currentScene=="MainScene" && dateStr=="24")
			{
				var bg:starling.display.MovieClip=scene_container.getChildByName("bg") as starling.display.MovieClip;
				if(bg)
					bg.removeFromParent();
				//var night_bg:starling.display.MovieClip=Assets.getDynamicAtlas("MainSceneNight");
				var mapTextute:Texture=Assets.getTexture("MainSceneNight");
				var night_bg:Image=new Image(mapTextute);
				scene_container.addChild(night_bg);
			}
			else
			{
				if(dateStr=="24")
				{
					//night
					var nightSprtie:Sprite=new Sprite();
					nightSprtie.flatten();
					var maskTexture:Texture=Assets.getTexture("Whitebg")
					var nightmask:Image=new Image(maskTexture);
					nightmask.color=Color.BLACK;
					nightmask.width=scene_container.width;
					nightmask.height=scene_container.height;
					nightmask.alpha=0.5;
					nightSprtie.addChild(nightmask);
					scene_container.addChild(nightSprtie);
					
				}
			}
			
		}
		public function listArrowEnabled(index:Number,pages:Number,left:*,right:*):void
		{
			
			left.visible=true;
			right.visible=true;
			var end_node:Number=index;
			
			if(index<=0)
			{
				left.visible=false;
			}
			//if
			if(index==pages-1)
			{
				right.visible=false;
			}
			//if
			if(pages<=1)
			{
				left.visible=false;
				right.visible=false;
			}
			//if
		}
		public function setNowMood():void
		{
			/*      -1000
			angry  
			-500
			sad
			-250
			bored 
			-150
			nromal   0
			150
			happy
			250
			excited
			500
			blush
			1000
			
			*/
			
			var dating:String=DataContainer.currentDating;
			var savegame:SaveGame=FloxCommand.savegame;
			var mood:Number=Number(savegame.mood[dating]);
			//-150~150
			var ran:Number=150;
			var nowMood:Number=uint(Math.random()*(ran*2))+1-ran;
			savegame.mood[dating]=nowMood;
			FloxCommand.savegame=savegame;
			
			 
			 
			
		}
		public function updateRelationship(mood:Number):void
		{
			//stranger,new frined,good firned, close firned, girlfriend,lover, wiife
			var dating:String=DataContainer.currentDating;
			var savegame:SaveGame=FloxCommand.savegame;
			var relObj:Object=savegame.rel;
			var rel:String=relObj[dating];
			var ptsObj:Object=savegame.pts;
			var pts:Number=Number(ptsObj[dating]);
			pts+=mood;
			
			if(pts>9999)
			{
				pts=9999;
			}
			//if
			ptsObj[dating]=pts;
			if(pts<0)
			{
				rel="enemy";	
			}
			else if(pts>=0 && pts<=99)
			{
				rel="stranger";	
			}
			else if(pts>=100 && pts<=249)
			{
				rel="new frined";	
				
			}
			else if(pts>=250 && pts<=499)
			{
				rel="good frined";	
				
			}
			else if(pts>=500 && pts<=999)
			{
				rel="close firned";	
				
			}
			else if(pts>=1000 && pts<=2499)
			{
				rel="girlfirned";	
				
			}
			else if(pts>=2500 && pts<=4999)
			{
				rel="lover";	
				
			}
			else if(pts>=5000)
			{
				rel="wife";	
			}
			
			relObj[dating]=rel;
			savegame.rel=relObj;
			savegame.pts=ptsObj;
			FloxCommand.savegame=savegame;
			DebugTrace.msg("MainCommand.updateRelationship dating:"+dating+" ; pts:"+pts);
			
			
			
			
		}
		public function moodCalculator(item_id:String,dating:String):Number
		{
			var systemdata:SystemData=FloxCommand.systemdata;
			var sysAssets:Object=systemdata.assets;
			var savedata:SaveGame=FloxCommand.savegame;
			var pst:Number=Number(savedata.pts[dating]);
			//var assetes:Object=savedata.assets;
			//var item:Object=assetes[item_id];
			var price:Number=sysAssets[item_id].price;
			var rating:Number=searchAssetRating(item_id);
			var time_rating:Number=100;
			var mood:Number=price*(Math.floor(rating/100*5+time_rating/100*2))+Math.floor(pst/500);
			DebugTrace.msg("MainCommand.moodCalculator mood:"+mood);
			
			return mood
		}
		public function searchAssetRating(item_id:String):Number
		{
			var flox:FloxInterface=new FloxCommand();
			var rating:Number;
			var assets:Array=flox.getSaveData("assets");
			for(var i:uint=0;i<assets.length;i++)
			{
				if(assets[i].id==item_id)
				{
					var assets_item:Object=assets[i];
					rating=Number(assets_item.rating);
					break;
				}
				//if
			}
			//for
			
			return rating;
		}
		//private var valueSprite:Sprite;
		private var apSprite:Sprite;
		private var cashSprite:Sprite;
		private var imageSprite:Sprite;
		private var intSprite:Sprite;
		public function displayUpdateValue(target:Sprite,_data:Object):void
		{
			//valueSprite=target;
			var attrlist:Array=_data.attr.split(",");
			var valuelist:Array=_data.values.split(",");
			var stageCW:Number=Starling.current.stage.stageWidth/2;
			var stageCH:Number=Starling.current.stage.stageHeight/2;
			
			var font:String="Futura";
			for(var i:uint=0;i<attrlist.length;i++)
			{
				var attr:String=attrlist[i];
				var value:String=valuelist[i];
				var posY:Number=i*50;
				switch(attr)
				{
					case "ap":
						apSprite=new Sprite();
						var apTexture:Texture=Assets.getTexture("ApIcon");
						var apImg:Image=new Image(apTexture);
						apImg.smoothing=TextureSmoothing.TRILINEAR;
						
						var aptxt:TextField=new TextField(100,apImg.height,value,font,30,0xFFFFFF);
						aptxt.hAlign="left";
						aptxt.vAlign="center";
						aptxt.x=apImg.width;
						aptxt.y=5;
						apSprite.addChild(apImg);
						apSprite.addChild(aptxt);
						target.addChild(apSprite);
						
						apSprite.pivotX=apSprite.width/2;
						apSprite.pivotY=apSprite.height/2;
						apSprite.x=stageCW;
						apSprite.y=stageCH-posY;
						
						
						tweenHandler(i,apSprite,apSprite.y-50,onAPValueTweenComplete);
						break
					case  "cash":
						var cf:CurrencyFormatter = new CurrencyFormatter("en_US"); 
						
						cashSprite=new Sprite();
						var signTexure:Texture=Assets.getTexture("Cashsign");
						var sign:Image=new Image(signTexure);
						sign.smoothing=TextureSmoothing.TRILINEAR;
						var cashtxt:TextField=new TextField(100,signTexure.height,value,font,30,0xFFFFFF);
						cashtxt.autoSize="left";
						cashtxt.autoScale=true;
						cashtxt.hAlign="left";
						cashtxt.vAlign="center";
						cashtxt.x=sign.width;
						cashtxt.y=5;
						cashSprite.addChild(sign);
						cashSprite.addChild(cashtxt);
						target.addChild(cashSprite);
						
						cashSprite.pivotX=cashSprite.width/2;
						cashSprite.pivotY=cashSprite.height/2;
						cashSprite.x=stageCW;
						cashSprite.y=stageCH-posY;
						
						
						tweenHandler(i,cashSprite,cashSprite.y-50,onCashValueTweenComplete);
						break
					case "image":
						imageSprite=new Sprite();
						var appTexure:Texture=Assets.getTexture("Appearance");
						var app_sign:Image=new Image(appTexure);
						var imagetxt:TextField=new TextField(100,40,value,font,30,0xFFFFFF);
						imagetxt.vAlign="center";
						//imagetxt.autoSize="left";
						imagetxt.x=app_sign.width-20;
						imagetxt.y=5;
						imageSprite.addChild(app_sign);
						imageSprite.addChild(imagetxt);
						target.addChild(imageSprite);
						
						imageSprite.pivotX=imageSprite.width/2;
						imageSprite.pivotY=imageSprite.height/2;
						imageSprite.x=stageCW;
						imageSprite.y=stageCH-posY;
						
						
						tweenHandler(i,imageSprite,imageSprite.y-50,onImgValueTweenComplete);
						
						break
					case "int":
						//Intelligence
						intSprite=new Sprite();
						var intTexure:Texture=Assets.getTexture("Intelligence");
						var int_sign:Image=new Image(intTexure);
						var inttxt:TextField=new TextField(100,40,value,font,30,0xFFFFFF);
						inttxt.vAlign="center";
						//inttxt.autoSize="left";
						inttxt.x=int_sign.width-20;
						intSprite.addChild(int_sign);
						intSprite.addChild(inttxt);
						target.addChild(intSprite);
						
						intSprite.pivotX=intSprite.width/2;
						intSprite.pivotY=intSprite.height/2;
						intSprite.x=stageCW;
						intSprite.y=stageCH-posY;
						
						tweenHandler(i,intSprite,intSprite.y-50,onIntValueTweenComplete);
						break
					
				}
				//switch
				
				
			}
			//for			
			
		}
		private function tweenHandler(index:Number,target:Sprite,value:Number,complete:Function):void
		{
			
			var tween:Tween=new Tween(target,1,Transitions.EASE_OUT_BACK);
			tween.delay=index*0.2;
			tween.animate("y",value);
			//tween.animate("alpha",0.8);
			tween.scaleTo(1.5);
			tween.onComplete=complete
			Starling.juggler.add(tween);	
		}
		private function onAPValueTweenComplete():void
		{
			Starling.juggler.removeTweens(apSprite);
			//valueSprite.removeChild(apSprite);
			apSprite.removeFromParent();
			apSprite=null
		}
		private function onCashValueTweenComplete():void
		{
			Starling.juggler.removeTweens(cashSprite);
			//valueSprite.removeChild(cashSprite);
			cashSprite.removeFromParent();
			cashSprite=null
		}
		private function onImgValueTweenComplete():void
		{
			Starling.juggler.removeTweens(imageSprite);
			//valueSprite.removeChild(imageSprite);
			imageSprite.removeFromParent();
			imageSprite=null
			
		}
		private function onIntValueTweenComplete():void
		{
			Starling.juggler.removeTweens(intSprite);
			//valueSprite.removeChild(intSprite);
			intSprite.removeFromParent();
			intSprite=null
		}
		private var cancelbtn:Image;
		private var cancelOverTex:Texture;
		private var cancelUpTex:Texture;
		private var confirmbtn:Image;
		private var confirmOverTex:Texture;
		private var confirmUpTex:Texture;
		private var onTouchCancelBegan:Function;
		private var onTouchConfirmBegan:Function;
		public function addedConfirmButton(target:Sprite,callback:Function,pos:Point=null):void
		{
			onTouchConfirmBegan=callback;
			confirmOverTex=Assets.getTexture("CheckAltOver");
			confirmUpTex=Assets.getTexture("CheckAltUp");
			confirmbtn=new Image(confirmUpTex);
			confirmbtn.useHandCursor=true;
			confirmbtn.name="confirm";
			confirmbtn.pivotX=confirmbtn.width/2;
			confirmbtn.pivotY=confirmbtn.height/2;
			if(!pos)
			{
				confirmbtn.x=904;
				confirmbtn.y=717;
			}
			else
			{
				confirmbtn.x=pos.x;
				confirmbtn.y=pos.y;
			}
			confirmbtn.addEventListener(TouchEvent.TOUCH,onTouchConfirm);
			target.addChild(confirmbtn);
		}
		private function onTouchConfirm(e:TouchEvent):void
		{
			var target:Image=e.currentTarget as Image;
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			if(began)
			{
				
				try
				{
					onTouchConfirmBegan(e);
				}
				catch(e:Error)
				{
					onTouchConfirmBegan();
				}
				//try...catch
				
			}
			//if
			if(hover)
			{
				
				confirmbtn.texture=confirmOverTex;
			}
			else
			{
				confirmbtn.texture=confirmUpTex;
			}
			//if
		}
		public function addedCancelButton(target:Sprite,callback:Function,pos:Point=null):void
		{
			
			onTouchCancelBegan=callback;
			cancelOverTex=Assets.getTexture("XAltOver");
			cancelUpTex=Assets.getTexture("XAltUp");
			cancelbtn=new Image(cancelUpTex);
			cancelbtn.useHandCursor=true;
			cancelbtn.name="cancel";
			cancelbtn.pivotX=cancelbtn.width/2;
			cancelbtn.pivotY=cancelbtn.height/2;
			if(!pos)
			{
				cancelbtn.x=970;
				cancelbtn.y=717;
			}
			else
			{
				cancelbtn.x=pos.x;
				cancelbtn.y=pos.y;
			}
			//if
			cancelbtn.addEventListener(TouchEvent.TOUCH,onTouchCancel);
			target.addChild(cancelbtn);
		}
		private function onTouchCancel(e:TouchEvent):void
		{
			var target:Image=e.currentTarget as Image;
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			if(began)
			{
				
				
				try
				{
					onTouchCancelBegan(e);
				}
				catch(e:Error)
				{
					onTouchCancelBegan();
				}
				//try...catch
				
			}
			//if
			if(hover)
			{
				
				cancelbtn.texture=cancelOverTex;
			}
			else
			{
				cancelbtn.texture=cancelUpTex;
			}
			//if
		}
		public function doRest(free:Boolean):void
		{
			var flox:FloxInterface=new FloxCommand();
			var command:MainInterface=new MainCommand();
			var ap:Number=flox.getSaveData("ap");
			var cash:Number=flox.getSaveData("cash");
			var sysCommad:Object=flox.getSyetemData("command");
			var _data:Object=new Object();
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			gameEvent._name="rest_animation";
			gameEvent.displayHandler();
			if(free)
			{
				var restObj:Object=sysCommad.FreeRest;
			}
			else
			{
				
				restObj=sysCommad.PayRest;
				_data.cash=cash+restObj.values.cash;
			}
			//if
			copyPlayerAndCharacter();
			
			var getAP:Number=restObj.ap;
			_data.ap=ap+getAP;
			DebugTrace.msg("MainCpmmand.doRest getAP:"+getAP);
			flox.updateSavegame(_data);
			command.dateManager("Rest");
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("UPDATE_INFO",false);
			
			
			
		}
		public function doStay(days:Number):void
		{
			
			var flox:FloxInterface=new FloxCommand();
			var command:MainInterface=new MainCommand();
			var ap:Number=flox.getSaveData("ap");
			var cash:Number=flox.getSaveData("cash");
			var sysCommad:Object=flox.getSyetemData("command");
			
			
			
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			gameEvent._name="stay_animation";
			gameEvent.displayHandler();
			copyPlayerAndCharacter();
			
			var restObj:Object=sysCommad.Stay;
			var getAP:Number=restObj.ap;
			var value:Number=restObj.values.cash;
			//DebugTrace.msg("MainComnad.doStay days:"+days+" ; value:"+value);
			
			var pay:Number=value*days;
			var _data:Object=new Object();
			_data.cash=cash+pay;
			_data.ap=ap+getAP;
			flox.updateSavegame(_data);
			command.dateManager("Stay"+days);
			
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("UPDATE_INFO",false);
			
			
			
		}
		public function doTrain():void
		{
			
			
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			gameEvent._name="train_animation";
			gameEvent.displayHandler();
			copyPlayerAndCharacter();
			
			//var command:MainInterface=new MainCommand();
			var savegame:SaveGame=new SaveGame();
			var flox:FloxInterface=new FloxCommand();
			var sysCommand:Object=flox.getSyetemData("command");
			
			var cash_pay:Number=sysCommand.Train.values.cash;
			var ap_pay:Number=sysCommand.Train.values.ap;
			var cash:Number=flox.getSaveData("cash");
			var ap:Number=flox.getSaveData("ap");
			var image:Number=flox.getSaveData("image");
			
			var _data:Object=new Object();
			_data.ap=ap+ap_pay;
			_data.cash=cash+cash_pay;
			var new_image:Number=Number(uint(Math.random()*6)+image);
			//DebugTrace.msg("MainCommand.doTrain new_image:"+new_image);
			if(savegame.dating)
			{
				new_image+=Math.floor(new_image*0.5);
			}
			
			_data.image=image+new_image;
			flox.updateSavegame(_data);
			
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("UPDATE_INFO",false);
			
			
			
		}
		public function doWork(income:Number):void
		{
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			gameEvent._name="working_animation";
			gameEvent.displayHandler();
			copyPlayerAndCharacter();
			
			var scene:String=DataContainer.currentScene;
			var attr:String=scene.split("Scene").join("Work");
			var savegame:SaveGame=FloxCommand.savegame;
			var flox:FloxInterface=new FloxCommand();
			var sysCommand:Object=flox.getSyetemData("command");
			var ap_pay:Number=sysCommand[attr].values.ap;
			var cash:Number=flox.getSaveData("cash");
			var ap:Number=flox.getSaveData("ap");
			var image:Number=flox.getSaveData("image");
			if(savegame.dating)
			{
				
				income+=Math.floor(income*0.5);
			}
			
			var _data:Object=new Object();
			_data.ap=ap+ap_pay;
			_data.cash=cash+income;
			//DebugTrace.msg("MainCommand.doWork income:"+income+" ; image:"+image);
			flox.updateSavegame(_data);
			
			var gameinfo:Sprite=ViewsContainer.gameinfo	
			gameinfo.dispatchEventWith("UPDATE_INFO");
			
			
		}
		public function doLearn(increaseINT:Number):void
		{
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			gameEvent._name="learning_animation";
			gameEvent.displayHandler();
			copyPlayerAndCharacter();
			
			var savegame:SaveGame=FloxCommand.savegame;
			var flox:FloxInterface=new FloxCommand();
			var sysCommand:Object=flox.getSyetemData("command");
			var ap_pay:Number=sysCommand.Learn.values.ap;
			var cash_pay:Number=sysCommand.Learn.values.cash;
			var cash:Number=flox.getSaveData("cash");
			var ap:Number=flox.getSaveData("ap");
			var intObj:Object=flox.getSaveData("int");
			if(savegame.dating)
			{
				
				increaseINT+=Math.floor(increaseINT*0.5);
			}
			
			var _data:Object=new Object();
			_data.ap=ap+ap_pay;
			_data.cash=cash+cash_pay;
			
			//DebugTrace.msg("MuseumScene.doTopViewDispatch reInt:"+reInt);
			intObj.player+=increaseINT;
			_data.int=intObj;
			flox.updateSavegame(_data);
			
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("UPDATE_INFO");
			
			
		}
		public function doMeditate():void
		{
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			gameEvent._name="meditate_animation";
			gameEvent.displayHandler();
			copyPlayerAndCharacter();
			
			
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("UPDATE_INFO");
			
		}
		public function showCommandValues(target:Sprite,attr:String, values:Object=null):void
		{
			var flox:FloxInterface=new FloxCommand();
			var sysCommad:Object=flox.getSyetemData("command");
			var sysValues:Object=sysCommad[attr].values;
			var command:MainInterface=new MainCommand();
			var attrlist:Array=new Array();
			var valueslist:Array=new Array();
			if(values)
			{
				sysValues=values;
			}
			for(var i:String in sysValues)
			{
				attrlist.push(i);
				if(sysValues[i]>0)
				{
					var valueStr:String="+"+sysValues[i];
				}
				else
				{
					valueStr=String(sysValues[i]);
				}
				valueslist.push(valueStr);
				
			}
			//for
			var value_data:Object=new Object();
			value_data.attr=attrlist.toString();
			value_data.values=valueslist.toString();
			command.displayUpdateValue(target,value_data);
			
		}
		private function reeseatDating():void
		{
			var savegame:SaveGame=FloxCommand.savegame;
			savegame.dating=null;
			FloxCommand.savegame=savegame;
			
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("CANCEL_DATING");
		}
		private var playerBitmap:Bitmap;
		private var playerTween:TweenLite;
		
		private var character:flash.display.MovieClip;
		private var chTween:TweenLite;
		public function copyPlayerAndCharacter():void
		{
			
			var savedata:SaveGame=FloxCommand.savegame;
			var gender:String=savedata.avatar.gender;
			var dating:String=savedata.dating;
			var modelObj:Object={"Male":new Rectangle(0,0,378,1117),
				"Female":new Rectangle(0,0,288,1034)};
			var pos:Point=new Point(44,58);
			if(gender=="Female")
			{
				pos=new Point(80,120);
			}
			var modelRec:Rectangle=modelObj[gender];
			
			var basemodel:Sprite=new Sprite();
			basemodel.x=modelRec.x;
			basemodel.y=modelRec.y;
			
			
			var modelAttr:Object=new Object();
			modelAttr.gender=gender;
			modelAttr.width=modelRec.width;
			modelAttr.height=modelRec.height;
			
			var drawcom:DrawerInterface=new DrawManager();
			drawcom.drawCharacter(basemodel,modelAttr);
			drawcom.updateBaseModel("Hair");
			drawcom.updateBaseModel("Eyes");
			drawcom.updateBaseModel("Pants");
			drawcom.updateBaseModel("Clothes");
			drawcom.updateBaseModel("Features");
			
			var bitmapdata:BitmapData=drawcom.copyAsBitmapData(basemodel,new Rectangle(0,0,basemodel.width,basemodel.height),new Point(0,-50)); 
			var bmp:BitmapData=new BitmapData(basemodel.width,basemodel.height);
			bmp.copyPixels(bitmapdata,new Rectangle(0,0,basemodel.width,basemodel.height),new Point(0,0));
			
			playerBitmap=new Bitmap(bmp);
			playerBitmap.name="player"
			playerBitmap.x=-100;
			playerBitmap.y=pos.y;
			playerBitmap.alpha=0;
			playerTween=new TweenLite(playerBitmap,0.5,{"alpha":1,"x":pos.x,onComplete:onShowed});
			SimgirlsLovemore.topview.addChild(playerBitmap);
			
			if(dating)
			{
				var container:Object={"lenus":new Lenus(),"sirena":new Sirena(),"dea":new Dea(),"sao":new Sao()
					,"klaire":new Klaire(),"tomoru":new Tomoru(),"ceil":new Ceil(),"zack":new Zack()};
				character=container[dating];
				character.x=1300;
				character.alpha=0;
				chTween=new TweenLite(character,0.5,{"alpha":1,"x":550,onComplete:onShowed});
				SimgirlsLovemore.topview.addChild(character);
				
			}
			/*var profileTexture:Texture = Texture.fromBitmapData(bmp);
			var _player_icon:Sprite=new Sprite();
			_player_icon.name="Player";
			var img:Image=new Image(profileTexture);
			img.smoothing=TextureSmoothing.TRILINEAR;
			var mainStage:Sprite=ViewsContainer.MainStage;*/
			//mainStage.addChild(basemodel);
			
			//mainStage.addChild(img);
		}
		private function onShowed():void
		{
			playerTween.kill();
			
		}
		public function clearCopyPixel():void
		{
			//DebugTrace.msg("ManCommand.clearCopyPixel")
			SimgirlsLovemore.topview.removeChild(playerBitmap);
			try
			{
				SimgirlsLovemore.topview.removeChild(character);
			}
			catch(err:Error)
			{
				DebugTrace.msg("ManCommand.clearCopyPixel character NULL !");
			}
			
		}
	}
}