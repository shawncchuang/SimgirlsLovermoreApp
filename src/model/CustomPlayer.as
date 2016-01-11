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

		//0=null,1=used
		public var saved:Array;
		public var assets:Object;
		public var paid:Boolean;
		
		/*
		blackmarket items
		*/
		public var items:Object;
		public var commander_items:Array;



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