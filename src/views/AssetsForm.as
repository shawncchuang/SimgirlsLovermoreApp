package views
{
	import controller.Assets;
	
	import events.GameEvent;
	
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	
	public class AssetsForm extends Sprite
	{
		private var gameEvent:GameEvent;
		private var tag_names:Array=["consumable","misc","apparel","estatecar"];
		public function AssetsForm()
		{
			
			
			gameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="assets_form";
			gameEvent.displayHandler();
			gameEvent._name="disable_assets_form";
			gameEvent.displayHandler();
			 
			
			this.addEventListener("DISPLAY",onDisplayAssetsForm);
			this.addEventListener(Event.ENTER_FRAME,onVisableAssetForm);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemovedAssetForm);
			
		}
		private function initTags():void
		{
			for(var i:uint=0;i<tag_names.length;i++)
			{
				DebugTrace.msg("AssetsForm.initTags tag_names:"+tag_names[i]+"Tag")
				var texture:Texture=Assets.getTexture(tag_names[i]+"Tag");
				var tagbtn:Button=new Button(texture);
				tagbtn.x=328+i*tagbtn.width;
				tagbtn.y=68;
				addChild(tagbtn);
			}
			//for
			
			
		}
		private function onDisplayAssetsForm(e:Event):void
		{
			
			gameEvent._name="assets_form";
			gameEvent.displayHandler();
			
		}
		private function  onVisableAssetForm(e:Event):void
		{
			if(this.visible)
			{
				//DebugTrace.msg("true");
				gameEvent._name="enable_assets_form";
			}
			else
			{
				//DebugTrace.msg("false");
				gameEvent._name="disable_assets_form";
			}
			gameEvent.displayHandler();
		}
		private function onRemovedAssetForm(e:Event):void
		{
			gameEvent._name="removed_assets_form";
			gameEvent.displayHandler();
			this.removeEventListener(Event.ENTER_FRAME,onVisableAssetForm);
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemovedAssetForm);
		}
	}
}