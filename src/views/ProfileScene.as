package views
{
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
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
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	import utils.DrawManager;
	import utils.FilterManager;
	import utils.ViewsContainer;
	
	public class ProfileScene extends Scenes
	{
		private var flox:FloxInterface=new FloxCommand();
		private var scencom:SceneInterface=new SceneCommnad();
		private var command:MainInterface=new MainCommand();
		private var base_sprite:Sprite;
		private var panelbase:Sprite;
		private var panelProfile:MovieClip;
		private var panelAssets:MovieClip;
		private var panelSkills:MovieClip;
		private var tagsname:Array=["person","assets","skills"];
		private var character:String="player";
		private var disablesObj:Object={
			"person":"0,195,300",
			"assets":"0,104,300",
			"skills":"0,104,209"
		}
		private var currentTag:String="person";
		private var tagshit:Sprite;
		private var tags:Array;
		//private var characters_name:Array=["Sao","Sirena","Tomoru","Zack","Lenus","Dea","Klaire","Ceil"];
		private var filtercom:FilterInterface=new FilterManager();
		private var drawcom:DrawerInterface=new DrawManager();
		private var chmodel:Sprite;
		private var basemodel:Sprite;
		private var player_icon:Sprite;
		private var nametile:TextField;
		private var ch_index:Number=-1;
		private static var ch_name:String="";
		private var personal:Sprite;
		private var assets:AssetsForm;
		private var excerptbox:Sprite;
		
		private var casshtext:TextField;
		private var textF1:TextField;
		private var textF2:TextField;
		private var textF3:TextField;
		private var textF4:TextField;
		private var textF5:TextField;
		private var assetsSymbols:Array;
		private var items:Array;
		private var gifts:Array;
		private var acc:Array;
		private var estate:Array;
		private var itemspage:Number=0;
		private var giftspage:Number=0;
		private var accpage:Number=0;
		private var estatepage:Number=0;
		private var itemsindex:Number=0;
		private var giftsindex:Number=0;
		private var accindex:Number=0;
		private var estateindex:Number=0;
		private var _type:String="";
		private var skills:Sprite;
		private var cardlist:Sprite;
		private var cate:String="fire";
		//skills tag form arrow
		private var left_arrow:Button;
		private var right_arrow:Button;
		public static function set CharacterName(str:String):void
		{
			ch_name=str;
		}
		public static function get CharacterName():String
		{
			return ch_name;
		}
		public function ProfileScene()
		{
			
			
			base_sprite=new Sprite();
			addChild(base_sprite);
			base_sprite.flatten();
			initBaseModel();
			initLayout();
			initPersonalData();
			initAsssetsData();
			initSkillsData();
			
			initProIcons();
			initCancelHandle();
			
		}
		private function initCancelHandle():void
		{
			//cancel button
			command.addedCancelButton(this,doCannelHandler);
			
			/*var cancel:Button=new Button(Assets.getTexture("XAlt"));
			cancel.name="cancel";
			cancel.x=964;
			cancel.y=720;
			addChild(cancel);
			cancel.addEventListener(Event.TRIGGERED,doCencaleHandler);*/
			
		}
		private function doCannelHandler():void
		{
			var _data:Object=new Object();
			_data.name="MenuScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data)
		}
		private function initLayout():void
		{
			scencom.init("ProfileScene",base_sprite,22,onCallback);
			scencom.start();
			scencom.disableAll();
			
			
			panelbase=new Sprite();
			panelbase.x=374;
			panelbase.y=96;
			addChild(panelbase);
			panelProfile=Assets.getDynamicAtlas("PanelProfile");
			panelProfile.name="person";
			panelAssets=Assets.getDynamicAtlas("PanelAssets");
			panelAssets.name="assets";
			panelAssets.visible=false;
			panelSkills=Assets.getDynamicAtlas("PanelSkills");
			panelSkills.name="skills";
			panelSkills.visible=false;
			panelbase.addChild(panelProfile);
			panelbase.addChild(panelAssets);
			panelbase.addChild(panelSkills);
			
			var title_texture:Texture=Assets.getTexture("ProfileTitle");
			var title:Image=new Image(title_texture);
			title.y=21;
			addChild(title);
			
			nametile=new TextField(1024,34,"Primero Lovemore’s Profile","Neogrey Medium",25,0xFFFFFF);
			nametile.hAlign="left"
			nametile.x=18;
			nametile.y=25;
			addChild(nametile);
			updateTitle();
			
			
			//add tag hit area
			tagshit=new Sprite();
			tagshit.alpha=0;
			tags=new Array();
			for(var i:uint=0;i<3;i++)
			{
				var tagtexure:Texture=Assets.getTexture("Empty");
				var tagbtn:Button=new Button(tagtexure);
				tagbtn.name=tagsname[i];
				tagbtn.width=105;
				tagbtn.height=60;
				tagbtn.x=disablesObj[currentTag].split(",")[i];
				tagshit.addChild(tagbtn);
				panelbase.addChild(tagshit);
				tagbtn.addEventListener(Event.TRIGGERED,doChageedTag);
			}
			//for
			var first_tag:Button=tagshit.getChildByName(currentTag) as Button;
			first_tag.width=195;
			//set child index
			for(var j:uint=0;j<tagsname.length;j++)
			{
				var tag:Button=tagshit.getChildByName(tagsname[j]) as Button;
				var index:uint=tagshit.getChildIndex(tag);
				var tagObj:Object=new Object();
				tagObj.index=index;
				tagObj.tag=tag;
				tags.push(tagObj);
			}
			
		}
		private function updateTitle():void
		{
			var savedata:SaveGame=FloxCommand.savegame;
			
			var last_name:String=Config.characters[ch_index];
			
			
			var first_name:String="Lovermore"
			if(ch_index==-1)
			{
				//player
				last_name=savedata.last_name;
				first_name=savedata.first_name;
			}
			else
			{
				if(last_name=="sao")
				{
					first_name="Black";
				}
				else if(last_name=="zack")
				{
					first_name="Krieg";
					
				}
			}
			//if
			DebugTrace.msg("ProfileScene.updateTitle name:"+last_name+" "+first_name+"’s Profile")
			nametile.text=last_name+" "+first_name;
			
			
		}
		private function doChageedTag(e:Event):void
		{
			var temp:Array=["person","assets","skills"];
			var target:Button=e.currentTarget as Button;
			currentTag=target.name;
			var top_target:Button=tagshit.getChildAt(2) as Button;
			tagshit.swapChildren(target,top_target);
			//DebugTrace.msg("ProfileScene.doChageedTag tag target:"+target.name);
			//var top:uint=tags.sortOn("index");
			var disableX:Array=disablesObj[target.name].split(",");
			//DebugTrace.msg("ProfileScene.doChageedTag tag disableX:"+disableX);
			for(var i:uint=0;i<tags.length;i++)
			{
				var tag:Button=tagshit.getChildByName(tagsname[i]) as Button;
				tag.width=195;
				var panel:MovieClip=panelbase.getChildByName(tagsname[i]) as MovieClip;
				panel.visible=false;
			}
			for(var j:uint=0;j<tags.length;j++)
			{
				tag=tagshit.getChildByName(tagsname[j]) as Button;
				var index:uint=tagshit.getChildIndex(tag);
				//DebugTrace.msg("ProfileScene.doChageedTag tag index:"+index);
				
				if(index<2)
				{
					
					tag.width=105;
				}
				//if
				tag.x=Number(disableX[j]);
				
			}
			//for
			panelProfile.visible=false;
			panelAssets.visible=false;
			panelSkills.visible=false;
			var current_panel:MovieClip=panelbase.getChildByName(target.name) as MovieClip;
			current_panel.visible=true;
			personal.visible=false;
			assets.visible=false;
			skills.visible=false;
			switch(target.name)
			{
				case "person":
					personal.visible=true;
					break
				case "assets":
					assets.visible=true;
					
					break
				case "skills":
					skills.visible=true;
					break
			}
			//switch
			
		}
		private function initPersonalData():void
		{
			
			personal=new Sprite();
			panelbase.addChild(personal);
			
			var format:Object=new Object();
			format.font="Neogrey Medium";
			format.size=20;
			format.color=0xFFFFFF;
			
			
			//status,relation,relation pts
			textF1=new TextField(380,115,"",format.font,format.size,format.color);
			textF1.hAlign="left"
			textF1.x=38;
			textF1.y=94;
			personal.addChild(textF1)
			
			
			//rank,honor
			textF2=new TextField(340,56,"",format.font,format.size,format.color);
			textF2.hAlign="left"
			textF2.x=112;
			textF2.y=237;
			personal.addChild(textF2);
			
			//spirit energy,love
			textF3=new TextField(340,56,"",format.font,format.size,format.color);
			textF3.hAlign="left"
			textF3.x=112;
			textF3.y=320;
			personal.addChild(textF3);
			
			
			//intelligence
			textF4=new TextField(340,28,"",format.font,format.size,format.color);
			textF4.hAlign="left"
			textF4.x=112;
			textF4.y=403;
			personal.addChild(textF4);
			
			//imgae
			textF5=new TextField(340,28,"",format.font,format.size,format.color);
			textF5.hAlign="left"
			textF5.x=112;
			textF5.y=463;
			personal.addChild(textF5);
			
			updateData();
			
		}
		private function updateData():void
		{
			
			
			var savedata:SaveGame=flox.getSaveData();
			var status:String="Status: "+savedata.status;
			var rel:String="Relation: "+savedata.rel[character];
			var rel_pts:String="Relation Pts: "+savedata.rel[character];
			var txt1:String=status+"\n\n"+rel+"\n"+rel_pts;
			textF1.text=txt1;
			
			
			var rank:String="Blackspears Rank: "+savedata.rank;
			var honor:String="Honor: "+savedata.honor[character];
			var txt2:String=rank+"\n"+honor;
			textF2.text=txt2;
			
			var spt_eng:String="Spirit Energy: "+savedata.se[character]+"/99999";
			var love:String="Love: "+savedata.love[character];
			var txt3:String=spt_eng+"\n"+love;	
			textF3.text=txt3;
			
			var int:String="Intelligence: "+savedata.int[character];
			textF4.text=int;
			
			var img:String="Image: "+savedata.image[character];
			textF5.text=img;
		}
		private function initAsssetsData():void
		{
			CharacterName="player";
			assets=new AssetsForm();
			
			panelbase.addChild(assets);
			
			//var savedata:SaveGame=FloxCommand.savegame;
		    //var cash:Number=savedata.cash;
			var cash:Number=flox.getSaveData("cash");
			var format:Object=new Object();
			format.font="Neogrey Medium";
			format.size=20;
			format.color=0xFFFFFF;
			format.txt=	DataContainer.currencyFormat(cash);
			casshtext=new TextField(380,30,format.txt,format.font,format.size,format.color);
			casshtext.hAlign="left"
			casshtext.x=149;
			casshtext.y=81;
			assets.addChild(casshtext);
			
			
			
			
			initAssetesForm();
			
			assets.visible=false;
			
			
		}
		
		
		private function initAssetesForm():void
		{
			
			assetsSymbols=new Array();
			
			itemsindex=0;
			giftsindex=0;
			accindex=0;
			estateindex=0;
			
			
			excerptbox=new ExcerptBox();
			excerptbox.x=-345;
			excerptbox.y=113;
			assets.addChild(excerptbox)
			
			//var savedata:SaveGame=FloxCommand.savegame;
			var chName:String
			if(ch_index==-1)
			{
				//player cash
				chName="player";
				var cash:Number=flox.getSaveData("cash");
			}
			else
			{
				//other character cash
				chName=Config.characters[ch_index].toLowerCase();
				cash=flox.getSaveData("ch_cash")[chName];
				//var excerpt:Array=savedata.assets[chName];
				
			}
			CharacterName=chName
			casshtext.text=DataContainer.currencyFormat(cash);
			
			
			
			
		}
		private function initArrowCtrl():void
		{
			var arrctrls:Array=new Array();
			var arrow_texture:Texture=Assets.getTexture("IconArrow");
			var item_l_arr:Button=new Button(arrow_texture);
			item_l_arr.name="Left_Item";
			item_l_arr.x=11;
			item_l_arr.y=172;
			var item_r_arr:Button=new Button(arrow_texture);
			item_r_arr.name="Right_Item";
			item_r_arr.x=607;
			item_r_arr.y=172;
			item_r_arr.scaleX=-1;
			arrctrls.push(item_l_arr);
			arrctrls.push(item_r_arr);
			
			var gift_l_arr:Button=new Button(arrow_texture);
			gift_l_arr.name="Left_Gift";
			gift_l_arr.x=11;
			gift_l_arr.y=280;
			var gift_r_arr:Button=new Button(arrow_texture);
			gift_r_arr.name="Right_Gift";
			gift_r_arr.x=607;
			gift_r_arr.y=280;
			gift_r_arr.scaleX=-1;
			arrctrls.push(gift_l_arr);
			arrctrls.push(gift_r_arr)
			
			//accessories
			var acc_l_arr:Button=new Button(arrow_texture);
			acc_l_arr.name="Left_Accessories";
			acc_l_arr.x=11;
			acc_l_arr.y=388;
			var acc_r_arr:Button=new Button(arrow_texture);
			acc_r_arr.name="Right_Accessories";
			acc_r_arr.x=607;
			acc_r_arr.y=388;
			acc_r_arr.scaleX=-1;
			arrctrls.push(acc_l_arr);
			arrctrls.push(acc_r_arr);
			
			//real estate & vehicles
			var estate_l_arr:Button=new Button(arrow_texture);
			estate_l_arr.name="Left_Estate";
			estate_l_arr.x=11;
			estate_l_arr.y=496;
			var estate_r_arr:Button=new Button(arrow_texture);
			estate_r_arr.name="Right_Estate";
			estate_r_arr.x=607;
			estate_r_arr.y=496;
			estate_r_arr.scaleX=-1;
			arrctrls.push(estate_l_arr);
			arrctrls.push(estate_r_arr);
			
			
			for(var i:uint=0;i<arrctrls.length;i++)
			{
				var arrow:Button=arrctrls[i];	 
				
				arrow.addEventListener(Event.TRIGGERED,doArrowTiggered);
				assets.addChild(arrow);
				assetsSymbols.push(arrow);
				
			}		
			//for
			/*for(var j:uint;j<arrctrls.length;j++)
			{
			arrow=arrctrls[j];	 
			var type:String=arrow.name.split("_")[1]; 
			checkLimit(0,1,type);
			}*/
		}
		
		private function intiEquipmentItems():void
		{
			
			
			renderAssetsbar("items");
			updatebarPage("Item");
		}
		private function initGifts():void
		{
			renderAssetsbar("gifts");
			updatebarPage("Gift");
		}
		private function initAccessories():void
		{
			renderAssetsbar("accessories");
			updatebarPage("Accessories");
			
		}
		private function initEstate():void
		{
			renderAssetsbar("estate");
			updatebarPage("Estate");
			
			
		}
		private function renderAssetsbar(type:String):void
		{
			DebugTrace.msg("ProfileScene.renderAssetsbar type:"+type+" -----------------");
			_type=type;
			var savedata:SaveGame=FloxCommand.savegame;
			var _y:Number=0;
			var list:Array=new Array();
			var xml:XML;
			var texture:Texture;
			switch(type)
			{
				case "items":
					_y=144;
					list=items=savedata.items[character].split(",");
					
					itemspage=uint(items.length/7);
					if(items.length%7>0)
					{
						itemspage++;
					}
					//DebugTrace.msg("ProfileScene.renderAssetsbar items:"+items)
					xml=Assets.getAtalsXML("ItemsXML");
					texture=Assets.getTexture("Items");
					checkLimit(0,itemspage,"Item");
					break
				case "gifts":
					_y=252;
					list=gifts=savedata.gifts[character].split(",");
					giftspage=uint(gifts.length/7);
					if(gifts.length%7>0)
					{
						giftspage++;
					}
					xml=Assets.getAtalsXML("GiftsXML");
					texture=Assets.getTexture("Gifts");
					checkLimit(0,giftspage,"Gift");
					break
				case "accessories":
					_y=362;
					list=acc=savedata.accessories[character].split(",");
					accpage=uint(acc.length/7);
					if(acc.length%7>0)
					{
						accpage++;
					}
					xml=Assets.getAtalsXML("AccessoriesXML");
					texture=Assets.getTexture("Accessories");
					checkLimit(0,accpage,"Accessories");
					break
				case "estate":
					_y=469;
					list=estate=savedata.estate[character].split(",");
					estatepage=uint(estate.length/7);
					if(estate.length%7>0)
					{
						estatepage++;
					}
					xml=Assets.getAtalsXML("EstateXML");
					texture=Assets.getTexture("Estate");
					checkLimit(0,estatepage,"Estate");
					break
			}
			//switch
			
			var data_index:Number=savedata[type][character].indexOf(",");
			DebugTrace.msg("ProfileScene.renderAssetsbar data_index:"+data_index);
			if(data_index!=-1)
			{
				var atlas:TextureAtlas=new TextureAtlas(texture, xml);
				for(var i:uint=0;i<list.length;i++)
				{
					
					texture=atlas.getTexture(list[i]);
					var img:Image=new Image(texture);
					img.name=list[i];
					img.x=28+i*img.width;
					img.y=_y;
					assets.addChild(img);
					assetsSymbols.push(img);
					//filtercom.setSource(itemImg);
					//filtercom.setShadow();
				}
				//for
			} 
			
		}
		private function doArrowTiggered(e:Event):void
		{
			var target:Button=e.currentTarget as Button;
			var dir:String=target.name.split("_")[0];
			var type:String=target.name.split("_")[1];
			DebugTrace.msg("ProfileScene.doArrowTiggered dir:"+dir+" ; type:"+type);
			
			switch(type)
			{
				case "Item":
					if(dir=="Left")
					{
						itemsindex--;
					}
					else
					{
						itemsindex++;	
					}
					DebugTrace.msg("ProfileScene.doArrowTiggered itemsindex:"+itemsindex);
					
					itemsindex=checkLimit(itemsindex,itemspage,type);
					
					DebugTrace.msg("ProfileScene.doArrowTiggered itemsindex:"+itemsindex+" ; itemspage:"+itemspage);
					break
				case "Gift":
					if(dir=="Left")
					{
						giftsindex--;
					}
					else
					{
						giftsindex++;	
					}
					giftsindex=checkLimit(giftsindex,giftspage,type);
					
					break
				case "Accessories":
					
					if(dir=="Left")
					{
						accindex--;
					}
					else
					{
						accindex++;	
					}
					accindex=checkLimit(accindex,accpage,type);
					
					break
				case "Estate":
					if(dir=="Left")
					{
						estateindex--;
					}
					else
					{
						estateindex++;	
					}
					estateindex=checkLimit(estateindex,estatepage,type);
					break
				
			}
			//switch
			updatebarPage(type);
			
			
		}
		
		private function updatebarPage(type:String):void
		{
			var start_page:Number;
			var end_page:Number;
			var list:Array=new Array();
			var index:Number;
			var savedata:SaveGame=FloxCommand.savegame;
			var data_index:Number=flox.getSaveData(_type)[character].indexOf(",");
			switch(type)
			{
				case "Item":
					start_page=itemsindex*7;
					end_page=items.length-itemsindex*7;
					list=items;
					index=itemsindex;
					break
				case "Gift":
					start_page=giftsindex*7;
					end_page=gifts.length-giftsindex*7;
					list=gifts;
					index=giftsindex;
					break
				case "Accessories":
					start_page=accindex*7;
					end_page=acc.length-accindex*7;
					list=acc;
					index=accindex;
					break
				case "Estate":
					start_page=estateindex*7;
					end_page=estate.length-estateindex*7;
					list=estate;
					index=estateindex;
					break
				
			}
			//switch
			if(end_page>7)
			{
				end_page=7;
			}
			if(data_index!=-1)
			{
				var img:Image
				for(var j:uint=0;j<list.length;j++)
				{
					img=assets.getChildByName(list[j]) as Image;
					img.x=28+j*img.width;
					img.visible=false;
				}
				
				var end:Number=index*7+end_page;
				DebugTrace.msg("ProfileScene.updatebarPage end_page:"+end_page);
				DebugTrace.msg("ProfileScene.updatebarPage end:"+end);
				var sec_index:Number=-1;
				for(var i:uint=start_page;i<end;i++)
				{
					sec_index++;
					img=assets.getChildByName(list[i]) as Image;
					img.visible=true;
					
					if(index>0)
					{
						img.x=28+sec_index*img.width;
						
					}
					//if
				}
				//for
			}
			
		}
		private function updateAssets():void
		{
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="removed_assets_form";
			gameEvent.displayHandler();
			
			assets.dispatchEventWith("DISPLAY");
			
			excerptbox.removeFromParent(true);
			initAssetesForm();
			
		}
		
		private function initProIcons():void
		{
			
			player_icon=new Sprite();
			player_icon.name="Player";
			addChild(player_icon);
			drawcom.drawPlayerProfileIcon(player_icon,1,new Point(60,710));
			//drawcom.drawPlayerProfileIcon(player_icon,1,new Point(54,50));
			player_icon.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
			
			 
			var savedata:SaveGame=FloxCommand.savegame;
			var characters:Array=Config.characters;
			for(var i:uint=0;i<characters.length;i++)
			{
				var name:String=characters[i].toLowerCase();
				var pts:Number=Number(savedata.pts[name]);
				var enable_ch:String="ProEmpty";
				var enabled:Boolean=false;
				
				var sprite:Sprite=new Sprite();
				sprite.name=characters[i];
				sprite.useHandCursor=enabled;
				sprite.x=i*100+160;
				sprite.y=710;
				
				if(pts!=-1)
				{
					enabled=true;
					drawcom.drawCharacterProfileIcon(sprite,characters[i],0.45);
				}
				else
				{	
					var texture:Texture=Assets.getTexture(enable_ch);
					var img:Image=new Image(texture);
					img.smoothing=TextureSmoothing.TRILINEAR;
					img.pivotX=img.width/2;
					img.pivotY=img.height/2;
					img.scaleX=0.45;
					img.scaleY=0.45;
					sprite.addChild(img);
				}
				//if
				
				/*var bgtexture:Texture=Assets.getTexture("IconCircle");
				var bgImg:Image=new Image(bgtexture);
				bgImg.smoothing=TextureSmoothing.TRILINEAR;
				bgImg.pivotX=bgImg.width/2;
				bgImg.pivotY=bgImg.height/2;
				bgImg.width=80;
				bgImg.height=80;
				
				sprite.addChild(bgImg);*/
				
				
				
				addChild(sprite);
				
				//filtercom.setSource(sprite);
				//filtercom.setShadow();
				
				//var tween:Tween=new Tween(sprite,1,Transitions.EASE_IN_OUT);
				//tween.scaleTo(1);
				//Starling.juggler.add(tween);
				if(enabled)
				{
					sprite.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
				}
				//if
			}
			//for
			
			
		}
		private function onTouchCharaterIcon(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			if(hover)
			{
				
				var tween:Tween=new Tween(target,0.2,Transitions.LINEAR);
				tween.scaleTo(1.1);
				Starling.juggler.add(tween);
				
				
			}
			else
			{
				var scale:Number=1;
				if(target.name=="Player")
				{
					scale=0.89;
				}
				//if	
				tween=new Tween(target,0.2,Transitions.LINEAR);
				tween.scaleTo(scale);
				Starling.juggler.add(tween);
			}
			//if
			if(began)
			{
				ch_index=Config.characters.indexOf(target.name);
				character=target.name.toLowerCase();
				CharacterName=character;
				updateTitle();
				updateData();
				updateCharacter();
				updateAssets();
				updateSkills();
			}
			//if
		}
		private function updateSkills():void
		{
			cate="fire";
			skills.removeFromParent(true);
			//panelbase.removeChild(skills);
			initSkillsData();
			
		}
		private function initSkillsData():void
		{
			//skills tag
			
			skills=new Sprite();
			
			initSkillsGate();
			initCardsList();
			
			panelbase.addChild(skills);
			
			if(currentTag!="skills")
			{
				skills.visible=false;
			}
			//if
			
		}
		private function initSkillsGate():void
		{
			var elements:Array=Config.elements;
			for(var i:uint=0;i<elements.length;i++)
			{
				
				
				var texture:Texture=Assets.getTexture("Cate_"+elements[i]);
				var elementsbtn:Button=new Button(texture);
				elementsbtn.name=elements[i];
				elementsbtn.x=i*50+336;
				elementsbtn.y=70;
				skills.addChild(elementsbtn);
				elementsbtn.addEventListener(Event.TRIGGERED,onTriggeredElements);
			}
			//for
			
			
			
		}
		private function onTriggeredElements(e:Event):void
		{
			var target:Button=e.currentTarget as Button;
			cate=target.name;
			left_arrow.removeFromParent(true);
			right_arrow.removeFromParent(true);
			cardlist.removeFromParent(true);
			//skills.removeChild(left_arrow);
			//skills.removeChild(right_arrow);
			//skills.removeChild(cardlist);
			
			initCardsList();
			
			
		}
		private function initCardsList():void
		{
			var _data:Object=new Object();
			_data.character=character;
			_data.cate=cate;
			cardlist=new CardsList(_data);
			cardlist.x=49;
			cardlist.y=130;
			
			var texture:Texture=Assets.getTexture("IconArrow");
			left_arrow=new Button(texture);
			left_arrow.name="left";
			left_arrow.x=13;
			left_arrow.y=314;
			right_arrow=new Button(texture);
			right_arrow.name="right";
			right_arrow.x=610;
			right_arrow.y=314;
			right_arrow.scaleX=-1;
			
			left_arrow.addEventListener(Event.TRIGGERED,onTriggeredSkillList);
			right_arrow.addEventListener(Event.TRIGGERED,onTriggeredSkillList);
			
			
			var arrow_data:Object=new Object();
			arrow_data.left_arrow=left_arrow;
			arrow_data.right_arrow=right_arrow;
			cardlist.dispatchEventWith(CardsList.INIT,false,arrow_data)
			
			skills.addChild(left_arrow);
			skills.addChild(right_arrow);
			skills.addChild(cardlist);
		}
		private function onTriggeredSkillList(e:Event):void
		{
			var target:Button=e.currentTarget as Button;
			
			var _data:Object=new Object();
			_data.dir=target.name;
			_data.left_arrow=left_arrow;
			_data.right_arrow=right_arrow;
			var cardsEvent:Event=new Event(CardsList.CHANGE,true,_data);
			cardlist.dispatchEvent(cardsEvent);
			
		}
		private var copyModel:Sprite
		private function initBaseModel():void
		{
			
			var savedata:SaveGame=FloxCommand.savegame;
			var gender:String=savedata.avatar.gender;
			
			var modelObj:Object={"Male":new Rectangle(0,0,270,797),
				"Female":new Rectangle(0,0,214,768)}
			var modelRec:Rectangle=modelObj[gender];
			
			chmodel=new Sprite();
			chmodel.y=50;
			addChild(chmodel);
			
			
			basemodel=new Sprite();
			basemodel.x=modelRec.x;
			basemodel.y=modelRec.y;
			addChild(basemodel);
			
			
			var modelAttr:Object=new Object();
			modelAttr.gender=gender;
			modelAttr.width=modelRec.width;
			modelAttr.height=modelRec.height;
			
			drawcom.drawCharacter(basemodel,modelAttr);
			drawcom.updateBaseModel("Hair");
			drawcom.updateBaseModel("Eyes");
			drawcom.updateBaseModel("Pants");
			drawcom.updateBaseModel("Clothes");
			drawcom.updateBaseModel("Features");
			
			copyModel=new Sprite();
			addChild(copyModel);
			var pos:Point=new Point(55,100);
			if(gender=="Female")
			{
				pos=new Point(95,140);
			}
			drawcom.playerModelCopy(copyModel,pos);
		}
		private function updateCharacter():void
		{
			copyModel.visible=false;
			chmodel.visible=true;
			if(ch_index==-1)
			{
				copyModel.visible=true;
				chmodel.visible=false;
			}
			else
			{
				var old_chmc:MovieClip=chmodel.getChildByName("character") as MovieClip;
				if(old_chmc)
				{
					old_chmc.removeFromParent(true);
				 
				}
				var ch_name:String=Config.characters[ch_index];
				//fake
				//ch_name="Sao";
				var chmc:MovieClip=Assets.getDynamicAtlas(ch_name.toLowerCase());
				chmc.name="character";
				chmc.width=356;
				chmc.height=608;
				chmodel.addChild(chmc)
			}
			
			
		}
		private function checkLimit(index:Number,pages:Number,type:String):Number
		{
			var left_arrow:Button=assets.getChildByName("Left_"+type) as Button;
			var right_arrow:Button=assets.getChildByName("Right_"+type) as Button;
			
			
			var end_node:Number=index;
			
			if(index<=0)
			{
				
				end_node=0;
			}
			
			if(index>pages-1)
			{
				
				end_node=pages-1;
			}
			
			command.listArrowEnabled(index,pages,left_arrow,right_arrow);
			
			return end_node;
		}
		private function onCallback():void
		{
			
		}
	}
}