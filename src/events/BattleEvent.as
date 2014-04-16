package events
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import views.Member;
 
	public class BattleEvent extends EventDispatcher
	{
		public static var UPDATE:String="update";
		public static var UPDATE_ACT:String="update_act";
		public static var SWITCH_INDEX:String="switch_inedx";
		public static var COMMANDER_ITEM:String="comander_item";
		public static var AREA_HEAL:String="area_heal";
		public static var HEAL:String="heal";
		public static var DISABLED_HEAL:String="disabled_heal";
		public static var REMOVE_HEAL:String="selected_heal";
		public static var COMPLETE_ACT:String="complete_act";
		public static var UPADATE_BONUS:String="update_bonus";
		public static var BONUS:String="bonus";
		public static var CPU_COMMANDER:String="cpu_commander";
		public var member:MovieClip;
		public var effect:String;
		public var member_name:String;
		public var act:String;
		public var id:String;
		public var from:String;
		public var itemid:String;
		public var healarea:Array;
		public var commander:Member;
		public function updateMemberAct():void
		{
			//character act update
			dispatchEvent(new Event(BattleEvent.UPDATE_ACT));
		}
		public function switchMemberIndex():void
		{
			dispatchEvent(new Event(BattleEvent.SWITCH_INDEX));
		}
		public function usedItemHandle():void
		{
			dispatchEvent(new Event(BattleEvent.COMMANDER_ITEM));
			
		}
		public function enabledMemberHeal():void
		{
			
			dispatchEvent(new Event(BattleEvent.HEAL));
		}
		public function removeMemberHeal():void
		{
			dispatchEvent(new Event(BattleEvent.REMOVE_HEAL));
			
		}
	    public function usedHealHandle():void
		{
			
			dispatchEvent(new Event(BattleEvent.HEAL));
		}
		public function enabledAreaMemberHeal():void
		{
			dispatchEvent(new Event(BattleEvent.AREA_HEAL));
		}
		public function disabledMemberHeal():void
		{
			dispatchEvent(new Event(BattleEvent.DISABLED_HEAL));
		}
		public function  actComplete():void
		{
			dispatchEvent(new Event(BattleEvent.COMPLETE_ACT));
			
		}
		public function updateBonus():void
		{
			
			dispatchEvent(new Event(BattleEvent.UPADATE_BONUS));
		}
		public function onStartBonusGame():void
		{
			
			dispatchEvent(new Event(BattleEvent.BONUS));
		}
		public  function onCPUCommaderItems():void
		{
			
			dispatchEvent(new Event(BattleEvent.CPU_COMMANDER));
			
		}
	}
}