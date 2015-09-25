package views
{
import data.DataContainer;

import flash.geom.Rectangle;
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

import flash.text.TextFieldAutoSize;

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
import com.gamua.flox.utils.SHA256;

	public class BlackMarketList extends Sprite
	{
		private var gameEvent:GameEvent;
		private var blance:TextField;
		private var flox:FloxInterface=new FloxCommand();
		private var excerptbox:Sprite;
		private var command:MainInterface=new MainCommand();
        private var coinTxt:TextField;
        private var font:String="SimMyriadPro";
		public function BlackMarketList()
		{
			ViewsContainer.blackmarketform=this;
			
			this.addEventListener("UPDAT_BLANCE",doUpdateBlance);
			initCharacter();
			initMarketList();
			initCancelHandle();
            initCoin();
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
			buybtn.addEventListener(Event.TRIGGERED,doBuyNow);
			
			excerptbox=new ExcerptBox();
			excerptbox.x=100;
			excerptbox.y=225;
			addChild(excerptbox);
		 
			
			gameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="blackmarket_form";
			gameEvent.displayHandler();
			
			 
		}
		private function doBuyNow(e:Event):void
		{

            var email:String=flox.getPlayerData("email");
            var pwd:String=flox.getPlayerData("password");
            var permision:String=Config.permision;
            var authKey:String=SHA256.hashString(String(email+permision+pwd));

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

            coinTxt.text=String(coin);
		}
        private function initCoin():void{


            var coin:Number=flox.getPlayerData("coin");
            var format:Object=new Object();
            format.font=font;
            format.size=20;
            format.color=0x000000;

            coinTxt=addTextField(this,new Rectangle(117,62,158,25),format);
            coinTxt.name="coin";
            coinTxt.text=DataContainer.currencyFormat(coin);

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
			

		}
        private function addTextField(target:Sprite,rec:Rectangle,format:Object):TextField
        {
            var txt:TextField=new TextField(rec.width,rec.height,"",font,format.size,format.color);
            txt.hAlign="left";
            txt.vAlign="center";
            txt.autoSize=TextFieldAutoSize.LEFT;
            txt.x=rec.x;
            txt.y=rec.y;
            target.addChild(txt);

            return txt
        }
	}
}