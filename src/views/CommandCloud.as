package views
{
import com.greensock.TweenMax;
import com.greensock.plugins.TweenPlugin;
import com.greensock.plugins.TransformAroundCenterPlugin;
import com.greensock.easing.Back;

import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	import events.TopViewEvent;
	
	import model.SaveGame;
	
	//import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Sprite;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	public class CommandCloud extends MovieClip
	{
		private var _label:String
		private var comcloud:MovieClip;
		private var cloudTxt:TextField;
		private var command:MainInterface=new MainCommand();
		private var scenecom:SceneInterface=new SceneCommnad();
		private var pos:Object={"L1":new Point(3,374),"L2":new Point(-11,469),"L3":new Point(-8,278),"L4":new Point(2,565),"L5":new Point(1,182),
			"R1":new Point(872,375),"R2":new Point(860,469),"R3":new Point(826,279),"R4":new Point(872,566),"R5":new Point(872,183)}
		private var de_label:String="";
		private var directions:MovieClip;
        TweenPlugin.activate([TransformAroundCenterPlugin]);
		public function CommandCloud(src:String)
		{
			//L1_^Departures
			var p:String=src.split("_")[0]
			_label=src.split("_")[1];
			//DebugTrace.msg("CommandCloud.addDisplayObj _label:"+_label);
			
			var format:TextFormat=new TextFormat();
			format.font="SimImpact";
			format.align=TextFormatAlign.CENTER;
			format.color=0x66CCFF;
			format.size=25;
			cloudTxt=new TextField();
			cloudTxt.x=22;
			cloudTxt.y=20;
			cloudTxt.width=114;
			cloudTxt.height=80;
			cloudTxt.embedFonts=true;
			cloudTxt.multiline=true;
			cloudTxt.defaultTextFormat=format;

            if(p.indexOf("L")!=-1){
                var posX:Number=-200;
                var id:Number=Number(p.split("L").join(""));
            }else{
                posX=1000;
                id=Number(p.split("R").join(""));
            }


			comcloud=new ComCloud();
			comcloud.name=_label;
			//comcloud.x=pos[p].x;
            comcloud.x=posX;
			comcloud.y=pos[p].y;
			comcloud.buttonMode=true;
			comcloud.mouseChildren=false;
			comcloud.addEventListener(MouseEvent.MOUSE_DOWN,doClickComCloud);
			comcloud.addEventListener(MouseEvent.MOUSE_OVER,doOverComCloud);
			comcloud.addEventListener(MouseEvent.MOUSE_OUT,doOutComCloud);
			comcloud.addEventListener(Event.ENTER_FRAME,doComCloudEnterFrame);
			comcloud.addChild(cloudTxt);

            comcloud.scaleX=0.1;
            comcloud.scaleY=0.1;

			addChild(comcloud);

            TweenMax.to(comcloud,id*0.1+0.2,{x:pos[p].x,transformAroundCenter:{scale:1},easing:Back.easeInOut});

		}


		private function doClickComCloud(e:MouseEvent):void
		{
			
			
			var target:String=e.target.name.split("^").join("");
			var flox:FloxInterface=new FloxCommand();
			var turn_switch:String=flox.getSaveData("current_switch").split("|")[1];
			if(target=="Rest" || target=="Stay")
			{
				
				var switch_verifies:Array=scenecom.switchGateway("Rest||Stay");
				DebugTrace.msg("CommandCloud.doClickComCloud switch_verify="+switch_verifies);
				if(!switch_verifies[0])
				{


                    onCloudTirrered();
				}
				//if
				
			}
			else
			{
                onCloudTirrered();

			}
			//if
			visibleCommandDirecation();
		}
        private function onCloudTirrered():void{

            disabledComCloud();

            TweenMax.to(comcloud,0.5,{label:"broke"});
            comcloud.gotoAndPlay("broke");
            command.playSound("Break");


        }
		private function doOverComCloud(e:MouseEvent):void
		{
			
			if(_label.indexOf("\n")!=-1)
			{
				var over_target:String=String(_label.split("\n").join(" "));
			}
			DebugTrace.msg("CommandCloud.doOverComCloud _label:"+over_target);
			
			var _data:Object=new Object();
			_data.enabled=true;
			_data.content=over_target;
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			if(over_target!=" Leave" && over_target)
			{
				gameinfo.dispatchEventWith("UPDATE_DIRECTION",false,_data);
			}
		}
		private function doOutComCloud(e:MouseEvent):void
		{
			
			visibleCommandDirecation();
		}
		private function visibleCommandDirecation():void
		{
			
			var _data:Object=new Object();
			_data.enabled=false;
			_data.content="";
			var gameinfo:Sprite=ViewsContainer.gameinfo;
			gameinfo.dispatchEventWith("UPDATE_DIRECTION",false,_data);
			
		}
		private function disabledComCloud():void
		{
			comcloud.removeEventListener(MouseEvent.MOUSE_DOWN,doClickComCloud);
			comcloud.removeEventListener(MouseEvent.MOUSE_OVER,doOverComCloud);
			comcloud.removeEventListener(MouseEvent.MOUSE_OUT,doOutComCloud);
			
		}
		private function doComCloudEnterFrame(e:Event):void
		{
			
			
			
			if(comcloud.currentFrameLabel=="showed")
			{
				if(_label.indexOf("^")!=-1)
				{
					if(_label.split("^")[0]!="")
						cloudTxt.y=35;
					
					_label=String(_label.split("^").join("\n"));
					
				}
				//if
				
				cloudTxt.text=_label;
			}
			
			if(comcloud.currentFrame==comcloud.totalFrames)
			{
				
				
				comcloud.removeEventListener(Event.ENTER_FRAME,doComCloudEnterFrame);
				//removeChild(comcloud);
				comcloud.visible=false;
				
				var _data:Object=new Object();
				de_label=_label.split("\n").join("");
				DebugTrace.msg("CommandCloud.doComCloudEnterFrame de_label:"+de_label);
				_data.removed=de_label;
				command.topviewDispatch(TopViewEvent.REMOVE,_data);
				var currentScene:String=DataContainer.currentScene;
				var scene_index:Number=currentScene.indexOf("Scene");
				if(scene_index!=-1)
				{
					checkSceneCommand();
				}
				//if
			}
		}
		private var valueTween:TweenMax;
		private function checkSceneCommand():void
		{
			var currentlable:String=DataContainer.currentLabel;
			var currentScene:String=DataContainer.currentScene;
			var scene_index:Number=currentlable.indexOf("Scene");
			var looking_index:Number=_label.indexOf("Look");
			var start_dating:Number=_label.indexOf("Dating");
			DebugTrace.msg("CommandCloud.checkSceneCommand currentlable:"+currentlable+" ; currentScene:"+currentScene);
			
			
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			var sussess:Boolean=false;
			var _data:Object=new Object();
			if(looking_index!=-1)
			{
				//Looking for someone at scene
				
				//sussess=paidAP();
				//if(sussess)
				//{
				
				_data.name="FoundSomeScene";
				command.sceneDispatch(SceneEvent.CHANGED,_data);
				//}
				//if
			}
			//if
			if(currentlable=="DatingScene")
			{
				
				//dating scene
				switch(de_label)
				{
					case "Give":
					case "Chat":
					case "Flirt":
					case "Dating":
						sussess=paidAP();
						if(sussess)
						{
                            var scene:Sprite=ViewsContainer.MainScene;
                            TweenMax.delayedCall(0.5,onInitCurrentScene)

                            /*
							var scene:Sprite=ViewsContainer.MainScene;
							valueTween=new Tween(scene,0.5);
							valueTween.delay=0.5;
							valueTween.onComplete=onInitCurrentScene;
							Starling.juggler.add(valueTween);
							*/
						}
						//if
						break
					case "Leave":
						onInitCurrentScene();
						break
				}
				//switch
				
			}
			//if
			if(start_dating!=-1)
			{
				//start dating
				_data=new Object();
				_data.name="DatingScene";
				//command.sceneDispatch(SceneEvent.CHANGED,_data)
				
			}
			//if
		}
		private function paidAP():Boolean
		{
			//command -10 ap
			var success:Boolean=false;
			var payAP:Number=10;
			var scene:Sprite=ViewsContainer.MainScene;
			var savegame:SaveGame=FloxCommand.savegame;
			if(Number(savegame.ap)<10)
			{
				ViewsContainer.UIViews.visible=false;
				var msg:String="Sorry,you don't have enough AP.";
				var alert:AlertMessage=new AlertMessage(msg,onClosedAlert);
				scene.addChild(alert);
				
			}
			else
			{
				success=true;
				savegame.ap=savegame.ap-payAP;
				FloxCommand.savegame=savegame;
				
				var gameinfo:Sprite=ViewsContainer.gameinfo;
				gameinfo.dispatchEventWith("UPDATE_INFO");
				
				
				var value_data:Object=new Object();
				value_data.attr="ap";
				value_data.values="-"+payAP;
				command.displayUpdateValue(scene,value_data);
				
				
			}
			//if
			return success;
			
		}
		private function onClosedAlert():void
		{
			var gameEvent:GameEvent=SimgirlsLovemore.gameEvent;
			gameEvent._name="clear_comcloud";
			gameEvent.displayHandler();
			
			var _data:Object=new Object();
			_data.name=DataContainer.currentScene;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
		}
		private function onInitCurrentScene():void
		{
			DebugTrace.msg("CommandCloud.onInitCurrentScene")

            TweenMax.killAll();
			//Starling.juggler.remove(valueTween);
			
			var _data:Object=new Object();
			_data.com=de_label;
			var basesprite:Sprite=ViewsContainer.baseSprite;
			basesprite.dispatchEventWith(DatingScene.COMMIT,false,_data);
			
			/*switch(de_label)
			{
			case "Give":
			case "Chat":
			case "Leave":
			case "Flirt":
			case "Dating":
			
			var _data:Object=new Object();
			_data.com=de_label;
			var basesprite:Sprite=ViewsContainer.baseSprite;
			basesprite.dispatchEventWith("commit",false,_data);
			
			break
			}
			//switch
			*/
			
			
		}
	}
}