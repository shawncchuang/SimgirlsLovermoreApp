/**
 * Created by shawnhuang on 2016-06-09.
 */
package views {

import controller.Assets;
import controller.FloxCommand;
import controller.FloxInterface;
import controller.MainCommand;
import controller.MainInterface;

import data.DataContainer;

import feathers.controls.Button;
import feathers.controls.Check;


import feathers.controls.PanelScreen;
import feathers.controls.PickerList;
import feathers.controls.ScrollText;
import feathers.controls.TextArea;
import feathers.controls.TextInput;

import feathers.controls.renderers.DefaultListItemRenderer;
import feathers.controls.renderers.IListItemRenderer;
import feathers.controls.text.ITextEditorViewPort;
import feathers.controls.text.StageTextTextEditor;
import feathers.controls.text.TextFieldTextEditorViewPort;
import feathers.controls.text.TextFieldTextRenderer;
import feathers.core.ITextEditor;
import feathers.core.ITextRenderer;
import feathers.data.ListCollection;
import feathers.events.FeathersEventType;

import flash.text.TextFormat;

import services.LoaderRequest;

import starling.core.Starling;

import starling.display.Image;
import starling.display.Quad;

import starling.display.Sprite;
import starling.events.Event;
import starling.text.TextField;


import starling.textures.Texture;

import utils.DebugTrace;
import utils.ViewsContainer;

public class PayoutComponent extends PanelScreen{
    private var font:String="SimMyriadPro";
    private var flox:FloxInterface=new FloxCommand();
    private var email:String="";
    private var coin:Number=0;
    private var policyContent:String="We will be sending money via paypal to the entered email address.  It is not necessary for you to have a paypal account to accept payouts.\n\n"+
            "In addition to all applicable paypal transaction and currency conversion fees, a 7% operating fee will be charged to cover basic operating costs for the Black Market.  Including fees we've already paid to multiple payment and network service providers.\n\n"+
            "It will usually take 1-2 business days to verify your information and process the request. Once the payout is in progress it cannot be cancelled or reversed. Please check your email address carefully.\n\n"+
            "We thank you for your understanding.";
    private var validated:Boolean=false;
    private var policy_check:Boolean=false;
    private var payout_amount:Number=0;
    private var command:MainInterface=new MainCommand();


    public function PayoutComponent() {
        this.width=Starling.current.stage.stageWidth;
        this.height=Starling.current.stage.stageHeight;
        this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
    }

    private function initializeHandler(e:Event):void{

        var bgQuad:Quad = new Quad(this.width,this.height,0x000000);
        bgQuad.alpha=0.6;

        var container:Sprite=new Sprite();

        var bgtexture:Texture=Assets.getTexture("Payout_UI");
        var bg:Image=new Image(bgtexture);

        var _format:Object=new Object();
        _format.font_size=18;
        _format.color=0x000000;


        coin=flox.getPlayerData("coin");
        var coinStr:String=DataContainer.currencyFormat(coin);
        var amountTxt:TextField = new TextField(300,40,coinStr);
        amountTxt.x=290;
        amountTxt.y=30;
        amountTxt.format.setTo(font,_format.font_size,_format.color);


        var coinslist:PickerList = new PickerList();
        coinslist.x=290;
        coinslist.y=77;
        coinslist.setSize(300,30);

        var collection :ListCollection = new ListCollection(
                [
                    { text: "$100" ,value:100},
                    { text: "$200" ,value:200},
                    { text: "$300" ,value:300},
                    { text: "$500" ,value:500},
                    { text: "$1,000" ,value:1000},
                    { text: "$5,000" ,value:5000}
                ]);

        coinslist.dataProvider=collection;
        coinslist.labelField = "text";
        coinslist.prompt = "$0";
        coinslist.selectedIndex = -1;
        coinslist.buttonFactory = function():Button
        {
            var button:Button = new Button();
            button.labelFactory= function():ITextRenderer {
                var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
                textRenderer.textFormat = new TextFormat(font, _format.font_size, _format.color);
                textRenderer.embedFonts = true;
                return textRenderer;
            };
            return button;
        };
        var PickerDefaultSkin:Texture=Assets.getTexture("PickerListDefault");
        coinslist.buttonProperties.defaultSkin = new Image( PickerDefaultSkin );
        coinslist.listProperties.itemRendererFactory = function():IListItemRenderer
        {
            var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
            renderer.labelField = "text";
            renderer.setSize(300,30);
            renderer.defaultSkin = new Image( PickerDefaultSkin );
            renderer.labelFactory = function():ITextRenderer
            {

                var textRenderer:TextFieldTextRenderer = new TextFieldTextRenderer();
                textRenderer.textFormat = new TextFormat(font, _format.font_size,_format.color);
                textRenderer.embedFonts = true;
                return textRenderer;
            };
            return renderer;
        };

        coinslist.addEventListener(Event.CHANGE, onCoinsChangeHandler);


        var emailInput:TextInput=new TextInput();
        emailInput.width=550;
        emailInput.height=40;
        emailInput.x=35;
        emailInput.y=135;
        emailInput.maxChars=20;
        emailInput.textEditorFactory=function():ITextEditor{

            var textEditor:StageTextTextEditor=new StageTextTextEditor();
            textEditor.fontFamily = font;
            textEditor.fontSize = _format.font_size;
            textEditor.color = _format.color;
            return textEditor;
        };

        emailInput.addEventListener( FeathersEventType.FOCUS_OUT, input_focusOutHandler );
        function input_focusOutHandler(e:Event):void{

            email=emailInput.text;
            var spaces:RegExp = / /gi;
            email=email.replace(spaces,"");
            validated=DataContainer.validateEmail(email);
            DebugTrace.msg("PayoutComponent.input_focusOutHandler email="+email);
            DebugTrace.msg("PayoutComponent.input_focusOutHandler validate="+validated);

            if(!validated){
                var msg:String="Please input correct email";
                command.showSaveError("payout",new Object(),msg);

            }

        }


//        var policyArea:ScrollText = new ScrollText();
//        policyArea.textFormat = new TextFormat(font,  _format.font_size-2, _format.color );
//        policyArea.embedFonts = true;
//        policyArea.isHTML=true;
//        policyArea.text = "<body>"+policyContent+"</body>";
//        policyArea.x=35;
//        policyArea.y=190;
//        policyArea.width=550;
//        policyArea.height =150;

        var policyArea:TextArea=new TextArea();
        policyArea.text = "<body>"+policyContent+"</body>";
        policyArea.isEditable=false;
        policyArea.x=35;
        policyArea.y=190;
        policyArea.width=550;
        policyArea.height =150;
        //policyArea.textEditorProperties.textFormat = new TextFormat(font, _format.font_size, _format.color );
        policyArea.textEditorFactory = function():ITextEditorViewPort
        {
            var textEditor:TextFieldTextEditorViewPort = new TextFieldTextEditorViewPort();
            textEditor.textFormat =  new TextFormat(font, _format.font_size-2, _format.color );
            textEditor.isSelectable=false;
            textEditor.isHTML=true;
            return textEditor;
        }

        var checkbox:Check=new Check();
        checkbox.isSelected = false;
        checkbox.width=20;
        checkbox.height=20;
        checkbox.x=35;
        checkbox.y=372;
        var defaultTexture:Texture=Assets.getTexture("DefaultCheckbox");
        var selectedTexture:Texture=Assets.getTexture("SelectedCheckbox");
        checkbox.upSkin=new Image( defaultTexture );
        checkbox.downSkin=new Image( defaultTexture );
        checkbox.hoverSkin=new Image( defaultTexture );
        checkbox.defaultSelectedSkin=new Image(selectedTexture);
        checkbox.addEventListener( Event.CHANGE, checkbox_changeHandler );

        var submitTexture:Texture=Assets.getTexture("IconSubmit");
        var submitBtn:starling.display.Button=new starling.display.Button(submitTexture);
        submitBtn.x=415;
        submitBtn.y=370;
        submitBtn.addEventListener( Event.TRIGGERED, submitBtnHandler );

        var cancelTexture:Texture=Assets.getTexture("IconCancel");
        var cancelBtn:starling.display.Button=new starling.display.Button(cancelTexture);
        cancelBtn.x=415+submitBtn.width+5;
        cancelBtn.y=370;
        cancelBtn.addEventListener( Event.TRIGGERED, cancelBtnHandler );


        container.x=this.width/2-(bg.width/2);
        container.y=this.height/2-(bg.height/2);
        container.addChild(bg);
        container.addChild( policyArea );
        container.addChild( amountTxt );
        container.addChild( coinslist );
        container.addChild( emailInput );
        container.addChild( checkbox );
        container.addChild( submitBtn );
        container.addChild( cancelBtn );

        this.addChild(bgQuad);
        this.addChild(container);

    }
    private function onCoinsChangeHandler(e:Event):void{

        var list:PickerList = PickerList( e.currentTarget );
        //var index:int = list.selectedIndex;
        payout_amount = list.selectedItem.value;
        DebugTrace.msg("PayoutComponent.onCoinsChangeHandler value="+payout_amount);

    }

    private function checkbox_changeHandler(e:Event):void{
        var check:Check= Check(e.currentTarget);

        policy_check=check.isSelected;

        DebugTrace.msg("PayoutComponent.checkbox_changeHandler check="+policy_check);
    }

    private function submitBtnHandler(e:Event):void{

        if(!policy_check){
            var msg:String="Please check 'I agree to the terms and conditions.'";
            command.showSaveError("payout",new Object(),msg);
        }
        var payout:Boolean=false;
        if(payout_amount==0){
            msg="Please choose a payout amount.";
            command.showSaveError("payout",new Object(),msg);
        }else{

            if(coin>payout_amount){
                payout=true;
                coin-=payout_amount;
                flox.savePlayerData("coin",coin);
            }else{

                msg="You do not have enough USD.";
                command.showSaveError("payout",new Object(),msg);
            }
        }

        if(validated && policy_check && payout){
            var payout_history:Array=flox.getPersonalLog("payout_history");
            var timeStamp:String=new Date().toLocaleString();
            var node:Object={createdAt:timeStamp,email:email,payout:payout_amount,balance:coin};
            if(!payout_history){
                payout_history=new Array();
            }
            payout_history.push(node);
            flox.savePersonalLog("payout_history",payout_history);

            var msg:String="Your payout request is submitted. It'll usually take 1-2 business days to process. If there is any issue we'll contact you at the email entered. Thank you for joining us at the Black Market!";
            command.showSaveError("payout",new Object(),msg);

            var current_scene:Sprite=ViewsContainer.currentScene;
            current_scene.dispatchEventWith("REMOVE_PAYOUT");



        }

    }

    private function cancelBtnHandler(e:Event):void{

        var current_scene:Sprite=ViewsContainer.currentScene;
        current_scene.dispatchEventWith("REMOVE_PAYOUT");

//
//        var serviceURL:String="https://megastore99.globat.com/files/payment/mailservices/mailgun.php";

//        var serviceURL:String="https://api:key-004f3ac21d626b611f0ab4f039dd08ce@api.mailgun.net/v3/samples.mailgun.org/messages";
        var loaderReq:LoaderRequest=new LoaderRequest();
//        var _data:Object=new Object();
//        _data.from="Lovemore <postmaster@sandboxec73155164604d51a2115c7524699d46.mailgun.org>";
//        _data.to="Shawn <shawncc.huang@gmail.com>";
//        _data.subject="Hello";
//        _data.text="Testing some Mailgun awesomness!";

        var serviceURL:String="https://usX.api.mailchimp.com/3.0/conversations/{conversation_id}/messages";
        var _data:Object=new Object();
        _data.from_email="shawncc.huang@gmail.com";
        _data.subject="Hello";
        _data.message="Testing some Mailgun awesomness!";
        _data.read=false;
        loaderReq.sendDataToURL(serviceURL,_data);

    }


}
}
