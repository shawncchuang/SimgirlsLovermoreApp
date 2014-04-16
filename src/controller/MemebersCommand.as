package controller
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import data.DataContainer;
	
	import events.BattleEvent;
	import events.GameEvent;
	import events.SceneEvent;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	import views.BattleScene;
	import views.Member;
	import views.VictoryBonus;
	
	public class MemebersCommand implements MembersInterface
	{
		private var cpupos:Array=[new Point(308,784),new Point(278,918),new Point(248,1044),
			//new Point(140,70),new Point(160,200),new Point(180,330),
			new Point(98,784),new Point(67,913),new Point(37,1044)
		]
		private var playerpos:Array=[new Point(630,784),new Point(601,914),new Point(568,1044),
			//new Point(750,70),new Point(730,200),new Point(710,330),
			new Point(839,784),new Point(810,914),new Point(780,1044)
		]
		private var battlescene:Sprite;
		private var flox:FloxInterface=new FloxCommand();
		private var cpucom:CpuMembersInterface=new CpuMembersCommand();
		//cpu team ,extends Member
		private static var cputeam:Array;
		//cpu main team data, didn't extends Memeber ;
		private var cpu_team:Array;
		private var characters:Array;
		private var current_player:Member;
		private var play_power:Array;
		private var top_index:uint=0;
		private static var playerteam:Array;
		private var battleteam:Object;
		private var player_index:uint=0
		private var battleover:Boolean=false;
		private var hurtplayer:Array=new Array();
		public static var battleEvt:BattleEvent;
		public function init(scene:MovieClip):void
		{
			battlescene=scene;
			
			
			var evt:BattleEvent=new BattleEvent();
			evt.addEventListener(BattleEvent.SWITCH_INDEX,switchMemberIndex);
			battleEvt=evt;
			
			cpucom.setupBattleTeam();
			
		}
		
		public function nextRound():void
		{
			player_index=0;
			
			
			for(var id:String in battleteam)
			{
				
				battleteam[id].updateRound();
			}
			//for
			cpucom.nextRound();
			cpucom.healSetUp();
			cpucom.setupSkillCard();
			cpucom.setupCpuTarget();
			cpucom.commanderSkill();
			
		}
		public function  reseatCPUPower(id:String):void
		{
			//after commander skill
			battleteam[id].updateRound();
			cpucom.nextRound();
			cpucom.healSetUp();
			cpucom.setupSkillCard();
			cpucom.setupCpuTarget();
		}
		public function setPlayerIndex(index:uint):void
		{
			player_index=index;
		}
		public static function set playerTeam(members:Array):void
		{
			playerteam=members;
		}
		public static function get playerTeam():Array
		{
			return playerteam;
		}
		public function getPlayerTeam():Array
		{
			
			return playerteam;
			
		}
		public static function set cpuTeam(members:Array):void
		{
			cputeam=members;
		}
		
		public function getCpuTeam():Array
		{
			return cputeam;
		}
		
		public function getTopIndex():uint
		{
			return top_index;
		}
		public function getBattleTeam():Object
		{
			//all members
			return battleteam;	
		}
		public function getBattleOver():Boolean
		{
			return battleover
		}
		public function initPlayerMember(clickPlayer:Function):void
		{
			playerteam=new Array();
			battleteam=new Object();
			var membersEffect:Object=DataContainer.MembersEffect;
			var seObj:Object=flox.getSaveData("se");
			var formation:Array=flox.getSaveData("formation");
			characters=new Array();
			
			var player_power:Array=new Array();
			
			for(var j:uint=0;j<formation.length;j++)
			{
				var formationStr:String=JSON.stringify(formation[j]);
				DebugTrace.msg("MemebersCommand.initPlayerMember formation["+j+"]:"+formationStr);
				
				if(formation[j])
				{
					
					
					var power:Object=new Object();
					power=formation[j];
					var member:Member=new Member();
					member.initPlayer(j);
					power.se=seObj[formation[j].name];
					power.id=member.name;
					power.speeded="false";
					power.shielded="false";
					power.skillID="";
					power.reincarnation="false";
					member.updatePower(power);
					member.x=playerpos[j].x+member.width;
					member.y=playerpos[j].y+40;
					battlescene.addChild(member);
					battleteam[member.name]=member;
					playerteam.push(member);
					var battleEvt:BattleEvent=member.memberEvt;
					battleEvt.act="stand";
					battleEvt.updateMemberAct();
					member.membermc.addEventListener(MouseEvent.CLICK,clickPlayer);
					player_power.push(power);
				}
				//if
			}
			//for
			//for testing bonus game------------------------------
			DataContainer.PlayerPower=player_power;
			
			playerTeam=playerteam;
			ViewsContainer.battleteam=battleteam;
			DataContainer.MembersEffect=membersEffect;
		}
		public function removePlayerMemberListener(clickPlayer:Function):void
		{
			
			for(var i:uint=0;i<playerteam.length;i++)
			{
				playerteam[i].membermc.buttonMode=false;
				playerteam[i].membermc.removeEventListener(MouseEvent.CLICK,clickPlayer);
				
			}
			//for	
			
		}
		public function addPlayerMemberListener(clickPlayer:Function):void
		{
			
			for(var i:uint=0;i<playerteam.length;i++)
			{
				if(playerteam[i].power.se>0)
				{
					playerteam[i].membermc.buttonMode=true;
					playerteam[i].membermc.addEventListener(MouseEvent.CLICK,clickPlayer);
				}
				//if
			}
			//for
			
			
		}
		public function initCpuMember():void
		{
			cputeam=new Array();
			var copy_cpupos:Array=new Array();
			for(var m:uint=0;m<cpupos.length;m++)
			{
				var obj:Object=new Object()
				obj.x=cpupos[m].x;
				obj.y=cpupos[m].y+40;
				obj.index=m;
				copy_cpupos.push(obj)
			}
			//for
			
			var cpu_team:Array=cpucom.getCpuMainTeam();
			var new_cpupos:Array=new Array();
			for(var j:uint=0;j<cpu_team.length;j++)
			{
				var index:Number=Math.floor(Math.random()*copy_cpupos.length);
				new_cpupos.push(copy_cpupos[index]);
				var _cpupos:Array=copy_cpupos.splice(index);
				_cpupos.shift();
				copy_cpupos=copy_cpupos.concat(_cpupos);
			}
			//for
			//_copy_cpupos.sortOn("index",Array.NUMERIC);
			new_cpupos.sortOn("index",Array.NUMERIC);
			//var cpu_teams:Object=flox.getSyetemData("cpu_teams");
			//var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
			var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
			//var cpupower:Array=cpucom.getCpuPower();
			//DebugTrace.msg("BattleScene.initCpuMember new_cpupos="+JSON.stringify(new_cpupos));
			for(var i:uint=0;i<cpu_team.length;i++)
			{
				//index=uint(Math.random()*copy_cpupos.length);
				
				//DebugTrace.msg("BattleScene.initCpuMember new_cpupos["+i+"].index="+new_cpupos[i].index);
				//cpu_team[i].combat=_copy_cpupos[i].index;
				cpu_team[i].combat=new_cpupos[i].index;
				cpu_team[i].se=cpu_teams_saved[cpu_team[i].id].se;
				
				var member:Member=new Member();
				member.initCpuPlayer(cpu_team,i);
				member.updatePower(cpu_team[i]);
				member.x=new_cpupos[i].x;
				member.y=new_cpupos[i].y;
				battlescene.addChild(member);
				battleteam[member.name]=member;
				//DebugTrace.msg("BattleScene.initCpuMember member:"+member.name);
				cputeam.push(member);
				var battleEvt:BattleEvent=member.memberEvt;
				battleEvt.act="ready";
				battleEvt.updateMemberAct();
				top_index=battlescene.getChildIndex(member);
				
			}
			//for
			cpuTeam=cputeam;
			CpuMembersCommand.cputeamMember=cputeam;
			ViewsContainer.battleteam=battleteam;
			
			 
			cpucom.healSetUp();
			cpucom.setupSkillCard();
			cpucom.setupCpuTarget();
			cpucom.commanderSkill();
			
		}
		public function switchMemberIndex(e:Event):void
		{
			DebugTrace.msg("BattleScene.switchMemberIndex id:"+e.target.id+",top_index:"+top_index);
			battlescene.setChildIndex(battleteam[e.target.id],top_index);
			
		}
		public function playerReadyPickupCard(id:String):void
		{
			
			
			//DebugTrace.msg("BattleScene.playerReadyPickupCard combat:"+power.combat);
			
			/*for(var i:uint=0;i<playerteam.length;i++)
			{
			//DebugTrace.msg("BattleScene.playerReadyPickupCard formation:"+JSON.stringify(formation[i]));
			
			
			var battleEvt:BattleEvent=playerteam[i].memberEvt;
			
			battleEvt.act="stand";
			
			if(playerteam[i].power.target!="")
			{
			
			battleEvt.act="ready";
			
			}
			//if
			DebugTrace.msg("BattleScene.playerReadyPickupCard status:"+playerteam[i].status);
			if(playerteam[i].status=="dizzy" || playerteam[i].status=="rage")
			{
			//var status:String=playerteam[i].getStatus();
			battleEvt.from="playerReadyPickupCard";
			battleEvt.act="";
			}
			battleEvt.updateMemberAct();
			}
			//for*/
			if(id!="all")
			{
				current_player=battleteam[id];
				battlescene.setChildIndex(current_player,top_index);
				/*battleEvt=current_player.memberEvt
				battleEvt.act="ready_to_attack";
				battleEvt.updateMemberAct();
				battleEvt.actComplete();*/
				current_player.processAction();
			}
			else
			{
				
				for(var i:uint=0;i<playerteam.length;i++)
				{
					//DebugTrace.msg("BattleScene.playerReadyPickupCard formation:"+JSON.stringify(formation[i]));
					
					
					/*var battleEvt:BattleEvent=playerteam[i].memberEvt;
					battleEvt.from="playerReadyPickupCard";
					battleEvt.act="";
					battleEvt.updateMemberAct();
					battleEvt.actComplete();*/
					
					playerteam[i].processAction();
				}
				//for
			}
			//if
			
		}
		public function choiceTarget(setupTarget:Function,overTarget:Function,outTraget:Function):void
		{
			for(var i:uint=0;i<cputeam.length;i++)
			{
				
				cputeam[i].addEventListener(MouseEvent.CLICK,setupTarget);
				cputeam[i].addEventListener(MouseEvent.MOUSE_OVER,overTarget);
				cputeam[i].addEventListener(MouseEvent.MOUSE_OUT,outTraget);
				
			}
			
		}
		public function reseatCpuTeam(setupTarget:Function,overTarget:Function,outTraget:Function):void
		{
			for(var i:uint=0;i<cputeam.length;i++)
			{
				//TweenMax.to(cputeam[i],0.2,{tint:null});
				cputeam[i].removeEventListener(MouseEvent.CLICK,setupTarget);
				cputeam[i].removeEventListener(MouseEvent.MOUSE_OVER,overTarget);
				cputeam[i].removeEventListener(MouseEvent.MOUSE_OUT,outTraget);
			}
			//for
		}
		private var battlealert:MovieClip;
		public function checkTeamSurvive():void
		{
			var cpu_gameover:Boolean=true;
			var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
			var player_gameover:Boolean=true;
			var seObj:Object=flox.getSaveData("se");
			var member:Member;
			
			var current_se:Number;
			for(var i:uint=0;i<cputeam.length;i++)
			{   
				member=cputeam[i];
				//setxt= membermc.getChildByName("se") as TextField;
				current_se=member.power.se;
				if(current_se>0)
				{
					cpu_gameover=false;
					break
				}
				//if
			}
			//for
			var player_power:Array=new Array();
			for(var j:uint=0;j<playerteam.length;j++)
			{
				member=playerteam[j];
				//setxt=membermc.getChildByName("se") as TextField;
				DebugTrace.msg("BattleScene checkTeamSurvive power:"+JSON.stringify(member.power));
				current_se=member.power.se;
				seObj[member.power.name]=current_se;
				player_power.push(member.power);
				if(current_se>0)
				{
					player_gameover=false;
					break
				}
				//if
			}
			//for
			DataContainer.PlayerPower=player_power;
			
			if(cpu_gameover ||  player_gameover)
			{
				//GameOver--------------------------------
				
				
				DebugTrace.msg("BattleScene checkTeamSurvive-------- Batttle Over seObj:"+JSON.stringify(seObj));
				battleover=true;
				
				flox.save("se",seObj);
				
				var battlescene:Sprite=ViewsContainer.battlescene;
				if(cpu_gameover)
				{
					battlealert=new VictoryAlert();	
				}
				if(player_gameover)
				{
					battlealert=new DefeatAlert();
				}
				battlealert.alpha=0;
				battlescene.addChild(battlealert);
				
				TweenMax.to(battlealert,1,{alpha:1});
				TweenMax.delayedCall(2,onBattleAlertFadIn);
				
				function onBattleAlertFadIn():void
				{
					TweenMax.to(battlealert,0.5,{alpha:0,onComplete:onBattleAlertFadeout});
					
				}
				function onBattleAlertFadeout():void
				{
					TweenMax.killAll();
					if(cpu_gameover)
					{
						
						 var battleEvt:BattleEvent=BattleScene.battleEvt;
						 battleEvt.onStartBonusGame();
						
					}
					else
					{
						
						var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
						gameEvt._name="remove_battle";
						gameEvt.displayHandler();
						
						var command:MainInterface=new MainCommand();	
						var _data:Object=new Object();
						_data.name= "SSCCArenaScene";
						command.sceneDispatch(SceneEvent.CHANGED,_data);
					}
					//if
				}
				
			}
			else
			{
				
				
				/*for(var k:uint=0;k<playerteam.length;k++)
				{
				member=playerteam[k];
				//setxt=membermc.getChildByName("se") as TextField;
				current_se=member.power.se;
				if(current_se==0)
				{
				hurtplayer.push(playerteam[k]);
				
				var _playerteam:Array= playerteam.splice(k)
				_playerteam.shift();
				var new_playerteam:Array=playerteam.concat(_playerteam);
				playerteam=new_playerteam;
				}
				//if
				}*/
				//for
				//DebugTrace.msg("MemebersCommand.checkTeamSurvive hurtplayer:"+hurtplayer+" ; @lu:"+hurtplayer.length);
				//DebugTrace.msg("MemebersCommand.checkTeamSurvive playerteam:"+playerteam+" ; @lu:"+playerteam.length);
				
			}
			//if
			//DataContainer.survivePlayer=playerteam;
		}
		private var equipedlist:Array=new Array();
		private var equipedcard:MovieClip;
		public function equipedCard(card:MovieClip):void
		{
			var equipedcard:MovieClip=new EquipedCard();
			equipedcard.x=card.x+card.parent.x+(card.width/2);
			equipedcard.y=battlescene.height-card.parent.y/2;
			battlescene.addChild(equipedcard);
			equipedlist[player_index]=equipedcard;
			//DebugTrace.msg("MemebersCommand.removeEquipedCard  equipedlist["+player_index+"]="+equipedlist[player_index]);
			var posX:Number=playerteam[player_index].x-40;
			var posY:Number=playerteam[player_index].y+playerteam[player_index].height/2;
			TweenMax.to(equipedcard,1,{x:posX,y:posY,scaleX:0.5,scaleY:0.5,ease:Expo.easeOut});
			
			
		}
		public function removeEquipedCard():void
		{
			equipedcard=equipedlist[player_index];
			//DebugTrace.msg("MemebersCommand.removeEquipedCard  equipedcard["+player_index+"]"+equipedcard);
			if(equipedcard)
			{
				var posX:Number=equipedcard.x;
				var posY:Number=equipedcard.y;
				TweenMax.to(equipedcard,0.25,{x:posX+50,y:posY+10,scaleX:0.8,scaleY:0.8,onComplete:onMotionEquiped,ease:Cubic.easeOut});
				function onMotionEquiped():void
				{
					TweenMax.to(equipedcard,0.5,{x:posX+300,y:posY+20,scaleX:0.1,scaleY:0.1,onComplete:onEquipedFadeout,ease:Cubic.easeOut});	
				}
				
			}
			//if
		}
		private function onEquipedFadeout():void
		{
			TweenMax.killTweensOf(equipedcard);
			battlescene.removeChild(equipedcard);
			equipedlist[player_index]=null;
		}
		public function removeAllEquidedCards():void
		{
			
			for(var i:uint=0;i<equipedlist.length;i++)
			{
				var _equipedcard:MovieClip=equipedlist[i];
				if(_equipedcard)
				{
					battlescene.removeChild(_equipedcard);
					equipedlist[i]=null;
				}
				
				
			}
			//for
			
			
		}
		public function clearPlayerTarget():void
		{
			
			for(var i:uint=0;i<playerteam.length;i++)
			{
				var player_member:Member=playerteam[i];
				player_member.power.target="";
				player_member.power.targetlist=new Array();
				player_member.updatePower(player_member.power);
				if(player_member.status=="mind_ctrl")
				{
					player_member.updateStatus("");
					player_member.processAction();
				}
				//if
				
			}
			
			
		}
		private function seTextfield(str:String):TextField
		{
			var format:TextFormat=new TextFormat();
			format.color=0xFFFFFF;
			format.size=14;
			format.font="Neogrey Medium";
			var  txt:TextField=new TextField();
			txt.name="se";
			txt.defaultTextFormat=format;
			txt.autoSize=TextFieldAutoSize.LEFT;
			txt.y=20;
			txt.text=str;
			
			return txt
		}
		
		/*public function praseMemberStatus():void
		{
		var memberseffect:Object=DataContainer.MembersEffect;
		
		play_power=BattleScene.play_power;
		var formation:Array=flox.getSaveData("formation");
		//if(play_power[0])
		//{
		
		for(var n:String in memberseffect)
		{
		
		var current_effect:String=memberseffect[n];
		DebugTrace.msg("MembersCommand.praseMemberPart memberseffect["+n+"]:"+memberseffect[n]);
		
		
		if(n.indexOf("player")!=-1)
		{
		//player team
		var combat:Number=Number(n.split("player").join(""));
		var member_model:MovieClip=battlescene.getChildByName(n) as MovieClip;
		var member:MovieClip=member_model.getChildByName("character") as MovieClip;	
		var player_name:String=formation[combat].name;
		if(current_effect!="" && current_effect!=null)
		{
		var act:String=current_effect;
		}
		else
		{
		act="stand";
		}
		//if
		}
		else
		{
		//cpu team
		member=battlescene.getChildByName(n) as MovieClip;
		//fake
		player_name="sao";
		if(current_effect!="" && current_effect!=null)
		{
		act=current_effect;
		}
		else
		{
		act="ready";
		}
		
		}
		
		//praseMemberPart(member,act,player_name);
		}
		//for
		
		//}
		//if
		
		}*/
		
		
	}
}