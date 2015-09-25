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
	private var speaker_sprite:Sprite;
	private var command:MainInterface=new MainCommand();
	private var button:Button;
	private var scencom:SceneInterface=new SceneCommnad();
	private var flox:FloxInterface=new FloxCommand();
	private var panelbase:Sprite;
	private var panellist:Image;
	private var coinTxt:TextField;
	private var font:String="SimMyriadPro";
	private var desc:Sprite;
	private var descTxt:TextField;
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
		speaker_sprite.flatten();
		init();
	}
	private function init():void
	{

		scencom.init("BlackStoreScene",speaker_sprite,58,onCallback);
		scencom.start();
		scencom.disableAll();

		this.addEventListener("UPDATE_BLANCE_BLACKMARKET",doUpdateBlance);
		this.addEventListener("UPDATE_DESC",doUpdateDESC);

	}
	private function doUpdateBlance(e:Event):void
	{

		DebugTrace.msg("BlackMarketScene.doUpdateBlance");

		var price:Number=e.data.price;
		var coin:Number=flox.getPlayerData("coin");
		coin=Number((coin-price).toFixed(2));

		var _data:Object=new Object();
		_data.coin=coin;
		flox.savePlayer(_data);

		coinTxt.text=String(coin);
	}
	private function initCharacter():void
	{

		var texture:Texture=Assets.getTexture("Bunny");
		var bunny:Image=new Image(texture);
		bunny.x=20;
		addChild(bunny);

	}
	private function initPanel():void
	{
		panelbase=new Sprite();
		panelbase.x=360;
		panelbase.y=159;
		addChild(panelbase);



		panellist=new Image(Assets.getTexture("BlackMarketAssets"));
		panelbase.addChild(panellist);


		var templete:MenuTemplate=new MenuTemplate();
		templete.addBackStepButton(doCannelHandler);
		addChild(templete);



	}
	private function initCoin():void{


		var coin:Number=flox.getPlayerData("coin");
		var format:Object=new Object();
		format.font=font;
		format.size=20;
		format.color=0x000000;

		coinTxt=addTextField(this,new Rectangle(485,187,158,25),format);
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

		var email:String=flox.getPlayerData("email");
		var pwd:String=flox.getPlayerData("password");
		var permision:String=Config.permision;
		var authKey:String=SHA256.hashString(String(email+permision+pwd));

		var url:String=Config.payCoinURL+authKey;
		DebugTrace.msg("BlackTileList onClickItemHandler url:"+url);
		var req:URLRequest=new URLRequest(url);
		navigateToURL(req,"_blank");


		var command:MainInterface=new MainCommand();
		var _data:Object=new Object();
		_data.name="BlackMarketScene";
		command.sceneDispatch(SceneEvent.CHANGED,_data);

	}
	private function onCallback():void
	{

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


				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();
				flox.refreshPlayer(onRefreshComplete);

				break
			case "ani_complete":
				break

		}

	}
	private function onRefreshComplete():void
	{

		//var marklist:BlackMarketList=new BlackMarketList();
		//addChild(marklist);

		initCharacter();
		initPanel();
		initCoin();
		initGetMoreUSDIcon();
		initDesc();


		var marketlayout:BlackMarketListLayout=new BlackMarketListLayout();
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

		descTxt=new TextField(270,255,"",font,20,0xFFFFFF,false);
		descTxt.x=15;
		descTxt.y=24;
		descTxt.hAlign="left";
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