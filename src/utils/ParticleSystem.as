package utils
{
	
	import flash.geom.Point;
	
	import controller.Assets;
	import controller.ParticleInterface;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.extensions.ColorArgb;
	import starling.extensions.PDParticleSystem;
	import starling.textures.Texture;
	
	public class ParticleSystem implements ParticleInterface
	{
		private var _target:Sprite;
		private var _src:String;
		private var _type:String;
		private var _color:uint;
		private var _point:Point;
		private var _duration:Number;
		private var ps:PDParticleSystem;
		public function init(target:*,type:String,point:Point=null):void
		{
			_duration=0.5;
			_target=target;
			_type=type;
			_point=point;
			switch(_type)
			{
				case "flirt_heart":
					_src="FlirtHeartParticle";
					_duration=0.2;
					break
				case "like":
			
					_src="HeartParticle";
					_color=0xFF66FF;
					break
				case "unlike":
					_src="StarParticle";
					_color=0x00FFFF;
					break
				case "heart_break":
					_duration=0.2;
					_src="HeartBreakParticle";
					break
			}
			
		}
		public function showParticles():void
		{
			
			var psXML:XML=Assets.getAtalsXML(_src+"XML");
			var psTexture:Texture=Assets.getTexture(_src);
			ps=new PDParticleSystem(psXML,psTexture);	
			if(_point)
			{
				ps.x=_point.x;
				ps.y=_point.y;
			}
			ps.start(_duration);
			//ps.endColor=ColorArgb.fromRgb(_color);
			ps.speed=300;
			ps.maxNumParticles=200;
			ps.lifespan=1;
			
			Starling.juggler.add(ps);
			_target.addChild(ps);
		}
	}
}