/**
 * Created by shawn on 2014-08-06.
 */
package views {
import com.greensock.TweenMax;
import com.greensock.events.LoaderEvent;
import com.greensock.loading.LoaderMax;
import com.greensock.loading.SWFLoader;

import controller.FloxCommand;

import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.utils.Dictionary;

import events.SceneEvent;
import events.TopViewEvent;
import services.LoaderRequest;
import data.Config;
import utils.ViewsContainer;


import starling.display.Sprite;

public class RankBoard extends MovieClip{
    private var main:MovieClip;
    private var flox:FloxInterface=new FloxCommand();

    public function RankBoard() {

        initLayout();

    }
    private function initLayout():void{

        var service:LoaderRequest=new LoaderRequest();
        service.setLoaderQueue("rank","../swf/scoreboard.swf",this,onRankBoardComplete);


    }
    private function onRankBoardComplete(e:LoaderEvent):void
    {

        var swfloader:SWFLoader=LoaderMax.getLoader("rank");
        main=swfloader.getSWFChild("main") as MovieClip;
        main.addEventListener(MouseEvent.MOUSE_DOWN,doCloseRanking);
        setupTeams();
        setupRanking();


    }
    private function setupTeams():void{

        var current_battle:Object=flox.getSaveData("current_battle");
        var date:String=flox.getSaveData("date").split(".")[1];
        var month:String=flox.getSaveData("date").split(".")[2];
        var schedule:Dictionary=Config.battleSchedule();

        //month="Sep";
        //date="5";

        var dayStr:String=month+"_"+date;
        var games:Array=schedule[dayStr];
        var current_result:Array=current_battle[dayStr];


        if(games)
        {
            //have game today
            for(var i:uint=0;i<games.length;i++){

                var teams_index:Array=new Array();
                var tIndex1:String=String(games[i].split("|")[0]);
                var tIndex2:String=String(games[i].split("|")[1]);


                teams_index[0]=tIndex1;
                teams_index[1]=tIndex2;
                for(var j:uint=0;j<2;j++) {

                    var label:String=String(teams_index[j]);

                    if(label!="p"){

                        label="t"+label;
                    }
                    else
                    {
                        label="player";

                    }

                    TweenMax.to(main.board.screen.games["g"+i+"_"+j],0.5,{frameLabel:label});
                    TweenMax.to(main.board.screen.games["f"+i+"_"+j],0.5,{frameLabel:label});

                    var result:String=String(current_result[i].split("|")[j]);
                    if(result=="0" || result=="L"){
                        main.board.screen["g"+i+"_"+j].visible=false;
                    }


                }
            }


        }
        else{


            for(var k:uint=0;k<5;k++){

                for(var l:uint=0;l<2;l++){

                    main.board.screen.games["g"+k+"_"+l].visible=false;
                    main.board.screen.games["f"+k+"_"+l].visible=false;
                    main.board.screen["g"+k+"_"+l].visible=false;

                }

            }

        }

    }
    private function setupRanking():void{

        var rankings:Array=flox.getSaveData("ranking");
        rankings=rankings.sortOn("win",Array.DESCENDING | Array.NUMERIC);

        //trace("RankBoard.setuppRanking rankings="+JSON.stringify(rankings));

        for(var i:uint=0;i<rankings.length;i++){

            //var team_txt:TextField=main.board.screen.ranking["top"+i];
            var ranking_txt:TextField=new TextField();
            ranking_txt.selectable=false;
            ranking_txt.embedFonts=true;
            ranking_txt.defaultTextFormat=setTextFormat(i);
            ranking_txt.width=50;
            ranking_txt.height=30;
            ranking_txt.x=15;

            var team_txt:TextField=new TextField();
            team_txt.selectable=false;
            team_txt.embedFonts=true;
            team_txt.defaultTextFormat=setTextFormat(i);
            team_txt.width=240;
            team_txt.height=30;
            team_txt.x=68;

            var win_txt:TextField=new TextField();
            win_txt.selectable=false;
            win_txt.embedFonts=true;
            win_txt.defaultTextFormat=setTextFormat(i);
            win_txt.width=90;
            win_txt.height=30;
            win_txt.x=327;


            if(i<2)
            {
                var pos:Number=33;
            }
            else
            {
                pos=53;

            }
            var posY:Number=i*32+pos;
            team_txt.y=posY;
            team_txt.text=rankings[i].name;

            ranking_txt.y=posY;
            ranking_txt.text=String(i+1);

            win_txt.y=posY;
            win_txt.text="W-"+rankings[i].win;


            main.board.screen.ranking.addChild(team_txt);
            main.board.screen.ranking.addChild(ranking_txt);
            main.board.screen.ranking.addChild(win_txt);
        }

    }
    private function setTextFormat(index:uint):TextFormat{
        var format:TextFormat=new TextFormat();

        format.font="SimErbosDraco";
        format.size=25;
        switch(index){
            case 0:
                format.color=0x00FF00;
                break
            case 1:
                format.color=0xFFFF00;
                break
            default :
                format.color=0xFFFFFF;
                break
        }
        return format;
    }



    private function doCloseRanking(e:MouseEvent):void
    {

        TweenMax.to(main.board.screen,1,{frame:1});
        TweenMax.to(main.board,1,{frame:1,onComplete:onFadeoutComplete});
    }
    private function onFadeoutComplete():void
    {
        TweenMax.killAll();
        var command:MainInterface=new MainCommand();

        var _data:Object=new Object();
        _data.removed="Remove_Ranking";
        command.topviewDispatch(TopViewEvent.REMOVE,_data);


    }
}
}
