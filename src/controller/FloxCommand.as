package controller
{
	import com.gamua.flox.Access;
	import com.gamua.flox.Entity;
	import com.gamua.flox.Flox;
	import com.gamua.flox.Player;
	import com.gamua.flox.Query;
	import com.gamua.flox.events.QueueEvent;
	import com.gamua.flox.utils.HttpStatus;
	import com.gamua.flox.utils.SHA256;
	
	import data.Config;
	import data.DataContainer;
	
	import events.TopViewEvent;
	
	import model.CusomAssets;
	import model.CustomPlayer;
	import model.SaveGame;
	import model.SystemData;
	
	import services.LoaderRequest;
	import services.TurboSMTP;
	
	import utils.DebugTrace;
	import utils.ViewsContainer;
	
	import views.AlertMessage;
	import views.FloxManagerView;
	
	
	public class FloxCommand implements FloxInterface
	{
		private var permision:String="black!@spears#$";
		private var player_name:String="";
		private var password:String="";
		public static var my_email:String="";
		private var key:String;
		private var save_player_type:String;
		private var _inGameProgress:Number=0;
		private static var _savegame:SaveGame;
		private static var _systemdata:SystemData;
		private var current_saved:String;
		private var saved_index:Number=0;
		private var savedrecord:Array=new Array();
		private static var _onComplete:Function=null;
		private var command:MainInterface=new MainCommand();
		private var sceneslikes:Object;
		private var game_type:String="";
		private  static var SAVE_ERROR_MSG:String="Sorry something Errorr! Please wait a minute and try again.";
		public static function set onLoadComplete(fun:Function):void
		{
			_onComplete=fun
		}
		public static function get onLoadComplete():Function
		{
			return _onComplete;
		}
		
		public static function set savegame(data:*):void
		{
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			
			_savegame.id=currentPlayer.id+"_saved"+currentPlayer.inGameProgress;
			if(data)
			{
				for(var attr:String in data)
				{
					_savegame[attr]=data[attr];
				}
				//for
			}
			//if
			_savegame.save(onSaveComplete,onSaveError);
			function onSaveComplete():void
			{
				
			}
			function onSaveError(error:String):void
			{
				
				MainCommand.addAlertMsg(SAVE_ERROR_MSG);
			}
		}
		
		public static function get savegame():SaveGame
		{
			return _savegame;
		}
		public static function set systemdata(data:*):void
		{
			_systemdata=data;
		}
		public static function get systemdata():SystemData
		{
			return _systemdata;
		}
		public function init():void
		{
			
			
			Flox.playerClass = CustomPlayer;
			
			Flox.init("jGAFFu973M7tlxp7", "wLDwYIitcQwtMmtZ", "1.0.1");
			Flox.traceLogs=true;
			
			//Flox.addEventListener(QueueEvent.QUEUE_PROCESSED,onInitComplete);
			
		}
		private function onInitComplete(e:QueueEvent):void
		{
			//Flox.logWarning("ss");
			trace("Flox InitComplete");
			
			
		}
		public function getSaveData(attr:String=null):*
		{
			if(attr)
			{	
				var result:*=_savegame[attr]
			}
			else
			{
				result=	_savegame;
			}
			return result;
		}
		public function getSyetemData(attr:String):*
		{
			var result:*=_systemdata[attr]
			
			return result;
		}
		public function getPlayerData(attr:String):*
		{
			var re:*;
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			re=currentPlayer[attr];
			return re;
		}
		public function savePlayer(data:Object=null,callback:Function=null):void
		{
			
			//save_player_type=attr;
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			
			if(data)
			{
				for(var attr:String in data)
				{
					currentPlayer[attr]=data[attr];
				}
			}
			//currentPlayer.saveQueued();
			currentPlayer.save(callback,onSavedError);
		}
		private function onSavePlayerComplete():void
		{
			switch(save_player_type)
			{
				case "verify":
					//setupSaveGame();
					break
			}
			DebugTrace.msg("Floxcommand.onSavePlayerComplete");
		}
		
		private function setupPlayer():void
		{
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			//currentPlayer.nickname=player_name+"_"+currentPlayer.id;
			currentPlayer.player_name=player_name;
			currentPlayer.email=my_email;
			currentPlayer.password=password;
			currentPlayer.verify="enabled";
			currentPlayer.paid=false;
			currentPlayer.saved=new Array();
			currentPlayer.items=Config.PlayerItems;
			//currentPlayer.saveQueued();
			currentPlayer.save(onSetupPlayerComplete,onSavedError);	
			
		}
		private function onSetupPlayerComplete():void
		{
			
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			
			DebugTrace.msg("Floxcommand.onSetupPlayerComplete, verify :"+currentPlayer);
			
			command.removeLoading();
			
			SimgirlsLovemore.successLogin();
			
		}
		public function loginWithKey(email:String,pwd:String):void
		{
			my_email=email;
			var cons:String="authId == ?";
			if(email=="%*%%!@#(" && pwd=="%*%%!@#(")
			{
				key=Config.verifyKey;
				indicesPlayer(cons,key,onVerifyComplete,onIndicesError,null);
				
			}
			else
			{
				command.addLoadind("");
				key=SHA256.hashString(String(email+permision+pwd));
				indicesPlayer(cons,key,onSignInIndices,onIndicesError,null);
				
			}
			
			//var player:Player=Player.current;
			//DebugTrace.msg(player.authId);
			
		}
		
		private function onVerifyComplete(players:Array):void
		{
			DebugTrace.msg("Floxcommand.onVerifyComplete:");
			var msg:String="";
			if(players.length>0)
			{
				msg="Congratulations ! You verify succcess,you can login to play game now.";
				
				Player.loginWithKey(key,onLoginToVerifyComplete,onLoginFailed);
			}
			else
			{
				msg="Sorry verify Error ! Please input correct email to verify again !";
				
			}
			//if
			MainCommand.addAlertMsg(msg);
		}
		private function onLoginToVerifyComplete(player:Player):void
		{
			var _data:Object=new Object();
			_data.verify="enabled";
			savePlayer(_data);
			
			
		}
		private function onSignInIndices(players:Array):void
		{
			
			DebugTrace.msg("Floxcommand.IndicesComplete");
			DebugTrace.obj(players);
			var msg:String="";
			if(players.length>0)
			{
				
				Player.loginWithKey(key,onLoginComplete,onLoginFailed);
			}
			else
			{
				command.removeLoading();
				msg="Login Error ! Please input correct email or password !!";
				MainCommand.addAlertMsg(msg);
			}
			//if
			
		}
		public function refreshPlayer(callback:Function):void
		{
			
			Player.current.refresh(callback,onLoginFailed);
		}
		
		
		private function onLoginComplete(player:Player):void
		{
			
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			command.removeLoading();
			if(currentPlayer.verify=="disabled")
			{
				
				var msg:String="Please check your mail to verify for new account!!";
				MainCommand.addAlertMsg(msg);
			}
			else
			{
				//send to sharedObject
				var laoderReq:LoaderRequest=new LoaderRequest();
				laoderReq.sendtoSharedObject(my_email);
				
				SimgirlsLovemore.successLogin();
			}
			//if
		}
		private function onLoginFailed(error:String, confirmationEmailSent:Boolean):void
		{
			command.removeLoading()
			DebugTrace.msg("FloxCommand.onLoginFailed error:"+error);
			SimgirlsLovemore.failedLogin(error)
			if(confirmationEmailSent) 
			{
				DebugTrace.obj(confirmationEmailSent);
			}
			else
			{
				
				
			}
			//if
		}
		public function signupAccount(email:String,pwd:String):void
		{
			
			my_email=email;
			password=pwd;
			player_name="";
			
			
			key=SHA256.hashString(String(email+permision+pwd));
			//var cons:String="authId == ? OR email == ? OR player_name == ?";
			var cons:String="authId == ? OR email == ?";
			//indicesPlayer(cons,key,onSignUpIndices,onIndicesError);
			//don't need player_name
			//var query:Query=new Query(CustomPlayer,cons,key,my_email,player_name);
			var query:Query=new Query(CustomPlayer,cons,key,my_email);
			query.find(onSignUpIndices,onIndicesError);
			
			var msg:String="Please wait a moment ! Your account is builded right now...";
			command.addLoadind(msg);
			
		}
		private function onSignUpIndices(players:Array):void
		{
			DebugTrace.msg("onSignUpIndices:");
			DebugTrace.obj(players)
			command.removeLoading();
			if(players.length==0)
			{
				
				var msg:String="Congratulation ! Login in game right now...";
				command.addLoadind(msg);
				Player.loginWithKey(key,onFirstLoginComplete,onLoginFailed);
			}
			else
			{
				msg="Create account Error ! Please input another email or player name !!"
				MainCommand.addAlertMsg(msg);
			}
			//if
			
		}
		private function onFirstLoginComplete(player:Player):void
		{
			
			//var msg:String="Please check your mail to verify for new account !!"
			//MainCommand.addAlertMsg(msg);
			command.removeLoading();
			var msg:String="Please wait a moment ! Setting up your data......";
			command.addLoadind(msg);
			
			
			
			//var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			/*if(currentPlayer.verify=="disabled")
			{
			var smtpsrv:TurboSMTP=new TurboSMTP();
			smtpsrv.init(my_email,key);
			}
			*/
			setupPlayer();
		}
		/*public function AdministerSave(data:Object=null,callback:Function=null):void
		{
		
		_savegame.id="AdministerSave";
		_savegame.save(callback,onSavedError);
		}*/
		
		public function save(attr:String,data:*=null,callback:Function=null):void
		{
			
			var playerData:Object=DataContainer.player;
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			//current_saved="saved"+currentPlayer.inGameProgress;
			
			//savegame=DataContainer.saveData; 
			
			DebugTrace.msg("FloxCommand.save savegame:"+_savegame+" ; inGameProgress:"+currentPlayer.inGameProgress);
			
			_savegame.id=currentPlayer.id+"_saved"+currentPlayer.inGameProgress;
			
			var SaveGameJSON:String=JSON.stringify(_savegame)
			DebugTrace.msg("FloxCommand.save SaveGameJSON:"+SaveGameJSON);
			if(data)
			{
				_savegame[attr]=data;
			}
			//savegame.saveQueued();
			_savegame.save(callback,onSavedError);
			
		}
		
		
		private function onSavedError(error:String):void
		{
			//DebugTrace.msg("onSavedError:"+error);
			
			MainCommand.addAlertMsg(SAVE_ERROR_MSG);
		}
		public function setupSaveGame():void
		{
			//new game
			game_type="newgame";
			DebugTrace.msg("FloxCommand.setupSaveGame");
			
			var playerAtt:Object=Config.PlayerAttributes(); 
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			
			var entity_target:String=currentPlayer.id+"_saved"+currentPlayer.inGameProgress;
			//DebugTrace.msg("FloxCommand.setupSaveGame entity_target:"+entity_target);
			savegame=new SaveGame();
			//savegame.publicAccess="owner" ; current_saved="saved1"
			
			savegame.id=entity_target;
			for(var attr:String in playerAtt)
			{
				
				savegame[attr]=playerAtt[attr];
				
			}
			//for
			//var savegamestr:String=JSON.stringify(savegame);
			
			
			loadSystemDataEntities();
			
			
			Flox.logEvent("GameStarted");
			SimgirlsLovemore.gameStart();
			
			
			
			
		}
		private function onSaveGameComplete():void
		{		
			refreshEntitesForStartGame();
		}
		private function refreshEntitesForStartGame():void
		{
			savegame.refresh(onRefreshForStartGameComplete,onLoadEntitiesError);
		}
		private function onRefreshForStartGameComplete(result:SaveGame):void
		{
			
			savegame=result;
			
			//DebugTrace.msg("onRefreshComplete:"+result);
			//DebugTrace.msg("onRefreshComplete:"+result.ap);
			
			loadSavedEntities();
			Flox.logEvent("GameStarted");
			SimgirlsLovemore.gameStart();
		}
		
		public function refreshEntites():void
		{
			
			savegame.refresh(onRefreshComplete,onLoadEntitiesError);
		}
		private function onRefreshComplete(result:SaveGame):void
		{
			//DataContainer.saveData=result;
			savegame=result
			//DebugTrace.msg("onRefreshComplete:"+result);
			//DebugTrace.msg("onRefreshComplete:"+result.ap);
			
		}
		public function loadSystemDataEntities():void
		{
			//for new game load system data
			
			/*var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			var assets_id:String="assets_"+currentPlayer.nickname+"_"+currentPlayer.inGameProgress;
			DebugTrace.msg("FloxCommand.loadSystemDataEntities  assets_id:"+assets_id);
			Entity.load(DataSave,assets_id,onLoadSystemDataComplete,onLoadEntitiesError);*/
			
			Entity.load(SystemData,"HeroesSaved",onLoadSystemDataComplete,onLoadEntitiesError);
			
			
		}
		private function onLoadSystemDataComplete(result:SystemData):void
		{
			systemdata=result;
			//DebugTrace.obj(result.datingchat);
			DebugTrace.msg("FloxCommand.onLoadSystemDataComplete");
			
			if(game_type=="newgame")
			{
				setupSystemData();
				
				var cpucom:CpuMembersInterface=new CpuMembersCommand();
				cpucom.setupCPU();
			}
			
			
		}
		private function _onLoadSystemDataComplete(result:SystemData):void
		{
			
			DebugTrace.msg("FloxCommand._onLoadSystemDataComplete");
			//DebugTrace.obj(result.datingchat);
		}
		public function loadEntities():void
		{
			game_type="loadgame";
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			//DebugTrace.msg("loadEntities:"+currentPlayer.id+" ; "+String(currentPlayer.createdAt)+" ; "+currentPlayer.nickname);
			var entity_target:String=currentPlayer.id+"_saved"+currentPlayer.inGameProgress;
			DebugTrace.msg("FloxCommand.loadEntities entity_target: "+entity_target);	
			
			Entity.load(SaveGame,entity_target,onLoadEntitiesComplete,onLoadEntitiesError);
			
		}
		private function onLoadEntitiesComplete(result:SaveGame):void
		{
			savegame=result
			
			var savegameStr:String=JSON.stringify(_savegame);	
			DebugTrace.msg("FloxCommand.onLoadEntitiesComplete savegameStr:"+savegameStr);
			var _data:Object=new Object();
			_data.removed="loadtoStart";
			command.topviewDispatch(TopViewEvent.REMOVE,_data);
			
			loadSystemDataEntities();
		}
		public function loadSavedEntities( ):void
		{
			// set record save data	
			game_type="savegame";
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			var entity_target:String=currentPlayer.id+"_saved"+(saved_index+1);
			DebugTrace.msg("FloxCommand.loadSavedEntities entity_target:"+entity_target);
			
			Entity.load(SaveGame,entity_target,onLoadSavedEntitiesComplete,onLoadEntitiesError);
			
			
		}
		private function onLoadSavedEntitiesComplete(result:SaveGame):void
		{
			
			
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			var savedlist:Array=currentPlayer.saved;
			savedrecord=DataContainer.SaveRecord
			var saveddata:Object=new Object();
			saveddata.cash=result.cash;
			saveddata.first_name=result.first_name;
			saveddata.last_name=result.last_name;
			saveddata.date=result.date;
			saveddata.ap=result.ap;
			saveddata.max_ap=result.max_ap;
			savedrecord.push(saveddata);
			DebugTrace.msg("FloxCommand.onLoadSavedEntitiesComplete saveddata:"+JSON.stringify(saveddata))
			DataContainer.SaveRecord=savedrecord;
			
			saved_index++;
			if(saved_index<savedlist.length)
			{
				loadSavedEntities();
				
			}
			else
			{
				
				saved_index=0;
				if(_onComplete)
				{
					//DebugTrace.msg("FloxCommand.onLoadEnitiesComplete");
					loadSystemDataEntities();
					_onComplete();
					_onComplete=null;
				}
				
			}
			//if
			
		}
		private function onLoadEntitiesError(error:String,httpStatus:int):void
		{
			if(httpStatus == HttpStatus.NOT_FOUND) 
			{
				
				var msg:String="There's no entity on the server that matches the given type and ID.";
				
			} else 
			{
				//DebugTrace.msg("Something went wrong during the load operation: The player's device may be offline.");
				msg="Something went wrong during the load operation: The player's device may be offline.";
				
			}
			MainCommand.addAlertMsg(msg);
			if(_onComplete)
			{
				_onComplete();
				_onComplete=null;
				
			}
			
		}
		private function setupSystemData():void
		{
			DebugTrace.msg("FloxCommand.setupSystemData ");
			
			
			var cistomAssets:CusomAssets=new CusomAssets();
			cistomAssets.praseRating();
			
			new DataContainer().initChacacterLikeScene();
			new DataContainer().setupCharacterSecrets()
			
			
		}
		
		/*private function saveSystemData():void
		{
		
		var amin_systemdata:SystemData=new SystemData();
		
		amin_systemdata.id="AdministerSaved";
		
		amin_systemdata.publicAccess=Access.READ_WRITE;
		
		//amin_systemdata.trashtalking=;
		amin_systemdata.save(onSystemDataComplete,onSavedError);
		
		
		}*/
		private function onSystemDataComplete(result:SystemData):void
		{
			
			DebugTrace.msg("Floxcommand.onSystemDataComplete");
		}
		
		/* private function UTCDate():Date
		{
		var date:Date=new Date();
		
		var utc_date:Date=new Date(date.fullYearUTC,date.monthUTC,date.dateUTC,date.hoursUTC,date.minutesUTC,date.secondsUTC,date.millisecondsUTC);
		DebugTrace.msg(utc_date.toString());
		return utc_date
		}*/
		public function indicesPlayer(cons:String,value1:String,onSuccess:Function,onFailed:Function,value2:String=null,value3:String=null):void
		{
			DebugTrace.msg("indicesPlayer: " + cons+" ; "+value1+" ; "+value2);
			
			var query:Query=new Query(CustomPlayer);
			
			if(value2)
			{
				
				query.where(cons,value1,value2);
			}
			else if(value3)
			{
				
				query.where(cons,value1,value2,value3);
			}
			else
			{
				query.where(cons,value1);
			}
			query.find(onSuccess,onFailed);
		}
		
		private function onIndicesError(error:String):void
		{
			
			DebugTrace.msg("IndicesError: " + error);
			var msg:String="Opps.It cann't connect to Server.\nPlaeae try again later."
			MainCommand.addAlertMsg(msg);
			command.removeLoading();
		}
		public function submitCoins():void
		{
			
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			Flox.postScore("number-of-coins", 1510, currentPlayer.id);
			
		}
		public function updateSavegame(data:Object):void
		{
			//write to local savegame data
			var config:Object=Config.PlayerAttributes();
			//var configStr:String=JSON.stringify(config);
			if(data)
			{			
				for(var attr:String in data)
				{
					switch(attr)
					{
						case "ap":
							var de_ap:Number=config[attr];
							if(data[attr]>de_ap)
							{
								data[attr]=de_ap;
							}
							//if
							if(data[attr]<0)
							{
								data[attr]=0
							}
							break
						case "cash":
							if(data[attr]<0)
							{
								data[attr]=0
							}
							break
					}
					//switch
					_savegame[attr]=data[attr]; 
				}
				//for
			}
			//if
			var savegamestr:String=JSON.stringify(_savegame);
			DebugTrace.msg("FloxCommand updateSavegame savegamestr:"+savegamestr);
			
			savegame=_savegame;
		}
		public function showlog(msg:String):void
		{
			
			Flox.logInfo(msg);
			
		}
		
		//Pre Order --------------------------------------------------
		private var Email:String;
		public function loginWithEmail(email:String):void
		{
			Email=email;
			command.addLoadind("");
			var cons:String="authId == ? AND from == ?";
			indicesPlayer(cons,email,onPreorderIndices,onIndicesError,"pre_order");
			
			
		}
		private function onPreorderIndices(players:Array):void
		{
			DebugTrace.msg("FloxCommand.onPreorderIndices players="+players);
			if(players.length==1)
			{
				DebugTrace.msg("FloxCommand.onPreorderIndices Success");
				
				Player.loginWithEmail(Email,onPreOderLoginComplete,onPreorderLoginFailed);
				
			}
			else
			{
				var msg:String="Sorry ! This Email isn't pre order account.";
				MainCommand.addAlertMsg(msg);
			}
			//if
			command.removeLoading();
		}
		private function onPreOderLoginComplete(player:Player):void
		{
			DebugTrace.msg("FloxCommand.onPreOderLoginComplete");
			
			command.removeLoading();
			SimgirlsLovemore.successLogin();
			
		}
		
		private function onPreorderLoginFailed(error:String, httpStatus:int, confirmationEmailSent:Boolean):void
		{
			command.removeLoading()
			DebugTrace.msg("FloxCommand.onPreorderLoginFailed error:"+error);
			DebugTrace.msg("FloxCommand.onPreorderLoginFailed httpStatus:"+httpStatus);
			SimgirlsLovemore.failedLogin(error)
			if(confirmationEmailSent) 
			{
				DebugTrace.obj(confirmationEmailSent);
			}
			else
			{
				
				
			}
			//if
		}
		public function signupWithEmail(email:String):void
		{
			//for Pre Order User signin
			
			command.addLoadind("");
			Player.loginWithEmail(email,onSignupWithEmailComplete,onLoginFailed);
			
		}
		private function onSignupWithEmailComplete():void
		{
			command.removeLoading();
			DebugTrace.msg("FloxCommand.onSignupWithEmailComplete");
			
			setupPreOrderPlayer();
			
		}
		private function setupPreOrderPlayer():void
		{
			var currentPlayer:CustomPlayer=Player.current as CustomPlayer;
			//currentPlayer.nickname=player_name+"_"+currentPlayer.id;
			currentPlayer.player_name="";
			//currentPlayer.email=my_email;
			//currentPlayer.password=password;
			currentPlayer.verify="enabled";
			currentPlayer.paid=true;
			currentPlayer.from="pre_order";
			currentPlayer.saved=new Array();
			//currentPlayer.saveQueued();
			currentPlayer.save(onSetupBetaPlayerComplete,onSavedError);	
			
		}
		private function onSetupBetaPlayerComplete():void
		{
			DebugTrace.msg("FloxCommand.onSetupBetaPlayerComplete");
			command.removeLoading();
			
			var floxMg:FloxManagerView=ViewsContainer.FloxManager;
			floxMg.currentAccount();
		}
		
		//------------------------------------------------------------------------
		public function LoginForDestroyPlayer(key:String,email:String):void
		{
			if(key!="")
			{
				Player.loginWithKey(key,onLoginForDestoryComplete,onLoginFailed);
			}
			if(email!="")
			{
				Player.loginWithEmail(email,onLoginForDestoryComplete,onLoginFailed);
			}
			
		}
		import model.DataSave;
		public function destoryEntities(type:String,id:String):void
		{
			switch(type)
			{
				case "Player":
					Entity.destroy(Player,id,onDestroyComplete,onSavedError);
					break
				case "SystemData":
					//Entity.destroy(SystemData,id,onDestroyComplete,onSavedError);
					break
				case "SaveGame":
					Entity.destroy(SaveGame,id,onDestroyComplete,onSavedError);
					break
				case "DataSave":
					//DataSave.destroy(onDestroyComplete,onSavedError);
					//Entity.load(DataSave,"",onDataSaveComplete,onSavedError);
					var dataSave:DataSave=new DataSave();
					dataSave.destroy(onDestroyComplete,onSavedError);
					break
			}
			
			
		}
		private function onDataSaveComplete(result:DataSave):void
		{
			result.destroy(onDestroyComplete,onSavedError);
			
		}
		private function onLoginForDestoryComplete():void
		{
			
			DebugTrace.msg("FloxCommand onLoginForDestoryComplete");
			//backup systemdata
			//Entity.load(SystemData,"AdministerSaved",onLoadSystemDataBackUp,onLoadEntitiesError);
			
		}
		private function onLoadSystemDataBackUp(result:SystemData):void
		{
			
			var _sysdata:SystemData=result;
			_sysdata.id="HeroesSaved";
			_sysdata.publicAccess=Access.READ;
			_sysdata.save(onSaveSystemDataComplete,onSavedError);
		}
		private function onSaveSystemDataComplete():void
		{
			DebugTrace.msg("FloxCommand onSaveSystemDataComplete");
		}
		private function onDestroyComplete():void
		{
			DebugTrace.msg("FloxCommand onDestroyComplete");
		}
		public function logEvent(evt:String,info:Object=null):void
		{
			Flox.logEvent(evt,info);
		}
		
	}
}