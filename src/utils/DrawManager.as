package utils
{
import data.Config;

import feathers.controls.ImageLoader;

import flash.display.BitmapData;
import flash.display.Shape;
import flash.display3D.Context3D;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.ByteArray;

import controller.Assets;
import controller.DrawerInterface;
import controller.FilterInterface;
import controller.FloxCommand;
import controller.FloxInterface;

import data.DataContainer;

import dragonBones.Armature;
import dragonBones.Bone;
import dragonBones.animation.WorldClock;
import dragonBones.factorys.StarlingFactory;

import model.SaveGame;

import starling.core.RenderSupport;
import starling.core.Starling;
import starling.display.Canvas;
import starling.display.DisplayObject;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.Quad;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.events.Event;

import starling.textures.Texture;
import starling.textures.TextureAtlas;
import starling.textures.TextureSmoothing;
import starling.utils.Color;
import starling.utils.VertexData;

import utils.DebugTrace;

//import starling.utils.getNextPowerOfTwo;

public class DrawManager implements DrawerInterface
{

    private var target:*;
    private var bmpData:BitmapData;
    private var porperties:Object;
    private var gender:String;
    private var basemodel:Sprite;
    //private var body:MovieClip;
    public var body:Image;
    public var hair:Image;
    public var eyes:Image;
    public var pants:Image;
    public var clothes:Image;
    private var hairAtlas:TextureAtlas ;
    private var hairIndex:Number;
    private var pantsAtlas:TextureAtlas;
    private var clothesAtlas:TextureAtlas;
    private var featureAtlas:TextureAtlas;
    private var pantsIndex:Number;
    private var clothesIndex:Number;
    private var features:Image;
    private var featuresIndex:Number;
    private var onReadyComplete:Function;
    private var factory:StarlingFactory;
    private var armature:Armature;
    private var bonmodel:Object;
    private var bonbody:Bone;
    private var piechart:MovieClip;
    private var fIndex:Number=0;
    private var picchartImg:Image;
    private var result:Number=0;
    private var filter:FilterInterface=new FilterManager();
    private var bgloader:ImageLoader;
    private var bgSprite:Sprite;
    public function setSource(src:*):void
    {
        target=src

    }

    public function drawCircle(attr:Object):void
    {


        var shape:Shape = new Shape();
        shape.graphics.beginFill(attr.color);
        shape.graphics.drawCircle(attr.radius,attr.radius,attr.radius);
        shape.graphics.endFill();
        bmpData= new BitmapData(shape.width,shape.height, true, attr.color);
        bmpData.draw(shape);

    }
    public function getBitmapdata():BitmapData
    {
        return bmpData;

    }
    public function setBitmapPorperties(obj:Object):void
    {
        porperties=obj

    }

    public function copyAsBitmapData(sprite:DisplayObject,rec:Rectangle=null,point:Point=null):BitmapData
    {



        if ( sprite == null) {
            return null;
        }


        var rc:Rectangle = new Rectangle();
        sprite.getBounds(sprite, rc);

        //var context:Context3D = Starling.context;
        var scale:Number = Starling.contentScaleFactor;

        var nativeWidth:Number = Starling.current.stage.stageWidth;
        var nativeHeight:Number = Starling.current.stage.stageHeight;

        var rs:RenderSupport = new RenderSupport();
        rs.clear();
        //rs.setOrthographicProjection(0,0,nativeWidth, nativeHeight);
        rs.setProjectionMatrix(0,0,nativeWidth, nativeHeight);


        rs.translateMatrix(-rc.x, -rc.y); // move to 0,0
        sprite.render(rs,1);
        rs.finishQuadBatch();

        var returnBMPD:BitmapData = new BitmapData(rc.width, rc.height, true);

        Starling.context.drawToBitmapData(returnBMPD);

        return returnBMPD;



    }

    public function drawCharacter(model:Sprite=null,attr:Object=null):void
    {
        basemodel=model;
        var flox:FloxInterface=new FloxCommand();
        var avatar:Object=flox.getSaveData("avatar");
        gender=avatar.gender;

        var texture:Texture=Assets.getTexture(gender+"Body");
        body=new Image(texture);
        body.name="Skin";
        //body=Assets.getDynamicAtlas(gender+"Body");
        //body.smoothing=TextureSmoothing.TRILINEAR;

        var _color:Number=avatar.skincolor;
        body.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));

        basemodel.addChild(body);

        DebugTrace.msg("DrawManager.drawCharacter attr:"+JSON.stringify(avatar));
        if(attr.width && attr.height)
        {
            basemodel.width=attr.width;
            basemodel.height=attr.height;
        }
        else
        {
            basemodel.scaleX=attr.scaleX;
            basemodel.scaleY=attr.scaleY;
        }

    }
    private var lowercolor:Number=0;
    private var uppercolor:Number=0;
    public function updateBaseModel(target:String,avatar:Object=null):void
    {

        //var part:DisplayObject=basemodel.getChildByName(target);
        //DebugTrace.msg("DrawManager.updateBaseModel target:"+ target)
        // var savedata:SaveGame=FloxCommand.savegame;

        if(!avatar){
            var flox:FloxInterface=new FloxCommand();
            avatar=flox.getSaveData("avatar");

        }
        hairIndex=avatar.hairstyle;
        pantsIndex=avatar.pants;
        clothesIndex=avatar.clothes;
        featuresIndex=avatar.features;

        uppercolor=avatar.uppercolor;
        lowercolor=avatar.lowercolor;

        //DebugTrace.msg("DrawManager.updateBaseModel gender:"+ gender)
        //DebugTrace.msg("DrawManager.updateBaseModel featuresIndex:"+ featuresIndex)
        var pos:Point=switchPosition(target);
        var _color:Number;
        var xml:XML=new XML();
        switch(target)
        {
            case "Hair":

                var texture:Texture=Assets.getTexture(gender+"HairStyle");
                xml=Assets.getAtalsXML(gender+"HairStyleXML");
                hairAtlas = new TextureAtlas(texture, xml);
                var atlas_texture:Texture=hairAtlas.getTexture("hair"+hairIndex);
                hair=new Image(atlas_texture);
                hair.smoothing=TextureSmoothing.TRILINEAR;
                hair.name=target;
                hair.x=pos.x;
                hair.y=pos.y;
                _color=avatar.haircolor;
                hair.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
                basemodel.addChild(hair);
                break
            case "HairStyle":
                var hairTexture:Texture=hairAtlas.getTexture("hair"+hairIndex);
                hair.smoothing=TextureSmoothing.TRILINEAR;
                hair.texture=hairTexture;
                break
            case "Eyes":
                var eyes_texture:Texture=Assets.getTexture(gender+"Eyes");
                eyes=new Image(eyes_texture);
                eyes.smoothing=TextureSmoothing.TRILINEAR;
                eyes.name=target;
                eyes.x=pos.x;
                eyes.y=pos.y;
                _color=avatar.eyescolor;
                eyes.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
                basemodel.addChild(eyes);
                break
            case "Pants":
                var pants_texture:Texture=Assets.getTexture(gender+"PantsStyle");
                xml=Assets.getAtalsXML(gender+"PantsStyleXML");
                pantsAtlas=new TextureAtlas(pants_texture, xml);
                atlas_texture=pantsAtlas.getTexture("pants"+pantsIndex);
                pants=new Image(atlas_texture);
                pants.smoothing=TextureSmoothing.TRILINEAR;
                _color=lowercolor;
                pants.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
                pants.name=target;
                pants.x=pos.x;
                pants.y=pos.y;
                basemodel.addChild(pants);
                break
            case "LowerBodyStyle":
                var lowerStyle:Texture=pantsAtlas.getTexture("pants"+pantsIndex);
                pants.texture=lowerStyle;
                break
            case "Clothes":
                var clothes_texture:Texture=Assets.getTexture(gender+"Clothes");
                xml=Assets.getAtalsXML(gender+"ClothesXML");
                clothesAtlas=new TextureAtlas(clothes_texture, xml);
                atlas_texture=clothesAtlas.getTexture("clothes"+clothesIndex);
                clothes=new Image(atlas_texture);
                clothes.smoothing=TextureSmoothing.TRILINEAR;
                _color=uppercolor;
                clothes.color=Color.rgb(Color.getRed(_color),Color.getGreen(_color),Color.getBlue(_color));
                clothes.name=target;
                clothes.x=pos.x;
                clothes.y=pos.y;
                basemodel.addChild(clothes);
                break
            case "UpperBodyStyle":
                var upperStyle:Texture=clothesAtlas.getTexture("clothes"+clothesIndex);
                clothes.texture=upperStyle;
                break
            case "Features":
                var features_texture:Texture=Assets.getTexture(gender+"Features");
                xml=Assets.getAtalsXML(gender+"FeaturesXML");
                featureAtlas = new TextureAtlas(features_texture, xml);
                var featureTexture:Texture=featureAtlas.getTexture("features"+featuresIndex);
                features=new Image(featureTexture);
                features.smoothing=TextureSmoothing.TRILINEAR;
                features.name=target;
                features.x=pos.x;
                features.y=pos.y;
                basemodel.addChild(features);
                break
            case "FeaturesStyle":
                var featureStyleTexture:Texture=featureAtlas.getTexture("features"+featuresIndex);
                features.texture=featureStyleTexture;
                break
        }

        //switch




    }
