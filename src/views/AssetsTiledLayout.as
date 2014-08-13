/*
 * Created by shawn on 2014-08-11.
 */
package views {
import controller.Assets;

import feathers.controls.PanelScreen;

import feathers.layout.TiledRowsLayout;
import feathers.layout.TiledColumnsLayout;
import feathers.events.FeathersEventType;

import starling.display.Image;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;
import starling.textures.Texture;


public class AssetsTiledLayout extends PanelScreen{


    public function AssetsTiledLayout() {


        super();
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);


    }
    private function initializeHandler(e:Event):void{

        this.width=560;
        this.height=405;
        var layout:TiledColumnsLayout=new TiledColumnsLayout();
        layout.paging =TiledRowsLayout.PAGING_NONE;
        layout.horizontalGap =2;
        layout.verticalGap=2;
        layout.horizontalAlign=TiledRowsLayout.HORIZONTAL_ALIGN_LEFT;
        layout.verticalAlign=TiledRowsLayout.VERTICAL_ALIGN_TOP;
        layout.tileHorizontalAlign = TiledRowsLayout.TILE_HORIZONTAL_ALIGN_LEFT;
        layout.tileVerticalAlign = TiledRowsLayout.TILE_VERTICAL_ALIGN_TOP;
        layout.manageVisibility = true;

        this.layout = layout;
        //this.snapScrollPositionsToPixels = true;

        for(var i:uint=0;i<100;i++) {
            var icon:Sprite=new Sprite();
            var txt:TextField=new TextField(30,30,String(i+1),"Verdana",12,0,false);
            var itemTt:Texture = Assets.getTexture("Cons1_1");
            var img:Image = new Image(itemTt);

            icon.addChild(img);
            icon.addChild(txt);
            addChild(icon)
        }
    }
}
}
