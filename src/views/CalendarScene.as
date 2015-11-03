/**
 * Created by shawn on 2014-08-18.
 */
package views {
import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import events.SceneEvent;

import flash.geom.Point;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.Texture;

public class CalendarScene extends Sprite {

    private var base_sprite:Sprite;
    private var scencom:SceneInterface=new SceneCommnad();
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var command:MainInterface=new MainCommand();
    private var ymPanel:Sprite;
    private var current_year:String;
    private var current_month:String;
    private var current_date:String;
    private var current_day:String;
    private var flox:FloxInterface=new FloxCommand();
    private var ymTextAltas:TextureAtlas;
    private var ymImg:Image;
    private var monthImg:Image;

    public function CalendarScene():void{


        base_sprite=new Sprite();
        addChild(base_sprite);
        base_sprite.flatten();



        var dateData:String=flox.getSaveData("date");
        var _date:String=dateData.split("|")[0];
        current_year=_date.split(".")[3];
        current_month=_date.split(".")[2];
        current_date=_date.split(".")[1];
        current_day=_date.split(".")[0];

        initializeHandler();
        initializeLayout();
        initializeMonthBtns();

        updateCalendar();
    }
    private function initializeHandler():void{


        scencom.init("CalendarScene",base_sprite,20);


    }
    private function initializeLayout():void{


        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="CALENDAR";
        templete.label="CALENDAR";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-456,408),to:new Point(-146,408)},
            {from:new Point(1478,-108),to:new Point(1168,-108)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();
        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(115,85),to:new Point(115,85)});
        templete.addMiniMenu();
        addChild(templete);


        ymPanel=new Sprite();
        ymPanel.x=102;
        ymPanel.y=170;
        addChild(ymPanel);

        var ymbg:Image=new Image(Assets.getTexture("CalendarYMBg"));
        ymPanel.addChild(ymbg);

        var ymXML:XML=Assets.getAtalsXML("CalendarYMXML");
        var ymTexture:Texture=Assets.getTexture("CalendarYM");
        ymTextAltas=new TextureAtlas(ymTexture,ymXML);
        ymImg=new Image(ymTextAltas.getTexture(current_month.toLowerCase()));
        ymImg.x=12;
        ymImg.y=60;
        ymPanel.addChild(ymImg);



        var monthTexture:Texture=Assets.getTexture("Calendar"+current_month);
        monthImg=new Image(monthTexture);
        monthImg.x=310;
        monthImg.y=116;
        addChild(monthImg);

    }
    private function updateCalendar():void{


        ymImg.texture=ymTextAltas.getTexture(current_month.toLowerCase());
        monthImg.texture=Assets.getTexture("Calendar"+current_month);

    }

    private function initializeMonthBtns():void{

        var months:Array=["Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec","Jan","Feb"];

        for(var i:uint=0;i<months.length;i++){
            var monthBtn:Sprite=new Sprite();
            monthBtn.useHandCursor=true;
            monthBtn.name=months[i];
            var quad:Quad=new Quad(180,35,0x649CD3);
            quad.alpha=0;
            monthBtn.addChild(quad);
            if(i<10){
                monthBtn.y=i*(monthBtn.height+2)+60;
            }else{
                monthBtn.y=(i-10)*(monthBtn.height+2)+463;
            }
            ymPanel.addChild(monthBtn);
            monthBtn.addEventListener(TouchEvent.TOUCH, onTouchedMonthHandler);
        }

    }
    private function onTouchedMonthHandler(e:TouchEvent):void{
        var target:Sprite=e.currentTarget as Sprite;
        var began:Touch=e.getTouch(target,TouchPhase.BEGAN);

        if(began){
            trace(target.name);
            current_month=target.name;
            updateCalendar();
        }

    }

    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data)
    }

}
}
