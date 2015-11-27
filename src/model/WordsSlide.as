package model
{
import starling.animation.Juggler;
import starling.animation.Tween;
	import starling.core.Starling;
	import starling.text.TextField;
	
	import views.ClickMouseIcon;

	public class WordsSlide
	{
		private var index:uint=0;
		private var sentence:String;
		private var txtfield:TextField;
		private var tween:Tween;
		private var onCompleteSentance:Function;
		private var juggler:Juggler;
		public function WordsSlide(txtf:TextField,txt:String,callback:Function):void
		{
			sentence=txt;
			txtfield=txtf;
			onCompleteSentance=callback;
			startSlide();
		
		}
		private function startSlide():void
		{
			


			juggler = Starling.juggler;
			juggler.repeatCall(onSlideNext,0.008,sentence.length)

		}
		private function onSlideNext():void
		{
			//juggler.removeTweens(onSlideNext);
			var current_txt:String=sentence.charAt(index);
			txtfield.text+=current_txt;
			if(index<sentence.length)
			{
				index++;

			}
			else
			{

				juggler.removeTweens(onSlideNext);
				onCompleteSentance();
			}
			//if
		}
	}
}