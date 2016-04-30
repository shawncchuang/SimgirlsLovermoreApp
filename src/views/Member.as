package views
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import data.Config;
	
	import events.BattleEvent;
	
	import utils.DebugTrace;
	
	public class Member extends Character
	{
		public  var memberEvt:BattleEvent;
		public var character:MovieClip;
		public var skillAni:MovieClip;
		public var membermc:MovieClip;
		public var status:String;
		public var power:Object;
		//public var selected:Boolean;
		public var chname:String;
		public var gender:String;
		public var plus_speed:Number;
		public var ett:MovieClip;
		public var OnArmour:Boolean;
		public function Member()
		{
			super();
			plus_speed=super.plus_speed;
			//this.mouseChildren=false;
			//this.buttonMode=true;
			var evt:BattleEvent=new BattleEvent();
			evt.addEventListener(BattleEvent.UPDATE_ACT,updateMemberAct);
			evt.addEventListener(BattleEvent.PROCESS_ACT,processAction);
			evt.addEventListener(BattleEvent.HEAL,enabledMemberHeal);
			evt.addEventListener(BattleEvent.AREA_HEAL,enabledAreaMemberHeal);
			evt.addEventListener(BattleEvent.DISABLED_HEAL,disabledAreaMemberHeal);
			evt.addEventListener(BattleEvent.REMOVE_HEAL,removeMemberHeal);
			evt.addEventListener(BattleEvent.COMPLETE_ACT,actComplete);
			evt.addEventListener(BattleEvent.HIT,hitHandle);
			evt.addEventListener(BattleEvent.END,battleEndHandle);
			evt.addEventListener(BattleEvent.DISABLED_ACT,disabledActionHandle);
			memberEvt=evt;
		}
		override public function initPlayer(index:Number):void
		{
			super.initPlayer(index);
			this.name=super.id;
			status=super.status;
			character=super.character;
			membermc=super.membermc;
			chname=super.ch_name;

			DebugTrace.msg("Member.initPlayer id:"+super.id);
			
		}
		override public function initCpuPlayer(team:Array,index:Number):void
		{
			super.initCpuPlayer(team,index);
			this.name=super.id;
			status=super.status;
			character=super.character;
			membermc=super.membermc;
			chname=super.ch_name;
			OnArmour=super.OnArmour;
			DebugTrace.msg("Member.initCpuPlayer id:"+super.id);
			
		}
		public function getMemberMC():void
		{
			membermc=super.membermc;
			membermc.mouseChildren=false;
			membermc.buttonMode=true;
		}
		override public function updateStatus(type:String):void
		{
			status=type;
			super.updateStatus(type);
			
		}
		override public function updatePower(data:Object):void
		{
			
			super.updatePower(data);
			power=super.power;
		}
		override public function updateDamage(effect:String,damage:Number):void
		{
			super.updateDamage(effect,damage);
			power=super.power;
			
		}
		override public function updateRound():void
		{
			super.updateRound();
		 
		}
		/*override public function onSelected():void
		{
			super.onSelected();
			selected=super.selected;
		}*/
		override public function startFight():void
		{
			super.startFight();
		}
		public function getStatus():String
		{
			status=super.status;
			
			return status;
		}
		private function processAction(e:Event):void
		{
			super.processAction();
		}
		override public function removeClickTap():void
		{
			super.removeClickTap()
			
		}
		 
		private function updateMemberAct(e:Event):void
		{
			DebugTrace.msg("Member.updateMemberAct act:"+e.target.act);
			super.processMember(e.target.act);
			
		}
		private function enabledMemberHeal(e:Event):void
		{
			super.enabledMemberHeal();
		}
		private function enabledAreaMemberHeal(e:Event):void
		{
			super.enabledAreaMemberHeal();
		}
		private function disabledAreaMemberHeal(e:Event):void
		{
			super.disabledAreaMemberHeal();
		}
		private function removeMemberHeal(e:Event):void
		{
			super.removeMemberHeal();
		}
		private function actComplete(e:Event):void
		{
			super.actComplete(e.target.from);
			
		}
        public function getPlusSpeed():Number
		{
			return super.plus_speed;
		}
		override public function setupSkillAni():void
		{
			super.setupSkillAni();
			skillAni=super.skillAni;
		}
		public function getSkillAni():void
		{
			
			skillAni=super.skillAni;
		}
		override public function removeSkillAni():void
		{
			super.removeSkillAni();
		}
		public function getEtt():void
		{
			//neutral target area mc
			ett=super.ett;
		}
		private function hitHandle(e:Event):void
		{
			
			super.hitHandle();
			
		}
		private function battleEndHandle(e:Event):void
		{

			super.setupVictoryDace();
		}
		public function getGender():void
		{
			gender=super.gender;
			 
		}
		public function getOnArmour():Boolean{
			OnArmour=super.OnArmour;
			return OnArmour;
		}
		private function disabledActionHandle(e:Event):void{

			super.stopActionHandle();
		}
	}
}