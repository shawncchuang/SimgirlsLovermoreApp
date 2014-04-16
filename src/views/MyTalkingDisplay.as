package views
{
	import com.emibap.textureAtlas.DynamicAtlas;
	
	import model.WordsSlide;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.TextureAtlas;

	public class MyTalkingDisplay extends Sprite
	{
		private var tween:Tween;
		private var sentence:String;
		private var subtitle:TextField;
		public function addMask(callback:Function=null):void
		{
		 
			var _mask:SceneMask = new SceneMask();
			var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(_mask, .5, 0, true, true);
			var scene_mask:MovieClip = new MovieClip(atlas.getTextures("mc"), 30);
			scene_mask.width=Starling.current.stage.stageWidth;
			scene_mask.height=Starling.current.stage.stageHeight;
			scene_mask.alpha=0;
			addChild(scene_mask);
			tween=new Tween(scene_mask,0.5,Transitions.EASE_OUT);
			tween.animate("alpha",1);
			tween.onComplete=callback;
			Starling.juggler.add(tween);
			
			
			
		}
		public function addTextField(sentence:String):void
		{
			//Starling.juggler.remove(tween);
			
			var subtitle:TextField=new TextField(785,90,"","Eras Demi ITC",25,0xFFFFFF);
			subtitle.hAlign="center";
			subtitle.x=125;
			subtitle.y=650;
		    addChild(subtitle);
		    new WordsSlide(subtitle,sentence,doDisplayClickMosue);
		}
		 
		private function doDisplayClickMosue():void
		{
			
			var clickmouse:ClickMouseIcon=new ClickMouseIcon();
			clickmouse.x=973;
			clickmouse.y=704;
			addChild(clickmouse)
		}
	}
}