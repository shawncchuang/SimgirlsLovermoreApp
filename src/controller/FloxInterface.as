package controller
{
	public interface FloxInterface
	{
		function init():void
		//function AdministerSave(data:Object=null,callback:Function=null):void
		function signupAccount(email:String,pwd:String):void
		function loginWithKey(key:String):void
		function setupSaveGame():void
		function getSaveData(attr:String=null):*
	    function getSyetemData(attr:String):*
		function getPlayerData(attr:String):*
		function savePlayer(data:Object=null,callback:Function=null):void
		function savePlayerData(attr:String,data:*,callback:Function=null):void
		function save(attr:String,data:*,callback:Function=null):void
		//function refreshEntites():void
        function refreshSaveData(callback:Function=null):void
		function loadEntities():void
        function loadSystemData():void
	    function loadBackupsavedEntities():void
		function saveSystemDataEntities():void
		function saveSystemData(attr:String,value:*):void
		function loadSystemDataEntities():void
		function indicesPlayer(constraints:String,value1:String,onSuccess:Function,onFailed:Function,value2:String=null,value3:String=null):void
		function updatePlayer(cons:String,key:String,value:*):void
		function submitCoins():void
	    function updateSavegame(data:Object):void
		function refreshPlayer(callback:Function=null):void
		function showlog(msg:String):void
		function signupWithEmail(email:String):void
		function signupWithKey(key:String):void
		function loginWithEmail(email:String):void
		function LoginForDestroyPlayer(key:String="",email:String=""):void
		function destoryEntities(type:String,id:String):void
		function logEvent(evt:String,info:Object=null):void
		function syncSaved(callback:Function=null):void
		function syncBackupSaved(callback:Function=null):void
        function loadBackupsaved(callback:Function=null):void
		function resetPassword(email:String):void
		function queryPlayerByEmail(email:String,callback:Function):void
		function playerEditor(key:String):void

		function saveBundlePool(data:Object,callback:Function=null):void
		function loadBundlePoolEntity():void
		function refleshBundlePool(callback:Function):void
		function getBundlePool(attr:String):*
		function savePersonalLog(attr,data:*):void
		function getPersonalLog(attr:String):*
		function savePayoutListEntity(data:Object):void
		function indicesParentId(callback:Function,id:String):void
		function getUID():String
		
	}
}