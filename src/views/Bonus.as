package views
{
	 
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class Bonus extends Star
	{
	    public var _max:Number=0;
		public function Bonus()
		{
			super();
		}
		override public function setUP(max:Number):void
		{
			_max=max;
			super.setUP(max);
		}
		override public function doFalling():void
		{
			super.doFalling();
			 
		}
		override public function starPhysics(target:DisplayObjectContainer,pos:Point,maximum:Number):void
		{
			super.starPhysics(target,pos,maximum);
		}
	}
}