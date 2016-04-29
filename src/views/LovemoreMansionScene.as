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

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class LovemoreMansionScene extends Scenes
{
	private var speaker_sprite:Sprite;
	private var command:MainInterface=new MainCommand();
	private var button:Button;
	private var scencom:SceneInterface=new SceneCommnad();
	private var flox:FloxInterface=new FloxCommand();
	private var skillstore:Sprite;
	private var font:String="SimMyriadPro";
	private var desc:Sprite;
	private var descTxt:TextField;

	public function LovemoreMansionScene()
	{
		/*var pointbgTexture:Texture=Assets.getTexture("PointsBg");
		 button=new Button(pointbgTexture);
		 addChild(button);
		 button.addEventListener(Event.TRIGGERED, onSceneTriggered);*/
		ViewsContainer.currentScene=this;
		this.addEventListener("UPDATE_DESC",doUpdateDESC);
		this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);
		speaker_sprite=new Sprite();
		addChild(speaker_sprite);

		init();
	}
	private function init():void
	{

		scencom.init("LovemoreMansionScene",speaker_sprite,34,onStartStory);
		scencom.start();

	}
	private function onStartStory():void
	{
		var switch_verifies:Array=scencom.switchGateway("LovemoreMansion");
		if(switch_verifies[0]){
			scencom.disableAll();
			scencom.start();
		}
	}
	private function onSceneTriggered(e:Event):void
	{

		button.visible=false;
		command.sceneDispatch(SceneEvent.CLEARED);


		var tween:Tween=new Tween(this,1);
		tween.onComplete=onClearComplete;
		Starling.juggler.add(tween);


	}
	private function doTopViewDispatch(e:Event):void
	{
		DebugTrace.msg("LovemoreMansionScene.doTopViewDispatch removed:"+e.data.removed);
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
			case "CaptainSkills":
				gameEvent._name="clear_comcloud";
				gameEvent.displayHandler();

				skillstore=new SkillStroeCaptain();
				addChild(skillstore);
				initDesc();
				break
			case "ani_complete":

				var value_data:Object=new Object();
				value_data.attr="honor";
				value_data.values="+10";
				command.displayUpdateValue(this,value_data);
				init();
				break
			case "story_complete":

				onStoryComplete();

				break

		}

	}

	private function onStoryComplete():void{
		var _data:Object=new Object();
		var current_switch:String=flox.getSaveData("current_switch");

		DebugTrace.msg("LovemoreMansionScene.onStoryComplete current_switch:"+current_switch);
		switch (current_switch){
			case "s007|off":
			case "s007b|off":
				var paid:Boolean=flox.getPlayerData("paid");
				if(paid){
					current_switch="s008|on";
				}else{
					current_switch="s007b|on"
				}
				flox.save("current_switch",current_switch);
				_data.name= "MainScene";
				_data.from="story";
				command.sceneDispatch(SceneEvent.CHANGED,_data);

				break;
			case "s046|off":

				DataContainer.battleType="story_battle_s046";
				_data=new Object();
				_data.name="ChangeFormationScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data);

				break;
			case "s047|on":
				_data.name= "MainScene";
				_data.from="story";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				break;
			case "s9999|off":
				var gameEvent:GameEvent = SimgirlsLovemore.gameEvent;
				gameEvent._name = "restart-game";
				gameEvent.displayHandler();
				break;
			default:
				_data.name= "LovemoreMansionScene";
				_data.from="story";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				break
		}


	}

	private function onClosedAlert():void
	{
		var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
		gameEvent._name="clear_comcloud";
		gameEvent.displayHandler();

		init();

	}
	private function onClearComplete():void
	{
		Starling.juggler.removeTweens(this);
		var _data:Object=new Object();
		_data.name= "MainScene";
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
}
}