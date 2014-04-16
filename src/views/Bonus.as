package views
{
	public class Bonus extends Star
	{
	    public var max:Number=0;
		public function Bonus()
		{
			super();
		}
		override public function setUP(max:Number):void
		{
			max=max;
			super.setUP(max);
		}
		override public function doFalling():void
		{
			super.doFalling();
			 
		}
	}
}