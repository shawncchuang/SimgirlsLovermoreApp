package model
{
	 
	 
	
	import controller.AvatarCommand;
	import controller.AvatarInterface;
	
	import starling.display.Sprite;
	 

	public class Avatar extends Sprite
	{
		
		private var avaterIf:AvatarInterface=new AvatarCommand();
		
		public function Avatar()
		{
			
			//avaterIf.createAvatar(fun:Function,attr:Object);
			 
		}
		
	}
}