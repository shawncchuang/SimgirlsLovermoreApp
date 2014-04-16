package utils
{
	import controller.FloxCommand;
	import controller.FloxInterface;

	public class DebugTrace
	{
		//private var flox:FloxInterface=new FloxCommand();
		public static function msg(value:String=null):void
		{
			//trace(value);
			var flox:FloxInterface=new FloxCommand();
			flox.showlog(value);
		}
		public static function obj(o:*=null):void
		{
			trace(o);
			
		}
	}
}