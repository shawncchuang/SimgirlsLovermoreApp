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
			startSlide()
		
		}
		private function startSlide():void
		{
			
		
			//tween=new Tween(txtfield,0.002);
			//tween.onComplete=onSlideNext;
			//Starling.juggler.add(tween);

			juggler = Starling.juggler;
			juggler.delayCall(onSlideNext, 0.0001);

		}
		private function onSlideNext():void
		{
			juggler.removeTweens(onSlideNext);
			var current_txt:String=sentence.charAt(index);
			txtfield.text+=current_txt;
			if(index<sentence.length)
			{
				index++;
				startSlide();
			}
			else
			{
				//Starling.juggler.removeTweens(txtfield);
				onCompleteSentance();
			}
			//if
		}
	}
}