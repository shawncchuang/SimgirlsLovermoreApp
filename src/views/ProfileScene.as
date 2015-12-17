package views
{

import controller.ViewCommand;
import controller.ViewInterface;

import flash.geom.Point;
import flash.geom.Rectangle;

import controller.Assets;
import controller.DrawerInterface;
import controller.FilterInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import data.Config;
import data.DataContainer;

import events.SceneEvent;

import model.SaveGame;
import model.Scenes;


import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;

import starling.text.TextField;
import starling.text.TextFieldAutoSize;
import starling.textures.Texture;

import utils.DebugTrace;

import utils.DrawManager;
import utils.FilterManager;
import utils.ViewsContainer;

public class ProfileScene extends Scenes
{
    private var flox:FloxInterface=new FloxCommand();
    private var scencom:SceneInterface=new SceneCommnad();
    private var command:MainInterface=new MainCommand();
    private var viewcom:ViewInterface=new ViewCommand();
    private var base_sprite:Sprite;
    private var panelbase:Sprite;
    private var panelProfile:Image;
    private var panelAssets:Image;
    private var panelSkills:Image;
    private var tagsname:Array=["person","assets","skills"];
    private var character:String="player";
    private var disablesObj:Object={
        "person":"0,205,410",
        "assets":"0,205,410",
        "skills":"0,205,410"
    }
    private var currentTag:String="person";
    private var tagshit:Sprite;
    private var tags:Array;
    //private var characters_name:Array=["Sao","Sirena","Tomoru","Zack","Lenus","Dea","Klaire","Ceil"];
    private var filtercom:FilterInterface=new FilterManager();
    private var drawcom:DrawerInterface=new DrawManager();
    private var chmodel:Sprite;
    private var basemodel:Sprite;
    private var player_icon:Sprite;
    private var nametile:TextField;
    private var ch_index:Number=-1;
    private static var ch_name:String="";

    private var personal:Sprite;
    private var assets:AssetsForm;
    private var excerptbox:Sprite;

    private var casshtext:TextField;
    private var assetsSymbols:Array;

    private var itemsindex:Number=0;
    private var giftsindex:Number=0;
    private var accindex:Number=0;
    private var estateindex:Number=0;

    private var skills:Sprite;
    private var cardlist:CardsList;
    private var cate:String="fire";
    //skills tag form arrow
    private var left_arrow:Button;
    private var right_arrow:Button;
    private var font:String="SimMyriadPro";
    private var skillexcbox:Sprite;
    public static var SKILL_EXC:String="skill_exc";

    private var templete:MenuTemplate;
    private var chbg:Image;
    public static function set CharacterName(str:String):void
    {
        ch_name=str;
    }
    public static function get CharacterName():String
    {
        return ch_name;
    }
    public function ProfileScene()
    {


        base_sprite=new Sprite();
        addChild(base_sprite);


        command.initStyleSchedule();

        initLayout();
        initBaseModel();
        initPanels();
        initPersonalData();
        initAsssetsData();
        initSkillsData();

        initProIcons();
        //initCancelHandle();

        this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedHandler);

    }
    private function initCancelHandle():void
    {
        //setup cancel button
        command.addedCancelButton(this,doCannelHandler);

    }
    private function doCannelHandler():void
    {


        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data)
    }
    private function initLayout():void
    {
        scencom.init("ProfileScene",base_sprite,22,onSceneReady);
        //scencom.start();
        //scencom.disableAll();

        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="PROFILE";
        templete.label="PROFILE";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-460,110),to:new Point(-150,110)},
            {from:new Point(1500,151),to:new Point(1170,410)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();
        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(116,82),to:new Point(116,82)});
        templete.addMiniMenu();
        addChild(templete);


    }
    private function initPanels():void
    {

        panelbase=new Sprite();
        panelbase.x=360;
        panelbase.y=159;
        addChild(panelbase);
        panelProfile=new Image(Assets.getTexture("PersonalInfo"));
        panelProfile.name="person";
        panelAssets=new Image(Assets.getTexture("AssetsInfo"));
        panelAssets.name="assets";
        panelAssets.visible=false;
        panelSkills=new Image(Assets.getTexture("SkillsInfo"));
        panelSkills.name="skills";
        panelSkills.visible=false;
        panelbase.addChild(panelProfile);
        panelbase.addChild(panelAssets);
        panelbase.addChild(panelSkills);


        //add tag hit area
        tagshit=new Sprite();
        tagshit.alpha=0;
        tags=new Array();
        for(var i:uint=0;i<3;i++)
        {
            var tagtexure:Texture=Assets.getTexture("Empty");
            var tagbtn:Button=new Button(tagtexure);
            tagbtn.name=tagsname[i];
            tagbtn.width=200;
            tagbtn.height=35;
            tagbtn.x=disablesObj[currentTag].split(",")[i];
            tagshit.addChild(tagbtn);
            panelbase.addChild(tagshit);
            tagbtn.addEventListener(Event.TRIGGERED,doChageedTag);
        }
        //for
        var first_tag:Button=tagshit.getChildByName(currentTag) as Button;
        first_tag.width=195;
        //set child index
        for(var j:uint=0;j<tagsname.length;j++)
        {
            var tag:Button=tagshit.getChildByName(tagsname[j]) as Button;
            var index:uint=tagshit.getChildIndex(tag);
            var tagObj:Object=new Object();
            tagObj.index=index;
            tagObj.tag=tag;
            tags.push(tagObj);
        }

    }
    private function onSceneReady():void
    {


    }

    private function doChageedTag(e:Event):void
    {
        var temp:Array=["person","assets","skills"];
        var target:Button=e.currentTarget as Button;
        currentTag=target.name;
        var top_target:Button=tagshit.getChildAt(2) as Button;
        // tagshit.swapChildren(target,top_target);
        //DebugTrace.msg("ProfileScene.doChageedTag tag target:"+target.name);
        //var top:uint=tags.sortOn("index");
        var disableX:Array=disablesObj[target.name].split(",");
        //DebugTrace.msg("ProfileScene.doChageedTag tag disableX:"+disableX);
        for(var i:uint=0;i<tags.length;i++)
        {
            // var tag:Button=tagshit.getChildByName(tagsname[i]) as Button;
            // tag.width=195;
            var panel:Image=panelbase.getChildByName(tagsname[i]) as Image;
            panel.visible=false;
        }


        panelProfile.visible=false;
        panelAssets.visible=false;
        panelSkills.visible=false;
        var current_panel:Image=panelbase.getChildByName(target.name) as Image;
        current_panel.visible=true;
        personal.visible=false;
        assets.visible=false;
        skills.visible=false;
        switch(target.name)
        {
            case "person":
                personal.visible=true;
                break
            case "assets":
                assets.visible=true;

                break
            case "skills":
                skills.visible=true;
                break
        }
        //switch

    }
    private var statusTxt:TextField;
    private var relTxt:TextField;
    private var relPointTxt:TextField;
    private var rankTxt:TextField;
    private var honorTxt:TextField;
    private var seTxt:TextField;
    private var loveTxt:TextField;
    private var intTxt:TextField;
    private var imgTxt:TextField;
    private function initPersonalData():void
    {

        personal=new Sprite();
        panelbase.addChild(personal);

        var format:Object=new Object();
        format.font=font;

        format.color=0x000000;


        format.size=30;
        statusTxt=addTextField(personal,new Rectangle(120,60,100,34),format);


        format.size=25;
        relTxt=addTextField(personal,new Rectangle(418,115,100,30),format);


        relPointTxt=addTextField(personal,new Rectangle(418,140,100,30),format);

        rankTxt=addTextField(personal,new Rectangle(418,197,100,30),format);

        honorTxt=addTextField(personal,new Rectangle(418,223,100,30),format);

        seTxt=addTextField(personal,new Rectangle(418,284,100,30),format);

        loveTxt=addTextField(personal,new Rectangle(418,306,100,30),format);

        intTxt=addTextField(personal,new Rectangle(418,371,100,30),format);

        imgTxt=addTextField(personal,new Rectangle(418,433,100,30),format);

        updateData();

    }
    private function addTextField(target:Sprite,rec:Rectangle,format:Object):TextField
    {

        var txt:TextField=new TextField(rec.width,rec.height,"",font,format.size,format.color);
        txt.hAlign="left";
        txt.vAlign="center";
        txt.autoSize=TextFieldAutoSize.HORIZONTAL;
        txt.x=rec.x;
        txt.y=rec.y;
        target.addChild(txt);

        return txt
    }
    private function updateData():void
    {


        var savedata:SaveGame=flox.getSaveData();
        var status:String=savedata.status;
        var rel:String=String(savedata.rel[character]);
        var rel_pts:String=String(savedata.pts[character]);
        var rank:String=savedata.rank;
        var honor:String=savedata.honor[character];
        var love:String=String(savedata.love[character]);
        var spt_eng:String=savedata.se[character]+"/"+love;

        var intStr:String=String(savedata.int[character]);
        var imgStr:String=String(savedata.image[character]);


        if(character!="player"){

            status=DataContainer.getFacialMood(character);

            if(status=="vhappy"){
                status="very happy";
            }

            status=status.toUpperCase();
        }

        statusTxt.text=status;
        relTxt.text=rel;
        relPointTxt.text=rel_pts;
        rankTxt.text=rank;
        honorTxt.text=honor;

        seTxt.text=spt_eng;
        loveTxt.text=love;
        intTxt.text=intStr;
        imgTxt.text=imgStr;

    }
    private function initAsssetsData():void
    {
        CharacterName="player";
        assets=new AssetsForm();
        assets.flatten();
        panelbase.addChild(assets);

        var _data:Object=new Object();
        _data.type="profile";
        assets.dispatchEventWith(AssetsForm.INILAIZE,false,_data);

        casshtext=assets.getChildByName("cash") as TextField;
        initAssetesForm();

        assets.visible=false;


    }

    private function initAssetesForm():void
    {

        assetsSymbols=new Array();

        itemsindex=0;
        giftsindex=0;
        accindex=0;
        estateindex=0;


        excerptbox=new ExcerptBox();
        excerptbox.x=-345;
        excerptbox.y=113;
        assets.addChild(excerptbox);
        ViewsContainer.ExcerptBox=excerptbox;
        //var savedata:SaveGame=FloxCommand.savegame;
        var chName:String;
        if(ch_index==-1)
        {
            //player cash
            chName="player";
            var cash:Number=flox.getSaveData("cash");
        }
        else
        {
            //other character cash
            chName=Config.characters[ch_index].toLowerCase();
            cash=flox.getSaveData("ch_cash")[chName];
            //var excerpt:Array=savedata.assets[chName];

        }
        CharacterName=chName;
        casshtext.text=DataContainer.currencyFormat(cash);


    }

    private function updateAssets():void
    {


        var _data:Object=new Object();
        _data.chname=character;
        assets.dispatchEventWith(AssetsForm.UPDATE,false,_data);
        excerptbox.removeFromParent(true);

        initAssetesForm();

    }

    private function initProIcons():void
    {


        this.addEventListener("TouchedIcon",onTouchCharaterIcon);
        viewcom.characterIcons(this);


    }
    private function onTouchCharaterIcon(e:Event):void
    {

        DebugTrace.msg("ProfileScene onTouchCharaterIcon");
        ch_index=e.data.ch_index;
        character=e.data.character;
        updateData();
        updateCharacter();
        updateAssets();
        updateSkills();


    }
    private function updateSkills():void
    {
        cate="fire";
        skills.removeFromParent(true);
        panelbase.removeChild(skills);
        initSkillsData();

    }
    private function initSkillsData():void
    {
        //skills tag

        skills=new Sprite();
        skills.addEventListener("ToucbedSkillIcon",onTriggeredElements);
        panelbase.addChild(skills);

        viewcom.skillIcons(skills);
        initCardsList();



        if(currentTag!="skills")
        {
            skills.visible=false;
        }
        //if

        var skillPts:Object=flox.getSaveData("skillPts");
        var spTxt:TextField=new TextField(70,24,String(skillPts[character]),font,20);
        spTxt.vAlign="center";
        spTxt.x=198;
        spTxt.y=62;
        skills.addChild(spTxt);


        skillexcbox=new ExcerptBox();
        skillexcbox.x=-345;
        skillexcbox.y=113;
        skills.addChild(skillexcbox);
        ViewsContainer.SkillExcerptBox=skillexcbox;
    }

    private function onTriggeredElements(e:Event):void
    {

        cate=e.data.cate;
        cardlist.removeFromParent(true);
        initCardsList();


    }
    private function initCardsList():void
    {


        cardlist=new CardsList();
        cardlist.flatten();
        cardlist.character=character;
        cardlist.from="profile";
        cardlist.cate=cate;
        cardlist.x=50;
        cardlist.y=120;
        skills.addChild(cardlist);
        cardlist.dispatchEventWith(CardsList.INIT);


    }
    private function initBaseModel():void
    {



        basemodel=new Sprite();
        addChild(basemodel);


        //other character
        chmodel=new Sprite();
        chmodel.clipRect=new Rectangle(0,0,356,540);
        chmodel.x=5;
        chmodel.y=120;
        addChild(chmodel);


        var params:Object=new Object();
        var gender:String=flox.getSaveData("avatar").gender;
        var _point:Point=new Point(54,180);
        if(gender=="Female"){
            _point=new Point(64,227);
        }
        params.pos=_point;
        params.clipRect=new Rectangle(0,-30,276,500);
        viewcom.fullSizeCharacter(basemodel,params);




    }
    private function updateCharacter():void
    {
        basemodel.visible=false;
        chmodel.visible=true;

        if(ch_index==-1)
        {
            basemodel.visible=true;
            chmodel.visible=false;
        }
        else
        {


            viewcom.replaceCharacter(chmodel);

        }


    }
    private function onRemovedHandler(e:Event):void{
        templete.removeFromParent(true);
        chmodel.removeFromParent(true);
        basemodel.removeFromParent(true);
        panelbase.removeFromParent(true);
        skills.removeFromParent(true);
        viewcom.removedCharacterIcons();
    }

}
}