package model
{
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
		public function WordsSlide(txtf:TextField,txt:String,callback:Function):void
		{
			sentence=txt;
			txtfield=txtf;
			onCompleteSentance=callback;
			startSlide()
		
		}
		private function startSlide():void
		{
			
		
			tween=new Tween(txtfield,0.01);
			tween.onComplete=onSlideNext
			Starling.juggler.add(tween);
		}
		private function onSlideNext():void
		{
			
			var current_txt:String=sentence.charAt(index);
			txtfield.text+=current_txt;
			if(index<sentence.length)
			{
				index++;
				startSlide();
			}
			else
			{

				Starling.juggler.removeTweens(txtfield);
				onCompleteSentance();
			}
			//if
		}
	}
}