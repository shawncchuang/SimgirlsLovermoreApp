package views
{
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.DrawerInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import model.SaveGame;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.textures.TextureSmoothing;
	
	import utils.DebugTrace;
	import utils.DrawManager;
	
	public class CardsList extends Sprite
	{
		private var _data:Object;
		private var cate:String;
		public static var CHANGE:String="_change";
		public static var INIT:String="_init";
		private var drawcom:DrawerInterface=new DrawManager();
		private var command:MainInterface=new MainCommand();
		private var flox:FloxInterface=new FloxCommand();
		private var skillscards:Array=new Array();
		private var cardslist:Sprite;
		private var listTotal:Number=0;
		private var cards_index:Number=0;
		//list tatol page
		private var pages:Number=0;
		private var now_page:Number=0;
		//per page  cards max number
		private var pageMax:Number=6
		//current page card number
		private var pageNum:Number=0;
		private var vertical:Number=0;
		private var horizontal:Number=0;
		private var cardAtlas:TextureAtlas;
		private var cardinfo:Object;
		public function CardsList(data:Object)
		{
			_data=data;
			cate=data.cate;
			//var savedata:SaveGame=FloxCommand.savegame;
			//var skills:Object=savedata.skills;
			DebugTrace.msg("CardsList.initCards character="+_data.character+", cate="+cate);
			var skills:Object=flox.getSaveData("skills");
			var enabled:Number=skills[_data.character][cate].indexOf(",");
			if(enabled!=-1)
			{
				var texture:Texture=Assets.getTexture("SkillCards");
				var xml:XML=Assets.getAtalsXML("SkillCardsXML");
				cardAtlas = new TextureAtlas(texture, xml);
				
				skillscards=skills[_data.character][cate].split(",");
				 
				listTotal=skillscards.length;
				pages=uint(listTotal/pageMax);
				if(listTotal%pageMax>0)
				{
					pages++;
				}
				cardslist=new Sprite();
				addChild(cardslist);
				
				
				initCards();
				this.addEventListener(CardsList.CHANGE,doCardsListChanged);
				
			}
			else
			{
				pages=0;
			}
			this.addEventListener(CardsList.INIT,onCardsListInit);
		}
		private function initCards():void
		{
			
			
			
			DebugTrace.msg("CardsList.initCards now_page:"+now_page);
			if(listTotal%pageMax>0)
			{
				if(now_page<pages-1)
				{
					pageNum=pageMax;
				}
				else
				{
					
					pageNum=listTotal%pageMax
					
				}
			}
			else
			{
				pageNum=pageMax;
				
			}
			cardinfo=new Object()
			cardinfo.cate=cate;
			cardinfo.name="SkillsCards";
			cardinfo.container=cardslist;
			
			
			DebugTrace.msg("CardsList.initCards listTotal:"+listTotal+"; pageNum:"+pageNum+" ;cards_index:"+cards_index);
			
			DebugTrace.msg("CardsList.initCards vertical:"+vertical+"; horizontal:"+horizontal);
			var posX:Number=vertical*160+vertical*20;
			var posY:Number=horizontal*203;
			cardinfo.pos=new Point(posX,posY);
			
			onCardReady();
			//drawcom.drawDragonBon(cardinfo,onCardReady)
			
			
		}
		private function onCardsListInit(e:Event):void
		{
			var left_arrow:Button=e.data.left_arrow;
			var right_arrow:Button=e.data.right_arrow;
			command.listArrowEnabled(0,pages,left_arrow,right_arrow);
		}
		private function onCardReady():void
		{
			var last_index:Number=pageNum+now_page*pageMax-1;
			if(cards_index<=last_index)
			{
				//DebugTrace.msg("CardsList.onCardReady BodyBone:"+cate+"face");
				DebugTrace.msg("CardsList.onCardReady card:"+skillscards[cards_index]);
				
				
				var cardTexture:Texture=cardAtlas.getTexture(skillscards[cards_index]);
				var cardImg:Image=new Image(cardTexture);
				cardImg.smoothing=TextureSmoothing.TRILINEAR;
				cardImg.width=160;
				cardImg.height=183;
				cardImg.x=cardinfo.pos.x;
				cardImg.y=cardinfo.pos.y;
				cardslist.addChild(cardImg);
				//var bodybon:Bone=drawcom.getBodyBon(cate+"face");	
			    //bodybon.childArmature.animation.gotoAndPlay(skillscards[cards_index]);
				
				
				cards_index++;
				vertical++;
				
				
				if(vertical==3)
				{
					vertical=0;
					horizontal=1;
				}
				
				
				initCards();
			}
			else
			{
				
				DebugTrace.msg("CardsList onCardReady")
				
			}
			//if
		}
		private function doCardsListChanged(e:Event):void
		{
			var left_arrow:Button=e.data.left_arrow;
			var right_arrow:Button=e.data.right_arrow;
			DebugTrace.msg("CardsList.doCardsListChanged:"+e.data.dir);
			var change:Boolean;
			if(e.data.dir=="left")
			{
				now_page--;
				change=true;
				if(now_page<0)
				{
					now_page=0;
					change=false;
				}
			}
			else
			{
				//right
				now_page++;
				change=true;
				if(now_page>pages-1)
				{
					now_page=pages-1;
					change=false;
				}
			}
			//if
			command.listArrowEnabled(now_page,pages,left_arrow,right_arrow);
			if(change)
			{
				cards_index=now_page*pageMax;
				DebugTrace.msg("CardsList.doCardsListChanged now_page:"+now_page);
				cardslist.removeFromParent(true);
				vertical=0;
				horizontal=0;
				cardslist=new Sprite();
				addChild(cardslist);
				initCards();
			}
		}
	}
}