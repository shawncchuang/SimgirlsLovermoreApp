package controller
{
	public interface FloxInterface
	{
		function init():void
		//function AdministerSave(data:Object=null,callback:Function=null):void
		function signupAccount(email:String,pwd:String):void
		function loginWithKey(email:String,pwd:String):void
		function setupSaveGame():void
		function getSaveData(attr:String=null):*
	    function getSyetemData(attr:String):*
		function getPlayerData(attr:String):*
		function savePlayer(data:Object=null,callback:Function=null):void
		function save(attr:String,data:*=null,callback:Function=null):void
		function refreshEntites():void
		function loadEntities():void
	    function loadSavedEntities():void
		function loadSystemDataEntities():void
		function indicesPlayer(constraints:String,value1:String,onSuccess:Function,onFailed:Function,value2:String=null,value3:String=null):void
		function submitCoins():void
	    function updateSavegame(data:Object):void
		function refreshPlayer(callback:Function):void
		function showlog(msg:String):void
		function signupWithEmail(email:String):void
		function loginWithEmail(email:String):void
		function LoginForDestroyPlayer(key:String,email:String):void
		
		function destoryEntities(type:String,id:String):void
			
		function logEvent(evt:String,info:Object=null):void
	}
}