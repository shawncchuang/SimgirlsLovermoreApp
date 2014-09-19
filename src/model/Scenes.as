package model
{

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;

import flash.display.MovieClip;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.BlendMode;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

import views.AcademyScene;
import views.AirplaneScene;
import views.AirportScene;
import views.ArenaScene;
import views.BankScene;
import views.BeachScene;
import views.BetaScene;
import views.BlackMarketScene;
import views.CalendarScene;
import views.CasinoScene;
import views.ChangeFormationScene;
import views.ChangingRoomScene;
import views.CharacterDesignScene;
import views.CinemaScene;
import views.ContactsScene;
import views.DatingScene;
import views.FitnessClubScene;
import views.FoundSomeScene;
import views.GardenScene;
import views.HotSpringScene;
import views.HotelScene;
import views.LoungeScene;
import views.LovemoreMansionScene;
import views.MainScene;
import views.MenuScene;
import views.MiniGameScene;
import views.MuseumScene;
import views.NightClubScene;
import views.ParkScene;
import views.PhotosScene;
import views.PierScene;
import views.PoliceStationScene;
import views.PrivateIslandScene;
import views.ProfileScene;
import views.SettingsScene;
import views.RestaurantScene;
import views.ShoppingCentreScene;
import views.SportsBarScene;
import views.StarlingBattleScene;
import views.TarotreadingScene;
import views.TempleScene;
import views.ThemedParkScene;



public class Scenes extends Sprite
{
    //private var scenebg:Image;

    private var scene:Sprite;
    private var current_scence:Sprite;
    private var mainstage:Sprite
    private var command:MainInterface=new MainCommand();
    private var flox:FloxInterface=new FloxCommand();

    private var scene_container:Sprite;
    private var next_scene:String;
    private var sceneObj:Object;
    private var scenebg:Image;
    public var battle_type:String;
    private function scenesPool():Object
    {

        /*sceneObj={
         "Tarotreading":TarotreadingScene,
         "CharacterDesignScene":CharacterDesignScene,
         "MainScene":MainScene,
         "AirplaneScene":AirplaneScene,
         "HotelScene": HotelScene,
         "BattleScene": BattleScene,
         "AirportScene": AirportScene,
         "FitnessScene": FitnessClubScene
         }
         */
        return sceneObj;
    }
    public function setupEvent():void
    {


        mainstage=ViewsContainer.MainStage;
        mainstage.addEventListener(SceneEvent.CHANGED,onChengedScene);
        mainstage.addEventListener(SceneEvent.CLEARED,onClearedScene);
    }

    private function onChengedScene(e:Event):void
    {

        scene=ViewsContainer.MainScene;
        next_scene=e.data.name;
        clearSceneHandle();


    }
    private function clearSceneHandle():void
    {

        try{

            Starling.current.nativeOverlay.removeChild(filtersMC);

            var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
            gameEvt=SimgirlsLovemore.gameEvent;
            gameEvt._name="remove_waving";
            gameEvt.displayHandler();

        }catch(e:Error){

            DebugTrace.msg("Scene.changeSceneHandle filtersMC=NULL");
        }



        var scentTween:Tween=new Tween(scene,0.5,Transitions.EASE_OUT);
        scentTween.fadeTo(0);
        scentTween.onComplete=onFadeoutComplete;
        Starling.juggler.add(scentTween);

    }
    private  var filtersMC:flash.display.MovieClip;
    private function changeSceneHandle():void
    {


        //var scene:Sprite=ViewsContainer.MainScene;
        ViewsContainer.InfoDataView.visible=true;
        if(next_scene!="MenuScene" && next_scene!="ProfileScene" &&
                next_scene!="SettingsScene" &&  next_scene!="ContactsScene" && next_scene!="CalendarScene" && next_scene!="PhotosScene")
        {
            DataContainer.currentLabel=next_scene;
        }
        if(next_scene!="FoundSomeScene" && next_scene!="DatingScene" &&
                next_scene!="MenuScene" && next_scene!="ProfileScene" &&
                next_scene!="SettingsScene" &&  next_scene!="ContactsScene" &&
                next_scene!="CalendarScene" && next_scene!="PhotosScene")
        {
            DataContainer.currentScene=next_scene;
        }
        scene_container=new Sprite();
        scene_container.name="scene_container";

        scene.addChild(scene_container);


        DebugTrace.msg("Scenes.changeSceneHandle next_scene:"+next_scene);
        if(next_scene=="MainScene")
        {
            var scene_texture:String=next_scene.split("Scene").join("Bg");
            var bgTexture:Texture=Assets.getTexture(scene_texture+"Day");
            scenebg=new Image(bgTexture);
            scene_container.addChild(scenebg);

            filtersMC=new flash.display.MovieClip();
            filtersMC.name="waving"
            Starling.current.nativeOverlay.addChild(filtersMC);


            var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
            gameEvt.container=filtersMC;
            gameEvt._name="waving";
            gameEvt.displayHandler();

        }
        else
        {

            /*
            try{
                Starling.current.nativeOverlay.removeChild(filtersMC);

            }catch(e:Error){

                DebugTrace.msg("Scene.changeSceneHandle filtersMC=NULL");
            }

            gameEvt=SimgirlsLovemore.gameEvent;
            gameEvt._name="remove_waving";
            gameEvt.displayHandler();

            */

        }

        var infobar:Boolean=true;


        //current_scence=getScene(next_scene);
        switch(next_scene)
        {
            case "Tarotreading":
                infobar=false;
                current_scence=new TarotreadingScene();
                break
            case "CharacterDesignScene":
                infobar=false;
                current_scence=new CharacterDesignScene();
                break
            case "MainScene":
                current_scence= new MainScene();
                break
            case "AirplaneScene":
                infobar=false;
                current_scence=new AirplaneScene();
                break
            case "HotelScene":
                current_scence= new HotelScene();
                break
            case "BattleScene":
                infobar=false;
                current_scence=new StarlingBattleScene();
                break
            case "AirportScene":
                current_scence=new AirportScene();
                break
            case "FitnessClubScene":
                current_scence=new FitnessClubScene();
                break
            case "MuseumScene":
                current_scence=new MuseumScene();
                break
            case "BeachScene":
                current_scence=new BeachScene();
                break
            case "NightclubScene":
                current_scence=new NightClubScene();
                break
            case "ChangeFormationScene":
                infobar=false;
                current_scence=new ChangeFormationScene();
                break
            case "MenuScene":
                infobar=false;
                current_scence=new MenuScene();

                break
            case "ProfileScene":
                infobar=false;
                current_scence=new ProfileScene();
                break
            case "SettingsScene":
                infobar=false;
                current_scence=new SettingsScene();
                break
            case "CalendarScene":
                infobar=false;
                current_scence=new CalendarScene();
                break
            case "ContactsScene":
                infobar=false;
                current_scence=new ContactsScene();
                break
            case "PhotosScene":
                infobar=false;
                current_scence=new PhotosScene();
                break
            case "FoundSomeScene":
                infobar=false;
                current_scence=new FoundSomeScene();
                break
            case "DatingScene":

                infobar=false;
                current_scence=new DatingScene();
                break
            case "SSCCArenaScene":
                current_scence=new ArenaScene();
                break
            case "AcademyScene":
                current_scence=new AcademyScene();
                break
            case "SpiritTempleScene":
                current_scence=new TempleScene();
                break
            case "PoliceStationScene":
                current_scence=new PoliceStationScene();
                break
            case "CasinoScene":
                current_scence=new CasinoScene();
                break
            case "LovemoreMansionScene":
                current_scence=new LovemoreMansionScene();
                break
            case "ShoppingCentreScene":
                current_scence=new ShoppingCentreScene();
                break
            case "CinemaScene":
                current_scence=new CinemaScene();
                break
            case "PierScene":
                current_scence=new PierScene();
                break
            case "LoungeScene":
                current_scence=new LoungeScene();
                break
            case "ParkScene":
                current_scence=new ParkScene();
                break
            case "ThemedParkScene":
                current_scence=new ThemedParkScene();
                break
            case "HotSpringScene":
                current_scence=new HotSpringScene();
                break
            case "SportsBarScene":
                current_scence=new SportsBarScene();
                break
            case "BankScene":
                current_scence=new BankScene();
                break
            case "PrivateIslandScene":
                current_scence=new PrivateIslandScene();
                break
            case "GardenScene":
                current_scence=new GardenScene();
                break
            case "BlackMarketScene":
                current_scence=new BlackMarketScene();
                break
            case "ChangingRoomScene":
                current_scence=new ChangingRoomScene();
                break
            case "RestaurantScene":
                current_scence=new RestaurantScene();
                break
            case "TraceGame":
            case "TrainingGame":
                infobar=false;
                current_scence=new MiniGameScene(next_scene);
                break
            case "BetaScene":
                infobar=false;
                current_scence=new BetaScene();
                break

        }
        //switch

        scene.addChild(current_scence);
        var UIViews:Sprite=ViewsContainer.UIViews;
        var  gameInfobar:Sprite=ViewsContainer.InfoDataView;
        var tween:Tween=new Tween(gameInfobar,0.5,Transitions.EASE_IN_OUT_BACK);
        if(infobar){

            tween.animate("y",-29);

        }else{

            tween.animate("y",-(gameInfobar.height));

        }
        tween.onComplete=onGameIngbarFadeinComplete;
        Starling.juggler.add(tween);

        function onGameIngbarFadeinComplete():void{

            if(infobar){
                var gameInfobar:Sprite=ViewsContainer.gameinfo;
                gameInfobar.dispatchEventWith("DISPLAY");
            }


            UIViews.visible=infobar;
            Starling.juggler.removeTweens(gameInfobar);
        }



    }
    /*private function getScene(attr:String):Sprite
     {
     var scene_names:Array=["Tarotreading","CharacterDesignScene",
     "MainScene","AirplaneScene","HotelScene",
     "BattleScene","AirportScene","FitnessClubScene",
     "MuseumScene","BeachScene","NightClub"];
     var index:Number=scene_names.indexOf(attr);
     var sceneVetor:Vector.<Sprite> = new <Sprite>[new TarotreadingScene(),new CharacterDesignScene(),new MainScene(),new AirplaneScene(),
     new HotelScene(),new BattleScene(),new AirportScene(),new FitnessClubScene(),new MuseumScene(),new BeachScene(),new NightClubScene()]



     return sceneVetor[index];
     }*/
    private function onClearedScene(e:SceneEvent):void
    {
        /*var mainstage:Sprite=ViewsContainer.MainStage;
         var scene:Sprite=ViewsContainer.MainScene;
         var mainUI:Sprite=ViewsContainer.UIViews;
         if(mainUI)
         {
         mainstage.removeChild(mainUI);
         }

         var scentTween:Tween=new Tween(scene,.5,Transitions.EASE_OUT);
         scentTween.animate("alpha",0.5);
         scentTween.onComplete=onFadeoutComplete;
         Starling.juggler.add(scentTween);*/
        clearSceneHandle();

    }
    private function onFadeoutComplete():void
    {
        Starling.juggler.removeTweens(scene);

        var mainstage:Sprite=ViewsContainer.MainStage;
        scene.alpha=1;
        if(scene_container)
        {
            //DebugTrace.msg("Scenes.onFadeoutComplete:"+scene_container.numChildren);
            if(scenebg)
            {
                scenebg.removeFromParent(true);
                scenebg=null;
            }
            current_scence.removeFromParent(true);
            scene_container.removeFromParent(true);
            scene.removeFromParent(true);

            scene_container=null;
            //new scene
            scene=new Sprite();
            addChild(scene);
            ViewsContainer.MainScene=scene;
            mainstage.addChild(scene);
            var uiViews:Sprite=ViewsContainer.UIViews;
            mainstage.swapChildren(scene,uiViews);
        }

        changeSceneHandle();
        //flox.refreshSaveData(onRefreshComplete);


    }
    private function onRefreshComplete():void{

        changeSceneHandle();

    }
}
}