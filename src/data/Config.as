package data
{
	public class Config
	{
		public static var deadline:Number=20;
		public static var payCoinURL:String="http://localhost:8888/simgilrs/index.php?cate=coin&authkey=";
		public static var payGameURL:String="http://localhost:8888/simgilrs/index.php?cate=game&authkey=";
		private static var points:Object=new Object();
		private static var playerInfo:Object=new Object();
		public static var btl_elements:Array=new Array("fire","air","earth","water","neutral","com");
		public static var elements:Array=new Array("fire","air","earth","water","neutral");
		private static var skillssheet:Array=new Array();
		private static var acctype:String;
		private static var authkey:String;
		public static var ExcerptFornt:String="Futura";
		public static const characters:Array=["lenus","sirena","dea","sao","klr","tomoru","ceil","zack"];
		
		public static const facial_moods:Array=["angry","blush","bored","normal","pleasant","sad","scared","sick","vhappy"];
		public static var scheduleIndex:Object={"lenus":0,"sirena":12,"dea":25,"sao":38,"klr":51,"tomoru":64,"ceil":77,"zack":90};
		
		//battle schedule 2022 Tuesday
		public static var team_schedule:Array=["Mar_1","Mar_8","Mar_15","Mar_22","Mar_29",
			"Apr_5","Apr_12","Apr_19","Apr_26",
			"May_3","May_10","May_17","May_24","May_31",
			"Jun_7","Jun_14","Jun_21","Jun_28",
			"Jul_5","Jul_12","Jul_19","Jul_26",
			"Aug_2","Aug_9","Aug_16","Aug_23","Aug_30",
			"Sep_6","Sep_13","Sep_20","Sep_27",
			"Oct_4","Oct_11","Oct_18","Oct_25",
			"Nov_1","Nov_8","Nov_15","Nov_22","Nov_29",
			"Dec_6","Dec_13","Dec_20","Dec_27"
			
		]
		public static var PlayerItems:Array=[{id:"com0",qty:100},
			{id:"com1",qty:10}];
		public static function set AccType(value:String):void
		{
			acctype=value;
		}
		public static function get AccType():String
		{
			return acctype;
		}
		public static function set verifyKey(value:String):void
		{
			authkey=value;
		}
		public static function get verifyKey():String
		{
			return authkey;
		}
		public static function get stagepoints():Object
		{
			points={"Hotel":[432,202],"Airport":[988,440],"SSCCArena":[128,790],"SMAAcademy":[395,975],"SpiritTemple":[468,847],
				"Museum":[739,765],"PoliceStation":[130,330],"Casino":[690,307],"SportsBar":[550,500],"Nightclub":[480,362],
				"LovemoreMansion":[367,718],"ShoppingCentre":[217,417],"FitnessClub":[764,466],"Beach":[1372,1076],"Park":[1222,515],
				"Cinema":[1427,846],"Pier":[937,540],"Restaurant":[1390,565],"HotSpring":[1132,564],"ThemedPark":[1235,710],
				"Bank":[540,203],"PrivateIsland":[1262,215],"Garden":[548,765],"BlackMarket":[522,589],"ChangingRoom":[1262,984],"Lounge":[640,470]
			};
			return points;
		}
		
		public static function PlayerAttributes():Object
		{
			//rel(relation):"stranger","new friend","good friend","close friend","girlfriend","lover","wife"
			//
			playerInfo={
				"status":"Normal",
				"cash":100000,
				"first_name":"",
				"last_name":"",
				"date":"Tue.1.Mar.2022|12",
				"ap":100,
				"max_ap":100,
				"dating":null,
				"ch_cash":{
					lenus:500,
					sirena:100,
					dea:200,
					sao:200,
					klr:0,
					tomoru:300,
					ceil:200,
					zack:1000000
				},
				"estate":{
					player:"re0,re1,re2,re3,re4,re5,re6,re7",
					lenus:"re0,re1",
					sirena:"",
					dea:"re0,re1,re2,re3,re4,re5,re6,re7",
					sao:"re0,re1",
					klr:"",
					tomoru:"re0,re1,re2",
					ceil:"re0,re1",
					zack:"re0"
				},
				"accessories":{
					player:"acc0,acc1,acc2,acc3,acc4,acc5,acc6,acc7",
					lenus:"acc0,acc1",
					sirena:"",
					dea:"acc0,acc1,acc2,acc3,acc4,acc5,acc6,acc7",
					sao:"acc0,acc1",
					klr:"",
					tomoru:"acc0,acc1,acc2",
					ceil:"acc0,acc1",
					zack:"acc0"
				},
				"gifts":{
					player:"gift0,gift1,gift2,gift3,gift4,gift5,gift6,gift7",
					lenus:"gift0,gift1",
					sirena:"",
					dea:"gift0,gift1,gift2,gift3,gift4,gift5,gift6,gift7",
					sao:"gift0,gift1",
					klr:"",
					tomoru:"gift0,gift1,gift2",
					ceil:"gift0,gift1",
					zack:"gift0"
				},
				"owned_assets":{
					player:[
						
					],
					lenus:[
						{id:"cons_1_1",qty:1,opsleteIn:22}, 
						{id:"cons_1_2",qty:1,opsleteIn:88}, 
						{id:"cons_1_3",qty:2,opsleteIn:44},
						{id:"cons_1_4",qty:5,opsleteIn:77},
						{id:"cons_1_5",qty:1,opsleteIn:33},
						{id:"cons_2_1",qty:1,opsleteIn:77},
						{id:"cons_2_3",qty:2,opsleteIn:22},
						{id:"cons_2_4",qty:1,opsleteIn:68},
						{id:"cons_2_2",qty:1,opsleteIn:25}
					],
					sirena:[
						{id:"cons_1_1",qty:1,opsleteIn:31}, 
						{id:"cons_1_2",qty:1,opsleteIn:9}, 
						{id:"cons_1_3",qty:2,opsleteIn:77},
						{id:"cons_1_5",qty:1,opsleteIn:34},
						{id:"cons_2_1",qty:1,opsleteIn:89},
						{id:"cons_2_2",qty:1,opsleteIn:323},
						{id:"cons_2_4",qty:1,opsleteIn:777},
						{id:"cons_2_5",qty:1,opsleteIn:33},
					],
					dea:[
						{id:"cons_1_1",qty:1,opsleteIn:99}, 
						{id:"cons_1_2",qty:1,opsleteIn:322}, 
						{id:"cons_1_3",qty:1,opsleteIn:772},
						{id:"cons_1_4",qty:1,opsleteIn:390},
						{id:"cons_1_5",qty:1,opsleteIn:30},
						{id:"cons_2_1",qty:1,opsleteIn:70},
						{id:"cons_2_2",qty:1,opsleteIn:25},
						{id:"cons_2_3",qty:1,opsleteIn:87},
						{id:"cons_2_4",qty:1,opsleteIn:32},
						{id:"cons_2_5",qty:1,opsleteIn:311},
						{id:"misc_4_1",qty:1,opsleteIn:88},
						{id:"misc_4_2",qty:1,opsleteIn:356},
						{id:"misc_4_3",qty:1,opsleteIn:3},
						{id:"misc_4_4",qty:1,opsleteIn:68},
						{id:"misc_4_5",qty:1,opsleteIn:66}
					],
					sao:[
						{id:"cons_1_1",qty:3,opsleteIn:32}, 
						{id:"cons_1_2",qty:1,opsleteIn:10}, 
						{id:"cons_1_3",qty:10,opsleteIn:55},
						{id:"cons_1_4",qty:1,opsleteIn:22},
						{id:"cons_1_5",qty:12,opsleteIn:37},
						{id:"cons_2_1",qty:1,opsleteIn:55}
					],
					klr:[],
					tomoru:[],
					ceil:[],
					zack:[]
				},
				"rel":{
					player:"-",
					lenus:"stranger",
					sirena:"stranger",
					dea:"stranger",
					sao:"stranger",
					klr:"stranger",
					tomoru:"stranger",
					ceil:"stranger",
					zack:"stranger"
				},
				"pts":{
					player: "-",
					lenus: 0,
					sirena: 0,
					dea: 0,
					sao: 0,
					klr: 0,
					tomoru: 0,
					ceil: 0,
					zack: 0
				},
				"mood":{
					lenus: 0,
					sirena: 0,
					dea: 0,
					sao: 0,
					klr: 0,
					tomoru: 0,
					ceil: 0,
					zack: 0
				},
				"rank":["private"],
				"honor":{
					player:0,
					lenus: 0,
					sirena:0,
					dea: 0,
					sao: 0,
					klr: 0,
					tomoru: 0,
					zack: 0,
					ceil: 0
				},
				"image":{
					player:100,
					lenus: 0,
					sirena:0,
					dea: 0,
					sao: 0,
					klr: 0,
					tomoru: 0,
					zack: 0,
					ceil: 0
				},
				"wealth":0,
				"int":{
					player:100,
					lenus: 100,
					sirena:100,
					dea: 100,
					sao: 100,
					klr: 100,
					tomoru: 100,
					zack: 100,
					ceil: 100
				},
				"love":{
					player:100,
					lenus: 100,
					sirena:100,
					dea: 100,
					sao: 100,
					klr: 100,
					tomoru: 100,
					zack: 100,
					ceil: 100
				},
				"se":{
					lenus: 100,
					sirena: 100,
					dea: 100,
					sao: 100,
					klr: 100,
					tomoru: 100,
					ceil: 100,
					zack: 0,
					player:100
				},
				"s_ele":"air",
				"skills":
				{
					"player":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:"com0,com1"
					},
					"lenus":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:""
					},
					"sirena":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:""
					},
					"dea":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"n0,n1,n2,n3",
						com:""
					},
					"sao":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:""
					},
					"klr":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:""
					},
					"tomoru":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"n0,n1,n2,n3",
						com:""
					},
					"ceil":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:""
					},
					"zack":
					{
						fire:"f0,f1,f2,f3",
						air:"a0,a1,a2,a3",
						earth:"e0,e1,e2,e3",
						water:"w0,w1,w2,w3",
						neutral:"",
						com:""
					}
				},	 
				"avatar":{
					gender:"Male",
					hairstyle:0,
					haircolor:0xFFFFFF,
					skincolor:0xFFFFFF,
					eyescolor:0xFFFFFF,
					features:0,
					clothes:0,
					pants:0
				},
				"formation":[
					
				],
				"cpu_teams":
				{
					t0_0 : {"seMax":100,"se":50} ,
					t0_1 : {"seMax":100,"se":50} ,
					t0_2 : {"seMax":100,"se":50} ,
					t0_3 : {"seMax":100,"se":50} ,
					t0_4 : {"seMax":100,"se":50} ,
					t0_5 : {"seMax":100,"se":50} ,
					t0_6 : {"seMax":100,"se":50} ,
					t0_7 : {"seMax":100,"se":50} ,
					t1_0 : {"seMax":"","se":100} ,
					t1_1 : {"seMax":"","se":100} ,
					t1_2 : {"seMax":"","se":100} ,
					t1_3 : {"seMax":"","se":100} ,
					t1_4 : {"seMax":"","se":100} ,
					t1_5 : {"seMax":"","se":100} ,
					t1_6 : {"seMax":"","se":100} ,
					t1_7 : {"seMax":"","se":100} ,
					t2_0 : {"seMax":"","se":100} ,
					t2_1 : {"seMax":"","se":100} ,
					t2_2 : {"seMax":"","se":100} ,
					t2_3 : {"seMax":"","se":100} ,
					t2_4 : {"seMax":"","se":100} ,
					t2_5 : {"seMax":"","se":100} ,
					t2_6 : {"seMax":"","se":100} ,
					t2_7 : {"seMax":"","se":100} ,
					t3_0 : {"seMax":"","se":100} ,
					t3_1 : {"seMax":"","se":100} ,
					t3_2 : {"seMax":"","se":100} ,
					t3_3 : {"seMax":"","se":100} ,
					t3_4 : {"seMax":"","se":100} ,
					t3_5 : {"seMax":"","se":100} ,
					t3_6 : {"seMax":"","se":100} ,
					t3_7 : {"seMax":"","se":100} ,
					t4_0 : {"seMax":"","se":100} ,
					t4_1 : {"seMax":"","se":100} ,
					t4_2 : {"seMax":"","se":100} ,
					t4_3 : {"seMax":"","se":100} ,
					t4_4 : {"seMax":"","se":100} ,
					t4_5 : {"seMax":"","se":100} ,
					t4_6 : {"seMax":"","se":100} ,
					t4_7 : {"seMax":"","se":100} ,
					t5_0 : {"seMax":"","se":100} ,
					t5_1 : {"seMax":"","se":100} ,
					t5_2 : {"seMax":"","se":100} ,
					t5_3 : {"seMax":"","se":100} ,
					t5_4 : {"seMax":"","se":100} ,
					t5_5 : {"seMax":"","se":100} ,
					t5_6 : {"seMax":"","se":100} ,
					t5_7 : {"seMax":"","se":100} ,
					t6_0 : {"seMax":"","se":100} ,
					t6_1 : {"seMax":"","se":100} ,
					t6_2 : {"seMax":"","se":100} ,
					t6_3 : {"seMax":"","se":100} ,
					t6_4 : {"seMax":"","se":100} ,
					t6_5 : {"seMax":"","se":100} ,
					t6_6 : {"seMax":"","se":100} ,
					t6_7 : {"seMax":"","se":100} ,
					t7_0 : {"seMax":"","se":100} ,
					t7_1 : {"seMax":"","se":100} ,
					t7_2 : {"seMax":"","se":100} ,
					t7_3 : {"seMax":"","se":100} ,
					t7_4 : {"seMax":"","se":100} ,
					t7_5 : {"seMax":"","se":100} ,
					t7_6 : {"seMax":"","se":100} ,
					t7_7 : {"seMax":"","se":100} ,
					t8_0 : {"seMax":"","se":100} ,
					t8_1 : {"seMax":"","se":100} ,
					t8_2 : {"seMax":"","se":100} ,
					t8_3 : {"seMax":"","se":100} ,
					t8_4 : {"seMax":"","se":100} ,
					t8_5 : {"seMax":"","se":100} ,
					t8_6 : {"seMax":"","se":100} ,
					t8_7 : {"seMax":"","se":100} ,
					t9_0 : {"seMax":"","se":100} ,
					t9_1 : {"seMax":"","se":100} ,
					t9_2 : {"seMax":"","se":100} ,
					t9_3 : {"seMax":"","se":100} ,
					t9_4 : {"seMax":"","se":100} ,
					t9_5 : {"seMax":"","se":100} ,
					t9_6 : {"seMax":"","se":100} ,
					t9_7 : {"seMax":"","se":100}
				}
				
				
			}
			
			return playerInfo;
		}
		
		/*
		"avatar":'{'+
		'"gender":"Male",'+
		'"hairstyle":"0",'+
		'"haircolor":"0xFFFFFF",'+
		'"skincolor":"0xFFFFFF",'+
		'"eyescolor":"0xFFFFFF",'+
		'"features":"0"'
		+'}'
		
		"avatar":{
		gender:"Male",
		hairstyle:0,
		haircolor:0xFFFFFF,
		skincolor:0xFFFFFF,
		eyescolor:0xFFFFFF,
		features:0
		}
		*/
		 
		
		public function Config()
		{
			
		}
		
	}
	
}

