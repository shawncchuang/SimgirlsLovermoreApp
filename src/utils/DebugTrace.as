package utils
{
import com.demonsters.debugger.MonsterDebugger;


public class DebugTrace
	{
		//private var flox:FloxInterface=new FloxCommand();
		public static function msg(value:String=null):void
		{
			//trace(value);
			//var flox:FloxInterface=new FloxCommand();
			//flox.showlog(value);

			//MonsterDebugger.trace(ViewsContainer.MainStage,value);

		}
		public static function obj(o:*=null):void
		{
			trace(o);
			
		}
	}
}