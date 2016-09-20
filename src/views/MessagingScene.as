/**
 * Created by shawnhuang on 15-12-03.
 */
package views {
import controller.Assets;
import controller.MainCommand;
import controller.MainInterface;
import controller.SceneCommnad;
import controller.SceneInterface;

import events.SceneEvent;

import feathers.controls.Button;
import feathers.controls.List;
import feathers.controls.ScreenNavigator;
import feathers.controls.ScreenNavigatorItem;
import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextRenderer;
import feathers.data.ListCollection;
import feathers.layout.TiledRowsLayout;
import feathers.layout.VerticalLayout;
import feathers.motion.Cover;
import feathers.motion.Fade;
import feathers.motion.Slide;
import feathers.motion.Wipe;

import flash.geom.Point;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.text.TextFormat;


import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;

import utils.DebugTrace;

import utils.ViewsContainer;

public class MessagingScene extends Sprite{
    private var base_sprite:Sprite;
    private var scenecom:SceneInterface=new SceneCommnad();
    private var templete:MenuTemplate;
    private var font:String="SimMyriadPro";
    private var command:MainInterface=new MainCommand();
    private var hyperlink:String="https://storage.googleapis.com/lovemore/sim73.swf";
    private var vlayout:VerticalLayout;
    private var navigator:ScreenNavigator;
    public function MessagingScene() {


        super();

        base_sprite=new Sprite();
        addChild(base_sprite);
        ViewsContainer.currentScene=this;

        this.addEventListener("MESSAGE_NAV",navigateViewHandler);
        initailizeLayoutHandler();

    }
    private function navigateViewHandler(e:Event):void{

        DebugTrace.msg("MessagingScene.navigateViewHandler item_name="+ e.data.item_name);
        var view_name:String=e.data.item_name;
        if(view_name.indexOf("_")!=-1)
            view_name=e.data.item_name.split("_")[0];
        navigator.showScreen(view_name,Wipe.createWipeLeftTransition());

    }
    private function initailizeLayoutHandler():void{


        scenecom.init("ContactsScene",base_sprite,20);
        //messaging

        templete=new MenuTemplate();
        templete.font=font;
        templete.cate="MESSAGING";
        templete.label="MESSAGING";
        templete.addBackground();
        var attrs:Array=[{from:new Point(-420,110),to:new Point(-180,150)},
            {from:new Point(1440,150),to:new Point(1200,150)}];
        templete.backgroundEffectFadein(attrs);
        templete.addTitlebar(new Point(0,82));
        templete.addFooter();
        templete.addBackStepButton(doCannelHandler);
        templete.addTitleIcon({from:new Point(116,82),to:new Point(116,82)});
        templete.addMiniMenu();
        addChild(templete);

        var massaging:Sprite=new Sprite();
        massaging.x=253;
        massaging.y=179;


        var panelBg:Image=new Image(Assets.getTexture("ContactsPanelBg"));
        massaging.addChild(panelBg);



        var str1:String="My Main Mission in Shambala: \n1. Stay alive. Get prepared before the dangerous days marked on the calendar.\n" +
                "2. Reach the highest relationship level (soulmate) with my destined lover (twin flame) before the Valentine's Day.\n" +
                "3. Enter the SSCC Final. The SSCC will start in Jan 2034. The top two teams with most wins will enter the final at the end of Feb 2034.";

        str1+="\n\n\nRELATIONSHIP POINTS REQUIREMENT\nCLOSE FRIEND: 166 PTS\nDATING PARTNER: 1000 PTS\nLOVER: 3333 PTS\nSOULMATE: 6666 PTS";

        var message1:TextField=new TextField(panelBg.width-20,400,str1);
        message1.format.setTo(font,16,0,"left");
        message1.x=10;
        //message1.y=btn.y+btn.height+20;
        message1.y=20;
        //massaging.addChild(message1);


        navigator=new ScreenNavigator();
        navigator.height=panelBg.height;
        navigator.addScreen("MassageShare",new ScreenNavigatorItem(MessagingShare));
        navigator.addScreen("MassageShareList",new ScreenNavigatorItem(MessagingShareList));
        massaging.addChild( navigator );
        navigator.showScreen( "MassageShare" );


        addChild(massaging);



    }

    private function listChangeHandle(e:Event):void{
        var list:List = List( e.currentTarget );
        trace( "selectedIndex:", list.selectedIndex );
    }


    private function doClickDownload(e:Event):void{

        navigateToURL(new URLRequest(hyperlink));
    }

    private function doCannelHandler():void
    {

        var _data:Object=new Object();
        _data.name="MenuScene";
        command.sceneDispatch(SceneEvent.CHANGED,_data);

    }
    private function getItTextRender():ITextRenderer{
        var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
        textRenderer.textFormat = new TextFormat( font, 30, 0x000000 );
        textRenderer.embedFonts = true;
        return textRenderer;
    }

}
}
