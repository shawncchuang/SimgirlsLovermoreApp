package views
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import controller.Assets;
	import controller.DrawerInterface;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.Config;
	
	import events.SceneEvent;
	
	import model.SaveGame;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	import starling.textures.TextureSmoothing;
	
	import utils.DrawManager;
	import utils.ViewsContainer;

	public class SkillsStore extends Sprite
	{
		private var flox:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
		private var panelbase:Sprite;
		private var panelSkills:*;
		private var tagshit:Sprite;
		private var drawcom:DrawerInterface=new DrawManager();
		private var chmodel:Sprite;
		private var basemodel:Sprite;
		private var copyModel:Sprite;
		private var skills:Sprite;
		private var skillexcbox:Sprite;
		private var cate:String="fire";
		private var character:String="player";
		private var cardlist:CardsList;
		private var left_arrow:Button;
		private var right_arrow:Button;
		private var player_icon:Sprite;
		private var ch_index:Number=0;
		private var sptsTxt:TextField;
		private var skillPts:Number=0;
		public static var UPDATE_SKILLPTS:String="";
		public function SkillsStore()
		{
			initBaseModel();
			initLayout();
			initSkillsData();
			initProIcons();
			
			initCancelHandle();
			
			this.addEventListener(SkillsStore.UPDATE_SKILLPTS,onUpdateSkillPts);
			ViewsContainer.SkillStore=this;
		}
		private function initLayout():void
		{
			ViewsContainer.UIViews.visible=false;
			panelbase=new Sprite();
			panelbase.x=374;
			panelbase.y=96;
			addChild(panelbase);
			
			var texture:Texture=Assets.getTexture("PanelSkillsStore");
			panelSkills=new Image(texture);
			panelSkills.name="skills";
			panelbase.addChild(panelSkills);
			
			tagshit=new Sprite();
			tagshit.alpha=0;
			var tagtexure:Texture=Assets.getTexture("Empty");
			var tagbtn:Button=new Button(tagtexure);
			tagbtn.name="skills";
			tagbtn.width=105;
			tagbtn.height=60;
			//tagbtn.x=disablesObj[currentTag].split(",")[i];
			
			
			var ptsTexture:Texture=Assets.getTexture("SkillPtsValueIcon");
			var skillPtsIcon:Image=new Image(ptsTexture);
			skillPtsIcon.x=34;
			skillPtsIcon.y=65;
			
			sptsTxt=new TextField(100,40,"","SimNeogreyMedium",30,0xFFFFFF);
			sptsTxt.x=120;
			sptsTxt.y=70;
			sptsTxt.hAlign="left";
			
			tagshit.addChild(tagbtn);
			panelbase.addChild(tagshit);
			panelbase.addChild(skillPtsIcon);
			panelbase.addChild(sptsTxt);
		}
		private function initBaseModel():void
		{
			
			var savedata:SaveGame=FloxCommand.savegame;
			var gender:String=savedata.avatar.gender;
			
			var modelObj:Object={"Male":new Rectangle(0,-20,276,660),
				"Female":new Rectangle(0,-20,262,613)}
			var modelRec:Rectangle=modelObj[gender];
			
			chmodel=new Sprite();
			chmodel.y=50;
			addChild(chmodel);
			
			
			basemodel=new Sprite();
			basemodel.x=modelRec.x;
			basemodel.y=modelRec.y;
			addChild(basemodel);
			
			
			var modelAttr:Object=new Object();
			modelAttr.gender=gender;
			modelAttr.width=modelRec.width;
			modelAttr.height=modelRec.height;
			
			drawcom.drawCharacter(basemodel,modelAttr);
			drawcom.updateBaseModel("Eyes");
			drawcom.updateBaseModel("Hair");
			drawcom.updateBaseModel("Pants");
			drawcom.updateBaseModel("Clothes");
			drawcom.updateBaseModel("Features");
			
			
			copyModel=new Sprite();
			addChild(copyModel);
			
			var posObj:Object={"Male":new Point(55,100),
				"Female":new Point(50,140)
			}
			
			drawcom.playerModelCopy(copyModel,posObj[gender]);
			
			if(gender=="Female")
			{
				basemodel.x=modelRec.x-25;
			}
			//if
			 
		}
		private function initSkillsData():void
		{
			//skills tag
			
			skills=new Sprite();
			
			initSkillsGate();
			initCardsList();
			
			panelbase.addChild(skills);
			 
			
			skillexcbox=new ExcerptBox();
			skillexcbox.x=-345;
			skillexcbox.y=113;
			skills.addChild(skillexcbox)
			ViewsContainer.SkillExcerptBox=skillexcbox;
			
			
			
			
			
			var skillPtsObj:Object=flox.getSaveData("skillPts");
			skillPts=skillPtsObj[character];
			sptsTxt.text=String(skillPts);
			
			
		}
		private function onUpdateSkillPts(e:Event):void
		{
			var value:Number=e.data.skillpts;
			sptsTxt.text=String(value);
			
		}
		private function initSkillsGate():void
		{
			var elements:Array=Config.elements;
			for(var i:uint=0;i<elements.length;i++)
			{
				
				
				var texture:Texture=Assets.getTexture("Cate_"+elements[i]);
				var elementsbtn:Button=new Button(texture);
				elementsbtn.name=elements[i];
				elementsbtn.x=i*50+336;
				elementsbtn.y=70;
				skills.addChild(elementsbtn);
				elementsbtn.addEventListener(Event.TRIGGERED,onTriggeredElements);
			}
			//for
			
			
			
		}
		private function onTriggeredElements(e:Event):void
		{
			var target:Button=e.currentTarget as Button;
			cate=target.name;
			left_arrow.removeFromParent(true);
			right_arrow.removeFromParent(true);
			cardlist.removeFromParent(true);
			//skills.removeChild(left_arrow);
			//skills.removeChild(right_arrow);
			//skills.removeChild(cardlist);
			
			initCardsList();
			
			
		}
		private function initCardsList():void
		{
			var _data:Object=new Object();
			_data.character=character;
			_data.list="store";
			_data.cate=cate;
			cardlist=new CardsList(_data);
			cardlist.x=49;
			cardlist.y=130;
			
			var texture:Texture=Assets.getTexture("IconArrow");
			left_arrow=new Button(texture);
			left_arrow.name="left";
			left_arrow.x=13;
			left_arrow.y=314;
			right_arrow=new Button(texture);
			right_arrow.name="right";
			right_arrow.x=610;
			right_arrow.y=314;
			right_arrow.scaleX=-1;
			
			left_arrow.addEventListener(Event.TRIGGERED,onTriggeredSkillList);
			right_arrow.addEventListener(Event.TRIGGERED,onTriggeredSkillList);
			
			
			var arrow_data:Object=new Object();
			arrow_data.left_arrow=left_arrow;
			arrow_data.right_arrow=right_arrow;
			arrow_data.profile=this;
			cardlist.dispatchEventWith(CardsList.INIT,false,arrow_data)
			
			skills.addChild(left_arrow);
			skills.addChild(right_arrow);
			skills.addChild(cardlist);
		}
		private function onTriggeredSkillList(e:Event):void
		{
			var target:Button=e.currentTarget as Button;
			
			var _data:Object=new Object();
			_data.dir=target.name;
			_data.left_arrow=left_arrow;
			_data.right_arrow=right_arrow;
			var cardsEvent:Event=new Event(CardsList.CHANGE,true,_data);
			cardlist.dispatchEvent(cardsEvent);
			
		}
		private function initProIcons():void
		{
			
			var savedata:SaveGame=FloxCommand.savegame;
			var gender:String=savedata.avatar.gender;
			
			player_icon=new Sprite();
			player_icon.name="Player";
			addChild(player_icon);
			var pos:Point=new Point(60,710);
			drawcom.drawPlayerProfileIcon(player_icon,1,pos);
			
			//drawcom.drawPlayerProfileIcon(player_icon,1,new Point(54,50));
			player_icon.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
			
			
			
			var characters:Array=Config.characters;
			for(var i:uint=0;i<characters.length;i++)
			{
				var name:String=characters[i].toLowerCase();
				var pts:Number=Number(savedata.pts[name]);
				var enable_ch:String="ProEmpty";
				var enabled:Boolean=false;
				
				var sprite:Sprite=new Sprite();
				sprite.name=characters[i];
				sprite.useHandCursor=enabled;
				sprite.x=i*100+160;
				sprite.y=710;
				
				if(pts!=-1)
				{
					enabled=true;
					drawcom.drawCharacterProfileIcon(sprite,characters[i],0.45);
				}
				else
				{	
					var texture:Texture=Assets.getTexture(enable_ch);
					var img:Image=new Image(texture);
					img.smoothing=TextureSmoothing.TRILINEAR;
					img.pivotX=img.width/2;
					img.pivotY=img.height/2;
					img.scaleX=0.45;
					img.scaleY=0.45;
					sprite.addChild(img);
				}
				//if
				
				
				addChild(sprite);
			
				if(enabled)
				{
					sprite.addEventListener(TouchEvent.TOUCH,onTouchCharaterIcon);
				}
				//if
			}
			//for
			
			
		}
		private function onTouchCharaterIcon(e:TouchEvent):void
		{
			var target:Sprite=e.currentTarget as Sprite;
			var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
			var began:Touch=e.getTouch(target,TouchPhase.BEGAN);
			if(hover)
			{
				
				var tween:Tween=new Tween(target,0.2,Transitions.LINEAR);
				tween.scaleTo(1.1);
				Starling.juggler.add(tween);
				
				
			}
			else
			{
				var scale:Number=1;
				if(target.name=="Player")
				{
					scale=0.89;
				}
				//if	
				tween=new Tween(target,0.2,Transitions.LINEAR);
				tween.scaleTo(scale);
				Starling.juggler.add(tween);
			}
			//if
			if(began)
			{
				ch_index=Config.characters.indexOf(target.name);
				character=target.name.toLowerCase();
				//CharacterName=character;
				updateCharacter();
				updateSkills();
			
			}
			//if
		}
		private function updateCharacter():void
		{
			copyModel.visible=false;
			chmodel.visible=true;
			if(ch_index==-1)
			{
				copyModel.visible=true;
				chmodel.visible=false;
			}
			else
			{
				var old_chmc:MovieClip=chmodel.getChildByName("character") as MovieClip;
				if(old_chmc)
				{
					old_chmc.removeFromParent(true);
					
				}
				var ch_name:String=Config.characters[ch_index];
			 
				var chmc:MovieClip=Assets.getDynamicAtlas(ch_name.toLowerCase());
				chmc.name="character";
				chmc.width=356;
				chmc.height=608;
				chmodel.addChild(chmc)
			}
			
			
		}
		private function updateSkills():void
		{
			cate="fire";
			skills.removeFromParent(true);
			initSkillsData();
			
		}
		private function initCancelHandle():void
		{
		 
			command.addedCancelButton(this,doCannelHandler);
			
			
		}
		private function doCannelHandler():void
		{
			var _data:Object=new Object();
			_data.name="AcademyScene";
			command.sceneDispatch(SceneEvent.CHANGED,_data)
		}
	}
}