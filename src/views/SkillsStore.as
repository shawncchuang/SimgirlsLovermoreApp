package views
{
import controller.ViewCommand;
import controller.ViewInterface;

import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import controller.Assets;

	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.Config;
	
	import events.SceneEvent;
	

	import starling.display.Button;
	import starling.display.Image;
	import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
	import starling.events.Event;

	import starling.events.TouchEvent;

	import starling.text.TextField;
	import starling.textures.Texture;

	import utils.ViewsContainer;

	public class SkillsStore extends Sprite
	{
		private var flox:FloxInterface=new FloxCommand();
		private var command:MainInterface=new MainCommand();
        private var viewcom:ViewInterface=new ViewCommand();
		private var panelbase:Sprite;
		private var panelSkills:*;
		private var tagshit:Sprite;

		private var chmodel:Sprite;
		private var basemodel:Sprite;

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
        private var font:String="SimMyriadPro";
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
			panelbase.x=360;
			panelbase.y=159;
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
			
			
			//var ptsTexture:Texture=Assets.getTexture("SkillPtsValueIcon");
			//var skillPtsIcon:Image=new Image(ptsTexture);
			//skillPtsIcon.x=34;
			//skillPtsIcon.y=65;
			
//			sptsTxt=new TextField(100,40,"","SimMyriadPro",20);
//			sptsTxt.x=198;
//			sptsTxt.y=62;
//			sptsTxt.hAlign="left";
			
			tagshit.addChild(tagbtn);
			panelbase.addChild(tagshit);
			//panelbase.addChild(skillPtsIcon);
			//panelbase.addChild(sptsTxt);
		}
		private function initBaseModel():void
		{


            basemodel=new Sprite();
            addChild(basemodel);


            //other character
            chmodel=new Sprite();
            //chmodel.clipRect=new Rectangle(0,0,356,540);
			chmodel.mask=new Quad(356,540);
            chmodel.x=5;
            chmodel.y=120;
            addChild(chmodel);



            var params:Object=new Object();
			var gender:String=flox.getSaveData("avatar").gender;
			var _point:Point=new Point(54,180);
			if(gender=="Female"){
				_point=new Point(64,227);
			}
            params.pos=_point;
            params.clipRect=new Rectangle(0,-30,276,500);
            viewcom.fullSizeCharacter(basemodel,params);


        }
		private function initSkillsData():void
		{
			//skills tag
			
			skills=new Sprite();
            skills.addEventListener("ToucbedSkillIcon",onTriggeredElements);
            panelbase.addChild(skills);

            viewcom.skillIcons(skills);
			initCardsList();


            var skillPts:Object=flox.getSaveData("skillPts");
			sptsTxt=new TextField(70,24,String(skillPts[character]));
			sptsTxt.format.setTo(font,20);
			sptsTxt.x=198;
			sptsTxt.y=62;
            skills.addChild(sptsTxt);

			
			skillexcbox=new ExcerptBox();
			skillexcbox.x=-345;
			skillexcbox.y=113;
			skills.addChild(skillexcbox);
			ViewsContainer.SkillExcerptBox=skillexcbox;


			
		}
		private function onUpdateSkillPts(e:Event):void
		{
			var value:Number=e.data.skillpts;
			sptsTxt.text=String(value);
			
		}


		private function onTriggeredElements(e:Event):void
		{

            cate=e.data.cate;

            cardlist.removeFromParent(true);

			initCardsList();
			
			
		}
		private function initCardsList():void
		{
            cardlist=new CardsList();
            cardlist.character=character;
            cardlist.from="store";
            cardlist.cate=cate;
            cardlist.x=50;
            cardlist.y=120;
            skills.addChild(cardlist);
            cardlist.dispatchEventWith(CardsList.INIT);
		}


		private function initProIcons():void
		{

            this.addEventListener("TouchedIcon",onTouchCharaterIcon);
            viewcom.characterIcons(this);
			
		}
		private function onTouchCharaterIcon(e:Event):void
		{

            ch_index=e.data.ch_index;
            character=e.data.character;
            updateCharacter();
            updateSkills();

		}
		private function updateCharacter():void
		{
            basemodel.visible=false;
			chmodel.visible=true;
			if(ch_index==-1)
			{
                basemodel.visible=true;
				chmodel.visible=false;
			}
			else
			{

                viewcom.replaceCharacter(chmodel);

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