package views
{
	import controller.Assets;
	
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.text.TextField;
	import starling.textures.Texture;

	public class LoadingBuffer extends Sprite
	{
		public function LoadingBuffer()
		{
			var bg_texture:Texture=Assets.getTexture("Whitebg");
			var bgImg:Image=new Image(bg_texture);
			bgImg.alpha=0.5;
			bgImg.color=0x000000
			bgImg.width=Starling.current.stage.stageWidth;
			bgImg.height=Starling.current.stage.stageHeight;
			addChild(bgImg);
			
			var saving_txt:TextField=new TextField(Starling.current.stage.stageWidth,50,"Loading....Please wait a minute.","Eras Demi ITC",20,0xFFFFFF);
			saving_txt.hAlign="center";
			saving_txt.y=Starling.current.stage.stageHeight/2-saving_txt.height/2;
			addChild(saving_txt);
		}
	}
}