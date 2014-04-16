package views
{
	import com.emibap.textureAtlas.DynamicAtlas;
	
	import starling.core.Starling;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.textures.TextureAtlas;

	public class ClickMouseIcon extends Sprite
	{
		public function ClickMouseIcon()
		{
			var clickmouse:ClickMouse = new ClickMouse();
			var mouse_atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(clickmouse, 1, 0, true, true);
			var click_mouse:MovieClip = new MovieClip(mouse_atlas.getTextures("mouse"), 30);
			
			addChild(click_mouse);
			Starling.juggler.add(click_mouse);
		}
	}
}