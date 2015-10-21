package controller
{
	
	import com.emibap.textureAtlas.DynamicAtlas;
	
	import flash.display.Bitmap;
	import flash.media.SoundChannel;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import controller.MusicEmbed;
	import controller.SoundEmbed;
	
	import starling.display.MovieClip;
	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.utils.AssetManager;
	
	import utils.DebugTrace;
	
	public class Assets
	{
		private static var subclassObj:Object={

			//"sirena":new Sirena(),
			//"sao":new Sao(),
			//"zack":new Zack(),
			//"tomoru":new Tomoru(),
			//"lenus":new Lenus(),
			//"dea":new Dea(),
			//"klr":new Klaire(),
			//"ceil":new Ceil(),
			"MaleBody":new MaleBody(),
			"FemaleBody":new FemaleBody(),
			"FrameFilterSex":new FrameFilterSex(),
			"ColorTitleFilters":new ColorTitleFilters(),

			"PanelProfile":new PanelProfile(),
			"PanelAssets":new PanelAssets(),
			"PanelSkills":new PanelSkills(),

			"TileBlack":new TileBlack(),
			"TileRed":new TileRed(),
			"TileGreen":new TileGreen(),
			"TileBlue":new TileBlue(),
			"AlertTalking":new AlertTalkingUI(),
			"WavingCrash1":new WavingCrash1()
			//"daz":new NPC001_daz()
		}
		private static var sContentScaleFactor:int = 1;
		private static var sTextures:Dictionary = new Dictionary();
		private static var sSounds:Dictionary = new Dictionary();
		private static var sTextureAtlas:TextureAtlas;
		private static var music_channel:SoundChannel;
		private static var music_manager:AssetManager;
		private static var sound_manager:AssetManager;
		private static var music:String;
		private static var sound:String;
		
		public static function set MusicChannel(sh:SoundChannel):void
		{
			music_channel=sh;
		}
		public static  function get MusicChannel():SoundChannel
		{
			return music_channel;
		}
		
		public static function set MusicManager(mm:AssetManager):void
		{
			music_manager=mm
		}
		public static function get MusicManager():AssetManager
		{
			return music_manager;
		}
		public static function set SoundManager(mm:AssetManager):void
		{
			sound_manager=mm
			
		}
		public static function get SoundManager():AssetManager
		{
			return sound_manager;
		}
		public function initSoundAssetsManager():void
		{
			//sound=src;
			sound_manager=new AssetManager();
			sound_manager.verbose=true
			sound_manager.enqueue(SoundEmbed);
			sound_manager.loadQueue(onLoadedSoundEnquese);
			
			SoundManager=sound_manager;
		}
		private function onLoadedSoundEnquese(ratio:Number):void
		{
			
			//DebugTrace.msg("Loading assets, progress:"+ratio);
			// sound_manager.playSound(sound,0,-1);
			
		}
		public  function initMusicAssetsManager():void
		{
			//music=src;
			music_manager=new AssetManager();
			
			music_manager.verbose=true
			music_manager.enqueue(MusicEmbed);
			music_manager.loadQueue(onLoadedMusicEnquese);
			
			MusicManager=music_manager;
		}
		private function onLoadedMusicEnquese(ratio:Number):void
		{
			trace(music_manager.getSoundNames());
			//music_manager.playSound(music,0);
			
			
		}
		public static function getTexture(name:String):Texture
		{
			//DebugTrace.msg("Assets.getTexture name:"+name);
			if (sTextures[name] == undefined)
			{
				var data:Object = create(name);

				if (data is Bitmap)
				{
					sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
				}
				else if (data is ByteArray)
				{
					
					sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
				}else
				{
					//ATF format
					//sTextures[name] = Texture.fromEmbeddedAsset(data);
					sTextures[name] = Texture.fromAtfData(data as ByteArray,sContentScaleFactor);
				}
			}
			return sTextures[name];
		}
		
		public static function getAtalsXML(name:String):XML
		{
			var atlasClass:Class=AssetEmbeds;
			var xml:XML=XML(new atlasClass[name]);
			return xml;
		}
		
		public static function create(name:String):Object
		{
			//var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
			
			var textureClass:Class=AssetEmbeds;
			return new textureClass[name];
		}
		public static function getDynamicAtlas(src:String):*
		{
			var superclass:Object=new Object();
			//DebugTrace.msg("Assets.getDynamicAtlas src:"+src);
			var attr:String="Background";

			var mc_ground:*

			try
			{

				var scale:Number=1;
				var rate:Number=1;
				if(src=="ShutterstockFrameAni")
				{
					rate=30;
				}
				else if(src.indexOf("Tile")!=-1)
				{
					rate=12;
				}
				var atlas:TextureAtlas = DynamicAtlas.fromMovieClipContainer(subclassObj[src],scale,0,true,true);
				mc_ground = new starling.display.MovieClip(atlas.getTextures("images"), rate);

			}
			catch(error:Error)
			{
				DebugTrace.msg("Assets.getDynamicAtlas:  Resource limit for this resource type exceded");

			}
			//if

			return mc_ground;
		}
		
	}
}