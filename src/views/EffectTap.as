package views
{
	import flash.display.MovieClip;
	
	import utils.DebugTrace;

	public class EffectTap extends MovieClip
	{
		protected var type:String;
		protected var tap_name:String;
		public function EffectTap()
		{
		}
		public function init():void
		{
			DebugTrace.msg("EffectTap name="+tap_name);
			this.mouseChildren=false;
			this.name=tap_name;
			var effectTap:MovieClip=new EffectTapIcon();
			addChild(effectTap);
		}
	}
}