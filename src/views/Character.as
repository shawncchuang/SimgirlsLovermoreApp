package views
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MembersInterface;
	import controller.MemebersCommand;
	
	import data.DataContainer;
	
	import events.BattleEvent;
	
	import model.BattleData;
	
	import utils.DebugTrace;
	
	import views.BattleScene;
	
	public class Character extends MovieClip
	{
		
		protected var flox:FloxInterface=new FloxCommand();
		private var characters:Array=new Array();
		protected var status:String="";
		protected var ch_name:String;
		protected var id:String;
		//private var playermc:MovieClip;
		protected var character:MovieClip;
		//private var cpumc:MovieClip;
		//power={"id":"t0_4","enemy":1,"se":100,"target":"player1","combat":4,"effect":"dizzy","area":0,"targetlist":[1],
		//"speed":130,"ele":"air","label":"Whirlwind Punch","from":"cpu","power":35,"jewel":"2|a"}
		protected var power:Object=new Object();
		protected var selected:Boolean=false;
		protected var membermc:MovieClip;
		protected var arrow:MovieClip;
		protected var dissytap:EffectTapView;
		private var round:Number=0;
		private var rage_round:Number=0;
		private var timer:Timer;
		private var scared_reduce_speed:Number=0.5;
		protected var plus_speed:Number=100;
		private var ett:MovieClip;
		private var _from:String;
		protected var effShield:MovieClip=null;
		private var part_pack:Array=new Array();
		private var bpart_pack:Array=["zack","xns","vdk","smn","shn","sao","prms","prml",
			"playerb","playera","lenus","helmb","helma","fan","bdh"];
		private var gpart_pack:Array=["sirena","tomoru","dea","ceil","player"];
		private  static var ready:String="RDY";
		private  static var knock_back:String="KnockBack";
		private  static var hop:String="HOP";
		private  static var hurt:String="HURT";
		private  static var rage:String="RAGE";
		private static var dizzy:String="DIZZY";
		private static var scared:String="SCARED";
		private  static var death:String="DEATH";
		public function Character()
		{
			
		}
		public function updatePower(_data:Object):void
		{
			
			if(id.indexOf("player")!=-1)
			{
				var loves:Object=flox.getSaveData("love");
				var maxSE:Number=Number(loves[power.name]);
				
			}
			else
			{
				//cpu
				var cpuSE:Object=flox.getSaveData("cpu_teams");
				maxSE=Number(cpuSE[id].seMax);
				
			}
			//if
			if(_data)
			{
				if(!_data.target)
				{
					var target:String="";
				}
				else
				{
					target=_data.target;
				}
				//if
				for(var i:String in _data)
				{
					
					if(status=="scared" && i=="speed")
					{
						_data[i]=Math.floor(_data[i]*scared_reduce_speed);
					}
					//if
					
					if(i=="se" && _data[i]>maxSE)
					{
						_data[i]=maxSE;
					}
					power[i]=_data[i];
				}
				//for
				if(power.shielded=="true")
				{
					DebugTrace.msg("Character.updatePower name:"+power.name+" ,EffectShield");
					if(!effShield)
					{
						effShield=new EffectShield();
						effShield.name="shield_"+name;
						if(id.indexOf("player")!=-1)
						{
							effShield.x=-(effShield.width);
						}
						//if
						addChild(effShield);
					}
					//if
				}
				
				
				var seText:TextField=membermc.getChildByName("se") as TextField;
				seText.visible=true;
				seText.text=String(power.se);
			}
			else
			{
				power=new Object();
			}
			//if
			//DebugTrace.msg("Character.updatePower status="+status);
			DebugTrace.msg("Character.updatePower power="+ JSON.stringify(power));
			
		}
		/*public function onSelected():void
		{
		if(!selected)
		{
		
		selected=true;
		var arrow:MovieClip=membermc.getChildByName("arrow") as MovieClip;
		arrow.visible=false;
		}
		else
		{
		selected=false;
		}
		
		}*/
		
		public function initPlayer(index:Number):void
		{
			var membersEffect:Object=DataContainer.MembersEffect;
			var seObj:Object=flox.getSaveData("se");
			var formation:Array=flox.getSaveData("formation");
			var formation_info:String=JSON.stringify(formation[index]);
			
			ch_name=formation[index].name;
			membermc=new MovieClip();
			var player_id:String="player"+formation[index].combat;
			id=player_id;
			
			membersEffect[player_id]="";
			var gender:String=flox.getSaveData("avatar").gender;
			if(ch_name=="player")
			{
				ch_name=gender+"_"+ch_name;
			}
			var boy_names:Array=["lenus","sao","zack","Male_player"];
			var girl_names:Array=["sirena","tomoru","dea","klaire","Female_player"];
			if(boy_names.indexOf(ch_name)!=-1)
			{
				characters=["lenus","sao","player"];
				part_pack=bpart_pack;
				character=new Boy();
			}
			//if
			if(girl_names.indexOf(ch_name)!=-1)
			{
				characters=["sirena","tomoru","dea","ceil","player"];
				part_pack=gpart_pack;
				character=new Girl();
			}
			//if
			var effect:MovieClip=new Effect();
			effect.name="effect";
			character.addChild(effect);
			character.name="character";
			character.scaleX=-1;
			if(ch_name.indexOf("player")!=-1)
			{
				ch_name=ch_name.split("_")[1];
			}
			var se:String=String(seObj[ch_name]);
			var seTxt:TextField=seTextfield(se);
			seTxt.x=-85;
			arrow=new ArrowFinger();
			arrow.name="arrow";
			arrow.x=-character.width;
			arrow.y=character.height/2;
			arrow.visible=false;
			membermc.addChild(character);
			membermc.addChild(seTxt);
			membermc.addChild(arrow);
			
			addChild(membermc);
			
			membermc.addEventListener(MouseEvent.MOUSE_OVER,onOverPlayer);
			membermc.addEventListener(MouseEvent.MOUSE_OUT,onOutPlayer);
		}
		private var healArea:Array;
		
		private function onOverPlayer(e:MouseEvent):void
		{
			//DebugTrace.msg("Character.onOverPlayer fighting="+ BattleScene.fighting);
			if(!BattleScene.fighting)
			{
				//var arrow:MovieClip=e.target.getChildByName("arrow") as MovieClip;
				arrow.visible=true;
			}
			//if
			var current_power:Object=DataContainer.currentPower;
			if(current_power.skillID=="n2" && current_power.skillID!=undefined)
			{
				if(e.target.name.indexOf("Heal")!=-1)
				{
					var battledata:BattleData=new BattleData();
					var combat:Number=e.target.name.split("Healplayer").join("");
					
					healArea=battledata.praseTargetList(current_power,combat);
					
					var heal_target:Array=new Array();
					for(var i:uint=0;i<healArea.length;i++)
					{
						var memberscom:MembersInterface=new MemebersCommand();
						var player_team:Array=memberscom.getPlayerTeam();
						for(var j:uint=0;j<player_team.length;j++)
						{
							if(player_team[j].power.combat==healArea[i])
							{
								heal_target.push(player_team[j]);
								
								var battleEvt:BattleEvent=player_team[j].memberEvt;
								battleEvt.enabledAreaMemberHeal();
							}
							//if
						}
						//for
					}
					//for
					DataContainer.healArea=heal_target;
				}
				//if
			}
			//if
		}
		private function onOutPlayer(e:MouseEvent):void
		{
			if(!BattleScene.fighting)
			{
				//var arrow:MovieClip=e.target.getChildByName("arrow") as MovieClip;
				arrow.visible=false;
			}
			var current_power:Object=DataContainer.currentPower;
			if(current_power.skillID=="n2")
			{
				if(e.target.name.indexOf("Heal")!=-1)
				{
					var memberscom:MembersInterface=new MemebersCommand();
					var player_team:Array=memberscom.getPlayerTeam();
					for(var j:uint=0;j<player_team.length;j++)
					{
						var battleEvt:BattleEvent=player_team[j].memberEvt;
						battleEvt.disabledMemberHeal();
					}
					
				}
				//if
			}
			//if
		}
		private function clickPlayer(e:MouseEvent):void
		{
			
			DebugTrace.msg("Character.clickPlayer id="+ id);
			var battelEvt:BattleEvent=MemebersCommand.battleEvt;
			battelEvt.id=id;
			battelEvt.switchMemberIndex();
		}
		public function initCpuPlayer(main_team:Array,index:Number):void
		{
			var cpu_teams:Object=flox.getSyetemData("cpu_teams");
			var cpu_teams_saved:Object=flox.getSaveData("cpu_teams");
			
			id=main_team[index].id;
			//fake---------------------------------------------------
			character=new Boy();
			character.name=id;
			membermc=character;
			
			part_pack=bpart_pack;
			//characters=["lenus","sao","zack"];
			if(id.split("_")[1]=="0")
			{
				//boss
				characters=["lenus","sao","player"];
				ch_name="sao";
				
			}
			else
			{
				characters=["helm"];
				ch_name="badguy";
			}
			//if
			
			//-------------------------------------------------------
			
			var effect:MovieClip=new Effect();
			effect.name="effect";
			character.addChild(effect);
			
			var se:String=String(cpu_teams_saved[id].se)
			var seTxt:TextField=seTextfield(se);
			seTxt.x=75;
			var arrow:MovieClip=new ArrowFinger();
			arrow.name="arrow";
			
			arrow.x=membermc.width;
			arrow.y=membermc.height/2;
			arrow.scaleX=-1;
			arrow.visible=false;
			membermc.addChild(seTxt);
			membermc.addChild(arrow);
			addChild(membermc);
			
			
			
			
		}
		public function updateStatus(type:String):void
		{
			status=type;
		}
		public function updateDamage(effect:String,damage:Number):void
		{
			DebugTrace.msg("Character.updateDamage id:"+name+"; effect="+ effect+"; status="+status);
			var current_se:Number=power.se;
			var se:Number=current_se-damage;
			var seText:TextField=membermc.getChildByName("se") as TextField;
			
			if(se<=0)
			{
				se=0;
				
				try
				{
					removeChild(dissytap);
					timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onHealStatus);
				}
				catch(e:Error)
				{
					DebugTrace.msg("Character.updateDamage remove dissytap Error");
				}
				//try
				try
				{
					removeChild(effShield);
				}
				catch(e:Error)
				{
					DebugTrace.msg("Character.updateDamage  remove effShield Error");
				}
				//try
				
				status="death";
				processMember(status);
			}
			else
			{
				
				switch(effect)
				{
					case "dizzy":	
						
						
						if(status!="dizzy")
						{
							//status="dizzy";
							round=1;
							dissytap=new EffectTapView("dizzy_"+id);	
							dissytap.name="dizzy_"+id;
							
							
							if(id.indexOf("player")!=-1)
							{
								dissytap.x=-dissytap.width;
							}
							addChild(dissytap);
							
							if(id.indexOf("player")==-1)
							{
								//cpu
								var index:Number=0;
								var time:Number=Math.floor((Math.random()*30))+20;
								DebugTrace.msg("Character.updateDamage id="+ id+"; time="+time);
								
								timer=new Timer(1000,time);
								//timer.addEventListener(TimerEvent.TIMER,onUpdateHeal);
								timer.addEventListener(TimerEvent.TIMER_COMPLETE,onHealStatus);
								timer.start();
								
								//function
								/*function onUpdateHeal(e:TimerEvent):void
								{
								index++;
								DebugTrace.msg("Character.updateDamage id="+ id+";index="+index);
								}*/
								//function*
							}
							//if
							
						}
						//if
						processMember("dizzy");
						break
					case "scared":
						if(status!="scared")
						{
							round=1;
						}
						processMember("scared");
						power.speeded="false;"
						removeClickTap();
						break
					
				}
				//switch
				if(effect!="")
				{
					status=effect;
					
				}
				else
				{
					processMember("");
				}
				//if
			}
			//if
			
			seText.text=String(se);
			power.se=se;
		}
		private function onHealStatus(e:TimerEvent):void
		{
			//TweenMax.killTweensOf(dissytap);
			
			removeClickTap();
		}
		public function removeClickTap():void
		{
			status="";
			try
			{
				removeChild(dissytap);
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onHealStatus);
				
			}
			catch(e:Error)
			{
				DebugTrace.msg("Character.removeClickTap Error");
			}
			//try
			if(id.indexOf("player")!=-1)
			{
				//player
				var act:String="stand";
				
			}
			else
			{
				//cpu
				act="ready";
				
			}
			//if'
			processMember(act);
		}
		public function updateRound():void
		{
			//DebugTrace.msg("Character.updateRound status:"+status);
			if(id.indexOf("player")!=-1)
			{
				//player
				switch(status)
				{
					case "dizzy":
						round++;
						if(round==4)
						{
							removeClickTap();
						}
						//if
						break
					case "scared":
						round++;
						if(round==4)
						{
							status="";
							processMember("stand");
						}
						//if
						break
					
				}
				//switch
			}
			else
			{
				//cpu
				switch(status)
				{
					case "dizzy":
						timer.stop();
						break
					case "scared":
						round++;
						if(round==4)
						{
							status="";
							processMember("ready");
						}
						break
					
				}
				//switch
				
			}
			//if
			if(power.speeded=="true")
			{
				rage_round++;
				DebugTrace.msg("Character.updateRound name="+power.name+" ; rage_round="+rage_round);
				if(rage_round>2)
				{	
					rage_round=0;
					power.speeded="false";
					//processMember("");
				}
				//if			
			}
			//if
			//if
			//effShield=getChildByName("shield_"+name) as MovieClip;
			try
			{
				//DebugTrace.msg("Character.updateRound remove effShield name="+power.name+" , effShield="+effShield.name);
				
				removeChild(effShield);
				effShield=null;
			}
			catch(e:Error)
			{
				DebugTrace.msg("Character.updateRound remove effShield Error");
			}
			//try
			
			power.shielded="false";
			power.target="";
			power.targetlist=new Array();
			power.label="";
			power.skillID="";
			power.jewel="";
			power.speed=0;
			power.power=0;
			power.enemy=0;
			power.area=0;
			//DebugTrace.msg("Character.updateRound power:"+JSON.stringify(power));
		}
		public function startFight():void
		{
			
			if(status=="dizzy")
			{
				
				timer.start();
				
			}
			//if
			
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
		protected function processAction():void
		{
			var act:String="";
			if(status!="")
			{ 
				if(status=="scared" && power.speeded=="true")
				{
					status="";
				}
				//if
				act=status;
				
			}
			else
			{
				//DebugTrace.msg("Character.processAction  power="+ JSON.stringify(power));
				if(act=="")
				{
					if(power.target==""  || power.target==undefined)
					{
						act="stand";
					}
					//if
					
					if(power.target!="" && power.target!=undefined)
					{
						act="ready_to_attack";
					}
					//if
				}
				//if
				
			}
			//if
			//DebugTrace.msg("Character.processAction  act="+ act);
			processMember(act);
		}
		
		protected function processMember(act:String=null):void
		{
			//play_power=BattleScene.play_power;
			var avatar:Object=flox.getSaveData("avatar");
			
			
			//DebugTrace.msg("Character.processMember id:"+name+" ,status="+status+" , act="+ act);
			
			var effect:MovieClip=character.getChildByName("effect") as MovieClip;
			if(act!="hop")
			act="dizzy";
			//try
			//{
			if(act=="stand")
			{
				
				character.gotoAndStop(1);
				effect.gotoAndStop(1);
				/*
				character.body.act[ch_name].gotoAndStop(1);
				character.body.act.eyes.gotoAndStop(1);
				character.body.act.acc.gotoAndStop(1);
				character.body.act.skin.gotoAndStop(1);
				character.body.act.body.gotoAndStop(1);
				*/
				for(var i:uint=0;i<part_pack.length;i++)
				{
					DebugTrace.msg("Character.processMember part_pack["+i+"]="+part_pack[i]);
					character.body.act[part_pack[i]].gotoAndStop(1);
				}
				//for
				
			}
			else if(act=="ready_to_attack")
			{
				character.gotoAndStop(Character.ready);
				effect.gotoAndStop(Character.ready);
				/*
				character.body.act[ch_name].play();
				character.body.act.eyes.play();
				character.body.act.acc.play();
				character.body.act.skin.play();
				character.body.act.body.play();
				*/
				for(var j:uint=0;j<part_pack.length;j++)
				{
					
					character.body.act[part_pack[j]].play();
				}
				//for
				
			}	
			else 
			{
				character.gotoAndStop(Character[act]);
				effect.gotoAndStop(Character[act]);
				
			}
			//if
			for(var k:uint=0;k<part_pack.length;k++)
			{
				//DebugTrace.msg("Character.processMember part_pack["+k+"]="+part_pack[k]);
				character.body.act[part_pack[k]].visible=false;
			}
			//for	
			if(name.indexOf("player")!=-1)
			{
				//playerb:maskb,playera:maskb
				var girls:String="sirena,tomoru,dea,ceil";
				if(girls.indexOf(ch_name)!=-1)
				{
					//no girl model;
					character.body.act[ch_name].visible=true;
				}
				else
				{
					//Boy
					if(ch_name=="player")
					{
						character.body.act.playera.visible=true;
						character.body.act.playerb.visible=true;
					}
					else
					{
						character.body.act[ch_name].visible=true;
					}
					//if
				}
				//if
			}
			else
			{
				//cpu
				if(ch_name=="badguy")
				{
					character.body.act.helmb.visible=true;
					character.body.act.helma.visible=true;
				}
				else
				{
					character.body.act[ch_name].visible=true;
				}
				//if
			}
			//if
			var arrow:DisplayObject=membermc.getChildByName("arrow");
			arrow.visible=false;
			
			if(name.indexOf("player")!=-1)
			{
				TweenMax.to(character.body.act.skin,0.1, {colorTransform:{tint:avatar.skincolor, tintAmount:0.5}});
				var acc_color:Number=0x6600FF;
				TweenMax.to(character.body.act.acc,0.1, {colorTransform:{tint:acc_color, tintAmount:0.5}});
			}
			//if
			//}
			/*catch(e:Error)
			{
			DebugTrace.msg("Character.processMember Error");
			}
			//try*/
		}
		private function onRageComplete(e:Event):void
		{
			if(e.target.currentFrame==e.target.totalFrames)
			{
				DebugTrace.msg("Character.onRageComplete");
				e.target.removeEventListener(Event.ENTER_FRAME,onRageComplete)
				processMember("stand");
				
			}
			//if
		}
		protected function enabledMemberHeal():void
		{
			ett=new EffectTargetTap();	
			ett.buttonMode=true;
			ett.mouseChildren=false;
			ett.name="Heal"+id;
			
			if(id.indexOf("player")!=-1)
			{
				ett.x=-ett.width;
			}
			//if
			ett.addEventListener(MouseEvent.CLICK,doClickHealTarget);
			ett.addEventListener(MouseEvent.MOUSE_OVER,onOverPlayer);
			ett.addEventListener(MouseEvent.MOUSE_OUT,onOutPlayer);
			addChild(ett);
		}
		protected function removeMemberHeal():void
		{
			
			ett.removeEventListener(MouseEvent.CLICK,doClickHealTarget);
			ett.removeEventListener(MouseEvent.MOUSE_OVER,onOverPlayer);
			ett.removeEventListener(MouseEvent.MOUSE_OUT,onOutPlayer);
			removeChild(ett);
			arrow.visible=false;
		}
		private function doClickHealTarget(e:MouseEvent):void
		{
			var currentPower:Object=DataContainer.currentPower;
			var battleEvt:BattleEvent=BattleScene.battleEvt;
			if(currentPower.skillID=="n2")
			{
				battleEvt.healarea=DataContainer.healArea;
			}
			else
			{
				battleEvt.id=e.target.name;
				
			}
			//if
			battleEvt.usedHealHandle();
			ett.visible=false;
		}
		
		protected function enabledAreaMemberHeal():void
		{
			arrow.visible=true;
		}
		protected function disabledAreaMemberHeal():void
		{
			arrow.visible=false;
		}
		protected function actComplete(from:String):void
		{
			_from=from;
			DebugTrace.msg("Character.actComplete from:"+_from);
			character.body.act.addEventListener(Event.ENTER_FRAME,onActComplete);
			
		}
		protected function onActComplete(e:Event):void
		{
			
			if(e.target.currentFrame==e.target.totalFrames)
			{
				DebugTrace.msg("Character.onActComplete _from="+_from);
				e.target.removeEventListener(Event.ENTER_FRAME,onActComplete);
				
				switch(_from)
				{
					case "Assist":
					case "CompleteKnockback":
					case "CombineSkill":
					case "Rage":
					case "Mind Control":
						//processMember("");
						break
				}
				
				processAction();
			}
			//if
		}
	}
}