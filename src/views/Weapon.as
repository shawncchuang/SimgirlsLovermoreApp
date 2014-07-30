package views
{
	import flash.display.MovieClip;

	public class Weapon extends Energy
	{
	
		
		public function Weapon()
		{
			
			super();
		 
		 
		}
		public function setGameType(type:String):void
		{
			super.game=type;
		}
		 
		override public function setTarget(ta:MovieClip):void
		{
			super.setTarget(ta);
		}
	    
		override public function stopFire():void
		{
			
			super.stopFire();
		}
	}
}