package controller
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import utils.ViewsContainer;

	public class SoundController extends MovieClip
	{
		
		private var sound_ctrl:MovieClip;
		private static var mute:Boolean;
		
		private var command:MainInterface=new MainCommand();
		public static function set Mute(type:Boolean):void
		{
			mute=type;
		}
		public static function get Mute():Boolean
		{
			return mute;
		}
		public function SoundController()
		{
			
			Mute=false;
			var battleTop:MovieClip=ViewsContainer.battleTop;
			sound_ctrl=new SoundCtrl();
			
			addChild(sound_ctrl);
			
			sound_ctrl.addEventListener(MouseEvent.MOUSE_DOWN,doSoundCtrl);
		}
		private function doSoundCtrl(e:MouseEvent):void
		{
			if(Mute)
			{
				Mute=false;
				sound_ctrl.gotoAndStop(1);
				command.playBackgroudSound("BattleMusic");
				
			}
			else
			{
				Mute=true;
				sound_ctrl.gotoAndStop(2);
				command.stopBackgroudSound();
			}
			
			
		}
	}
}