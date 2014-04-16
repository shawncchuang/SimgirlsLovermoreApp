package views
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.Config;
	
	import events.TopViewEvent;
	
	import utils.DebugTrace;

	public class TarotCardsDisplay extends MovieClip
	{
		private var tarotcards:TarotCards;
		private var command:MainInterface=new MainCommand();
		private var floxcom:FloxInterface=new FloxCommand();
		public function TarotCardsDisplay()
		{
			
			tarotcards=new TarotCards();
			
			tarotcards.x=730;
			tarotcards.y=370;
			addChild(tarotcards);
			init();
		}
		private function init():void
		{
			for(var i:uint=0;i<4;i++)
			{
				var card:MovieClip=tarotcards.mc["card"+i];
				card.buttonMode=true;
				card.addEventListener(MouseEvent.CLICK,doSelectedCard);
			}
			
		   //for	
		}
		private function doSelectedCard(e:MouseEvent):void
		{
			var target:String=e.target.name;
			DebugTrace.msg("TarotCardsDisplay.doSelectedCard :"+target);
            var id:Number=Number(target.split("card").join(""));
			var ele:String=Config.elements[id];
			var _data:Object=new Object();
			_data.s_ele=ele;
			//floxcommand.save(_data);
			//floxcommand.refreshEntites();
			floxcom.updateSavegame(_data);
			var com_data:Object=new Object();
			com_data.removed="tarot_cards";
			command.topviewDispatch(TopViewEvent.REMOVE,com_data);
	
		}
	}
}