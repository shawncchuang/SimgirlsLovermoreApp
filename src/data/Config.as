package data
{
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class Config
{
    public static var permision:String="black!@spears#$";
    public static var deadline:Number=20;
    public static var payCoinURL:String="http://localhost:8888/simgilrs/dgpayment/index.php?cate=coin&authkey=";
    public static var payGameURL:String="http://localhost:8888/simgilrs/payment/index.php?cate=game&authkey=";
    private static var points:Object=new Object();
    private static var playerInfo:Object=new Object();
    public static var modelObj:Object={"Male":new Rectangle(0,-20,276,660),
        "Female":new Rectangle(-25,0,240,563)};
    public static var btl_elements:Array=new Array("fire","air","earth","water","neutral","com");
    public static var elements:Array=new Array("fire","air","earth","water","neutral");
    private static var skillssheet:Array=new Array();
    private static var acctype:String;
    private static var authkey:String;
    public static var ExcerptFornt:String="SimFutura";
    public static const allCharacters:Array=["lenus","sirena","dea","sao","klr","tomoru","ceil","zack"];
    public static const cashRate:Object={"lenus":100,
        "sirena":35,"dea":38,"sao":5,"klr":45,"tomoru":25,"ceil":40,"zack":0};
    public static const intRate:Object={"lenus":120,
        "sirena":51,"dea":126,"sao":36,"klr":60,"tomoru":42,"ceil":27,"zack":0};
    public static const imgRate:Object={"lenus":40,
        "sirena":119,"dea":54,"sao":54,"klr":60,"tomoru":98,"ceil":63,"zack":0};
    //zack don't show up in somewhere
    public static const characters:Array=["lenus","sirena","dea","sao","klr","tomoru","ceil"];
    public static const datingCharacters:Array=["lenus","sirena","dea","zack","klr","tomoru","ceil"];
    public static const fullnameCharacters:Array=["Lenus","Sirena","Dea","Zack","Klair","Tomoru","Ceil"];
    public static const CommanderItems:Array=[ { "qty": 3, "id": "com0" },{ "qty": 3, "id": "com1" }, { "qty": 3, "id": "com2" }, { "qty": 3, "id": "com3" } ];
    public static const NPC:Object={"daz":"npc001",
        "policestation":"npc002",
        "sportsbar":"npc003",
        "casino":"npc004",
        "cinema":"npc005",
        "nightclub":"npc006",
        "arena":"npc007",
        "themedpark":"npc008",
        "shoppingmall":"npc009",
        "blackmarket":"npc010",
        "temple":"npc011",
        "hotspring":"npc012",
        "waiter":"npc013",
        "mansion":"npc014",
        "bank":"npc015",
        "dan":"npc016",
        "pier_guy":"npc017",
        "pier_gal":"npc018",
        "airport_guy":"npc019",
        "airport_gal":"npc020",
        "themedpark_boy":"npc021",
        "museum":"npc022",
        "park_guy":"npc023",
        "park_gal":"npc024",
        "primero":"npc025",
        "beach":"npc026",
        "fitnessclub":"npc027",
        "restaurant":"npc028",
        "akira":"npc029",
        "fatman":"npc030",
        "gorilla":"npc031",
        "hooker":"npc032",
        "keir":"npc033",
        "nighthawk":"npc034",
        "o":"npc035",
        "rayden":"npc036",
        "sana":"npc037",
        "shinichi":"npc038",
        "tyren":"npc039",
        "vodka":"npc040",
        "xenos":"npc041",
        "mia":"npc042",
        "primero1":"npc043",
        "rufus":"npc044",
        "simman":"npc045",
        "tiger":"npc046",
        "primero2":"npc047",
        "rufus1":"npc048",
        "rufus2":"npc049",
        "rufus3":"npc050",
        "shinichi1":"npc051",
        "simman1":"npc052",
        "tiger1":"npc053",
        "vodka1":"npc054",
        "simman2":"npc055",

        "ceilkiss":"npc056",
        "deakiss":"npc057",
        "klairekiss":"npc058",
        "lenuskiss":"npc058",
        "sirenakiss":"npc059",
        "tomorukiss":"npc060",
        "zackkiss":"npc061",
        "xenos1":"npc062"
    };
    //schedule [index+ current month]
    public static var scheduleIndex:Object={"lenus":88,"sirena":12,"dea":25,"sao":38,"klr":51,"tomoru":64,"ceil":77,"zack":38};

    public static var Days:Array = new Array("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");
    public static var Months:Object = {
        "Jan": 31, "Feb": 28, "Mar": 31, "Apr": 30, "May": 31, "Jun": 30,
        "Jul": 31, "Aug": 31, "Sep": 30, "Oct": 31, "Nov": 30, "Dec": 31
    }
    public static var Monthslist:Array = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    public static var PickerMonthslist:Array = ["Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];

    public static var gameEndDay:String="Feb_28";

    //battle schedule 2033 Tuesday
    public static var battleDays:Array=[
        "Sep_6","Sep_13","Sep_20","Sep_27",
        "Oct_4","Oct_11","Oct_18","Oct_25",
        "Nov_1","Nov_8","Nov_15","Nov_22","Nov_29",
        "Jan_3","Jan_10","Jan_17","Jan_24","Jan_31"
    ];

    public static var daynightScene:Array=["Main","Beach","Park","Pier","LovemoreMansion"
        ,"Hotel","Garden","FitnessClub","PrivateIsland"];

    public static var relHierarchy:Array=["foe","acquaintance","friend","close friend",
        "dating partner","lover","spouse"];

    public static function  battleSchedule():Dictionary
    {
        var scheduls:Dictionary=new Dictionary();

        scheduls[battleDays[0]]= ["p|0", "2|1", "4|3", "5|6", "7|8"];
        scheduls[battleDays[1]]=["p|1", "0|2", "3|5", "4|7", "8|6"];
        scheduls[battleDays[2]]=["p|3", "4|0", "1|7", "6|2", "8|5"];
        scheduls[battleDays[3]]=["p|2", "0|1", "6|3", "7|5", "4|8"];

        scheduls[battleDays[4]]= ["p|6", "7|0", "5|1", "2|4", "8|3"];
        scheduls[battleDays[5]]= ["p|5", "2|7", "1|3", "6|4", "8|0"];
        scheduls[battleDays[6]]=["p|4", "7|6", "5|0", "2|3", "1|8"];
        scheduls[battleDays[7]]=["p|7", "0|3", "4|5", "6|1", "2|8"];

        scheduls[battleDays[8]]=["p|8", "0|6", "5|2", "1|4", "3|7"];
        scheduls[battleDays[9]]= ["p|0", "2|1", "4|3", "5|6", "7|8"];
        scheduls[battleDays[10]]=["p|1", "0|2", "3|5", "4|7", "8|6"];
        scheduls[battleDays[11]]=["p|3", "4|0", "1|7", "6|2", "8|5"];
        scheduls[battleDays[12]]=["p|2", "0|1", "6|3", "7|5", "4|8"];

        scheduls[battleDays[13]]= ["p|6", "7|0", "5|1", "2|4", "8|3"];
        scheduls[battleDays[14]]= ["p|5", "2|7", "1|3", "6|4", "8|0"];
        scheduls[battleDays[15]]=["p|4", "7|6", "5|0", "2|3", "1|8"];
        scheduls[battleDays[16]]=["p|7", "0|3", "4|5", "6|1", "2|8"];
        scheduls[battleDays[17]]=["p|8", "0|6", "5|2", "1|4", "3|7"];


        return scheduls
    }

    public static function defaultCurrentBattle():Object{
        var defaultCB:Object=new Object();

        for(var i:uint=0;i<battleDays.length;i++){
            defaultCB[battleDays[i]]=["0|0", "0|0", "0|0", "0|0", "0|0"];

        }
//            "Sep_5": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Sep_12": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Sep_19": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Sep_26": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Oct_2": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Oct_9": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Oct_16": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Oct_23": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Oct_30": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Nov_4": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Nov_11": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Nov_18": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Nov_25": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Jan_1": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Jan_8": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Jan_15": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Jan_22": ["0|0", "0|0", "0|0", "0|0", "0|0"],
//            "Jan_29": ["0|0", "0|0", "0|0", "0|0", "0|0"]

        return defaultCB;

    }

    public static var CriminalRanking:Array=[{"rank":"S","se":3200,"rewards":32000},
{"rank":"A","se":2400,"rewards":24000},
{"rank":"B","se":1600,"rewards":16000},
{"rank":"C","se":800,"rewards":8000},
{"rank":"D","se":400,"rewards":4000},
{"rank":"E","se":200,"rewards":2000},
{"rank":"F","se":100,"rewards":1000}];

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
    public static  var teamColors:Object=
    {
        "t0":
        {
            "acc":0xA04A1A,
            "acc_tint":0.5,
            "body":0xFEE169,
            "body_tint":0.5,
            "skin":0xA04A1A,
            "skin_tint":0.5,
            "member":[0xFEE169,0x000000],
            "member_tint":[0.5,0.5]
        },
        "t1":
        {
            "acc":0x3F5134,
            "acc_tint":0.5,
            "body":0x8FAB6E,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0x8FAB6E,0x3F5134],
            "member_tint":[0.5,0.5]
        },
        "t2":
        {
            "acc":0xCC0000,
            "acc_tint":0.5,
            "body":0xFF0000,
            "body_tint":0.5,
            "skin":null,
            "skin_tint":null,
            "member":[0xFF0000,0x000000],
            "member_tint":[0.5,0.5]
        },
        "t3":
        {
            "acc":0x3C74B6,
            "acc_tint":0.5,
            "body":0x36435A,
            "body_tint":0.5,
            "skin":null,
            "skin_tint":null,
            "member":[0x36435A,0x3C74B6],
            "member_tint":[0.5,0.5]
        },
        "t4":
        {
            "acc":0xAC324C,
            "acc_tint":0.5,
            "body":0xFF6DBC,
            "body_tint":0.5,
            "skin":null,
            "skin_tint":null,
            "member":[0xFF6DBC,0xAC324C],
            "member_tint":[0.5,0.5]
        },
        "t5":
        {
            "acc":0x263E33,
            "acc_tint":0.5,
            "body":0x7F9D5D,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0x7F9D5D,0x263E33],
            "member_tint":[0.5,0.5]
        },
        "t6":
        {
            "acc":0x275B80,
            "acc_tint":0.5,
            "body":0x93C8F9,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0x93C8F9,0x275B80],
            "member_tint":[0.5,0.5]
        },
        "t7":
        {
            "acc":0xA83B3B,
            "acc_tint":0.8,
            "body":0xFFFFFF,
            "body_tint":0.8,
            "skin":null,
            "skin_tint":null,
            "member":[0xFFFFFF,0xA83B3B],
            "member_tint":[0.8,0.8]
        },
        "t8":
        {
            "acc":0xBBE8EE,
            "acc_tint":0.8,
            "body":0x2D6392,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":0.6,
            "member":[0x2D6392,0xBBE8EE],
            "member_tint":[0.9,0.8]
        },
        "t11":
        {
            "acc":null,
            "acc_tint":0.5,
            "body":0xCCCCCC,
            "body_tint":0.8,
            "skin":null,
            "skin_tint":null,
            "member":[0xCCCCCC,null],
            "member_tint":[0.9,0.5]

        }

    }
    public static function get allScenes():Array{
        var scenes:Array=["Hotel","Airport","SSCCArena","Academy","SpiritTemple",
                "Museum","PoliceStation","Casino","SportsBar","Nightclub",
                "LovemoreMansion","ShoppingCentre","FitnessClub","Beach","Park",
                "Cinema","Pier","Restaurant","HotSpring","ThemedPark",
                "Bank","PrivateIsland","Garden","BlackMarket","ChangingRoom","CoffeeShop"];
        return scenes;

    }
    public static function get stagepoints():Object
    {
        points={"Hotel":[432,202],"Airport":[988,440],"SSCCArena":[128,790],"Academy":[395,975],"SpiritTemple":[468,847],
            "Museum":[739,765],"PoliceStation":[130,330],"Casino":[690,307],"SportsBar":[245,240],"Nightclub":[480,362],
            "LovemoreMansion":[367,718],"ShoppingCentre":[217,417],"FitnessClub":[764,466],"Beach":[1372,1076],"Park":[1222,515],
            "Cinema":[1427,846],"Pier":[937,540],"Restaurant":[1390,565],"HotSpring":[1132,564],"ThemedPark":[1235,710],
            "Bank":[540,203],"PrivateIsland":[1262,215],"Garden":[548,765],"BlackMarket":[522,589],"ChangingRoom":[1262,984],"CoffeeShop":[600,507]
        };
        return points;
    }
    public static var bossName:Object={
        "t0_0":"chef",
        "t1_0":"vdk",
        "t2_0":"akr",
        "t3_0":"shn",
        "t4_0":"mia",
        "t5_0":"tgr",
        "t6_0":"bdh",
        "t7_0":"xns",
        "t8_0":"gor",
        "t10_0":"fat",
        "t11_0":"fan"
    };
    public static var bossModels:Array=["gor","tgr","fat"];
    public static var ch_bossModels:Array=["mia","bdh","vdk","akr","chef","shn"];
    public static var bossSkill:Object={
        "gor":{
            "lv1":{"skillID":"gor_s_0",
                "label":"GrabPunch",
                "type":"hop",
                "enemy":1,
                "area":2},
            "lv2":{"skillID":"gor_s_1",
                "label":"MultiPunch",
                "type":"m_hop",
                "enemy":3,
                "area":2
            }

        },
        "fat":{
            "pos":new Point(140,900),
            "lv1":{
                "skillID":"fat_s_0",
                "label":"Barf",
                "type":"",
                "enemy":null,
                "area":null
            }
        },
        "tgr":{
            "lv1":{
                "skillID":"tgr_s_0",
                "label":"Grabpunch",
                "type":"hop",
                "enemy":1,
                "area":null
            },
            "lv2":{
                "skillID":"tgr_s_1",
                "label":"Slashes",
                "type":"m_hop",
                "enemy":3,
                "area":0
            },
            "lv3":{
                "skillID":"tgr_s_2",
                "label":"GroupGrab",
                "type":"",
                "enemy":5,
                "area":2
            }

        }

    }
    public static function PlayerAttributes():Object
    {
        //Save Game
        //Wed.1.Jun.2033|12
        playerInfo={
            "next_switch":"s001",
            "current_switch":"s001|on",
            "status":"Normal",
            "cash":1000,
            "first_name":"",
            "last_name":"",
            "date":"Wed.1.Jun.2033|24",
            "ap":100,
            "ap_max":100,
            "dating":"",
            "ch_cash":{
                lenus:5000,
                sirena:1750,
                dea:1875,
                sao:1000,
                klr:2250,
                tomoru:1250,
                ceil:2000,
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
            "command_dating":{
                lenus:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                sirena:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                dea:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                zack:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                sao:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                klr:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                tomoru:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                ceil:{
                    "Kiss":2,
                    "Flirt":4,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                }
            },
            "owned_assets":{
                player:[
                ],
                lenus:[
                ],
                sirena:[

                ],
                dea:[

                ],
                sao:[

                ],
                klr:[

                ],
                tomoru:[

                ],
                ceil:[

                ],
                zack:[

                ]
            },
            "rel":{
                player:"-",
                lenus:"acquaintance",
                sirena:"acquaintance",
                dea:"acquaintance",
                sao:"close friend",
                klr:"acquaintance",
                tomoru:"acquaintance",
                ceil:"acquaintance",
                zack:"foe"
            },
            "pts":{
                player: "-",
                lenus: 0,
                sirena: 0,
                dea: 0,
                sao: 776,
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
                lenus: 120,
                sirena:357,
                dea: 160,
                sao: 162,
                klr: 180,
                tomoru: 294,
                zack: 0,
                ceil: 189
            },
            "wealth":0,
            "int":{
                player:100,
                lenus: 360,
                sirena:153,
                dea: 379,
                sao: 108,
                klr: 180,
                tomoru: 126,
                zack: 100,
                ceil: 81
            },
            "love":{
                //love==Max se
                player:100,
                lenus: 100,
                sirena:100,
                dea: 100,
                sao: 100,
                klr: 100,
                tomoru: 100,
                zack: 0,
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
                    exp:"",
                    fire:"f0",
                    air:"a0",
                    earth:"e0",
                    water:"w0",
                    neutral:"n0",
                    com:"com0,com1"
                },
                "lenus":
                {
                    exp:"w",
                    fire:"f0",
                    air:"a0",
                    earth:"e0",
                    water:"w0,w1",
                    neutral:"n0",
                    com:""
                },
                "sirena":
                {
                    exp:"w",
                    fire:"f0",
                    air:"a0",
                    earth:"e0",
                    water:"w0,w1",
                    neutral:"n0",
                    com:""
                },
                "dea":
                {
                    exp:"n",
                    fire:"f0",
                    air:"a0",
                    earth:"e0",
                    water:"w0",
                    neutral:"n0,n1",
                    com:""
                },
                "sao":
                {
                    exp:"a",
                    fire:"f0",
                    air:"a0,a1",
                    earth:"e0",
                    water:"w0",
                    neutral:"n0",
                    com:""
                },
                "klr":
                {
                    exp:"a",
                    fire:"f0",
                    air:"a0,a1",
                    earth:"e0",
                    water:"w0",
                    neutral:"n0",
                    com:""
                },
                "tomoru":
                {
                    exp:"f",
                    fire:"f0,f1",
                    air:"a0",
                    earth:"e0",
                    water:"w0",
                    neutral:"n0",
                    com:""
                },
                "ceil":
                {
                    exp:"e",
                    fire:"f0",
                    air:"a0",
                    earth:"e0,e1",
                    water:"w0",
                    neutral:"n0",
                    com:""
                },
                "zack":
                {
                    exp:"",
                    fire:"",
                    air:"",
                    earth:"",
                    water:"",
                    neutral:"",
                    com:""
                },
                "captain":[
                    {
                        "qty": 0,
                        "id": "com0"
                    },
                    {
                        "qty": 0,
                        "id": "com1"
                    },
                    {
                        "qty": 0,
                        "id": "com2"
                    },
                    {
                        "qty": 0,
                        "id": "com3"
                    }
                ]
            },
            "avatar":{
                gender:"Male",
                hairstyle:0,
                haircolor:0xFFFFFF,
                skincolor:0xFFFFFF,
                eyescolor:0xFFFFFF,
                features:0,
                clothes:0,
                pants:0,
                uppercolor:0xCCCCCC,
                lowercolor:0xCCCCCC,
                "upperbody": ["0"],
                "lowerbody": ["0"]
            },
            "formation":[

            ],
            "cpu_teams":
            {
                t0_0 : {"seMax":500,"se":500} ,
                t0_1 : {"seMax":500,"se":500} ,
                t0_2 : {"seMax":500,"se":500} ,
                t0_3 : {"seMax":500,"se":500} ,
                t0_4 : {"seMax":500,"se":500} ,
                t0_5 : {"seMax":500,"se":500} ,
                t0_6 : {"seMax":500,"se":500} ,
                t0_7 : {"seMax":500,"se":500} ,

                t1_0 : {"seMax":500,"se":500} ,
                t1_1 : {"seMax":500,"se":500} ,
                t1_2 : {"seMax":500,"se":500} ,
                t1_3 : {"seMax":500,"se":500} ,
                t1_4 : {"seMax":500,"se":500} ,
                t1_5 : {"seMax":500,"se":500} ,
                t1_6 : {"seMax":500,"se":500} ,
                t1_7 : {"seMax":500,"se":500} ,

                t2_0 : {"seMax":500,"se":500} ,
                t2_1 : {"seMax":500,"se":500} ,
                t2_2 : {"seMax":500,"se":500} ,
                t2_3 : {"seMax":500,"se":500} ,
                t2_4 : {"seMax":500,"se":500} ,
                t2_5 : {"seMax":500,"se":500} ,
                t2_6 : {"seMax":500,"se":500} ,
                t2_7 : {"seMax":500,"se":500} ,

                t3_0 : {"seMax":550,"se":550},
                t3_1 : {"seMax":550,"se":550} ,
                t3_2 : {"seMax":550,"se":550} ,
                t3_3 : {"seMax":550,"se":550} ,
                t3_4 : {"seMax":550,"se":550} ,
                t3_5 : {"seMax":550,"se":550} ,
                t3_6 : {"seMax":550,"se":550} ,
                t3_7 : {"seMax":550,"se":550} ,

                t4_0 : {"seMax":600,"se":600} ,
                t4_1 : {"seMax":600,"se":600} ,
                t4_2 : {"seMax":600,"se":600} ,
                t4_3 : {"seMax":600,"se":600} ,
                t4_4 : {"seMax":600,"se":600} ,
                t4_5 : {"seMax":600,"se":600} ,
                t4_6 : {"seMax":600,"se":600} ,
                t4_7 : {"seMax":600,"se":600} ,

                t5_0 : {"seMax":650,"se":650} ,
                t5_1 : {"seMax":650,"se":650} ,
                t5_2 : {"seMax":650,"se":650} ,
                t5_3 : {"seMax":650,"se":650} ,
                t5_4 : {"seMax":650,"se":650} ,
                t5_5 : {"seMax":650,"se":650} ,
                t5_6 : {"seMax":650,"se":650} ,
                t5_7 : {"seMax":650,"se":650} ,

                t6_0 : {"seMax":700,"se":700} ,
                t6_1 : {"seMax":700,"se":700} ,
                t6_2 : {"seMax":700,"se":700} ,
                t6_3 : {"seMax":700,"se":700} ,
                t6_4 : {"seMax":700,"se":700} ,
                t6_5 : {"seMax":700,"se":700} ,
                t6_6 : {"seMax":700,"se":700} ,
                t6_7 : {"seMax":700,"se":700} ,

                t7_0 : {"seMax":750,"se":750} ,
                t7_1 : {"seMax":750,"se":750} ,
                t7_2 : {"seMax":750,"se":750} ,
                t7_3 : {"seMax":750,"se":750} ,
                t7_4 : {"seMax":750,"se":750} ,
                t7_5 : {"seMax":750,"se":750} ,
                t7_6 : {"seMax":750,"se":750} ,
                t7_7 : {"seMax":750,"se":750} ,

                t8_0 : {"seMax":1100,"se":1100} ,
                t8_1 : {"seMax":1100,"se":1100} ,
                t8_2 : {"seMax":1100,"se":1100} ,
                t8_3 : {"seMax":1100,"se":1100} ,
                t8_4 : {"seMax":1100,"se":1100} ,
                t8_5 : {"seMax":1100,"se":1100} ,
                t8_6 : {"seMax":1100,"se":1100} ,
                t8_7 : {"seMax":1100,"se":1100} ,

                t9_0 : {"seMax":"","se":100} ,
                t9_1 : {"seMax":"","se":100} ,
                t9_2 : {"seMax":"","se":100} ,
                t9_3 : {"seMax":"","se":100} ,
                t9_4 : {"seMax":"","se":100} ,
                t9_5 : {"seMax":"","se":100} ,
                t9_6 : {"seMax":"","se":100} ,
                t9_7 : {"seMax":"","se":100},

                t10_0 :{"seMax":1500,"se":1500},
                t10_1 : {"seMax":0,"se":0},
                t10_2 : {"seMax":0,"se":0},
                t10_3 : {"seMax":0,"se":0},
                t10_4 : {"seMax":0,"se":0},
                t10_5 : {"seMax":0,"se":0},
                t10_6 : {"seMax":0,"se":0},
                t10_7 : {"seMax":0,"se":0},

                t11_0 : {"seMax":500,"se":500} ,
                t11_1 : {"seMax":500,"se":500} ,
                t11_2 : {"seMax":500,"se":500} ,
                t11_3 : {"seMax":500,"se":500} ,
                t11_4 : {"seMax":500,"se":500} ,
                t11_5 : {"seMax":500,"se":500} ,
                t11_6 : {"seMax":500,"se":500} ,
                t11_7 : {"seMax":500,"se":500}
            },
            "victory":{ "player":0, "sao": 0, "sirena": 0, "tomoru": 0, "ceil": 0, "dea": 0, "lenus": 0, "klr": 0 },
            "defeat":{"player":0, "sao": 0, "sirena": 0, "tomoru": 0, "ceil": 0, "dea": 0, "lenus": 0, "klr": 0},
            "collapses":{"player":0, "sao": 0, "sirena": 0, "tomoru": 0, "ceil": 0, "dea": 0, "lenus": 0, "klr": 0},
            "skillPts":{
                "player":0,
                "sao": 0,
                "sirena": 0,
                "tomoru":0,
                "ceil": 0,
                "dea": 0,
                "lenus": 0,
                "klr": 00
            },
            "ranking":[
                {"team_id":"player",
                    "name":"Apollyon",
                    "win":0
                },
                {"team_id":"t0",
                    "name":"Vulpecula",
                    "win":0
                },
                {"team_id":"t1",
                    "name":"Lupus",
                    "win":0
                },
                {"team_id":"t2",
                    "name":"Phoenix",
                    "win":0
                },
                {"team_id":"t3",
                    "name":"Serpens",
                    "win":0
                },
                {"team_id":"t4",
                    "name":"Canis Minor",
                    "win":0
                },
                {"team_id":"t5",
                    "name":"Ursa Major",
                    "win":0
                },
                {"team_id":"t6",
                    "name":"Monoceros",
                    "win":0
                },
                {"team_id":"t7",
                    "name":"Draco",
                    "win":0
                },
                {"team_id":"t8",
                    "name":"Zephon",
                    "win":0
                }
            ],
            current_battle:defaultCurrentBattle(),
            "photos":new Array()

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

    public static var relationshipStep:Object={

        "foe-Max":-1,
        "acquaintance-Min":0,
        "acquaintance-Max":76,
        "friend-Min":77,
        "friend-Max":332,
        "closefriend-Min":333,
        "closefriend-Max":776,
        "datingpartner-Min":777,
        "datingpartner-Max":1665,
        "lover-Min":1666,
        "lover-Max":3332,
        "spouse-Min":3333

    }
    public static var moodStep:Object={

        "sickened-Max":-1666,
        "depressed-Min":-1665,
        "depressed-Max":-777,
        "annoyed-Min":-776,
        "annoyed-Max":-333,
        "bored-Min":-332,
        "bored-Max":-111,
        "calm-Min":-110,
        "calm-Max":110,
        "pleased-Min":111,
        "pleased-Max":332,
        "delighted-Min":333,
        "delighted-Max":776,
        "smitten-Min":777,
        "smitten-Max":1665,
        "loved-Min":1666

    }
    public  static var ratingStep:Object={



        "hate-Max":-51,
        "hate-Min":-100,
        "dislike-Max":-1,
        "dislike-Min":-50,
        "normal-Max":29,
        "normal-Min":0,
        "like-Min":30,
        "like-Max":64,
        "love-Min":65,
        "love-Max":100


    }
    public static var styles:Object= {
        "lenus_Garden": ["casual2"],
        "ceil_CoffeeShop": ["work"],
        "sirena_Pier": ["casual3"],
        "lenus_BlackMarket": ["work"],
        "sirena_Academy": ["dojo"],
        "sirena_Restaurant": ["party"],
        "zack_PrivateIsland": ["casual3"],
        "dea_Hotel": ["pj"],
        "dea_Airport": ["casual1"],
        "sirena_HotSpring": ["towel"],
        "lenus_ChangingRoom": ["underwear"],
        "lenus_CoffeeShop": ["work"],
        "klr_SpiritTemple": ["casual1"],
        "zack_Garden": ["casual3"],
        "dea_SSCCArena": ["battle"],
        "klr_Museum": ["casual1"],
        "sirena_ThemedPark": ["work"],
        "tomoru_Hotel": ["pj"],
        "dea_Academy": ["dojo"],
        "klr_PoliceStation": ["work"],
        "sirena_SSCCArena": ["battle"],
        "sirena_Bank": ["casual1"],
        "tomoru_Airport": ["work"],
        "dea_SpiritTemple": ["work"],
        "klr_Casino": ["casual5"],
        "tomoru_SSCCArena": ["battle"],
        "dea_Museum": ["casual1"],
        "klr_SportsBar": ["casual3"],
        "tomoru_Academy": ["dojo"],
        "dea_PoliceStation": ["casual1"],
        "klr_Nightclub": ["club"],
        "zack_BlackMarket": ["casual2"],
        "tomoru_SpiritTemple": ["casual1"],
        "dea_Casino": ["night"],
        "sirena_Airport": ["casual1"],
        "zack_ChangingRoom": ["underwear"],
        "tomoru_Museum": ["casual1"],
        "klr_LovemoreMansion": ["pj"],
        "klr_ShoppingCentre": ["casual4"],
        "zack_CoffeeShop": ["casual2"],
        "dea_SportsBar": ["night"],
        "dea_Nightclub": ["club"],
        "dea_LovemoreMansion": ["pj"],
        "sao_Hotel": ["casual1"],
        "tomoru_PoliceStation": ["casual4"],
        "klr_FitnessClub": ["gym"],
        "klr_Beach": ["swimsuit"],
        "sao_Airport": ["casual1"],
        "sirena_PrivateIsland": ["swimsuit1"],
        "tomoru_Casino": ["night"],
        "dea_ShoppingCentre": ["casual1"],
        "sao_SportsBar": ["casual1"],
        "sao_SSCCArena": ["battle"],
        "tomoru_SportsBar": ["night"],
        "klr_Park": ["casual3"],
        "sao_Nightclub": ["casual1"],
        "sao_Academy": ["dojo"],
        "dea_FitnessClub": ["gym"],
        "sirena_Garden": ["casual3"],
        "sao_LovemoreMansion": ["casual1"],
        "sao_SpiritTemple": ["casual1"],
        "klr_Cinema": ["casual2"],
        "tomoru_Nightclub": ["club"],
        "sao_ShoppingCentre": ["casual1"],
        "sao_Museum": ["casual1"],
        "sirena_BlackMarket": ["work"],
        "sirena_ChangingRoom": ["underwear1", "underwear2"],
        "sao_FitnessClub": ["casual1"],
        "sao_PoliceStation": ["casual1"],
        "klr_Pier": ["casual3"],
        "dea_Beach": ["swimsuit1", "swimsuit2"],
        "tomoru_Cinema": ["casual2"],
        "sao_Casino": ["casual1"],
        "klr_Restaurant": ["party"],
        "sao_Beach": ["swimsuit"],
        "sao_Park": ["casual1"],
        "tomoru_LovemoreMansion": ["pj"],
        "klr_HotSpring": ["towel"],
        "dea_Cinema": ["casual2"],
        "sao_Cinema": ["casual1"],
        "tomoru_ShoppingCentre": ["casual1"],
        "klr_SSCCArena": ["battle"],
        "dea_Restaurant": ["party1", "party2"],
        "sirena_CoffeeShop": ["casual3"],
        "tomoru_HotSpring": ["towel"],
        "dea_Park": ["casual3"],
        "klr_Academy": ["dojo"],
        "dea_HotSpring": ["towel"],
        "sao_Pier": ["casual1"],
        "tomoru_ThemedPark": ["casual2"],
        "tomoru_Beach": ["swimsuit"],
        "klr_PrivateIsland": ["swimsuit"],
        "sao_Restaurant": ["party"],
        "tomoru_Bank": ["casual1"],
        "dea_Pier": ["casual3"],
        "dea_Bank": ["casual1"],
        "sao_HotSpring": ["casual1"],
        "klr_CoffeeShop": ["work"],
        "tomoru_FitnessClub": ["gym"],
        "klr_Hotel": ["pj"],
        "dea_PrivateIsland": ["swimsuit1"],
        "tomoru_PrivateIsland": ["swimsuit"],
        "ceil_Hotel": ["pj"],
        "klr_Airport": ["casual5"],
        "sao_ThemedPark": ["casual1"],
        "dea_ChangingRoom": ["underwear"],
        "ceil_Airport": ["casual1"],
        "tomoru_Park": ["casual3"],
        "dea_ThemedPark": ["casual3"],
        "tomoru_Garden": ["casual2"],
        "dea_CoffeeShop": ["casual2"],
        "ceil_SSCCArena": ["battle"],
        "klr_ThemedPark": ["casual2"],
        "klr_Garden": ["casual4"],
        "tomoru_BlackMarket": ["casual4"],
        "lenus_Hotel": ["pj"],
        "sirena_Hotel": ["pj"],
        "klr_Bank": ["casual1"],
        "klr_BlackMarket": ["work"],
        "tomoru_ChangingRoom": ["underwear"],
        "ceil_Academy": ["dojo"],
        "ceil_SpiritTemple": ["casual1"],
        "tomoru_Restaurant": ["party"],
        "dea_Garden": ["work"],
        "lenus_Airport": ["casual1"],
        "lenus_SSCCArena": ["battle"],
        "ceil_Museum": ["casual1"],
        "dea_BlackMarket": ["casual2"],
        "tomoru_CoffeeShop": ["work"],
        "lenus_Academy": ["dojo"],
        "ceil_PoliceStation": ["casual1"],
        "sao_Bank": ["casual1"],
        "tomoru_Pier": ["casual3"],
        "zack_Hotel": ["underwear"],
        "lenus_SpiritTemple": ["casual1"],
        "ceil_Casino": ["night"],
        "klr_ChangingRoom": ["underwear"],
        "sao_PrivateIsland": ["casual1"],
        "sirena_FitnessClub": ["gym"],
        "zack_Airport": ["casual1"],
        "lenus_Museum": ["work"],
        "ceil_SportsBar": ["work"],
        "sao_Garden": ["casual1"],
        "zack_SSCCArena": ["battle"],
        "lenus_PoliceStation": ["work"],
        "ceil_Nightclub": ["club"],
        "sao_BlackMarket": ["casual1"],
        "sirena_ShoppingCentre": ["casual1"],
        "zack_SpiritTemple": ["casual1"],
        "lenus_Casino": ["casual1"],
        "ceil_LovemoreMansion": ["pj"],
        "sao_ChangingRoom": ["casual1"],
        "zack_Museum": ["casual1"],
        "lenus_SportsBar": ["casual2"],
        "ceil_ShoppingCentre": ["casual1"],
        "sao_CoffeeShop": ["casual1"],
        "sirena_LovemoreMansion": ["pj"],
        "zack_PoliceStation": ["casual2"],
        "lenus_Nightclub": ["club"],
        "ceil_FitnessClub": ["gym"],
        "zack_Casino": ["casual2"],
        "lenus_LovemoreMansion": ["casual2"],
        "ceil_Beach": ["swimsuit1", "swimsuit2", "swimsuit3"],
        "zack_Academy": ["casual3"],
        "sirena_Nightclub": ["club"],
        "zack_SportsBar": ["casual2"],
        "lenus_ShoppingCentre": ["casual3"],
        "ceil_Park": ["casual2"],
        "zack_Nightclub": ["club"],
        "lenus_FitnessClub": ["gym"],
        "ceil_Cinema": ["casual2"],
        "sirena_SportsBar": ["casual2"],
        "zack_LovemoreMansion": ["casual3"],
        "lenus_Beach": ["swimsuit"],
        "sirena_Cinema": ["casual2"],
        "zack_ShoppingCentre": ["casual2"],
        "ceil_Pier": ["casual2"],
        "ceil_Restaurant": ["party"],
        "sirena_Casino": ["night"],
        "lenus_Park": ["casual2"],
        "lenus_Cinema": ["casual3"],
        "ceil_HotSpring": ["towel"],
        "zack_FitnessClub": ["gym"],
        "lenus_Pier": ["casual3"],
        "ceil_ThemedPark": ["casual2"],
        "sirena_PoliceStation": ["casual2"],
        "zack_Park": ["casual3"],
        "lenus_Restaurant": ["casual2"],
        "zack_Pier": ["casual3"],
        "sirena_Park": ["casual3"],
        "zack_Cinema": ["casual2"],
        "ceil_Bank": ["casual1"],
        "ceil_PrivateIsland": ["swimsuit1"],
        "sirena_Museum": ["casual1"],
        "lenus_HotSpring": ["towel"],
        "lenus_ThemedPark": ["casual2"],
        "zack_HotSpring": ["towel"],
        "zack_Restaurant": ["party"],
        "ceil_Garden": ["casual2"],
        "zack_ThemedPark": ["casual2"],
        "zack_Beach": ["swimsuit"],
        "sirena_SpiritTemple": ["casual1"],
        "lenus_Bank": ["casual1"],
        "ceil_BlackMarket": ["casual2"],
        "zack_Bank": ["casual1"],
        "sirena_Beach": ["swimsuit1", "swimsuit2"],
        "lenus_PrivateIsland": ["swimsuit"],
        "ceil_ChangingRoom": ["underwear"]
    }

    public static var goodevails:Object={

        "airplane-phonenumber":[-10,10],
        "qa-s006b":[10,-10]

    }
    public function Config()
    {

    }

}

}

