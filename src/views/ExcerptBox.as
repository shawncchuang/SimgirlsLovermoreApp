package views
{
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import data.Config;
	import data.DataContainer;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	public class ExcerptBox extends Sprite
	{
		private var excerptbox:Image;
		private var excerptTxt:TextField;
		private var flox:FloxInterface=new FloxCommand();
		public function ExcerptBox()
		{
		
			
			var texture:Texture=Assets.getTexture("ExcerptBox");
			excerptbox=new Image(texture);
			
			excerptTxt=new TextField(290,290,"",Config.ExcerptFornt,20,0xFFFFFF);
			excerptTxt.x=8;
			//excerptTxt.y=5;
			excerptTxt.hAlign="left";
			excerptTxt.vAlign="center";
			this.addChild(excerptbox);
			this.addChild(excerptTxt);
			this.addEventListener("UPDATE",onUpdateExcerpt);
			this.addEventListener("CLEAR",onClearExcerpt);
			this.visible=false;
		}
		private function onUpdateExcerpt(e:Event):void
		{
			//DebugTrace.msg("ExcerptBox.onUpdateExcerpt type="+e.data.type+" ,id="+e.data.id+" ,skill="+e.data.skill);
			switch(e.data.type)
			{
				case "assets":
					var id:String=e.data.id;
					var attr:String="assets";
					if(e.data.attr)
					{
						attr=e.data.attr;
					}
					var systemdata:Object=flox.getSyetemData(attr);
					var assetsLog:Object=systemdata[id];
					var excerpt:String=assetsLog.exc;
					
					DebugTrace.msg("ProfileScene.onUpdateExcerpt id:"+ id);
					break
				case "skill_card":
					var skills:Object=flox.getSyetemData("skillsys");
					var skillObj:Object=skills[e.data.skill];
					excerpt=skillObj.note;
					break;
			}
			if(excerpt!="")
			{
				excerptTxt.text=excerpt;
				this.visible=true;
			}
			
		}
		private function onClearExcerpt(e:Event):void
		{
			
			this.visible=false;
			
		}
	}
}