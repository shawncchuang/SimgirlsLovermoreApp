package views
{


import com.gamua.flox.utils.SHA256;

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
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextFieldAutoSize;

import model.SaveGame;
import model.Scenes;

import services.LoaderRequest;

import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
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
	private var font:String="SimMyriadPro";
	private var desc:Sprite;
	private var descTxt:TextField;

	private var type:String="";

	//BlackMarketUseAssets , BlackMarketAssets
	private var PANEL_TEXTURE_BG:String="";

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
		items[id]=itemData;

		var _data:Object=new Object();
		_data.coin=coin;
		_data.items=items;
		flox.savePlayer(_data);

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
		panelbase.y=159;
		addChild(panelbase);



		panellist=new Image(Assets.getTexture(PANEL_TEXTURE_BG));
		panelbase.addChild(panellist);


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

		coinTxt=addTextField(this,new Rectangle(435,187,158,25),format);
		coinTxt.name="coin";
		coinTxt.text=DataContainer.currencyFormat(coin);

	}
	private function initGetMoreUSDIcon():void{

		var buytexture:Texture=Assets.getTexture("BuyNowBtn");
		var buybtn:Button=new Button(buytexture);
		buybtn.x=825;
		buybtn.y=175;
		addChild(buybtn);
		buybtn.addEventListener(Event.TRIGGERED,doBuyNow);

	}
	private function doBuyNow(e:Event):void
	{

		var loaderReq:LoaderRequest=new LoaderRequest();
		var auth:String=loaderReq.getSharedObject("auth");

		var email:String=flox.getPlayerData("email");
		var pwd:String=flox.getPlayerData("password");
		var permision:String=Config.permision;
		var authKey:String=SHA256.hashString(String(email+permision+pwd));
		if(auth=="email") {
			authKey = loaderReq.getSharedObject("email");
		}
		if(Config.payCoinURL.indexOf("blackspears.com")!=-1){
			var url:String=Config.payCoinURL;
		}else{
			url=Config.payCoinURL+authKey+"&auth="+auth;
		}
		DebugTrace.msg("BlackTileList onClickItemHandler url:"+url);
		var req:URLRequest=new URLRequest(url);
		navigateToURL(req,"_blank");


		var command:MainInterface=new MainCommand();
		var _data:Object=new Object();
		_data.name="BlackMarketScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);

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
			case "ani_complete":

				break
			case "story_complete":
				onStoryComplete();

				break


		}

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
				initGetMoreUSDIcon();
				break
			case "Use":
				PANEL_TEXTURE_BG="BlackMarketUseAssets";
				initPanel();
				break

		}

		initDesc();


        marketlayout=new BlackMarketListLayout();
		marketlayout.type=type;
		marketlayout.x=390;
		marketlayout.y=250;
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
		desc.y=275;
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
		txt.autoSize=TextFieldAutoSize.LEFT;
		txt.x=rec.x;
		txt.y=rec.y;
		target.addChild(txt);

		return txt
	}

}
}