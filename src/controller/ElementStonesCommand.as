package controller
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Elastic;
	import com.greensock.easing.Quart;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import data.DataContainer;
	
	import model.BattleData;
	
	import utils.DebugTrace;
	
	import views.BattleScene;
	import views.Member;
	
	
	public class ElementStonesCommand implements ElementStones
	{
		private var menuscene:Sprite;
		private var stoneslist:Array;
		private var stonebar:MovieClip;
		private var elementslist:Array;
		private var new_req_list:Array;
		private var play_power:Array;
		private var player_index:uint;
		public function getStonebar():MovieClip
		{
			return stonebar;
		}
		public function initStoneBar(menu:Sprite):void
		{
			menuscene=menu;
			stoneslist=new Array();
			stonebar=new MovieClip();
			stonebar.name="stonebar";
			stonebar.x=413;
			stonebar.y=385;
			menuscene.addChild(stonebar);
			var battledata:BattleData=new BattleData();
			battledata.stoneCaculator();
			elementslist=BattleData.stoneElements;
			for(var i:uint=0;i<elementslist.length;i++)
			{
				
				var stones:MovieClip=new Stones();
				stones.x=i*50;
				stones.gotoAndStop(elementslist[i]);
				stones.stone.scanlight.gotoAndStop(1);
				stonebar.addChild(stones);
				
				var stoneInfo:Object=new Object();
				stoneInfo.src=stones;
				stoneInfo.id="stone"+i;
				stoneInfo.status="empty";
				stoneslist.push(stoneInfo);
				
				TweenMax.to(stones,0.2,{scaleX:0.85,scaleY:0.85});
			}
			//for
			
			DataContainer.stonesList=stoneslist;
		}
		public function readyElementStones(cate:String=null):void
		{
			//play_power=BattleScene.play_power;
			var playerteam:Array=MemebersCommand.playerTeam;
			player_index=BattleScene.player_index;
			var member:Member=playerteam[player_index];
			var power:Object=playerteam[player_index].power;
			var readystones:Array=new Array();
			for(var j:uint=0;j<new_req_list.length;j++)
			{
				var index:Number=new_req_list[j].index;
				var target_stone:MovieClip=stoneslist[index].src;
				var type:String=elementslist[index];
				target_stone.stone.scanlight.gotoAndStop(1);
				var color:int;
				switch(type)
				{
					case "fire":
						color=0xFF3300;
						break
					case "water":
						color=0x2D6BAC;
						break
					case "earth":
						color=0xE8D138;
						break
					case "air":
						color=0xAFFB67;
						break
					case "neutral":
						color=0x000000;
						break
				}
				//switch
				readystones.push(index);
				stoneslist[index].status="ready";
				
				TweenMax.to(target_stone, 0.5, {y:0,colorTransform:{tint:0x000000, tintAmount:0.5},scaleX:0.85,scaleY:0.85,glowFilter:{color:color, alpha:1, blurX:10, blurY:10, strength:2.5, quality:3},ease:Quart.easeOut});
				
				
			}
			//for
			if(!cate)
			{
				//from skill card shuild update power
				power.readystones=readystones;
				member.updatePower(power);
			}
			
			DataContainer.stonesList=stoneslist;
			
			/*for(var k:uint=0;k<stoneslist.length;k++)
			{
			DebugTrace.msg("ElementStonesCommand.readyElementStones stoneslist["+k+"].id="+stoneslist[k].id);
			DebugTrace.msg("ElementStonesCommand.readyElementStones stoneslist["+k+"].status="+stoneslist[k].status);
			}
			//for	
			*/
		}
		public function releaseStones(readystones:Array):void
		{
			for(var i:uint=0;i<readystones.length;i++)
			{
				stoneslist[readystones[i]].status="empty";
				var target_stone:MovieClip=stoneslist[readystones[i]].src;
				target_stone.stone.scanlight.gotoAndStop(1);
				TweenMax.to(target_stone, 0.5, {colorTransform:{tint:0x000000, tintAmount:0},scaleX:0.85,scaleY:0.85,glowFilter:{remove:true}});
			}
			
		}
		public function spentStones():void
		{
			var new_stoneslist:Array=new Array();
			for(var i:uint=0;i<stoneslist.length;i++)
			{
				if(stoneslist[i].status=="ready")
				{
					var target_stone:MovieClip=stoneslist[i].src;
					TweenMax.to(target_stone, 0.5, {alpha:0,glowFilter:{remove:true}});
					
					
				}
				//if	
			}
			//for
			TweenMax.to(this,0.5,{delay:0.5,onComplete:doSpentStones});
			
			
		}
		public function doSpentStones():void
		{
			
			var new_stoneslist:Array=new Array();
			var new_elementslist:Array=new Array();
			var max:Number=stoneslist.length;
			var start:Number=0;
			while(start<stoneslist.length)
			{
				
				if(stoneslist[start].status=="ready")
				{
					
					var _stoneslsit:Array=stoneslist.splice(start);
					_stoneslsit.shift();
					new_stoneslist=stoneslist.concat(_stoneslsit);
					stoneslist=new_stoneslist;
					
					var _elementslist:Array=elementslist.splice(start);
					_elementslist.shift();
					new_elementslist=elementslist.concat(_elementslist);
					elementslist=new_elementslist;
					start=-1;
					
				}
				//if
				start++;
			}
			//while
			
			/*for(var k:uint=0;k<stoneslist.length;k++)
			{
			DebugTrace.msg("BattleScene.doSpentStones stoneslist["+k+"].id="+stoneslist[k].id);
			DebugTrace.msg("BattleScene.doSpentStones stoneslist["+k+"].status="+stoneslist[k].status);
			}
			//for	*/
			
		}
		public function onNewRoundWithStones():void
		{
			for(var i:uint=0;i<stoneslist.length;i++)
			{
				var target_stone:MovieClip=stoneslist[i].src;
				var posX:Number=i*50;
				TweenMax.to(target_stone,0.5,{x:posX});
			}
			//for
			var battledata:BattleData=new BattleData();
			battledata.stoneCaculator();
			var new_elementslist:Array=BattleData.stoneElements;
			
			var req_new:Number=7-stoneslist.length;
			var start:Number=stoneslist.length;
			for(var j:uint=0;j<req_new;j++)
			{
				posX=(j+start)*50;
				var stones:MovieClip=new Stones();
				elementslist.push(new_elementslist[j]);
				stones.gotoAndStop(new_elementslist[j]);
				stones.stone.scanlight.gotoAndStop(1);
				stonebar.addChild(stones);
				TweenMax.to(stones,0.5,{scaleX:0.85,scaleY:0.85,x:posX,onComplete:onStoneAllreadyComplete,onCompleteParams:[stones]});
				var infoObj:Object=new Object();
				infoObj.id="stone"+(7+j);
				infoObj.src=stones;
				infoObj.status="empty";
				stoneslist.push(infoObj);
				
			}
			//for
			DataContainer.stonesList=stoneslist;
			function onStoneAllreadyComplete(stones:MovieClip):void
			{
				TweenMax.killTweensOf(stones);
				
			}
			/*for(var k:uint=0;k<stoneslist.length;k++)
			{
			DebugTrace.msg("BattleScene.onNewRoundWithStones stoneslist["+k+"].id="+stoneslist[k].id);
			DebugTrace.msg("BattleScene.onNewRoundWithStones stoneslist["+k+"].status="+stoneslist[k].status);
			DebugTrace.msg("BattleScene.onNewRoundWithStones elementslist["+k+"]="+elementslist[k]);
			}
			//for	
			*/
		}
		public function showElementRequest(reqJewel:Array):void
		{
			//when mouseover skillcard show how many stones request
			var reqlist:Array=new Array();
			var qty:Number=0;
			var ele:String="";
			for(var i:uint=0;i<reqJewel.length;i++)
			{
				
				qty=Number(reqJewel[i].split("|")[0]);
				ele=reqJewel[i].split("|")[1];
				var stoneObj:Object=new Object();
				
				stoneObj.qty=qty;
				var _ele:String;
				switch(ele)
				{
					case "a":
						_ele="air";
						break
					case "f":
						_ele="fire";
						break
					case "w":
						_ele="water";
						break
					case "e":
						_ele="earth";
						break
					case "n":
						_ele="neutral";
						break
				}
				stoneObj.ele=_ele;
				reqlist.push(stoneObj);
				DebugTrace.msg("stoneObj:"+JSON.stringify(stoneObj));
			}
			//for
			
			new_req_list=new Array();	 
			var battledata:BattleData=new BattleData();
			new_req_list=battledata.praseRequestStones(elementslist,reqlist);
			
			for(var j:uint=0;j<new_req_list.length;j++)
			{
				if(new_req_list[j])
				{
					var index:Number=new_req_list[j].index;
					var target_stone:MovieClip=stoneslist[index].src;
					target_stone.stone.scanlight.gotoAndPlay(2);
					TweenMax.to(target_stone,0.5,{y:-10,scaleX:1,scaleY:1,ease:Elastic.easeOut});
				}
				//if
			}
			//for
			
		}
		public function releaseElementRequest():void
		{
			//when mouseout skillcard release stones those have requested
			for(var i:uint=0;i<stoneslist.length;i++)
			{
				var target_stone:MovieClip=stoneslist[i].src;
				target_stone.stone.scanlight.gotoAndStop(1);
				TweenMax.to(target_stone,0.5,{y:0,scaleX:0.85,scaleY:0.85,ease:Elastic.easeOut});
			}
			//for
			
		}
		public function getSonesList():Array
		{
			return stoneslist
			
		}
		public function getElementslist():Array
		{
			return elementslist
		}
		public function getNewReqList():Array
		{
			return new_req_list;
		}
		private function onTweenComplete():void
		{
			TweenMax.killAll(true);
		}
	}
}