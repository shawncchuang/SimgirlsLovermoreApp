package controller
{
	import dragonBones.Armature;
	
	import starling.display.Sprite;
	
	public interface AvatarInterface
	{
		function createAvatar(fun:Function,attr:Object):void
		function getAvatar():Sprite
		function getArmaute():Armature
	}
}