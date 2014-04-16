package views
{
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.DataContainer;
	
	import events.GameEvent;
	import events.TopViewEvent;
	
	import model.SaveGame;
	
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	
	public class SaveandLoadList extends Sprite
	{
		private var _type:String;
		private var panel:Sprite;
		private var emptypos:Array=[new Point(-150,-164),new Point(-150,-53),new Point(-150,58)];
		private var flox:FloxInterface=new FloxCommand();
		private var empty_max:Number=0;
		private var empty_index:Number=0;
		private var progressbar:Array=new Array();
		private var buffer:LoadingBuffer;
		private var command:MainInterface=new MainCommand();
		private var comfirm:Sprite;
		private var _data:Object=new Object();
		private var playerData:Object;
		private var msg:String="";
		private var save_new:Boolean=false;
		public function SaveandLoadList(type:String)
		{
			
			_type=type;
			DataContainer.SaveRecord=new Array();
			DebugTrace.msg("SaveandLoadList type:"+type);
			
			
			var current_savedstr:String=flox.getPlayerData("saved");
			DebugTrace.msg("SaveandLoadList current_savedstr:"+current_savedstr);
			var current_saved:Array=current_savedstr.split(",");
			
			DebugTrace.msg("SaveandLoadList current_saved:"+current_saved);
			if(current_saved.length>0)
			{
				FloxCommand.onLoadComplete=onLoadCompleteToInit;
				flox.loadSavedEntities();
				addBuffer()
			}
			else
			{
				init();
			}
			
		}
		
		private function onLoadCompleteToInit():void
		{
			
			removeChild(buffer);
			init();
			
		}
		private function init():void
		{
			var paid:Boolean=flox.getPlayerData("paid");
			panel=new Sprite();
			addChild(panel);
			renderBackground();
			renderSavedbar();
			if(paid)
			{
				renderEmpty();
			}
			renderCloseButton();
			
		}
		private function renderBackground():void
		{
			
			var bgtexture:Texture=Assets.getTexture("departureListbg");
			var bgImg:Image=new Image(bgtexture);
			bgImg.pivotX=bgImg.width/2;
			bgImg.pivotY=bgImg.height/2;
			
			panel.addChild(bgImg);
			
			
		}
		private function renderSavedbar():void
		{
			var saverecord:Array=DataContainer.SaveRecord;
			empty_max=3-saverecord.length;
			var inGameProgress:Number=flox.getPlayerData("inGameProgress");
			var savedata:SaveGame=FloxCommand.savegame;
			
			DebugTrace.msg("SaveandLoadList.renderSavedbar saverecord:"+saverecord.length)
			if(_type=="Arrivals" || _type=="Arrived")
			{
				var title:String="Load Game";
			}
			else
			{
				title="Save Game";
			}
			var title_txt:TextField=new TextField(panel.width,35,"< "+title+" >","Eras Demi ITC",20,0xFFFFFF);
			title_txt.x=-(panel.width/2);
			title_txt.y=-(panel.height/2)+title_txt.height;
			title_txt.vAlign="center";
			panel.addChild(title_txt);
			
			for(var i:uint=0;i<saverecord.length;i++)
			{
				
				empty_index++;
				var emptybar:Sprite=new Sprite();
				emptybar.useHandCursor=true;
				emptybar.name="savedbar"+i;
				emptybar.x=emptypos[i].x;
				emptybar.y=emptypos[i].y;
				progressbar.push(emptybar);
				
				var empty_texture:Texture=Assets.getTexture("Empty");
				var emptyImg:Image=new Image(empty_texture);
				emptybar.addChild(emptyImg);
				
				var name_txt:TextField=new TextField(70,emptyImg.height,saverecord[i].first_name+"\n"+saverecord[i].last_name,"Eras Demi ITC",20,0xFFFFFF);
				emptybar.addChild(name_txt);
				var _date:String=saverecord[i].date.split("|")[0];
				var info_data:String=_date+"\n"+saverecord[i].cash+"\nAP "+saverecord[i].ap+"/"+saverecord[i].max_ap;
				var info_txt:TextField=new TextField(emptyImg.width-50,emptyImg.height,info_data,"Eras Demi ITC",20,0xFFFFFF);
				info_txt.hAlign="right";
				info_txt.vAlign="center";
				emptybar.addChild(info_txt);
				
				//DebugTrace.msg("SaveandLoadList.renderSavedbar info_data:"+info_data)
				
				var check_texture:Texture=Assets.getTexture("CheckAlt");	
				var check_icon:Image=new Image(check_texture);
				
				//var check_btn:Button=new Button(check_texture);
				check_icon.x=emptyImg.width-check_icon.width-10;
				check_icon.y=emptyImg.height/2-check_icon.height/2;
				emptybar.addChild(check_icon);
				emptybar.addEventListener(TouchEvent.TOUCH,doSaveLoadListTouched);
				panel.addChild(emptybar);
			}
			//for
		}
		private function renderEmpty():void
		{
			DebugTrace.msg("SaveandLoadList.renderEmpty empty_index:"+empty_index+" ;empty_max:"+empty_max)
			var saverecord:Array=DataContainer.SaveRecord;
			var recods:uint=saverecord.length;
			var emptybars:Array=new Array();
			for(var i:uint=0;i<empty_max;i++)
			{
				var empty_texture:Texture=Assets.getTexture("Empty");
				var emptybar:Sprite=new Sprite();
				emptybar.name="emptybar"+(i+recods);
				progressbar.push(emptybar);
				
				var emptyImg:Image=new Image(empty_texture);
				var txt:TextField=new TextField(emptyImg.width,emptyImg.height,"Empty","Eras Demi ITC",20,0xFFFFFF);
				txt.hAlign="center";
				emptybar.x=emptypos[i+recods].x;
				emptybar.y=emptypos[i+recods].y;
				emptybar.addChild(emptyImg);
				emptybar.addChild(txt);
				panel.addChild(emptybar);
				emptybars.push(emptybar);
				emptybar.addEventListener(TouchEvent.TOUCH,doSaveLoadListTouched);
				
			}
			//for
			/*for(var j:uint=1;j<emptybars.length;j++)
			{
			emptybars[j].alpha=0.5;
			}*/
		}
		private function doSaveLoadListTouched(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			//DebugTrace.msg("SceneCommand.onChatSceneTouched name:"+target.name);
			var BEGAN:Touch = e.getTouch(target, TouchPhase.BEGAN);
			var inGameProgress:Number=flox.getPlayerData("inGameProgress");
			var savedstr:String=flox.getPlayerData("saved");
			var saved:Array=savedstr.split(",")
			playerData=DataContainer.player;
			//var playerToStr:String=JSON.stringify(playerData);
			//DebugTrace.msg("SaveandLoadList.doSaveLoadListTouched playerToStr:"+playerToStr);
			if(BEGAN)
			{
				DebugTrace.msg("SaveandLoadList.doSaveLoadListTouched target:"+target.name+" ; saved:"+saved);
				var progress:Number;
				var selbar:String=target.name;
				_data=new Object();
				save_new=false;
				if(_type=="Departures")
				{
					//Do save
					
					var saverecord:Array=DataContainer.SaveRecord;
					var savedata:SaveGame=FloxCommand.savegame;
					
					if(selbar.indexOf("savedbar")!=-1)
					{
						DebugTrace.msg("Do over write Saved");	
						
						progress=Number(selbar.split("savedbar").join(""))+1;
						//_data.inGameProgress=progress;
						_data=null;
						playerData.inGameProgress=progress;
					}
					//if
					if(selbar.indexOf("emptybar")!=-1)
					{
						DebugTrace.msg("Do  write to empty");	
						save_new=true;
						//progress=Number(selbar.split("emptybar").join(""))+1;
						
						var old_savedstr:String=flox.getPlayerData("saved");
						var old_saved:Array=old_savedstr.split(",");
						progress=saverecord.length+1;
						old_saved.push("saved"+progress);
						if(old_saved[0]=="")
						{
							old_saved.shift();
						}
						//_data.inGameProgress=progress;
						DebugTrace.msg("old_saved :"+old_saved);	
						playerData.inGameProgress=progress;
						playerData.saved=old_saved;
					}
					DataContainer.player=playerData;
					
					//flox.savePlayer(_data,onSavePlayerComplete);
					//addBuffer();
					displayConfirm();
				}
				else
				{
					//Arrivals :do load
					if(selbar.indexOf("emptybar")==-1)
					{
						
						DebugTrace.msg("Do  load for saved");
						progress=Number(selbar.split("savedbar").join(""))+1;
						playerData.inGameProgress=progress;
						DataContainer.player=playerData;
						_data.inGameProgress=progress;
						
						//flox.savePlayer(_data,onSavePlayerComplete);
						//addBuffer();
						msg="Are you sure?";
						displayConfirm();
					}
					else
					{
						//load empty
						msg="Empty Data.Please create new game!!";
						displayLoadEmptyConfirm();
					}
					
				}
				//if
				
				//target.removeEventListener(TouchEvent.TOUCH,doSaveLoadListTouched);
			}
			//if
		}
		private function onSavePlayerComplete():void
		{
			
			if(_type=="Departures")
			{
				//var _data:Object=new Object();
				//_data.cash=uint(Math.random()*20000);
				flox.save("",null,onSavedComplete);
			}
			else
			{
				
				flox.loadEntities();
				
			}
		}
		private function onSavedComplete():void
		{
			DebugTrace.msg("SaveandLoadList.onSavedComplete");	
			DataContainer.SaveRecord=new Array();
			FloxCommand.onLoadComplete=onLoadComplete;
			flox.loadSavedEntities();
		}
		private function onLoadComplete():void
		{
			refreshProgress();
		}
		private function refreshProgress():void
		{
			
			DebugTrace.msg("SaveandLoadList.refreshProgress");	
			for(var i:uint=0;i<progressbar.length;i++)
			{
				progressbar[i].removeEventListener(TouchEvent.TOUCH,doSaveLoadListTouched);
				panel.removeChild(progressbar[i]);
			}
			//for
			//panel.removeFromParent(); 
			removeChild(panel);
			removeChild(buffer);
			empty_index=0;
			progressbar=new Array();
			panel=new Sprite();
			addChild(panel);
			
			
			renderBackground();
			renderSavedbar();
			renderEmpty();
			renderCloseButton();
			
		}
		private function addBuffer():void
		{
			buffer=new LoadingBuffer();
			buffer.pivotX=Starling.current.stage.stageWidth/2;
			buffer.pivotY=Starling.current.stage.stageHeight/2;
			addChild(buffer);
		}
		private function renderCloseButton():void
		{
			
			var btn_texture:Texture=Assets.getTexture("XAlt");
			var closbtn:Button=new Button(btn_texture);
			closbtn.x=180;
			closbtn.y=-174;
			panel.addChild(closbtn);
			closbtn.addEventListener(Event.TRIGGERED,doCloseTouched);
		}
		private function doCloseTouched(e:Event):void
		{
			//var target:Sprite=e.currentTarget as Sprite;
			//var BEGAN:Touch = e.getTouch(target, TouchPhase.BEGAN);
			DataContainer.SaveRecord=new Array();
			var _data:Object=new Object();
			_data.removed="back";
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
			
			
		}
		private function displayConfirm():void
		{
			comfirm=new Sprite();
			var bgtexture:Texture=Assets.getTexture("departureListbg");
			var bgImg:Image=new Image(bgtexture);
			bgImg.pivotX=bgImg.width/2;
			bgImg.pivotY=bgImg.height/2;
			
			//comfirm.pivotX=bgImg.width/2;
			//comfirm.pivotY=bgImg.height/2;
			comfirm.addChild(bgImg);
			msg="Are you sure?";
			var txt:TextField=new TextField(bgImg.width,70,msg,"Eras Demi ITC",20,0xFFFFFF);
			txt.hAlign="center";
			txt.pivotX=bgImg.width/2;
			txt.y=-50
			
			comfirm.addChild(txt);
			var check_texture:Texture=Assets.getTexture("CheckAlt");	
			var check_btn:Button=new Button(check_texture);
			check_btn.x=-65;
			comfirm.addChild(check_btn);
			var btn_texture:Texture=Assets.getTexture("XAlt");
			var closbtn:Button=new Button(btn_texture);
			closbtn.x=25;
			comfirm.addChild(closbtn);
			addChild(comfirm);
			check_btn.addEventListener(Event.TRIGGERED,doCheckConfirm);
			closbtn.addEventListener(Event.TRIGGERED,doCloseConfirm);
		}
		private function doCheckConfirm(e:Event):void
		{
			panel.removeFromParent();
			comfirm.removeFromParent();
			
			flox.savePlayer(playerData,onSavePlayerComplete);
			
			addBuffer();
			
			var _data:Object={removed:"remove_loadgame_gametitle"};
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
		}
		private function displayLoadEmptyConfirm():void
		{
			comfirm=new Sprite();
			var bgtexture:Texture=Assets.getTexture("departureListbg");
			var bgImg:Image=new Image(bgtexture);
			bgImg.pivotX=bgImg.width/2;
			bgImg.pivotY=bgImg.height/2;
			
			//comfirm.pivotX=bgImg.width/2;
			//comfirm.pivotY=bgImg.height/2;
			comfirm.addChild(bgImg);
			
			var txt:TextField=new TextField(bgImg.width,70,msg,"Eras Demi ITC",20,0xFFFFFF);
			txt.hAlign="center";
			txt.pivotX=bgImg.width/2;
			txt.y=-50
			
			comfirm.addChild(txt);
			var check_texture:Texture=Assets.getTexture("CheckAlt");	
			var check_btn:Button=new Button(check_texture);
			//check_btn.x=-65;
			comfirm.addChild(check_btn);
			var btn_texture:Texture=Assets.getTexture("XAlt");
			
			addChild(comfirm);
			check_btn.addEventListener(Event.TRIGGERED,doCloseConfirm);
		}
		private function doCloseConfirm(e:Event):void
		{
			if(save_new)
			{
				playerData=DataContainer.player;
				var saved:Array=playerData.saved;
				if(saved.length>0)
				{
					saved.pop();
					playerData.saved=saved;
					DataContainer.player=playerData;
				}
			}
			comfirm.removeFromParent();
			removeChild(comfirm);
		}
		
	}
}