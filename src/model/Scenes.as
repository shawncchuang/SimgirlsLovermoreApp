package model
{

import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.DataContainer;

import events.GameEvent;
import events.SceneEvent;

import feathers.controls.ImageLoader;

import flash.display.MovieClip;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.BlendMode;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.DrawManager;
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
import views.ChangeClothesScene;
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
import views.CoffeeShopScene;
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
import views.PreciousPhotosScene;
import views.PrivateIslandScene;
import views.ProfileScene;
import views.SettingsScene;
import views.RestaurantScene;
import views.ShoppingCentreScene;
import views.SportsBarScene;
import views.StarlingBattleScene;
import views.StoryPreview;
import views.TarotreadingScene;
import views.TempleScene;
import views.ThemedParkScene;
import views.MessagingScene;



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
    private var from:String;
    private var sceneObj:Object;
    private var scenebg:Sprite;
    public var battle_type:String;
    private var infobar:Boolean;
    private var gameInfoTween:Tween;
    private  var filtersMC:flash.display.MovieClip;
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
        mainstage.addEventListener(SceneEvent.CHANGED,onChangedScene);
        mainstage.addEventListener(SceneEvent.CLEARED,onClearedScene);
    }

    private function onChangedScene(e:Event):void
    {

        scene=ViewsContainer.MainScene;
        next_scene=e.data.name;
        from=e.data.from;
        flox.save("current_scene",next_scene);

        clearSceneHandle();


    }
    private function clearSceneHandle():void
    {

        var gameEvt:GameEvent=SimgirlsLovemore.gameEvent;
        gameEvt._name="remove_waving";
        gameEvt.displayHandler();

        try{
            Starling.current.nativeOverlay.removeChild(filtersMC);
            filtersMC=null;
        }catch(e:Error){
            DebugTrace.msg("Scene.changeSceneHandle removed filtersMC");
        }


        //onFadeoutComplete();

        var scentTween:Tween=new Tween(scene,0.5,Transitions.EASE_OUT);
        scentTween.fadeTo(0);
        scentTween.onComplete=onFadeoutComplete;
        Starling.juggler.add(scentTween);


    }

    private function changeSceneHandle():void
    {


        //var scene:Sprite=ViewsContainer.MainScene;
        if(ViewsContainer.InfoDataView)
            ViewsContainer.InfoDataView.visible=true;
        if(next_scene!="MenuScene" && next_scene!="ProfileScene" &&
                next_scene!="SettingsScene" &&  next_scene!="ContactsScene" &&
                next_scene!="CalendarScene" && next_scene!="PhotosScene" &&  next_scene!="PreciousPhotosScene" &&
                next_scene!="BattleScene" && next_scene!="ChangeFormationScene")
        {
            DataContainer.currentLabel=next_scene;
        }
        if(next_scene!="FoundSomeScene" && next_scene!="DatingScene" &&
                next_scene!="MenuScene" && next_scene!="ProfileScene" &&
                next_scene!="SettingsScene" &&  next_scene!="ContactsScene" && next_scene!="MessagingScene" &&
                next_scene!="CalendarScene" && next_scene!="PhotosScene" && next_scene!="PreciousPhotosScene" && next_scene!="ChangeClothesScene")
        {
            DataContainer.currentScene=next_scene;
        }
        DataContainer.shortcutsScene=next_scene;
        scene_container=new Sprite();
        scene_container.name="scene_container";
        scene.addChild(scene_container);

        ViewsContainer.SceneContainer=scene_container;

        DebugTrace.msg("Scenes.changeSceneHandle next_scene:"+next_scene);
        if(next_scene=="MainScene" || next_scene=="LoadMainScene")
        {

//            var drawmanager:DrawerInterface=new DrawManager();
//            scenebg=drawmanager.drawBackground();
//            scene_container.addChild(scenebg);


            filtersMC=new flash.display.MovieClip();
            filtersMC.name="waving";
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


        //current_scence=getScene(next_scene);
        infobar=true;
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
                infobar=true;
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
                //Selfies
                infobar=false;
                current_scence=new PhotosScene();
                break
            case "PreciousPhotosScene":
                infobar=false;
                current_scence=new PreciousPhotosScene();
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
                DataContainer.shoppingFrom="main";
                current_scence=new ShoppingCentreScene();
                break
            case "ShoppingCentreScene_fromlist":
                DataContainer.shoppingFrom="list";
                DataContainer.currentScene="ShoppingCentreScene";
                current_scence=new ShoppingCentreScene();
                break
            case "CinemaScene":
                current_scence=new CinemaScene();
                break
            case "PierScene":
                current_scence=new PierScene();
                break
            case "CoffeeShopScene":
                current_scence=new CoffeeShopScene();
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
            case "ChangeClothesScene":
                infobar=false;
                current_scence=new ChangeClothesScene();
                break
            case "StoryPreview":
                infobar=false;
                current_scence=new StoryPreview();
                break
            case "MessagingScene":
                infobar=false;
                current_scence=new MessagingScene();
                break

        }
        //switch

        scene.addChild(current_scence);
        var  gameInfobar:Sprite=ViewsContainer.InfoDataView;
        var UIViews:Sprite=ViewsContainer.UIViews;

        if(next_scene=="CharacterDesignScene" || SceneCommnad.scene=="Story"){
            return
        }else{

            mainstage.swapChildren(scene,UIViews);
            gameInfoTween=new Tween(gameInfobar,0.5,Transitions.EASE_IN_OUT_BACK);
            if(infobar){

                gameInfoTween.animate("y",-29);

            }else{

                gameInfoTween.animate("y",-(gameInfobar.height));

            }

            gameInfoTween.onComplete=onGameIngbarFadeinComplete;
            Starling.juggler.add(gameInfoTween);
        }


        //var shortcutsScene:String=DataContainer.shortcutsScene;
        if(next_scene.indexOf("Game")!=-1 || next_scene.indexOf("Battle")!=-1 ||
                next_scene=="DatingScene" || next_scene.indexOf("Formation")!=-1){
            //DebugTrace.msg("Scenes.changeSceneHandle addShortcuts shortcutsScene:"+shortcutsScene);
            command.removeShortcuts();
        }
        if(!from)
            command.addShortcuts();
        switch(from){
            case "battle":
            case "minigame":
            case "dating":
            case "story":
                command.addShortcuts();
                break

        }



        if(next_scene.indexOf("Game")==-1)
        {

            var currentScene:String = DataContainer.currentScene;
            var evtObj:Object = new Object();
            var scene_name:String=currentScene.split("Scene").join("");
            evtObj.name = scene_name;
            flox.logEvent("SceneVisited", evtObj);
        }

    }

    private function onGameIngbarFadeinComplete():void{

        Starling.juggler.removeTweens(gameInfoTween);
        DebugTrace.msg("Scene.onGameIngbarFadeinComplete infobar="+infobar);
        var UIViews:Sprite=ViewsContainer.UIViews;
        var gameInfobar:Sprite=ViewsContainer.gameinfo;
        if(infobar){
            gameInfobar.dispatchEventWith("DISPLAY");
            gameInfobar.dispatchEventWith("DRAW_PROFILE");
        }

        UIViews.visible=infobar;

    }
    private function onClearedScene(e:SceneEvent):void
    {

        clearSceneHandle();

    }
    private function onFadeoutComplete():void
    {
        Starling.juggler.removeTweens(scene);

        var mainstage:Sprite=ViewsContainer.MainStage;

        //if(scene_container)
        //{
        //DebugTrace.msg("Scenes.onFadeoutComplete:"+scene_container.numChildren);
        if(scenebg)
        {


            scenebg.removeFromParent(true);
            scenebg=null;
        }
        if(current_scence){
            current_scence.removeFromParent(true);
        }
        if(scene_container){
            scene_container.removeFromParent(true);
            scene_container=null;
        }

        scene.removeFromParent(true);
//            try{
//                scene.removeFromParent();
//            }catch(e:Error){
//                DebugTrace.msg("Scenes.onFadeoutComplete  remove scene Error");
//            }

        //new scene
        scene=new Sprite();
        scene_container=new Sprite();
        scene_container.name="scene_container";
        scene.addChild(scene_container);
        addChild(scene_container);
        ViewsContainer.MainScene=scene;
        mainstage.addChild(scene);


        //}

        changeSceneHandle();
        //flox.refreshSaveData(onRefreshComplete);


    }
    private function onRefreshComplete():void{

        changeSceneHandle();

    }
}
}