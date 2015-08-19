package utils
{
	
	
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.display.ContentDisplay;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import controller.FloxManagerController;
	
	import starling.display.Sprite;
	
	
	
	public class ViewsContainer
	{
		private static var game_st:Stage;
		private static var mainstage:Sprite;
		private static var mainscene:Sprite;
		private static var mainui:Sprite;
		private static var tarotscene:Sprite;
		private static var characters:Object;
		private static var gamebar:Sprite;
		private static var chdesign:Sprite;
		private static var formation:Sprite;
		private static var excerptboxpanel:Sprite;
		private static var basesprite:Sprite;
		private static var infodataview:Sprite;
		private static var playerCopy:Bitmap;
		private static var marketform:Sprite;
		private static var _battleteam:Object;
		private static var managerview:FloxManagerController;
		private static var groundeff_player:MovieClip;
		private static var groundeff_cpu:MovieClip;
		private static var _battlescene:flash.display.Sprite;
		private static var content:LoaderMax;
		private static var battleview:MovieClip;
		private static var battletop:MovieClip;
		private static var battlealert:MovieClip;
		private static var enemy_bike:MovieClip;
		private static var mini_game:MovieClip;
		private static var skillexcerptbox:Sprite;
		private static var skill_store:Sprite;
		private static var player_profile:Sprite;

		public static function set GameStage(st:Stage):void
		{
			game_st=st;	
		}
		public static function get GameStage():Stage
		{
			return game_st;	
		}
		public static function set MainStage(target:Sprite):void
		{
			mainstage=target;
		}
		public static function get MainStage():Sprite
		{
			return mainstage;
		}
		public static function set MainScene(target:Sprite):void
		{
			mainscene=target;
		}
		public static function get MainScene():Sprite
		{
			return mainscene;
		}
		public static function set UIViews(target:Sprite):void
		{
			mainui=target;
			
		}
		public static function get UIViews():Sprite
		{
			return mainui;
			
		}
		public static function set currentScene(target:Sprite):void
		{
			tarotscene=target;
		}
		public static function get currentScene():Sprite
		{
			return tarotscene;
		}
		public static function set Characters(obj:Object):void
		{
			characters=obj
		}
		public static function get Characters():Object
		{
			return characters;
		}
		public static function set gameinfo(target:Sprite):void
		{
			gamebar=target;
		}
		public static function get gameinfo():Sprite
		{	
			return gamebar;
		}
		public static function set chacaterdesignScene(target:Sprite):void
		{
			chdesign=target;
		}
		public static function get chacaterdesignScene():Sprite
		{
			return chdesign;
		}
		public static function set AvatarShip(target:Sprite):void
		{
			formation=target
			
		}
		public static function get AvatarShip():Sprite
		{
			return formation;
		}
		public static function set ExcerptBox(target:Sprite):void
		{
			excerptboxpanel=target;
		}
		public static function get ExcerptBox():Sprite
		{
			return excerptboxpanel;
		}
		public static function set SkillExcerptBox(target:Sprite):void
		{
			skillexcerptbox=target
		}
		public static function get SkillExcerptBox():Sprite
		{
			return skillexcerptbox;
		}
		
		public static function set baseSprite(target:Sprite):void
		{
			basesprite=target;	
		}
		public static function get baseSprite():Sprite
		{
			return basesprite;	
		}
		public static function set InfoDataView(target:Sprite):void
		{
			infodataview=target;
		}
		public static function get InfoDataView():Sprite
		{
			return infodataview;
		}
		public static function set playerCopyAsBitmap(bmap:Bitmap):void
		{
			
			playerCopy=bmap;
			
		}
		public static function get playerCopyAsBitmap():Bitmap
		{
			
			return playerCopy;
			
		}
		public static function set blackmarketform(target:Sprite):void
		{
			
			marketform=target;
		}
		public static function get blackmarketform():Sprite
		{
			
			return marketform;
		}
		public static function set battleteam(team:Object):void
		{
			_battleteam=team;
		}
		public static function get battleteam():Object
		{
			return _battleteam;
		}
		public static function set FloxManager(manager:FloxManagerController):void
		{
			managerview=manager;
		}
		public static function get FloxManager():FloxManagerController
		{
			return managerview;
		}
		public static function set groundEffectPlayer(mc:MovieClip):void
		{
			groundeff_player=mc
		}
		public static function get groundEffectPlayer():MovieClip
		{
			return groundeff_player
		}
		public static function set groundEffectCPU(mc:MovieClip):void
		{
			groundeff_cpu=mc;
		}
		public static function get groundEffectCPU():MovieClip
		{
			return groundeff_cpu;
		}
		public static function set battlescene(scene:flash.display.Sprite):void
		{
			_battlescene=scene;
		}
		public static function get battlescene():flash.display.Sprite
		{
			return _battlescene;
		}
		public static function set loaderQueue(loader:LoaderMax):void
		{
			content=loader;
			
		}
		public static function get loaderQueue():LoaderMax
		{
			return content;
			
		}
		public static function set battleView(view:MovieClip):void
		{
			battleview=view;
		}
		public static function get battleView():MovieClip
		{
			return battleview;
		}
		public static function set battleTop(view:MovieClip):void
		{
			battletop=view;
		}
		public static function get battleTop():MovieClip
		{
			return battletop;
		}
		public static function set BattleAlert(view:MovieClip):void
		{
			battlealert=view;
		}
		public static function get BattleAlert():MovieClip
		{
			return battlealert;
		}
		public static function set EnemyBike(view:MovieClip):void
		{
			enemy_bike=view;	
		}
		public static function get EnemyBike():MovieClip
		{
			return enemy_bike;	
		}
		public static function set MiniGame(view:MovieClip):void
		{
			mini_game=view;
		}
		public static function get MiniGame():MovieClip
		{
			return mini_game
		}
		public static function set SkillStore(target:Sprite):void
		{
			
			skill_store=target;
		}
		public static function get SkillStore():Sprite
		{
			
			return skill_store;
		}
		public static function set PlayerProfile(target:Sprite):void
		{
			player_profile=target;
		}
		public static function get PlayerProfile():Sprite
		{
			return player_profile;
		}
	}
}