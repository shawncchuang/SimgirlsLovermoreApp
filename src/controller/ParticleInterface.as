package controller
{
	import flash.geom.Point;
	
	import starling.display.Sprite;

	public interface ParticleInterface 
	{
	
		
		function init(target:*,type:String,point:Point=null):void
		function showParticles():void
		
	}
}