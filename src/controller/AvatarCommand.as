package controller
{
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import controller.Assets;
	
	import dragonBones.Armature;
	import dragonBones.Bone;
	import dragonBones.animation.WorldClock;
	import dragonBones.events.AnimationEvent;
	import dragonBones.events.FrameEvent;
	import dragonBones.factorys.StarlingFactory;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	import starling.utils.rad2deg;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;

	public class AvatarCommand implements AvatarInterface
	{
	
		private var name:String;
		private var factory:StarlingFactory;
		private var armature:Armature;
		 
		//private var arm:Bone;
		private var body:Bone;
		private static var _avatar:Sprite;
		public  var onReadyComplete:Function;
		private var attrs:Object=new Object();
		public static function set currentAvatar(target:Sprite):void
		{
			_avatar=target;
		}
		public static function get currentAvatar():Sprite
		{
			return _avatar;
		}
		public function getAvatar():Sprite
		{
			
			return AvatarCommand.currentAvatar;
		}
		public function getArmaute():Armature
		{
			
			return armature;
		}
		public function createAvatar(fun:Function,attr:Object):void
		{
			name=attr.name;
			attrs=attr;
			onReadyComplete=fun;
//            if(name=="player")
//			{
//				name=name+attrs.gender;
//			}
			DebugTrace.msg("ChangeFormationScene.createAvatar name="+name);
			var texture:Texture=Assets.getTexture(name+"Rdy");
			var img:Image=new Image(texture);
			img.pivotX=img.width/2;
			img.pivotY=img.height/2;
			var avatar:Sprite=new Sprite();
			avatar.addChild(img);
			avatar.x=attrs.pos.x;
			avatar.y=attrs.pos.y;
			currentAvatar=avatar;
			var ship:Sprite=ViewsContainer.AvatarShip;
			ship.addChild(avatar);
			onReadyComplete();
			/*var textTure:ByteArray=Assets.create(name+"Ani") as ByteArray;
			factory = new StarlingFactory();
			factory.parseData(textTure);
			factory.addEventListener(Event.COMPLETE, textureCompleteHandler);*/
		 
			
		}
		private function textureCompleteHandler(e:Event):void
		{
			
			var ship:Sprite=ViewsContainer.AvatarShip;
			armature = factory.buildArmature(name);
			var avatar:Sprite = armature.display as Sprite;
			avatar.x=attrs.pos.x;
			avatar.y=attrs.pos.y;
			currentAvatar=avatar;
			//avatar.x = 400;
			//avatar.y = 400;
			 
			ship.addChild(avatar);
			armature.animation.gotoAndPlay("ready",-1,-1,null)
			 
			 
			//body = armature.getBone("body");
			//body.childArmature.animation.gotoAndPlay("ready")
			//arm = armature.getBone("armOutside");
			//arm.childArmature.addEventListener(FrameEvent.MOVEMENT_FRAME_EVENT, armFrameEventHandler);
			
			WorldClock.clock.add(armature);
		 
			ship.addEventListener(EnterFrameEvent.ENTER_FRAME, onEnterFrameHandler);
			onReadyComplete();
		}
		private function onEnterFrameHandler(e:EnterFrameEvent):void
		{
		 
			_avatar.scaleX=0.69*attrs.side;
			_avatar.scaleY=0.69;
			
			//updateSpeed();
			WorldClock.clock.advanceTime(-1);
			//updateArrows();
			//DebugTrace.msg("AvatarCommand.onEnterFrameHandler")
			
		}
		 
		private function armFrameEventHandler(e:FrameEvent):void 
		{
			switch(e.frameLabel)
			{
				case "fire":
					//createArrow();
					//trace("frameEvent:" + e.frameLabel);
					break;
				case "ready":
					//isAttacking = false;
					//isComboAttack = true;
					//hitCount ++;
					break;
			}
			//switch
		}
		
	}
}