package views
{

import com.greensock.TweenMax;
import com.greensock.easing.Elastic;
import com.greensock.easing.Expo;
import com.greensock.easing.Quart;
import com.greensock.easing.Quint;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;
import com.greensock.plugins.FrameLabelPlugin;
import com.greensock.plugins.FramePlugin;
import com.greensock.plugins.TweenPlugin;
import com.greensock.text.SplitTextField;

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.Stage;
import flash.display.StageQuality;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.text.AntiAliasType;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.utils.Timer;

import controller.ElementStones;
import controller.ElementStonesCommand;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.MembersInterface;
import controller.MemebersCommand;
import controller.SoundController;

import data.Config;
import data.DataContainer;

import events.BattleEvent;
import events.GameEvent;
import events.SceneEvent;

import model.BattleData;
import model.SaveGame;

import services.LoaderRequest;

import starling.core.Starling;

import utils.DebugTrace;
import utils.ViewsContainer;

//import com.greensock.loading.SWFLoader;
//TweenPlugin.activate([CirclePath2DPlugin]);
//TweenPlugin.activate([TransformAroundCenterPlugin, TransformAroundPointPlugin, ShortRotationPlugin]);

//TweenPlugin.activate([BezierThroughPlugin]);
TweenPlugin.activate([FrameLabelPlugin, FramePlugin]);


public class BattleScene extends Sprite
{

	private var flox:FloxInterface=new FloxCommand();
	//private var cpucom:CpuMembersInterface=new CpuMembersCommand();
	//private var swfloader:SWFLoader;

	private var cputeam:Array=new Array();
	//cpu main team data
	//private var cpu_team:Array;
	private var playerteam:Array=new Array();
	public static var player_index:uint=0;
	private var current_player:Member;


	public static var play_power:Array;
	private var top_index:int;
	private var tweenmax:TweenMax;
	private var battconfirm:StartBattleConfirm;

	private var characters:Array;

	private var element:String="";
	private var cardsSprtie:Sprite;
	private var elepanel:MovieClip=null;
	private var hurtplayer:Array=new Array();

	private var battlescene:MovieClip;
	private var background:MovieClip;
	private var menuscene:Sprite
	private var elementsbar:MovieClip;
	private var sebar:MovieClip;
	private var hptsbar:MovieClip;
	private var menubg:MovieClip;
	private var selectedCard:Boolean=false;
	private var power:Object=new Object();
	private var stonebar:MovieClip;
	private var new_req_list:Array=new Array();
	private var elementslist:Array;
	private var stoneslist:Array;
	private var elestonecom:ElementStones=new ElementStonesCommand();
	private var starttab:MovieClip;
	private var current_damage:Number;
	private var memberscom:MembersInterface=new MemebersCommand();
	private var targetlist:Array;
	private var attack_power:Object;
	private var targetArea:Array;
	private var battletitle:MovieClip;
	private var stepTxts:Object={"solider":"Select Solider","skill":"Select Skill Card","target":"Select Target","itempanel":"Select Item"};
	//all members effect
	private var memeffect:Object;
	public static var fighting:Boolean=false;
	private var titleTxt:TextField=new TextField();
	private var stageDeY:Number=-768;
	public static var battleEvt:BattleEvent;
	private var profile:MovieClip;
	private var reinPlayerSE:Number;
	private var reinCpuSE:Number;
	//commnader skill type;
	private var comType:String="";
	private var partner:String="";
	private var commander:Member;
	private var formationNum:Number=3;
	private var cryNum:Number=3;
	private var command:MainInterface=new MainCommand();
	private var memberWH:Number=150;
	private var playersX:Object=new Object();
	private var cpusX:Object=new Object();
	private var current_skillPts:Object=new Object();
	private var battle_type:String;
	private var commanderSkill:Boolean=false;
	public function BattleScene()
	{


		battle_type=DataContainer.battleType;
		var scene:String=DataContainer.currentScene;
		var evtObj:Object=new Object();
		evtObj.event="Start@"+scene;
		evtObj.type=battle_type;
		flox.logEvent("Battle",evtObj);

		var evt:BattleEvent=new BattleEvent();
		evt.addEventListener(BattleEvent.COMMANDER_ITEM,usedItemHandle);
		evt.addEventListener(BattleEvent.HEAL,usedHealHandle);
		evt.addEventListener(BattleEvent.BONUS,onStartBonusGame);
		evt.addEventListener(BattleEvent.CPU_COMMANDER,onCPUCommaderItems);
		evt.addEventListener(BattleEvent.PLAYER_CONTROLER,doDefinePlayerControler);
		battleEvt=evt;

		current_skillPts=flox.getSaveData("skillPts");
		//current_skillPts=Config.getSkillPts;
		init();

		ViewsContainer.battlescene=this;
		command.playBackgroudSound("BattleMusic");




		//sound testing
		//command.playSound("BingoSound");

		//--------------Victory Testing----------------------			
		//var victorybounse:Sprite=new VictoryBonus();
		//addChild(victorybounse);

	}

	private function onStartBonusGame(e:Event):void
	{

		if(battle_type=="random_battle"){


			var victorybounse:Sprite=new VictoryBonus();
			addChild(victorybounse);



		}else{

			var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvt._name="remove_battle";
			gameEvt.displayHandler();

			var _data:Object=new Object();
			_data.name=DataContainer.currentLabel;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}

	}
	private function onCPUCommaderItems(e:Event):void
	{
		DebugTrace.msg("BattleScene.onCPUCommaderItems item="+e.target.itemid);

		starttab.wall.visible=true;

		switch(e.target.itemid)
		{
			case "com0":
				formationNum--;
				if(formationNum>0)
				{
					changeCPUFormationHandle();
				}
				//if
				break
			case "com1":
				cryNum--;
				commander=e.target.commander;
				if(cryNum>0)
				{
					doCommanderRage();
				}
				//if
				break

		}
		//switch
		if(e.target.itemid=="")
		{
			initTeamPos();
			focusHandle("solider");
		}
	}
	private function init():void
	{
		partner="";
		DataContainer.currentPower=new Object();

		memeffect=new Object();
		DataContainer.MembersEffect=memeffect;

		play_power=new Array();

		battlescene=new MovieClip();
		battlescene.y=stageDeY;
		addChild(battlescene);
		ViewsContainer.battleView=battlescene;


		var loaderReq:LoaderRequest=new LoaderRequest();
		loaderReq.setLoaderQueue("background","../swf/BattleStage.swf",battlescene,onStageBGComplete);


		var playereffGround:MovieClip=new GroundEffect();
		playereffGround.x=893;
		playereffGround.y=1050;
		battlescene.addChild(playereffGround);
		playereffGround.visible=false;
		ViewsContainer.groundEffectPlayer=playereffGround;

		var cpueffFround:MovieClip=new GroundEffect();
		cpueffFround.x=134;
		cpueffFround.y=1050;
		battlescene.addChild(cpueffFround);
		cpueffFround.visible=false;
		ViewsContainer.groundEffectCPU=cpueffFround;



		menuscene=new Sprite();
		menuscene.y=354;
		addChild(menuscene);

		menubg=new BattleMenubg();
		menubg.y=450;
		menuscene.addChild(menubg);

		profile=new BattleProfile();
		profile.y=60;
		profile.alpha=0;
		menuscene.addChild(profile);

		sebar=new SEbar();
		sebar.y=367;
		menuscene.addChild(sebar);

		hptsbar=new HPtsBar();
		hptsbar.y=376;
		menuscene.addChild(hptsbar);

		battletitle=new BattleTitle();
		addChild(battletitle);
		var format:TextFormat=new TextFormat();
		format.font="SimImpact";
		format.color=0xffffff;
		format.size=40;
		//battletitle.y=15;
		titleTxt=new TextField();
		titleTxt.width=370;
		titleTxt.height=70;
		titleTxt.antiAliasType=AntiAliasType.ADVANCED;
		//var titleTxt:TextField=battletitle.txt;
		titleTxt.selectable=false;
		titleTxt.defaultTextFormat=format;
		titleTxt.autoSize=TextFieldAutoSize.LEFT;
		battletitle.addChild(titleTxt);

		starttab=new StartBattleTab();
		//starttab.btn.buttonMode=true;
		starttab.wall.alpha=0;
		starttab.wall.visible=false;
		addChild(starttab);
		starttab.btn.addEventListener(MouseEvent.MOUSE_DOWN,doStartBattle);
		starttab.btn.addEventListener(MouseEvent.ROLL_OVER,doMouseOverStartTab);
		starttab.btn.addEventListener(MouseEvent.ROLL_OUT,doMouseOutStartTab);

		var battletop:MovieClip=new MovieClip();
		addChild(battletop);
		ViewsContainer.battleTop=battletop;

		var soundctrl:SoundController=new SoundController();
		soundctrl.x=985;

		addChild(soundctrl);

	}
	private function onStageBGComplete(e:LoaderEvent):void
	{
		var swfloader:SWFLoader = LoaderMax.getLoader("background");
		background=swfloader.getSWFChild("bg") as MovieClip;
		background.gotoAndStop(1);

		//var stageID:Number=Math.floor(Math.random()*background.mc.totalFrames)+1;
		//trace("BattleScene.onStageBGComplete battle_type=",battle_type);
		var stageID:Number=1;
		switch(battle_type){

			case "practice":
				stageID=2;
				break
			case "random_battle":
				var currentlabel:String=DataContainer.currentLabel;
				DebugTrace.msg("BattleScene.onStageBGComplete currentLabel="+currentlabel);
				if(currentlabel=="BeachScene" || currentlabel=="ThemedParkScene" ||
						currentlabel=="GardenScene" || currentlabel=="ParkScene" || currentlabel=="PierScene"){
					stageID=5;
				}else{
					stageID=3;
				}
				var dateStr:String = flox.getSaveData("date");
				var _time:Number = Number(dateStr.split("|")[1]);
				if(_time==24){
					stageID++;
				}

				break


		}
		//DebugTrace.msg("BattleScene.onStageBGComplete background.width"+background.width);

		background.width=1224;
		background.x=-100;
		background.y=memberWH;

		background.mc.gotoAndStop(stageID);

		DataContainer.stageID=stageID;

		setupBattleStage();
	}

	private function setupBattleStage():void
	{

		initBattleSkills();
		memberscom.init(battlescene);
		memberscom.initPlayerMember(doSelectPlayer);
		memberscom.addPlayerMemberListener(doSelectPlayer);
		memberscom.initCpuMember();


		initElementBar();
		elestonecom.initStoneBar(menuscene);

		updateStepLayout("solider");
	}


	private function initBattleSkills():void
	{
		var allSkill:Array=new Array();
		var flox:FloxInterface=new FloxCommand();
		var _skillsys:Object=flox.getSyetemData("skillsys");
		for(var skill:String in _skillsys)
		{
			var _skill:Object=_skillsys[skill];
			allSkill.push(_skill.label);
		}
		//for
		DataContainer.skillsLabel=allSkill;

	}
	private function updateProfile(name:String):void
	{
		profile.alpha=0;
		profile.gotoAndStop(name);
		TweenMax.to(profile,0.5,{alpha:1,easing:Expo.easeOut,onComplete:onUpdateProfile});

		function onUpdateProfile():void
		{
			TweenMax.killTweensOf(profile);

		}
	}
	private function updateHonourSkillPts(name:String):void
	{


		var Hformat:TextFormat=new TextFormat();
		Hformat.color=0xFFCC33;
		Hformat.font="SimNeogreyMedium";

		var ptsformat:TextFormat=new TextFormat();
		ptsformat.color=0xD31044;
		ptsformat.font="SimNeogreyMedium";

		hptsbar.hxt.defaultTextFormat=Hformat;
		hptsbar.ptsTxt.defaultTextFormat=ptsformat;

		var honours:Object=flox.getSaveData("honor");
		hptsbar.hxt.embedFonts=true;
		hptsbar.hxt.text=String(honours[name]);

		var skillPts:Object=flox.getSaveData("skillPts");
		hptsbar.ptsTxt.embedFonts=true;
		hptsbar.ptsTxt.text=String(skillPts[name]);


	}
	private function doStartBattle(e:MouseEvent):void
	{
		removeCardNote();
		var success:Boolean=true;
		var formation:Array=flox.getSaveData("formation");
		var playerteam:Array=memberscom.getPlayerTeam();

		//memberscom.playerReadyPickupCard("all");
		for(var i:uint=0;i<playerteam.length;i++)
		{
			if(playerteam[i].power.label)
			{
				DebugTrace.msg("BattleScene.doStartBattle playerteam["+i+"].power="+JSON.stringify(playerteam[i].power));
				if(playerteam[i].power.target=="")
				{
					success=false;
					break
				}
				//if
			}
			//if
		}
		//for

		if(success)
		{
			focusHandle("default");
			fighting=true;
			updateStepLayout("startbattle");
			memberscom.removeAllEquidedCards();
			memberscom.removePlayerMemberListener(doSelectPlayer);
			removeElEmentPanel();

		}
		else
		{
			var msg:String="Select target first!";
			//MainCommand.addAlertMsg(msg);
			command.addAttention(msg)
		}
		//if

	}
	private function onBattleSceneComplete():void
	{
		TweenMax.killTweensOf(battlescene);
		TweenMax.killTweensOf(menuscene);

		elestonecom.spentStones();
		onCardFadeout();

		callCPUReadFight();

		initAllPower();
		startBattle();
	}
	private function doMouseOverStartTab(e:MouseEvent):void
	{
		TweenMax.to(starttab.btn,0.5, {frameLabel:"over",onComplet:onTweenComplete,onCompleteParams:[starttab]});

	}
	private function doMouseOutStartTab(e:MouseEvent):void
	{
		TweenMax.to(starttab.btn,0.5, {frameLabel:"out",onComplet:onTweenComplete,onCompleteParams:[starttab]});
		//TweenMax.to(starttab,0.5, {frameLabel:"out"});
	}
	private function onSEbarFadein():void
	{
		TweenMax.killTweensOf(sebar);
	}
	private function onHSPtsbarFadein():void
	{
		TweenMax.killTweensOf(hptsbar);
	}
	private function onMenuBgFadein():void
	{
		TweenMax.killTweensOf(menubg);
	}
	private function initElementBar():void
	{
		elementsbar=new Elementsbar();
		elementsbar.x=1024;
		elementsbar.y=326;
		menuscene.addChild(elementsbar);
		//TweenMax.to(elementsbar,0.2,{x:352,onComplet:onTweenComplete,easing:Elastic.easeOut});	

	}
	private function updateESbar():void
	{
		playerteam=memberscom.getPlayerTeam();
		var formation:Array=flox.getSaveData("formation");
		var loves:Object=flox.getSaveData("love");

		//var combat:Number=Number(current_player.name.split("player").join(""));
		var player_name:String=current_player.power.name;
		var se:Number=current_player.power.se;
		var love:Number=loves[player_name];
		DebugTrace.msg("BattleScene.updateESbar se/love:"+se+"/"+love);


		var format:TextFormat=new TextFormat();
		format.color=0xFFFFFF;
		format.font="SimNeogreyMedium";

		sebar.txt.embedFonts=true;
		sebar.txt.defaultTextFormat=format;
		sebar.txt.text=se+"/"+love;
		var percent:Number=Math.floor(Number((se/love).toFixed(2))*100);
		sebar.bar.gotoAndStop(percent);

	}
	//private var temp_powers:Array=new Array();
	private function doDefinePlayerControler(e:Event):void
	{

		DebugTrace.msg("BattleScene.doDefinePlayerControler slisten="+e.target.listen);
		if(!e.target.listen)
		{
			memberscom.removePlayerMemberListener(doSelectPlayer);
		}
		else
		{
			memberscom.addPlayerMemberListener(doSelectPlayer);
		}

	}
	private function doSelectPlayer(e:MouseEvent):void
	{

		TweenMax.to(menubg,0.5,{y:120,onComplete:onMenuBgFadein,easing:Elastic.easeOut});
		TweenMax.to(sebar,0.4,{y:325,onComplete:onSEbarFadein,easing:Elastic.easeOut});
		TweenMax.to(hptsbar,0.3,{y:367,onComplete:onHSPtsbarFadein,easing:Elastic.easeOut});
		DebugTrace.msg("BattleScene.doSelectPlayer id:"+e.target.name);
		var gender:String=flox.getSaveData("avatar").gender;
		var id:String=e.target.name;
		var battleteam:Object=memberscom.getBattleTeam();
		current_player=battleteam[id];
		var power:Object=current_player.power;
		var profile_name:String=power.name;
		if(profile_name=="player"){
			profile_name+="_"+gender;
		}
		DebugTrace.msg("BattleScene.doSelectPlayer profile_name="+profile_name);
		playerteam=memberscom.getPlayerTeam();

		for(var i:uint=0;i<playerteam.length;i++)
		{
			if(id==playerteam[i].name)
			{
				player_index=i;
				break
			}
			//if
		}
		//for
		DebugTrace.msg("BattleScene.doSelectPlayer  player_index:"+player_index);
		DebugTrace.msg("BattleScene.doSelectPlayer  current_player:"+current_player.name+" , power="+JSON.stringify(power));
		updateProfile(profile_name);
		updateHonourSkillPts(power.name);

		memberscom.setPlayerIndex(player_index);

		if(power.skillID!="")
		{

			//selected target 

			try
			{
				elestonecom.releaseStones(power.readystones);
			}
			catch(e:Error)
			{
				DebugTrace.msg("BattleScene.doSelectPlayer : Didn't select gems yet")
			}

			//current_player.onSelected();
			power.label="";
			power.skillID="";
			power.target="";
			power.targetlist=new Array();
			current_player.updatePower(power);
			play_power[player_index]=null;

			memberscom.removeEquipedCard();
			reseatCpuTeam();
			updateESbar();

		}
		else
		{


			reseatCpuTeam();
			updateESbar();

		}
		//if
		/*if(cardsSprtie)
		 {
		 TweenMax.to(cardsSprtie,0.5,{y:800,onComplete:onCardFadeout,ease:Elastic.easeInOut});
		 }
		 //if*/

		showItemsPanel(false);
		memberscom.playerReadyPickupCard(id);
		removeElEmentPanel();


		initElementPanel();

		updateStepLayout("skill");


	}


	private function onPlayLabelComplete():void
	{

		DebugTrace.msg("BattleScene.onPlayLabelComplete");

	}
	private var skillsys:Object;
	private function initSkillCard():void
	{
		cardsSprtie=new Sprite();
		cardsSprtie.x=250;
		cardsSprtie.y=120;
		menuscene.addChild(cardsSprtie);
		playerteam=memberscom.getPlayerTeam();
		current_player=playerteam[player_index];
		//var combat:Number=Number(current_player.name.split("player").join(""));
		var formation:Array=flox.getSaveData("formation");
		var player_name:String=current_player.power.name;
		skillsys=flox.getSyetemData("skillsys");

		//DebugTrace.msg("BattleScene.initSkillCard  skillsys="+JSON.stringify(skillsys));

		var skillstr:String=flox.getSaveData("skills")[player_name][element];
		var skills:Array=new Array();
		if(skillstr.indexOf(",")!=-1)
		{
			skills=skillstr.split(",");
		}
		else
		{
			if(skillstr!="")
			{
				skills.push(skillstr);
			}
			//if
		}
		//if
		//DebugTrace.msg("BattleScene.onPlayLabelComplete  skills:"+skills);
		for(var i:uint=0;i<skills.length;i++)
		{
			var card:MovieClip=new SkillsCards();
			card.name=skills[i];
			card.width=180;
			card.height=224;
			card.gotoAndStop(element);
			card.face.gotoAndStop(skills[i]);
			card.face.mouseChildren=false;
			card.face.buttonMode=true;
			if(skillsys[skills[i]].note=="")
			{
				card.notebtn.visible=false;
			}
			//if
			card.x=900;
			cardsSprtie.addChild(card);
			TweenMax.to(card,0.5,{x:i*(card.width+10),delay:i*0.05,ease:Quint.easeInOut,onComplete:onSkillComplete,onCompleteParams:[card]});


			card.face.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverCard);
			card.face.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutCard);
			card.face.addEventListener(MouseEvent.MOUSE_DOWN,onMouseClickCard);
			card.notebtn.addEventListener(MouseEvent.MOUSE_DOWN,onClickCardNote);

		}
		//for
		command.playSound("CardTrans");

	}
	private var cardnote:MovieClip;
	private function onSkillComplete(card:MovieClip):void
	{
		TweenMax.killTweensOf(card);
		/*
		 card.face.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverCard);
		 card.face.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutCard);
		 card.face.addEventListener(MouseEvent.MOUSE_DOWN,onMouseClickCard);
		 card.notebtn.addEventListener(MouseEvent.MOUSE_DOWN,onClickCardNote);
		 */
	}
	private function onClickCardNote(e:MouseEvent):void
	{
		removeCardNote();
		var loaderReq:LoaderRequest=new LoaderRequest();
		loaderReq.setLoaderQueue("cardnote","../swf/skillsCardsNote.swf",e.target.parent,onCardNoteComplete);
		var skill_id:String=e.target.parent.name;
		DebugTrace.msg("BattleScene.onClickCardNote  skill_id:"+skill_id);
		function onCardNoteComplete():void
		{
			var swfloader:SWFLoader = LoaderMax.getLoader("cardnote");

			cardnote=swfloader.getSWFChild("card") as MovieClip;

			TweenMax.to(cardnote,0.2,{frameLabel:"over"});
			var note:String="<p><font size='14' align='justify'>"+skillsys[skill_id].note+"</font></p>";
			//var format:TextFormat=new TextFormat();
			//format.size=16;
			//cardnote.note.txt.defaultTextFormat=format;
			cardnote.note.txt.htmlText=note;
			//cardnote.note.txt.text=note;
			cardnote.addEventListener(MouseEvent.CLICK,doDisabledCardNote);
		}

	}
	private function doDisabledCardNote(e:MouseEvent):void
	{
		TweenMax.to(cardnote,0.2,{frameLabel:"out",onComplete:onCompleteFlip});

		function onCompleteFlip():void
		{
			removeCardNote();

		}
	}
	private function removeCardNote():void
	{
		try
		{
			LoaderMax.getLoader("cardnote").unload();
		}
		catch(e:Error)
		{
			DebugTrace.msg("BattleScene.removeCardNote  Null");
		}

	}
	private var reqJewel:Array;
	private function onMouseOverCard(e:MouseEvent):void
	{

		//DebugTrace.msg("BattleScene.onMouseOverCard  skillsys:"+JSON.stringify(skillsys));
		command.playSound("CardSelect");
		removeCardNote();
		TweenMax.to(e.target.parent, 0.2, {y:-10,ease:Quint.easeInOut,dropShadowFilter:{color:0x000000, alpha:1, blurX:12, blurY:10, distance:5}});

		var skillID:String=e.target.parent.name;
		var skill:Object=skillsys[skillID];

		var sysJewel:String=skill.jewel;
		reqJewel=new Array();
		if(sysJewel.indexOf(",")!=-1)
		{
			reqJewel.push(sysJewel);
		}
		else
		{
			reqJewel=sysJewel.split(",");
		}
		//if
		elestonecom.showElementRequest(reqJewel);
		new_req_list=elestonecom.getNewReqList();
	}
	private function onMouseOutCard(e:MouseEvent):void
	{

		TweenMax.to(e.target.parent,0.2,{y:0,ease:Quint.easeInOut,onComplete:onTweenComplete,dropShadowFilter:{color:0x000000, alpha:0, blurX:0, blurY:0, distance:0},onCompleteParams:[e.target.parent]});
		if(reqJewel)
		{
			if(reqJewel.length>0)
			{
				elestonecom.releaseElementRequest();
			}
			//if
		}
		//if
	}

	//new_req_list

	private function onMouseClickCard(e:MouseEvent):void
	{
		command.playSound("CardPick");


		DebugTrace.msg("BattleScene.onMouseClickCard skillsys:"+JSON.stringify(skillsys));

		var battleteam:Object=memberscom.getBattleTeam();
		var player_team:Array=memberscom.getPlayerTeam();

		var member:Member=battleteam[current_player.name];
		var battledata:BattleData=new BattleData();
		var member_name:String=current_player.name;
		var power:Object=member.power;
		//DebugTrace.msg("BattleScene.onMouseClickCard current_player name:"+current_player.name);
		//DebugTrace.msg("BattleScene.onMouseClickCard power:"+JSON.stringify(power));
		//memberscom.praseMemberPart(member,"ready",member_name);
		var id:String=e.target.parent.name;

		var skill:Object=skillsys[id];
		skill.skillID=id;

		DebugTrace.msg("BattleScene.onMouseClickCard skill:"+JSON.stringify(skill));

		//new_req_list=elestonecom.getNewReqList();
		//DebugTrace.msg("BattleScene.onMouseClickCard new_req_list:"+new_req_list);

		var lockHeal:Boolean=false;
		var survive:Number=0;
		for(var i:uint=0;i<player_team.length;i++)
		{
			if(player_team[i].power.se>0)
			{
				survive++;
			}
		}
		if(skill.skillID=="n1" || skill.skillID=="n2")
		{
			if(player_team.length==1 || survive<=1)
			{
				lockHeal=true;
			}
			//if
		}
		//if

		if(new_req_list.indexOf(null)!=-1 || new_req_list.length<1)
		{
			var msg:String="NOT ENOUGH GEMS!";
			command.addAttention(msg);
			//DebugTrace.msg("BattleScene.onMouseClickCard: "+msg);
		}
		else if(lockHeal)
		{
			msg="No target in the team.";
			command.addAttention(msg);
		}
		else
		{
			removeElEmentPanel();
			memberscom.removeEquipedCard();
			if(player_index<5)
			{
				//Skill System default data

				for(var j:String in skill)
				{
					power[j]=skill[j];
				}
				//for

				var play_se:Object=new Object();

				var SkillUpdated:Object=new Object();
				//var SkillUpdated:Object=battledata.skillCard(member,skill);
				var skillPower:Number=battledata.skillCard(member,skill.power);
				DebugTrace.msg("BattleScene.onMouseClickCard skillPower:"+skillPower);

				power.power=skillPower;
				power.from="player";
				power.target="";
				power.targetlist=new Array();
				memberscom.equipedCard(power.id,e.currentTarget as MovieClip);

				var act:String="ATTACK";
				switch(power.skillID)
				{
					case "a0":
					//Air Shield
					case "w0":
						//Water Barrier
						command.playSound("BattleConfirm");
						act="SHIELD";
						power.target=current_player.name;
						break;
					case "n0":
						//Regenerate
						command.playSound("BattleConfirm");
						act="REGENERATE";
						power.target=current_player.name;
						break;
					case "n1":
					case "n2":
						//Heal
						act="HEAL";
						//memberscom.removePlayerMemberListener(doSelectPlayer)
						break;
					case "n3":
						//Reincarnation
						command.playSound("BattleConfirm");
						act="REINCARNATION";
						power.target=current_player.name;
						break
				}
				//switch
				switch(act)
				{
					case "ATTACK":
						//starttab.wall.visible=true;
						//starttab.wall.x=500;
						targetArea=BattleData.rangeMatrix(power);

						updateStepLayout("target");
						focusHandle("target");

						memberscom.choiceTarget(doSetupTarget,doMouseOverTarget,doMouseOutTarget);
						break;
					case "SHIELD":
					case "REGENERATE":
					case "REINCARNATION":
						//starttab.wall.visible=true;

						updateStepLayout("heal target");
						updateStepLayout("solider");

						//focusHandle("target");
						//focusHandle("default");
						//focusHandle("solider");

						break;
					case "HEAL":
						memberscom.removePlayerMemberListener(doSelectPlayer);
						updateStepLayout("heal target");
						player_team=memberscom.getPlayerTeam();
						for(var k:uint=0;k<player_team.length;k++)
						{
							if(current_player.name!=player_team[k].power.id && player_team[k].power.se>0)
							{
								var memberEvt:BattleEvent=player_team[k].memberEvt;
								memberEvt.enabledMemberHeal();
							}
						}
						//for
						break
				}
				//switch

				DataContainer.currentPower=power;
				member.updatePower(power);

				memberEvt=member.memberEvt;
				memberEvt.processAction();
				memberEvt.removeMemberHeal();

				member.setupSkillAni();
				play_power[player_index]=member.power;
				DebugTrace.msg("BattleScene.doSetupSkillCard power:"+JSON.stringify(member.power));

				//TweenMax.to(cardsSprtie,0.5,{y:800,onComplete:onCardFadeout,ease:Elastic.easeInOut});
				e.target.removeEventListener(MouseEvent.MOUSE_OUT,onMouseOutCard);

				elestonecom.readyElementStones();


			}
			//if
		}
		//if
	}
	private function usedHealHandle(e:Event):void
	{
		var battleteam:Object=memberscom.getBattleTeam();
		var member:Member=battleteam[current_player.name];
		DebugTrace.msg("BattleScene.usedHealHandle target:"+e.target.id+", healarea="+e.target.healarea);

		if(e.target.id)
		{
			//Heal

			member.power.target=e.target.id;
			member.power.targetlist=[e.target.id];
		}
		else
		{
			//Heal Area

			var healarea:Array=e.target.healarea;
			member.power.target=healarea[0].name;
			var targetlist:Array=new Array();
			for(var i:uint=0;i<healarea.length;i++)
			{
				//DebugTrace.msg("BattleScene.usedHealHandle healarea power:"+JSON.stringify(healarea[i].power));
				targetlist.push(healarea[i].power.combat)

			}
			//for
			member.power.targetlist=targetlist;

		}
		//if
		member.updatePower(member.power);
		DebugTrace.msg("BattleScene.usedHealHandle member.power:"+JSON.stringify(member.power));

		play_power[player_index]=member.power;
		//DebugTrace.msg("BattleScene.usedHealHandle heal_target:"+heal_target);

		updateStepLayout("solider");

		DataContainer.currentPower=new Object();

		var player_team:Array=memberscom.getPlayerTeam();
		for(var k:uint=0;k<player_team.length;k++)
		{
			var memberEvt:BattleEvent=player_team[k].memberEvt;
			memberEvt.removeMemberHeal();
		}
		//for

		memberscom.addPlayerMemberListener(doSelectPlayer);

	}
	private var battleAlert:MovieClip;
	private function doCommanderRage():void
	{
		starttab.btn.visible=false;
		removeElEmentPanel();
		//focusHandle("default");
		//battleAlert=new BattleCryAlert();
		//battleAlert.alpha=0;
		//addChild(battleAlert);
		var index:Number=-1;
		try
		{
			var id:String=current_player.power.id;
			index=id.indexOf("player");
		}
		catch(e:Error)
		{
			index=-1;
		}
		if(index==-1)
		{
			//cpu
			rtSec=3
			var msg:String="Enemy uses Battle Cry";
			command.addAttention(msg);

		}
		else
		{
			rtSec=1;

		}
		doRageAction();
		//TweenMax.to(battleAlert,2,{alpha:1,onComplete:doRageAction})

	}
	private var rageTimer:Timer;
	private var rtSec:Number=0;
	private function doRageAction():void
	{

		rageTimer=new Timer(1000,rtSec);
		rageTimer.addEventListener(TimerEvent.TIMER_COMPLETE,onBattleAlertFadeOut);
		rageTimer.start();
		//TweenMax.delayedCall(10,onBattleAlertFadeOut);

		/*function doBattleAlertFadeOut():void
		 {
		 TweenMax.killDelayedCallsTo(doBattleAlertFadeOut);

		 //TweenMax.to(battleAlert,1,{alpha:0,onComplete:onBattleAlertFadeOut});
		 onBattleAlertFadeOut();
		 }*/




	}
	private function onBattleAlertFadeOut(e:TimerEvent):void
	{
		//BattleAlertFadeOut

		rageTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,onBattleAlertFadeOut);

		//TweenMax.killDelayedCallsTo(onBattleAlertFadeOut);

		try
		{
			LoaderMax.getLoader("attention").unload();
		}
		catch(e:Error)
		{
			DebugTrace.msg("BattleScene.onBattleAlertFadeOut LoaderMax unload attention Error");
		}
		//TweenMax.killTweensOf(battleAlert); 

		//removeChild(battleAlert);



		//	DebugTrace.msg("BattleScene.onBattleAlertFadeOut commander:"+commander.name);
		if(commander.name.indexOf("player")!=-1)
		{
			var members:Array=memberscom.getPlayerTeam();
			comType="item";
		}
		else
		{
			members=memberscom.getCpuTeam();
			comType="skill";
		}
		//if


		commander.power.speeded="true";
		commander.updatePower(commander.power);
		commander.updateStatus("");

		var battleEvt:BattleEvent=commander.memberEvt;
		battleEvt.act="BattleCry";
		battleEvt.updateMemberAct();
		battleEvt.from="Rage";
		battleEvt.actComplete();


		TweenMax.delayedCall(2,onMemberBattleCry,[members]);
	}
	private function onMemberBattleCry(members:Array):void
	{
		TweenMax.killDelayedCallsTo(onMemberBattleCry);


		for(var i:uint=0;i<members.length;i++)
		{
			var member:Member=members[i];
			if(member.power.se>0)
			{
				if(member.power.name!="player" || Number(member.name.split("_")[1])!=0)
				{
					member.power.speeded="true";
					member.updatePower(member.power);
					member.updateStatus("");


					var battleEvt:BattleEvent=member.memberEvt;
					battleEvt.from="onCommnadBattleCryComplete";
					battleEvt.act="rage";
					battleEvt.updateMemberAct();
					battleEvt.from="Rage";
					battleEvt.actComplete();
				}
				//if

			}
			//if
		}
		//for

		//onBattleCryComplete();

		TweenMax.delayedCall(2,onBattleCryComplete);
	}
	private function onBattleCryComplete():void
	{

		TweenMax.killDelayedCallsTo(onBattleCryComplete);

		updateStepLayout("solider");

		//focusHandle("solider");
		//starttab.wall.visible=false;

		showItemsPanel(false);

		if(commander.name.indexOf("player")==-1)
		{
			//cpu
			memberscom.reseatCPUPower(commander.name);
		}

		starttab.btn.visible=true;
		starttab.wall.visible=false;
		initTeamPos();
		focusHandle("default");
		focusHandle("solider");

	}
	private function doBootItemHandle(attr:String):void
	{
		//BootSkills
		var members:Array=memberscom.getPlayerTeam();
		var format:TextFormat=numbersTextFormat(attr);
		var _data:Object=new Object();
		_data=flox.getSaveData(attr);
		for(var i:uint=0;i<members.length;i++)
		{
			var member:Member=members[i];
			if(member.power.se>0)
			{
				//if(member.power.name!="player" || Number(member.name.split("_")[1])!=0)
				//{	


				var battleEvt:BattleEvent=member.memberEvt;
				battleEvt.act="charge";
				battleEvt.updateMemberAct();
				//battleEvt.from="BootComplete";
				//battleEvt.actComplete();
				//}
				//if

				var boot_txt:TextField=new TextField();
				boot_txt.width=memberWH;
				boot_txt.autoSize=TextFieldAutoSize.CENTER;
				boot_txt.embedFonts=true;
				boot_txt.defaultTextFormat=format;
				var  txt_x:Number=member.x-memberWH/4;
				showSplitTextField(member,"+1",boot_txt,txt_x);
				var value:Number=_data[member.power.name];
				value++;
				_data[member.power.name]=value;
			}
			//if
		}
		//for

		flox.save(attr,_data);
		updateStepLayout("solider");


	}
	private function onSavedToFormation():void
	{
		DebugTrace.msg("BattleScene.onFormationSave");

		starttab.wall.visible=true;



		var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
		gameEvt._name="remove_battle";
		gameEvt.displayHandler();


		var command:MainInterface=new MainCommand();
		var _data:Object=new Object();
		if(comType=="item")
		{

			_data.name= "ChangeFormationScene";
		}
		else
		{
			_data.name= "BattleScene";
		}
		//if
		command.sceneDispatch(SceneEvent.CHANGED,_data);
	}
	private function displayAttackArea():void
	{
		//cpu_team=memberscom.getCpuMainTeam();
		cputeam=memberscom.getCpuTeam();
		var power:Object=current_player.power;
		var combat:Number=power.combat;


		for(var j:uint=0;j<cputeam.length;j++)
		{
			for(var k:uint=0;k<targetArea.length;k++)
			{
				//DebugTrace.msg("BattleScene.displayAttackArea pu_team["+j+"].power.combat="+cputeam[j].power.combat);
				if(targetArea[k]==cputeam[j].power.combat)
				{

					var cpu_target:Member=cputeam[j];
					TweenMax.to(cpu_target,0.25,{colorTransform:{tint:0xFFFFFF, tintAmount:0.9}});
					TweenMax.to(cpu_target,0.25,{delay:0.25,removeTint:true,onComplete:onCompleteTint,onCompleteParams:[cpu_target]});

				}
				//if
			}
			//for

		}
		//for
	}
	private function onCompleteTint(cpu_target:Member):void
	{
		//TweenMax.killAll(true);
		TweenMax.killTweensOf(cpu_target);
		displayAttackArea();

	}
	private function removeDisplayAttackArea():void
	{
		cputeam=memberscom.getCpuTeam();
		for(var i:uint;i<cputeam.length;i++)
		{
			TweenMax.to(cputeam[i],0.1,{ tint:null,onComplete:onRemoveTintComplete,onCompleteParams:[cputeam[i]]});

		}
		//for
		function onRemoveTintComplete(member:Member):void
		{
			TweenMax.killTweensOf(member);
		}
	}
	private function onCardFadeout():void
	{

		try
		{
			TweenMax.killTweensOf(cardsSprtie);
			menuscene.removeChild(cardsSprtie);
			cardsSprtie=null;
		}
		catch(e:Error)
		{
			//error
		}

		//TweenMax.to(elepanel,0.5,{alpha:.5,ease:Elastic.easeInOut,onComplete:onTweenComplete});
	}


	private function reseatCpuTeam():void
	{
		memberscom.reseatCpuTeam(doSetupTarget,doMouseOverTarget,doMouseOutTarget);
	}
	private var combat:Number;
	private function checkInAttackArea(target:Member):Boolean
	{
		//var battleteam:Object=memberscom.getBattleTeam();
		//var member:Member=battleteam[target.name];	
		DebugTrace.msg("BattleScene.checkInAttackArea  target.power="+JSON.stringify(target.power));
		var inArea:Boolean=false;
		//var skillarea:Array=BattleData.rangeMatrix(target.power.area);

		combat=target.power.combat;
		//if(skillarea.indexOf(combat)!=-1 && target.power.se>0)
		if(targetArea.indexOf(combat)!=-1 && target.power.se>0)
		{
			inArea=true;
		}
		return inArea;
	}
	private function doSetupTarget(e:MouseEvent):void
	{
		//current_player

		var battleteam:Object=memberscom.getBattleTeam();
		var power:Object=current_player.power;
		var id:String=effectSwichId(e.target.name);
		var member:Member=battleteam[id];

		var inArea:Boolean=checkInAttackArea(member);

		if(inArea)
		{

			command.playSound("BattleConfirm");

			reseatCpuTeam();
			power.target=id;

			if(player_index<playerteam.length)
			{
				power.targetlist=targetArea;
				DebugTrace.msg("BattleScene.doSetupTarget power :"+JSON.stringify(power));
				play_power[player_index]=power;
				current_player.updatePower(power);
				//current_player.processAction();
				//DebugTrace.msg("BattleScene.doSetupTarget play_power["+player_index+"]="+JSON.stringify(play_power[player_index]));


				updateStepLayout("solider");

				//starttab.wall.x=0;
				//starttab.wall.visible=false;


				for(var i:uint=0;i<cputeam.length;i++)
				{
					TweenMax.killTweensOf(cputeam[i]);
					TweenMax.to(cputeam[i],0.2,{tint:null});
					var arrow:MovieClip=cputeam[i].membermc.getChildByName("arrow") as MovieClip;
					arrow.visible=false;
				}


				//member.onSelected();
			}
			else
			{
				//finish selected target
				/*for(var k:uint=0;k<play_power.length;k++)
				 {
				 DebugTrace.msg("BattleScene.doSetupTarget play_power:"+JSON.stringify(play_power[k]));
				 }
				 //for
				 */
			}
			//if
			focusHandle("default");
			focusHandle("solider");
		}
		//if
	}

	private function doMouseOverTarget(e:MouseEvent):void
	{
		//TweenMax.killAll(true);	

		var cputeam:Array=memberscom.getCpuTeam();
		var battleteam:Object=memberscom.getBattleTeam();
		//DebugTrace.msg("BattleScene.doMouseOverTarget "+e.target.name )
		var id:String=effectSwichId(e.target.name);

		//DebugTrace.msg("BattleScene.doMouseOverTarget id="+id);
		var power:Object=current_player.power;
		var combat:Number=battleteam[id].power.combat;

		//DebugTrace.msg("BattleScene.doMouseOverTarget battleteam power:"+JSON.stringify(battleteam[id].power));
		var battledata:BattleData=new BattleData();
		targetArea=battledata.praseTargetList(power,combat);

		var membermc:MovieClip=battleteam[id].membermc;
		var arrow:MovieClip=membermc.getChildByName("arrow") as MovieClip;
		arrow.visible=checkInAttackArea(battleteam[id]);

		//DebugTrace.msg("BattleScene.doMouseOverTarget combat:"+combat+" ,targetArea:"+targetArea);
		//displayAttackArea();
		removeDisplayAttackArea();
		for(var i:uint=0;i<targetArea.length;i++)
		{
			for(var j:uint=0;j<cputeam.length;j++)
			{
				if(cputeam[j].power.combat==targetArea[i])
				{
					command.playSound("BattlePointer");
					arrow=cputeam[j].membermc.getChildByName("arrow") as MovieClip;
					arrow.visible=true;
				}
				//if
			}
			//for
		}
		//for
	}
	private function doMouseOutTarget(e:MouseEvent):void
	{
		var battleteam:Object=memberscom.getBattleTeam();
		var id:String=effectSwichId(e.target.name);
		var membermc:MovieClip=battleteam[id].membermc;
		var arrow:MovieClip=membermc.getChildByName("arrow") as MovieClip;
		arrow.visible=false;
		removeDisplayAttackArea();
		var power:Object=current_player.power;
		targetArea=BattleData.rangeMatrix(power);
		displayAttackArea();
		var cputeam:Array=memberscom.getCpuTeam();
		for(var i:uint=0;i<cputeam.length;i++)
		{
			arrow=cputeam[i].membermc.getChildByName("arrow") as MovieClip;
			arrow.visible=false;
		}
		//for
	}
	private function effectSwichId(_id:String):String
	{
		var id:String=_id
		if(_id.indexOf("dizzy")!=-1)
		{
			id=_id.split("dizzy_").join("");
		}
		return id;

	}

	private function restartRound():void
	{
		DebugTrace.msg("BattleScene.restartRound");
		player_index=0;
		attack_index=0;
		play_power=new Array();

		//sebar.y=325;
		//hptsbar.y=367;
		menubg.y=450;
		profile.alpha=0;
		TweenMax.to(starttab.btn,0.5,{y:709});
		TweenMax.to(battlescene,1,{y:stageDeY,onComplete:onSceneAlready});
		TweenMax.to(menuscene,1,{y:354});

	}
	private function onSceneAlready():void
	{
		DebugTrace.msg("BattleScene.onSceneAlready");
		TweenMax.killTweensOf(battlescene);
		TweenMax.killTweensOf(menuscene);

		fighting=false;
		starttab.wall.visible=false;



		memberscom.nextRound();
		reseatCpuTeam();
		memberscom.addPlayerMemberListener(doSelectPlayer);
		memberscom.clearPlayerTarget();
		memberscom.playerReadyPickupCard("all");
		elestonecom.onNewRoundWithStones();
		updateStepLayout("solider");
	}
	private var allpowers:Array;
	private var attack_index:Number=0;
	private var from:String;
	private var attack_member:Member;
	private var target_member:Member;
	private var start_pos:Point;
	private var ctrl_memeber:MovieClip;
	private var character_name:String;
	//allpowers:{"area":0,"speed":130,"ele":"air","effect":"","combat":5,"power":35,"target":"player3","label":"Whirlwind Punch",
	//"from":"cpu","enemy":1,"jewel":"2|a","id":"t0_1"}
	private function callCPUReadFight():void
	{
		var cputeam:Array=memberscom.getCpuTeam();
		for(var j:uint=0;j<cputeam.length;j++)
		{
			cputeam[j].startFight();
		}
	}
	private var movingX:Number=0;
	private var movingY:Number=0;

	private function initAllPower():void
	{


		var battleteam:Object=memberscom.getBattleTeam();
		allpowers=new Array();
		var cputeam:Array=memberscom.getCpuTeam();

		var cpu_power:Array=new Array();
		var member:Member;
		for(var j:uint=0;j<cputeam.length;j++)
		{
			member=cputeam[j];

			if(member.power.speeded=="true")
			{
				member.power.speed+=member.plus_speed;
				member.updatePower(member.power);
			}
			//if
			cpu_power.push(member.power);
		}
		//for

		var _play_power:Array=new Array();
		for(var i:uint=0;i<play_power.length;i++)
		{

			//DebugTrace.msg("BattleScene.startBattle play_power["+i+"]="+JSON.stringify(play_power[i]));
			if(play_power[i])
			{
				member=battleteam[play_power[i].id];
				var combat:Number=play_power[i].combat;
				var player_name:String=play_power[i].name;

				//DebugTrace.msg("BattleScene.startBattle play_power["+i+"]="+JSON.stringify(play_power[i]));
				if(play_power[i].speeded=="true")
				{
					play_power[i].speed+=member.plus_speed;

				}
				//if
				//if(seObj[player_name]>0)
				//{
				play_power[i].se=member.power.se;
				member.updatePower(play_power[i]);
				_play_power.push(play_power[i]);
				//DebugTrace.msg("BattleScene.startBattle play_power["+i+"]="+JSON.stringify(play_power[i]));
				//}
				//if
			}
			//if

		}
		//for
		allpowers=_play_power.concat(cpu_power);
		allpowers.sortOn("speed",Array.DESCENDING | Array.NUMERIC);
		for(var k:uint=0;k<allpowers.length;k++)
		{
			DebugTrace.msg("BattleScene.startBattle allpowers["+k+"]="+JSON.stringify(allpowers[k]));
		}
		//for


	}


	private function startBattle():void
	{
		//player pick up skillcard  complete
		//BattleScene.play_power=play_power;

		//memberscom.playerReadyPickupCard("all");
		DebugTrace.msg("BattleScene.startBattle----------------attack_index="+attack_index);
		var sp:Boolean=false;
		var battleteam:Object=memberscom.getBattleTeam();

		from=allpowers[attack_index].from;
		var id:String=allpowers[attack_index].id;
		attack_member=battleteam[id];
		DebugTrace.msg("BattleScene.startBattle  attack_member.power="+JSON.stringify(attack_member.power));
		top_index=memberscom.getTopIndex();
		battlescene.setChildIndex(attack_member,top_index);

		start_pos=new Point();
		start_pos.x=attack_member.x;
		start_pos.y=attack_member.y;
		var seTxt:TextField=battleteam[id].membermc.getChildByName("se") as TextField;
		seTxt.visible=false;

		var se:Number=attack_member.power.se;
		var status:String=attack_member.getStatus();
		var effect:String=attack_member.power.effect;
		var act:String="ATTACK";


		if(se==0 || status=="dizzy" || status=="mind_ctrl" || attack_member.power.target=="")
		{
			act="PASS";
		}
		//if
		if(attack_member.power.skillID=="s0")
		{
			//combo skill
			var cpu_team:Array=memberscom.getCpuTeam();

			for(var i:uint=0;i<cpu_team.length;i++)
			{
				var parnetID:String=cpu_team[i].power.id;

				if(parnetID=="t0_1")
				{
					if(cpu_team[i].power.se==0)
					{
						act="PASS";
					}
					break
				}
			}

		}
		if(act=="ATTACK")
		{
			recordSkillPts(attack_member);

			function getTargetID(target_id,targetlist:Array):String
			{
				//get Target id for combat 
				if(target_id.indexOf("player")!=-1)
				{
					var members:Array=memberscom.getPlayerTeam();
				}
				else
				{
					members=memberscom.getCpuTeam();

				}
				//if
				var target_ids:Array=new Array();
				for(var i:uint=0 ;i<members.length;i++)
				{
					for(var j:uint=0;j<targetlist.length;j++)
					{
						if(members[i].power.combat==targetlist[j])
						{

							target_ids.push(members[i].power.id);
						}
						//if
					}
					//for
				}
				//for
				target_id=target_ids[Math.floor(Math.random()*target_ids.length)];
				return target_id;
			}
			//function
			if(allpowers[attack_index].target!="")
			{
				var target_id:String=allpowers[attack_index].target;
				//DebugTrace.msg("BattleScene.startBattle target_id:"+target_id);
				target_member=battleteam[target_id];
				movingY=target_member.y;

				if(from=="player")
				{
					memberWH=150;
					if(allpowers[attack_index].ch_name=="fat")
					{
						memberWH=300;
					}
					//if
					movingX=target_member.x+memberWH*2;
					var direction:Number=-1;

				}
				else
				{
					var targetlist:Array=allpowers[attack_index].targetlist;
					if(targetlist.length>1)
					{
						target_id=getTargetID(target_id,targetlist);
					}
					//if
					//DebugTrace.msg("BattleScene.startBattle target_id:"+target_id);
					target_member=battleteam[target_id];
					//DebugTrace.msg("BattleScene.startBattle target:"+target);
					movingX=target_member.x-memberWH*2;
					direction=1;
				}
				//if
				var skillID:String=attack_member.power.skillID;
				var boss:Array=Config.bossModels;

				switch(skillID)
				{
					case "f3":
					//Kamikaze Flame
					case "a3":
					//Dragon Dance

					case "n3":
					//Reincarnation
					case "w3":
					//The 12th Night
					case "e3":
					//Exodus Blade
					case "s0":
					//Combine Skill
					case "s1":
					//Mind Control	
					case "gor_s_1":
					case "tgr_s_2":
						var chname:String=attack_member.chname;
						if(chname!="badguy" && chname!="prml")
						{
							sp=true;
							showupSPAni(act);
						}
						else
						{
							shakingBackground();
						}
						break
					case "com0":
						//cpu commander change foramation
						act="STOP";
						changeCPUFormationHandle();
						break
					case "com1":
						//cpu battle cry
						act="STOP";
						//doCommanderRage();
						//onBattleCryComplete();
						break

				}
				//switch
			}
			//if
		}
		//if
		DebugTrace.msg("BattleScene.startBattle allpowers["+attack_index+"]="+JSON.stringify(attack_member.power));

		//var se:Number=allpowers[attack_index].se;
		//var memberseffect:Object=DataContainer.MembersEffect;
		//var effect:String=memberseffect[allpowers[attack_index].id];
		//DebugTrace.msg("BattleScene.startBattle status:"+status);

		//var radius:Number=(Math.abs(movingX-attack_member.x))/2;
		//var circle:CirclePath2D = new CirclePath2D(movingX, target_member.y, radius);
		//var follower:PathFollower = circle.addFollower(attack_member, circle.angleToProgress(180), true);
		//var path:Array=getMovingPath(start_pos,new Point(movingX,target_member.y),direction);
		//tweenmax=new TweenMax(attack_member, 1, {bezierThrough:path,onComplete:doAttackHandle,ease:Quint.easeOut}); 

		//tweenmax=new TweenMax(follower, 2, {progress:circle.followerTween(follower, 180, Direction.COUNTER_CLOCKWISE)});
		//tweenmax=new TweenMax(attack_member, 1, {circlePath2D:{path:circle, startAngle:0, endAngle:180, direction:Direction.COUNTER_CLOCKWISE, extraRevolutions:1}});
		DebugTrace.msg("------------------------------------------------------act="+act);
		DebugTrace.msg("------------------------------------------------------skillID="+attack_member.power.skillID);

		if(!sp)
		{
			//if(attack_member.power.ch_name!="fat")
			doAttachAction(act);
		}

	}
	private var spAni:MovieClip;
	private var end_label:String="";
	private function showupSPAni(act:String):void
	{
		spAni=new MovieClip();
		spAni.name="spAni";
		addChild(spAni);
		attack_member.getGender();
		var member_gender:String=attack_member.gender;
		var skillID:String=attack_member.power.skillID;
		var chname:String=attack_member.chname;
		DebugTrace.msg("BattleScene.showupSPAni chname="+chname+" ,member_gender="+member_gender);
		var loaderReq:LoaderRequest=new LoaderRequest();
		loaderReq.setLoaderQueue("spbg","../swf/skills/SP_BG.swf",spAni,onSPAniComplete);

		function onSPAniComplete(e:LoaderEvent):void
		{

			var swfloader:SWFLoader = LoaderMax.getLoader("spbg");
			var aniMC:MovieClip=swfloader.getSWFChild("spani") as MovieClip;

			if(skillID=="n3")
			{
				end_label="nsp_bgh_out";
				aniMC.gotoAndPlay("nsp_bgh");

			}
			else
			{
				end_label="sp_bg_out";

			}
			//if
			aniMC.ch.gotoAndPlay(1);
			aniMC.addEventListener(Event.ENTER_FRAME,onPlayingSPAni);
			function onPlayingSPAni(e:Event):void
			{

				if(e.target.currentFrameLabel==end_label)
				{
					aniMC.removeEventListener(Event.ENTER_FRAME,onPlayingSPAni);
					onSPAniFadeOut(act)
				}
			}

			if(chname=="player")
			{
				chname=member_gender+chname;
			}
			else if(chname=="ceil")
			{
				chname="ciel";
			}

			aniMC.ch.mc.gotoAndStop(chname);

		}

	}

	private function onSPAniFadeOut(act:String):void
	{
		DebugTrace.msg("BattleScene.onSPAniFadout");
		LoaderMax.getLoader("spbg").unload();
		removeChild(spAni);
		shakingBackground();
		doAttachAction(act);
	}

	private function shakingBackground():void
	{
		var id:String=attack_member.name;
		if(from=="player")
		{
			movingX=710+memberWH;
		}
		else
		{
			movingX=175;
		}
		//if
		despearBatttleTeam(0,id);
		movingY=950;
		//y=-578 battle
		attack_member.x=movingX;
		attack_member.y=movingY;


		background.gotoAndPlay("hard");

		//TweenMax.to(battlescene,1,{y:-568,yoyo:true,repeat:-1,ease:Elastic.easeOut,onComplete:onYoyoComplete});
		function onYoyoComplete():void
		{
			TweenMax.killChildTweensOf(battlescene);
		}
		//if


	}
	private function doAttachAction(act:String):void
	{
		var effect:String=attack_member.power.effect;


		if(act=="ATTACK")
		{


			if(attack_member.power.skillID=="a0" ||  attack_member.power.skillID=="w0")
			{
				//shield
				attack_member.power.shielded="true";
				attack_member.updatePower(attack_member.power);
				doAttackHandle();
			}
			//else if(attack_member.power.skillID=="n3" || attack_member.power.skillID=="e0")
			else if(attack_member.power.skillID=="n3")
			{
				doAttackHandle();
			}
			else
			{
				//except
				if(effect=="regenerate" || effect=="heal")
				{
					//TweenMax.to(attack_member,0.5,{onComplete:doAttackHandle});

					//attack_member.updateStatus(effect);

					doAttackHandle();

				}
				else
				{

					var duration:Number=0.5;
					if(attack_member.power.combat<3)
					{
						duration=0.25;
					}
					//if
					//--------------skill need to HOP or TP------------------------------------------------------------------------------------------------------------
					//DebugTrace.msg("------------------------------>>movingX="+movingX+" , movingY="+movingY);
					switch(attack_member.power.type)
					{
						case "hop":
							var partnertEvt:BattleEvent=attack_member.memberEvt;
							partnertEvt.act="hop";
							partnertEvt.updateMemberAct();


							var offer:Number=0;
							switch(attack_member.power.skillID)
							{
								case "a1":
									offer=60;
									break
								case "a2":
									offer=90;
									break
								case "e0":
									offer=200;
									break
								case "f0":
									offer=280;
									break
								case "f1":
									offer=225;
									break
								case "e1":
									offer=10;
									break
							}
							if(attack_member.name.indexOf("player")!=-1)
							{
								//player
								movingX=movingX+offer;

								extraAttackBossMoving();
							}
							else
							{
								//cpu
								movingX=movingX-offer;

							}
							//if
							attack_member.character.body.addEventListener(Event.ENTER_FRAME,doHopping);
							break
						case "m_hop":
							partnertEvt=attack_member.memberEvt;
							partnertEvt.act="hop";
							partnertEvt.updateMemberAct();

							doHoppingToCenter();
							break
						case "TP":

							TweenMax.delayedCall(1,onAttack);
							break
						default:
							//stay
							//TweenMax.to(attack_member,duration,{x:movingX,y:movingY,onComplete:doAttackHandle});
							TweenMax.delayedCall(1,onAttack);

							break

					}
					function onAttack():void
					{
						TweenMax.killDelayedCallsTo(onAttack);
						doAttackHandle();
					}

					/*		function doTpHandle(e:Event):void
					 {

					 movingX=440;
					 movingY=980;

					 if(e.target.currentFrame==25)
					 {

					 if(attack_member.name.indexOf("player")!=-1)
					 {
					 //player
					 movingX=movingX-memberWH;


					 }
					 else
					 {
					 //cpu
					 movingX=movingX+memberWH;

					 }
					 //if
					 //TweenMax.to(attack_member,duration,{x:Math.floor(_movingX),y:movingY,onComplete:doAttackHandle});
					 attackTweenHandler(attack_member,duration,{x:Math.floor(movingX),y:movingY,onComplete:doAttackHandle});
					 }
					 //if
					 }

					 */
					function doHopping(e:Event):void
					{
						//DebugTrace.msg("------------------------------>>>>currentFrameLabel="+attack_member.skillAni.body.currentFrameLabel);
						var _body:MovieClip=attack_member.character.body;
						if(_body.currentFrameLabel=="moving")
						{


							TweenMax.to(attack_member,duration,{x:movingX,y:movingY});
						}
						//if
						if(_body.currentFrame==_body.totalFrames)
						{
							attack_member.character.body.removeEventListener(Event.ENTER_FRAME,doHopping);


							//TweenMax.to(attack_member,duration,{x:_movingX,y:movingY});
							attackTweenHandler(attack_member,duration,{x:movingX,y:movingY});
							doAttackHandle();

						}
						//if

					}
					//fun
					function doHoppingToCenter():void
					{
						var _body:MovieClip=attack_member.character.body;
						var target:String=attack_member.power.target;
						var battleteam:Object=memberscom.getBattleTeam();
						var target_combat:Number=battleteam[target].power.combat;
						if(attack_member.name.indexOf("player")!=-1)
						{
							if(target_combat==0 || target_combat==1 || target_combat==3 || target_combat==4)
							{
								movingX=748+memberWH;
								movingY=882;
							}
							else
							{
								movingX=698+memberWH;
								movingY=1020;
							}

						}
						else
						{

							movingX=Starling.current.stage.stageWidth/2-attack_member.width/2;
							movingY=950;

						}
						//if
						if(attack_member.power.skillID=="w2" || attack_member.power.skillID=="f2")
						{
							movingY=950;
						}
						switch(attack_member.power.target)
						{
							case "t10_0":
								movingX=movingX-100;
								movingY=970;
								break

						}
						TweenMax.to(attack_member,duration,{x:movingX,y:movingY,onComplete:doAttackHandle});
						//attackTweenHandler(attack_member,duration,{x:_movingX,y:_movingY,onComplete:doAttackHandle});
					}


					//----------------Normal--------------------------------------------------------------------------------------------------------
					//TweenMax.to(attack_member,duration,{x:movingX,y:movingY,onComplete:doAttackHandle});
				}
				//if
			}//if
			DebugTrace.msg("------------------------------>>>>effect="+allpowers[attack_index].effect);
		}
		else if(act=="PASS")
		{
			//attacker se=0 ,dizzy pass attack 
			var setxt:TextField= attack_member.membermc.getChildByName("se") as TextField;
			setxt.visible=true;
			onFinishAttack();
		}
		//if
	}
	private function extraAttackBossMoving():void
	{


		switch(attack_member.power.target)
		{
			case "t10_0":
				movingX+=100;
				movingY=movingY+100;
				break

		}
	}
	private function attackTweenHandler(attacker:Member,dur:Number,paramas:Object):void
	{

		DebugTrace.msg("BattleScene.attackTweenHandler paramas="+JSON.stringify(paramas));
		TweenMax.to(attacker,dur,paramas);
	}
	private function despearBatttleTeam(alpha:Number,id:String):void
	{
		DebugTrace.msg("BattleScene.despearBatttleTeam id="+id+" ; alpha="+alpha);
		var battleteam:Object=memberscom.getBattleTeam();
		var _member:String="";
		var index:Number;
		if(id.indexOf("player")!=-1)
		{
			//player no combine skill 
			var members:Array=memberscom.getPlayerTeam();

		}
		else
		{
			members=memberscom.getCpuTeam();
			var _id:String=id.split("_")[0];
			index=Number(id.split("_")[1]);
			if(index==1)
			{
				index=0;
			}
			else
			{
				index=1;
			}
			partner=_id+"_"+index;
		}
		//if
		for(var i:uint=0;i<members.length;i++)
		{

			if(members[i].name!=id)
			{
				members[i].alpha=alpha;
				//TweenMax.to(members[i],0.5,{alpha:alpha});
			}
			//if

		}
		//for
		if(battleteam[id].power.skillID=="s0")
		{


			DebugTrace.msg("BattleScene.despearBatttleTeam partner="+JSON.stringify(battleteam[partner].power));
			battleteam[partner].alpha=1;
			//TweenMax.to(battleteam[partner],0.5,{alpha:1});
		}
		//if


	}
	private var team:Array;
	private var hitT:Number=0;
	private function doAttackHandle():void
	{
		hitT=0;
		TweenMax.killTweensOf(attack_member);
		attack_member.character.gotoAndStop(1);
		//playing skill visible effect
		var membermc:MovieClip=attack_member.membermc;
		var effectmc:MovieClip=membermc.getChildByName("effect") as MovieClip;
		if(effectmc)
		{
			effectmc.visible=true;
			if(attack_member.status=="scared")
			{
				effectmc.visible=false;
			}
		}



		//DebugTrace.msg("BattleScene.doAttackHandle attack_member:"+attack_member.name);
		var battleteam:Object=memberscom.getBattleTeam();
		team=new Array();
		if(from=="player")
		{

			team=memberscom.getPlayerTeam();

		}
		else
		{
			//attack from cpu
			team=cputeam;

		}
		//if

		//var element:String=allpowers[attack_index].ele.charAt(0).toLocaleUpperCase();
		var act:String=allpowers[attack_index].label;
		var id:String=allpowers[attack_index].id;
		var member:Member=battleteam[id];
		member.getSkillAni();

		DebugTrace.msg("BattleScene.doAttackHandle attack power:"+JSON.stringify(member.power));

		var skillID:String=member.power.skillID;
		switch(skillID)
		{
			/*
			 case "s0":

			 //partner
			 var partnermember:Member=battleteam[partner];
			 var partnertEvt:BattleEvent=partnermember.memberEvt;
			 partnertEvt.act=act;
			 partnertEvt.updateMemberAct();
			 partnertEvt.from="CombineSkill";
			 partnertEvt.actComplete();
			 break
			 */

			default:
				var battleEvt:BattleEvent=member.memberEvt;
				battleEvt.act=act;
				battleEvt.updateMemberAct();
				break
		}
		//switch


		var boss:Array=Config.bossModels;
		member.getSkillAni();

		if(member.power.label.indexOf("_")!=-1 || boss.indexOf(member.power.ch_name)==-1)
		{
			//attack skill


			try
			{
				member.skillAni.alpha=1;
				member.character.alpha=0;

				member.skillAni.body.act.addEventListener(Event.ENTER_FRAME,doActPlaying);
			}
			catch(e:Error)
			{
				DebugTrace.msg("BattleScene.doAttackHandle attack_member.skillAni Null");
				TweenMax.delayedCall(2,onWaitingSkillAni);

				function onWaitingSkillAni():void
				{
					TweenMax.killDelayedCallsTo(onWaitingSkillAni);
					doAttackHandle();
				}
			}
			//try


		}
		else
		{
			//boss or not skill attack animation

			DebugTrace.msg("member.character currentLabel:" +member.skillAni.currentLabel);
			member.character.body.act.addEventListener(Event.ENTER_FRAME,doActPlaying);
		}
		//if
	}
	private function doActPlaying(e:Event):void
	{

		//DebugTrace.msg("BattleScene.doActPlaying:"+e.target.currentFrame+","+e.target.totalFrames)
		//moving stage
		var _movingX:Number;
		var membermc:MovieClip=attack_member.membermc;
		try
		{
			var effectMC:MovieClip=membermc.getChildByName("effect") as MovieClip;
			effectMC.visible=false;
		}
		catch(e:Error)
		{
			DebugTrace.msg("BattleScene.doActPlaying Effect Null");
		}
		switch(attack_member.power.skillID)
		{
			case "e1":
				var endF:Number=attack_member.skillAni.body.act.totalFrames;
				TweenMax.to(battlescene,endF,{y:-100,useFrame:true});
				break;
			case "e3":
				if(	attack_member.skillAni.body.act.currentFrame==290)
				{
					endF=attack_member.skillAni.body.act.totalFrames;
					var tweenf:Number=endF-291;
					TweenMax.to(battlescene,tweenf,{y:-100,useFrame:true});
				}
				break;
			case "f3":

				if(attack_member.skillAni.body.act.currentFrame==74)
				{
					endF=130;
					tweenf=endF-74;
					TweenMax.to(battlescene,tweenf,{y:-100,useFrame:true,onComplete:onAniToTop});
					function onAniToTop():void
					{
						TweenMax.killChildTweensOf(battlescene);
						//endF=185;
						//tweenf=endF-165;
						//TweenMax.to(battlescene,1,{y:stageDeY,onComplete:onAniToBottom});
					}
					function onAniToBottom():void
					{
						TweenMax.killChildTweensOf(battlescene);

					}
				}
				//if
				break;

			case "w1":
				//case "w2":
				var _memberWH:Number=memberWH;
				if(attack_member.power.skillID=="w1")
				{
					_memberWH=memberWH/2;
				}
				if(attack_member.skillAni.body.currentFrame==35)
				{

					if(attack_member.name.indexOf("player")!=-1)
					{
						//player
						_movingX=movingX-_memberWH;
					}
					else
					{
						//cpu
						_movingX=movingX+_memberWH;

					}
					//if

					if(attack_member.power.skillID=="w1")
					{
						switch(attack_member.power.target)
						{
							case "t10_0":
								_movingX+=100;
								movingY+=100;
								break
						}
						//switch
						attack_member.x=_movingX;
						attack_member.y=movingY;

					}
					else
					{
						//TweenMax.to(attack_member,0.5,{x:_movingX,y:movingY,onComplete:doTPComplete});
					}
					//if
					function doTPComplete():void
					{
						TweenMax.killChildTweensOf(attack_member);
					}
				}
				//if
				break

		}
		//switch
		var hitframes:Array=new Array();

		switch(attack_member.power.skillID)
		{
			case "a1":
				hitframes=[24];
				break;
			case "a2":
				hitframes=[21, 24, 27, 30, 34, 37, 40, 43, 51, 54, 57, 60, 66, 72, 76, 81];
				break;
			case "f0":
				hitframes=[27];
				break;
			case "f1":
				hitframes=[44];
				break;
			case "f2":
				hitframes=[67, 78, 98];
				break;
			case "w2":
				hitframes=[38,51];
				break;
			case "e1":
				hitframes=[9, 32, 38, 44, 50, 56, 82];
				break;
			case "e2":
				hitframes=[58,63,78];
				break
		}
		//switch
		if(attack_member.power.effect!="regenerate" && attack_member.power.effect!="heal" &&
				attack_member.power.effect!="mind_ctrl" && attack_member.power.effect!="shield")
		{
			if(hitframes.length>0)
			{
				if(e.target.currentFrame==hitframes[hitT])
				{
					hitHandle();
				}
				//if
			}
			//if
		}
		//if
		function hitHandle():void
		{
			var battleteam:Object=memberscom.getBattleTeam();
			var targetIDlist:Array=new Array();
			targetlist=getTargetList();
			var targetIDsHit:Array=getRangeTargetList(targetlist,attack_member.power.from);
			DebugTrace.msg("BattleScene.hitHandle targetIDsHit:"+targetIDsHit);


			for(var k:uint=0;k<targetIDsHit.length;k++)
			{


				var _target_member:Member=battleteam[targetIDsHit[k]];
				var reflect:Boolean=false;
				if(_target_member.power.reincarnation=="true")
				{
					reflect=true;
				}

				if(_target_member.power.se>0 && !reflect)
				{
					var battleEvt:BattleEvent=_target_member.memberEvt;
					battleEvt.act="hit";
					battleEvt.updateMemberAct();

					battleEvt.hitHandle();

				}
				//if

			}
			//for

			hitT++;
			DebugTrace.msg("BattleScene.hitHandle hitT:"+hitT);
			if(hitT>hitframes.length)
			{
				//combo hit finish
				for(var m:uint=0;m<targetIDsHit.length;m++)
				{

					var target_member:Member=battleteam[targetIDsHit[m]];
					battleEvt=target_member.memberEvt;
					battleEvt.from="CompleteKnockback";
					battleEvt.actComplete();

				}
				//for

			}
			//if
		}
		// hitHandle()

		if(e.target.currentFrame==e.target.totalFrames)
		{

			e.target.removeEventListener(Event.ENTER_FRAME,doActPlaying);
			var reincarnation:Boolean=false;
			var battleteam:Object=memberscom.getBattleTeam();
			TweenMax.to(battlescene,1,{y:-578,ease:Expo.easeOut});


			var member:Member=battleteam[allpowers[attack_index].id];
			membermc=member.membermc;

			despearBatttleTeam(1,member.name);



			var battledata:BattleData=new BattleData();

			var damage:Number=battledata.damageCaculator(member.power);


			var battleEvt:BattleEvent=member.memberEvt;
			//if(allpowers[attack_index].effect=="shield")
			DebugTrace.msg("BattleScene.doActPlaying member.power:"+JSON.stringify(member.power));
			if(member.power.effect=="regenerate" || member.power.effect=="heal"
					|| member.power.shielded=="true")
			{

				switch(member.power.effect)
				{
					case "shield":
						//battleEvt.act=allpowers[attack_index].label;
						//battleEvt.updateMemberAct();
						break;
					case "regenerate":
					case "heal":
						if(member.power.targetlist.length<=1)
						{
							if(target_member.power.se>0)
							{
								displayRegenerate(null,member.power.effect,damage);
							}
							//if
						}
						else
						{
							var healArea:Array=member.power.targetlist;
							var per_damage:Number=Math.floor(damage/healArea.length);
							displayRegenerate(healArea,"",per_damage);
						}
						//if
						break
					case "reincarnation":

						break
					/*
					 case "mind_ctrl":
					 var player_team:Array=memberscom.getPlayerTeam();
					 for(var i:uint=0;i<player_team.length;i++)
					 {
					 var player:Member=player_team[i];
					 player.power.target="";
					 player.power.targetlist=new Array();
					 player.updatePower(player.power);
					 player.updateStatus("");

					 var targetEvt:BattleEvent=player.memberEvt;
					 targetEvt.act="mind_ctrl";
					 targetEvt.updateMemberAct();

					 targetEvt.from="Mind Control";
					 targetEvt.actComplete();


					 }
					 //for
					 break	
					 */
				}
				//switch
			}
			else
			{
				//attack	 

				DebugTrace.msg("BattleScene.doActPlaying attack_member.power:"+JSON.stringify(attack_member.power));

				if(attack_member.power.skillID=="n3")
				{
					var loves:Object=flox.getSaveData("love");

					if(member.name.indexOf("player")!=-1)
					{
						//player
						reinPlayerSE=loves[member.power.name];
					}
					else
					{
						//cpu
						reinCpuSE=attack_member.power.seMax;
					}
					updateMemberReincarnation();

				}
				else
				{
					if(target_member.power.reincarnation=="true")
					{
						//displayReincarnation(damage);
						reincarnation=true;
					}
					else
					{


						displayDamage(damage);
					}
					//if

				}
				//if

			}
			//if
			//DebugTrace.msg("BattleScene.doActPlaying attack_index:"+attack_index);
			//DebugTrace.msg("BattleScene.doActPlaying damage:"+damage);
			var atkPower:Object=attack_member.power;
			atkPower.target="";
			atkPower.targetlist=new Array();
			attack_member.updatePower(atkPower);

			TweenMax.to(attack_member,0.2,{alpha:0,onComplete:onBeforeAttackComplete,onCompleteParams:[start_pos,attack_member,damage,reincarnation]});

			function onBeforeAttackComplete(start_pos,attack_member,damage,reincarnation):void
			{
				TweenMax.killChildTweensOf(attack_member);
				attack_member.alpha=1;
				attack_member.x=start_pos.x;
				attack_member.y=start_pos.y;
				doAttackCompleteHandle(attack_member,damage,reincarnation);
			}
			//TweenMax.to(attack_member,0.6,{x:start_pos.x,y:start_pos.y,onComplete:doAttackCompleteHandle,onCompleteParams:[attack_member,damage,reincarnation]});
		}
		//if

	}
	private function updateMemberReincarnation():void
	{

		var members:Array= new Array()
		if(attack_member.name.indexOf("player")!=-1)
		{
			//player
			var groundeff:MovieClip=ViewsContainer.groundEffectPlayer;
			members=memberscom.getPlayerTeam();

		}
		else
		{
			//cpu
			groundeff=ViewsContainer.groundEffectCPU;
			members=memberscom.getCpuTeam();

		}
		groundeff.visible=true;
		groundeff.mc.gotoAndPlay(2);
		for(var i:uint=0;i<members.length;i++)
		{

			DebugTrace.msg("BattleScene.updateMemberReincarnation name="+members[i].name+" , se:"+members[i].power.se);
			if(members[i].power.se>0)
			{
				members[i].power.reincarnation="true";
				members[i].updatePower(members[i].power);
			}
			//if
		}
		//for

	}

	private function targetKnockbackHandle(member:Member):void
	{
		var current_label:String=member.character.currentLabel;

		var battleEvt:BattleEvent=member.memberEvt;
		battleEvt.act="knockback";
		battleEvt.updateMemberAct();

		//battleEvt.from="CompleteKnockback";
		//battleEvt.actComplete();

		//TweenMax.to(member,2,{onComplete:onKnockbackComplete,onCompleteParams:[member,current_label]});
		//target_member.character.body.act.body.addEventListener(Event.ENTER_FRAME,onKnockbackComplete);
	}
	/*
	 private function onKnockbackComplete(member:Member,current_label:String):void
	 {
	 //TweenMax.killTweensOf(member);

	 var battleEvt:BattleEvent=member.memberEvt;
	 battleEvt.act=current_label;
	 battleEvt.updateMemberAct();

	 }*/
	private function doAttackCompleteHandle(member,damage,reflect:Boolean):void
	{
		DebugTrace.msg("BattleScene.doAttackCompleteHandle-------"+member.name+" ,reflect="+reflect);
		//TweenMax.killTweensOf(member);


		if(attack_member.name.indexOf("player")!=-1)
		{
			var members:Array=memberscom.getPlayerTeam();

		}
		else
		{
			members=memberscom.getCpuTeam();
		}

		var memberEvt:BattleEvent=member.memberEvt;
		memberEvt.processAction();

		member.removeSkillAni();

		var delaySec:Number=0;
		var type:String="";
		//attack_member.power.skillID!="a0" && attack_member.power.skillID!="w0"
		if(reflect)
		{
			displayReincarnation(damage);
			delaySec=3;
			type="displayReincarnation";
		}
		else
		{

			if(member.power.skillID=="e3")
			{
				changeFromation(member);
				delaySec=1.5;
				type="changeFromation";
			}
			else
			{

				delaySec=1;
				type="normal";
			}
			//if
		}
		//if
		//TweenMax.delayedCall(delaySec,onAttackComplete,[type]);

		var timer:Timer=new Timer(delaySec*1000,1);
		timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
		timer.start();
		function onTimeout(e:TimerEvent):void
		{
			timer.stop();
			e.target.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimeout);
			onAttackComplete(type)
		}

	}
	private function changeFromation(member:Member):void
	{
		var poslist:Array=new Array();
		if(member.power.from=="cpu")
		{
			//player formation
			//survives combat
			//var survive_combats:Array=BattleData.checkPlayerSurvive();	
			var members:Array=memberscom.getPlayerTeam();
			if(member.power.reincarnation=="true")
			{
				members=memberscom.getCpuTeam();
			}
			//if
		}
		else
		{
			//cpu formation
			//survive_combats=BattleData.checkCpuSurvive();
			members=memberscom.getCpuTeam();
			if(member.power.reincarnation=="true")
			{
				members=memberscom.getPlayerTeam();
			}
			//if
		}
		//if
		var survive_members:Array=new Array();
		for(var i:uint=0;i<members.length;i++)
		{
			DebugTrace.msg("BattleScene.chageFromation  members["+i+"]:"+JSON.stringify(members[i].power));
			if(members[i].power.se>0)
			{
				survive_members.push(members[i]);
				var pos:Object=new Object();

				pos.x=members[i].x;
				pos.y=members[i].y;
				pos.combat=members[i].power.combat;
				poslist.push(pos);
			}
			//if
		}
		//for
		//DebugTrace.msg("BattleScene.chageFromation  poslist:"+JSON.stringify(poslist));
		if(poslist.length>1)
		{
			var new_poslist:Array=setupRandomFormation(poslist);
			DebugTrace.msg("BattleScene.chageFromation  new_poslist:"+JSON.stringify(new_poslist));
			var battleteam:Object=memberscom.getBattleTeam();
			for(var k:uint=0;k<new_poslist.length;k++)
			{


				var _member:Member=survive_members[k];

				var posX:Number=new_poslist[k].x
				var posY:Number=new_poslist[k].y;
				_member.power.combat=new_poslist[k].combat;
				_member.updatePower(_member.power);
				//_member.x=posX;
				//_member.y=posY;
				//TweenMax.to(_member,0.5,{x:posX,y:posY,ease:Expo.easeOut});
				TweenMax.to(_member,0.2,{x:posX,y:posY,onComplete:onCompleteFromation,onCompleteParams:[_member]});

			}
			//for

			function onCompleteFromation(currentMember:Member):void
			{
				initTeamPos();
				TweenMax.killChildTweensOf(currentMember);
			}
		}
		//if

	}
	/*private function onFormationComplete():void
	 {

	 TweenMax.delayedCall(1,onAttackComplete);
	 }*/
	private function setupRandomFormation(poslist:Array):Array
	{

		var _poslist:Array=new Array();
		var times:Number=poslist.length;
		for(var i:uint=0;i<times;i++)
		{
			var ran:Number=Math.floor(Math.random()*poslist.length);
			_poslist.push(poslist[ran]);
			var ___poslist:Array=poslist.splice(ran);
			___poslist.shift();
			var result_poslist:Array=poslist.concat(___poslist);
			poslist=result_poslist;
		}
		//for

		return _poslist
	}
	private function onAttackComplete(type:String):void
	{
		DebugTrace.msg("BattleScene.onAttackComplete type="+type);
		TweenMax.killDelayedCallsTo(onAttackComplete);
		var seText:TextField=attack_member.membermc.getChildByName("se") as TextField;
		seText.visible=true;
		onFinishAttack();
	}
	private function onFinishAttack():void
	{
		//TweenMax.killAll(true);
		memberscom.checkTeamSurvive();
		attack_index++;
		var battleover:Boolean=memberscom.getBattleOver();
		//DebugTrace.msg("BattleScene.doAttackCompleteHandle battleover:"+battleover);


		if(!battleover)
		{
			DebugTrace.msg("BattleScene.onFinishAttack attack_index:"+attack_index+" ; allpowers max:"+allpowers.length);
			reseatChildIndex();
			if(attack_index<allpowers.length)
			{

				startBattle();
			}
			else
			{

				DebugTrace.msg("BattleScene.onFinishAttack restartRound--------------");
				TweenMax.killAll();

				//focusHandle("default");
				restartRound();

				//TweenMax.delayedCall(1,updateFocus);


			}
			//if
		}
		//if
		function updateFocus():void
		{
			TweenMax.killDelayedCallsTo(updateFocus);
			//focusHandle("solider");

		}
	}
	private function reseatChildIndex():void
	{
		var gffPlayer:MovieClip=ViewsContainer.groundEffectPlayer;
		var gffCPU:MovieClip=ViewsContainer.groundEffectCPU;
		var battleteam:Object=memberscom.getBattleTeam();
		var top_index:Number=memberscom.getTopIndex();
		var player_team:Array=memberscom.getPlayerTeam();
		var cpu_team:Array=memberscom.getCpuTeam();
		var teamSum:Number=player_team.length-1;
		//var deIndex:Number=battlescene.getChildIndex(cpu_team[0]);
		var deIndex:Number=2;
		var indexs:Array=new Array();
		var indexObj:Object=new Object();
		for(var _id:String in battleteam)
		{
			var index:Number=battlescene.getChildIndex(battleteam[_id]);
			indexs.push(index);
			indexObj[_id]=index;
		}
		//indexs.sort(Array.NUMERIC);
		//deIndex=indexs[0];
		DebugTrace.msg("BattleScene.reseatChildIndex indexs="+indexs);
		for(var id:String in battleteam)
		{
			var _power:Object=battleteam[id].power;
			var current_index:Number=battlescene.getChildIndex(battleteam[id]);
			var combat:Number=_power.combat;
			var _index:Number=0;
			if(_power.id.indexOf("player")==-1)
			{
				//cpu
				//_index+=(teamSum+1);
				_index=combat+deIndex+teamSum;
			}
			else
			{
				_index=combat+deIndex;
			}
			//if
			DebugTrace.msg("BattleScene.reseatChildIndex from="+_power.from+" ;combat="+_power.combat+" ; index="+indexObj[_power.id]+"; id="+_power.id);

			battlescene.setChildIndex(battleteam[id],indexObj[_power.id]);
			current_index=battlescene.getChildIndex(battleteam[id]);



		}
		//for
		if(gffCPU.visible)
		{
			battlescene.setChildIndex(gffCPU,1)


		}

	}

	private function getMovingPath(start:Point,end:Point,direction:Number):Array
	{
		var split:Number=10;
		var path:Array=new Array();

		var rangeX:Number=Math.abs(start.x-end.x);
		var vX:Number=rangeX/split;
		var height:Number=Math.abs(start.y-end.y);
		var topY:Number=end.y-(height*2);
		var rangeY:Number=Math.abs(start.y-topY);
		var vY:Number=rangeY/(split/2);
		for(var i:uint=0;i<split;i++)
		{
			var p:Object=new Object();
			p.x=start.x+direction*(vX*i);
			var _vY:Number=-(vY*i);
			if(i>=5)
			{
				vY=Math.abs(topY-end.y)/(split/2);
				_vY=_vY+(vY*(i-5));
			}
			//if
			p.y=start.y+_vY;
			path.push(p);
			//DebugTrace.msg("BattleScene.getMovingPath:"+JSON.stringify(p))
		}
		//for
		path.push({x:end.x,y:end.y});
		return path;
	}
	private function numbersTextFormat(type:String):TextFormat
	{
		//damage & heal numbers format
		var format:TextFormat=new TextFormat();
		format.size=30;
		switch(type)
		{
			case "damage":
				format.color=0xFF3300;
				break;
			case "skillPts":
				format.color=0xD31044;
				break;
			case "honor":
				format.color=0xFFCC33;
				break;
			default:
				format.color=0xFFFFFF;
				break

		}

		format.font="SimNeogreyMedium";
		return format
	}
	private function displayRegenerate(area:Array,effect:String,reg:Number):void
	{
		DebugTrace.msg("BattleScene.displayRegenerate -----------reg="+reg);
		var format:TextFormat=numbersTextFormat("regenerate");

		var damage_txt:TextField=new TextField();
		damage_txt.autoSize=TextFieldAutoSize.CENTER;
		damage_txt.defaultTextFormat=format;
		var battleEvt:BattleEvent
		if(!area)
			area=new Array();

		//attack_member.updateStatus("");


		//battleEvt=attack_member.memberEvt;
		//battleEvt.processAction();

		var _target_member:Member;
		if(area.length<=1)
		{
			//Heal
			_target_member=attack_member;
			if(attack_member.power.skillID=="n1")
			{
				var battleteam:Object=memberscom.getBattleTeam();
				_target_member=battleteam[attack_member.power.target];

			}
			//if

			if(from=="player")
			{

				var txt_x:Number=_target_member.x-memberWH/2;
			}
			else
			{

				txt_x=_target_member.x+memberWH/2;
			}
			//if

			var extrareg:Number=reg+(5-Math.floor(Math.random()*5)+1);
			showSplitTextField(_target_member,extrareg,damage_txt,txt_x);
			_target_member.power.se=_target_member.power.se+extrareg;
			_target_member.updatePower(_target_member.power);


			//battleEvt=_target_member.memberEvt;
			//battleEvt.act="heal";
			//battleEvt.updateMemberAct();

		}
		else
		{
			//Heal Area
			if(attack_member.name.indexOf("player")!=-1)
			{
				var members:Array=memberscom.getPlayerTeam();
			}
			else
			{
				members=memberscom.getCpuTeam();
			}
			//if
			var area_member:Array=new Array();
			for(var k:uint=0;k<members.length;k++)
			{
				if(area.indexOf(members[k].power.combat)!=-1)
				{
					area_member.push(members[k]);
				}
				//if
			}
			//for		
			for(var i:uint=0;i<area_member.length;i++)
			{
				_target_member=area_member[i];
				if(_target_member.power.se>0)
				{
					DebugTrace.msg("BattleScene.onAssistActComplete _target_member.power:"+JSON.stringify(_target_member.power));
					if(from=="player")
					{

						var _txt_x:Number=_target_member.x-memberWH/2;
					}
					else
					{

						_txt_x=_target_member.x+memberWH/2;
					}
					//if
					extrareg=reg+(5-Math.floor(Math.random()*5)+1);
					showSplitTextField(_target_member,extrareg,damage_txt,_txt_x);
					_target_member.power.se=_target_member.power.se+extrareg;
					_target_member.updatePower(_target_member.power);

					//var _battleEvt:BattleEvent=_target_member.memberEvt;
					//_battleEvt.act="heal";
					//_battleEvt.updateMemberAct();

				}
				//if
			}
			//for
		}
		//if




	}
	private function getTargetList():Array
	{


		for(var j:uint=0;j<allpowers.length;j++)
		{

			if(allpowers[j])
			{
				if(allpowers[j].id==attack_member.name)
				{
					attack_power=allpowers[j];
					if(attack_power.targetlist)
					{
						targetlist=attack_power.targetlist;
					}
					break
				}

				//if	   
			}
			//if
		}
		//for

		return targetlist;
	}
	private function displayDamage(damage:Number):void
	{
		var battleteam:Object=memberscom.getBattleTeam();
		current_damage=damage;
		DebugTrace.msg("BattleScene.displayDamage damage:"+damage);
		var format:TextFormat=numbersTextFormat("damage");

		targetlist=getTargetList();

		//DebugTrace.msg("BattleScene.displayDamage targetlist:"+targetlist);
		var targetIDlist:Array=new Array();
		targetIDlist=getRangeTargetList(targetlist,from);
		//var enemy:Number=attack_member.power.enemy;


		var _damage:Number=Math.floor(damage*0.1);
		var extradmg:Number=damage-_damage;



		//DebugTrace.msg("BattleScene.displayDamage extradmg:"+extradmg);

		var predamage:Number=Math.floor(extradmg/targetIDlist.length);
		var  _predamage:Number=predamage;
		if(attack_member.power.skillID=="w3")
		{

			var battledata:BattleData=new BattleData();
			predamage=Math.floor(Math.floor((Math.random()*800)+200));
			predamage=battledata.skillCard(attack_member,predamage);
			var w3_predamage:Number=_predamage+Math.floor(predamage/targetIDlist.length);
		}


		for(var k:uint=0;k<targetIDlist.length;k++)
		{

			predamage=_predamage;
			var _target_member:Member=battleteam[targetIDlist[k]];

			//DebugTrace.msg("BattleScene.displayDamage _target_member.status:"+_target_member.status);
			var damage_txt:TextField=new TextField();
			damage_txt.autoSize=TextFieldAutoSize.CENTER;
			damage_txt.embedFonts=true;
			damage_txt.defaultTextFormat=format;

			switch(attack_member.power.target)
			{
				case "t10_0":
					var _memberWH:Number=300;
					break
				default:
					_memberWH=150;
					break
			}
			if(from=="player")
			{
				var  txt_x:Number=_target_member.x+_memberWH/2-damage_txt.width/2;

			}
			else
			{
				txt_x=_target_member.x-_memberWH/2-damage_txt.width/2;

			}
			//if
			if(attack_member.power.skillID=="w3")
			{
				predamage=w3_predamage-Math.floor(Math.random()*w3_predamage*0.1);

			}
			//if
			if(_target_member.power.shielded=="true")
			{
				//target shielded	
				predamage=Math.floor(predamage*0.25);
				if(_target_member.power.ele=="water" && attack_member.power.ele=="fire")
				{
					predamage=0;
				}
				else if(_target_member.power.ele=="air" && attack_member.power.ele=="earth")
				{
					predamage=0;
				}
				//if

			}

			//DebugTrace.msg("BattleScene.displayDamage effect:"+attack_power.effect);
			DebugTrace.msg("BattleScene.displayDamage predamage:"+predamage);
			if(_target_member.power.se>0)
			{
				targetKnockbackHandle(_target_member);
				showSplitTextField(_target_member,predamage,damage_txt,txt_x);
				_target_member.updateDamage(attack_power.effect,predamage);
			}

		}


	}
	private function displayReincarnation(damage:Number):void
	{

		DebugTrace.msg("BattleScene.displayReincarnation damage:"+damage);

		var player_survive:Array=BattleData.checkPlayerSurvive();
		var cpu_survive:Array=BattleData.checkCpuSurvive();
		var groundeff:MovieClip;
		if(attack_member.power.from=="cpu")
		{
			//damage:cpu  ;  heal:player
			var healMembers:Array=memberscom.getPlayerTeam();
			var damageMembers:Array=memberscom.getCpuTeam();
			var perHeal:Number=Math.floor(damage/player_survive.length);
			var perDamage:Number=Math.floor(damage/cpu_survive.length);

			reinPlayerSE-=damage;
			groundeff=ViewsContainer.groundEffectPlayer;

		}
		else
		{
			//damage:player  ;  heal:cpu
			healMembers=memberscom.getCpuTeam();
			damageMembers=memberscom.getPlayerTeam();
			perHeal=Math.floor(damage/cpu_survive.length);
			perDamage=Math.floor(damage/player_survive.length);

			reinCpuSE-=damage;
			groundeff=ViewsContainer.groundEffectCPU;
		}
		//if

		if(reinPlayerSE<=0 || reinCpuSE<=0)
		{

			groundeff.visible=false;

			for(var k:uint=0;k<healMembers.length;k++)
			{
				if(healMembers[k].power.se>0)
				{
					healMembers[k].power.reincarnation="false";
					healMembers[k].updatePower(healMembers[k].power);
				}
				//if
			}
			//for

		}
		//if
		DebugTrace.msg("BattleScene.displayReincarnation reinPlayerSE:"+reinPlayerSE+" ; reinCpuSE:"+reinCpuSE);

		for(var i:uint=0;i<healMembers.length;i++)
		{
			var format:TextFormat=numbersTextFormat("reincarnation");
			var heal_txt:TextField=new TextField();
			heal_txt.autoSize=TextFieldAutoSize.CENTER;
			heal_txt.defaultTextFormat=format;
			var heal_member:Member=healMembers[i];
			if(heal_member.name.indexOf("player")!=-1)
			{
				var  txt_x:Number=heal_member.x-heal_member.width/2;
			}
			else
			{
				txt_x=heal_member.x+heal_member.width/2;
			}
			//if
			if(heal_member.power.se>0)
			{
				showSplitTextField(heal_member,perHeal,heal_txt,txt_x);

				heal_member.power.se+=perHeal;
				heal_member.updatePower(heal_member.power);
			}
			//if
		}
		//for
		for(var j:uint=0;j<damageMembers.length;j++)
		{
			format=numbersTextFormat("damage");
			var damage_txt:TextField=new TextField();
			damage_txt.autoSize=TextFieldAutoSize.CENTER;
			damage_txt.defaultTextFormat=format;
			var damage_member:Member=damageMembers[j];
			if(damage_member.name.indexOf("player")!=-1)
			{
				txt_x=damage_member.x-damage_member.width/2;
			}
			else
			{
				txt_x=damage_member.x+damage_member.width/2;
			}
			//if
			if(damage_member.power.se>0)
			{
				if(damage_member.power.shielded=="true")
				{
					perDamage=Math.floor(perDamage*0.25);
				}
				showSplitTextField(damage_member,perDamage,damage_txt,txt_x);
				damage_member.updateDamage("",perDamage);


			}
			//if
			if(damage_member.power.se>0)
			{
				//after damage
				targetKnockbackHandle(damage_member);
			}
		}
		//for

	}
	private function showSplitTextField(member:Member,numbers:*,split_txt:TextField ,posX:Number):void
	{
		DebugTrace.msg("BattleScene.showSplitTextField numbers="+numbers+" ; posX="+posX+" member.height"+member.height);
		switch(member.name)
		{
			case "t10_0":
				var _memberWH:Number=300;
				break
			default:
				_memberWH=150;
				break

		}
		split_txt.embedFonts=true;
		split_txt.text=String(numbers);
		split_txt.x=posX;
		split_txt.y=member.y+_memberWH/2;
		battlescene.addChild(split_txt);

		var stf:SplitTextField = new SplitTextField(split_txt);
		for (var i:int = stf.textFields.length - 1; i > -1; i--)
		{
			TweenMax.to(stf.textFields[i],0.5,{bezierThrough:[{x:stf.textFields[i].x,y:-20+i*5},{x:stf.textFields[i].x,y:0}],ease:Quint.easeOut,onComplete:onShowDamageComplete,onCompleteParams:[stf,stf.textFields[i]]});
		}
		//for
		function onShowDamageComplete(stf:SplitTextField,txt:TextField):void
		{


			TweenMax.delayedCall(0.5,onShowedSplitText,[stf,txt]);
			//txt.visible=false;
			//DebugTrace.msg("BattleScene.onShowDamageCmplete");

		}
		function onShowedSplitText(stf:SplitTextField,txt:TextField):void
		{
			//TweenMax.killDelayedCallsTo(onShowedSplitText);
			//TweenMax.killTweensOf(txt);
			try
			{
				stf.removeChild(txt);
			}
			catch(e:Error)
			{
				DebugTrace.msg("BattleScene.showSplitTextField  remove stf Error");
			}
			//try
		}

	}
	private function getRangeTargetList(targetlist:Array,search:String):Array
	{
		DebugTrace.msg("BattleScene.getRangeTargetList  targetlist:" +targetlist+" ; search:"+search);

		var list:Array=new Array();

		for(var n:uint=0;n<targetlist.length;n++)
		{


			if(search=="cpu")
			{

				//cpu attack player
				var target_id:String="player"+targetlist[n];
				list.push(target_id);

			}
			else
			{
				//player attack cpu
				for(var m:uint=0;m<allpowers.length;m++)
				{
					if(allpowers[m])
					{

						if(allpowers[m].combat==targetlist[n] && allpowers[m].from=="cpu")
						{
							target_id=allpowers[m].id;
							list.push(target_id);
						}
						//if
					}
					//if
				}
				//for
			}
			//if

		}
		//for

		return list;
	}


	private function initElementPanel():void
	{
		command.playSound("ElementOpen");
		var skills:Object=flox.getSaveData("skills");
		var elemends:Array=Config.btl_elements;
		DebugTrace.msg("BattleScene.updateSpritEnergy  elemends:"+elemends);
		elepanel=new ElementsPanel();
		elepanel.name="elepanel";
		elepanel.x=current_player.x-memberWH/2;
		elepanel.y=current_player.y+memberWH/2;
		battlescene.addChild(elepanel);

		for(var i:uint=0;i<elemends.length;i++)
		{

			var elebtn:MovieClip=elepanel[elemends[i]];
			elebtn.cover.visible=false;
			elebtn.mouseChildren=false;
			elebtn.buttonMode=true;
			elebtn.addEventListener(MouseEvent.CLICK,doChangedElement);
			elebtn.addEventListener(MouseEvent.MOUSE_OVER,doMouseOverElement);
			elebtn.addEventListener(MouseEvent.MOUSE_OUT,doMouseOutElement);

			if(elemends[i]=="com" && current_player.power.name!="player")
			{
				//not commander		
				disabledCommander(elebtn)
			}

			/*
			 if(elemends[i]=="com")
			 {
			 //beta version disabled commander 
			 disabledCommander(elebtn);
			 }
			 */
			var skill:String=skills[current_player.power.name][elemends[i]];
			if(skill=="")
			{
				disabledCommander(elebtn);
			}
		}
		//for
		function disabledCommander(elebtn:MovieClip):void
		{
			//TweenMax.delayedCall(0.2,disableColorTransform,[elebtn]);
			//TweenMax.to(elebtn, 0.1, {colorTransform:{tint:0x000000, tintAmount:0.6}});

			elebtn.cover.visible=true;
			elebtn.buttonMode=false;
			elebtn.removeEventListener(MouseEvent.CLICK,doChangedElement);
			elebtn.removeEventListener(MouseEvent.MOUSE_OVER,doMouseOverElement);
			elebtn.removeEventListener(MouseEvent.MOUSE_OUT,doMouseOutElement);


		}
		function disableColorTransform(target:MovieClip):void
		{
			TweenMax.killDelayedCallsTo(disableColorTransform);
			TweenMax.to(target, 0.1, {colorTransform:{tint:0x000000, tintAmount:0.6}});
		}
		//elepanel.commander.frame.visible=false;

	}
	private function doMouseOverElement(e:MouseEvent):void
	{
		command.playSound("ElementSelect");
		e.target.gotoAndStop(2);
	}
	private function doMouseOutElement(e:MouseEvent):void
	{
		e.target.gotoAndStop(1);
	}
	private function removeElEmentPanel():void
	{

		try
		{
			battlescene.removeChild(elepanel);
			elepanel=null;
		}
		catch(e:Error)
		{
			DebugTrace.msg("BattleScene.removeElEmentPanel Error");
		}
		//try

	}
	private function onElementsPanelFadout():void
	{
		TweenMax.killTweensOf(elepanel);

	}

	private var itemspanel:Sprite;
	private function doChangedElement(e:MouseEvent):void
	{
		command.playSound("ElementPick");

		var power:Object=current_player.power;
		DebugTrace.msg("BattleScene.doChangedElement power:"+JSON.stringify(power));
		element=e.target.name;
		//removeElEmentPanel();

		//if
		if(element!="com")
		{

			if(cardsSprtie)
			{
				TweenMax.to(cardsSprtie,0.5,{y:450,onComplete:onCardCleared,ease:Elastic.easeInOut});

			}
			else
			{
				initSkillCard();
				memberscom.playerReadyPickupCard(current_player.name);
			}
			//if
		}
		else
		{
			//commander	
			removeElEmentPanel();
			commander=current_player;
			if(power.name=="player")
			{
				showItemsPanel(commanderSkill);
			}
			//if

		}
		//if
	}
	private function showItemsPanel(enable:Boolean):void
	{
		DebugTrace.msg("BattleScene.showItemsPanel enable:"+enable);
		if(enable)
		{
			updateStepLayout("itempanel");
			//TweenMax.to(menuscene,1,{y:700,ease:Expo.easeOut});
			/*TweenMax.to(menuscene,1,{y:700,ease:Expo.easeOut});

			 TweenMax.to(starttab,0.8,{y:90,ease:Expo.easeOut});
			 if(cardsSprtie)
			 {
			 TweenMax.to(cardsSprtie,0.5,{y:450,onComplete:onCardCleared,ease:Expo.easeOut});
			 }*/
			if(!itemspanel)
			{
				itemspanel=new CommanderItemsPanel();
				itemspanel.x=800;
				itemspanel.y=500;
				TweenMax.to(itemspanel,0.5,{x:225,ease:Expo.easeOut,onComplete:onTweenComplete,onCompleteParams:[itemspanel]});
				addChild(itemspanel);
			}
			//if


		}
		else
		{

			//TweenMax.to(menuscene,1,{y:354,ease:Expo.easeOut});
			//TweenMax.to(starttab,0.8,{y:0,ease:Expo.easeOut});	
			if(itemspanel)
			{
				updateStepLayout("disabled itempanel");
				TweenMax.to(itemspanel,0.5,{y:800,ease:Expo.easeOut,onComplete:onItemPenelFadoutComplete});
			}
			//if
		}
		//if


	}
	private function onItemPenelFadoutComplete():void
	{
		try
		{
			TweenMax.killTweensOf(itemspanel);
			removeChild(itemspanel);
			itemspanel=null;
		}
		catch(e:Error)
		{

		}
		//try
	}
	private function onCardCleared():void
	{
		try
		{
			TweenMax.killTweensOf(cardsSprtie);
			menuscene.removeChild(cardsSprtie);
			cardsSprtie=null;
		}
		catch(e:Error)
		{

		}
		//try
		initSkillCard();
		memberscom.playerReadyPickupCard(current_player.name);
	}
	private var itemid:String;
	private var itemconfirm:MovieClip;
	private function usedItemHandle(e:Event):void
	{
		//var itemsdata:Object=flox.getSyetemData("commander_items");

		itemid=e.target.itemid;

		var msg:String="Use this Captain skill ?";
		command.addAttention(msg);
		showUseItemConfirm();

		TweenMax.to(itemspanel,0.5,{y:800,ease:Expo.easeOut,onComplete:onItemPenelFadoutComplete});

		//showItemsPanel(false);

	}
	private function showUseItemConfirm():void
	{
		var topview:flash.display.MovieClip=SimgirlsLovemore.topview;
		itemconfirm=new UseItemConfirm();
		itemconfirm.txt.text="";
		itemconfirm.confirm.mouseChildren=false;
		itemconfirm.confirm.buttonMode=true;
		itemconfirm.confirm.addEventListener(MouseEvent.CLICK,doConfirmClick);
		itemconfirm.confirm.addEventListener(MouseEvent.MOUSE_OVER,doConfirmMouseOver);
		itemconfirm.confirm.addEventListener(MouseEvent.MOUSE_OUT,doConfirmMouseOut);
		itemconfirm.cancel.mouseChildren=false;
		itemconfirm.cancel.buttonMode=true;
		itemconfirm.cancel.addEventListener(MouseEvent.CLICK,doCancelClick);
		itemconfirm.cancel.addEventListener(MouseEvent.MOUSE_OVER,doConfirmMouseOver);
		itemconfirm.cancel.addEventListener(MouseEvent.MOUSE_OUT,doConfirmMouseOut);
		topview.addChild(itemconfirm);

	}

	private function doConfirmClick(e:MouseEvent):void
	{
		var topview:flash.display.MovieClip=SimgirlsLovemore.topview;
		var success:Boolean=true;

		var items:Array=flox.getPlayerData("commander_items");
		for(var i:uint=0;i<items.length;i++)
		{
			if(items[i].id==itemid)
			{
				var qty:Number=Number(items[i].qty);
				qty--;
				items[i].qty=qty;
				break
			}
			//if
		}
		//for
		var new_items:Array=new Array();
		for(var j:uint=0;j<items.length;j++)
		{
			if(items[j].qty<0)
			{
				items[j].qty=0;
			}
			new_items.push(items[j]);
			//if
		}
		//for

		comType="item";

		LoaderMax.getLoader("attention").unload();
		topview.removeChild(itemconfirm);

		switch(itemid)
		{
			case "com0":

				savePlayerTeamSE(onPlayerSaveComplete);
				break;
			case "com1":

				if(current_player.power.combat<3)
				{
					focusHandle("default");
					doCommanderRage();
				}
				else
				{

					success=false;

					var msg:String="Captain must be in front row to use.";
					//MainCommand.addAlertMsg(msg);
					command.addAttention(msg);
					updateStepLayout("solider");
				}
				//if

				//if
				break;
			case "com2":
			case "com3":

				var jewelObj:Object={"com2":["1|f"],"com3":["1|e"]};
				initBootItem(itemid,jewelObj[itemid]);
				break
		}
		//switch

		var _data:Object=new Object();
		_data.items=new_items;
		flox.savePlayer(_data);

	}
	private function initBootItem(itemid:String,jewel:Array):void
	{
		elestonecom.showElementRequest(jewel);
		new_req_list=elestonecom.getNewReqList();
		DebugTrace.msg("BattleScene.doConfirmClick  new_req_list:"+JSON.stringify(new_req_list));
		if(new_req_list.indexOf(null)!=-1 || new_req_list.length<1)
		{
			var msg:String="NOT ENOUGH GEMS!";
			command.addAttention(msg);
			updateStepLayout("solider");
		}
		else
		{

			focusHandle("solider");
			elestonecom.readyElementStones();
			var attr:String="";
			if(itemid=="com2")
			{
				attr="skillPts";
			}
			else
				attr="honor";
			doBootItemHandle(attr);
		}
		//if
	}
	private function onPlayerSaveComplete():void
	{
		var cpu_team:Array=memberscom.getCpuTeam();
		var cpu_teams:Object=flox.getSaveData("cpu_teams");

		for(var i:uint=0;i<cpu_team.length;i++)
		{
			var member:Member=cpu_team[i];
			DebugTrace.msg("BattleScene.onPlayerSaveComplete member:"+JSON.stringify(member.power));
			var cpuObj:Object=cpu_teams[member.power.id];
			cpuObj.se=member.power.se;
			cpu_teams[member.power.id]=cpuObj;

		}
		//for
		flox.save("cpu_teams",cpu_teams,onSavedToFormation);

	}
	private function doCancelClick(e:MouseEvent):void
	{
		var topview:flash.display.MovieClip=SimgirlsLovemore.topview;
		LoaderMax.getLoader("attention").unload();
		topview.removeChild(itemconfirm);
		updateStepLayout("solider");


		//showItemsPanel(false);
	}
	private function doConfirmMouseOver(e:MouseEvent):void
	{
		e.target.gotoAndStop(2);

	}
	private function doConfirmMouseOut(e:MouseEvent):void
	{
		e.target.gotoAndStop(1);

	}
	private function disabledPlayerMember(playermc:MovieClip):void
	{
		playermc.buttonMode=false;
		playermc.removeEventListener(MouseEvent.CLICK,doSelectPlayer);

	}
	private function updateStepLayout(type:String):void
	{
		DebugTrace.msg("BattleScene.updateStepLayout  type:" +type);
		titleTxt.text=stepTxts.solider;
		battletitle.visible=false;
		if(type=="")
		{
			titleTxt.text="";
			TweenMax.to(battletitle,0.5,{x:-500,onComplete:onTweenComplete,onCompleteParams:[battletitle]});
		}
		else
		{
			if(stepTxts[type])
			{
				titleTxt.text=stepTxts[type];
			}
			//if
			//TweenMax.to(battletitle,0.5,{x:-500})
			TweenMax.to(battletitle,0.5,{x:0,ease:Quart.easeOut,onComplete:onTweenComplete,onCompleteParams:[battletitle]});
		}
		//if
		if(type!="startbattle")
		{
			TweenMax.to(battletitle,0.5,{x:0,ease:Quart.easeOut,onComplete:onTweenComplete,onCompleteParams:[battletitle]});
		}



		removePlayerHighlight();

		var stonebar:MovieClip=elestonecom.getStonebar();
		stonebar.visible=true;
		if(cardsSprtie)
		{
			TweenMax.to(cardsSprtie,0.5,{y:450,onComplete:onCardFadeout,ease:Expo.easeOut});
		}
		switch(type)
		{
			case "solider":
				starttab.y=0;
				starttab.wall.x=0;
				//starttab.wall.visible=false;
				stonebar.alpha=0;
				profile.alpha=0;
				starttab.btn.y=709;
				//TweenMax.to(starttab.btn,0.8,{y:709,onComplete:onTweenComplete});
				TweenMax.to(elementsbar,0.5,{x:1024,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[elementsbar]});
				TweenMax.to(menubg,0.5,{y:450,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[menubg]});
				TweenMax.to(sebar,0.5,{y:500,onComplete:onSEbarFadein});
				TweenMax.to(hptsbar,0.5,{y:500,onComplete:onHSPtsbarFadein});
				TweenMax.to(menuscene,0.5,{y:354});

				showPlayerHighlight();


				break;
			case "skill":
				TweenMax.to(stonebar,0.8,{alpha:1,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[stonebar]});
				TweenMax.to(elementsbar,0.5,{x:350,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[elementsbar]});

				/*if(cardsSprtie)
				 {
				 TweenMax.to(cardsSprtie,0.5,{y:800,onComplete:onCardFadeout,ease:Elastic.easeInOut});
				 }*/
				//if
				break;
			case "startbattle":
				TweenMax.to(starttab.btn,0.5,{y:800,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[starttab]});
				//battletitle.x=-500;
				TweenMax.to(battletitle,0.5,{x:-500,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[battletitle]});
				TweenMax.to(battlescene,1,{y:-578,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[battlescene]});
				TweenMax.to(menuscene,1,{y:700,onComplete:onBattleSceneComplete});
				break;
			case "target":
				starttab.wall.x=650;
				starttab.wall.visible=true;
				displayAttackArea();

				break;
			case "heal target":
				TweenMax.to(menuscene,0.5,{y:700});

				break
			case "itempanel":
				stonebar.visible=false;
				TweenMax.to(starttab,0.8,{y:90,ease:Expo.easeOut,onComplete:onTweenComplete,onCompleteParams:[starttab]});
				TweenMax.to(elementsbar,0.5,{x:1024,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[elementsbar]});
				//TweenMax.to(menuscene,1,{y:700,onComplete:onTweenComplete});

				break;
			case "disabled itempanel":
				TweenMax.to(menuscene,1,{y:354,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[menuscene]});
				TweenMax.to(starttab,0.8,{y:0,onComplete:onTweenComplete,ease:Expo.easeOut,onCompleteParams:[starttab]});
				break
		}

		//switch


	}
	private function initTeamPos():void
	{
		var player_team:Array=memberscom.getPlayerTeam();
		var cpu_team:Array=memberscom.getCpuTeam();
		for(var a:uint=0;a<player_team.length;a++)
		{
			playersX[player_team[a].name]=player_team[a].x;
		}
		for(var b:uint=0;b<cpu_team.length;b++)
		{
			cpusX[cpu_team[b].name]=cpu_team[b].x;
		}
		//trace("initTeamPos ",JSON.stringify(cpusX));
	}
	private function focusHandle(type:String):void
	{

		var movingX:Number=100;
		var player_team:Array=memberscom.getPlayerTeam();
		var cpu_team:Array=memberscom.getCpuTeam();
		//var background:MovieClip=battlescene.getChildByName("background") as MovieClip;
		var groundEff:MovieClip=ViewsContainer.groundEffectPlayer;
		var posX:Number=0;
		switch(type)
		{
			case "solider":
				starttab.wall.visible=false;
				for(var i:uint=0;i<player_team.length;i++)
				{
					var player_member:Member=player_team[i];
					posX=player_member.x-movingX;

					tweenMember(player_member,posX,0.5);
				}
				//for
				for(var j:uint=0;j<cpu_team.length;j++)
				{
					var cpu_member:Member=cpu_team[j];

					posX=cpusX[cpu_member.name]-movingX;
					cpu_member.x=posX;

					//tweenMember(cpu_member,posX,0.5);
				}
				//for


				posX=-(movingX*2);
				background.x=posX;
				//tweenMember(background,posX,0.8);
				groundEff.x=893-movingX;

				break
			case "target":

				for(var k:uint=0;k<player_team.length;k++)
				{
					player_member=player_team[k];

					posX=player_member.x+movingX*2;
					player_member.x=posX;
					//tweenMember(player_member,posX,0.5);
				}
				//for
				for(var m:uint=0;m<cpu_team.length;m++)
				{
					cpu_member=cpu_team[m];

					posX=cpu_member.x+movingX*2;

					tweenMember(cpu_member,posX,0.5);
				}
				//for

				posX=0;
				background.x=posX;
				groundEff.x=893+movingX;
				//tweenMember(background,posX,0.8);
				break
			case "default":
				starttab.wall.visible=true;
				for(k=0;k<player_team.length;k++)
				{
					player_member=player_team[k];

					posX=playersX[player_member.name];
					player_member.x=posX;
					//tweenMember(player_member,posX);
				}
				//for
				for(m=0;m<cpu_team.length;m++)
				{
					cpu_member=cpu_team[m];

					posX=cpusX[cpu_member.name];
					cpu_member.x=posX;
					//tweenMember(cpu_member,posX);
				}


				posX=-(movingX);
				background.x=posX;
				groundEff.x=893;
				//tweenMember(background,posX,0.2);
				break
		}
		//switch
		function tweenMember(target:MovieClip,posX:Number,duration:Number):void
		{
			/*  var cardIcon:MovieClip=battlescene.getChildByName(player_member.name+"_card") as MovieClip;
			 if(cardIcon)
			 {
			 cardIcon.x=posX-150;
			 }*/

			TweenMax.to(target, duration, {x:posX});
		}


	}
	private function onFocusComplete():void
	{

		showPlayerHighlight();

	}
	private function showPlayerHighlight():void
	{
		removePlayerHighlight();
		var battleteam:Object=memberscom.getBattleTeam();
		var playerteam:Array=memberscom.getPlayerTeam();
		for(var i:uint=0;i<playerteam.length;i++)
		{
			var playermember:Member=playerteam[i];

			var status:String=playermember.status;
			var se:Number=playermember.power.se;
			if(status!="dizzy" && se>0)
			{
				TweenMax.to(playermember,0.25,{colorTransform:{tint:0xffffff, tintAmount:0.7}});
				TweenMax.to(playermember,0.25,{delay:0.25,removeTint:true,onComplete:onPlayerCompleteHightlight,onCompleteParams:[playermember]});
			}
			//if
		}
		//for
		//DebugTrace.msg("BattleScene.showPlayerHighlight  player_survive:" +player_survive);
	}
	private function onPlayerCompleteHightlight(member:Member):void
	{

		//TweenMax.killTweensOf(member);
		showPlayerHighlight();
	}
	private function removePlayerHighlight():void
	{
		var battleteam:Object=memberscom.getBattleTeam();
		var playerteam:Array=memberscom.getPlayerTeam();

		for(var i:uint=0;i<playerteam.length;i++)
		{
			var playermember:Member=playerteam[i];
			//var playermember:Member=battleteam["player"+player_survive[i]];
			TweenMax.killTweensOf(playermember);
			TweenMax.to(playermember,0.25,{removeTint:true,onComplete:onRemoveHightlightComplete,onCompleteParams:[playermember]});

		}
		//for
		function onRemoveHightlightComplete(member:Member):void
		{
			TweenMax.killTweensOf(member);
		}
	}

	private function savePlayerTeamSE(callback:Function):void
	{

		var seObj:Object=flox.getSaveData("se");
		var playerteam:Array=memberscom.getPlayerTeam();
		for(var i:uint=0;i<playerteam.length;i++)
		{
			var power:Object=playerteam[i].power;
			seObj[power.name]=power.se;
		}
		//for
		flox.save("se",seObj,callback);
	}
	private function changeCPUFormationHandle():void
	{
		command.stopBackgroudSound();
		comType="cpu skill";
		//var alert:MovieClip=new ChangeFormationAlert();
		//addChild(alert);
		var msg:String="Enemy uses Change Formation";
		command.addAttention(msg);



		TweenMax.delayedCall(2,savePlayerHandle);

		function savePlayerHandle():void
		{
			LoaderMax.getLoader("attention").unLoad();

			TweenMax.killDelayedCallsTo(savePlayerHandle);
			savePlayerTeamSE(onPlayerSaveComplete);
		}
	}
	private function recordSkillPts(atk_member:Member):void
	{
		if(atk_member.power.id.indexOf("player")!=-1)
		{
			//player

			var skillPts:Object=flox.getSaveData("skillPts");
			var ch_name:String=atk_member.power.name;
			var skillID:String=atk_member.power.skillID;
			var gems:Number=Number(atk_member.power.jewel.split("|")[0]);
			var pts:Number=skillPts[ch_name];
			pts+=gems;

			skillPts[ch_name]=pts;
			current_skillPts[ch_name]=pts;

			DebugTrace.msg("BattleScene.recordSkillPts  current_skillPts:" +JSON.stringify(skillPts));
			DebugTrace.msg("BattleScene.recordSkillPts  skillPts:" +JSON.stringify(skillPts));

			flox.save("skillPts",skillPts);

		}
	}
	private function onTweenComplete(target:*):void
	{

		TweenMax.killChildTweensOf(target);

	}
}
}