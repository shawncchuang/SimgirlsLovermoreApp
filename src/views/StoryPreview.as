/**
 * Created by shawnhuang on 15-11-10.
 */
package views {
import com.greensock.loading.LoaderMax;
import com.shortybmc.data.parser.CSV;

import controller.Assets;
import controller.PreviewStoryCommand;
import controller.PreviewStoryInterface;


import events.TopViewEvent;


import flash.events.NativeDragEvent;
import flash.filesystem.File;
import flash.net.FileFilter;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.net.URLVariables;

import model.Scenes;

import services.LoaderRequest;
import starling.display.Button;

import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

import utils.DebugTrace;

import utils.ViewsContainer;

public class StoryPreview extends Scenes {

    private var storycom:PreviewStoryInterface=new PreviewStoryCommand();
    private var speaker_sprite:Sprite;
    // private var filepath:String="csv/main_story_scenes.csv";
    private var filepath:String="";
    private var main_story:CSV;

    public function StoryPreview() {

        DebugTrace.msg("StoryPreview.StoryPreview ");
        ViewsContainer.currentScene=this;
        this.addEventListener(TopViewEvent.REMOVE,doTopViewDispatch);

        speaker_sprite=new Sprite();
        addChild(speaker_sprite);


        var texture:Texture=Assets.getTexture("IncrementButton");
        var filebtn:Button=new Button(texture,"");
        filebtn.y=5;
        addChild(filebtn);
        filebtn.addEventListener(Event.TRIGGERED, onAdddFile);

        var arrowTxtr:Texture=Assets.getTexture("IconPrevBtn");
        var prevbtn:Button=new Button(arrowTxtr,"");
        prevbtn.name="previousbtn";
        prevbtn.scaleX=0.5;
        prevbtn.scaleY=0.5;
        prevbtn.x=filebtn.width+10;
        prevbtn.addEventListener(Event.TRIGGERED, doPrevStory);
        addChild(prevbtn);



    }
    private function onAdddFile(e:Event):void{

        var file:File = new File();
        var txtFilter:FileFilter = new FileFilter("CSV", "*.csv");
        file.browseForOpen("Open", [txtFilter]);
        file.addEventListener(Event.SELECT, dirSelected);
        file.browseForDirectory("Select a directory");
        function dirSelected(e:flash.events.Event):void {
            DebugTrace.msg(file.nativePath);
            if(file.nativePath){

                if(filepath!=""){
                    storycom.doClearAll();
                }
                filepath=file.url;
                initCSV();
            }
        }
    }
    private function initCSV():void{

//        main_story = new CSV();
//        main_story.addEventListener(Event.COMPLETE, onMainStoryComplete);
//        main_story.load(new URLRequest(filepath));

        var loaderReq:LoaderRequest=new LoaderRequest();
        loaderReq.URLLoaderHandle(filepath,onMainStoryComplete);

    }
    private function onMainStoryComplete(e:flash.events.Event):void {
//        var stories:Array = main_story.data;
//        for (var i:uint = 0; i < stories.length; i++) {
//
//
//            var story:Array = stories[i];
//            stories[i] = filterTalking(story);
//
//            //DebugTrace.msg("MainCommand.onMainStoryComplete story=" + filterTalking(story) + " ; length:" + story.length);
//        }
        var loader:URLLoader=URLLoader(e.target);
        var data:Array=loader.data.split(/\r\n|\n|\r/);
        var stories:Array=[];
        for(var i:uint=0;i<data.length;i++){
            data[i]=data[i].split(",");
        }

        for(var k:uint=0;k<data[0].length;k++){


            var story:Array=new Array();
            for(var j:uint=1;j<data.length;j++){
                var contnet:String=data[j][k];
                if(contnet!="") {
                    story.push(contnet);
                }

            }
            stories[k]=story;
        }

        //DebugTrace.msg("MainCommand.onMainStoryComplete stories="+JSON.stringify(stories));
        storycom.init(stories,"StoryPreview",speaker_sprite,0,onChatFinished);
        storycom.start();

    }
    private function doPrevStory(e:Event):void{

        if(filepath!=""){
            storycom.prevStoryStep();
        }
    }
    public function filterTalking(source:Array):Array {
        var sentances:Array = new Array();
        for (var i:uint = 0; i < source.length; i++) {
            var re:String = source[i];
            if (re.charAt(0) == '"') {
                var _re:String = re.split('"').join("");
                source[i] = _re
            }
            if (re.charAt(re.length - 1) == '"') {
                _re = re.split('"').join("");
                source[i] = _re;
            }
            if (source[i] != "") {
                sentances.push(source[i]);
            }
        }

        return sentances;
    }

    private function onChatFinished():void
    {


    }

    private function doTopViewDispatch(e:TopViewEvent):void
    {

        DebugTrace.msg("TarotreadingScene.doTopViewDispatch removed:"+e.data.removed);


    }
}
}
