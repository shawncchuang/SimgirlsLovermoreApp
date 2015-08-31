package model
{
import controller.FloxCommand;
import controller.FloxInterface;

import data.Config;

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


    }
    public function praseRating():void {

        DebugTrace.msg("CusomAssets.praseRating");
        var characters:Array = Config.characters;
        var assetsSys:Object = flox.getSyetemData("assets");
        assets_rating = new Object();

        for (var i:uint = 0; i < characters.length; i++) {

            var saveAssets:Array = new Array();
            for (var id:String in assetsSys) {
                var assets:Object = new Object();

                assets.id = id;
                assets.rating = Math.floor(Math.random() * 200) + 1 - 100;
                saveAssets.push(assets);
            }
            assets_rating[characters[i]]=saveAssets;
        }


        flox.save("assets",assets_rating,onAssetsSaved);

    }
    private function onAssetsSaved(result:SaveGame):void{


        flox.save("unreleased_assets","");

    }
}
}