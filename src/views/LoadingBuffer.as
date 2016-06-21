package views
{
import controller.Assets;

import starling.core.Starling;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

import utils.ViewsContainer;

public class LoadingBuffer extends Sprite
{
	public function LoadingBuffer()
	{
		//var bg_texture:Texture=Assets.getTexture("Whitebg");
		var stageW:Number=Starling.current.stage.stageWidth;
		var stageH:Number=Starling.current.stage.stageHeight;
		var bgImg:Quad=new Quad(stageW,stageH,0x000000);
		bgImg.alpha=0.8;
		addChild(bgImg);



		var preloadXML:XML=Assets.getAtalsXML("PreloadingXML");
		var preloadTexture:Texture=Assets.getTexture("Preloading");
		var atlas:TextureAtlas = new TextureAtlas(preloadTexture, preloadXML);
		var preloadMC:MovieClip=new MovieClip(atlas.getTextures("Sprite"),24);

		preloadMC.pivotX=(preloadMC.width/2);
		preloadMC.pivotY=(preloadMC.height/2);
		preloadMC.x=Starling.current.stage.stageWidth/2;
		preloadMC.y=Starling.current.stage.stageHeight/2;
		preloadMC.loop=true;
		addChild(preloadMC);
		preloadMC.play();
		Starling.juggler.add(preloadMC);




	}
}
}