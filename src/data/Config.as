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
    //public static var payCoinURL:String="http://blackspears.com/black-market.html";
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
    public static const fullnameCharacters:Array=["Lenus","Sirena","Dea","Zack","Klaire","Tomoru","Ceil"];
    public static const fullnames:Object={"lenus":"Lenus","sirena":"Sirena","dea":"Dea","zack":"Zack",
        "klr":"Klaire","tomoru":"Tomoru","ceil":"Ceil"};
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
        "klrkiss":"npc058",
        "lenuskiss":"npc059",
        "sirenakiss":"npc060",
        "tomorukiss":"npc061",
        "zackkiss":"npc068",

        "xenos1":"npc062",
        "sana1":"npc063",
        "akira1":"npc064",
        "akira2":"npc065",
        "restaurant1":"npc066",
        "restaurant2":"npc067"

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

    //boss battle
    public static var gameEndDay:String="Feb_28";

    /*
    public static var battleDays:Array=[
        "Sep_6","Sep_13","Sep_20","Sep_27",
        "Oct_4","Oct_11","Oct_18","Oct_25",
        "Nov_1","Nov_8","Nov_15","Nov_22","Nov_29",
        "Jan_3","Jan_10","Jan_17","Jan_24","Jan_31"
    ];
    */
    public static var battleDays:Array=[
        "Jan_1","Jan_8","Jan_15","Jan_22",
        "Jan_29", "Feb_5","Feb_12","Feb_19",
        "Feb_26"
    ];

    public static var daynightScene:Array=["Main","Beach","Park","Pier","LovemoreMansion"
        ,"Hotel","Garden","FitnessClub","PrivateIsland"];

    public static var relHierarchy:Array=["foe","acquaintance","friend","close friend",
        "dating partner","lover","spouse"];

    public static function  battleSchedule():Dictionary
    {
        var scheduls:Dictionary=new Dictionary();

        scheduls[battleDays[0]]=["p|0", "2|1", "4|3", "5|6", "7|8"];
        scheduls[battleDays[1]]=["p|1", "0|2", "3|5", "4|7", "8|6"];
        scheduls[battleDays[2]]=["p|2", "0|1", "6|3", "7|5", "4|8"];
        scheduls[battleDays[3]]=["p|3", "4|0", "1|7", "6|2", "8|5"];
        scheduls[battleDays[4]]=["p|4", "7|6", "5|0", "2|3", "1|8"];
        scheduls[battleDays[5]]=["p|5", "2|7", "1|3", "6|4", "8|0"];
        scheduls[battleDays[6]]=["p|6", "7|0", "5|1", "2|4", "8|3"];
        scheduls[battleDays[7]]=["p|7", "0|3", "4|5", "6|1", "2|8"];
        scheduls[battleDays[8]]=["p|8", "0|6", "5|2", "1|4", "3|7"];
       /*
        scheduls[battleDays[9]]= ["p|0", "2|1", "4|3", "5|6", "7|8"];
        scheduls[battleDays[10]]=["p|1", "0|2", "3|5", "4|7", "8|6"];
        scheduls[battleDays[11]]=["p|3", "4|0", "1|7", "6|2", "8|5"];
        scheduls[battleDays[12]]=["p|2", "0|1", "6|3", "7|5", "4|8"];

        scheduls[battleDays[13]]= ["p|6", "7|0", "5|1", "2|4", "8|3"];
        scheduls[battleDays[14]]= ["p|5", "2|7", "1|3", "6|4", "8|0"];
        scheduls[battleDays[15]]=["p|4", "7|6", "5|0", "2|3", "1|8"];
        scheduls[battleDays[16]]=["p|7", "0|3", "4|5", "6|1", "2|8"];
        scheduls[battleDays[17]]=["p|8", "0|6", "5|2", "1|4", "3|7"];
        */

        return scheduls
    }

    public static function defaultCurrentBattle():Object{
        var defaultCB:Object=new Object();

        for(var i:uint=0;i<battleDays.length;i++){
            defaultCB[battleDays[i]]=["0|0", "0|0", "0|0", "0|0", "0|0"];

        }

        return defaultCB;

    }

    public static var CriminalRanking:Array=[{"rank":"S","se":7000,"rewards":1600},
        {"rank":"A","se":5000,"rewards":1300},
        {"rank":"B","se":3500,"rewards":1000},
        {"rank":"C","se":2000,"rewards":800},
        {"rank":"D","se":1000,"rewards":600},
        {"rank":"E","se":500,"rewards":450},
        {"rank":"F","se":200,"rewards":300}];

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
            "acc":0x972517,
            "acc_tint":0.5,
            "body":0xF56B33,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0xF56B33,0x972517],
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
            "acc":0x0000CC,
            "acc_tint":0.5,
            "body":0x6666FF,
            "body_tint":0.5,
            "skin":null,
            "skin_tint":null,
            "member":[0x6666FF,0x0000CC],
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
        "t9_0":"practice",
        "t10_0":"fat",
        "t11_0":"fan",
        "t12_0":"rfs",
        "t13_0":"rvn",
        "t14_0":"nhk",
        "t15_0":"gor"
    };
    public static var bossModels:Array=["gor","tgr","fat","rfs","rvn","nhk"];
    public static var ch_bossModels:Array=["mia","bdh","vdk","akr","chef","shn"];
    public static var bossSkill:Object={
        "gor":{
            "pos":new Point(180,988),
            "lv2":{
                "skillID":"gor_s_0",
                "label":"GrabPunch",
                "type":"hop",
                "enemy":1,
                "area":2
            },
            "lv3":{
                "skillID":"gor_s_1",
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

        },
        "rfs":{
            "pos":new Point(180,988),
            "lv1":{
                "skillID":"rfs_s_0",
                "label":"Grabpunch",
                "type":"hop",
                "enemy":1,
                "area":null
            },
            "lv2":{
                "skillID":"rfs_s_1",
                "label":"Uppercut",
                "type":"",
                "enemy":5,
                "area":null
            },
            "lv3":{
                "skillID":"rfs_s_2",
                "label":"EnergyBall",
                "type":"",
                "enemy":5,
                "area":null
            },
            "lv4":{
                "skillID":"rfs_s_3",
                "label":"SPArmour",
                "type":"",
                "enemy":0,
                "area":null
            }
        },
        "rvn":{
            "pos":new Point(170,988),
            "lv2":{
                "skillID":"rvn_s_1",
                "label":"ATK",
                "type":"",
                "enemy":2,
                "area":2
            },
            "lv3":{
                "skillID":"rvn_s_2",
                "label":"MultiATK",
                "type":"",
                "enemy":5,
                "area":null
            }
        },
        "nhk":{
            "pos":new Point(170,988),
            "lv1":{
                "skillID":"nhk_s_0",
                "label":"FKick",
                "type":"hop",
                "enemy":1,
                "area":0
            },
            "lv2":{
                "skillID":"nhk_s_1",
                "label":"FDrillKick",
                "type":"hop",
                "enemy":2,
                "area":2
            },
            "lv3":{
                "skillID":"nhk_s_2",
                "label":"SP",
                "type":"",
                "enemy":4,
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
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                sirena:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                dea:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                zack:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                sao:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                klr:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                tomoru:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
                },
                ceil:{
                    "Kiss":1,
                    "Flirt":4,
                    "TakePhoto":1,
                    "Chat":6,
                    "Date":1,
                    "Give":1
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
                sao: 700,
                klr: 0,
                tomoru: 0,
                ceil: 0,
                zack: -300
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
                player:200,
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
                player:200,
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
                player:200,
                lenus: 200,
                sirena:200,
                dea: 200,
                sao: 200,
                klr: 200,
                tomoru: 200,
                zack: 200,
                ceil: 200
            },
            "se":{
                lenus: 200,
                sirena: 200,
                dea: 200,
                sao: 200,
                klr: 200,
                tomoru: 200,
                ceil: 200,
                zack: 200,
                player:200
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
                t0_0 : {"seMax":3000,"se":3000} ,
                t0_1 : {"seMax":1500,"se":1500} ,
                t0_2 : {"seMax":1500,"se":1500} ,
                t0_3 : {"seMax":1500,"se":1500} ,
                t0_4 : {"seMax":1500,"se":1500} ,
                t0_5 : {"seMax":1500,"se":1500} ,
                t0_6 : {"seMax":1500,"se":1500} ,
                t0_7 : {"seMax":1500,"se":1500} ,

                t1_0 : {"seMax":4500,"se":4500} ,
                t1_1 : {"seMax":2250,"se":2250} ,
                t1_2 : {"seMax":2250,"se":2250} ,
                t1_3 : {"seMax":2250,"se":2250} ,
                t1_4 : {"seMax":2250,"se":2250} ,
                t1_5 : {"seMax":2250,"se":2250} ,
                t1_6 : {"seMax":2250,"se":2250} ,
                t1_7 : {"seMax":2250,"se":2250} ,

                t2_0 : {"seMax":6000,"se":6000} ,
                t2_1 : {"seMax":3000,"se":3000} ,
                t2_2 : {"seMax":3000,"se":3000} ,
                t2_3 : {"seMax":3000,"se":3000} ,
                t2_4 : {"seMax":3000,"se":3000} ,
                t2_5 : {"seMax":3000,"se":3000} ,
                t2_6 : {"seMax":3000,"se":3000} ,
                t2_7 : {"seMax":3000,"se":3000} ,

                t3_0 : {"seMax":7500,"se":7500},
                t3_1 : {"seMax":3750,"se":3750} ,
                t3_2 : {"seMax":3750,"se":3750} ,
                t3_3 : {"seMax":3750,"se":3750} ,
                t3_4 : {"seMax":3750,"se":3750} ,
                t3_5 : {"seMax":3750,"se":3750} ,
                t3_6 : {"seMax":3750,"se":3750} ,
                t3_7 : {"seMax":3750,"se":3750} ,

                t4_0 : {"seMax":9000,"se":9000} ,
                t4_1 : {"seMax":4500,"se":4500} ,
                t4_2 : {"seMax":4500,"se":4500} ,
                t4_3 : {"seMax":4500,"se":4500} ,
                t4_4 : {"seMax":4500,"se":4500} ,
                t4_5 : {"seMax":4500,"se":4500} ,
                t4_6 : {"seMax":4500,"se":4500} ,
                t4_7 : {"seMax":4500,"se":4500} ,

                t5_0 : {"seMax":11000,"se":11000} ,
                t5_1 : {"seMax":5500,"se":5500} ,
                t5_2 : {"seMax":5500,"se":5500} ,
                t5_3 : {"seMax":5500,"se":5500} ,
                t5_4 : {"seMax":5500,"se":5500} ,
                t5_5 : {"seMax":5500,"se":5500} ,
                t5_6 : {"seMax":5500,"se":5500} ,
                t5_7 : {"seMax":5500,"se":5500} ,

                t6_0 : {"seMax":13000,"se":13000} ,
                t6_1 : {"seMax":6500,"se":6500} ,
                t6_2 : {"seMax":6500,"se":6500} ,
                t6_3 : {"seMax":6500,"se":6500} ,
                t6_4 : {"seMax":6500,"se":6500} ,
                t6_5 : {"seMax":6500,"se":6500} ,
                t6_6 : {"seMax":6500,"se":6500} ,
                t6_7 : {"seMax":6500,"se":6500} ,

                t7_0 : {"seMax":15000,"se":15000} ,
                t7_1 : {"seMax":7500,"se":7500} ,
                t7_2 : {"seMax":7500,"se":7500} ,
                t7_3 : {"seMax":7500,"se":7500} ,
                t7_4 : {"seMax":7500,"se":7500} ,
                t7_5 : {"seMax":7500,"se":7500} ,
                t7_6 : {"seMax":7500,"se":7500} ,
                t7_7 : {"seMax":7500,"se":7500} ,

                t8_0 : {"seMax":17000,"se":17000} ,
                t8_1 : {"seMax":8500,"se":8500} ,
                t8_2 : {"seMax":8500,"se":8500} ,
                t8_3 : {"seMax":8500,"se":8500} ,
                t8_4 : {"seMax":8500,"se":8500} ,
                t8_5 : {"seMax":8500,"se":8500} ,
                t8_6 : {"seMax":8500,"se":8500} ,
                t8_7 : {"seMax":8500,"se":8500} ,

                t9_0 : {"seMax":"","se":100} ,
                t9_1 : {"seMax":"","se":100} ,
                t9_2 : {"seMax":"","se":100} ,
                t9_3 : {"seMax":"","se":100} ,
                t9_4 : {"seMax":"","se":100} ,
                t9_5 : {"seMax":"","se":100} ,
                t9_6 : {"seMax":"","se":100} ,
                t9_7 : {"seMax":"","se":100},

                t10_0 :{"seMax":1200,"se":1200},
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
                t11_7 : {"seMax":500,"se":500} ,

                t12_0 : {"seMax":38000,"se":38000} ,
                t12_1 : {"seMax":0,"se":0} ,
                t12_2 : {"seMax":0,"se":0} ,
                t12_3 : {"seMax":0,"se":0} ,
                t12_4 : {"seMax":0,"se":0} ,
                t12_5 : {"seMax":0,"se":0} ,
                t12_6 : {"seMax":0,"se":0} ,
                t12_7 : {"seMax":0,"se":0} ,

                t13_0 : {"seMax":6000,"se":6000} ,
                t13_1 : {"seMax":0,"se":0} ,
                t13_2 : {"seMax":0,"se":0} ,
                t13_3 : {"seMax":0,"se":0} ,
                t13_4 : {"seMax":0,"se":0} ,
                t13_5 : {"seMax":0,"se":0} ,
                t13_6 : {"seMax":0,"se":0} ,
                t13_7 : {"seMax":0,"se":0},

                t14_0 : {"seMax":3000,"se":3000} ,
                t14_1 : {"seMax":0,"se":0} ,
                t14_2 : {"seMax":0,"se":0} ,
                t14_3 : {"seMax":0,"se":0} ,
                t14_4 : {"seMax":0,"se":0} ,
                t14_5 : {"seMax":0,"se":0} ,
                t14_6 : {"seMax":0,"se":0} ,
                t14_7 : {"seMax":0,"se":0} ,


                t15_0 : {"seMax":3000,"se":3000} ,
                t15_1 : {"seMax":0,"se":0} ,
                t15_2 : {"seMax":0,"se":0} ,
                t15_3 : {"seMax":0,"se":0} ,
                t15_4 : {"seMax":0,"se":0} ,
                t15_5 : {"seMax":0,"se":0} ,
                t15_6 : {"seMax":0,"se":0} ,
                t15_7 : {"seMax":0,"se":0}
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
                "klr": 0
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
            "photos":new Array(),
            //"lenus","sirena","dea","zack","klr","tomoru","ceil"
            datingtwin:{

                "dating partner":{
                    id:"t001",
                    enabled:true
                },
                "lover":{
                    id:"t002",
                    enabled:true
                },
                "spouse":{
                    id:"t003",
                    enabled:true
                }
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

    public static var relationshipStep:Object={

        "foe-Max":-1,
        "acquaintance-Min":0,
        "acquaintance-Max":32,
        "friend-Min":33,
        "friend-Max":165,
        "closefriend-Min":166,
        "closefriend-Max":999,
        "datingpartner-Min":1000,
        "datingpartner-Max":3332,
        "lover-Min":3333,
        "lover-Max":6665,
        "spouse-Min":6666

    }
    public static var moodStep:Object={

        "sickened-Max":-2222,
        "depressed-Min":-2221,
        "depressed-Max":-999,
        "annoyed-Min":-998,
        "annoyed-Max":-444,
        "bored-Min":-443,
        "bored-Max":-111,
        "calm-Min":-110,
        "calm-Max":110,
        "pleased-Min":111,
        "pleased-Max":443,
        "delighted-Min":444,
        "delighted-Max":998,
        "smitten-Min":999,
        "smitten-Max":2221,
        "loved-Min":2222

    }
    public  static var ratingStep:Object={



        "hate-Max":-51,
        "hate-Min":-100,
        "dislike-Max":0,
        "dislike-Min":-50,
        "normal-Max":29,
        "normal-Min":1,
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
        "dea_Restaurant": ["party", "party2"],
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
        "qa-s006b":[10,-10],
        "qa-s008":[10,-10],
        "qa-s010":[10,-10],
        "qa-s025":[-10,10],
        "qa-s033":[10,-10],
        "qa-s034-1":[-10,10],
        "qa-s034-2":[-10,10],
        "qa-s050":[10,-10],
        "qa-s051":[-10,10],
        "qa-s1427-1-1":[10,-10],
        "qa-s1427-1-2":[-10,10]
    }

    public static  var dangersScenes:Object={"s023|on":"Restaurant","s033|on":"SportsBar","s036|on":"PrivateIsland","s042|on":"Casino",
        "s046|on":"LovemoreMansion","s260|on":"SSCCArena"};

    public function Config()
    {

    }

}

}

