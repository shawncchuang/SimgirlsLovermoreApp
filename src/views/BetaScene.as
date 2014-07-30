package views
{
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.FloxCommand;
	import controller.FloxInterface;
	import controller.MainCommand;
	import controller.MainInterface;
	
	import data.DataContainer;
	
	import events.GameEvent;
	import events.SceneEvent;
	
	import model.Scenes;
	
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.textures.Texture;
	
	import utils.ViewsContainer;
	
	public class BetaScene extends Scenes
	{
		private var command:MainInterface=new MainCommand();
		private var flox:FloxInterface=new FloxCommand();
		private var base_sprite:Sprite;
		public function BetaScene()
		{
			super();
		 
			 
			//DataContainer.battleCode="s003-1";
	     	DataContainer.BatttleScene="Arena";
			ViewsContainer.currentScene=this;
			base_sprite=new Sprite();
			addChild(base_sprite);
			base_sprite.flatten();
			init();
		}
		private function init():void
		{
			var bgTexture:Texture=Assets.getTexture("BetaBackground");
			var bgImg:Image=new Image(bgTexture);
			addChild(bgImg);
			
			var battlebtn:Button=createButton("Battle",new Point(300,440));
			var chasebtn:Button=createButton("Race",new Point(580,440));
			battlebtn.addEventListener(TouchEvent.TOUCH,onTouchHandle);
			chasebtn.addEventListener(TouchEvent.TOUCH,onTouchHandle);
			
		}
		
		private function onTouchHandle(e:TouchEvent):void
		{
			var target:Button=e.currentTarget as Button;
			var touch:Touch=e.getTouch(target,TouchPhase.BEGAN);
			var goScene:String="";
			if(touch)
			{
				switch(target.name)
				{
					case "Battle":
						goScene="ChangeFormationScene";
						break
					case "Race":
						goScene="TraceGame";
						break
				}
				
			 
		 
				var _data:Object=new Object();
				_data.name=goScene;
				command.sceneDispatch(SceneEvent.CHANGED,_data);
			}
		}
		private function createButton(label:String,point:Point):Button
		{
	 
			var btnbg:Texture=Assets.getTexture("Beta"+label);
			var btn:Button=new Button(btnbg);
			 
			btn.name=label;
			btn.width=150;
			btn.height=150;
			btn.x=point.x;
			btn.y=point.y;
			addChild(btn);
			 
			return btn
		}
	}
}