package views
{

import data.DataContainer;

import flash.geom.Point;

import controller.Assets;
import controller.AvatarCommand;
import controller.AvatarInterface;
import controller.FilterInterface;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import dragonBones.Armature;

import events.SceneEvent;
import events.TopViewEvent;

import model.SaveGame;
import model.Scenes;

import starling.animation.Transitions;
import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Button;
import starling.display.Image;
import starling.display.MovieClip;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.text.TextField;
import starling.textures.Texture;

import utils.DebugTrace;
import utils.FilterManager;
import utils.ViewsContainer;

public class ChangeFormationScene extends Scenes
{
    private var flox:FloxInterface=new FloxCommand();
    private var base_sprite:Sprite;
    private var command:MainInterface=new MainCommand();
    private var scencom:SceneInterface=new SceneCommnad();
    private var summary:Sprite;
    private var soldilers_name:Array;
    private var avatarcom:AvatarInterface=new AvatarCommand();
    private var avatar_pos:Array;
    private var substitues:Array;
    private var subs_armature:Array=new Array();
    private var avatars:Array=new Array();
    private var subsindex:uint=0;
    private var soldiers_tiles_pos:Array;
    private var gX:Number=0;
    private var gY:Number=0;
    private var currentTile:Image=null;
    private var tile_index:Number=0;
    private var currentAvatar:Sprite=null;
    private var combatpos:Array=[new Point(272,288),new Point(234,378),new Point(189,485),
        new Point(475,288),new Point(438,378),new Point(403,485)];
    private var avatarTween:Tween;
    private var combat_zone:Array;
    private var subs_soldiers_tiles:Array;
    private var successTween:Tween;
    private var per_combat_tile:MovieClip=null;
    private var hover_subs_title:MovieClip=null;
    //private var filtercom:FilterInterface=new FilterManager();
    private var layout_sprite:Sprite;
    private var tileImgs:Array=new Array();
    public function ChangeFormationScene()
    {

        ViewsContainer.AvatarShip=this;
        ViewsContainer.currentScene=this;
        base_sprite=new Sprite();
        addChild(base_sprite);


        command.playBackgroudSound("FormationMusic");

        init();
        initLayout();
        initSoldiersTiles();
        initCombatTiles();
        initSubstitues();
        initConfirm();
    }
    private function init():void
    {

        soldilers_name=new Array();
        var formation:Object=flox.getSaveData("se");
        var pts:Object=flox.getSaveData("pts");
        var reLv:Object=flox.getSyetemData("relationship_level");
        for(var name:String in formation)
        {
            if(formation[name]>0)
            {
                if(pts[name]>reLv["closefriend-Min"] || name=="player"){
                    soldilers_name.push(name);
                }


            }
        }
        DebugTrace.msg("ChangeFormationScene.init soldilers_name:"+soldilers_name)

    }
    private function initLayout():void
    {
        scencom.init("ChangeFormationScene",base_sprite,18,onCallback);
        scencom.start();



        var title:Image=new Image(getTexture("ChangeFormationTitle"));
        title.y=21;
        addChild(title);

        layout_sprite=new Sprite();
        layout_sprite.x=16;
        layout_sprite.y=80;
        addChild(layout_sprite);

//        var tween:Tween=new Tween(layout_sprite,0.5,Transitions.EASE_IN_ELASTIC);
//        tween.fadeTo(1);
//        tween.animate("x",16);
//        tween.onComplete=onSummaryComplete;
//        Starling.juggler.add(tween);

        var sum_firststr:String="Drag and drop one to five soldiers to the combat zone";
        var sum_first:TextField=new TextField(650,40,sum_firststr,"SimNeogreyMedium",18,0xFFFD38);
        sum_first.hAlign="left";
        layout_sprite.addChild(sum_first);


        //game zone
        var gamezone:Image=new Image(getTexture("CombatZone"));
        gamezone.x=94;
        gamezone.y=549;
        addChild(gamezone);

        //substitutes
        var substitutes:Image=new Image(getTexture("Substitutes"));
        substitutes.x=570;
        substitutes.y=663;
        addChild(substitutes);


    }
    private function onSummaryComplete():void
    {
        Starling.juggler.removeTweens(layout_sprite);
    }
    private function initSoldiersTiles():void
    {
        substitues=new Array();
        soldiers_tiles_pos=new Array();
        var lineX:Array=[724,686,650,613,575];
        var tilesMax:uint=10;
        var hline:uint=uint(tilesMax/2);
        var lastnode:Boolean=false;
        if(tilesMax%2>0)
        {
            hline++;
            lastnode=true;
        }
        for(var j:uint=0;j<hline;j++)
        {
            var vline:uint=2;
            if(j==hline-1)
            {
                if(lastnode)
                {
                    vline=1;
                }
                //if
            }
            //if
            for(var i:uint=0;i<vline;i++)
            {
                var tile:MovieClip=Assets.getDynamicAtlas("TileBlack");
                //var tile:Image=new Image(getTexture("SoldiersTile"));
                tile.name="soldiers_tile"+(i+j*2);
                tile.x=lineX[j]+i*(tile.width-40);
                tile.y=138+j*100;
                tile.alpha=0.6;
                var p:Point=new Point(tile.x,tile.y);
                soldiers_tiles_pos.push(p);
                substitues.push(tile);
                addChild(tile);
                tile.stop();
                Starling.juggler.add(tile);
            }
            //for
        }//for
        //for
    }
    private function initCombatTiles():void
    {
        combat_zone=new Array();
        subs_soldiers_tiles=new Array();
        var lineX:Array=[183,146,110,
            388,351,315];
        var tile_colors:Array=["Red","Blue"];
        for(var j:uint=0;j<tile_colors.length;j++)
        {
            for(var i:uint=0;i<3;i++)
            {
                var tile:MovieClip=Assets.getDynamicAtlas("Tile"+tile_colors[j]);
                //var tile:Image=new Image(getTexture("combar_"+tile_colors[j]+"Tile"));
                tile.name="combat_tile"+(i+j*3);
                tile.x=lineX[i+j*3];
                tile.y=245+i*100;
                tile.alpha=0.6;
                addChild(tile);
                tile.stop();
                Starling.juggler.add(tile);
                combat_zone.push(null);
                subs_soldiers_tiles.push(-1);
            }
            //for
        }
        //for


    }
    private function initSubstitues():void
    {
        var avatar:Object=flox.getSaveData("avatar");
        avatar_pos=[new Point(790,150),new Point(898,150),
            new Point(754,246),new Point(859,246),
            new Point(718,353),new Point(822,353),
            new Point(683,452),new Point(788,452),
            new Point(688,562),new Point(743,562)
        ];
        //DebugTrace.msg("ChangeFormationScene.initSubstitues soldilers name:"+ soldilers_name[subsindex])
        var avatar_attr:Object={"name":soldilers_name[subsindex],"side":-1,"pos":avatar_pos[subsindex],"gender":avatar.gender};
        DebugTrace.msg(JSON.stringify(avatar_attr));
        var items:Object=flox.getPlayerData("items");
        var _enable:Boolean=true;
        if(avatar_attr.name=="prms" || avatar_attr.name=="smn" ){
            if(avatar_attr.name=="prms")
            {
                _enable=items.bm_8.enable;
            }else{
                _enable=items.bm_9.enable;
            }

        }

        if(_enable){
            avatarcom.createAvatar(onReadyComplete,avatar_attr);
        }else{
            onReadyComplete();
        }



    }
    private function onReadyComplete():void
    {

        DebugTrace.msg("ChangeFormationScene.initSubstitues subsindex:"+subsindex);
        var avatar:Sprite=avatarcom.getAvatar();
        var armature:Armature=avatarcom.getArmaute();
        //var body:Bone = armature.getBone("body");
        subs_armature.push(armature);
        avatars.push(avatar);
        subsindex++;
        if(subsindex<soldilers_name.length)
        {
            initSubstitues()

        }
        else
        {
            initSubstituesTouchArea();
        }

    }
    private function initSubstituesTouchArea():void
    {

        this.addEventListener(TouchEvent.TOUCH,onTouchMovedHandler);
        for(var j:uint=0;j<soldilers_name.length;j++)
        {

            var tile:Image=new Image(getTexture("SoldiersTile"));
            tile.useHandCursor=true;
            tile.name="tile"+j;
            tile.x=soldiers_tiles_pos[j].x;
            tile.y=soldiers_tiles_pos[j].y;
            tile.alpha=0;
            addChild(tile);
            tileImgs.push(tile);
            tile.addEventListener(TouchEvent.TOUCH,onPickUpHandler);

        }
        //for

    }
    private function onTouchMovedHandler(e:TouchEvent):void
    {
        var target:Sprite=e.currentTarget as Sprite;
        var hover:Touch = e.getTouch(target, TouchPhase.HOVER);
        var moved:Touch = e.getTouch(target, TouchPhase.MOVED);
        var stationary:Touch = e.getTouch(target, TouchPhase.STATIONARY);
        //DebugTrace.msg("ChangeFormationScene.onTouchMovedHandler moved:"+moved);
        if(moved)
        {
            //keep mouse moving
            gX=moved.globalX;
            gY=moved.globalY;

            if(currentTile)
            {
                tile_index=Number(currentTile.name.split("tile").join(""));
                currentTile.x=gX;
                currentTile.y=gY;
                currentAvatar=avatars[tile_index];
                currentAvatar.x=gX;
                currentAvatar.y=gY;
                //DebugTrace.msg("ChangeFormationScene.onTouchMovedHandler  tile_index:"+tile_index);
                var combat_index:Number=checkCombatTile();
                //DebugTrace.msg("ChangeFormationScene.onTouchMovedHandler  combat_index:"+combat_index);
                removeCombatZone();
                if(combat_index!=-1)
                {
                    refalshCombatTiles();
                    per_combat_tile=this.getChildByName("combat_tile"+combat_index) as MovieClip;
                    per_combat_tile.play();


                }
                else
                {
                    if(per_combat_tile)
                    {
                        refalshCombatTiles();

                    }
                    //if
                }
                //if
            }
            //if


        }





    }

    private var _avatarTween:Tween;
    private function onPickUpHandler(e:TouchEvent):void
    {
        var target:Image=e.currentTarget as Image;
        //DebugTrace.msg("ChangeFormationScene.onTouchHandler target:"+target.name);
        var began:Touch = e.getTouch(target, TouchPhase.BEGAN);
        var ended:Touch = e.getTouch(target, TouchPhase.ENDED);
        var hover:Touch= e.getTouch(target, TouchPhase.HOVER);
        if(began)
        {

            currentTile=target;

            DebugTrace.msg("ChangeFormationScene.onPickUpHandler currentTile:"+currentTile.name);

        }
        else
        {
            //DebugTrace.msg("ChangeFormationScene.onPickUpHandler TouchPhase.BEGAN :"+began+" ; tile_index:"+tile_index);
            var combat_index:Number=checkCombatTile();
            if(currentTile)
            {
                if(combat_index==-1)
                {
                    //back to substitues line

                    tile_index=Number(currentTile.name.split("tile").join(""));
                    currentAvatar=avatars[tile_index];



                    currentAvatar.x=avatar_pos[tile_index].x;
                    currentAvatar.y=avatar_pos[tile_index].y;

                    currentTile.x=soldiers_tiles_pos[tile_index].x;
                    currentTile.y=soldiers_tiles_pos[tile_index].y;
                    //currentTile=null;
                    refalshCombatTiles();
                }
                //if
            }
            //if

        }
        if(ended)
        {
            //DebugTrace.msg("ChangeFormationScene.onPickUpHandler TouchPhase.ended :"+ended);
            if(currentAvatar)
            {
                currentTile.x=currentAvatar.x-currentTile.width/2-50;
                currentTile.y=currentAvatar.y-currentTile.height/2;
            }

            combat_index=checkCombatTile();

            avatarTween=new Tween(currentAvatar,0.5,Transitions.EASE_OUT);
            avatarTween.onComplete=onAvatarTweenComplete;

            if(combat_index==-1)
            {
                //back to substitues line
                avatarTween.moveTo(avatar_pos[tile_index].x,avatar_pos[tile_index].y);
                Starling.juggler.add(avatarTween);

                currentTile.x=soldiers_tiles_pos[tile_index].x;
                currentTile.y=soldiers_tiles_pos[tile_index].y;
                currentTile=null;

            }
            else
            {
                //success added to combat zone
                Starling.juggler.removeTweens(per_combat_tile);


                avatarTween.moveTo(combatpos[combat_index].x-20,combatpos[combat_index].y-40+20);
                Starling.juggler.add(avatarTween);

                var avatar_name:String=soldilers_name[tile_index];
                currentTile.x=combatpos[combat_index].x-currentTile.width/2;
                currentTile.y=combatpos[combat_index].y-currentTile.height/2;
                currentTile=null;

                var avatar_data:Object=new Object();
                avatar_data.name=avatar_name;
                avatar_data.substitutes=tile_index;
                avatar_data.combat=combat_index;
                combat_zone[combat_index]=avatar_data;
                subs_soldiers_tiles[combat_index]=tile_index;
                refalshCombatTiles();

            }
            //if

            DebugTrace.msg("ChangeFormationScene.onPickUpHandler ended");


            /*for(var k:uint=0;k<combat_zone.length;k++)
             {

             DebugTrace.msg("ChangeFormationScene.onPickUpHandler combat_zone:"+combat_zone[k]);
             }*/


        }
        //if
        if(hover)
        {


            var soldiers_tile_index:Number=Number(target.name.split("tile").join(""));
            hover_subs_title=this.getChildByName("soldiers_tile"+soldiers_tile_index) as MovieClip;


            if(subs_soldiers_tiles.indexOf(soldiers_tile_index)==-1)
            {
                hover_subs_title.play();
            }


        }
        else
        {
            reflashSubstitutesTiles();
        }

    }

    private function onAvatarTweenComplete():void
    {
        Starling.juggler.remove(avatarTween);

        currentAvatar=null;
    }

    private function checkCombatTile():Number
    {
        var radius:uint=40;
        //DebugTrace.msg("ChangeFormationScene.checkCombatTile  currentAvatar:"+currentAvatar);
        var index:Number=-1;
        if(currentAvatar)
        {
            for(var i:Number=0;i<combatpos.length;i++)
            {
                var pos:Point=combatpos[i];
                var rx:Number=Math.abs(currentAvatar.x-pos.x);
                var ry:Number=Math.abs(currentAvatar.y-pos.y);
                //DebugTrace.msg("ChangeFormationScene.checkCombatTile rx:"+rx+" ; ry:"+ry);
                if(rx<radius  && ry<radius)
                {

                    //DebugTrace.msg("ChangeFormationScene.checkCombatTile index:"+index);
                    index=i;
                    break

                }
                //if
            }
            //for
        }
        if(index!=-1)
        {
            //check hade been at combat zone
            var space:Boolean=true;
            var maximum:Boolean=true;
            var _data:Object=combat_zone[index];
            if(_data)
            {
                space=false;
            }
            var sum:Number=0;
            maximum=checkTeamMaxium();
            //DebugTrace.msg("ChangeFormationScene.checkCombatTile maximum:"+maximum);
            if(!space || !maximum)
            {
                index=-1;
            }
        }
        //if
        return index;

    }
    private var teamSum:Number=0;
    private function checkTeamMaxium():Boolean
    {
        var sum:uint=0;
        var maximum:Boolean=true;
        for(var j:uint=0;j<combat_zone.length;j++)
        {
            var _data:Object=combat_zone[j];
            if(_data)
            {
                sum++;
            }
            //if
        }
        //for
        if(sum==5)
        {
            //maxinum >1
            maximum=false;

        }
        //if
        teamSum=sum;
        return maximum
    }
    private function removeCombatZone():void
    {
        //drop up form combat zone
        for(var i:uint=0;i<combat_zone.length;i++)
        {
            if(combat_zone[i])
            {
                var subs_index:Number=combat_zone[i].substitutes;
                if(tile_index==subs_index)
                {
                    combat_zone[i]=null;
                    subs_soldiers_tiles[i]=-1;
                    break
                }
                //if
            }
            //if
        }
        //for


    }
    private function refalshCombatTiles():void
    {
        for(var k:uint=0;k<combat_zone.length;k++)
        {

            var combat_tile:MovieClip=this.getChildByName("combat_tile"+k) as MovieClip;

            combat_tile.stop();
        }
    }
    private function reflashSubstitutesTiles():void
    {

        for(var i:uint=0;i<soldilers_name.length;i++)
        {

            var tile:MovieClip=this.getChildByName("soldiers_tile"+i) as MovieClip;

            tile.stop();

        }


    }
    private function initConfirm():void
    {


        command.addedConfirmButton(this,doFinished);
        //command.addedCancelButton(this,doFinished);



    }
    private function doFinished(e:TouchEvent):void
    {
        var target:Image=e.currentTarget as Image;
        //DebugTrace.msg("CharacterDesignScene.doFinished target:"+target.name);

        var _data:Object=new Object();
        if(target.name=="confirm")
        {
            DebugTrace.obj("ChangeFormationScene doFinished combat_zone :"+JSON.stringify(combat_zone));

            checkTeamMaxium();

            if(teamSum>=1 && teamSum<=5)
            {

                command.stopBackgroudSound();
                removedHandler();
                flox.save("formation",combat_zone);

                _data.name= "BattleScene";
                command.sceneDispatch(SceneEvent.CHANGED,_data);

            }
            else
            {

                var msg:String="Drag and drop at least one soldier to the combat zone.";
                var alert:AlertMessage=new AlertMessage(msg);
                addChild(alert)

            }


        }
        else
        {
            //cancel

            //_data.removed="characterdesign_to_loadgame";
            //command.topviewDispatch(TopViewEvent.REMOVE,_data);

            _data.name= "SSCCArenaScene";
            command.sceneDispatch(SceneEvent.CHANGED,_data);
        }
        //if

    }
    private function getTexture(src:String):Texture
    {
        var textture:Texture=Assets.getTexture(src);
        return textture;
    }
    private function onCallback():void
    {
        scencom.disableAll();
    }
    private function doCannelHandler():void{

        var current_label:String= DataContainer.currentLabel;
        var _data:Object=new Object();
        _data.name= current_label;
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function removedHandler():void{


        for(var i:uint=0;i<substitues.length;i++){
            var subtile:MovieClip=substitues[i];
            subtile.removeFromParent(true);
        }
        for(var j:uint=0;j<avatars.length;j++){
            var avatar:Sprite=avatars[j];
            avatar.removeFromParent(true);
        }
        for(var k:uint=0;k<tileImgs.length;k++){
            var tile:Image=tileImgs[k];
            tile.removeFromParent(true);
        }
        layout_sprite.removeFromParent(true);
    }
}
}