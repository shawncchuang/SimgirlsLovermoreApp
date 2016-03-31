package views
{
	//import com.emibap.textureAtlas.DynamicAtlas;

	import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;

import data.DataContainer;

import model.WordsSlide;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;

import utils.DebugTrace;

public class MyTalkingDisplay extends Sprite
	{
		private var tween:Tween;
		private var sentence:String;
		private var subtitle:TextField;
	public static var TALKING_COMPLETE:String="talking_complete";
		private var onTalkingComplete:Function;
	
		public function addMask(callback:Function=null):void
		{
		 
			//var _mask:SceneMask = new SceneMask();
			//var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(_mask, .5, 0, true, true);
			//var scene_mask:MovieClip = new MovieClip(atlas.getTextures("mc"), 30);
			var texture:Texture=Assets.getTexture("SceneMask");
			var scene_mask:Image=new Image(texture);
			scene_mask.width=Starling.current.stage.stageWidth;
			scene_mask.height=Starling.current.stage.stageHeight;
			//scene_mask.alpha=0;
			addChild(scene_mask);
//			tween=new Tween(scene_mask,0.5,Transitions.EASE_OUT);
//			tween.animate("alpha",1);
//			tween.onComplete=callback;
//			Starling.juggler.add(tween);
			
			
			
		}
		public function addTextField(sentance:String,callback:Function=null):void
		{
			//Starling.juggler.remove(tween);
			addMask();
			onTalkingComplete=callback;


			var first_name:String="First Name";
			var twinflame:String=null;

			if(!SimgirlsLovemore.previewStory){

				var flox:FloxInterface=new FloxCommand();
				first_name=flox.getSaveData("first_name");
				twinflame=flox.getSaveData("twinflame");
			}else{
				twinflame=DataContainer.TwinFlame;
			}

			if(twinflame){
				twinflame=twinflame.toLowerCase();
			}
			var fullname:String=Config.fullnames[twinflame];
			sentance=sentance.split("<>").join(",");
			sentance=sentance.split("player|").join("");
			sentance=sentance.split("$$$").join(first_name);
			sentance=sentance.split("@@@").join(fullname);
			var htmltext:String="<body>"+sentance+"</body>";

			subtitle=new TextField(785,120,"");
			subtitle.format.setTo("SimImpact",24,0xFFFFFF);
			subtitle.autoScale=true;
			subtitle.x=125;
			subtitle.y=650;
			subtitle.isHtmlText=true;
		    addChild(subtitle);
		    new WordsSlide(this,subtitle,htmltext);
			this.addEventListener(MyTalkingDisplay.TALKING_COMPLETE,onCompleteWordsSlide);
		}
		 
		private function onCompleteWordsSlide(e:Event):void
		{
			DebugTrace.msg("MyTalkingDisplay.onCompleteWordsSlide");

			var clickmouse:ClickMouseIcon=new ClickMouseIcon();
			clickmouse.x=973;
			clickmouse.y=704;
			addChild(clickmouse);

			if(onTalkingComplete)
			onTalkingComplete();
		}
	}
}