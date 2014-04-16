package model
{
	import controller.CpuMembersCommand;
	import controller.CpuMembersInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MembersInterface;
	import controller.MemebersCommand;
	
	import data.Config;
	import data.DataContainer;
	
	import utils.DebugTrace;
	
	public class BattleData
	{
		//base point
		private var bp:Number=29;
		private var flox:FloxInterface=new FloxCommand();
		private var allpowers:Array;
		private static var _stoneElements:Array;
		private var cpucom:CpuMembersInterface=new CpuMembersCommand();
		private static var memberscom:MembersInterface=new MemebersCommand();
		private static var from:String;
		public static var surviveCombats:Array
		public static function rangeMatrix(power:Object):Array
		{
			var matrix:Array=new Array();
			from=power.from;
			var skillID:String=power.skillID;
			var area:Number=power.area;
			var areaMatrix:Object={
				0:[0,1,2],
				1:[3,4,5],
				2:[0,1,2,3,4,5]
			}
			if(skillID.indexOf("n")!=-1)
			{
				//assist
				if(from=="player")
				{
					surviveCombats=checkPlayerSurvive();  
				}
				else
				{
					surviveCombats=checkCpuSurvive();
				}
				//if
			}
			else
			{
				//attck->target
				if(from=="player")
				{
					surviveCombats=checkCpuSurvive();
				}
				else
				{
					
					surviveCombats=checkPlayerSurvive();
				}
				//if
			}
			//if
			var survive:Boolean=false;
			//DebugTrace.msg("BattleData.rangeMatrix surviveCombats:"+surviveCombats+" ; from:"+from);
			if(area==0)
			{
				// check front row
				var _matrix:Array=[0,1,2];
				for(var i:uint=0;i<surviveCombats.length;i++)
				{
					if(_matrix.indexOf(surviveCombats[i])!=-1)
					{
						
						survive=true;
						break
					}
					//if
				}
				//for
				if(!survive)
				{
					area=1;
				}
				//if
			}
			else if(area==1)
			{
				//check back row
				_matrix=[3,4,5];
				
				for(var j:uint=0;j<surviveCombats.length;j++)
				{
					if(_matrix.indexOf(surviveCombats[j])!=-1)
					{	
						survive=true;
						break
					}
					//if
				}
				//for
				if(!survive)
				{
					area=0;
				}
				//if
			}
			 //if
			
			var _area:Array=areaMatrix[area];
			for(var k:uint=0;k<_area.length;k++)
			{
				var target:Number=_area[k];
				if(surviveCombats.indexOf(target)!=-1)
				{
					matrix.push(target);
				}
				//if
				
			}
			//for
			//matrix=areaMatrix[aera];
			return matrix
		}
		public function skillCard(member:Object,cupsys:Object):Object
		{
			var powers:Object=new Object();
			 
			var se:Number=member.power.se;
			var power:Number=cupsys.power;
			if(member.power.skillID.indexOf("n")!=-1)
			{
				se=member.power.seMax;
			}
			
			//var def:Number=cupsys.def;
			var speed:Number=cupsys.speed;
			
			
			power=power+power*bp*Number((se/9999).toFixed(2));
			var extra:Number=Math.floor(Math.random()*10)/100;
			//def=def+def*bp*Number((se/9999).toFixed(2));
			//speed=speed+speed*bp*Number((se/9999).toFixed(2));
			powers.power=Math.floor(power+power*extra);
			//powers.def=def;
			powers.speed=speed;
			
			return powers;
		}
		public function damageCaculator(powers:Array,index:Number):Number
		{
			var damage:Number;
			allpowers=powers;
			
			
			
			var extra:Number=5-(Math.floor(Math.random()*10)+1);
			var power:Number=allpowers[index].power;
			damage=power+extra;
			return damage;
		}
		private function getTargetPower(target:String):Object
		{
			var power:Object=new Object();
			for(var i:uint=0;i<allpowers.length;i++)
			{
				if(allpowers[i].id==target)
				{
					power=allpowers[i];
					break
				}
			}
			//for
			return power;
		}
		public static function set stoneElements(list:Array):void
		{
			_stoneElements=list;	
		}
		public static function get stoneElements():Array
		{	
			return _stoneElements;	
		}
		public function stoneCaculator():void
		{
			var stones:Array=new Array();
			var elements:Array=Config.elements;
			elements=new Array("fire","air","earth","water","neutral");
			for(var i:uint=0;i<7;i++)
			{
				
				var ran:Number=Math.floor(Math.random()*100);
				if(ran<=8)
				{
					var ele:String="neutral";	
				}
				else
				{
					var other_elements:Array=new Array("fire","air","earth","water");
					var index:Number=Math.floor(Math.random()*other_elements.length);
					ele=other_elements[index];
				}
				//if
				stones.push(ele);
				//fake
				//stones=["neutral","earth","earth","earth","earth","earth","neutral"];
			}
			//for
			stoneElements=stones;
		}
		public function praseRequestStones(elements:Array,reqs:Array):Array
		{
			//elements:elements stones in this round
			//reqs: how many stones do the skill need?
			//DebugTrace.msg("reqs.length :"+reqs.length);
			var stoneslsit:Array=DataContainer.stonesList;
			var elelist:Array=new Array();
			for(var i:uint=0;i<reqs.length;i++)
			{
				for(var j:uint=0;j<elements.length;j++)
				{
					DebugTrace.msg(elements[j]+" ; "+reqs[i].ele);
					if(elements[j]==reqs[i].ele && stoneslsit[j].status=="empty")
					{
						var eleObj:Object=new Object();
						eleObj.ele=elements[j];
						eleObj.index=j;
						DebugTrace.msg("Battle.praseRequestStones elelist["+j+"]="+JSON.stringify(eleObj));
						elelist.push(eleObj);	
					}
					//if
				}
				//for
			}
			//for
			var new_elelist:Array=new Array();
			
			for(var q:uint=0;q<reqs.length;q++)
			{
				//elelist.sortOn(reqs[q].ele);
				//DebugTrace.msg("Battle.praseRequestStones reqs["+q+"]="+JSON.stringify(reqs[q]));
				//DebugTrace.msg("Battle.praseRequestStones elelist["+q+"]="+JSON.stringify(elelist[0]));
				for(var p:uint=0;p<reqs[q].qty;p++)
				{
					if(elelist[p])
					{
						DebugTrace.msg("Battle.praseRequestStones new_elelist["+q+"]="+JSON.stringify(elelist[p]));
						new_elelist.push(elelist[p]);
					}
					else
					{
						DebugTrace.msg("Battle.praseRequestStones");
						new_elelist.push(null);
					}
					//if
				}
				//for
				
			}
			//for
			return new_elelist
		}
		
		public function praseTargetList(power:Object,combat:Number):Array
		{
			//combat ; target's combat
			DebugTrace.msg("BattleData.praseTargetList combat= "+combat);
			DebugTrace.msg("BattleData.praseTargetList power= "+JSON.stringify(power));
			from=power.from;
			
			var targetArea:Array=new Array();
			var area:Number=power.area;
			var enemy:Number=power.enemy;
			var skillID:String=power.skillID;
			var skillarea:Array=rangeMatrix(power);
			var areaMatrix:Object=new Object();
			 
			var target:Number;
			
			switch(enemy)
			{
				case 1:
					
					/*if(skillarea.indexOf(combat)!=-1)
					{
						//target's combat is at skill area 
						if(skillarea.indexOf(combat)!=-1)
						{
						   targetArea.push(combat);
						}
						//if
					}
					else
					{
					
						for(var i:uint=1;i<=3;i++)
						{
							if(surviveCombats.indexOf(i)!=-1)
							{
								targetArea.push(i);
								break
							}
							//if
						}
						//for
					}
					//if*/
					 if(skillarea.indexOf(combat)!=-1)
					 {
						 targetArea.push(combat);
					 }
				 	
					
					break
				case 2:
					targetArea.push(combat);
					if(combat<3)
					{
						targetArea.push(combat+3);
					}
					else
					{
						targetArea.push(combat-3);
					}
					break
				case 3:
					 
					targetArea=skillarea;
					 
					break
				case 4:
					
					areaMatrix={
					0:[0,1,3,4],
					1:[1,2,4,5],
					2:[1,2,4,5],
					3:[0,1,3,4],
					4:[0,1,3,4],
					5:[1,2,4,5]
				}
					targetArea=areaMatrix[combat];
					
					break
				case 5:
					for(var n:uint=0;n<skillarea.length;n++)
					{
						targetArea.push(skillarea[n]);
					}
					//for
					break
				
			}
			//switch
			
			DebugTrace.msg("BattleData.surviveCombats: "+surviveCombats);
			DebugTrace.msg("BattleData.targetArea: "+targetArea);
			 
			//DebugTrace.msg("BattleData._targetArea="+_targetArea);
			return targetArea;
		}
		public function checkPlayerTeam():Array
		{
			//var formation:Array=flox.getSaveData("formation");
			//var seObj:Object=flox.getSaveData("se");
			var playerteam:Array=MemebersCommand.playerTeam;
			var player_team:Array=new Array();
			
			for(var j:uint=0;j<playerteam.length;j++)
			{
			 
				player_team.push(playerteam[j].power);
			}
			//for
			//DataContainer.playerMainTeam=player_team;
			return player_team;
			
		}
		public function checkCPUTeam():Array
		{
			var cpu_team:Array=new Array();
			var cputeam:Array=memberscom.getCpuTeam();
			for(var j:uint=0;j<cputeam.length;j++)
			{
				
				var cpu:Object=new Object();
				cpu=cputeam[j].power;
				cpu_team.push(cpu);
			}
			return cpu_team;
		}
		public static function checkPlayerSurvive():Array
		{
			
			//var playerteam:Array=MemebersCommand.playerTeam;
			var playerteam:Array=memberscom.getPlayerTeam();
			//var mainPlayer:Array=DataContainer.playerMainTeam;
			
			var surviveCombats:Array=new Array();
			for(var j:uint=0;j<playerteam.length;j++)
			{
				
				var power:Object=playerteam[j].power
				//DebugTrace.msg("BattleData.checkPlayerSurvive playerteam["+j+"]="+JSON.stringify(power));
				if(power.se>0)
				{
					surviveCombats.push(power.combat)
				}
				//if
			}
			//for
			//DebugTrace.msg("BattleData.checkPlayerSurvive surviveCombats="+surviveCombats);
			return surviveCombats;
		}
		public static function checkCpuSurvive():Array
		{
			var surviveCombats:Array=new Array();
			
			var cputeam:Array=CpuMembersCommand.cputeamMember;
			for(var j:uint=0;j<cputeam.length;j++)
			{
				
				var cpu_power:Object=cputeam[j].power;
				//DebugTrace.msg("BattleData.praseTargetList mainTeam["+j+"]="+JSON.stringify(cpu_power));
				if(cpu_power.se>0)
				{
					surviveCombats.push(cpu_power.combat);
				}
				//if
			}
			//for	
			
			return surviveCombats;
		}
		public function getPlayerChacterName(member_id:String):String
		{
			var _name:String="";
			var formation:Array=flox.getSaveData("formation");
			var attack_combat:Number=Number(member_id.split("player").join(""));
			for(var i:uint=0;i<formation.length;i++)
			{
				if(formation[i])
				{
					if(formation[i].combat==attack_combat)
					{
						_name=formation[i].name;
						break;
						
					}
					//if
				}//if
			}
			//for
			return _name;
			
		}
		public function shuffleHandle(sample:Array):Array
		{
			var re:Array=new Array();
			
			 
			while (sample.length > 0)
			{
				re.push(sample.splice(Math.round(Math.random() * (sample.length - 1)),1)[0]);
			}
			//while
			
			
			return re
			
		}
	}
}