package utils
{
	
	 
	import controller.FilterInterface;

import flash.events.TimerEvent;

import flash.utils.Timer;

import starling.animation.DelayedCall;
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
import starling.display.Sprite;
import starling.filters.BlurFilter;
	import starling.filters.ColorMatrixFilter;
	import starling.utils.Color;
	
	import utils.DebugTrace;

	public class FilterManager implements FilterInterface
	{
		private var target:*;
		private var colorMatrixFilter:ColorMatrixFilter;
	    private var tween:Tween;
		private var call:DelayedCall;
		private var complete_call:DelayedCall;
		private var  repeat:Number=10;
		private var repeatCount:Number=3;
		private var bright:Number=0.3
		private var delpay:Number=0.2;
		public function setSource(src:Image):void
		{
			 
			target=src;
			
		}
		public function changeColor(value:uint):void
		{
			var r:int=Color.getRed(value);
			var g:int=Color.getGreen(value);
			var b:int=Color.getBlue(value);
			target.color=Color.rgb(r,g,b);
			
		}
		public  function startFlash():void
		{
		 
			setColorMatrixFilter(bright);

			/*tween=new Tween(target,0.5,Transitions.EASE_OUT);
			tween.animate("alpha",0.5);
			tween.onComplete=onFlashFilters
			Starling.juggler.add(tween);*/
			//call=new DelayedCall(onFlashFilters,delpay);
			//Starling.juggler.add(call);
			var timer:Timer=new Timer(300,1);
            timer.addEventListener(TimerEvent.TIMER_COMPLETE, onBrightComplete);
            timer.start();
		}
        private function onBrightComplete(e:TimerEvent):void{

            e.target.stop();
            e.target.removeEventListener(TimerEvent.TIMER_COMPLETE, onBrightComplete);
            setColorMatrixFilter(0);

        }
		private function onFlashFilters():void
		{
			DebugTrace.msg("FilterManager.onFlashFilters");
			
			colorMatrixFilter.reset()
			target.filter =colorMatrixFilter;
			Starling.juggler.remove(call);
			
			//call=new DelayedCall(onRepeatFlash,delpay);
			//call.repeatCount=repeat;
			//Starling.juggler.add(call);
		   
		}
		private function onRepeatFlash():void
		{
			
			setColorMatrixFilter(bright);
		
			complete_call=new DelayedCall(onCompleteFlash,delpay);
			Starling.juggler.add(complete_call);
		 
		}
		public function onCompleteFlash():void
		{
			//DebugTrace.msg("FilterManager.onCompleteFlash")
		 
			target.filter=null;
			//Starling.juggler.remove(complete_call);
			 
			
		}
		public function setColorMatrixFilter(value:*):void
		{
			
			colorMatrixFilter = new ColorMatrixFilter();
			//colorMatrixFilter.invert();                // invert image
			//colorMatrixFilter.adjustSaturation(-1);    // make image Grayscale
			//colorMatrixFilter.adjustContrast(0.75);    // raise contrast
			//colorMatrixFilter.adjustHue(1);            // change hue
			colorMatrixFilter.adjustBrightness(value); // darken image
			target.filter = colorMatrixFilter;
		}
		public function setShadow(src:Sprite):void
		{
		 
			var dropShadow:BlurFilter = BlurFilter.createDropShadow(); 
			src.filter = dropShadow;
		}
		public function setBulr():void
		{
			
			var blur:BlurFilter = new BlurFilter(5, 5);
			target.filter = blur;
		}
	}
}