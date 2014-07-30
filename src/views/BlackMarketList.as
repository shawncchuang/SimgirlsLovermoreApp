package views
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.Config;
	
	import events.GameEvent;
	import events.SceneEvent;
	
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
	
	import utils.DebugTrace;
	import utils.ViewsContainer;

	public class BlackMarketList extends Sprite
	{
		private var gameEvent:GameEvent;
		private var blance:TextField;
		private var flox:FloxInterface=new FloxCommand();
		private var excerptbox:Sprite;
		private var command:MainInterface=new MainCommand();
		public function BlackMarketList()
		{
			ViewsContainer.blackmarketform=this;
			
			this.addEventListener("UPDAT_BLANCE",doUpdateBlance);
			initCharacter();
			initMarketList();
			initCancelHandle()
		}
		private function initCharacter():void
		{
			var texture:Texture=Assets.getTexture("Bunny");
			var bunny:Image=new Image(texture);
			bunny.x=45;
			addChild(bunny);
			//var bunny:MovieClip=Assets.getDynamicAtlas("bunny");
			//bunny.x=45;
			//addChild(bunny);
		}
		private function initMarketList():void
		{
			var formtxture:Texture=Assets.getTexture("MarketListForm");
			var marklistformbg:Image=new Image(formtxture);
			marklistformbg.x=450;
			marklistformbg.y=120;
			addChild(marklistformbg);
			
			var coin:String=String(flox.getPlayerData("coin"));
			blance=new TextField(200,30,coin,"SimNeogreyMedium",20,0xFFFFFF);
			blance.hAlign="left";
			blance.vAlign="center";
			blance.x=648;
			blance.y=150;
			addChild(blance);
			
			var buytexture:Texture=Assets.getTexture("BuyNowBtn");
			var buybtn:Button=new Button(buytexture);
			buybtn.x=810;
			buybtn.y=150;
			addChild(buybtn);
			buybtn.addEventListener(Event.TRIGGERED,doBuyNmow);
			
			excerptbox=new ExcerptBox();
			excerptbox.x=100;
			excerptbox.y=225;
			addChild(excerptbox);
		 
			
			gameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="blackmarket_form";
			gameEvent.displayHandler();
			
			 
		}
		private function doBuyNmow(e:Event):void
		{
		  
		
			var  authKey:String=flox.getPlayerData("authId");
			var url:String=Config.payCoinURL+authKey;
			DebugTrace.msg("BlackTileList onClickItemHandler url:"+url);
			var req:URLRequest=new URLRequest(url);
			navigateToURL(req,"_blank");
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="remove_blackmarket_form";
			gameEvent.displayHandler();
			
			var command:MainInterface=new MainCommand();
			var _data:Object=new Object();
			_data.name="BlackMarketScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data);
			
		}
		private function doUpdateBlance(e:Event):void
		{
			var price:Number=e.data.price;
			var coin:Number=flox.getPlayerData("coin");
			coin=Number((coin-price).toFixed(2));
			blance.text=String(coin);
			var _data:Object=new Object();
			_data.coin=coin;
			flox.savePlayer(_data);
					
			
		}
		private function initCancelHandle():void
		{
			//cancel button
			command.addedCancelButton(this,doCannelHandler);
			
			 
		}
		private function doCannelHandler():void
		{
			
			gameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="remove_blackmarket_form";
			gameEvent.displayHandler();
			
			
			var _data:Object=new Object();
			_data.name="BlackMarketScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data)
		}
	}
}