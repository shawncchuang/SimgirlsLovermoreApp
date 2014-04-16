package model
{
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	 
	public class CusomAssets
	{
		private var savegame:SaveGame;
		private var balance:Array=[1,-1];
		//private var positive:Number=0;
		//private var negative:Number=0;
		private var flox:FloxInterface=new FloxCommand();
		public function CusomAssets()
		{
			
			 
		}
		public function praseRating():void
		{
			var sysAssets:Object=flox.getSyetemData("assets");
			savegame=FloxCommand.savegame;
			var saveAssets:Array=new Array();
			for(var id:String in sysAssets)
			{
				 var assets:Object=new Object();
				var blance_index:Number=uint(Math.random()*2);
				var poORne:Number=balance[blance_index];
				assets.id=id;
				assets.rating=(uint(Math.random()*100)+1)*poORne;
				saveAssets.push(assets);
			}
			//for
			savegame.assets=saveAssets;
			FloxCommand.savegame=savegame;
			 
		}
	}
}