/**
 * Created by shawnhuang on 15-08-20.
 */
package views {

import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.Assets;
import controller.MainInterface;

import data.Config;

import data.DataContainer;

import feathers.controls.ImageLoader;
import feathers.controls.Label;

import feathers.controls.PanelScreen;
import feathers.controls.List;
import feathers.controls.renderers.BaseDefaultItemRenderer;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;
import feathers.layout.AnchorLayout;
import feathers.layout.AnchorLayoutData;
import feathers.text.BitmapFontTextFormat;

import flash.text.TextFormat;


import starling.events.Event;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

import utils.DebugTrace;


public class ContactsSheet extends PanelScreen {
    private var assetsData:Object;
    private var flox:FloxInterface=new FloxCommand();
    private var command:MainInterface=new MainCommand();

    public function ContactsSheet() {

        this.height=532;

        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
    }
    private function initializeHandler(e:Event):void
    {
        assetsData=flox.getSaveData("rel");
        command.initCharacterLocation("all_scene");
        var relationlevel:Object=flox.getSyetemData("relationship_level");
        var locations:Array=DataContainer.CharacherLocation;
        var arrivedChStr:String=JSON.stringify(locations);
        //DebugTrace.msg("ContactsSheet.initializeHandler arrivedChStr:"+arrivedChStr);
        var contacts:Array=new Array();
        for(var name:String in assetsData)
        {
            var rel:String=assetsData[name];
            var pts:Number=flox.getSaveData("pts")[name];
            var request_pts_min:Number=relationlevel["closefriend-Min"];
            if(pts>=request_pts_min)
            {
                for(var i:uint=0;i<locations.length;i++){
                    var chloc:Object=locations[i];
                    if(chloc.name==name){
                        contacts.push(chloc);
                    }
                }

            }
        }
        var contactsStr:String=JSON.stringify(contacts);
        DebugTrace.msg("ContactsSheet.initializeHandler contactsStr:"+contactsStr);


        var contactlist:List= new List();
        //contactlist.itemRendererProperties.labelField = "text";
        //contactlist.itemRendererProperties.iconSourceField = "thumbnail";
        //contactlist.embedFonts=true;

        contactlist.itemRendererFactory= function ():IListItemRenderer{

            var renderer:DefaultListItemRenderer=new DefaultListItemRenderer();
            //renderer.layoutOrder=BaseDefaultItemRenderer.DEFAULT_CHILD_NAME_ICON_LABEL;
            renderer.gap = 5;

            renderer.iconLoaderFactory=function():ImageLoader{
                var loader:ImageLoader = new ImageLoader();
                loader.width=80;
                loader.height=80;
                return loader;
            }
            renderer.labelFactory=function():ITextRenderer{
                var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
                textRenderer.pivotY=-20;
                textRenderer.setSize(250,80);
                textRenderer.textFormat=new TextFormat("SimMyriadPro",16,0x333333,null,null,null,null,null,null,10);
                textRenderer.embedFonts=true;
                return textRenderer;
            }
            renderer.labelField="text";
            renderer.iconSourceField = "thumbnail";

            return renderer;

        };
        contactlist.width=506;
        contactlist.height=523;
        addChild(contactlist);

        var _data:Array=new Array();
        for(var i:uint=0;i<contacts.length;i++)
        {
            var renderObj:Object=new Object();
            renderObj.text=contacts[i].name+"\nLocation: "+contacts[i].location;

            var xml:XML=Assets.getAtalsXML(contacts[i].name+"FacialsXML");
            var textrue:Texture=Assets.getTexture(contacts[i].name+"Facials");
            var textureAtlas:TextureAtlas=new TextureAtlas(textrue,xml);
            var _texture:Texture=textureAtlas.getTexture(contacts[i].name+"-pleased1");
            renderObj.thumbnail=_texture;
            _data.push(renderObj);
        }


        var contactsCollectoin:ListCollection= new ListCollection(_data);
        contactlist.dataProvider=contactsCollectoin;

    }
}
}
