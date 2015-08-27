package data
{
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Dictionary;

public class Config
{
    public static var deadline:Number=20;
    public static var payCoinURL:String="http://localhost:8888/simgilrs/index.php?cate=coin&authkey=";
    public static var payGameURL:String="http://localhost:8888/simgilrs/index.php?cate=game&authkey=";
    private static var points:Object=new Object();
    private static var playerInfo:Object=new Object();
    public static var modelObj:Object={"Male":new Rectangle(0,-20,276,660),
        "Female":new Rectangle(-25,-20,262,613)}
    public static var btl_elements:Array=new Array("fire","air","earth","water","neutral","com");
    public static var elements:Array=new Array("fire","air","earth","water","neutral");
    private static var skillssheet:Array=new Array();
    private static var acctype:String;
    private static var authkey:String;
    public static var ExcerptFornt:String="SimFutura";
    public static const allCharacters:Array=["lenus","sirena","dea","sao","klr","tomoru","ceil","zack"];
    //zack don't show up in somewhere
    public static const characters:Array=["lenus","sirena","dea","sao","klr","tomoru","ceil"];
    public static const NPC:Object={"daz":"npc001"};
    //schedule [index+ current month]
    public static var scheduleIndex:Object={"lenus":88,"sirena":12,"dea":25,"sao":38,"klr":51,"tomoru":64,"ceil":77,"zack":90};

    //battle schedule 2022 Tuesday

    public static var team_schedule:Array=[

        "Jul_5","Jul_12","Jul_19","Jul_26",
        "Aug_2","Aug_9","Aug_16","Aug_23","Aug_30",
        "Sep_6","Sep_13","Sep_20","Sep_27",


        "Oct_4","Oct_11","Oct_18","Oct_25",
        "Nov_1","Nov_8","Nov_15","Nov_22","Nov_29",
        "Dec_6","Dec_13","Dec_20","Dec_27"

    ]
    public static function  battleSchedule():Dictionary
    {
        var scheduls:Dictionary=new Dictionary();

        scheduls["Jul_5"]= ["p|0", "2|1", "4|3", "5|6", "7|8"];
        scheduls["Jul_12"]= ["p|1", "0|2", "3|5", "4|7", "8|6"];
        scheduls["Jul_19"]= ["p|3", "4|0", "1|7", "6|2", "8|5"];
        scheduls["Jul_26"]= ["p|2", "0|1", "6|3", "7|5", "4|8"];
        scheduls["Aug_2"]= ["7|0", "p|6", "5|1", "2|4", "8|3"];
        scheduls["Aug_9"]=["2|7", "1|3", "6|4", "p|5", "8|0"];
        scheduls["Aug_16"]=["p|4", "7|6", "5|0", "2|3", "1|8"];
        scheduls["Aug_23"]=["p|7", "0|3", "4|5", "6|1", "2|8"];
        scheduls["Aug_30"]=["0|6", "5|2", "1|4", "3|7", "p|8"];

        scheduls["Oct_4"]=["p|0", "2|1", "4|3", "5|6", "7|8"];
        scheduls["Oct_11"]= ["p|1", "0|2", "3|5", "4|7", "8|6"];
        scheduls["Oct_18"]=["p|3", "4|0", "1|7", "6|2", "8|5"];
        scheduls["Oct_25"]=["p|2", "0|1", "6|3", "7|5", "4|8"];
        scheduls["Nov_1"]= ["7|0", "p|6", "5|1", "2|4", "8|3"];
        scheduls["Nov_8"]=["2|7", "1|3", "6|4", "p|5", "8|0"];
        scheduls["Nov_15"]= ["p|4", "7|6", "5|0", "2|3", "1|8"];
        scheduls["Nov_22"]=["p|7", "0|3", "4|5", "6|1", "2|8"];
        scheduls["Nov_29"]=["0|6", "5|2", "1|4", "3|7", "p|8"];


        return scheduls
    }
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
            "acc":0xFF0000,
            "acc_tint":0.5,
            "body":0xFFFFFF,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0xFFFFFF,0xFF0000],
            "member_tint":[0.9,0.5]
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
            "member_tint":[0.9,0.5]
        },
        "t2":
        {
            "acc":0x539FCF,
            "acc_tint":0.8,
            "body":0xDF67C5,
            "body_tint":0.8,
            "skin":null,
            "skin_tint":null,
            "member":[0xD94886,0xDF67C5],
            "member_tint":[0.8,0.8]
        },
        "t3":
        {
            "acc":0x3C74B6,
            "acc_tint":0.5,
            "body":0x36435A,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0x36435A,0x3C74B6],
            "member_tint":[0.9,0.5]
        },
        "t4":
        {
            "acc":null,
            "acc_tint":0.5,
            "body":null,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0x1E1E1E,0x595959],
            "member_tint":[0.9,0.5]
        },
        "t5":
        {
            "acc":0xc51111,
            "acc_tint":0.5,
            "body":0xff5c00,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[0xff5c00,0xc51111],
            "member_tint":[0.8,0.5]
        },
        "t6":
        {
            "acc":null,
            "acc_tint":0.5,
            "body":null,
            "body_tint":0.9,
            "skin":0x333333,
            "skin_tint":0.5,
            "member":[null,null],
            "member_tint":[0.9,0.5]
        },
        "t7":
        {
            "acc":null,
            "acc_tint":0.5,
            "body":null,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[null,null],
            "member_tint":[0.9,0.5]
        },
        "t8":
        {
            "acc":null,
            "acc_tint":0.5,
            "body":null,
            "body_tint":0.9,
            "skin":null,
            "skin_tint":null,
            "member":[null,null],
            "member_tint":[0.9,0.5]
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
        "t6_0":"akr",
        "t7_0":"bdh",
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
        //rel(relation):"stranger","new friend","acquaintance","close friend","girlfriend","lover","wife"
        //Tue.1.Mar.2022|12
        playerInfo={
            "next_switch":"s001",
            "current_switch":"s001|on",
            "status":"Normal",
            "cash":10000,
            "first_name":"",
            "last_name":"",
            "date":"Tue.1.Mar.2022|12",
            "ap":100,
            "ap_max":100,
            "dating":"",
            "ch_cash":{
                lenus:100,
                sirena:100,
                dea:100,
                sao:100,
                klr:100,
                tomoru:100,
                ceil:100,
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
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                sirena:{
                    "Kiss":2,
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                dea:{
                    "Kiss":2,
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                sao:{
                    "Kiss":2,
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                klr:{
                    "Kiss":2,
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                tomoru:{
                    "Kiss":2,
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                },
                ceil:{
                    "Kiss":2,
                    "Flirt":2,
                    "TakePhoto":2,
                    "Chat":6,
                    "Date":1,
                    "Give":2
                }
            },
            "owned_assets":{
                player:[
                    {id:"cons_1_1",qty:1,expiration:1},
                    {id:"fs_7_4",qty:1,expiration:100},
                    {id:"lx_1_1",qty:1,expiration:100},
                    {id:"cons_2_4",qty:1,expiration:100},
                    {id:"cons_2_2",qty:1,expiration:100},
                    {id:"misc_4_1",qty:1,expiration:100},
                    {id:"misc_4_2",qty:1,expiration:100},
                    {id:"lx_2_1",qty:1,expiration:100}
                ],
                lenus:[
                    {id:"cons_1_1",qty:1,expiration:100},
                    {id:"cons_1_2",qty:1,expiration:100},
                    {id:"cons_1_3",qty:1,expiration:100},
                    {id:"cons_1_4",qty:1,expiration:100},
                    {id:"cons_1_5",qty:1,expiration:100},
                    {id:"cons_2_1",qty:1,expiration:100},
                    {id:"cons_2_3",qty:1,expiration:100},
                    {id:"cons_2_4",qty:1,expiration:100},
                    {id:"cons_2_2",qty:1,expiration:100},
                    {id:"misc_4_1",qty:1,expiration:100},
                    {id:"misc_4_2",qty:1,expiration:100},
                    {id:"misc_4_3",qty:1,expiration:100},
                    {id:"misc_4_4",qty:1,expiration:100},
                    {id:"misc_4_5",qty:1,expiration:100}
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
                sirena:"close friend",
                dea:"acquaintance",
                sao:"acquaintance",
                klr:"acquaintance",
                tomoru:"acquaintance",
                ceil:"acquaintance",
                zack:"foe"
            },
            "pts":{
                player: "-",
                lenus: 0,
                sirena: 333,
                dea: 0,
                sao: 0,
                klr: 0,
                tomoru: 0,
                ceil: 0,
                zack: -1
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
                //love==Max se
                player:500,
                lenus: 500,
                sirena:500,
                dea: 500,
                sao: 500,
                klr: 500,
                tomoru: 500,
                zack: 0,
                ceil: 500
            },
            "se":{
                lenus: 500,
                sirena: 500,
                dea: 500,
                sao: 500,
                klr: 500,
                tomoru: 500,
                ceil: 500,
                zack: 0,
                player:400
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
                }
            },
            "avatar":{
                gender:"Male",
                hairstyle:0,
                haircolor:0xFFFFFF,
                skincolor:0xFFFFFF,
                eyescolor:0xFFFFFF,
                features:0,
                clothes:1,
                pants:1
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
                    "win":10
                },
                {"team_id":"t0",
                    "name":"Vulpecula",
                    "win":3
                },
                {"team_id":"t1",
                    "name":"Lupus",
                    "win":9
                },
                {"team_id":"t2",
                    "name":"Phoenix",
                    "win":0
                },
                {"team_id":"t3",
                    "name":"Serpens",
                    "win":5
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
                    "win":7
                },
                {"team_id":"t7",
                    "name":"Draco",
                    "win":2
                },
                {"team_id":"t8",
                    "name":"Zephon",
                    "win":1
                }
            ],
            current_battle:{
                "Jul_5": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Jul_12": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Jul_19": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Jul_26": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Aug_2": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Aug_9": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Aug_16": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Aug_23": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Aug_30": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Oct_4": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Oct_11": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Oct_18": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Oct_25": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Nov_1": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Nov_8": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Nov_15": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Nov_22": ["0|0", "0|0", "0|0", "0|0", "0|0"],
                "Nov_29": ["0|0", "0|0", "0|0", "0|0", "0|0"]

            },
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
        "acquaintance-Max":110,
        "friend-Min":111,
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


        "hate-Min":-100,
        "hate-Max":-39,
        "dislike-Min":-40,
        "dislike-Max":-19,
        "normal-Min":-20,
        "normal-Max":19,
        "like-Min":20,
        "like-Max":59,
        "love-Min":60,
        "love-Max":100


    }

    public function Config()
    {

    }

}

}