//    public function updateModelColor(type:String,rgb:Object):void
//    {
//        var flox:FloxInterface=new FloxCommand();
//        var avatar:Object=flox.getSaveData("avatar");
//       // var savedata:SaveGame=FloxCommand.savegame;
//        var rgbObj:Object=rgb;
//        switch(type)
//        {
//            case "Hair":
//                hair.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
//                avatar.haircolor=hair.color;
//                break
//            case "Skin":
//                body.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
//                avatar.skincolor=body.color;
//                break
//            case "Eyes":
//                eyes.color=Color.rgb(rgbObj.r,rgbObj.g,rgbObj.b);
//                avatar.eyescolor=eyes.color;
//                break
//
//
//        }
//        //switch
//        flox.save("avatar",avatar);
//
//
//    }
    public function playerModelCopy(target:Sprite,pos:Point):void
    {

        //basemodel.clipRect=new Rectangle(0,-30,basemodel.width,540);
        //basemodel.x=pos.x;
        //basemodel.y=pos.y;
        target.addChild(basemodel);
        /*
         var bitmapdata:BitmapData=copyAsBitmapData(basemodel,new Rectangle(0,0,basemodel.width,basemodel.height),new Point(0,-50));
         var bmp:BitmapData=new BitmapData(basemodel.width,550);
         bmp.copyPixels(bitmapdata,new Rectangle(0,0,basemodel.width,550),new Point(0,0));

         var profileTexture:Texture = Texture.fromBitmapData(bmp);
         var _player_icon:Sprite=new Sprite();
         _player_icon.useHandCursor=true;
         _player_icon.name="Player";
         var img:Image=new Image(profileTexture);
         img.smoothing=TextureSmoothing.TRILINEAR;
         img.x=pos.x;
         img.y=pos.y;

         target.addChild(img);
         */


    }
    public function drawPlayerProfileIcon(target:Sprite,scale:Number,point:Point,bp:Point=null):void
    {

        //point:icon position ; bp: basemodel position
        var player_icon:Sprite=target;
        //player_icon.useHandCursor=true;
        var shapObj:Object=new Object()

        var rec:Rectangle=new Rectangle(-80,-22,100,100);
        var maskPoint:Point=new Point(133,72);
        if(gender=="Female")
        {
            rec=new Rectangle(-77,-9,100,100);
            maskPoint=new Point(130,59);
        }

        var texture:Texture=Assets.getTexture("ProEmpty");
        var bgImg:Image=new Image(texture);
        bgImg.pivotX=bgImg.width/2;
        bgImg.pivotY=bgImg.height/2;
        bgImg.width=rec.width;
        bgImg.height=rec.height;
        player_icon.addChild(bgImg);

//        var maskImg:Image=new Image(texture);
//        maskImg.width=rec.width;
//        maskImg.height=rec.height;

        if(!bp)
        {
            //basemodel.clipRect=new Rectangle(0,-50,150,150);
            basemodel.x=rec.x;
            basemodel.y=rec.y;
        }else{

            basemodel.x=bp.x;
            basemodel.y=bp.y;
        }
        basemodel.scaleX=0.96;
        basemodel.scaleY=0.96;


        //DebugTrace.msg("DrawManager.drawPlayerProfileIcon basemodel.width="+basemodel.width+" ,basemodel.height="+basemodel.height);
//        var maskedDisplayObject:PixelMaskDisplayObject = new PixelMaskDisplayObject(-1,false);
//        maskedDisplayObject.addChild(basemodel);
//        maskedDisplayObject.mask=maskImg;

//        maskedDisplayObject.x=-(player_icon.width/2);
//        maskedDisplayObject.y=-(player_icon.height/2);
//        player_icon.addChild(maskedDisplayObject);
        basemodel.pivotX=(player_icon.width/2);
        basemodel.pivotY=(player_icon.height/2);

        var maskQuad:Canvas = new Canvas();
        maskQuad.beginFill(0x000000);
        maskQuad.drawCircle(maskPoint.x,maskPoint.y,53);
        maskQuad.endFill();
        basemodel.mask=maskQuad;

        player_icon.addChild(basemodel);

        //DebugTrace.msg("DrawManager bgImg width:"+bgImg.width+" ;bgImg height:"+bgImg.height);

        player_icon.x=point.x;
        player_icon.y=point.y;

        //DebugTrace.msg("DrawManager.drawPlayerProfileIcon player_icon.width="+player_icon.width+" ,player_icon.height="+player_icon.height);
        ViewsContainer.PlayerProfile=player_icon;

    }
    public function drawCharacterProfileIcon(target:Sprite,ch:String,scale:Number):void
    {

        var texture:Texture=Assets.getTexture(ch+"Facials");
        var xml:XML=Assets.getAtalsXML(ch+"FacialsXML");
        var atlas:TextureAtlas=new TextureAtlas(texture,xml);
        var mood:String=DataContainer.getFacialMood(ch);
        DebugTrace.msg("DrawManager.drwaCharacterProfileIcon ch:"+ch+" ,mood:"+mood+" ,scale:"+scale);

        var mc:MovieClip=new MovieClip(atlas.getTextures(ch+"-"+mood),12);
        mc.stop();
        mc.useHandCursor=true;
        mc.name=ch.toLowerCase();
        mc.smoothing=TextureSmoothing.TRILINEAR;
        mc.pivotX=mc.width/2;
        mc.pivotY=mc.height/2;
        mc.scaleX=scale;
        mc.scaleY=scale;
        target.addChild(mc);


    }
    public function drawNPCProfileIcon(target:Sprite,id:String,scale:Number):void
    {
        var texture:Texture=Assets.getTexture("NPCs");
        var xml:XML=Assets.getAtalsXML("NPCsXML");
        var atlas:TextureAtlas=new TextureAtlas(texture,xml);
        var npc_texture:Texture=atlas.getTexture(id);
        DebugTrace.msg("DrawManager.drawNPCProfileIcon id:"+id);
        var img:Image=new Image(npc_texture);
        img.useHandCursor=true;
        img.name=id;
        img.smoothing=TextureSmoothing.TRILINEAR;
        img.pivotX=img.width/2;
        img.pivotY=img.height/2;
        img.scaleX=scale;
        img.scaleY=scale;
        target.addChild(img);
    }
    public function drawCircyleImage(target:Sprite):void
    {
        var bmpData:BitmapData = getBitmapdata();
        var circle_texture:Texture = Texture.fromBitmapData(bmpData);
        var circle:Image = new Image(circle_texture);
        circle.pivotX=circle.width/2;
        circle.pivotY=circle.height/2;
        target.addChild(circle)


    }
    public function drawDragonBon(info:Object,callback:Function=null):void
    {
        bonmodel=info;
        onReadyComplete=callback;
        var textTure:ByteArray=Assets.create(bonmodel.name) as ByteArray;
        factory = new StarlingFactory();
        factory.parseData(textTure);
        factory.addEventListener(flash.events.Event.COMPLETE,textureCompleteHandler)

    }
    private function textureCompleteHandler(e:flash.events.Event):void
    {


        armature = factory.buildArmature(bonmodel.name);
        var dispay_armature:Sprite = armature.display as Sprite;
        dispay_armature.x=bonmodel.pos.x;
        dispay_armature.y=bonmodel.pos.y;


        var ship:Sprite=bonmodel.container;
        ship.addChild(dispay_armature);
        armature.animation.gotoAndPlay(bonmodel.cate,-1,-1,null)


        //bonbody = armature.getBone("body");
        //bonbody.childArmature.animation.gotoAndPlay("ready")
        //arm = armature.getBone("armOutside");
        //arm.childArmature.addEventListener(FrameEvent.MOVEMENT_FRAME_EVENT, armFrameEventHandler);

        WorldClock.clock.add(armature);

        //ship.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
        onReadyComplete();
    }
    private function onEnterFrameHandler(e:EnterFrameEvent):void
    {


        WorldClock.clock.advanceTime(-1);

    }
    public function getBodyBon(target:String):Bone
    {

        bonbody = armature.getBone(target);
        return bonbody
    }
    private function switchPosition(part:String):Point
    {
        //
        var p:Point=new Point();
        var attr:String=gender+"_"+part;
        var pos:Object={
            "Male_Hair":new Point(69,-30),
            "Female_Hair":new Point(44,-21),
            "Male_HairStyle":new Point(223,-33),
            "Female_HairStyle":new Point(54,-39),
            "Male_Eyes":new Point(112,70),
            "Female_Eyes":new Point(108,59),
            //"Male_Pants":new Point(-2,401),
            "Male_Pants":new Point(-4,351.5),
            "Female_Pants":new Point(16,352),
            "Male_Clothes":new Point(-21,81),
            "Female_Clothes":new Point(7,117),
            "Male_Features":new Point(80,3),
            "Female_Features":new Point(30,-14)
        }
        p=pos[attr];
        return p;
    }
    public function drawPieChart(target:Sprite,texture:String):void
    {

        var xml_pie:XML=Assets.getAtalsXML(texture+"XML");
        var texture_pie:Texture=Assets.getTexture(texture);
        var atlas:TextureAtlas=new TextureAtlas(texture_pie,xml_pie);
        piechart=new MovieClip(atlas.getTextures("piechart"),30);
        piechart.pivotX=piechart.width/2;
        piechart.pivotY=piechart.height/2;
        piechart.stop();

        Starling.juggler.add(piechart);
        target.addChild(piechart);

        picchartImg=new Image(piechart.getFrameTexture(fIndex));
        picchartImg.pivotX=picchartImg.width/2;
        picchartImg.pivotY=picchartImg.height/2;

        target.addChild(picchartImg);

        //DebugTrace.msg("DrawManager.drawPieChart  picchartImg");
        //DebugTrace.obj(picchartImg);
    }
    private var pieMax:Number=9999;
    public function updatePieChart(value:Number):void
    {

        result=value;
        if(result>pieMax)
        {
            result=pieMax;
        }else if(result<-(pieMax))
        {
            result=-(pieMax);
        }
        //var dating:String=DataContainer.currentDating;
        //var savegame:SaveGame=FloxCommand.savegame;
        //fIndex=0;
        DebugTrace.msg("DrawManager.updatePieChart  result:"+result);
        var color:uint=0xFF66FF;
        //picchartImg.scaleX=1;
        if(result<0)
        {
            color=0x00FFFF;
            //picchartImg.scaleX=-1;
            result*=-1;
        }
        filter.setSource(picchartImg);
        filter.changeColor(color);
        //piechart.addEventListener(Event.ENTER_FRAME,doRenderPieEnterFrame);


        doRenderPieEnterFrame();
    }
    private function doRenderPieEnterFrame():void
    {

        var index:Number=Math.floor(Number((result/pieMax).toFixed(2))*100);
        if(index==100 || index==-100)
        {
            index=99;
        }
        DebugTrace.msg("DrawManager.doRenderPieEnterFrame  index:"+index);
        picchartImg.texture=piechart.getFrameTexture(index);
        if(fIndex==result)
        {

            //piechart.removeEventListener(Event.ENTER_FRAME,doRenderPieEnterFrame);

        }
        //if
    }
    public function drawBackground(src:String=null):Sprite
    {
        //backgound image or sprite
        var bgSrc:String=src;
        //var scene:String=DataContainer.currentScene;
        if(!src){
            src=DataContainer.currentScene;
        }
        DebugTrace.msg("DrawManager.drawBackground src="+src);
        //DebugTrace.msg("DrawManager.drawBackground  DataContainer.currentLabel="+DataContainer.currentLabel);
        var date:String="";
        if(src=="HomePageScene" || SimgirlsLovemore.previewStory){
            var playerInfo:Object=Config.PlayerAttributes();
            date=playerInfo.date;
        }else{
            var flox:FloxInterface=new FloxCommand();
            date=flox.getSaveData("date");

        }
        var time:String=date.split("|")[1];
        if(time=="12")
        {
            var _time:String="Day";
        }
        else
        {
            _time="Night";
        }

        var allDNScene:Array=Config.daynightScene;
        if(src){
            if(src.indexOf("Scene")!=-1)
                bgSrc=src.split("Scene").join("");
        }
        switch(bgSrc){
            case "ChangeFormation":
            case "CharacterDesign":
                bgSrc="Normal";
                break
            case "Dating":
                bgSrc=DataContainer.currentLabel.split("Scene").join("");
                break

        }
        if(target){
            bgSrc=target;
        }

        var scene_index:Number=allDNScene.indexOf(bgSrc);
        bgSrc+="Bg";
        if(scene_index!=-1){
            //scenes need day or night background
            bgSrc+=_time;
        }

        if(src.indexOf("Scene")==-1){

            bgSrc=src;
        }

        bgloader=new ImageLoader();
        bgloader.source="../images/scenes/"+bgSrc+".jpg";
        DebugTrace.msg("DrawManager.drawBackground  source:../images/scenes/"+bgSrc+".jpg");
        //var bgTexture:Texture=Assets.getTexture(bgSrc);
        //var bgImg:Image=new Image(bgTexture);
        var bgSprite:Sprite=new Sprite();
        bgSprite.addChild(bgloader);

        bgloader.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onBackgroundRemoved);
        return bgSprite

    }
    public function drawBackgroundgFroPreview(scene:String):Sprite{


        DebugTrace.msg("DrawManager.drawBackgroundgFroPreview scene="+scene);
        //DebugTrace.msg("DrawManager.drawBackground  DataContainer.currentLabel="+DataContainer.currentLabel);
        var playerInfo:Object=Config.PlayerAttributes();
        var date:String=playerInfo.date;

        var time:String=date.split("|")[1];
        if(time=="12")
        {
            var _time:String="Day";
        }
        else
        {
            _time="Night";
        }

        var allDNScene:Array=Config.daynightScene;

        var bgSrc:String=scene.split("Scene").join("");
        var scene_index:Number=allDNScene.indexOf(bgSrc);
        if(scene.indexOf("Scene")!=-1)
        {
            bgSrc+="Bg";
            if(scene_index!=-1){
                //scenes need day or night background
                bgSrc+=_time;
            }
        }

        bgloader=new ImageLoader();
        bgloader.source="../images/scenes/"+bgSrc+".jpg";
        DebugTrace.msg("DrawManager.drawBackgroundgFroPreview  source:../images/scenes/"+bgSrc+".jpg");
        //var bgTexture:Texture=Assets.getTexture(bgSrc);
        //var bgImg:Image=new Image(bgTexture);
        var bgSprite:Sprite=new Sprite();
        bgSprite.addChild(bgloader);

        bgloader.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, onBackgroundRemoved);
        return bgSprite


    }
    private function onBackgroundRemoved(e:starling.events.Event):void{
        //DebugTrace.msg("DrawManager.drawBackground  onBackgroundRemoved");
        bgloader.dispose();
        //bgSprite.removeFromParent(true);
    }

}
}