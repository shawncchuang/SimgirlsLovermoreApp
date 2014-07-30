package views
{
	//import com.emibap.textureAtlas.DynamicAtlas;
	
	import controller.Assets;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	public class ClickMouseIcon extends Sprite
	{
		private var iconMC:MovieClip
		public function ClickMouseIcon()
		{
			var texture:Texture=Assets.getTexture("IconMouse");
			var xml:XML=Assets.getAtalsXML("IconMouseXML");
			var textureAtl:TextureAtlas=new TextureAtlas(texture,xml);
			
			iconMC=new MovieClip(textureAtl.getTextures("mouse_"),12);
			iconMC.loop=true;
			addChild(iconMC);
			iconMC.play();
			Starling.juggler.add(iconMC);
			iconMC.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			/*
			var clickmouse:ClickMouse = new ClickMouse();
			var mouse_atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(clickmouse, 1, 0, true, true);
			var click_mouse:MovieClip = new MovieClip(mouse_atlas.getTextures("mouse"), 30);
			
			addChild(click_mouse);
			Starling.juggler.add(click_mouse);
			*/
		}
		private function onRemoved():void
		{
			iconMC.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			Starling.juggler.remove(iconMC);
			
		}
	}
}