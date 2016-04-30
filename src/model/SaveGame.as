package model
{
	import com.gamua.flox.Entity;
	
	import data.Config;
	public class SaveGame extends Entity
	{
		
		private var _engine:Number;
		private var _ap:Number;
		private var _cash:Number;
		private var _date:String;

		public var status:String;
		public var first_name:String;
		public var last_name:String;
	    public var ch_cash:Object;
		public var int:Object;
		public var image:Object;
		public var ap_max:Number;
		public var assets:Object;
		public var owned_assets:Object;
        public var unreleased_assets:Object;
		public var items:Object;
		public var gifts:Object;
		public var accessories:Object;
		public var estate:Object;
		public var pts:Object;
		public var rel:Object;
		public var rank:String;
		public var honor:Object;
		public var mood:Object;
		public var wealth:String;
		public var love:Object;
		//sprite engine
		public var se:Object;
		public var s_ele:String;
        public var dating:*;
		public var skills:Object;

		public var avatar:Object;
		public var formation:Array;
		public var scenelikes:Object;
		public var secrets:Object;
		public var cpu_teams:Object;
		public var victory:Object;
		public var defeat:Object;
		public var collapses:Object;
		public var skillPts:Object;
		public var current_switch:String;
		public var next_switch:String;
        public var ranking:Array;
        public var current_battle:Object;
        public var command_dating:Object;
        public var photos:Array;
		public var current_scene:String;
		public var criminals:Array;
		public var twinflame:String;
		public var goodevail:Number;
		public var datingtwin:Object;
		public var saved:Boolean;
		public var mission:Object;
		public function SaveGame()
		{
	 
		}
		public function set cash(value:Number):void
		{
			_cash=value;
		}
		public function get cash():Number
		{
			return _cash;
		}
		public function set ap(value:Number):void
		{
			_ap=value
		}
		public function get ap():Number
		{
			return _ap;
		}
		 
		 
		public function set date(value:String):void
		{
			_date=value;
		}
		public function get date():String
		{
			return _date;
		}


	   
	}
}