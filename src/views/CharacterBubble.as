package views
{
	import flash.geom.Point;
	
	import controller.AssetEmbeds;
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.DataContainer;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.utils.AssetManager;
	
	import utils.DebugTrace;
	
	public class CharacterBubble extends Sprite
	{
		private var flox:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
		private var pos:Point;
		private var bubble:Image
		private var talks:Array;
		private var pure_talks:Array=new Array();
		private var bubbletext:TextField;
		private var scene:String;
		private var talk_index:uint=0;
		private var part_index:uint=0;
		private var diraction:Number=1;
		private var texture_name:String;
		public function CharacterBubble(type:String,index:uint,part:uint,point:Point,dir:Number)
		{
			
			scene=type;
			pos=point;
			talk_index=index;
			part_index=part;
			diraction=dir;
			addBubble();
			
		}
		private function addBubble():void
		{
			
	 
			
			var library:Array;
			talks=new Array();
			pure_talks=new Array();
			switch(scene)
			{
				case "NPC":
					talks=DataContainer.NpcTalkinglibrary;
					break
				case "Story":
					library=flox.getSyetemData("main_story");
					talks=library[part_index];
					break
				case "StoryPreview":
					library=DataContainer.previewStory;
					talks=library[part_index];
					break
				default:
					library=flox.getSyetemData("scenelibrary");
					talks=library[part_index];
					break
			}
			 
			var type:String=talks[talk_index].split("|")[0];
			
			if(type.indexOf("sp")!=-1)
			{
				texture_name="Bubble";
			}
			else if(type.indexOf("sh")!=-1){
				texture_name="BubbleShout";
			}
			else if(type.indexOf("th")!=-1)
			{
				texture_name="BubbleThink";
			}
			
			if(talks[talk_index].indexOf("|")!=-1)
			{
				for(var i:uint=0;i<talks.length;i++)
				{
					pure_talks.push("");
				}
				pure_talks[talk_index]=talks[talk_index].split("|")[1];
				//talks[talk_index]=talks[talk_index].split("|")[1];
			}
			 
			
			var texture:Texture=Assets.getTexture(texture_name);
			bubble=new Image(texture);
			bubble.pivotX=bubble.width/2+20;
			bubble.pivotY=bubble.height/2;
			
			bubble.scaleX=0.2*diraction;
			bubble.scaleY=0.2;
			addChild(bubble);
			var tween:Tween=new Tween(bubble,0.5,Transitions.EASE_OUT_ELASTIC);
			tween.animate("scaleX",1*diraction);
			tween.animate("scaleY",1);
			tween.onComplete=onBubbleDisplayed;
			Starling.juggler.add(tween);
			
			
			
			
		}
		private function onBubbleDisplayed():void
		{
			Starling.juggler.removeTweens(bubble);
			addBubbleTxt();
		}
		private function addBubbleTxt():void
		{
			//var library:Array=DataContainer.characterTalklibrary;
			//talks=library[part_index]
			if(pure_talks[talk_index]==undefined)
			{
				//talks=command.filterTalking(talks);
				var sentence:String=filterScentance(pure_talks[pure_talks.length-1]);
			}
			else
			{
				sentence=filterScentance(pure_talks[talk_index]);
			}
			//DebugTrace.msg("addBubbleTxt: "+talks[talk_index]);
			
			bubbletext=new TextField(200,200,"","SimImpact",22,0x000000);
			bubbletext.hAlign="center";
			bubbletext.autoScale=true;
			bubbletext.text=sentence.split("<>").join(",");
			bubbletext.pivotX=bubbletext.width/2+20*diraction;
			var pioveY:Number=bubbletext.height/2+15;
			if(texture_name=="BubbleThink" || texture_name=="BubbleShout")
			{
				pioveY=bubbletext.height/2+45;
			}
			bubbletext.pivotY=pioveY;
			
			addChild(bubbletext);
		}
		private function filterScentance(src:String):String
		{
			var re:String=src;
			
			switch(scene)
			{
				case "TarotReading":
					var player:Object=DataContainer.player;
					if(re.indexOf("$$$")!=-1)
					{
						re=String(re.split("$$$").join(player.first_name));
					}
					//if
					break
				case "":
					
					break
			}
			//siwtch
			if(texture_name=="BubbleThink")
			{
				re=String(re.split("|think|").join(""));
			}
			return re;
		}
	}
}