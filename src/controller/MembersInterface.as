package controller
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public interface MembersInterface
	{
		function init(scene:MovieClip):void
		function initPlayerMember(clickPlayer:Function):void
		function initCpuMember():void
		//function praseMemberPart(member:MovieClip,act:String,name:String):void
		function setPlayerIndex(index:uint):void
		function choiceTarget(setupTarget:Function,overTarget:Function,outTraget:Function):void
		function reseatCpuTeam(setupTarget:Function,overTarget:Function,outTraget:Function):void
		function playerReadyPickupCard(id:String):void
		function checkTeamSurvive():void
		function getPlayerTeam():Array
		function getCpuTeam():Array
		//function getCpuMainTeam():Array
		//function getCpuPower():Array
		//function setCpuPower(cpupower:Array):void
		function getTopIndex():uint
		function nextRound():void
		function equipedCard(target:String,card:MovieClip):void
		function removeEquipedCard():void
		function removeAllEquidedCards():void
		//function praseMemberStatus():void
		function getBattleTeam():Object;
		function removePlayerMemberListener(clickPlayer:Function):void
		function addPlayerMemberListener(clickPlayer:Function):void
		function clearPlayerTarget():void
		function getBattleOver():Boolean
		function reseatCPUPower(name:String):void
		 
	}
}