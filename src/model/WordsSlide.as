package model
{
import starling.animation.Juggler;
import starling.animation.Tween;
	import starling.core.Starling;
import starling.display.Sprite;
import starling.text.TextField;

import utils.DebugTrace;

import views.ClickMouseIcon;
import views.MyTalkingDisplay;

public class WordsSlide
	{
		private var index:uint=0;
		private var sentence:String;
		private var _target:Sprite;
		private var txtfield:TextField;
		private var tween:Tween;
		private var onCompleteSentance:Function;
		private var juggler:Juggler;
	    private  var tweedID:uint=0;
		public function WordsSlide(target:Sprite,txtf:TextField,txt:String,callback:Function=null):void
		{
			_target=target;
			sentence=txt;
			txtfield=txtf;
			if(callback)
			onCompleteSentance=callback;
			startSlide();
		
		}
		private function startSlide():void
		{

			juggler = Starling.juggler;
			tweedID=juggler.repeatCall(onSlideNext,0.008,sentence.length);

		}
		private function onSlideNext():void
		{
			//DebugTrace.msg("WordSlide.onSlideNext tweemIDs="+JSON.stringify(tweedID));
			var current_txt:String=sentence.charAt(index);
			txtfield.text+=current_txt;

			if(index<sentence.length-1)
			{
				index++;

			}
			else
			{

				Starling.juggler.removeByID(tweedID);
				_target.dispatchEventWith(MyTalkingDisplay.TALKING_COMPLETE);
			}
			//if
		}
	}
}