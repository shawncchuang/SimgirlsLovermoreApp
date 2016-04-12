/**
 * Created by shawnhuang on 2016-04-11.
 */
package data {
public class CommandDAO {
    public static function getData():Object {
        var _data:Object={
            "LookAround": {
                "dec": "You never know!",
                "ap": -10
            },
            "StartDating": {
                "dec": "Spend time with your date.",
                "ap": 0
            },
            "Chat": {
                "dec": "Both Intelligence and self-image are important. Need to be in the right mood.",
                "ap": -5
            },
            "Change": {
                "dec": "Change your clothes.",
                "ap": 0
            },
            "NightclubWork": {
                "dec": "Looking hot? Be a sexy go-go dancer; the Shambalians are big tippers!",
                "ap": -60
            },
            "Leave": {
                "cash": 0,
                "ap": 0
            },
            "Practice": {
                "dec": "Why not? You have nothing to do. Better than watching porn.",
                "ap": -60
            },
            "Save": {
                "dec": "Save your game progress.",
                "ap": 0
            },
            "Battle": {
                "dec": "Fight SSCC battle. Check Calendar for game schedule.",
                "ap": 0
            },
            "FreeRest": {
                "values": {
                    "ap": 30
                },
                "dec": "Partially recharge your Action Points (AP). Can\u0027t afford a room?",
                "ap": 0
            },
            "Meditate": {
                "dec": "Recharge your Spirit Energy (SE). Catch the Sushi and avoid the Hammers!",
                "ap": -60
            },
            "PayRest": {
                "values": {
                    "cash": -150,
                    "ap": 100
                },
                "dec": "Fully recharge your Action Points (AP). Stay for $150 only.",
                "ap": 0
            },
            "CaptainSkills": {
                "values": {
                    "cash": 0,
                    "ap": 0
                },
                "dec": "Only the Captain can use these skills.",
                "ap": 0
            },
            "LearnSkills": {
                "values": {
                    "cash": 0,
                    "ap": 0
                },
                "dec": "If you are serious about picking up Spirit Martial Arts (SMA), you will need some.",
                "ap": 0
            },
            "Kiss": {
                "dec": "For Lovers and above. Need to be in the right mood.",
                "ap": -20
            },
            "ThemedParkWork": {
                "dec": "No degree? No experience? No problem! We just need a good heart.",
                "ap": -60
            },
            "Buy": {
                "dec": "We only accept USD! No refund no exchange.",
                "ap": 0
            },
            "BuyGifts": {
                "dec": "Shop till your drop. We just want your $$$!",
                "ap": 0
            },
            "BuyClothes": {
                "dec": "Shop till your drop. We just want your $$$!",
                "ap": 0
            },
            "Use": {
                "dec": "Use the illegal items you bought from the black market.",
                "ap": 0
            },
            "Stay": {
                "values": {
                    "cash": -300,
                    "ap": 100
                },
                "dec": "Stay.......................",
                "ap": 100
            },
            "BankWork": {
                "dec": "Long work hours; pay on commission only; no dumb people please.",
                "ap": -80
            },
            "Load": {
                "dec": "Load a game progress.",
                "ap": 0
            },
            "Train": {
                "values": {
                    "image": "80~95",
                    "cash": -40
                },
                "dec": "Increase Self-image. Fees $40.",
                "ap": -60
            },
            "Flirt": {
                "dec": "Self-image is important. For Dating Partners and above. Need to be in the right mood.",
                "ap": -10
            },
            "Date": {
                "dec": "For Close Friends and above. Need to be in the right mood.",
                "ap": -10
            },
            "Research": {
                "values": {
                    "cash": -20,
                    "int": "80~95"
                },
                "dec": "Increase Intelligence. Fees $20",
                "ap": -60
            },
            "CheckStatus": {
                "dec": "Games of the day (if any) and current team rankings.",
                "ap": 0
            },
            "TakePhoto": {
                "dec": "For Friends and above. Need to be in the right mood.",
                "ap": -10
            },
            "Give": {
                "dec": "Choosing the perfect gift for him/her is never easy. Need to be in the right mood.",
                "ap": -10
            },
            "HuntCriminals": {
                "dec": "Keep looking around in different locations to hunt them. It takes some luck and you may or may not run into them.",
                "ap": 0
            },
            "RunAwayRandomBattle": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": -50
                }
            },
            "Relax": {
                "values": {
                    "mood": 0,
                    "cash": -5000
                },
                "dec": "Organize a trip to the Hot Spring for the team. Bring everyone’s mood back to CALM. Fees $5000",
                "ap": -100
            },
            "Sail": {
                "values": {
                    "cash": -60,
                    "ap": 60
                },
                "dec": "Take a short break from everything. Recharge 60 AP. Fees $60",
                "ap": 0
            },
            "WatchMovies": {
                "values": {
                    "cash": -30,
                    "int": 33
                },
                "dec": "Increase Intelligence. Also increase mood during a date. Fees $30",
                "ap": -30
            },
            "BattleTutorial": {
                "dec": "It is important to learn all the basics.",
                "ap": 0,
                "values": {
                    "cash": 0
                }
            },
            "Think": {
                "values": {
                    "int": 40
                },
                "dec": "Increase intelligence. Also increase mood during a date.",
                "ap": -40
            },
            "Drink": {
                "values": {
                    "image": 53,
                    "cash": -300
                },
                "dec": "Increase image. Also increase mood during a date. Fees $300",
                "ap": -30
            },
            "HangAround": {
                "values": {
                    "image": 22,
                    "cash": -10
                },
                "dec": "Increase image. Also increase mood during a date. Fees $10",
                "ap": -20
            },
            "Dine": {
                "values": {
                    "image": 87,
                    "cash": -600
                },
                "dec": "Increase image. Also increase mood during a date. Fees $600",
                "ap": -40
            },
            "Play": {
                "values": {
                    "cash": -500
                },
                "dec": "Take a risk. Fees $500",
                "ap": -30
            },
            "skillPts+": {
                "dec": "",
                "ap": 0,
                "values": {
                    "skillPts": 50
                }
            },
            "honor+": {
                "dec": "",
                "ap": 0,
                "values": {
                    "honor": 500
                }
            },
            "love+": {
                "dec": "",
                "ap": 0,
                "values": {
                    "love": 250
                }
            },
            "int+": {
                "dec": "",
                "ap": 0,
                "values": {
                    "int": 500
                }
            },
            "image+": {
                "dec": "",
                "ap": 0,
                "values": {
                    "image": 500
                }
            },
            "cash+": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 1500
                }
            },
            "HuntRewards-S": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 20000
                }
            },
            "HuntRewards-A": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 15000
                }
            },
            "HuntRewards-B": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 10000
                }
            },
            "HuntRewards-C": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 5000
                }
            },
            "HuntRewards-D": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 2000
                }
            },
            "HuntRewards-E": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 1000
                }
            },
            "HuntRewards-F": {
                "dec": "",
                "ap": 0,
                "values": {
                    "cash": 500
                }
            }
        };
        return _data;
    }
}
}
