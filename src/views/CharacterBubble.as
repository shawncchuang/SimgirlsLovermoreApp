package views
{
import data.Config;
import data.StoryDAO;
import data.TwinDAO;

import feathers.controls.Label;

import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;

import flash.geom.Point;

import controller.AssetEmbeds;
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import flash.text.TextFormat;

import starling.animation.Juggler;

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
	private var onBubbleComplete:Function;
	private var tweenID:uint=0;
	public function CharacterBubble(type:String,index:uint,part:uint,point:Point,dir:Number,callback:Function=null)
	{

		scene=type;
		pos=point;
		talk_index=index;
		part_index=part;
		diraction=dir;
		onBubbleComplete=callback;
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
				var switchID:String=flox.getSaveData("current_switch").split("|")[0];
				if(switchID.indexOf("t")!=-1){
					talks=TwinDAO.switchTwinDAO(switchID);
				}else{
					talks=StoryDAO.switchStory(switchID);
				}
				break;
			case "TwinStory":
				var dating:String=DataContainer.currentDating;
				var rel:Object=flox.getSaveData("rel");
				var current_rel:String=rel[dating];
				var datingtwin:Object=flox.getSaveData("datingtwin");
				var id:String=datingtwin[current_rel].id;
				talks=TwinDAO.switchTwinDAO(id);
				break;
			case "StoryPreview":
				library=DataContainer.previewStory;
				talks=library[part_index];
				break;
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


//		var tween:Tween=new Tween(bubble,0.5,Transitions.EASE_OUT_ELASTIC);
//		tween.animate("scaleX",1*diraction);
//		tween.animate("scaleY",1);
//		tween.onComplete=onBubbleDisplayed;
//		Starling.juggler.add(tween);

		var juggler:Juggler=Starling.juggler;
		tweenID=juggler.tween(bubble,0.5,{scaleX:1*diraction,scaleY:1,onComplete:onBubbleDisplayed,transition:Transitions.EASE_OUT_ELASTIC});


	}
	private function onBubbleDisplayed():void
	{
		if(onBubbleComplete)
			onBubbleComplete();
		//Starling.juggler.removeTweens(bubble);
		Starling.juggler.removeByID(tweenID);
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
		var flox:FloxInterface=new FloxCommand();
		try{
			var first_name:String=flox.getSaveData("first_name");
		}catch(e:Error){
			first_name=" ";
		}

		var brand:String="";
		var msnObj:Object=DataContainer.CurrentMission;
		if(msnObj){
			var msnID:String=msnObj.id;
			var mission:Object=flox.getSyetemData("missions")[msnID];
			var assets:Object=flox.getSyetemData("assets");
			brand=assets[mission.req].brand;
		}
//		sentence=sentence.split("<>").join(",");
//		sentence=sentence.split("$$$").join(first_name);
//		sentence=sentence.split("XXX").join(brand);

		sentence=sentence.replace("<>",",");
		sentence=sentence.replace("$$$",first_name);
		sentence=sentence.replace("XXX",brand);

		var htmltext:String="<body>"+sentence+"</body>";
		bubbletext=new TextField(200,200,"");
		bubbletext.format.setTo("SimImpact",22);
		bubbletext.autoScale=true;
		bubbletext.isHtmlText=true;
		bubbletext.text=htmltext;

		bubbletext.pivotX=Math.floor(bubbletext.width/2+20*diraction);
		var pioveY:Number=Math.floor(bubbletext.height/2+15);
		if(texture_name=="BubbleThink" || texture_name=="BubbleShout")
		{
			pioveY=Math.floor(bubbletext.height/2+45);
		}
		bubbletext.pivotY=pioveY;


		addChild(bubbletext);
	}
	private function filterScentance(src:String):String
	{
		var re:String=src;
		if(SimgirlsLovemore.previewStory){
			var first_name:String="(Preview)";
			var twinflame:String="(Preview)";
		}else{
			first_name=flox.getSaveData("first_name");
			twinflame=flox.getSaveData("twinflame");
			if(twinflame) {
				twinflame = twinflame.toLowerCase();
			}
		}
		if(re.indexOf("$$$")!=-1)
		{
//			re=String(re.split("$$$").join(first_name));
			re=String(re.replace("$$$",first_name));
		}
		if(re.indexOf("@@@")!=-1){
			var fullname:String=Config.fullnames[twinflame];

//			re=String(re.split("@@@").join(fullname));
			re=String(re.replace("@@@",fullname));
		}
		//if

		if(texture_name=="BubbleThink")
		{
//			re=String(re.split("|think|").join(""));
			re=String(re.replace("|think|",""));
		}
		return re;
	}
}
}