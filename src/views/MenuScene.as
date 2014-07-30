package views
{
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.MainCommand;
	import controller.MainInterface;
	import controller.SceneCommnad;
	import controller.SceneInterface;
	
	import data.DataContainer;
	
	import events.SceneEvent;
	
	import model.Scenes;
	
	import starling.animation.Transitions;
	import starling.animation.Tween;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	public class MenuScene extends Scenes
	{
		private var scencom:SceneInterface=new SceneCommnad();
		private var base_sprite:Sprite;
		private var network:Image;
		private var tween:Tween;
		//profile,contacts,calendar,photos,mail,option
		private var iconsname:Array=["ProfileScene","Contacts","Calendar","Photos","Mail","Option"];
		private var icons:Array=[new Point(433,250),new Point(320,402),new Point(425,550),new Point(586,550),new Point(660,402),new Point(595,262)];
		private var iconsimg:Array=new Array();
		private var command:MainInterface=new MainCommand();
		private var click_type:String="";
		public function MenuScene()
		{
			 
			
			base_sprite=new Sprite();
			addChild(base_sprite);
			base_sprite.flatten();
			initLayout();
		}
		private function initLayout():void
		{
			
			scencom.init("MenuScene",base_sprite,20,onCallback);
			scencom.start();
			scencom.disableAll();
			
			
			var title:Image=new Image(getTexture("MenuTitle"));
			title.y=21;
			addChild(title);
			
			network=new Image(getTexture("IconNetwork"));
			network.useHandCursor=true;
			network.pivotX=network.width/2;
			network.pivotY=network.height/2;
			network.x=490;
			network.y=900;
			network.scaleX=0.1;
			network.scaleY=0.1;
			network.alpha=0;
			addChild(network);
			
			
			tween=new Tween(network,1,Transitions.EASE_IN_OUT_BACK);
			tween.scaleTo(0.5);
			tween.animate("y",402);
			tween.animate("alpha",1);
			tween.onComplete=onNetworkComplete;
			Starling.juggler.add(tween);
			
			//cancel button
			command.addedCancelButton(this,doCannelHandler);
			/*var cancel:Button=new Button(getTexture("XAlt"));
			cancel.name="cancel";
			cancel.x=964;
			cancel.y=720;
			addChild(cancel);
			cancel.addEventListener(Event.TRIGGERED,doCencaleHandler);*/
			
		}
		private function doCannelHandler():void
		{
			
			click_type=DataContainer.currentLabel;
			DebugTrace.msg("MenuScene.doCencaleHandler click_type:"+click_type);
			//click_type="MainScene";
			
			var infobar:Sprite=ViewsContainer.gameinfo;
			infobar.dispatchEventWith("DRAW_PROFILE");
			
			doFadeoutTransatoin();
			
			
			
		}
		private function onNetworkComplete():void
		{
			Starling.juggler.remove(tween);
			//network.addEventListener(TouchEvent.TOUCH,doTouchIconHandler);
			initFadeinIcons();
			
		}
		private function initFadeinIcons():void
		{
			
			for(var i:uint=0;i<iconsname.length;i++)
			{
				
				var texture:Texture=Assets.getTexture("Icon"+iconsname[i]);
				//DebugTrace.msg("MenuScene.initFadeinIcons icon name:"+"Icon"+iconsname[i])
				var iconimg:Image=new Image(texture);
				iconimg.name=iconsname[i];
				iconimg.useHandCursor=true;
				iconimg.pivotX=iconimg.width/2;
				iconimg.pivotY=iconimg.height/2;
				iconimg.x=network.x;
				iconimg.y=network.y;
				iconimg.scaleX=0.5;
				iconimg.scaleY=0.5;
				iconimg.alpha=0;
				addChild(iconimg);
				iconsimg.push(iconimg);
				//iconimg.addEventListener(TouchEvent.TOUCH,doTouchIconHandler);
			}
			//for
			for(var j:uint=0;j<iconsimg.length;j++)
			{
				
				var tween:Tween=new Tween(iconsimg[j],0.5,Transitions.EASE_IN_OUT_BACK);
				//tween.delay=j;
				tween.moveTo(icons[j].x,icons[j].y);
				tween.animate("alpha",1);
				 
				Starling.juggler.add(tween);
			}
			//for
			var delayCall:Tween=new Tween(this,0.5);
			delayCall.delay=0.5;
			delayCall.onComplete=onIconsComplete;
			Starling.juggler.add(delayCall);
		}
		private function onIconsComplete():void
		{
			Starling.juggler.removeTweens(this);
			for(var i:int=0;i<iconsimg.length;i++)
			{
				
				var iconimg:Image=iconsimg[i];
				iconimg.addEventListener(TouchEvent.TOUCH,doTouchIconHandler);
			}
			
		}
		private function doTouchIconHandler(e:TouchEvent):void
		{
			
			var target:Image=e.currentTarget as Image; 
			var hovor:Touch = e.getTouch(target, TouchPhase.HOVER);
			var began:Touch= e.getTouch(target, TouchPhase.BEGAN);
			var tween:Tween;
			if(hovor)
			{
				tween=new Tween(target,0.2,Transitions.EASE_IN_OUT_BACK);
				tween.scaleTo(1);
				Starling.juggler.add(tween);
			}
			else
			{
				Starling.juggler.removeTweens(target);
				tween=new Tween(target,0.2,Transitions.EASE_IN_OUT_BACK);
				tween.scaleTo(0.5);
				Starling.juggler.add(tween);
			}
			if(began)
			{
				click_type=target.name
				 
				doFadeoutTransatoin();
			}
		}
		
		private function doFadeoutTransatoin():void
		{
			
			
			
			for(var i:uint=0;i<iconsname.length;i++)
			{
				
				var iconimg:Image=iconsimg[i];
				var tween:Tween=new Tween(iconimg,0.2,Transitions.EASE_IN_OUT_BACK);
				tween.moveTo(network.x,network.y);
				tween.animate("alpha",0);
				Starling.juggler.add(tween);
				try
				{
					iconimg.removeEventListener(TouchEvent.TOUCH,doTouchIconHandler);
				}
				catch(error:Error)
				{
				
					trace("MenuScene error remove iconimg");
				}
				
				
			}
			
			
			var network_tween:Tween=new Tween(network,0.2,Transitions.EASE_IN_OUT_BACK);
			network_tween.delay=0.2;
			network_tween.scaleTo(0.1);
			network_tween.animate("y",900);
			network_tween.animate("alpha",0);
			network_tween.onComplete=onNetworkFadeout;
			Starling.juggler.add(network_tween);
			
			
		}
		private function onNetworkFadeout():void
		{
			for(var i:uint=0;i<iconsname.length;i++)
			{
				var iconimg:Image=iconsimg[i];
				Starling.juggler.removeTweens(iconimg);
				iconimg.removeFromParent(true);
			}
			Starling.juggler.removeTweens(network);
			network.removeFromParent(true);
			
			var _data:Object=new Object(); 
			_data.name=click_type;
			command.sceneDispatch(SceneEvent.CHANGED,_data);
				
			
			
		}
		private function onCallback():void
		{
			
		}
		private function getTexture(src:String):Texture
		{
			var textture:Texture=Assets.getTexture(src);
			return textture;
		}
	}
}