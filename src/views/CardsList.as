package views
{
import flash.geom.Point;
import flash.geom.Rectangle;

import mx.utils.NameUtil;

import controller.Assets;
import controller.DrawerInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import model.SaveGame;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;

import utils.DebugTrace;
import utils.DrawManager;
import utils.ViewsContainer;

public class CardsList extends Sprite
{
    private var cardSize:Rectangle=new Rectangle(0,0,140,160);
    //private var _data:Object;
    public var character:String;
    public var cate:String;
    //from :"profile" ,"store"
    public var from:String;
    private var skillPts:Object;
    private var skills:Object;
    public static var CHANGE:String="_change";
    public static var INIT:String="_init";
    private var drawcom:DrawerInterface=new DrawManager();
    private var command:MainInterface=new MainCommand();
    private var flox:FloxInterface=new FloxCommand();
    private var skillscards:Array=new Array();
    private var cardslist:Sprite;
    private var listTotal:Number=0;
    private var cards_index:Number=0;
    private var cards_no:Number=0;
    //list tatol page
    private var pages:Number=0;
    private var now_page:Number=0;
    //per page  cards max number
    private var pageMax:Number=6;
    //current page card number
    private var pageNum:Number=0;
    private var vertical:Number=0;
    private var horizontal:Number=0;
    private var cardAtlas:TextureAtlas;
    private var cardinfo:Object;
    private var unlockSkill:Object=new Object();
    private var cards:Array;
    public function CardsList()
    {


        this.addEventListener(CardsList.INIT,onCardsListInit);
    }
    private function onCardsListInit(e:Event):void
    {

        DebugTrace.msg("CardsList.onCardsListInit character="+character+", cate="+cate+" , from="+from);


        skillPts=flox.getSaveData("skillPts");
        skills=flox.getSaveData("skills");


        var ele:String=cate.charAt(0);
        for(var i:uint=0;i<4;i++)
        {
            var skillID:String=ele+i;
            skillscards.push(skillID);
        }

        listTotal=skillscards.length;
        pages=uint(listTotal/pageMax);
        if(listTotal%pageMax>0)
        {
            pages++;
        }

        var texture:Texture=Assets.getTexture("SkillCards");
        var xml:XML=Assets.getAtalsXML("SkillCardsXML");
        cardAtlas = new TextureAtlas(texture, xml);


        cards=new Array();
        cardslist=new Sprite();
        addChild(cardslist);


        initCards();
        this.addEventListener(CardsList.CHANGE,doCardsListChanged);



    }
    private function initCards():void
    {



        DebugTrace.msg("CardsList.initCards now_page:"+now_page);

        cardinfo=new Object()
        cardinfo.cate=cate;
        cardinfo.name="SkillsCards";
        cardinfo.container=cardslist;


        if(listTotal%pageMax>0)
        {
            if(now_page<pages-1)
            {
                pageNum=pageMax;
            }
            else
            {

                pageNum=listTotal%pageMax

            }
        }
        else
        {
            pageNum=pageMax;

        }

        //DebugTrace.msg("CardsList.initCards listTotal:"+listTotal+"; pageNum:"+pageNum+" ;cards_index:"+cards_index);

        //DebugTrace.msg("CardsList.initCards vertical:"+vertical+"; horizontal:"+horizontal);
        var posX:Number=vertical*180
        var posY:Number=horizontal*180;
        cardinfo[skillscards[cards_index]]=new Point(posX,posY);

        onCardReady();


    }

    private function onCardReady():void
    {

        var last_index:Number=pageNum+now_page*pageMax-1;
        var skills_enabled:Array=skills[character][cate].split(",");
        if(cards_index<=last_index)
        {
            //DebugTrace.msg("CardsList.onCardReady BodyBone:"+cate+"face");
           // DebugTrace.msg("CardsList.onCardReady card:"+skillscards[cards_index]);
            var skillID:String=skillscards[cards_index]
            var cardTexture:Texture=cardAtlas.getTexture(skillID);
            var card:Image=new Image(cardTexture);
            //var card:Button=new Button(cardTexture);
            card.name=skillID;
            card.width=cardSize.width;
            card.height=cardSize.height;
            card.x=cardinfo[skillID].x;
            card.y=cardinfo[skillID].y;
            cards.push(card);
            cardslist.addChild(card);
            card.addEventListener(TouchEvent.TOUCH,doSkillCardTiggered);

            if(from=="store")
            {
                //DebugTrace.msg("CardsList.onCardReady skills_enabled:"+skills_enabled);
                //DebugTrace.msg("CardsList.onCardReady skillID:"+skillID);
                var index:Number=skills_enabled.indexOf(skillID);
                if(index==-1 || skills[character][cate]=="")
                {

                    lockSkillHandle(cards_index,skillID);

                }
                //if

            }
            //if
            cards_index++;
            vertical++;


            if(vertical==3)
            {
                vertical=0;
                horizontal=1;
            }

            initCards();


        }
        else
        {

            DebugTrace.msg("CardsList onCardReady")

            if(from!="store"){
                //control disable skill card

                for(var i:uint=0;i<cards.length;i++){
                    cards[i].visible=false;
                }

                for(var j:uint=0;j<skills_enabled.length;j++){
                    cards[j].visible=true;
                }

            }


        }
        //if
    }
    private function lockSkillHandle(index:Number,skillID:String):void
    {
        DebugTrace.msg("CardsList.lockSkillHandle skillID="+skillID)
        var locksprite:Sprite=new Sprite();
        locksprite.name=skillID
        locksprite.x=cardinfo[skillID].x;
        locksprite.y=cardinfo[skillID].y;
        cardslist.addChild(locksprite);

        var lockTexture:Texture=Assets.getTexture("SkillLocked");
        var skilllocked:Image=new Image(lockTexture);
        skilllocked.width=cardSize.width;
        skilllocked.height=cardSize.height;
        locksprite.addChild(skilllocked);


        var icontexture:Texture=Assets.getTexture("SkillPtsIcon");
        var skillptsicon:Image=new Image(icontexture);
        skillptsicon.x=110;
        skillptsicon.y=-15;
        locksprite.addChild(skillptsicon);


        var spend_spts:TextField=new TextField(50,28,"","SimNeogreyMedium",20,0x000000,true);
        spend_spts.x=110;
        spend_spts.y=-4;
        spend_spts.hAlign="center";
        var rate:Number=20;
        if(character=="player")
        {
            var s_ele:String=flox.getSaveData("s_ele");
            if(cate==s_ele)
            {
                //expert with this cate
                rate=10;
            }
            else if(cate.charAt(0)=="n")
            {
                rate=60;
            }
            //if
            //if
        }
        else
        {

            var expert:String=skills[character].exp;
            if(cate.charAt(0)==expert)
            {
                //expert with this cate

                rate=10;
            }
            else if(cate.charAt(0)=="n")
            {
                rate=60;
            }
            //if
        }
        //if
        var unlockPts:Number=(index+1)*rate
        unlockSkill[skillscards[index]]=unlockPts;
        spend_spts.text=String(unlockPts);
        locksprite.addChild(spend_spts);
        locksprite.addEventListener(TouchEvent.TOUCH,onTouchlockSkill);


    }

    private var lockTween:Tween;
    private var currentSkill:Sprite;
    private var alertmsg:Sprite;
    private function onTouchlockSkill(e:TouchEvent):void
    {
        currentSkill=e.currentTarget as Sprite;
        var began:Touch=e.getTouch(currentSkill,TouchPhase.BEGAN);
        var skillStore:Sprite=ViewsContainer.SkillStore;
        if(began)
        {

            var sPts:Number=skillPts[character];
            var unlockPts:Number=unlockSkill[currentSkill.name];

            DebugTrace.msg("CardsList onTouchlockSkill unlockPts="+unlockPts+" , sPts="+sPts+" , skill="+currentSkill.name);

            if(unlockPts<=sPts)
            {
                alertmsg=new AlertMessage(msg)
                alertmsg.alpha=0;
                skillStore.addChild(alertmsg);

                currentSkill.removeEventListener(TouchEvent.TOUCH,onTouchlockSkill);

                lockTween=new Tween(currentSkill,0.1);
                lockTween.animate("alpha",0);
                lockTween.onComplete=unlockSkillHandle;
                Starling.juggler.add(lockTween);


                sPts-=unlockPts;
                skillPts[character]=sPts;

                if(skills[character][cate].indexOf(",")==-1)
                {

                    var skilllist:Array=new Array();
                    if(skills[character][cate]!="")
                    {
                        //only one skill
                        skilllist.push(skills[character][cate])
                    }
                }
                else
                {
                    skilllist=skills[character][cate].split(",");
                }
                if(skilllist.indexOf(currentSkill.name)==-1)
                {
                    skilllist.push(currentSkill.name);
                }
                skilllist.sort(Array.CASEINSENSITIVE);
                skills[character][cate]=skilllist.toString();

                flox.save("skills",skills,onSaveSkillsComplete);
                function onSaveSkillsComplete(result:SaveGame):void
                {
                    DebugTrace.msg("CardsList.onTouchlockSkill  onSaveSkillsComplete");

                    flox.save("skillPts",skillPts,onSavedSkillPts);

                }
                function onSavedSkillPts(result:SaveGame):void
                {
                    DebugTrace.msg("CardsList.onTouchlockSkill  onSavedSkillPts");
                    var re:Object=new Object();
                    re.skillpts=sPts;
                    skillStore.dispatchEventWith(SkillsStore.UPDATE_SKILLPTS,false,re);

                    skillStore.removeChild(alertmsg);
                }
            }
            else
            {
                var msg:String="You need more Skill Points.";
                var alertmsg:Sprite=new AlertMessage(msg);

                skillStore.addChild(alertmsg);

            }
        }

    }
    private function unlockSkillHandle():void
    {
        Starling.juggler.removeTweens(lockTween);
        cardslist.removeChild(currentSkill);

    }
    private function doSkillCardTiggered(e:TouchEvent):void
    {
        var target:Image=e.currentTarget as Image;
        var hover:Touch=e.getTouch(target,TouchPhase.HOVER);
        var excbox:Sprite=ViewsContainer.SkillExcerptBox;

       // DebugTrace.msg("CardsList.doSkillCardTiggered hover="+hover+" ,skill="+target.name);
        if(hover)
        {
            var _data:Object=new Object();
            _data.type="skill_card";
            _data.skill=target.name;
            excbox.dispatchEventWith("UPDATE",false,_data);

        }
        else
        {

            excbox.dispatchEventWith("CLEAR");

        }



    }
    private function doCardsListChanged(e:Event):void
    {
        var left_arrow:Button=e.data.left_arrow;
        var right_arrow:Button=e.data.right_arrow;
        DebugTrace.msg("CardsList.doCardsListChanged:"+e.data.dir);
        var change:Boolean;
        if(e.data.dir=="left")
        {
            now_page--;
            change=true;
            if(now_page<0)
            {
                now_page=0;
                change=false;
            }
        }
        else
        {
            //right
            now_page++;
            change=true;
            if(now_page>pages-1)
            {
                now_page=pages-1;
                change=false;
            }
        }
        //if
        command.listArrowEnabled(now_page,pages,left_arrow,right_arrow);
        if(change)
        {
            cards_index=now_page*pageMax;
            DebugTrace.msg("CardsList.doCardsListChanged now_page:"+now_page);
            cardslist.removeFromParent(true);
            vertical=0;
            horizontal=0;
            cardslist=new Sprite();
            addChild(cardslist);
            initCards();
        }
    }
}
}