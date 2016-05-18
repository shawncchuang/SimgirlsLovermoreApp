package model
{
import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;
import data.DataContainer;

import utils.DebugTrace;


public class CusomAssets
{
    private var savegame:SaveGame;

    //private var positive:Number=0;
    //private var negative:Number=0;
    private var flox:FloxInterface=new FloxCommand();
    private var assets_rating:Object;



    public function CusomAssets()
    {
        var assetsSys:Object = flox.getSyetemData("assets");
        var assets_id:Array=new Array();
        for(var id:String in assetsSys){
            assets_id.push(id);
        }
        DataContainer.AssetsId=assets_id;

    }

    public function praseRating():void {

        DebugTrace.msg("CusomAssets.praseRating");
        var characters:Array = Config.datingCharacters;
        var assets_id:Array=DataContainer.AssetsId;

        assets_rating = new Object();
        for (var i:uint = 0; i < characters.length; i++) {

            var character:String=characters[i];
            var saveAssets:Array = setupRating();
            assets_rating[character]=saveAssets;
        }

        for(var chr:String in assets_rating){

            if(assets_rating[chr].length != assets_id.length){

                assets_rating[chr] = setupRating();
            }

        }

        flox.save("assets",assets_rating,onAssetsSaved);

    }
    private function setupRating():Array{

        var  assets_id:Array=DataContainer.AssetsId;
        var saveAssets:Array = new Array();
        for (var j:uint=0;j<assets_id.length;j++) {
            var ratingObj:Object = new Object();
            var rating:Number=Math.floor(Math.random() * 200) + 1 - 100;
            if(assets_id[j].indexOf("lx")!=-1){
                rating=100;
            }
            ratingObj[assets_id[j]]= rating;
            saveAssets.push(ratingObj);
        }
        return saveAssets;


    }
    private function onAssetsSaved():void{


        flox.save("unreleased_assets",{});

    }

    public function checkRatingAssets():void{

        var _assets_rating:Object=flox.getSaveData("assets");

        for(var chr:String in _assets_rating){

            if(_assets_rating[chr].length != _assets_rating.length){
                _assets_rating[chr] = setupRating();
            }

        }
        flox.save("assets",_assets_rating);

    }
}
}