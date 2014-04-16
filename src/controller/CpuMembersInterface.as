package controller
{
	
	public interface CpuMembersInterface
	{
		
		function setupCPU():void
		function setupBattleTeam():void
		function setupSkillCard():void
		function setupCpuTarget():void
		//function showupMember():void
		//function getCpuTeam():Array
		function getCpuMainTeam():Array
		function commanderSkill():void
		//function getCpuPower():Array
		//function overidePower(powers:Array):void
		// function overideMainTeam(teams:Array):void
		//function set cputeamMember(members:Array):void
		function healSetUp():void
		function nextRound():void
	}
}