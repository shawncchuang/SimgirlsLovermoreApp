package data
{
	import flash.globalization.CurrencyFormatter;
	
	import controller.FloxCommand;
	import controller.FloxInterface;
	
	import model.SaveGame;
	import model.SystemData;
	
	import utils.DebugTrace;
	
	public class DataContainer
	{
		private static var _deadline:Boolean;
		private static var scene:String;
		private static var label:String;
		private static var player_talkllibrary:Array;
		private static var ch_talkllibrary:Array;
		private static var playerdata:Object;
		
		private static var _battle:Boolean;
		private static var record:Array;
		private static var flox:FloxInterface=new FloxCommand();
		private static var sortedlikes:Array;
		private static var dating:String;
		private static var schedulelist:Array;
		private static var dateIndex:Object;
		private static var stones:Array;
		private static var surviveplayer:Array;
		private static var cpu_main_team:Array;
		private static var player_main_team:Array;
		private static var player_powers:Array;
		private static var memberseffect:Object;
		private static var members_mail:Array;
		private static var _current_power:Object;
		private static var _healArea:Array;
		private static var _stageID:Number;
		private static var cpuID:Number;
		public static function set deadline(boolean:Boolean):void
		{
			_deadline=boolean;
		}
		public static function get deadline():Boolean
		{
			return _deadline;
		}
		public static function set currentScene(value:String):void
		{
			
			scene=value;
		}
		public static function get currentScene():String
		{
			
			return scene;
		}
		public static function set currentLabel(value:String):void
		{
			label=value;
			
		}
		public static function get currentLabel():String
		{
			return label;
			
		}
		public static  function set playerTalklibrary(re:Array):void
		{
			player_talkllibrary=re;
		}
		public static  function get playerTalklibrary():Array
		{
			return player_talkllibrary;
		}
		
		public static  function set characterTalklibrary(re:Array):void
		{
			ch_talkllibrary=re;
		}
		public static  function get characterTalklibrary():Array
		{
			return ch_talkllibrary;
		}
		
		public static function set player(_data:Object):void
		{
			
			playerdata=_data;
		}
		public static function get player():Object
		{
			
			return playerdata;
		}
		public static function set battleDemo(value:Boolean):void
		{
			_battle=value;
		}
		public static function get battleDemo():Boolean
		{
			return _battle;
		}
		public static function set SaveRecord(list:Array):void
		{
			record=list;
		}
		public static function get SaveRecord():Array
		{
			return 	record;
		}
		public static function currencyFormat(value:Number):String
		{
			var localID:String="CAD"
			var cf:CurrencyFormatter = new CurrencyFormatter(localID); 
			cf.trailingZeros=false;
			/*
			if (cf.formattingWithCurrencySymbolIsSafe("CAD")) {
			trace(cf.actualLocaleIDName);     // "fr-CA French (Canada)"
			trace(cf.format(1254.56, false)); // "1 254,56 $"
			}
			else {
			trace(cf.actualLocaleIDName);     // "en-US English (USA)"
			cf.setCurrency("CAD", "C$")
			trace(cf.format(1254.56, true));  // "C$ 1,254.56"
			}
			*/
			var currecy:String=cf.format(value);
			var num_currency:String=String(currecy.split(localID).join(""));
			return 	num_currency;
		}
		
		/*
		public static function get AssetsData():Object
		{
		
		var assetsData:Object =
		{
		
		cons_1_1:
		{
		cate:"cons",
		name:"Chocolae",
		brand:"Lin",
		price:"20",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE.Must be used during sleep. Only Captain can use this skill during battle. Captain must be in the front row.\nEffect: All enemy will stop moving for one round. "
		},
		cons_1_2:
		{
		cate:"cons",
		name:"Chocolae",
		brand:"Ferro",
		price:"30",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_1_3:
		{
		cate:"cons",
		name:"Chocolae",
		brand:"Nesie",
		price:"10",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_1_4:
		{
		cate:"cons",
		name:"Chocolae",
		brand:"Herley",
		price:"10",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_1_5:
		{
		cate:"cons",
		name:"Chocolae",
		brand:"Godiff",
		price:"50",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_2_1:
		{
		cate:"cons",
		name:"Perfume",
		brand:"Dio",
		price:"20",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_2_2:
		{
		cate:"cons",
		name:"Perfume",
		brand:"S&G",
		price:"30",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_2_3:
		{
		cate:"cons",
		name:"Perfume",
		brand:"Berry",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_2_4:
		{
		cate:"cons",
		name:"Perfume",
		brand:"Chanelle",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_2_5:
		{
		cate:"cons",
		name:"Perfume",
		brand:"Guccy",
		price:"60",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_3_1:
		{
		cate:"cons",
		name:"Flowers",
		brand:"Dio",
		price:"10",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_3_2:
		{
		cate:"cons",
		name:"Flowers",
		brand:"S&G",
		price:"10",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_3_3:
		{
		cate:"cons",
		name:"Flowers",
		brand:"Berry",
		price:"30",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_3_4:
		{
		cate:"cons",
		name:"Flowers",
		brand:"Chanelle",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		cons_3_5:
		{
		cate:"cons",
		name:"Flowers",
		brand:"Guccy",
		price:"20",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_4_1:
		{
		cate:"misc",
		name:"Book",
		brand:"Lenus L.",
		price:"20",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_4_2:
		{
		cate:"misc",
		name:"Book",
		brand:"Ryuji S.",
		price:"30",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_4_3:
		{
		cate:"misc",
		name:"Book",
		brand:"Junta M.",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_4_4:
		{
		cate:"misc",
		name:"Book",
		brand:"Sana R.",
		price:"50",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_4_5:
		{
		cate:"misc",
		name:"Book",
		brand:"Akira K.",
		price:"10",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_5_1:
		{
		cate:"misc",
		name:"Game",
		brand:"Playbox",
		price:"30",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_5_2:
		{
		cate:"misc",
		name:"Game",
		brand:"X-station",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_5_3:
		{
		cate:"misc",
		name:"Game",
		brand:"PC",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_5_4:
		{
		cate:"misc",
		name:"Game",
		brand:"Ninga",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_5_5:
		{
		cate:"misc",
		name:"Game",
		brand:"Handhelds",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_6_1:
		{
		cate:"misc",
		name:"Plush Toy",
		brand:"Pikumon",
		price:"40",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_6_2:
		{
		cate:"misc",
		name:"Plush Toy",
		brand:"Desly",
		price:"80",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_6_3:
		{
		cate:"misc",
		name:"Plush Toy",
		brand:"Teddi",
		price:"30",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_6_4:
		{
		cate:"misc",
		name:"Simgirls",
		brand:"Teddi",
		price:"20",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_6_5:
		{
		cate:"misc",
		name:"Simgirls",
		brand:"Super Heros",
		price:"100",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_10_1:
		{
		cate:"misc",
		name:"Electronic Device",
		brand:"Semseng",
		price:"650",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_10_2:
		{
		cate:"misc",
		name:"Electronic Device",
		brand:"Soni",
		price:"350",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_10_3:
		{
		cate:"misc",
		name:"Electronic Device",
		brand:"Orange",
		price:"400",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_10_4:
		{
		cate:"misc",
		name:"Electronic Device",
		brand:"Blueberry",
		price:"420",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_10_5:
		{
		cate:"misc",
		name:"Electronic Device",
		brand:"Koogle",
		price:"300",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_11_1:
		{
		cate:"misc",
		name:"Art",
		brand:"Vincent",
		price:"1000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_11_2:
		{
		cate:"misc",
		name:"Art",
		brand:"Leonardo",
		price:"1500",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_11_3:
		{
		cate:"misc",
		name:"Art",
		brand:"Pablo",
		price:"2000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_11_4:
		{
		cate:"misc",
		name:"Art",
		brand:"Raphael",
		price:"1000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_11_5:
		{
		cate:"misc",
		name:"Art",
		brand:"Claude",
		price:"2000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_13_1:
		{
		cate:"misc",
		name:"Camera",
		brand:"Canno",
		price:"1100",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_13_2:
		{
		cate:"misc",
		name:"Camera",
		brand:"Niko",
		price:"1200",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_13_3:
		{
		cate:"misc",
		name:"Camera",
		brand:"Pantax",
		price:"1300",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_13_4:
		{
		cate:"misc",
		name:"Camera",
		brand:"Rica",
		price:"2500",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		misc_13_5:
		{
		cate:"misc",
		name:"Camera",
		brand:"Luminar",
		price:"3000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_7_1:
		{
		cate:"app",
		name:"Earrings",
		brand:"Cartia",
		price:"500",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_7_2:
		{
		cate:"app",
		name:"Earrings",
		brand:"Tiffy",
		price:"900",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_7_3:
		{
		cate:"app",
		name:"Earrings",
		brand:"Hermas",
		price:"1500",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_7_4:
		{
		cate:"app",
		name:"Earrings",
		brand:"Oharu",
		price:"750",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_7_5:
		{
		cate:"app",
		name:"Earrings",
		brand:"Chopp",
		price:"950",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_8_1:
		{
		cate:"app",
		name:"Necklace",
		brand:"Cartia",
		price:"950",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_8_2:
		{
		cate:"app",
		name:"Necklace",
		brand:"Tiffy",
		price:"800",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_8_3:
		{
		cate:"app",
		name:"Necklace",
		brand:"Hermas",
		price:"900",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_8_4:
		{
		cate:"app",
		name:"Necklace",
		brand:"Oharu",
		price:"900",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_8_5:
		{
		cate:"app",
		name:"Necklace",
		brand:"Chopp",
		price:"1000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_9_1:
		{
		cate:"app",
		name:"Shoes",
		brand:"Dio",
		price:"1000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_9_2:
		{
		cate:"app",
		name:"Shoes",
		brand:"Berry",
		price:"1300",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_9_3:
		{
		cate:"app",
		name:"Shoes",
		brand:"Bali",
		price:"1400",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_9_4:
		{
		cate:"app",
		name:"Shoes",
		brand:"S&G",
		price:"900",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_9_5:
		{
		cate:"app",
		name:"Shoes",
		brand:"Coast",
		price:"1200",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_12_1:
		{
		cate:"app",
		name:"Small Leather Good",
		brand:"Louis Vernon",
		price:"1500",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_12_2:
		{
		cate:"app",
		name:"Small Leather Good",
		brand:"Hermas",
		price:"1600",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_12_3:
		{
		cate:"app",
		name:"Small Leather Good",
		brand:"Guccy",
		price:"1100",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_12_4:
		{
		cate:"app",
		name:"Small Leather Good",
		brand:"Chanelle",
		price:"1800",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_12_5:
		{
		cate:"app",
		name:"Small Leather Good",
		brand:"Parna",
		price:"2100",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_14_1:
		{
		cate:"app",
		name:"Handbag",
		brand:"Louis",
		price:"2500",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_14_2:
		{
		cate:"app",
		name:"Handbag",
		brand:"Hermas",
		price:"3100",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_14_3:
		{
		cate:"app",
		name:"Handbag",
		brand:"Guccy",
		price:"2800",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_14_4:
		{
		cate:"app",
		name:"Handbag",
		brand:"Chanelle",
		price:"3600",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_14_5:
		{
		cate:"app",
		name:"Handbag",
		brand:"Parna",
		price:"4000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_15_1:
		{
		cate:"app",
		name:"Watch",
		brand:"Rolix",
		price:"120000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_15_2:
		{
		cate:"app",
		name:"Watch",
		brand:"Cartia",
		price:"120000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_15_3:
		{
		cate:"app",
		name:"Watch",
		brand:"Sigma",
		price:"130000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_15_4:
		{
		cate:"app",
		name:"Watch",
		brand:"Hermas",
		price:"150000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_15_5:
		{
		cate:"app",
		name:"Watch",
		brand:"Tinsot",
		price:"900",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_16_1:
		{
		cate:"app",
		name:"Diamond Ring",
		brand:"Cartia",
		price:"130000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_16_2:
		{
		cate:"app",
		name:"Diamond Ring",
		brand:"Tiffy",
		price:"140000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_16_3:
		{
		cate:"app",
		name:"Diamond Ring",
		brand:"Boboli",
		price:"150000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_16_4:
		{
		cate:"app",
		name:"Diamond Ring",
		brand:"Hermas",
		price:"200000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		},
		app_16_5:
		{
		cate:"app",
		name:"Diamond Ring",
		brand:"Chopp",
		price:"10000",
		blackstore:"0",
		data:"images/items/cons_1_1.png",
		exc:"Increase 100% of SE."
		}
		
		
		}
		return assetsData;
		}
		
		*/
		private var chlikesScene:Array;
		public function initChacacterLikeScene():void
		{
			/*
			every character has rating with all scenes
			every scene has random rating(all scenes's rating totle is 100)
			
			*/
			var chls:Object=new Object();
			var characters:Array=Config.characters;
			var scenes:Object=Config.stagepoints;
			
			
			
			//DebugTrace.msg("rendom scene  : "+ran_sceneslist+" ; length : "+ran_sceneslist.length);
			//40% likes-random 100 , 
			for(var i:uint=0;i<characters.length;i++)
			{	
				chlikesScene=new Array();
				var likes:Number=100;
				var ch_name:String=characters[i];
				//var scene_like:Object=new Object();
				var ran_sceneslist:Array=setupRandomSencenLikes();
				//DebugTrace.msg("DataContainer.initChacacterLikeScene ran_sceneslist:"+ran_sceneslist);
				for(var k:uint=0;k<ran_sceneslist.length;k++)
				{
					//every scene rating;
					
					var scene_rating:Object=new Object();
	                
					var reLikes:uint=uint(Math.random()*likes);
					var scene_name:String=ran_sceneslist[k];
					//DebugTrace.msg("scene_name  : "+scene_name);
					if(scene_name=="PrivateIsland" || scene_name=="Airport" || scene_name=="LovemoreMansion" || scene_name=="Hotel" || scene_name=="PoliceStation" || scene_name=="SSCCArena")
					{
						//no people at here
						reLikes=0;
					}
					//scene_like[scene_name]=reLikes;
					//DebugTrace.msg("DataContainer.initChacacterLikeScene scene_name:"+scene_name);
					scene_rating.name=scene_name;
					scene_rating.likes=reLikes;
					
					likes-=reLikes;
					var gress:Number=Math.floor(ran_sceneslist.length*0.4);
					if(likes<50 && k<gress)
					{
						//40% likes:random 50
						likes=50;
					}
					if(k>gress)
					{
						//60% likes:keeping random-20 to 0;
						likes-=20;
						if(likes<0)
						{
							likes=0;
						}
						//if
					}
					//if
					chlikesScene.push(scene_rating);
					
				}
				//for
				
				chlikesScene.sortOn("likes",Array.NUMERIC|Array.DESCENDING);
				//DebugTrace.msg("DataContainer.initChacacterLikeScene chlikesScene:"+JSON.stringify(chlikesScene));
				/*var _scene_like:Object=new Object();
				for(var m:uint=0;m<chlikesScene.length;m++)
				{
					var ratingObj:Object=chlikesScene[m];
					_scene_like[ratingObj.name]=ratingObj.likes;
					DebugTrace.msg("DataContainer.initChacacterLikeScene _scene_like:"+JSON.stringify(_scene_like));
				}*/
				chls[ch_name]=chlikesScene;
				
				//chls[ch_name]=scene_like;
				
			}
			//for
			var chLikes:String=JSON.stringify(chls);
			//DebugTrace.msg("DataContainer.initChacacterLikeScene chLikes:"+chLikes);
			
			//flox.saveSystemData("scenelikes",chls);
			
			flox.save("scenelikes",chls)
			
		}
		private function setupRandomSencenLikes():Array
		{
			var sceneslist:Array=new Array();
			var ran_sceneslist:Array=new Array();
			var scenes:Object=Config.stagepoints;
			for(var scene:String in scenes)
			{
				if(scene!="Hotel")
				{
					sceneslist.push(scene);
				}
			}
			//for
			//make random all scenes 
			var max:uint=sceneslist.length;
			for(var j:uint=0;j<max;j++)
			{
				var index:uint=uint(Math.random()*sceneslist.length);
				ran_sceneslist.push(sceneslist[index]);
				//DebugTrace.msg("rendom scene  : "+sceneslist[index]);
				var _sceneslist:Array=sceneslist.splice(index);
				_sceneslist.shift();
				sceneslist=sceneslist.concat(_sceneslist);
				//DebugTrace.msg("_sceneslist  : "+_sceneslist);
				//DebugTrace.msg("DataContainer.sceneslist  : "+sceneslist +" ; length:"+sceneslist.length);
			}
			//for
			//DebugTrace.msg("DataContainer.sceneslist  : "+ran_sceneslist +" ; length:"+ran_sceneslist.length);
			return ran_sceneslist;
		}
		public static function set seceneLikseSorted(target:String):void
		{
			
			var scenelikes:Object=FloxCommand.savegame.scenelikes;
			var wholikes:Object=scenelikes[target];
			
			sortedlikes=new Array();
			for(var scene:String in wholikes)
			{
				var likes:Object=new Object();
				likes.scene=scene;
				likes.value=uint(wholikes[scene]);
				sortedlikes.push(likes);
			}
			sortedlikes.sortOn(["value"],Array.NUMERIC|Array.DESCENDING);
			/*for(var i:uint=0;i<sortedlikes.length;i++)
			{
				var sortedStr:String=JSON.stringify(sortedlikes[i]);
				DebugTrace.msg("DataContainer.seceneLikseSorted sortedStr:"+sortedStr);
			}*/
			//DebugTrace.msg("DataContainer.seceneLikseSorted _sortedlikes:"+_sortedlikes);
			
		}
		public function setupCharacterSecrets():void
		{
			var flox:FloxInterface=new FloxCommand();
			var secretsData:Object=flox.getSyetemData("secrets");
			var charts:Array=Config.characters;
			var secrets:Object=new Object();
			
			for(var i:uint=0;i<charts.length;i++)
			{
				//every character
				var chname:String=charts[i];
				
				var allAns:Array=new Array();
				for(var id:String in secretsData)
				{
					//secrets id
					var anslist:Array=praseSecretAnswer(secretsData[id]);
					var secretsObj:Object=new Object();
					secretsObj.id=id;
					secretsObj.ans=anslist[i];
					allAns.push(secretsObj);
				}
				secrets[chname]=allAns;
			}
			
			var savegame:SaveGame=FloxCommand.savegame;
			savegame.secrets=secrets;
			FloxCommand.savegame=savegame;
		}
		private function praseSecretAnswer(secrets:Object):Array
		{
			var ran_anslist:Array=new Array();
			var ans:String=secrets.ans;
			var anslist:Array=ans.split(",");
			var maxTimes:Number=anslist.length
			for(var i:uint=0;i<maxTimes;i++)
			{
				var index:uint=uint(Math.random()*anslist.length)
				var ran_ans:String=anslist[index];		
				//DebugTrace.msg("DataContainer.praseSecretAnswer ran_ans:"+ran_ans);
				ran_anslist.push(ran_ans);
				var _anslist:Array=anslist.splice(index)
				//DebugTrace.msg("DataContainer.praseSecretAnswer _anslist:"+_anslist);
				//DebugTrace.msg("DataContainer.praseSecretAnswer anslist:"+anslist);
				_anslist.shift();
				anslist=anslist.concat(_anslist);
				//DebugTrace.msg("DataContainer.praseSecretAnswer anslist:"+anslist);
			}
			//for
			//DebugTrace.msg("DataContainer.praseSecretAnswer sortedStr:"+ran_anslist);
			
			return ran_anslist;
		}
		public static function getFacialMood(name:String):String
		{
			var ch:String=name.toLowerCase();
			var facial:String="";
			var flox:FloxInterface=new FloxCommand();
			var moodObj:Object=flox.getSaveData("mood");
			var mood:Number=moodObj[ch];
			DebugTrace.msg("DataContainer.getFacialMood mood:"+mood);
			if(mood<=-500)
			{
				facial="angry";
			}
			else if(mood>-500 && mood<=-250)
			{
				facial="sad";
			}
			else if(mood>-250 && mood<=-50)
			{
				facial="bored";
			}
			else if(mood>-50 && mood<=50)
			{
				facial="normal";
			}
			else if(mood>50 && mood<=250)
			{
				facial="pleasant";
			}
			else if(mood>250 && mood<=500)
			{
				facial="vhappy";
			}
			else if(mood>500)
			{
				facial="blush";
			}
			return  facial;
		}
		
		public static function get getLikseSorted():Array
		{
			return sortedlikes;
			
		}
		public static function set currentDating(name:String):void
		{
			
			dating=name;
		}
		public static function get currentDating():String
		{
			
			return dating;
		}
		public static function set currentDateIndex(obj:Object):void
		{
			dateIndex=obj;
		}
		public static function get currentDateIndex():Object
		{
			return dateIndex;
		}
		public static  function set scheduleListbrary(data:Array):void
		{
			schedulelist=data;
			
		}
		public static  function get scheduleListbrary():Array
		{
			return schedulelist;
			
		}
		public static function set stonesList(list:Array):void
		{
			stones=list;
		}
		public static function get stonesList():Array
		{
			return stones;
		}
		public static function set survivePlayer(list:Array):void
		{
			surviveplayer=list;
		}
		public static function get survivePlayer():Array
		{
			return surviveplayer;
		}
		public static function set cpuMainTeam(teams:Array):void
		{
			cpu_main_team=teams;
			
		}
		public static function get cpuMainTeam():Array
		{
			return cpu_main_team;
			
		}
		/*public static function set playerMainTeam(teams:Array):void
		{
			player_main_team=teams;
		}
		public static function get playerMainTeam():Array
		{
			return player_main_team;
		}*/
		public static function set PlayerPower(powers:Array):void
		{
			player_powers=powers;
		}
		public static function get PlayerPower():Array
		{
			return player_powers;
		}
		public static function set MembersEffect(eff:Object):void
		{
			memberseffect=eff;
		}
		public static function get MembersEffect():Object
		{
			return memberseffect;
		
		}
		public static function set MembersMail(arr:Array):void
		{
			members_mail=arr;
		}
		public static function get MembersMail():Array
		{
			return members_mail;
		}
		public static function set currentPower(power:Object):void
		{
			_current_power=power;
		}
		public static function get currentPower():Object
		{
			return _current_power;
		}
		public static function set healArea(area:Array):void
		{
			
			_healArea=area;
		}
		public static function get healArea():Array
		{
			
			return _healArea;
		}
		public static function set stageID(value:Number):void
		{
			_stageID=value;
		}
		public static function get stageID():Number
		{
			return _stageID;
		}
		public static function set setCputID(value:Number):void
		{
			cpuID=value;
		}
		public static function get setCputID():Number
		{
			return  cpuID;
		}
	}
}