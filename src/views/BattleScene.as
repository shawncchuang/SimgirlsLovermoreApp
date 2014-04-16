package views
{
	
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Expo;
	import com.greensock.easing.Quart;
	import com.greensock.easing.Quint;
	import com.greensock.text.SplitTextField;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
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
	
	import data.Config;
	import data.DataContainer;
	
	import events.BattleEvent;
	import events.GameEvent;
	import events.SceneEvent;
	
	import model.BattleData;
	import model.SaveGame;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	//import com.greensock.loading.SWFLoader;
	//TweenPlugin.activate([CirclePath2DPlugin]);
	//TweenPlugin.activate([TransformAroundCenterPlugin, TransformAroundPointPlugin, ShortRotationPlugin]);
	
	//TweenPlugin.activate([BezierThroughPlugin]);
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
		private var menuscene:Sprite
		private var elementsbar:MovieClip;
		private var sebar:MovieClip;
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
		public function BattleScene()
		{
			
			var evt:BattleEvent=new BattleEvent();
			evt.addEventListener(BattleEvent.COMMANDER_ITEM,usedItemHandle);
			evt.addEventListener(BattleEvent.HEAL,usedHealHandle);
			evt.addEventListener(BattleEvent.BONUS,onStartBonusGame);
			evt.addEventListener(BattleEvent.CPU_COMMANDER,onCPUCommaderItems);
			battleEvt=evt;
			
			
			init();
			
			memberscom.init(battlescene);
			memberscom.initPlayerMember(doSelectPlayer);
			memberscom.initCpuMember();
			
			
			initElementBar();
			elestonecom.initStoneBar(menuscene);
			
			
			updateStepLayout("solider");
			
			
			
			ViewsContainer.battlescene=this;
			
			
			//sound testing
			//command.playSound("BingoSound");
			
			//--------------Victory Testing----------------------			
			//var victorybounse:Sprite=new VictoryBonus();
			//addChild(victorybounse);
			
		}
		private function onStartBonusGame(e:Event):void
		{
			
			var victorybounse:Sprite=new VictoryBonus();
			addChild(victorybounse);
			
		}
		private function onCPUCommaderItems(e:Event):void
		{
			DebugTrace.msg("BattleScene.onCPUCommaderItems item="+e.target.itemid);
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
					cryNum--
					commander=e.target.commander;
					if(cryNum>0)
					{
						doCommanderRage();
					}
					//if
					break
				
			} 
			//switch
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
			
			var batllestage:MovieClip=new BattleStage();
			var stageID:Number=Math.floor(Math.random()*batllestage.totalFrames)+1;
			//stageID=6;
			batllestage.gotoAndStop(stageID);
			batllestage.y=150;
			battlescene.addChild(batllestage);
			DataContainer.stageID=stageID;
			
			var playereffGround:MovieClip=new GroundEffect();
			playereffGround.x=803;
			playereffGround.y=1050;
			battlescene.addChild(playereffGround);
			playereffGround.visible=false;
			ViewsContainer.groundEffectPlayer=playereffGround;
			
			var cpueffFround:MovieClip=new GroundEffect();
			cpueffFround.x=244;
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
			sebar.y=500;
			menuscene.addChild(sebar);
			
			
			
			
			battletitle=new BattleTitle();
			addChild(battletitle);
			var format:TextFormat=new TextFormat();
			format.font="Impact";
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
			starttab.btn.buttonMode=true;
			starttab.wall.visible=false;
			addChild(starttab);
			starttab.btn.addEventListener(MouseEvent.CLICK,doStartBattle);
			starttab.btn.addEventListener(MouseEvent.ROLL_OVER,doMouseOverStartTab);
			starttab.btn.addEventListener(MouseEvent.ROLL_OUT,doMouseOutStartTab);
			
			
			
		}
		private function updateProfile(name:String):void
		{
			profile.alpha=0;
			profile.gotoAndStop(name);
			TweenMax.to(profile,0.5,{alpha:1,easing:Expo.easeOut,onComplete:onUpdateProfile})
			
			function onUpdateProfile():void
			{
				TweenMax.killTweensOf(profile);
				
			}
		}
		private function doStartBattle(e:MouseEvent):void
		{
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
				fighting=true;
				updateStepLayout("startbattle");
				memberscom.removeAllEquidedCards();
				memberscom.removePlayerMemberListener(doSelectPlayer);
				removeElEmentPanel();
				
			}
			else
			{
				var msg:String="You're not ready."
				MainCommand.addAlertMsg(msg);
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
			
			startBattle();
		}
		private function doMouseOverStartTab(e:MouseEvent):void
		{
			TweenMax.to(starttab.btn,0.5, {frameLabel:"over",onComplet:onTweenComplete});
			
		}
		private function doMouseOutStartTab(e:MouseEvent):void
		{
			TweenMax.to(starttab.btn,0.5, {frameLabel:"out",onComplet:onTweenComplete});
			//TweenMax.to(starttab,0.5, {frameLabel:"out"});
		}
		private function onSEbarFadein():void
		{
			TweenMax.killTweensOf(sebar);
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
			
			sebar.txt.text=se+"/"+love;
			var percent:Number=Math.floor(Number((se/love).toFixed(2))*100);
			sebar.bar.gotoAndStop(percent);
			
		}
		//private var temp_powers:Array=new Array();
		private function doSelectPlayer(e:MouseEvent):void
		{
			
			TweenMax.to(menubg,0.5,{y:120,onComplete:onMenuBgFadein,easing:Elastic.easeOut});
			TweenMax.to(sebar,0.2,{y:344,onComplete:onSEbarFadein,easing:Elastic.easeOut});
			DebugTrace.msg("BattleScene.doSelectPlayer id:"+e.target.parent.name);
			var id:String=e.target.parent.name
			var battleteam:Object=memberscom.getBattleTeam();
			current_player=battleteam[id];
			var power:Object=current_player.power;
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
			updateProfile(power.name);
			memberscom.setPlayerIndex(player_index);
			//temp_powers[player_index]=playerteam[player_index].name;
			//current_player.onSelected();
			//var memberEff:Object=DataContainer.MembersEffect;
			if(power.target!="")
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
			DebugTrace.msg("BattleScene.onPlayLabelComplete  skills:"+skills);
			for(var i:uint=0;i<skills.length;i++)
			{
				var card:MovieClip=new SkillsCards();
				card.mouseChildren=false;
				card.buttonMode=true;
				card.name=skills[i];
				card.width=180;
				card.height=224;
				card.gotoAndStop(element);
				card.face.gotoAndStop(skills[i]);
				card.x=900;
				cardsSprtie.addChild(card);
				TweenMax.to(card,0.5,{x:i*(card.width+10),delay:i*0.05,ease:Quint.easeInOut,onComplete:onSkillComplete,onCompleteParams:[card]});
				
			}
			//for
			
		}
		
		private function onSkillComplete(card:MovieClip):void
		{
			TweenMax.killTweensOf(card);
			card.addEventListener(MouseEvent.MOUSE_OVER,onMouseOverCard);
			card.addEventListener(MouseEvent.MOUSE_OUT,onMouseOutCard);
			card.addEventListener(MouseEvent.CLICK,onMouseClickCard);
		}
		private var reqJewel:Array;
		private function onMouseOverCard(e:MouseEvent):void
		{
			//TweenMax.to(e.target,0.5,{y:-20,ease:Quint.easeInOut});
			TweenMax.to(e.target, 0.5, {y:-20,ease:Quint.easeInOut,dropShadowFilter:{color:0x000000, alpha:1, blurX:12, blurY:10, distance:5}});
			
			var skill_id:String=e.target.name;
			var skillsys:Object=flox.getSyetemData("skillsys")[skill_id];
			
			var sysJewel:String=skillsys.jewel;
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
			
		}
		private function onMouseOutCard(e:MouseEvent):void
		{
			
			TweenMax.to(e.target,0.2,{y:0,ease:Quint.easeInOut,onComplete:onTweenComplete,dropShadowFilter:{color:0x000000, alpha:0, blurX:0, blurY:0, distance:0}});
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
			var battleteam:Object=memberscom.getBattleTeam();
			//var playerteam:Array=MemebersCommand.playerTeam;
			
			var member:Member=battleteam[current_player.name];
			var battledata:BattleData=new BattleData();
			var member_name:String=current_player.name;
			var power:Object=member.power;
			DebugTrace.msg("BattleScene.doSetupSkillCard current_player name:"+current_player.name);
			DebugTrace.msg("BattleScene.doSetupSkillCard power:"+JSON.stringify(power));
			//memberscom.praseMemberPart(member,"ready",member_name);
			var id:String=e.target.name;
			var skillsys:Object=flox.getSyetemData("skillsys")[id];
			skillsys.skillID=id;
			new_req_list=elestonecom.getNewReqList();
			//DebugTrace.msg("BattleScene.doSetupSkillCard new_req_list:"+new_req_list);
			if(new_req_list.indexOf(null)!=-1 || new_req_list.length<1)
			{
				var msg:String="You need more gems!";
				MainCommand.addAlertMsg(msg);
				DebugTrace.msg("BattleScene.doSetupSkillCard: "+msg);
			}
			else
			{
				
				if(player_index<5)
				{
					
					//var seObj:Object=flox.getSaveData("se");
					var play_se:Object=new Object();
					//fake sao's power
					//play_se.se=seObj.sao;
					
					var skills:Object=battledata.skillCard(current_player,skillsys);
					for(var i:String in skills)
					{
						power[i]=skills[i];
						
					}
					//for
					/*var plus_speed:Number=member.getPlusSpeed();
					if(plus_speed!=0)
					{
					power.speed+=plus_speed;
					}*/
					power.from="player";
					power.target="";
					//power.combat=Number(current_player.name.split("player").join(""));
					for(var j:String in skillsys)
					{
						
						power[j]=skillsys[j];
					}
					//for
					
					memberscom.equipedCard(e.currentTarget as MovieClip);
					var act:String="ATTACK";
					switch(power.skillID)
					{
						case "a0":
							//Air Shield
						case "w0":
							//Water Barrier
							act="SHIELD";
							power.target=current_player.name;
							break
						case "n0":
							//Regenerate
							act="REGENERATE";
							power.target=current_player.name;
							break
						case "n1":
						case "n2":
							//Heal
							act="HEAL";
							break
						case "n3":
							//Reincarnation
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
							updateStepLayout("target");
							targetArea=BattleData.rangeMatrix(power);
							displayAttackArea();
							memberscom.choiceTarget(doSetupTarget,doMouseOverTarget,doMouseOutTarget);	
							break
						case "SHIELD":
						case "REGENERATE":
						case "REINCARNATION":
							//starttab.wall.visible=true;
							updateStepLayout("heal target");
							updateStepLayout("solider");
							//cputeam=memberscom.getCpuTeam();
							break
						case "HEAL":
							updateStepLayout("heal target");
							var player_team:Array=memberscom.getPlayerTeam();
							for(var k:uint=0;k<player_team.length;k++)
							{
								var memberEvt:BattleEvent=player_team[k].memberEvt;
								memberEvt.enabledMemberHeal();
							}
							//for
							break
						
						
					}
					//switch
					
					DataContainer.currentPower=power;
					member.updatePower(power);
					member.processAction();
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
			if(e.target.id)
			{
				//Heal
				var heal_target:String=String(e.target.id.split("Heal").join(""));
				power.target=heal_target;
				
			}
			else
			{
				//Heal Area
				
				var healarea:Array=e.target.healarea;
				//power.target="player"+healarea[0].power.combat;
				power.target=healarea[0].name;
				var targetlist:Array=new Array();
				for(var i:uint=0;i<healarea.length;i++)
				{
					//targetlist.push(healarea[i].power.combat)
					var target_combat:Number=Number(healarea[i].name.split("player").join(""));
					targetlist.push(target_combat);
				}
				//for
				power.targetlist=targetlist;
				
			}
			//if
			member.updatePower(power);
			play_power[player_index]=member.power;
			//DebugTrace.msg("BattleScene.usedHealHandle heal_target:"+heal_target);
			
			
			
			updateStepLayout("solider");
			var player_team:Array=memberscom.getPlayerTeam();
			for(var k:uint=0;k<player_team.length;k++)
			{
				var memberEvt:BattleEvent=player_team[k].memberEvt;
				memberEvt.removeMemberHeal();
			}
			//for
			
		}
		private var battleAlert:MovieClip;
		private function doCommanderRage():void
		{
			
			battleAlert=new BattleCryAlert();
			battleAlert.alpha=0;
			addChild(battleAlert);
			
			TweenMax.to(battleAlert,1,{alpha:1,onComplete:doRageAction})
			
		}
		
		private function doRageAction():void
		{
			
			TweenMax.delayedCall(4,doBattleAlertFadeOut);
			function doBattleAlertFadeOut():void
			{
				TweenMax.killDelayedCallsTo(doBattleAlertFadeOut);
				
				TweenMax.to(battleAlert,1,{alpha:0,onComplete:onBattleAlertFadeOut});
			}
			
			
			
			function onBattleAlertFadeOut():void
			{
				TweenMax.killTweensOf(battleAlert); 
				removeChild(battleAlert);
			}
			
			starttab.wall.visible=true;
			DebugTrace.msg("BattleScene.doRageAction commander:"+commander.name);
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
			/*for(var i:uint=0;i<members.length;i++)
			{
			var member:Member=members[i];
			DebugTrace.msg("BattleScene.doRageAction power:"+JSON.stringify(member.power));
			if(member.power.name=="player" || member.power.skillID=="com1")
			{
			//member used battle cry
			commander=member;
			member.power.speeded="true";
			member.updatePower(member.power);
			DebugTrace.msg("BattleScene.doRageAction commander power:"+JSON.stringify(commander.power));
			var battleEvt:BattleEvent=commander.memberEvt;
			battleEvt.act="rage";
			battleEvt.updateMemberAct();	
			battleEvt.from="Rage";
			battleEvt.actComplete();
			TweenMax.delayedCall(1,onMemberBattleCry,[members]);
			break
			}
			//if
			
			}
			//for*/
			
			commander.power.speeded="true";
			commander.updatePower(commander.power);
			commander.updateStatus("");
			
			var battleEvt:BattleEvent=commander.memberEvt;
			battleEvt.act="rage";
			battleEvt.updateMemberAct();	
			battleEvt.from="Rage";
			battleEvt.actComplete();
			
			
			
			TweenMax.delayedCall(2,onMemberBattleCry,[members]);
		}
		
		private function onMemberBattleCry(members:Array):void
		{
			
			//TweenMax.killTweensOf(member);
			
			for(var i:uint=0;i<members.length;i++)
			{
				var member:Member=members[i];
				
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
			//for
			
			//onBattleCryComplete();
			TweenMax.delayedCall(2,onBattleCryComplete);
		}
		private function onBattleCryComplete():void
		{
			
			updateStepLayout("solider");
			starttab.wall.visible=false;
			TweenMax.killDelayedCallsTo(onMemberBattleCry);
			TweenMax.killDelayedCallsTo(onBattleCryComplete);
			showItemsPanel(false);
			
			if(commander.name.indexOf("player")==-1)
			{
				//cpu
				memberscom.reseatCPUPower(commander.name);
			}
		}
		private function onSavedToFormation():void
		{
			DebugTrace.msg("BattleScene.onFormationSave");
			
			starttab.wall.visible=true;
			
			TweenMax.killAll();
			
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
						TweenMax.to(cpu_target,0.25,{colorTransform:{tint:0xff0000, tintAmount:0.5}});
						TweenMax.to(cpu_target,0.25,{delay:0.5,removeTint:true,onComplete:onCompleteTint,onCompleteParams:[cpu_target]});
						
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
				reseatCpuTeam(); 
				power.target=id;
				
				
				
				if(player_index<playerteam.length)
				{
					power.targetlist=targetArea;
					play_power[player_index]=power;
					current_player.updatePower(power);
					current_player.processAction();
					DebugTrace.msg("BattleScene.doSetupTarget play_power["+player_index+"]="+JSON.stringify(play_power[player_index]));
					
					
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
			
			
			var power:Object=current_player.power;
			var combat:Number=battleteam[id].power.combat;
			
			DebugTrace.msg("BattleScene.doMouseOverTarget battleteam power:"+JSON.stringify(battleteam[id].power));
			var battledata:BattleData=new BattleData();
			targetArea=battledata.praseTargetList(power,combat);
			
			var membermc:MovieClip=battleteam[id].membermc;
			var arrow:MovieClip=membermc.getChildByName("arrow") as MovieClip;
			arrow.visible=checkInAttackArea(battleteam[id]);
			
			DebugTrace.msg("BattleScene.doMouseOverTarget combat:"+combat+" ,targetArea:"+targetArea);
			//displayAttackArea();
			removeDisplayAttackArea();
			for(var i:uint=0;i<targetArea.length;i++)
			{
				for(var j:uint=0;j<cputeam.length;j++)
				{
					if(cputeam[j].power.combat==targetArea[i])
					{
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
			sebar.y=500;
			menubg.y=450;
			profile.alpha=0;
			TweenMax.to(starttab.btn,0.5,{y:709});
			TweenMax.to(battlescene,1,{y:stageDeY,ease:Elastic.easeOut,onComplete:onSceneAlready});
			TweenMax.to(menuscene,1,{y:354,ease:Elastic.easeOut});
			
		}
		private function onSceneAlready():void
		{
			TweenMax.killTweensOf(battlescene);
			TweenMax.killTweensOf(menuscene);
			
			fighting=false;
			starttab.wall.visible=false;
			
			player_index=0;
			attack_index=0;
			play_power=new Array();
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
		private function startBattle():void
		{
			//player pick up skillcard  complete
			//BattleScene.play_power=play_power;
			
			memberscom.playerReadyPickupCard("all");
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
			DebugTrace.msg("------------------------------------------------------attack_index="+attack_index);
			
			
			from=allpowers[attack_index].from;
			
			var id:String=allpowers[attack_index].id;
			attack_member=battleteam[id];
			
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
			if(act=="ATTACK")
			{
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
					DebugTrace.msg("BattleScene.startBattle target_id:"+target_id);
					target_member=battleteam[target_id];
					var movingY:Number=target_member.y;
					
					if(from=="player")
					{
						var movingX:Number=target_member.x+target_member.width*2;
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
						DebugTrace.msg("BattleScene.startBattle target_id:"+target_id);
						target_member=battleteam[target_id];
						//DebugTrace.msg("BattleScene.startBattle target:"+target);
						movingX=target_member.x-target_member.width-Math.floor(target_member.width/2);	
						direction=1;
					}
					//if
					switch(attack_member.power.skillID)
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
							if(from=="player")
							{
								movingX=710+target_member.width;
							}
							else
							{
								movingX=175;
							}
							//if
							despearBatttleTeam(0,id);
							movingY=950;
							//y=-578 battle
							TweenMax.to(battlescene,1,{y:-568,yoyo:true,repeat:-1,ease:Elastic.easeOut});
							
							//if
							break
						case "com0":
							//cpu commander change foramation
							act="STOP";
							changeCPUFormationHandle();
							break
						case "com1":
							//cpu battle cry
							act="STOP";
							doCommanderRage();
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
			DebugTrace.msg("BattleScene.startBattle status:"+status);
			
			//var radius:Number=(Math.abs(movingX-attack_member.x))/2;
			//var circle:CirclePath2D = new CirclePath2D(movingX, target_member.y, radius);
			//var follower:PathFollower = circle.addFollower(attack_member, circle.angleToProgress(180), true);
			//var path:Array=getMovingPath(start_pos,new Point(movingX,target_member.y),direction);
			//tweenmax=new TweenMax(attack_member, 1, {bezierThrough:path,onComplete:doAttackHandle,ease:Quint.easeOut}); 
			
			//tweenmax=new TweenMax(follower, 2, {progress:circle.followerTween(follower, 180, Direction.COUNTER_CLOCKWISE)});
			//tweenmax=new TweenMax(attack_member, 1, {circlePath2D:{path:circle, startAngle:0, endAngle:180, direction:Direction.COUNTER_CLOCKWISE, extraRevolutions:1}});
			DebugTrace.msg("------------------------------------------------------act="+act);
			
			if(act=="ATTACK")
			{
				if(attack_member.power.skillID=="a0" ||  attack_member.power.skillID=="w0")
				{
					//shield
					attack_member.power.shielded="true";
					attack_member.updatePower(attack_member.power);
					doAttackHandle();
				}
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
						
						attack_member.updateStatus(effect);
						
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
						//--------------skill need to HOP------------------------------------------------------------------------------------------------------------
						var partnertEvt:BattleEvent=attack_member.memberEvt;
						partnertEvt.act="hop";
						partnertEvt.updateMemberAct();
						
						attack_member.character.body.addEventListener(Event.ENTER_FRAME,doHopping);
						function doHopping(e:Event):void
						{
							 
							if(e.target.currentFrameLabel=="moving")
							{
								TweenMax.to(attack_member,duration,{x:movingX,y:movingY});
							}
							//if
							if(e.target.currentFrame==e.target.totalFrames)
							{
								attack_member.character.body.removeEventListener(Event.ENTER_FRAME,doHopping);
								doAttackHandle();
							}	
							//if
						}
						//fun
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
		
		private function despearBatttleTeam(alpha:Number,id:String):void
		{
			DebugTrace.msg("BattleScene.despearBatttleTeam id="+id+" ; alpha="+alpha);
			var battleteam:Object=memberscom.getBattleTeam();
			var _member:String="";
			var index:Number
			if(id.indexOf("player")!=-1)
			{
				//player no combine skill 
				var members:Array=memberscom.getPlayerTeam();
				/*
				if(id=="player1")
				{
				partner="player0";
				}
				else
				{
				partner="player1";
				}*/
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
		private var team:Array
		private function doAttackHandle():void
		{
			TweenMax.killTweensOf(attack_member);
			
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
			//DebugTrace.msg("BattleScene.doAttackHandle allpowers:"+JSON.stringify(allpowers[player_index])+" ; attack_index:"+attack_index);
			var id:String=allpowers[attack_index].id;
			var member:Member=battleteam[id];
			/*if(member.power.skillID=="a0" || member.power.skillID=="w0")
			{
			//shield
			act="";
			}
			//if
			*/
			var skillID:String=member.power.skillID;
			switch(skillID)
			{
				case "s0":
					
					//partner
					var partnermember:Member=battleteam[partner];
					var partnertEvt:BattleEvent=partnermember.memberEvt;
					partnertEvt.act=act;
					partnertEvt.updateMemberAct();
					partnertEvt.from="CombineSkill";
					partnertEvt.actComplete();
					break
				
			}
			
			
			//if
			var battleEvt:BattleEvent=member.memberEvt;
			battleEvt.act=act;
			battleEvt.updateMemberAct();
			
			member.character.body.act.addEventListener(Event.ENTER_FRAME,doActPlaying);
			
		}
		private function doActPlaying(e:Event):void
		{
			
			//DebugTrace.msg("BattleScene.doActPlaying:"+e.target.currentFrame+","+e.target.totalFrames)
			if(e.target.currentFrame==e.target.totalFrames)
			{
				var reincarnation:Boolean=false;
				var battleteam:Object=memberscom.getBattleTeam();
				e.target.removeEventListener(Event.ENTER_FRAME,doActPlaying);
				var _team:Array=team.concat(hurtplayer);
				for(var k:uint=0;k<_team.length;k++)
				{
					//_team[k].alpha=1;
					TweenMax.to(_team[k], 0.5, {colorTransform:{tint:0xffffff, tintAmount:0}});
				}
				//for
				var member:Member=battleteam[allpowers[attack_index].id];
				var membermc:MovieClip=member.membermc;
				
				despearBatttleTeam(1,member.name);
				
				var seTxt:TextField=membermc.getChildByName("se") as TextField;
				seTxt.visible=true;
				
				var battledata:BattleData=new BattleData();
				var damage:Number=battledata.damageCaculator(allpowers,attack_index);
				
				
				var battleEvt:BattleEvent=member.memberEvt;
				//if(allpowers[attack_index].effect=="shield")
				DebugTrace.msg("BattleScene.doActPlaying member.power:"+JSON.stringify(member.power));
				if(member.power.effect=="regenerate" || member.power.effect=="heal" || member.power.effect=="mind_ctrl")
				{
					
					switch(member.power.effect)
					{
						case "shield":
							//battleEvt.act=allpowers[attack_index].label;
							//battleEvt.updateMemberAct();
							break
						case "regenerate":
						case "heal":
							if(member.power.targetlist.length<=1)
							{
								displayRegenerate(null,member.power.effect,damage);
							}
							else
							{
								var healArea:Array=member.power.targetlist;
								var per_damage:Number=Math.floor(damage/healArea.length);
								
								displayRegenerate(healArea,"",per_damage);
								
							}
							break
						case "reincarnation":
							
							break
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
							//battleEvt.act="";
							//battleEvt.updateMemberAct();
							break
						
					}
					//switch
				}
				else
				{
					
					/*var act:String="ready";
					if(member.status=="scared")
					{
					act="scared";
					}
					battleEvt.act=act;
					battleEvt.updateMemberAct();*/
					
					//targetKnockbackHandle(target_member);
					
					DebugTrace.msg("BattleScene.doActPlaying target_member.power:"+JSON.stringify(target_member.power));
					
					if(attack_member.power.skillID=="n3")
					{
						var loves:Object=flox.getSaveData("love");
						
						reinPlayerSE=loves[member.power.name];
						reinCpuSE=attack_member.power.seMax;
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
				TweenMax.to(attack_member,0.5,{x:start_pos.x,y:start_pos.y,onComplete:doAttackCompleteHandle,onCompleteParams:[attack_member,damage,reincarnation]});
			}
			//if
		}
		private function updateMemberReincarnation():void
		{
			
			
			if(attack_member.name.indexOf("player")!=-1)
			{
				//player
				var groundeff:MovieClip=ViewsContainer.groundEffectPlayer;
				var members:Array=memberscom.getPlayerTeam();
				
			}
			else
			{
				//cpu
				groundeff=ViewsContainer.groundEffectCPU;
				members=memberscom.getCpuTeam();
				
			}
			groundeff.visible=true;
			for(var i:uint=0;i<members.length;i++)
			{
				
				//members[i].updateStatus("reincarnation");
				members[i].power.reincarnation="true";
				members[i].updatePower(members[i].power);
			}
			//for
			
		}
		private function targetKnockbackHandle(member:Member):void
		{
			var current_label:String=member.character.currentLabel;
			var battleEvt:BattleEvent=member.memberEvt;
			battleEvt.act="knockback";
			battleEvt.updateMemberAct();
			battleEvt.from="CompleteKnockback";
			battleEvt.actComplete();
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
		private function doAttackCompleteHandle(member,damage,rein:Boolean):void
		{
			DebugTrace.msg("BattleScene.doAttackCompleteHandle--------------------------------");
			TweenMax.killTweensOf(member);
			if(attack_member.name.indexOf("player")!=-1)
			{
				var members:Array=memberscom.getPlayerTeam();
				
			}
			else
			{
				members=memberscom.getCpuTeam();
			}
			for(var i:uint=0;i<members.length;i++)
			{
				var member:Member=members[i];
				member.alpha=1;
				member.processAction();
			}
			
			if(rein)
			{
				displayReincarnation(damage);
			}
			//if
			if(member.power.skillID=="e3")
			{
				
				changeFromation(member);
			}
			else
			{
				
				TweenMax.delayedCall(1,onAttackComplete);
			}
			//if
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
			}
			else
			{
				//cpu formation
				//survive_combats=BattleData.checkCpuSurvive();
				members=memberscom.getCpuTeam();
				
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
					//pos.member=members[i];
					//pos.id=members[i].name;
					pos.x=members[i].x;
					pos.y=members[i].y;
					pos.combat=members[i].power.combat;
					poslist.push(pos);
				}
				//if
			}
			//for
			DebugTrace.msg("BattleScene.chageFromation  poslist:"+JSON.stringify(poslist));
			if(poslist.length>1)
			{
				var new_poslist:Array=setupRandomFormation(poslist);
				DebugTrace.msg("BattleScene.chageFromation  new_poslist:"+JSON.stringify(new_poslist));
				var battleteam:Object=memberscom.getBattleTeam();
				for(var k:uint=0;k<new_poslist.length;k++)
				{
					
					//var id:String=new_poslist[k].id
					var _member:Member=survive_members[k];
					
					var posX:Number=new_poslist[k].x
					var posY:Number=new_poslist[k].y;
					_member.power.combat=new_poslist[k].combat;
					_member.updatePower(_member.power);
					//TweenMax.to(_member,0.5,{x:posX,y:posY,ease:Expo.easeOut});
					TweenMax.to(_member,0.5,{x:posX,y:posY});
				}
				//for
			}
			//if
			TweenMax.delayedCall(1,onAttackComplete);
		}
		private function onFormationComplete():void
		{
			//TweenMax.killDelayedCallsTo(onFormationComplete);
			TweenMax.delayedCall(1,onAttackComplete);
		}
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
		private function onAttackComplete():void
		{
			TweenMax.killDelayedCallsTo(onAttackComplete);
			onFinishAttack();
		}
		private function onFinishAttack():void
		{
			TweenMax.killAll(true);
			memberscom.checkTeamSurvive();
			attack_index++;
			var battleover:Boolean=memberscom.getBattleOver();
			//DebugTrace.msg("BattleScene.doAttackCompleteHandle battleover:"+battleover);
			if(!battleover)
			{
				DebugTrace.msg("BattleScene.doAttackCompleteHandle attack_index:"+attack_index+" ; allpowers max:"+allpowers.length);
				
				if(attack_index<allpowers.length)
				{
					
					startBattle();
				}
				else
				{
					
					DebugTrace.msg("BattleScene.doAttackCompleteHandle restartRound--------------");
					
					restartRound();
				}
				//if
			}
			//if
			
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
			if(type=="damage")
			{
				format.color=0xFF3300;
			}
			else
			{
				format.color=0xFFFFFF;
			}
			
			format.font="Neogrey Medium";
			return format
		}
		private function displayRegenerate(area:Array,effect:String,reg:Number):void
		{
			DebugTrace.msg("BattleScene.displayRegenerate restartRound-----------area="+area);
			var format:TextFormat=numbersTextFormat("regenerate");
			//var target:String=attack_member.power.target;
			
			var damage_txt:TextField=new TextField();
			damage_txt.autoSize=TextFieldAutoSize.CENTER;
			damage_txt.defaultTextFormat=format;
			
			
			
			if(area.length<=1)
			{
				//Heal
				if(from=="player")
				{
					//var  txt_x:Number=target_member.x+target_member.width/2-damage_txt.width/2;
					//var  txt_x:Number=target_member.x-damage_txt.width/2;
					var txt_x:Number=target_member.x-target_member.width/2;
				}
				else
				{
					//txt_x=target_member.x-target_member.width/2-damage_txt.width/2;
					txt_x=target_member.x+target_member.width/2;
				}
				//if
				var extrareg:Number=reg+(5-Math.floor(Math.random()*5)+1);
				showSplitTextField(target_member,extrareg,damage_txt,txt_x);
				target_member.power.se+=extrareg;
				target_member.updatePower(target_member.power);
				
				
				var targetEvt:BattleEvent=target_member.memberEvt;
				targetEvt.act=attack_member.power.effect;
				targetEvt.updateMemberAct();
				//target_member.character.body.act.addEventListener(Event.ENTER_FRAME,onAssistActComplete);
				
				target_member.updateStatus("");
				target_member.processAction();
				//targetEvt.from="Assist";
				//targetEvt.actComplete()
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
					var _target_member:Member=area_member[i];
					if(_target_member.power.se!=0)
					{
						DebugTrace.msg("BattleScene.onAssistActComplete _target_member:"+_target_member.power.id);
						//from=area[0].power.from;
						if(from=="player")
						{
							
							var _txt_x:Number=_target_member.x-_target_member.width/2;
						}
						else
						{
							
							_txt_x=_target_member.x+_target_member.width/2;
						}
						//if
						extrareg=reg+(5-Math.floor(Math.random()*5)+1);
						showSplitTextField(_target_member,extrareg,damage_txt,_txt_x);
						_target_member.power.se+=extrareg;	 
						_target_member.updatePower(_target_member.power);
						
						targetEvt=_target_member.memberEvt;
						targetEvt.act=attack_member.power.effect;
						targetEvt.updateMemberAct();
						
						_target_member.updateStatus("");
						targetEvt.from="Assist";
						targetEvt.actComplete()
					}
					//if
				}
				//for
			}
			//if
			
			//attack_member.power.target="";
			//attack_member.power.targetlist=new Array();
			//attack_member.updatePower(attack_member.power);
			attack_member.updateStatus("");
			attack_member.processAction();
			var attackEvt:BattleEvent=attack_member.memberEvt;
			//attackEvt.act="";
			//attackEvt.updateMemberAct();
			
		}
		
		private function displayDamage(damage:Number):void
		{
			var battleteam:Object=memberscom.getBattleTeam();
			current_damage=damage;
			DebugTrace.msg("BattleScene.displayDamage damage:"+damage);
			var format:TextFormat=numbersTextFormat("damage");
			
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
			
			
			//DebugTrace.msg("BattleScene.displayDamage targetlist:"+targetlist);
			var targetIDlist:Array=new Array();
			targetIDlist=getRangeTargetList(targetlist,from);
			
			for(var k:uint=0;k<targetIDlist.length;k++)
			{
				
				
				var _target_member:Member=battleteam[targetIDlist[k]];
				//var _target_member:MovieClip=battlescene.getChildByName(targetIDlist[k]) as MovieClip;
				
				DebugTrace.msg("BattleScene.displayDamage _target_member.status:"+_target_member.status);
				var damage_txt:TextField=new TextField();
				damage_txt.autoSize=TextFieldAutoSize.CENTER;
				damage_txt.defaultTextFormat=format;
				if(from=="player")
				{
					var  txt_x:Number=_target_member.x+_target_member.width/2-damage_txt.width/2;
					var hurtX:Number=_target_member.x-10;
				}
				else
				{
					txt_x=_target_member.x-_target_member.width/2-damage_txt.width/2;
					hurtX=_target_member.x+10;
				}
				//if
				var extradmg:Number=damage+(5-Math.floor(Math.random()*5)+1);
				
				if(_target_member.power.shielded=="true")
				{
					//var battleEvt:BattleEvent=_target_member.memberEvt;
					//battleEvt.act="stand";
					//battleEvt.updateMemberAct();
					extradmg=Math.floor(damage*0.25);
					if(_target_member.power.ele=="water" && attack_member.power.ele=="fire")
					{
						extradmg=0;
					}
					else if(_target_member.power.ele=="air" && attack_member.power.ele=="earth")
					{
						extradmg=0;
					}
					//if
				}
				else
				{
					//status isn't shield
					targetKnockbackHandle(_target_member);
				}
				//if
				
				//DebugTrace.msg("BattleScene.displayDamage extradmg:"+extradmg);
				
				var predamage:Number=Math.floor(extradmg/targetIDlist.length);
				if(attack_member.power.skillID=="w3")
				{
					predamage=Math.floor(Math.floor((Math.random()*900)+100)/targetIDlist.length);
					predamage+=Math.floor(Math.random()*predamage*2)-predamage;
				}
				//if
				showSplitTextField(_target_member,predamage,damage_txt,txt_x);
				//DebugTrace.msg("BattleScene.displayDamage effect:"+attack_power.effect);
				//DebugTrace.msg("BattleScene.displayDamage predamage:"+predamage);
				_target_member.updateDamage(attack_power.effect,predamage);
				
			}
			
			//for
			
		}
		private function displayReincarnation(damage:Number):void
		{
			/*
			reincarnationSE=member.power.seMax;
			var groundeff:MovieClip=ViewsContainer.groundEffect;
			groundeff.visible=true;
			*/
			DebugTrace.msg("BattleScene.displayReincarnation damage:"+damage);
			
			var player_survive:Array=BattleData.checkPlayerSurvive();
			var cpu_survive:Array=BattleData.checkCpuSurvive();
			var groundeff:MovieClip
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
					if(healMembers[k].power.se!=0)
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
				showSplitTextField(heal_member,perHeal,heal_txt,txt_x);
				//_target_member.updateDamage(attack_power.effect,predamage);
				heal_member.power.se+=perHeal;
				heal_member.updatePower(heal_member.power);
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
				showSplitTextField(damage_member,perDamage,damage_txt,txt_x);
				damage_member.updateDamage("",perDamage);
			}
			//for
			
		}
		private function showSplitTextField(member:Member,numbers:Number,split_txt:TextField ,posX:Number):void
		{
			
			split_txt.text=String(numbers);
			split_txt.x=posX;
			split_txt.y=member.y+member.height/2;
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
					
					var target_id:String="player"+targetlist[n];
					list.push(target_id);
					
				}
				else
				{
					
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
			var elemends:Array=Config.btl_elements;
			DebugTrace.msg("BattleScene.updateSpritEnergy  elemends:"+elemends);
			elepanel=new ElementsPanel();	
			elepanel.name="elepanel";
			elepanel.x=current_player.x-current_player.width/2;
			elepanel.y=current_player.y+current_player.height/2;
			battlescene.addChild(elepanel);
			for(var i:uint=0;i<elemends.length;i++)
			{
				var elebtn:MovieClip=elepanel[elemends[i]];
				
				elebtn.mouseChildren=false;
				elebtn.buttonMode=true;
				elebtn.addEventListener(MouseEvent.CLICK,doChangedElement);
				elebtn.addEventListener(MouseEvent.MOUSE_OVER,doMouseOverElement);
				elebtn.addEventListener(MouseEvent.MOUSE_OUT,doMouseOutElement);
				if(elemends[i]=="com" && current_player.power.name!="player")
				{
					//not commander
					/*TweenMax.delayedCall(0.2,disableColorTransform,[elebtn]);
					
					elebtn.buttonMode=false;
					elebtn.removeEventListener(MouseEvent.CLICK,doChangedElement);
					elebtn.removeEventListener(MouseEvent.MOUSE_OVER,doMouseOverElement);
					elebtn.removeEventListener(MouseEvent.MOUSE_OUT,doMouseOutElement);*/
					disabledCommander(elebtn)
				}
				
			}
			//for
			function disabledCommander(combtn:MovieClip):void
			{
				TweenMax.delayedCall(0.2,disableColorTransform,[combtn]);
				
				combtn.buttonMode=false;
				combtn.removeEventListener(MouseEvent.CLICK,doChangedElement);
				combtn.removeEventListener(MouseEvent.MOUSE_OVER,doMouseOverElement);
				combtn.removeEventListener(MouseEvent.MOUSE_OUT,doMouseOutElement);
				
				
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
			var power:Object=current_player.power;
			DebugTrace.msg("BattleScene.doChangedElement power:"+JSON.stringify(power));
			element=e.target.name;
			removeElEmentPanel();
			
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
				commander=current_player;
				if(power.name=="player")
				{	
					showItemsPanel(true);
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
					TweenMax.to(itemspanel,0.5,{x:225,ease:Expo.easeOut});
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
			showUseItemConfirm();
			
			TweenMax.to(itemspanel,0.5,{y:800,ease:Expo.easeOut,onComplete:onItemPenelFadoutComplete});
			//showItemsPanel(false);
			
		}
		private function showUseItemConfirm():void
		{
			
			itemconfirm=new UseItemConfirm();
			itemconfirm.txt.text="Are you sure using this item ?";
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
			addChild(itemconfirm);
			
		}
		
		private function doConfirmClick(e:MouseEvent):void
		{
			var success:Boolean=true;
			
			var items:Array=flox.getPlayerData("items");
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
				if(items[j].qty>0)
				{
					new_items.push(items[j]);	
				}
				//if
			}
			//for
			
			comType="item";
			switch(itemid)
			{
				case "com0":
					
					savePlayerTeamSE(onPlayerSaveComplete);
					break
				case "com1":
					if(current_player.power.combat<3)
					{
						doCommanderRage();
					}
					else
					{
						success=false
						var msg:String="You cann't use this.Captin must be front row."
						MainCommand.addAlertMsg(msg);
					}
					//if
					break
			}
			//switch
			if(success)
			{
				removeChild(itemconfirm);
				var _data:Object=new Object();
				_data.items=new_items;
				flox.savePlayer(_data);
				
				
			}
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
			
			removeChild(itemconfirm);
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
			
			if(type=="")
			{
				titleTxt.text="";
				TweenMax.to(battletitle,0.5,{x:-500,onComplete:onTweenComplete});
			}
			else
			{
				if(stepTxts[type])
				{
					titleTxt.text=stepTxts[type];
				}
				//if
				//TweenMax.to(battletitle,0.5,{x:-500})
				TweenMax.to(battletitle,0.5,{x:0,ease:Quart.easeOut,onComplete:onTweenComplete});
			}
			//if
			if(type!="startbattle")
			{
				TweenMax.to(battletitle,0.5,{x:0,ease:Quart.easeOut,onComplete:onTweenComplete});
			}
			
			
			
			removePlayerHighlight();
			var stonebar:MovieClip=elestonecom.getStonebar();
			if(cardsSprtie)
			{
				TweenMax.to(cardsSprtie,0.5,{y:450,onComplete:onCardFadeout,ease:Expo.easeOut});
			}
			switch(type)
			{
				case "solider":
					starttab.y=0;
					starttab.wall.x=0;
					starttab.wall.visible=false;
					stonebar.alpha=0;
					profile.alpha=0;
					TweenMax.to(starttab.btn,0.8,{y:709,ease:Expo.easeOut,onComplete:onTweenComplete});
					TweenMax.to(elementsbar,0.5,{x:1024,onComplete:onTweenComplete,ease:Expo.easeOut});	
					TweenMax.to(menubg,0.5,{y:450,onComplete:onTweenComplete,ease:Expo.easeOut});	
					TweenMax.to(sebar,0.8,{y:500,onComplete:onSEbarFadein,ease:Expo.easeOut});
					TweenMax.to(menuscene,2,{y:354,onComplete:onTweenComplete,ease:Expo.easeOut});
					showPlayerHighlight();
					break
				case "skill":
					TweenMax.to(stonebar,0.8,{alpha:1,onComplete:onTweenComplete,ease:Expo.easeOut});	
					TweenMax.to(elementsbar,0.5,{x:350,onComplete:onTweenComplete,ease:Expo.easeOut});	
					
					/*if(cardsSprtie)
					{
					TweenMax.to(cardsSprtie,0.5,{y:800,onComplete:onCardFadeout,ease:Elastic.easeInOut});
					}*/
					//if
					break
				case "startbattle":
					TweenMax.to(starttab.btn,0.5,{y:800,onComplete:onTweenComplete,ease:Expo.easeOut});
					//battletitle.x=-500;
					TweenMax.to(battletitle,0.5,{x:-500,onComplete:onTweenComplete,ease:Expo.easeOut});
					TweenMax.to(battlescene,1,{y:-578,onComplete:onTweenComplete,ease:Expo.easeOut});
					TweenMax.to(menuscene,1,{y:700,onComplete:onBattleSceneComplete});
					break
				case "target":
					starttab.wall.x=500;
					starttab.wall.visible=true;
					
					//TweenMax.to(cardsSprtie,0.5,{y:800,onComplete:onCardFadeout,ease:Expo.easeInOut});
					break
				case "heal target":
					TweenMax.to(menuscene,0.5,{y:700,onComplete:onTweenComplete});
					//TweenMax.to(cardsSprtie,0.5,{y:800,onComplete:onCardFadeout,ease:Expo.easeInOut});
					break
				case "itempanel":
					
					TweenMax.to(starttab,0.8,{y:90,ease:Expo.easeOut,onComplete:onTweenComplete});
					TweenMax.to(menuscene,1,{y:700,onComplete:onTweenComplete});
					
					break
				case "disabled itempanel":
					TweenMax.to(menuscene,1,{y:354,onComplete:onTweenComplete,ease:Expo.easeOut});
					TweenMax.to(starttab,0.8,{y:0,onComplete:onTweenComplete,ease:Expo.easeOut});
					break
			}
			
			//switch
			
			
		}
		private function showPlayerHighlight():void
		{
			removePlayerHighlight();
			var battleteam:Object=memberscom.getBattleTeam();
			var playerteam:Array=memberscom.getPlayerTeam();
			for(var i:uint=0;i<playerteam.length;i++)
			{
				var playermember:Member=playerteam[i];
				//var status:String=playermember.getStatus();
				//DebugTrace.msg("BattleScene.showPlayerHighlight status:"+playermember.status);
				var status:String=playermember.status;
				var se:Number=playermember.power.se;
				if(status!="dizzy" && se>0)
				{
					TweenMax.to(playermember,0.25,{colorTransform:{tint:0xffffff, tintAmount:0.5}});
					TweenMax.to(playermember,0.25,{delay:0.5,removeTint:true,onComplete:onPlayerCompleteHightlight,onCompleteParams:[playermember]});
				}
				//if
			}
			//for
			//DebugTrace.msg("BattleScene.showPlayerHighlight  player_survive:" +player_survive);
		}
		private function onPlayerCompleteHightlight(member:Member):void
		{
			//DebugTrace.msg("BattleScene.onPlayerCompleteHightligh");
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
		private function onTweenComplete():void
		{
			
			TweenMax.killAll(true);
			
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
			
			comType="cpu skill";
			var alert:MovieClip=new ChangeFormationAlert();
			addChild(alert);
			
			TweenMax.delayedCall(2,savePlayerHandle);
			function savePlayerHandle():void
			{
				TweenMax.killDelayedCallsTo(savePlayerHandle);
				savePlayerTeamSE(onPlayerSaveComplete);
			}
		}
		
		/*private function initLoadCharacter():void
		{
		
		var queue:LoaderMax = new LoaderMax({name:"mainQueue",onComplete:onCharacterComplete,onProgress:progressHandler});
		
		for(var i:uint=0;i<10;i++)
		{
		var posX:Number=Math.floor(Math.random()*500);
		var posY:Number=Math.floor(Math.random()*500);
		swfloader=new SWFLoader("../swf/B_norm.swf", {name:"B_norm"+i,x:posX,y:posY, container:this});
		
		queue.append(swfloader);
		}
		//LoaderMax.prioritize("photo1");
		queue.load();
		
		
		}*/
		//private function onCharacterComplete(e:LoaderEvent):void
		/*private function onCharacterComplete(target:MovieClip):void
		{
		var chArr:Array=["lns","sao","zak"];
		var colors:Array=[0x99CC33,0x99FFFF,0xFF9999];
		var skins:Array=[0x999966,0xFFFFFF,0x663300];
		for(var i:uint=0;i<10;i++)
		{
		var hair:String=chArr[Math.floor(Math.random()*chArr.length)];  
		var color:Number=colors[Math.floor(Math.random()*colors.length)];  
		var skin:Number=skins[Math.floor(Math.random()*skins.length)];  
		//var swfloader:SWFLoader=LoaderMax.getLoader("B_norm"+i);
		//var b_norm:ContentDisplay = LoaderMax.getContent("B_norm"+i);
		//var boy:MovieClip = swfloader.getSWFChild("Boy") as MovieClip;
		var boy:MovieClip=target;
		for(var j:uint=0;j<chArr.length;j++)
		{
		
		boy[chArr[j]].visible=false;
		
		}
		//for
		boy[hair].visible=true;
		if(i>0)
		{
		boy[hair].gotoAndStop(1);
		boy.accents.gotoAndStop(1);
		boy.skin.gotoAndStop(1);
		boy.eyes.gotoAndStop(1);
		boy.body1.gotoAndStop(1);
		boy.body2.gotoAndStop(1);
		boy.gotoAndStop("ready");
		}
		TweenMax.to(boy.accents, 1, {colorTransform:{tint:color, tintAmount:1}});
		TweenMax.to(boy.skin, 1, {colorTransform:{tint:skin, tintAmount:1}});
		//TweenMax.to(boy.boy, 1, {colorTransform:{tint:skin, tintAmount:1}});
		
		}
		
		//trace(e.target.content)
		
		}*/
		/*private function progressHandler(event:LoaderEvent):void
		{
		trace("progress: " + event.target.progress);
		}*/
	}
}