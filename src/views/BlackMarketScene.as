package views
{

import controller.Assets;
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
import events.TopViewEvent;

import flash.geom.Rectangle;

import model.SaveGame;
import model.Scenes;

import services.LoaderRequest;

import starling.display.Button;
import starling.display.Image;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class BlackMarketScene extends Scenes
{
	private var marketlayout:BlackMarketListLayout;
	private var templete:MenuTemplate;
	private var speaker_sprite:Sprite;
	private var command:MainInterface=new MainCommand();
	private var button:Button;
	private var scenecom:SceneInterface=new SceneCommnad();
	private var flox:FloxInterface=new FloxCommand();
	private var panelbase:Sprite;
	private var panellist:Image;
	private var coinTxt:TextField;
	private var warringTxt:TextField;
	private var font:String="SimMyriadPro";
	private var desc:Sprite;
	private var descTxt:TextField;

	private var type:String="";

	//BlackMarketUseAssets , BlackMarketAssets
	private var PANEL_TEXTURE_BG:String="";

	public static var discount_rate:Number=0.05;
	public static var rewards_rate:Number=0.17;

	private var payoutComponent:PayoutComponent;
	private var preload:Sprite;

	public function BlackMarketScene()
	{
		/*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
		 button=new Button(pointbgTexture);
		 addChild(button);
		 button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
		ViewsContainer.currentScene=this;
		this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
		speaker_sprite=new Sprite();
		addChild(speaker_sprite);

		init();
	}
	private function init():void
	{


		scenecom.init("BlackStoreScene",speaker_sprite,58,onStartStory);
		scenecom.start();


		this.addEventListener("UPDATE_DESC",doUpdateDESC);
		this.addEventListener("BUY_BLACKMARKET_ITEM",doBuyItem);
		this.addEventListener("CONSUME_BLACKMARKET_ITEM",doConsumeItem);
		this.addEventListener("REFLASH_LISTLAYOUT",doReflashListLayout);
		this.addEventListener("REMOVE_PAYOUT",doRemovePayoutComponent);
		this.addEventListener("REQUEST_LOADING",initLoadingBuffer);
		this.addEventListener("COMPLETE_LOADING",removeLoadingBuffer);

	}
	private function onStartStory():void
	{

		var switch_verifies:Array=scenecom.switchGateway("BlackMarketScene");
		DebugTrace.msg("BlackMarketScene.onStartStory switch_verifies="+switch_verifies);
		if(switch_verifies[0]) {

			scenecom.disableAll();
			scenecom.start();
		}

	}


	private function doBuyItem(e:Event):void{

		var id:String=e.data.item_id;
		var price:Number=e.data.price;
		var coin:Number=flox.getPlayerData("coin");
		coin=Number((coin-price).toFixed(2));


		var items:Object=flox.getPlayerData("items");
		if(!items){
			items=new Object();
		}
		var blackmarket:Object=flox.getSyetemData("blackmarket");
		var itemData:Object=blackmarket[id];
		itemData.createAt=e.data.createAt;
		items[id]=itemData;
		var _data:Object=new Object();
		_data.coin=coin;
		_data.items=items;
		flox.savePlayer(_data,onSaveComplete);
		function onSaveComplete():void{

			flox.refreshPlayer();
		}

		coinTxt.text=String(coin);
	}
	private function doConsumeItem(e:Event):void{



		var id:String=e.data.item_id;
		var items:Object=flox.getPlayerData("items");
		var currentItems:Object=new Object();

		DebugTrace.msg("BlackMarketScene.doConsumeItem id="+id);

		for(var item_id:String in items){

			if(item_id!=id){
				currentItems[item_id]=items[item_id];
			}
		}

		var _data:Object=new Object();
		_data.items=currentItems;
		flox.savePlayer(_data);


	}
	private function initCharacter():void
	{

		var texture:Texture=Assets.getTexture("Bunny");
		var bunny:Image=new Image(texture);
		addChild(bunny);

	}
	private function initPanel():void
	{
		panelbase=new Sprite();
		panelbase.x=360;
		panelbase.y=120;
		addChild(panelbase);



		panellist=new Image(Assets.getTexture(PANEL_TEXTURE_BG));
		panelbase.addChild(panellist);


		if(type=="Use"){
			var format:Object=new Object();
			format.font=font;
			format.size=20;
			format.color=0xFF0000;

			var rec:Rectangle=new flash.geom.Rectangle(385,146,550,40);
			var quad:Quad=new Quad(562,rec.height,0xFFFFFF);
			quad.x=rec.x;
			quad.y=rec.y;
			this.addChild(quad);

			var msg:String="Once you used the consumable items they will be consumed. We highly recommend saving the game progress after using them.";
			warringTxt=addTextField(this,rec,format);
			warringTxt.name="warring";
			warringTxt.text=msg;

		}else{

			//add share / input id panel
			var inputComponent:Sprite=new InputIDComponent();
			inputComponent.y=465;
			panelbase.addChild(inputComponent);

			var paid:Boolean=flox.getPlayerData("paid");

			//if(paid){
			var sharedComponent:Sprite=new ShareIDComponent();
			sharedComponent.y=555;
			panelbase.addChild(sharedComponent);
			//}

		}

		templete=new MenuTemplate();
		templete.addBackStepButton(doCannelHandler);
		addChild(templete);
		this.addEventListener("USE_BLACKMARTET_ITEM",onUseBlackMarketItem);


	}
	private function onUseBlackMarketItem(e:Event):void{
		panelbase.removeFromParent(true);
		marketlayout.removeFromParent(true);
		templete.removeFromParent(true);
	}

	private function initCoin():void{


		var coin:Number=flox.getPlayerData("coin");
		var format:Object=new Object();
		format.font=font;
		format.size=20;
		format.color=0x000000;

		var ownerId:String=flox.getPlayerData("ownerId");
		var rewards:Object=flox.getBundlePool("rewards");
		if(rewards[ownerId]){
			if(rewards[ownerId].enable){
				var payout:Number=rewards[ownerId].payout;
				coin+=payout;
				rewards[ownerId].payout=0;
				flox.saveBundlePool({"rewards":rewards});

				flox.savePlayerData("coin",coin);

			}

		}


		coinTxt=addTextField(this,new Rectangle(435,150,158,25),format);
		coinTxt.name="coin";
		coinTxt.text=DataContainer.currencyFormat(coin);

	}
	private function initCurrencyBtns():void{

		var buytexture:Texture=Assets.getTexture("BuyNowBtn");
		var buybtn:Button=new Button(buytexture);
		buybtn.x=835 - buybtn.width - 5;
		buybtn.y=142;
		addChild(buybtn);
		buybtn.addEventListener(Event.TRIGGERED,doBuyNow);

		var payoutTexture:Texture=Assets.getTexture("PayoutBtn");
		var payoutbtn:Button=new Button(payoutTexture);
		payoutbtn.x=835;
		payoutbtn.y=142;
		addChild(payoutbtn);
		payoutbtn.addEventListener(Event.TRIGGERED,doPayout);
	}
	private function doBuyNow(e:Event):void
	{

		var loaderReq:LoaderRequest=new LoaderRequest();
		var auth:String=loaderReq.getSharedObject("auth");

		var email:String=flox.getPlayerData("email");
		var authKey:String=flox.getPlayerData("hashkey");


		var dataReq:Object=new Object();
		dataReq.authKey=authKey;
		loaderReq.navigateToURLHandler(Config.payCoinURL,dataReq);


		var command:MainInterface=new MainCommand();
		var _data:Object=new Object();
		_data.name="BlackMarketScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);

	}

	private function doPayout(e:Event):void{

		payoutComponent=new PayoutComponent();
		this.addChild(payoutComponent);

	}

	private function doTopViewDispatch(e:Event):void
	{
		DebugTrace.msg("BlackStoreScene.doTopViewDispatch removed:"+e.data.removed);
		var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
		var savegame:SaveGame=FloxCommand.savegame;
		var _data:Object=new Object();

		switch(e.data.removed)
		{
			case "Leave":
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				_data.name="MainScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				break
			case "Buy":
			case "Use":
				type=e.data.removed;
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();

				flox.refreshPlayer(onRefreshComplete);
				//onRefreshComplete();
				break
			case "Leaderboard":
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				var leaderboard:Sprite=new LeaderboardForm();
				addChild(leaderboard);

				break
			case "ani_complete":

				break
			case "story_complete":
				onStoryComplete();

				break


		}

	}

	private function initGetPaid():void{


	}

	private function onStoryComplete():void {

		var _data:Object = new Object();
		var current_switch:String = flox.getSaveData("current_switch");
		DebugTrace.msg("BlackStoreScene.onStoryComplete switchID=" + current_switch);
		var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
		switch (current_switch) {


			default:
				_data.name= "BlackMarketScene";
				_data.from="story";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				break

		}
	}
	private function onRefreshComplete():void
	{

		switch(type){

			case "Buy":
				PANEL_TEXTURE_BG="BlackMarketAssets";
				initCharacter();
				initPanel();
				initCoin();
				initCurrencyBtns();
				initGetPaid();
				break
			case "Use":
				PANEL_TEXTURE_BG="BlackMarketUseAssets";
				initPanel();
				break

		}

		initDesc();

		initBlackMaretLayout();



	}
	private function initBlackMaretLayout():void{
		marketlayout=new BlackMarketListLayout();
		marketlayout.type=type;
		marketlayout.x=390;
		marketlayout.y=215;
		addChild(marketlayout);
	}
	private function doCannelHandler():void
	{
		var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
		gameEvent._name="clear_comcloud";
		gameEvent.displayHandler();

		var _data:Object=new Object();
		_data.name= "BlackMarketScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);

	}


	private function initDesc():void{

		desc=new Sprite();
		desc.x=24;
		desc.y=245;
		var bgTexture:Texture=Assets.getTexture("ExcerptBox");
		var bg:Image=new Image(bgTexture);

		descTxt=new TextField(270,255,"");
		descTxt.x=15;
		descTxt.y=24;
		descTxt.format.setTo(font,20,0xFFFFFF,"left");
		desc.addChild(bg);
		desc.addChild(descTxt);
		desc.visible=false;

		addChild(desc);

	}
	private function doUpdateDESC(e:Event):void{

		if(e.data._visible){
			desc.visible=true;
			descTxt.text=e.data.desc;

		}else{
			desc.visible=false;
			descTxt.text="";

		}


	}

	private function addTextField(target:Sprite,rec:Rectangle,format:Object):TextField
	{

		var txt:TextField=new TextField(rec.width,rec.height,"");
		txt.format.setTo(font,format.size,format.color,"left");
		txt.autoScale=true;
		txt.x=rec.x;
		txt.y=rec.y;
		target.addChild(txt);

		return txt
	}

	private function doReflashListLayout(e:Event):void{


		marketlayout.removeFromParent(true);
		initBlackMaretLayout();

	}
	private function doRemovePayoutComponent(e:Event):void{
		payoutComponent.removeFromParent(true);


		var coin:Number=flox.getPlayerData("coin");
		coinTxt.text=DataContainer.currencyFormat(coin);
	}

	private function initLoadingBuffer(e:Event):void{

		//preload=new LoadingBuffer();
		//addChild(preload);
	}
	private function removeLoadingBuffer():void{
		//preload.removeFromParent(true);
	}

}
}