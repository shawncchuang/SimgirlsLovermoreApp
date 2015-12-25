package model
{
import com.gamua.flox.Access;
import com.gamua.flox.Entity;

import flash.utils.Dictionary;

public class SystemData extends Entity
{
    public var s001:Array;
    public var s002:Array;
    public var s003:Array;
    public var s004:Array;

    public var scenelibrary:Array;
    public var schedule:Array;
    public var secrets_chat:Array;
    public var assets: Object;
    public var secrets: Object;
    public var trashtalking: Array;
    public var command: Object;
    public var date_response: Object;
    public var chat_lenus: Object;
    public var chat_lenus_loc: Object;
    public var chat_sirena: Object;
    public var chat_sirena_loc: Object;
    public var chat_dea: Object;
    public var chat_dea_loc: Object;
    public var chat_sao: Object;
    public var chat_sao_loc: Object;
    public var chat_klr: Object;
    public var chat_klr_loc: Object;
    public var chat_tomoru: Object;
    public var chat_tomoru_loc: Object;
    public var chat_ceil: Object;
    public var chat_ceil_loc: Object;
    public var chat_zack: Object;
    public var chat_zack_loc: Object;
    public var cpu_teams: Object;
    public var skillsys: Object;
    public var blackmarket:Object;
    public var commander_items: Object;
    public var main_story:Array;
    public var npcLocated:Object;
    //bubble sp:normal , th:bubble thinking
    public var npcs:Object;
    //story_battle={switch id}+"-"+{number}:{boss id}(ex:format: t10_1)
    public var story_battle:Object;
    public var status:Object;
    public var relationship_level:Object;
    public var mood_level:Object;
    public var rating_level:Object;
    public var preciousphotos:Object;
    public var domainPrecious:String;
    public var upperbodyitems:Array;
    public var lowerbodyitems:Array;
    public var switchs:Object=
    {
        "s001":{
            hints:"(I should check into the hotel first...)",
            date:"",
            time:"",
            location:"hotel",
            people:"",
            enabled:true,
            result:{
                off:"s001",
                on:"s002"
            }
        },
        "s002":{
            hints:"(I want to visit the beach on the magazine first...)",
            date:"",
            time:"",
            location:"beach",
            people:"",
            enabled:true,
            result:{
                off:"s002",
                on:""
            }
        },
        "s003":{
            hints:"(I should meet Sao at the museum first...)",
            date:"Wed.2.Mar.2022",
            time:"12",
            location:"museum",
            people:"",
            enabled:true,
            result:{
                off:"s003",
                on:""
            }
        },
        "s004":{
            hints:"",
            date:"Wed.2.Mar.2022",
            time:"12",
            location:"museum",
            people:"",
            enabled:true,
            result:{
                off:"s004",
                on:""
            }
        },
        "s005":{
            hints:"(I should go pubbing with Sao...)",
            date:"Wed.2.Mar.2022",
            time:"24",
            location:"sportsbar",
            people:"",
            enabled:true,
            result:{
                off:"s005",
                on:""
            }
        },
        "s006":{
            hints:"(I am supposed to meet Sao at the temple...)",
            date:"Wed.3.Mar.2022",
            time:"12",
            location:"spirittemple",
            people:"",
            enabled:true,
            result:{
                off:"s006",
                on:""
            }
        },
        "s007":{
            hints:"",
            date:"Wed.3.Mar.2022",
            time:"24",
            location:"restaurant",
            people:"",
            enabled:true,
            result:{
                off:"s007",
                on:""
            }
        },
        "s008":{
            hints:"(Friday Night! Clubbing time...)",
            date:"Wed.4.Mar.2022",
            time:"24",
            location:"restaurant",
            people:"",
            enabled:true,
            result:{
                off:"s008",
                on:""
            }
        },
        "s009":{
            hints:"(I am going to casino tonight...)",
            date:"Wed.5.Mar.2022",
            time:"24",
            location:"casino",
            people:"",
            enabled:true,
            result:{
                off:"s009",
                on:""
            }
        }

    }
    public var style_schedule:Object;
    /*{
        "ceil":[
            {"date":"Wed.2.Mar.2022","src":"ceil_s0001"},
            {"date":"Wed.3.Mar.2022","src":"ceil_s0002"},
            {"date":"Wed.3.Mar.2022","src":"ceil_s0003"},
            {"date":"Wed.4.Mar.2022","src":"ceil_s0004"},
            {"date":"Wed.5.Mar.2022","src":"ceil_s0005"},
            {"date":"Wed.6.Mar.2022","src":"ceil_s0006"},
            {"date":"Wed.7.Mar.2022","src":"ceil_s0007"},
            {"date":"Wed.9.Mar.2022","src":"ceil_s0008"},
            {"date":"Wed.10.Mar.2022","src":"ceil_s009"},
            {"date":"Wed.11.Mar.2022","src":"ceil_s0010"},
            {"date":"Wed.12.Mar.2022","src":"ceil_s0011"},
            {"date":"Wed.13.Mar.2022","src":"ceil_s0012"}
        ],
        "dea":[
            {"date":"Wed.2.Mar.2022","src":"dea_s0001"},
            {"date":"Wed.3.Mar.2022","src":"dea_s0002"},
            {"date":"Wed.3.Mar.2022","src":"dea_s0003"},
            {"date":"Wed.4.Mar.2022","src":"dea_s0004"},
            {"date":"Wed.5.Mar.2022","src":"dea_s0005"},
            {"date":"Wed.6.Mar.2022","src":"dea_s0006"},
            {"date":"Wed.7.Mar.2022","src":"dea_s0007"},
            {"date":"Wed.9.Mar.2022","src":"dea_s0008"},
            {"date":"Wed.10.Mar.2022","src":"dea_s0009"},
            {"date":"Wed.11.Mar.2022","src":"dea_s0010"},
            {"date":"Wed.12.Mar.2022","src":"dea_s0011"},
            {"date":"Wed.13.Mar.2022","src":"dea_s0012"},
            {"date":"Wed.14.Mar.2022","src":"dea_s0013"}
        ],
        "klr":[
            {"date":"Wed.2.Mar.2022","src":"klr_s0001"},
            {"date":"Wed.3.Mar.2022","src":"klr_s0002"},
            {"date":"Wed.3.Mar.2022","src":"klr_s0003"},
            {"date":"Wed.4.Mar.2022","src":"klr_s0004"},
            {"date":"Wed.5.Mar.2022","src":"klr_s0005"},
            {"date":"Wed.6.Mar.2022","src":"klr_s0006"},
            {"date":"Wed.7.Mar.2022","src":"klr_s0007"},
            {"date":"Wed.9.Mar.2022","src":"klr_s0008"},
            {"date":"Wed.10.Mar.2022","src":"klr_s0009"},
            {"date":"Wed.11.Mar.2022","src":"klr_s0010"},
            {"date":"Wed.12.Mar.2022","src":"klr_s0011"},
            {"date":"Wed.13.Mar.2022","src":"klr_s0012"},
            {"date":"Wed.14.Mar.2022","src":"klr_s0013"}
        ],
        "lenus":[
            {"date":"Wed.2.Mar.2022","src":"lenus_s0001"},
            {"date":"Wed.3.Mar.2022","src":"lenus_s0002"},
            {"date":"Wed.3.Mar.2022","src":"lenus_s0003"},
            {"date":"Wed.4.Mar.2022","src":"lenus_s0004"},
            {"date":"Wed.5.Mar.2022","src":"lenus_s0005"}
        ],
        "sao":[
            {"date":"Wed.2.Mar.2022","src":"sao_s0001"},
            {"date":"Wed.3.Mar.2022","src":"sao_s0002"},
            {"date":"Wed.3.Mar.2022","src":"sao_s0003"}
        ],
        "sirena":[
            {"date":"Wed.2.Mar.2022","src":"sirena_s0001"},
            {"date":"Wed.3.Mar.2022","src":"sirena_s0002"},
            {"date":"Wed.3.Mar.2022","src":"sirena_s0003"},
            {"date":"Wed.4.Mar.2022","src":"sirena_s0004"},
            {"date":"Wed.5.Mar.2022","src":"sirena_s0005"},
            {"date":"Wed.6.Mar.2022","src":"sirena_s0006"},
            {"date":"Wed.7.Mar.2022","src":"sirena_s0007"},
            {"date":"Wed.9.Mar.2022","src":"sirena_s0008"},
            {"date":"Wed.10.Mar.2022","src":"sirena_s0009"},
            {"date":"Wed.11.Mar.2022","src":"sirena_s0010"},
            {"date":"Wed.12.Mar.2022","src":"sirena_s0011"},
            {"date":"Wed.13.Mar.2022","src":"sirena_s0012"},
            {"date":"Wed.14.Mar.2022","src":"sirena_s0013"}
        ],
        "tomoru":[
            {"date":"Wed.2.Mar.2022","src":"tomoru_s0001"},
            {"date":"Wed.3.Mar.2022","src":"tomoru_s0002"},
            {"date":"Wed.3.Mar.2022","src":"tomoru_s0003"},
            {"date":"Wed.4.Mar.2022","src":"tomoru_s0004"},
            {"date":"Wed.5.Mar.2022","src":"tomoru_s0005"},
            {"date":"Wed.6.Mar.2022","src":"tomoru_s0006"},
            {"date":"Wed.7.Mar.2022","src":"tomoru_s0007"},
            {"date":"Wed.9.Mar.2022","src":"tomoru_s0008"},
            {"date":"Wed.10.Mar.2022","src":"tomoru_s0009"},
            {"date":"Wed.11.Mar.2022","src":"tomoru_s0010"},
            {"date":"Wed.12.Mar.2022","src":"tomoru_s0011"},
            {"date":"Wed.13.Mar.2022","src":"tomoru_s0012"},
            {"date":"Wed.14.Mar.2022","src":"tomoru_s0013"}
        ],
        "zack":[
            {"date":"Wed.2.Mar.2022","src":"zack_s0001"},
            {"date":"Wed.3.Mar.2022","src":"zack_s0002"},
            {"date":"Wed.3.Mar.2022","src":"zack_s0003"},
            {"date":"Wed.4.Mar.2022","src":"zack_s0004"},
            {"date":"Wed.5.Mar.2022","src":"zack_s0005"},
            {"date":"Wed.6.Mar.2022","src":"zack_s0006"},
            {"date":"Wed.7.Mar.2022","src":"zack_s0007"}
        ]
    }
    */
    public function SystemData()
    {


    }
    /*
     public function set assets(obj:Object):void
     {
     _assets={
     "app_7_5": {
     "cate": "app",
     "name": "Earrings",
     "brand": "Chopp",
     "price": "380",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_13_2": {
     "cate": "misc",
     "name": "Camera",
     "brand": "Niko",
     "price": "1800",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_3_5": {
     "cate": "cons",
     "name": "Flowers",
     "brand": "Guccy",
     "price": "100",
     "obsoleteIn": "5",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_4_2": {
     "cate": "misc",
     "name": "Book",
     "brand": "Ryuji S.",
     "price": "15",
     "obsoleteIn": "15",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_9_5": {
     "cate": "app",
     "name": "Shoes",
     "brand": "Coast",
     "price": "700",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_7_4": {
     "cate": "app",
     "name": "Earrings",
     "brand": "Oharu",
     "price": "450",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_5_4": {
     "cate": "misc",
     "name": "Game",
     "brand": "Ninga",
     "price": "55",
     "obsoleteIn": "30",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_3_4": {
     "cate": "cons",
     "name": "Flowers",
     "brand": "Chanelle",
     "price": "95",
     "obsoleteIn": "5",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_12_2": {
     "cate": "app",
     "name": "Small Leather Good",
     "brand": "Hermas",
     "price": "1600",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_11_2": {
     "cate": "misc",
     "name": "Art",
     "brand": "Leonardo",
     "price": "1200",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_3_3": {
     "cate": "cons",
     "name": "Flowers",
     "brand": "Berry",
     "price": "110",
     "obsoleteIn": "5",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_1_4": {
     "cate": "cons",
     "name": "Chocolate",
     "brand": "Herley",
     "price": "12",
     "obsoleteIn": "10",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_1_2": {
     "cate": "cons",
     "name": "Chocolate",
     "brand": "Ferro",
     "price": "15",
     "obsoleteIn": "10",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_1_1": {
     "cate": "cons",
     "name": "Chocolate",
     "brand": "Lin",
     "price": "20",
     "obsoleteIn": "10",
     "exc": "Increase 100% of SE.Must be used during sleep. Only Captain can use this skill during battle. Captain must be in the front row.\nEffect: All enemy will stop moving for one round. ",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_8_4": {
     "cate": "app",
     "name": "Necklace",
     "brand": "Oharu",
     "price": "550",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_16_2": {
     "cate": "app",
     "name": "Diamond Ring",
     "brand": "Tiffy",
     "price": "9000",
     "obsoleteIn": "-",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_1_3": {
     "cate": "cons",
     "name": "Chocolate",
     "brand": "Nesie",
     "price": "25",
     "obsoleteIn": "10",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_2_4": {
     "cate": "cons",
     "name": "Perfume",
     "brand": "Chanelle",
     "price": "40",
     "obsoleteIn": "45",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_7_2": {
     "cate": "app",
     "name": "Earrings",
     "brand": "Tiffy",
     "price": "410",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_14_3": {
     "cate": "app",
     "name": "Handbag",
     "brand": "Guccy",
     "price": "2800",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_7_1": {
     "cate": "app",
     "name": "Earrings",
     "brand": "Cartia",
     "price": "400",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_6_3": {
     "cate": "misc",
     "name": "Plush Toy",
     "brand": "Teddi",
     "price": "70",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_13_1": {
     "cate": "misc",
     "name": "Camera",
     "brand": "Canno",
     "price": "2000",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_11_1": {
     "cate": "misc",
     "name": "Art",
     "brand": "Vincent",
     "price": "1000",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_5_3": {
     "cate": "misc",
     "name": "Game",
     "brand": "PC",
     "price": "45",
     "obsoleteIn": "30",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_1_5": {
     "cate": "cons",
     "name": "Chocolate",
     "brand": "Godiff",
     "price": "20",
     "obsoleteIn": "10",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_9_3": {
     "cate": "app",
     "name": "Shoes",
     "brand": "Bali",
     "price": "800",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_10_2": {
     "cate": "misc",
     "name": "Electronic Device",
     "brand": "Soni",
     "price": "780",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_10_1": {
     "cate": "misc",
     "name": "Electronic Device",
     "brand": "Semseng",
     "price": "800",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_3_2": {
     "cate": "cons",
     "name": "Flowers",
     "brand": "S\u0026G",
     "price": "120",
     "obsoleteIn": "5",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_11_5": {
     "cate": "misc",
     "name": "Art",
     "brand": "Claude",
     "price": "1200",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_2_1": {
     "cate": "cons",
     "name": "Perfume",
     "brand": "Dio",
     "price": "20",
     "obsoleteIn": "45",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_8_1": {
     "cate": "app",
     "name": "Necklace",
     "brand": "Cartia",
     "price": "590",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_8_5": {
     "cate": "app",
     "name": "Necklace",
     "brand": "Chopp",
     "price": "600",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_10_5": {
     "cate": "misc",
     "name": "Electronic Device",
     "brand": "Koogle",
     "price": "720",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_4_5": {
     "cate": "misc",
     "name": "Book",
     "brand": "Akira K.",
     "price": "20",
     "obsoleteIn": "15",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_6_2": {
     "cate": "misc",
     "name": "Plush Toy",
     "brand": "Desly",
     "price": "85",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_14_5": {
     "cate": "app",
     "name": "Handbag",
     "brand": "Parna",
     "price": "4000",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_2_2": {
     "cate": "cons",
     "name": "Perfume",
     "brand": "S\u0026G",
     "price": "50",
     "obsoleteIn": "45",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_9_2": {
     "cate": "app",
     "name": "Shoes",
     "brand": "Berry",
     "price": "680",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_4_3": {
     "cate": "misc",
     "name": "Book",
     "brand": "Junta M.",
     "price": "25",
     "obsoleteIn": "15",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_5_2": {
     "cate": "misc",
     "name": "Game",
     "brand": "X-station",
     "price": "50",
     "obsoleteIn": "30",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_13_4": {
     "cate": "misc",
     "name": "Camera",
     "brand": "Rica",
     "price": "1600",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_14_1": {
     "cate": "app",
     "name": "Handbag",
     "brand": "Louis",
     "price": "2500",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_2_5": {
     "cate": "cons",
     "name": "Perfume",
     "brand": "Guccy",
     "price": "60",
     "obsoleteIn": "45",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_15_2": {
     "cate": "app",
     "name": "Watch",
     "brand": "Cartia",
     "price": "6000",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_6_5": {
     "cate": "misc",
     "name": "Plush Toy",
     "brand": "Super Heros",
     "price": "100",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_11_4": {
     "cate": "misc",
     "name": "Art",
     "brand": "Raphael",
     "price": "1300",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_7_3": {
     "cate": "app",
     "name": "Earrings",
     "brand": "Hermas",
     "price": "420",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_15_1": {
     "cate": "app",
     "name": "Watch",
     "brand": "Rolix",
     "price": "6800",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_6_1": {
     "cate": "misc",
     "name": "Plush Toy",
     "brand": "Pikumon",
     "price": "70",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_3_1": {
     "cate": "cons",
     "name": "Flowers",
     "brand": "Dio",
     "price": "100",
     "obsoleteIn": "5",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "cons_2_3": {
     "cate": "cons",
     "name": "Perfume",
     "brand": "Berry",
     "price": "55",
     "obsoleteIn": "45",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_10_4": {
     "cate": "misc",
     "name": "Electronic Device",
     "brand": "Blueberry",
     "price": "750",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_12_4": {
     "cate": "app",
     "name": "Small Leather Good",
     "brand": "Chanelle",
     "price": "1800",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_12_1": {
     "cate": "app",
     "name": "Small Leather Good",
     "brand": "Louis Vernon",
     "price": "1500",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_15_3": {
     "cate": "app",
     "name": "Watch",
     "brand": "Sigma",
     "price": "6200",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_8_3": {
     "cate": "app",
     "name": "Necklace",
     "brand": "Hermas",
     "price": "580",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_16_3": {
     "cate": "app",
     "name": "Diamond Ring",
     "brand": "Boboli",
     "price": "8500",
     "obsoleteIn": "-",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_5_1": {
     "cate": "misc",
     "name": "Game",
     "brand": "Playbox",
     "price": "40",
     "obsoleteIn": "30",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_15_4": {
     "cate": "app",
     "name": "Watch",
     "brand": "Hermas",
     "price": "6500",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_16_4": {
     "cate": "app",
     "name": "Diamond Ring",
     "brand": "Hermas",
     "price": "8200",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_13_5": {
     "cate": "misc",
     "name": "Camera",
     "brand": "Luminar",
     "price": "1700",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_9_4": {
     "cate": "app",
     "name": "Shoes",
     "brand": "S\u0026G",
     "price": "750",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_12_5": {
     "cate": "app",
     "name": "Small Leather Good",
     "brand": "Parna",
     "price": "1300",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_6_4": {
     "cate": "misc",
     "name": "Plush Toy",
     "brand": "Simgirls",
     "price": "80",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_9_1": {
     "cate": "app",
     "name": "Shoes",
     "brand": "Dio",
     "price": "710",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_13_3": {
     "cate": "misc",
     "name": "Camera",
     "brand": "Pantax",
     "price": "2100",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_11_3": {
     "cate": "misc",
     "name": "Art",
     "brand": "Pablo",
     "price": "900",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_15_5": {
     "cate": "app",
     "name": "Watch",
     "brand": "Tinsot",
     "price": "5800",
     "obsoleteIn": "-",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_14_2": {
     "cate": "app",
     "name": "Handbag",
     "brand": "Hermas",
     "price": "3100",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_5_5": {
     "cate": "misc",
     "name": "Game",
     "brand": "Handhelds",
     "price": "40",
     "obsoleteIn": "30",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_8_2": {
     "cate": "app",
     "name": "Necklace",
     "brand": "Tiffy",
     "price": "650",
     "obsoleteIn": "60",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_4_4": {
     "cate": "misc",
     "name": "Book",
     "brand": "Sana R.",
     "price": "15",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_4_1": {
     "cate": "misc",
     "name": "Book",
     "brand": "Lenus L.",
     "price": "20",
     "obsoleteIn": "15",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "misc_10_3": {
     "cate": "misc",
     "name": "Electronic Device",
     "brand": "Orange",
     "price": "810",
     "obsoleteIn": "90",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_14_4": {
     "cate": "app",
     "name": "Handbag",
     "brand": "Chanelle",
     "price": "3600",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_16_1": {
     "cate": "app",
     "name": "Diamond Ring",
     "brand": "Cartia",
     "price": "8000",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_12_3": {
     "cate": "app",
     "name": "Small Leather Good",
     "brand": "Guccy",
     "price": "1400",
     "obsoleteIn": "180",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     },
     "app_16_5": {
     "cate": "app",
     "name": "Diamond Ring",
     "brand": "Chopp",
     "price": "9000",
     "obsoleteIn": "-1",
     "exc": "Increase 100% of SE.",
     "blackstore": "0",
     "data": "images/items/cons_1_1.png"
     }
     }

     }
     public function get assets():Object
     {
     return _assets;
     }

     public function set blackmarket(obj:Object):void
     {
     _blackmarket={
     "bm_3": {
     "name": "Cheat3",
     "exc": "Increase ……. ",
     "price": "2.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_6": {
     "name": "Cheat6",
     "exc": "Increase ……. ",
     "price": "2.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_7": {
     "name": "Cheat7",
     "exc": "Increase ……. ",
     "price": "2.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_1": {
     "name": "Cheat1",
     "exc": "Increase ……. ",
     "price": "1.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_8": {
     "name": "Cheat8",
     "exc": "Increase ……. ",
     "price": "4.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_4": {
     "name": "Cheat4",
     "exc": "Increase ……. ",
     "price": "1.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_2": {
     "name": "Cheat2",
     "exc": "Increase ……. ",
     "price": "1.99",
     "data": "images/bm/bm_1.png"
     },
     "bm_5": {
     "name": "Cheat5",
     "exc": "Increase ……. ",
     "price": "2.99",
     "data": "images/bm/bm_1.png"
     }
     }
     }
     public function get blackmarket():Object
     {
     return _blackmarket;
     }
     public function set chat_ceil(obj:Object):void
     {
     _chat_ceil={
     "lover": {
     "angry": [
     "Leave me alone.(Ceil-lover-angry)",
     "Go away please.(Ceil-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Ceil-lover-inlove)",
     "Do you have time?(Ceil-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Ceil-lover-normal)",
     "This is a nice day.(Ceil-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Ceil-lover-happy)",
     "I have great time with you.(Ceil-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Ceil-lover-sad)",
     "Sorry,I don\u0027t have time.(Ceil-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Ceil-close_friend-angry)",
     "Go away please.(Ceil-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Ceil-close_friend-inlove)",
     "Do you have time?(Ceil-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Ceil-close_friend-normal)",
     "This is a nice day.(Ceil-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Ceil-close_friend-happy)",
     "I have great time with you.(Ceil-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Ceil-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Ceil-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Ceil-friend-angry)",
     "Go away please.(Ceil-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Ceil-friend-inlove)",
     "Do you have time?(Ceil-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Ceil-friend-normal)",
     "This is a nice day.(Ceil-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Ceil-friend-happy)",
     "I have great time with you.(Ceil-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Ceil-friend-sad)",
     "Sorry,I don\u0027t have time.(Ceil-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Ceil-enemy-angry)",
     "Go away please.(Ceil-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Ceil-enemy-inlove)",
     "Do you have time?(Ceil-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Ceil-enemy-normal)",
     "This is a nice day.(Ceil-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Ceil-enemy-happy)",
     "I have great time with you.(Ceil-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Ceil-enemy-sad)",
     "Sorry,I don\u0027t have time.(Ceil-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Ceil-couples-angry)",
     "Go away please.(Ceil-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Ceil-couples-inlove)",
     "Do you have time?(Ceil-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Ceil-couples-normal)",
     "This is a nice day.(Ceil-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Ceil-couples-happy)",
     "I have great time with you.(Ceil-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Ceil-couples-sad)",
     "Sorry,I don’t have time.(Ceil-couples-sad)"
     ]
     }
     }

     }
     public function get chat_ceil():Object
     {
     return _chat_ceil;
     }
     public function set chat_dea(obj:Object):void
     {
     _chat_dea={
     "lover": {
     "angry": [
     "Leave me alone.(Dea-lover-angry)",
     "Go away please.(Dea-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Dea-lover-inlove)",
     "Do you have time?(Dea-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Dea-lover-normal)",
     "This is a nice day.(Dea-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Dea-lover-happy)",
     "I have great time with you.(Dea-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Dea-lover-sad)",
     "Sorry,I don\u0027t have time.(Dea-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Dea-close_friend-angry)",
     "Go away please.(Dea-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Dea-close_friend-inlove)",
     "Do you have time?(Dea-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Dea-close_friend-normal)",
     "This is a nice day.(Dea-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Dea-close_friend-happy)",
     "I have great time with you.(Dea-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Dea-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Dea-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Dea-friend-angry)",
     "Go away please.(Dea-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Dea-friend-inlove)",
     "Do you have time?(Dea-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Dea-friend-normal)",
     "This is a nice day.(Dea-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Dea-friend-happy)",
     "I have great time with you.(Dea-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Dea-friend-sad)",
     "Sorry,I don\u0027t have time.(Dea-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Dea-enemy-angry)",
     "Go away please.(Dea-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Dea-enemy-inlove)",
     "Do you have time?(Dea-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Dea-enemy-normal)",
     "This is a nice day.(Dea-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Dea-enemy-happy)",
     "I have great time with you.(Dea-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Dea-enemy-sad)",
     "Sorry,I don\u0027t have time.(Dea-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Dea-couples-angry)",
     "Go away please.(Dea-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Dea-couples-inlove)",
     "Do you have time?(Dea-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Dea-couples-normal)",
     "This is a nice day.(Dea-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Dea-couples-happy)",
     "I have great time with you.(Dea-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Dea-couples-sad)",
     "Sorry,I don’t have time.(Dea-couples-sad)"
     ]
     }
     }
     }

     public function get chat_dea():Object
     {
     return _chat_dea;
     }
     public function set chat_klr(obj:Object):void
     {
     _chat_klr={
     "lover": {
     "angry": [
     "Leave me alone.(Klaire-lover-angry)",
     "Go away please.(Klaire-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Klaire-lover-inlove)",
     "Do you have time?(Klaire-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Klaire-lover-normal)",
     "This is a nice day.(Klaire-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Klaire-lover-happy)",
     "I have great time with you.(Klaire-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Klaire-lover-sad)",
     "Sorry,I don\u0027t have time.(Klaire-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Klaire-close_friend-angry)",
     "Go away please.(Klaire-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Klaire-close_friend-inlove)",
     "Do you have time?(Klaire-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Klaire-close_friend-normal)",
     "This is a nice day.(Klaire-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Klaire-close_friend-happy)",
     "I have great time with you.(Klaire-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Klaire-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Klaire-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Klaire-friend-angry)",
     "Go away please.(Klaire-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Klaire-friend-inlove)",
     "Do you have time?(Klaire-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Klaire-friend-normal)",
     "This is a nice day.(Klaire-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Klaire-friend-happy)",
     "I have great time with you.(Klaire-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Klaire-friend-sad)",
     "Sorry,I don\u0027t have time.(Klaire-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Klaire-enemy-angry)",
     "Go away please.(Klaire-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Klaire-enemy-inlove)",
     "Do you have time?(Klaire-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Klaire-enemy-normal)",
     "This is a nice day.(Klaire-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Klaire-enemy-happy)",
     "I have great time with you.(Klaire-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Klaire-enemy-sad)",
     "Sorry,I don\u0027t have time.(Klaire-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Klaire-couples-angry)",
     "Go away please.(Klaire-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Klaire-couples-inlove)",
     "Do you have time?(Klaire-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Klaire-couples-normal)",
     "This is a nice day.(Klaire-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Klaire-couples-happy)",
     "I have great time with you.(Klaire-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Klaire-couples-sad)",
     "Sorry,I don’t have time.(Klaire-couples-sad)"
     ]
     }
     }

     }
     public function get chat_klr():Object
     {
     return _chat_klr;
     }

     public function set chat_lenus(obj:Object):void
     {
     _chat_lenus={
     "lover": {
     "angry": [
     "Leave me alone.(Lenus-lover-angry)",
     "Go away please.(Lenus-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Lenus-lover-inlove)",
     "Do you have time?(Lenus-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Lenus-lover-normal)",
     "This is a nice day.(Lenus-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Lenus-lover-happy)",
     "I have great time with you.(Lenus-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Lenus-lover-sad)",
     "Sorry,I don\u0027t have time.(Lenus-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Lenus-close_friend-angry)",
     "Go away please.(Lenus-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Lenus-close_friend-inlove)",
     "Do you have time?(Lenus-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Lenus-close_friend-normal)",
     "This is a nice day.(Lenus-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Lenus-close_friend-happy)",
     "I have great time with you.(Lenus-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Lenus-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Lenus-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Lenus-friend-angry)",
     "Go away please.(Lenus-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Lenus-friend-inlove)",
     "Do you have time?(Lenus-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Lenus-friend-normal)",
     "This is a nice day.(Lenus-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Lenus-friend-happy)",
     "I have great time with you.(Lenus-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Lenus-friend-sad)",
     "Sorry,I don\u0027t have time.(Lenus-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Lenus-enemy-angry)",
     "Go away please.(Lenus-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Lenus-enemy-inlove)",
     "Do you have time?(Lenus-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Lenus-enemy-normal)",
     "This is a nice day.(Lenus-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Lenus-enemy-happy)",
     "I have great time with you.(Lenus-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Lenus-enemy-sad)",
     "Sorry,I don\u0027t have time.(Lenus-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Lenus-couples-angry)",
     "Go away please.(Lenus-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Lenus-couples-inlove)",
     "Do you have time?(Lenus-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Lenus-couples-normal)",
     "This is a nice day.(Lenus-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Lenus-couples-happy)",
     "I have great time with you.(Lenus-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Lenus-couples-sad)",
     "Sorry,I don’t have time.(Lenus-couples-sad)"
     ]
     }
     }
     }

     public function get chat_lenus():Object
     {
     return _chat_lenus;
     }

     public function set chat_sao(obj:Object):void
     {
     _chat_sao={
     "lover": {
     "angry": [
     "Leave me alone.(Sao-lover-angry)",
     "Go away please.(Sao-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sao-lover-inlove)",
     "Do you have time?(Sao-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sao-lover-normal)",
     "This is a nice day.(Sao-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Sao-lover-happy)",
     "I have great time with you.(Sao-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Sao-lover-sad)",
     "Sorry,I don\u0027t have time.(Sao-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Sao-close_friend-angry)",
     "Go away please.(Sao-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sao-close_friend-inlove)",
     "Do you have time?(Sao-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sao-close_friend-normal)",
     "This is a nice day.(Sao-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Sao-close_friend-happy)",
     "I have great time with you.(Sao-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Sao-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Sao-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Sao-friend-angry)",
     "Go away please.(Sao-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sao-friend-inlove)",
     "Do you have time?(Sao-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sao-friend-normal)",
     "This is a nice day.(Sao-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Sao-friend-happy)",
     "I have great time with you.(Sao-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Sao-friend-sad)",
     "Sorry,I don\u0027t have time.(Sao-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Sao-enemy-angry)",
     "Go away please.(Sao-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sao-enemy-inlove)",
     "Do you have time?(Sao-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sao-enemy-normal)",
     "This is a nice day.(Sao-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Sao-enemy-happy)",
     "I have great time with you.(Sao-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Sao-enemy-sad)",
     "Sorry,I don\u0027t have time.(Sao-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Sao-couples-angry)",
     "Go away please.(Sao-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sao-couples-inlove)",
     "Do you have time?(Sao-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sao-couples-normal)",
     "This is a nice day.(Sao-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Sao-couples-happy)",
     "I have great time with you.(Sao-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Sao-couples-sad)",
     "Sorry,I don’t have time.(Sao-couples-sad)"
     ]
     }
     }
     }
     public function get chat_sao():Object
     {
     return _chat_sao;
     }
     public function set chat_sirena(obj:Object):void
     {
     _chat_sirena={
     "lover": {
     "angry": [
     "Leave me alone.(Sirena-lover-angry)",
     "Go away please.(Sirena-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sirena-lover-inlove)",
     "Do you have time?(Sirena-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sirena-lover-normal)",
     "This is a nice day.(Sirena-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Sirena-lover-happy)",
     "I have great time with you.(Sirena-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Sirena-lover-sad)",
     "Sorry,I don\u0027t have time.(Sirena-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Sirena-close_friend-angry)",
     "Go away please.(Sirena-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sirena-close_friend-inlove)",
     "Do you have time?(Sirena-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sirena-close_friend-normal)",
     "This is a nice day.(Sirena-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Sirena-close_friend-happy)",
     "I have great time with you.(Sirena-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Sirena-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Sirena-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Sirena-friend-angry)",
     "Go away please.(Sirena-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sirena-friend-inlove)",
     "Do you have time?(Sirena-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sirena-friend-normal)",
     "This is a nice day.(Sirena-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Sirena-friend-happy)",
     "I have great time with you.(Sirena-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Sirena-friend-sad)",
     "Sorry,I don\u0027t have time.(Sirena-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Sirena-enemy-angry)",
     "Go away please.(Sirena-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sirena-enemy-inlove)",
     "Do you have time?(Sirena-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sirena-enemy-normal)",
     "This is a nice day.(Sirena-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Sirena-enemy-happy)",
     "I have great time with you.(Sirena-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Sirena-enemy-sad)",
     "Sorry,I don\u0027t have time.(Sirena-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Sirena-couples-angry)",
     "Go away please.(Sirena-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Sirena-couples-inlove)",
     "Do you have time?(Sirena-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Sirena-couples-normal)",
     "This is a nice day.(Sirena-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Sirena-couples-happy)",
     "I have great time with you.(Sirena-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Sirena-couples-sad)",
     "Sorry,I don’t have time.(Sirena-couples-sad)"
     ]
     }
     }
     }

     public function get chat_sirena():Object
     {
     return _chat_sirena;
     }

     public function set chat_tomoru(obj:Object):void
     {
     _chat_tomoru={
     "lover": {
     "angry": [
     "Leave me alone.(Tomoru-lover-angry)",
     "Go away please.(Tomoru-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Tomoru-lover-inlove)",
     "Do you have time?(Tomoru-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Tomoru-lover-normal)",
     "This is a nice day.(Tomoru-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Tomoru-lover-happy)",
     "I have great time with you.(Tomoru-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Tomoru-lover-sad)",
     "Sorry,I don\u0027t have time.(Tomoru-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Tomoru-close_friend-angry)",
     "Go away please.(Tomoru-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Tomoru-close_friend-inlove)",
     "Do you have time?(Tomoru-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Tomoru-close_friend-normal)",
     "This is a nice day.(Tomoru-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Tomoru-close_friend-happy)",
     "I have great time with you.(Tomoru-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Tomoru-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Tomoru-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Tomoru-friend-angry)",
     "Go away please.(Tomoru-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Tomoru-friend-inlove)",
     "Do you have time?(Tomoru-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Tomoru-friend-normal)",
     "This is a nice day.(Tomoru-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Tomoru-friend-happy)",
     "I have great time with you.(Tomoru-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Tomoru-friend-sad)",
     "Sorry,I don\u0027t have time.(Tomoru-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Tomoru-enemy-angry)",
     "Go away please.(Tomoru-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Tomoru-enemy-inlove)",
     "Do you have time?(Tomoru-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Tomoru-enemy-normal)",
     "This is a nice day.(Tomoru-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Tomoru-enemy-happy)",
     "I have great time with you.(Tomoru-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Tomoru-enemy-sad)",
     "Sorry,I don\u0027t have time.(Tomoru-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Tomoru-couples-angry)",
     "Go away please.(Tomoru-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Tomoru-couples-inlove)",
     "Do you have time?(Tomoru-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Tomoru-couples-normal)",
     "This is a nice day.(Tomoru-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Tomoru-couples-happy)",
     "I have great time with you.(Tomoru-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Tomoru-couples-sad)",
     "Sorry,I don’t have time.(Tomoru-couples-sad)"
     ]
     }
     }

     }
     public function get chat_tomoru():Object
     {
     return _chat_tomoru
     }

     public function set chat_zack(obj:Object):void
     {
     _chat_zack={
     "lover": {
     "angry": [
     "Leave me alone.(Zack-lover-angry)",
     "Go away please.(Zack-lover-angry)"
     ],
     "inlove": [
     "I miss you every day.(Zack-lover-inlove)",
     "Do you have time?(Zack-lover-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Zack-lover-normal)",
     "This is a nice day.(Zack-lover-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Zack-lover-happy)",
     "I have great time with you.(Zack-lover-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Zack-lover-sad)",
     "Sorry,I don\u0027t have time.(Zack-lover-sad)"
     ]
     },
     "close_friend": {
     "angry": [
     "Leave me alone.(Zack-close_friend-angry)",
     "Go away please.(Zack-close_friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Zack-close_friend-inlove)",
     "Do you have time?(Zack-close_friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Zack-close_friend-normal)",
     "This is a nice day.(Zack-close_friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Zack-close_friend-happy)",
     "I have great time with you.(Zack-close_friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Zack-close_friend-sad)",
     "Sorry,I don\u0027t have time.(Zack-close_friend-sad)"
     ]
     },
     "friend": {
     "angry": [
     "Leave me alone.(Zack-friend-angry)",
     "Go away please.(Zack-friend-angry)"
     ],
     "inlove": [
     "I miss you every day.(Zack-friend-inlove)",
     "Do you have time?(Zack-friend-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Zack-friend-normal)",
     "This is a nice day.(Zack-friend-normal)"
     ],
     "happy": [
     "I\u0027m happy to meet you.(Zack-friend-happy)",
     "I have great time with you.(Zack-friend-happy)"
     ],
     "sad": [
     "Oh,I don\u0027t feel good today.(Zack-friend-sad)",
     "Sorry,I don\u0027t have time.(Zack-friend-sad)"
     ]
     },
     "enemy": {
     "angry": [
     "Leave me alone.(Zack-enemy-angry)",
     "Go away please.(Zack-enemy-angry)"
     ],
     "inlove": [
     "I miss you every day.(Zack-enemy-inlove)",
     "Do you have time?(Zack-enemy-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Zack-enemy-normal)",
     "This is a nice day.(Zack-enemy-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Zack-enemy-happy)",
     "I have great time with you.(Zack-enemy-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Zack-enemy-sad)",
     "Sorry,I don\u0027t have time.(Zack-enemy-sad)"
     ]
     },
     "couples": {
     "angry": [
     "Leave me alone.(Zack-couples-angry)",
     "Go away please.(Zack-couples-angry)"
     ],
     "inlove": [
     "I miss you every day.(Zack-couples-inlove)",
     "Do you have time?(Zack-couples-inlove)"
     ],
     "normal": [
     "Sure,we could  have a dating.(Zack-couples-normal)",
     "This is a nice day.(Zack-couples-normal)"
     ],
     "happy": [
     "I’m happy to meet you.(Zack-couples-happy)",
     "I have great time with you.(Zack-couples-happy)"
     ],
     "sad": [
     "Oh,I don’t feel good today.(Zack-couples-sad)",
     "Sorry,I don’t have time.(Zack-couples-sad)"
     ]
     }
     }
     }
     public function get chat_zack():Object
     {
     return _chat_zack;
     }

     public function set command(obj:Object):void
     {
     _command={
     "Stay": {
     "dec": "Stay.......................",
     "values": {
     "ap": 100,
     "cash": -300
     },
     "ap": 100
     },
     "LookAround": {
     "dec": "Look around the place to find out any interactive objects.\nINTELLIGENCE will increase the change of success.",
     "ap": 0
     },
     "Train": {
     "dec": "Train.......................",
     "values": {
     "image": 5,
     "cash": -20,
     "ap": -10
     },
     "ap": -10
     },
     "Flirt": {
     "dec": "Flirt.......................",
     "ap": -10
     },
     "Dating": {
     "dec": "Dating.......................",
     "ap": -10
     },
     "Meditate": {
     "dec": "Meditate.......................",
     "values": {
     "ap": -10,
     "cash": 0
     },
     "ap": -10
     },
     "Departures": {
     "dec": "Departures................",
     "ap": 0
     },
     "Chat": {
     "dec": "Chat.......................",
     "ap": -10
     },
     "Arrivals": {
     "dec": "Arrivals................",
     "ap": 0
     },
     "Buy": {
     "dec": "Buy.......................",
     "values": {
     "ap": -10,
     "cash": 0
     },
     "ap": -10
     },
     "FreeRest": {
     "dec": "Rest.......................",
     "values": {
     "ap": 10
     },
     "ap": 10
     },
     "NightclubWork": {
     "dec": "NightclubWork.......................",
     "values": {
     "ap": -50,
     "cash": 0
     },
     "ap": -50
     },
     "ThemedParkWork": {
     "dec": "ThemedParkWork.......................",
     "values": {
     "ap": -50,
     "cash": 0
     },
     "ap": -50
     },
     "PayRest": {
     "dec": "Rest.......................",
     "values": {
     "ap": 50,
     "cash": -150
     },
     "ap": 50
     },
     "Learn": {
     "dec": "Learn.......................",
     "values": {
     "int": 0,
     "cash": -20,
     "ap": -10
     },
     "ap": -10
     },
     "Join": {
     "dec": "Join.......................",
     "ap": -10
     },
     "BankWork": {
     "dec": "BankWork.......................",
     "values": {
     "ap": -50,
     "cash": 0
     },
     "ap": -50
     },
     "Give": {
     "dec": "Give xxxxxxxxxxxxx.",
     "ap": -10
     },
     "StartDating": {
     "dec": "Start dating with partner.",
     "ap": -10
     }
     }

     }
     public function get command():Object
     {
     return _command;

     }

     public function set commander_items(obj:Object):void
     {
     _commander_items={
     "com0": {
     "label": "Change Formation",
     "price": "0.99"
     },
     "com1": {
     "label": "Battle Cry",
     "price": "0.99"
     }
     }
     }
     public function get commander_items():Object
     {
     return _commander_items;
     }

     public function set cpu_teams(obj:Object):void
     {
     _cpu_teams={
     "t3_0": {
     "skill": "a1,a1"
     },
     "t0_2": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t3_7": {
     "skill": "a1,a1"
     },
     "t2_6": {
     "skill": "a1,a1"
     },
     "t6_2": {
     "skill": "a1,a1"
     },
     "t4_0": {
     "skill": "a1,a1"
     },
     "t9_4": {
     "skill": "a1,a1"
     },
     "t4_6": {
     "skill": "a1,a1"
     },
     "t4_1": {
     "skill": "a1,a1"
     },
     "t1_7": {
     "skill": "a1,a1"
     },
     "t1_4": {
     "skill": "a1,a1"
     },
     "t6_1": {
     "skill": "a1,a1"
     },
     "t0_1": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t2_2": {
     "skill": "a1,a1"
     },
     "t0_0": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t2_5": {
     "skill": "a1,a1"
     },
     "t4_7": {
     "skill": "a1,a1"
     },
     "t3_4": {
     "skill": "a1,a1"
     },
     "t8_3": {
     "skill": "a1,a1"
     },
     "t0_6": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t8_7": {
     "skill": "a1,a1"
     },
     "t8_1": {
     "skill": "a1,a1"
     },
     "t6_6": {
     "skill": "a1,a1"
     },
     "t5_0": {
     "skill": "a1,a1"
     },
     "t5_2": {
     "skill": "a1,a1"
     },
     "t3_1": {
     "skill": "a1,a1"
     },
     "t9_1": {
     "skill": "a1,a1"
     },
     "t1_5": {
     "skill": "a1,a1"
     },
     "t2_3": {
     "skill": "a1,a1"
     },
     "t4_2": {
     "skill": "a1,a1"
     },
     "t0_5": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t1_0": {
     "skill": "s0"
     },
     "t6_3": {
     "skill": "a1,a1"
     },
     "t0_7": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t7_2": {
     "skill": "a1,a1"
     },
     "t7_0": {
     "skill": "a1,a1"
     },
     "t6_4": {
     "skill": "a1,a1"
     },
     "t3_5": {
     "skill": "a1,a1"
     },
     "t7_4": {
     "skill": "a1,a1"
     },
     "t0_3": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t2_0": {
     "skill": "a1,a1"
     },
     "t5_4": {
     "skill": "a1,a1"
     },
     "t6_5": {
     "skill": "a1,a1"
     },
     "t7_6": {
     "skill": "a1,a1"
     },
     "t5_5": {
     "skill": "a1,a1"
     },
     "t9_6": {
     "skill": "a1,a1"
     },
     "t4_5": {
     "skill": "a1,a1"
     },
     "t8_2": {
     "skill": "a1,a1"
     },
     "t8_4": {
     "skill": "a1,a1"
     },
     "t9_0": {
     "skill": "a1,a1"
     },
     "t1_6": {
     "skill": "a1,a1"
     },
     "t7_5": {
     "skill": "a1,a1"
     },
     "t9_7": {
     "skill": "a1,a1"
     },
     "t7_1": {
     "skill": "a1,a1"
     },
     "t2_1": {
     "skill": "a1,a1"
     },
     "t3_6": {
     "skill": "a1,a1"
     },
     "t5_6": {
     "skill": "a1,a1"
     },
     "t8_5": {
     "skill": "a1,a1"
     },
     "t1_1": {
     "skill": "s0"
     },
     "t9_2": {
     "skill": "a1,a1"
     },
     "t7_3": {
     "skill": "a1,a1"
     },
     "t6_0": {
     "skill": "a1,a1"
     },
     "t1_3": {
     "skill": "a1,a1"
     },
     "t4_3": {
     "skill": "a1,a1"
     },
     "t9_5": {
     "skill": "a1,a1"
     },
     "t1_2": {
     "skill": "a1,a1"
     },
     "t2_7": {
     "skill": "a1,a1"
     },
     "t5_1": {
     "skill": "a1,a1"
     },
     "t0_4": {
     "skill": "f0,f1,f2,f3,a0,a1,a2,a3,e0,e1,e2,e3,w0,w1,w2,w3,n0,n1,n2,n3"
     },
     "t5_7": {
     "skill": "a1,a1"
     },
     "t7_7": {
     "skill": "a1,a1"
     },
     "t4_4": {
     "skill": "a1,a1"
     },
     "t9_3": {
     "skill": "a1,a1"
     },
     "t5_3": {
     "skill": "a1,a1"
     },
     "t3_2": {
     "skill": "a1,a1"
     },
     "t2_4": {
     "skill": "a1,a1"
     },
     "t3_3": {
     "skill": "a1,a1"
     },
     "t8_0": {
     "skill": "a1,a1"
     },
     "t8_6": {
     "skill": "a1,a1"
     },
     "t6_7": {
     "skill": "a1,a1"
     }
     }
     }

     public function get cpu_teams():Object
     {
     return _cpu_teams;
     }
     public function set date_response(obj:Object):void
     {
     _date_response={
     "n": [
     "No,I\u0027m busy now.",
     "Sorry,Not today.",
     "No,I\u0027ld like to stay home today."
     ],
     "y": [
     "Yes,How about now",
     "Sure,Sounds good.",
     "Interesting!"
     ]
     }
     }
     public function get date_response():Object
     {
     return _date_response;
     }
     public function set secrets(obj:Object):void
     {
     _secrets={
     "s_15": {
     "ans": "themed parks,seaside,aquarium,farmland,lagoon,zoos,science museum,basement",
     "q": "my favorite place as a child is |~|"
     },
     "s_19": {
     "ans": "geography, psychology, science, history, language studies, mythology, music theory, physical education",
     "q": "my most favorite subject in school is a |~|"
     },
     "s_4": {
     "ans": "kyoto, paris, dubai, male, bangkok, barcelona, cancun, florence",
     "q": "my favorite travel destination is |~|"
     },
     "s_1": {
     "ans": "chinese,japanese,thai,greek,italian,french,mexican,lebanese",
     "q": "my favorite cuisine is |~|"
     },
     "s_5": {
     "ans": "veterinarian, detective, musician, actor, writer, soldier, dancer, astronaut",
     "q": "my dream job as a child is |~|"
     },
     "s_11": {
     "ans": "black tie,black eye,mocha,cappuccino,latte,espresso,vienna coffee,white coffee",
     "q": "my Favorite type of coffee is |~|"
     },
     "s_3": {
     "ans": "Meat Duck,Beany,Booboo,Monkey Buns,Pudding,Snookie,Egghead,doodle",
     "q": "my childhood nickname is |~|"
     },
     "s_6": {
     "ans": "Usagi Tsukino,Batman,Goku,L,Monkey D.Luffy,Naruto Uzumaki,Iron Man,Edward Elric",
     "q": "my childhood hero is |~|"
     },
     "s_2": {
     "ans": "Riverbank,Northdale,Riverdell,Easton,Cedarwood,Ashton,Westbank,Maybeck",
     "q": "I went to |~| high school"
     },
     "s_10": {
     "ans": "cheese cake,tiramisu,ice cream,peach pie,chocolate,cupcakes,carrot cake,brownies",
     "q": "my Favorite dessert is |~|"
     },
     "s_7": {
     "ans": "cody,duk,lila,mia,cleo,kobe,taz,zula",
     "q": "I used to have a pet called |~|"
     },
     "s_18": {
     "ans": "human, cat, dog, guinea pig,hamster,rabbit,parrot,turtle",
     "q": "the first pet I have is a |~|"
     },
     "s_14": {
     "ans": "going to dentists,ghosts,being alone in the dark,spiders,snakes,zombies,lighting and thunder,blood",
     "q": "the thing that I feared most is |~|"
     },
     "s_8": {
     "ans": "dragonball,chobits,death note,one piece,naruto,pokemon,attack on titan,Fullmetal Alchemist",
     "q": "my favorite Anime as a child |~|"
     },
     "s_17": {
     "ans": "avant-garde,pop,hip hop,rock,r\u0026b,rap,techno,heavy metal",
     "q": "my favourite type of music is |~|"
     },
     "s_13": {
     "ans": "rpg,first-person shooters,real-time strategy,dating sim,car racing,sport,puzzles, platform",
     "q": "my favorite video game genre is |~|"
     },
     "s_9": {
     "ans": "italy,france,mexico,japan,slovakia,spain,sri lanka,ecuador",
     "q": "the first time I travelled I went to |~|"
     },
     "s_12": {
     "ans": "fruit wine,brown ale,lager,sake,palm wine,cider,whiskey,vodka",
     "q": "my Favorite type of alcohol is |~|"
     },
     "s_0": {
     "ans": "red,blue,black,white,pink,orange,green,brown",
     "q": "my favorite color is |~|"
     },
     "s_16": {
     "ans": "he Valentine’s, xmas,new year,summer holiday,spring break,fireworks festival,moon festival,\thalloween",
     "q": "I think |~| is the best time of the year"
     }
     }
     }
     public function get secrets():Object
     {
     return _secrets;
     }
     public function set secrets_chat(arr:Array):void
     {
     _secrets_chat=[
     "|~| is simply the BEST!",
     "I love |~| so mouch.",
     "I like |~| a lot.",
     "|~| ? It\u0027s prety cool.",
     "|~| ? It\u0027s not bad.",
     "I think |~|  is just okay!",
     "I don\u0027t like |~|.",
     "|~| is no good.",
     "I freaking hate |~|.",
     "|~| makes me feel disgusled extrenely."
     ]
     }
     public function get secrets_chat():Array
     {
     return _secrets_chat;
     }

     public function set skillsys(obj:Object):void
     {
     _skillsys={
     "s0": {
     "type": "",
     "power": 100,
     "area": 2,
     "enemy": 5,
     "ele": "",
     "effect": "",
     "label": "Combine Skill",
     "jewel": "",
     "speed": 100,
     "note": ""
     },
     "s1": {
     "type": "",
     "power": 0,
     "area": 2,
     "enemy": 5,
     "ele": "",
     "effect": "mind_ctrl",
     "label": "Mind Control",
     "jewel": "",
     "speed": 1000,
     "note": ""
     },
     "e2": {
     "type": "",
     "power": 170,
     "area": 0,
     "enemy": 3,
     "ele": "earth",
     "effect": "",
     "label": "E_Slash",
     "jewel": "4|e",
     "speed": 90,
     "note": ""
     },
     "w3": {
     "type": "",
     "power": 0,
     "area": 2,
     "enemy": 5,
     "ele": "water",
     "effect": "",
     "label": "W_SPSpears",
     "jewel": "5|w",
     "speed": 80,
     "note": "Inflict random damages to all enemies. "
     },
     "e1": {
     "type": "hop",
     "power": 95,
     "area": 0,
     "enemy": 1,
     "ele": "earth",
     "effect": "scared",
     "label": "E_Juggle",
     "jewel": "3|e",
     "speed": 110,
     "note": "Inflict COWARDICE on target; reduce target’s SKILL SPEED by ⅔."
     },
     "a2": {
     "type": "hop",
     "power": 85,
     "area": 0,
     "enemy": 1,
     "ele": "air",
     "effect": "dizzy",
     "label": "A_16PPS",
     "jewel": "3|a",
     "speed": 130,
     "note": "Inflict DIZZINESS on target; target cannot make any move.  "
     },
     "w1": {
     "type": "",
     "power": 40,
     "area": 1,
     "enemy": 1,
     "ele": "water",
     "effect": "",
     "label": "W_Sword",
     "jewel": "2|w",
     "speed": 180,
     "note": ""
     },
     "n3": {
     "type": "",
     "power": 0,
     "area": 2,
     "enemy": 5,
     "ele": "neutral",
     "effect": "",
     "label": "N_Reflect",
     "jewel": "5|n",
     "speed": 10,
     "note": "Absorb all enemy attacks to recover SE for the team while reflecting all damages back to the enemies, until the accumulated damages absorbed exceeds the SE limit of the skill user. "
     },
     "f1": {
     "type": "hop",
     "power": 90,
     "area": 2,
     "enemy": 2,
     "ele": "fire",
     "effect": "",
     "label": "F_DrillKick",
     "jewel": "3|f",
     "speed": 140,
     "note": ""
     },
     "n2": {
     "type": "",
     "power": 400,
     "area": 2,
     "enemy": 4,
     "ele": "neutral",
     "effect": "heal",
     "label": "N_Mimic",
     "jewel": "3|n",
     "speed": 20,
     "note": "Recover SE for up to four teammates. "
     },
     "n0": {
     "type": "",
     "power": 70,
     "area": 0,
     "enemy": 1,
     "ele": "neutral",
     "effect": "heal",
     "label": "N_Regenate",
     "jewel": "1|n",
     "speed": 40,
     "note": "Recharge own SE. "
     },
     "w2": {
     "type": "m_hop",
     "power": 85,
     "area": 1,
     "enemy": 3,
     "ele": "water",
     "effect": "",
     "label": "W_BackRow",
     "jewel": "3|w",
     "speed": 120,
     "note": ""
     },
     "e0": {
     "type": "hop",
     "power": 50,
     "area": 0,
     "enemy": 1,
     "ele": "earth",
     "effect": "",
     "label": "E_Blade",
     "jewel": "2|e",
     "speed": 160,
     "note": ""
     },
     "e3": {
     "type": "",
     "power": 430,
     "area": 2,
     "enemy": 2,
     "ele": "earth",
     "effect": "",
     "label": "E_SPStorm",
     "jewel": "5|e",
     "speed": 50,
     "note": "Shatter enemy formation."
     },
     "a0": {
     "type": "",
     "power": 0,
     "area": 0,
     "enemy": 0,
     "ele": "air",
     "effect": "shield",
     "label": "A_Shield",
     "jewel": "1|a",
     "speed": 200,
     "note": "Completely shield the skill user from all EARTH attacks; receive only 25% of damages from all other attacks."
     },
     "f0": {
     "type": "hop",
     "power": 45,
     "area": 0,
     "enemy": 1,
     "ele": "fire",
     "effect": "",
     "label": "F_Kick",
     "jewel": "2|f",
     "speed": 170,
     "note": ""
     },
     "w0": {
     "type": "",
     "power": 0,
     "area": 0,
     "enemy": 0,
     "ele": "water",
     "effect": "",
     "label": "W_Shield",
     "jewel": "1|w",
     "speed": 190,
     "note": "Completely shield the skill user from all FIRE attacks; receive only 25% of damages from all other attacks."
     },
     "a3": {
     "type": "",
     "power": 400,
     "area": 2,
     "enemy": 5,
     "ele": "air",
     "effect": "scared",
     "label": "A_SPDragon",
     "jewel": "5|a",
     "speed": 60,
     "note": "Inflict COWARDICE on target; reduce target’s SKILL SPEED by ⅔."
     },
     "f3": {
     "type": "",
     "power": 370,
     "area": 2,
     "enemy": 4,
     "ele": "fire",
     "effect": "dizzy",
     "label": "F_SPTornado",
     "jewel": "5|f",
     "speed": 70,
     "note": "Inflict DIZZINESS on target; target cannot make any move."
     },
     "a1": {
     "type": "hop",
     "power": 55,
     "area": 0,
     "enemy": 1,
     "ele": "air",
     "effect": "",
     "label": "A_Punch",
     "jewel": "2|a",
     "speed": 150,
     "note": ""
     },
     "n1": {
     "type": "",
     "power": 180,
     "area": 0,
     "enemy": 0,
     "ele": "neutral",
     "effect": "heal",
     "label": "N_Heal",
     "jewel": "2|n",
     "speed": 30,
     "note": "Recover SE for one teammate."
     },
     "f2": {
     "type": "m_hop",
     "power": 150,
     "area": 2,
     "enemy": 3,
     "ele": "fire",
     "effect": "",
     "label": "F_FireBalls",
     "jewel": "4|f",
     "speed": 100,
     "note": ""
     }
     }
     }
     public function get skillsys():Object
     {
     return _skillsys;
     }
     public function set trashtalking(arr:Array):void
     {
     _trashtalking=[
     "Oh,Hi",
     "Excuse me for interrupting.",
     "I like to watch movies a lot.",
     "I walk home every night.",
     "…"
     ]
     }
     public function get trashtalking():Array
     {
     return _trashtalking;
     }
     */
}
}