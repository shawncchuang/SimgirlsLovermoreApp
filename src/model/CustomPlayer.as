package model
{
	import com.gamua.flox.Player;

	public class CustomPlayer extends Player
	{
		
		 
		 
		//private var _progress:Number;
	    public var inGameProgress:Number=1;
		public var coin:Number=0;
		public var email:String;
		public var from:String;
		public var verify:String="disabled";
		public var player_name:String="";
		public var password:String="";
		private var currentPlayer:Player;
		
		public var saved:Array;
		public var assets:Object;
		public var paid:Boolean;
		
		/*
		com0 :change formation
		com1 :battle cry
		com2 :boot skills
		com3 :boot honors
		*/
		public var items:Array=[  { "id": "com1", "qty": 3 },{ "id": "com2", "qty": 9999 }, { "id": "com3", "qty": 9999 } ];
	
		public function CustomPlayer()
		{
			currentPlayer=Player.current
		}
		 
       /* public function set inGameProgress(value:Number):void
		{
			_progress=value;
		}
		public function get inGameProgress():Number
		{
			return _progress;
		}
		*/
		 
	}
}