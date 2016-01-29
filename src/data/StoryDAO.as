/**
 * Created by shawnhuang on 2016-01-04.
 */
package data {
public class StoryDAO {
    private static var access:Array=new Array();
    private static const container:Object={"s001":s001(),"s002":s002(),"s003":s003(),"s004":s004(),
        "s005":s005(),"s006a":s006a(),"s006b":s006b(),"s007":s007(),"s008":s008(),"s009":s009(),"s010":s010(),
        "s011":s011(), "s012":s012(),"s013":s013(),"s014":s014(),"s015":s015(),
        "s016":s016(),"s017":s017(),"s018":s018(),"s019":s019(),"s020":s020(),
        "s021":s021(),"s022":s022(),"s023":s023(),"s024":s024(),"s025":s025(),
        "s260":s260(),"s261":s261(),"s262":s262(),"s270":s270(),"s9999":s9999()};
    public static function switchStory(id:String):Array {

        access=container[id];
        return access;
    }

    private static function s001():Array{

        return [
            "com|bg_HotelScene#com|display_daz_center",
            "spC|Aloha! Welcome to the Hotel Shambala.",
            "spC|While we are getting your room ready, let me explain a bit about ACTION POINTS or simply AP.",
            "spC|AP determines how many things you can do in a given time period. Most activities will consume your AP.",
            "spC|When your AP is running out, you can regain AP by taking a rest in our hotel.",
            "spC|Just so you know I am always here seven days a week. Whenever you need me, you just have to LOOK AROUND.",
            "spC|Workaholic? We are Shambalians! We enjoy our work. See you around!",
            "END"
        ]

    }
    //  "com|display_sao_swimsuit_center",
    private static function s002():Array{

        return [
            "com|bg_BeachScene#com|music-on_beachparty",
            "com|display_sao_swimsuit_center",
            "spC|What are you waiting for!? Go get changed! The bitches are waiting!",
            "player|I went into the empty changing room.",
            "com|remove_sao_swimsuit_center",
            "com|bg_ChangingRoomScene",
            "player|Just when I removed all my clothes<> a stranger rushes into the changing room.",
            "com|display_ceil_swimsuit1_center",
            "spC|Have you seen my cat!?",
            "player|The blonde girl seemed very worried and the fact that I was butt-naked didn't seem to bother her at all. Uneasy<> I covered myself with my hands.",
            "com|photo-on_ChangingCat",
            "player|She showed me a selfie of her with the cat. The cat was cute ... and the girl had a fantastic body!",
            "player|Blonde Girl: My cat! Tom Yum! Have you seen him!?",
            "com|photo-off#com|music-off_beachparty",
            "com|photo-on_ChangingCeil",
            "player|I raised my hands and shrugged my shoulders. ",
            "com|swf-on_fxzok",
            "player|AAAAHHHHHHHH!",
            "player|I uncovered myself... and the girl runs outside flustered.",
            "com|photo-off",
            "com|remove_ceil_swimsuit1_center",
            "END"
        ]

    }
    private static function s003():Array{
        return[
            "com|bg_MuseumScene#com|music-on_liberty",
            "com|display_sao_casual1_center",
            "spC|Now that's wacky. Shambala was founded by a legendary Mega-playboy<> Primero Lovemore!",
            "com|photo-on_MuseumStatue",
            "player|Sao shows me a statue of the 'Mega-playboy' Primero Lovemore. There were a lot of stories about Mr. Lovemore. ",
            "player|He was the founding father of this new nation Shambala... ",
            "com|photo-off",
            "com|photo-on_MuseumMarry",
            "player|...but he became famous mostly because he had four very beautiful wives. That's why people call him the Mega-playboy.",
            "player|Sao: Wait-a-sec!! Four wives!? What a lucky guy! I would give anything to be him!",
            "com|photo-off",
            "com|move_sao_casual1_left",
            "com|display_lenus_work_right",
            "spR|......",
            "com|photo-on_MuseumLenus",
            "player|A tall young man next to us shakes his head and sighs. ",
            "player|Sao: What's the problem man? This dude is a boss!",
            "player|Stranger: You know nothing about this man.",
            "player|The young man walks away before Sao could respond to the bitter comment. ",
            "com|photo-off",
            "com|remove_lenus_work_right",
            "spL|Whatever 'Nerdyman'!... I can't stand people with that 'know-it-all' attitude.",
            "player|Strangely<> I thought the man kinda looked like the statue of the Mega-playboy Lovemore. ",
            "com|music-off_liberty",
            "END"
        ]

    }
    private static function s004():Array{
        return [
            "com|bg_NightclubScene#com|music-on_clubmusic",
            "com|display_sao_casual1_center",
            "spC|It’s Friday night<> the only decision you need to make is bottle or glass. See ya around okay!?",
            "com|remove_sao_casual1_center",
            "player|Sao disappears in the crowd. I get myself a drink at the bar and walk around aimlessly in the club. This is the nicest club I've ever been to! ",
            "com|photo-on_ClubDancer",
            "player|A girl dancing in a cage catches my eye. ",
            "player|She has fiery red hair<> a mask and an outfit that barely covers her extravagant body. I don't know much about dancing but her moves were mesmerizing. ",
            "player|She smiled at me a few times too.",
            "player|Well... it can be a delusion<> but I seriously think she is flirting at me.",
            "player|Some time later...",
            "com|photo-off#com|bg_SkyNight#com|display_sao_casual1_left",
            "com|music-off_clubmusic",
            "player|Sao steps outside for a cigarette break. He doesn't smoke regularly<> but smokes socially for fun. ",
            "com|display_zack_casual1_right#com|music-on_zackMusic",
            "spR|Hey kid on the plane<> I told you we would see each other again!",
            "spL|Damn it! Didn't I 'un-friend' you!? Are you one of my followers now?",
            "com|photo-on_ClubArmlock",
            "player|The red-haired guy hooks his arm around Sao's neck. He seems to be drunk.",
            "player|Red-haired guy: Do you know who I am? ",
            "player|Let me tell you what's up... I am Zack Krieg. Heir to Rufus Krieg<> the Captain General of Blackspears. We fucking RULE this place.",
            "player|Sao: What!? Blackspears? Never heard of it<> sorry dude.",
            "player|Of course you wouldn't know. You're a dumb shit kid that doesn't recognize greatness even if it's staring you in the face! ",
            "player|Blackspears saved the World from terrorists in the old war. Without us you'd still be jizz in your daddy's palm... hahaha!",
            "com|photo-off",
            "shL|Alright<> that's it! This conversation is OVER!",
            "com|photo-on_ClubElbow#com|swf-on_fxbam",
            "player|Sao peels back Zack's finger and pulls it hard to release the arm lock followed by a swift elbow to the gut. Sao's been in a lot of street fights back in high school. He never lose a fight in his life.",
            "player|HHUUURRRGGGGG!",
            "player|Zack falls a few steps back. Sao doesn't stop. He sprints and aims another punch at Zack's face...",
            "com|photo-off",
            "shR|Enough kid!",
            "com|photo-on_ClubKick#com|swf-on_fxzok",
            "player|Suddenly<> Zack is surrounded by a fiery aura. ",
            "player|In a split second Zack kicks Sao's chest sending him flying 30 feet away!",
            "com|photo-off",
            "com|photo-on_ClubBin#com|swf-on_fxbam",
            "player|Sao crashed hard into a garbage bin!",
            "player|That's when I came out of the club. Sao was knocked out. ",
            "player|HEY! Whats going on!?",
            "com|photo-off#com|remove_sao_casual1_left",
            "com|move_zack_casual1_center",
            "spC|Oh<> I remember you. You were sitting with that idiot kid on the plane. It's your turn to sleep!",
            "player|Zack explodes with the fiery aura again and charges towards me in blazing speed...",
            "com|photo-on_ClubBlock#com|swf-on_fxzok",
            "player|BANG!!!!",
            "player|A small figure appears in front of me and blocks the attack with some kind of green energy surrounding her. ",
            "com|photo-off#com|move_zack_casual1_left",
            "com|display_klr_work_right",
            "shR|Back off Zack!",
            "spL|Hey Officier<> they started the fight! I know the Laws of Shambala. I have the right to finish this!",
            "spR|Those rules don't apply to tourists and non-SMA practitioners!",
            "spL|Hmph<> whatever! So... you're a bitch citizen and a wack SMA fighter<> should I show YOU the wrath of a Krieg!?",
            "spR|What did you just call me!?",
            "player|Zack and the female police officer go at each other again with vigor...",
            "com|photo-on_ClubTyren#com|swf-on_fxboom",
            "player|...a giant figure in a suit interrupts and stands between them absorbing both their hits with his gigantic body. ",
            "player|Zack: Tyren<> what are you doing?! Get out of my way!",
            "player|Tyren: Not a good idea<> sir!",
            "player|Zack: Tyren! You are MY bodyguard. You take orders from ME!",
            "player|Tyren: Attacking tourists can be criminal offense. Your father Mr. Krieg will not be happy if he has to bail you out of jail again.",
            "player|Zack: Tsk!",
            "player|Zack leaves without any further complaint. His father must be a powerful man. ",
            "com|photo-off",
            "com|music-off_zackMusic",
            "com|remove_zack_casual1_left",
            "spR|Crap!",
            "player|Sao regains consciousness and looks dazed. He is still disarrayed by the power of Zack's attack. ",
            "com|display_sao_casual1_left",
            "spL|...what the heck is going on?",
            "spR|That was SMA... Spirit Martial Arts.",
            "spR|If you guys are planning to stay around<> don't get into any more fights! ",
            "spR|Shambala is run by an SMA government. There are a lot of SMA practitioners here... ",
            "spR|...and it's perfectly legal to settle disputes through street fights.",
            "spR|You're lucky Zack Krieg only released a fraction of his Spirit Energy. That attack could have been the end of your vacation.",
            "spL|Woah... Spirit... Martial Arts? Spirit... Energy?",
            "spR|Interested? Okay... I would highly recommend you...",
            "shR|Oh crap! Almost forgot! The SS-ball game is on tonight! ",
            "spR|If you guys are okay now<> I'm going to get off work a bit early...",
            "spL|Huh...?",
            "com|photo-on_ClubSalute",
            "player|Please excuse me folks! Stay away from troubles. Bye!",
            "player|The police officer salutes and runs off. ",
            "player|Shambala sure is a weird place. I wonder what other experiences lie ahead in our trip.",
            "com|photo-off#com|bg_Alley",
            "player|In a dark alley outside the club<> Little Miss S from the psychic shop has recorded the entire street fight. She is talking to someone through the earpiece. ",
            "com|display_sirena_work_center",
            "spC|I'm not sure if Sao is the AMAGI. I don't see much potential in him. Maybe I got the wrong guy?",
            "player|There is no way to make certain. Just let him fuck around for now. Just keep an eye on him. ",
            "spC|Okay... if you say so.",
            "END"
        ]
    }

    private static function s005():Array{

        return [
            "com|bg_HotelScene",
            "com|display_sao_casual1_center",
            "spC|Yo! Have you seen my necklace?",
            "spC|...the one that my mom Ana gave me before she passed away. I think I dropped it somewhere in the last couple days. ",
            "spC|No? I'm going to look for it at the night club. Can you help me to check the museum? ",
            "com|remove_sao_casual1_center#com|bg_Sky",
            "player|On the way to the museum. ",
            "com|photo-on_GardenCat",
            "player|Meow!",
            "player|There's a cat in the bush. It looks vaguely familiar. Oh! It must be that cute girl's... the cat from the picture I saw in the changing room! ",
            "player|I approach the cat cautiously<> but the cat got scared and ran away. I run after the cat into the woods.",
            "com|photo-off#com|bg_Woods#com|music-on_acoustic",
            "player|What is that music? It seemed as if the cat is running towards the music. ",
            "player|I searched through the woods until it opened up to a beautiful garden surrounded with blue flowers. ",
            "com|bg_GardenScene",
            "player|Where's the cat...?",
            "com|photo-on_GardenGuitar",
            "player|A girl with silver hair is playing a wooden guitar in the garden. ",
            "player|She is quite special to say the least. Who would still be playing an accoustic guitar these days? ",
            "player|She had my attention. She noticed me as well.",
            "com|photo-off#com|music-off_acoustic",
            "com|display_dea_work_center",
            "spC|Hello there!",
            "player|Oh excuse me. I am just looking for a cat...",
            "player|I scanned the area to realize that the cat was gone. ",
            "spC|A Cat?",
            "com|move_dea_work_left",
            "com|display_temple_right",
            "shR|This is a private area! You aren't allowed in here! Leave!",
            "spL|Wait...",
            "spL|Sorry<> he's the temple guardian here. ",
            "spL|Take my card. Call me. I will let you know if I see the cat. ",
            "com|photo-on_GardenCard",
            "player|The girl gave me a business card. She is the High Priestess of the Temple teaching people how to use Spirit Energy.",
            "player|Spirit Energy... the mysterious powers we saw outside of the night club. I am sure Sao will be interested in this one. ",
            "com|photo-off#com|bg_HotelScene",
            "player|At the end<> Sao found the necklace given to him by his mom Ana. It was lost under the sofa cushion in the hotel room the whole time!",
            "player|He must have been too drunk last night and lost it sleeping on the sofa. ",
            "com|display_sao_casual1_center",
            "spC|Phew! Thanks the Universe. I thought I've lost it!",
            "com|photo-on_GardenNecklace",
            "player|The necklace is important to him. Sao's dad died when he was still a baby. His dad gave this pendant to his mom Ana. ",
            "player|A few years ago Ana passed away too and gave it to Sao. ",
            "player|Sao is the only child in the family. The pendant is pretty much their family heritage. ",
            "END"
        ]
    }
    private static function s006a():Array{

        return [
            "com|bg_CasinoScene",
            "com|display_sao_casual1_center",
            "spC|Damn! Not my lucky day...",
            "player|Sao and I are trying our luck at the Roulette table. Sao complains as the dealer rakes a pile of chips towards me. ",
            "spC|Oh man<> you're slammin it today!",
            "player|A gorgeous blonde in a chinese dress approaches the table<> turning the heads of all the males in the area.",
            "com|remove_sao_casual1_center",
            "com|display_sirena_night_center#com|music-on_sirenaMusic",
            "player|She places a stack of all her chips on RED.",
            "player|The wheel spins<> with the ball bouncing around. It finally rests on a black number disappointingly.",
            "player|The beautiful girl frowns and sends me a bitter smile. She steps back and disappears into the crowd. ",
            "com|remove_sirena_night_center",
            "player|She definitely got my attention. The next few minutes<> I randomly place my bets in a haze trying to recall the way she looked and win three games in a row. ",
            "player|Then the blonde reappears standing right next to me.",
            "com|display_sirena_night_center",
            "spC|You really know how to play eh?",
            "spC|I have an intense feeling that the next number must be RED. Too bad I've lost all my money... do you mind if I just borrow a few of these from you?",
            "player|She points at my pile of black chips. Each of them is worth $100.",
            "spC|I just want to borrow 7 of these...",
            "spC|...and I... have collateral.",
            "com|photo-on_CasinoCleavage",
            "player|She leans over to show me a room key card sitting in her cleavage.",
            "player|Girl: Rooms are only around $300 a night but I wouldn't mind staying with you the rest of the night.",
            "player|She successfully convinced me why she could get a $700 loan with a $300 collateral...",
            "com|photo-off#com|photo-on_CasinoCard",
            "player|She slips the key card into my pocket and takes the chips in front of me. ",
            "player|I only had 6 chips<> so i borrowed one more from Sao. She places all the chips on the RED once again. ",
            "com|photo-off",
            "player|The ball jumps around the wheel... and for the first time ever I want to lose some money. It stops at number 33<> black. ",
            "spC|Come on!",
            "spC|It isn't my lucky day<> is it?",
            "spC|Hey... I don't mind you bring your friend as well...",
            "player|The girl whispers into my ear and fades into the crowd again.",
            "com|music-off_sirenaMusic#com|remove_sirena_night_center",
            "com|display_sao_casual1_center",
            "spC|Woah! That girl is a DIME!",
            "player|We played for another 15 minutes and decide to collect the collateral. ",
            "END"
        ]

    }
    private static function s006b():Array{

        return [
            "com|bg_HotelBgNight",
            "player|We found the place. We walked inside the dimly lit hotel room. The girl was waiting for us.",
            "com|photo-on_CasinoSofa",
            "player|The blonde was lying comfortably on the sofa with a cigarette in hand. ",
            "player|She had left her high heels on the floor and fully displayed her beautiful long legs. ",
            "player|Girl: Hey...",
            "player|She let out in a familiar sultry voice.",
            "player|Sao: You... y-you're that psychic chick... Little Miss S?",
            "player|Girl: My name is Sirena Lovemore<>' daughter of Primero Lovemore. ",
            "player|Sao: Primero... the Mega-playboy? The founding father of Shambala?",
            "com|photo-off#com|photo-on_CasinoPrimero#com|music-on_epicbegins",
            "player|Sirena: Yes. He's also the Blackspears General<>' the highest ranking commander of Blackspears.",
            "player|At his peak<>' my father was the No. 1 SMA Master in the World and one of the most powerful men ever lived on the planet. ",
            "player|Sao: Wait... Blackspears? I remember some red-haired asshole that said his father was a boss in Blackspears too.",
            "player|Sirena: Zack Krieg?",
            "player|Sao: Yes Zack! That stupid prick! Anyway... what is Blackspears?",
            "com|photo-off#com|photo-on_CasinoBlackspears",
            "player|Blackspears used to be a private military contracting company. During the global war on terrorism they were the secret force behind the UN peacekeeping operations.",
            "player|Blackspears had an army of SMA experts and genetically-engineered Super Soldiers.",
            "player|When the War ended about 10 years ago<>' most of the Blackspears soldiers retired here at Shambala... except Zack Krieg's father<>' Rufus Krieg.",
            "com|photo-off",
            "com|display_sirena_night_right",
            "com|display_sao_casual1_left",
            "spL|Rufus Krieg... hmmm. Now that you mention it<>' that Zack moron almost shit his pants when his huge bodyguard warned him about his father...",
            "spR|He is a man to be feared... ",
            "com|photo-on_CasinoDevil",
            "player|During the war on terrorism<>' he fought on the front lines the whole time. One battle<>' he slaughtered a whole battalion of heavily-armed terrorists single-handedly.",
            "player|No one ever found out how he did it<>' but he earned the nickname - Red-haired Devil after that victory.",
            "com|photo-off",
            "spL|Interesting...",
            "spR|After the war<>' many ex-Blackspears soldiers had problems fitting back into normal society... ",
            "spR|...so my father Primero<>' created an SMA tournament to keep the ex-soldiers busy and occupied in Shambala.",
            "com|photo-on_CasinoSSCC",
            "player|The SMA tournament is called the Super Spirit Combat Championships<>' SSCC.",
            "player|It is by far the biggest professional sport game in Shambala... like the NBA to the United States. ",
            "com|photo-off",
            "spR|However<>' Rufus Krieg was jaded by his love of real wars. ",
            "spR|When he found out that the simulated battles didn't excite him<>' he decided to leave Shambala anyways.",
            "spR|On the other hand my father and his team won the first three SSCCs. ",
            "shL|Your old man is awesome!",
            "spR|He used to be<>' I guess. ",
            "spR|Later on<>' something happened. Primero fell into depression and retired soon-after.",
            "spL|......",
            "spL|Why?",
            "spR|Family issues... I don't want to talk about that now.",
            "spL|Alrighty... sorry to hear about that.",
            "spR|Shambala's way of life carried on... until last year<>' when Rufus returned.  ",
            "com|photo-on_CasinoRufus",
            "player|Since his return<>' Rufus has gathered a new team 'Zephon' and they easily dominated the SSCC.",
            "player|He then challenged my father to fight him in the SSCC with a new rule. The winning team leader to win the SSCC championship would become the new Blackspears General in Primero's place.",
            "player|Later<>' we found out that Rufus was secretly connected to re-emerging terror groups around the World. He wanted to bring Blackspears back into the glory of war again.",
            "com|photo-off#com|music-off_epicbegins",
            "spR|Despite the SSCC<>' many former Blackspears soldiers still had troubles fitting back into normal society and formed various underground gangs.",
            "spR|Many of them were eager to jump back into War and quickly became the supporting backbone of Rufus Krieg. ",
            "spR|My father was forced to accept the challenge. However after years of depression<>' he is no longer in shape to fight Rufus.",
            "spR|We need your help.",
            "spL|What can we do? We're just two normal college students...",
            "spL|Wait... does that mean you manipulated us to Shambala on purpose?",
            "spR|Yes<>' I did. I am an expert in Astrology. The stars told me that you are the new Savior<>' or what we call<>' the AMAGI SPIRITER.",
            "spL|Sorry Ma'am<>' you've lost me... this is all sounding pretty fishy all of a sudden. Is this some kind of online scam? We're getting out of here...",
            "spL|By the way<>' I do like your perfume... but it's way... too... st-r-ong...",
            "com|remove_sao_casual1_left#com|music-on_ironic",
            "player|Sao fell to the floor abruptly mid-sentence. My vision went black soon after.",
            "spR|Perfect timing!",
            "com|bg_SkyNight",
            "player|They say beautiful girls are dangerous...",
            "player|When I regained consciousness it was in the morning. I woke in a luxury living room.",
            "com|bg_LovemoreMansionBgDay",
            "com|display_primero_center",
            "spC|Hi guys. I am Primero.",
            "player|Finally<>' we met the legendary man. He wore shades that covered his pale looking skin. He looked a lot weaker than his statue in the museum. ",
            "com|move_primero_left",
            "com|display_sao_casual1_right",
            "spR|What do you want from me? ",
            "spL|I want you to do me a big favor.",
            "spL|I want you to lead a team to join the upcoming SSCC on behalf of me and fight Rufus Krieg.",
            "spL|This is supposed to be my job<>' and I would love to take him down... ",
            "com|photo-on_MansionDepressed#com|music-off_ironic",
            "player|Well... a few years ago<>' due to some family issues<>' my wives and children left the Lovemore family one after another.",
            "player|I've been suffering from serious depressions for years.",
            "player|I've lost my powers<>' and I no longer have the ability to fight Rufus Krieg.",
            "com|photo-off",
            "spL|If Rufus succeeds as the new Blackspears General<>' he will drag Blackspears back into war causing more pain and suffering in the World.",
            "spR|Okay<>' Zack is an asshole<>' so I guess his father can be an even bigger one. But why me?",
            "spL|I believe you are the AMAGI SPIRITER.",
            "com|photo-on_MansionAmagi",
            "player|Do you believe in fate<>' destiny<>' or a divine plan from above? The future of all men is predetermined... except for Amagi Spiriters.",
            "player|Amagi Spiriters have the rare ability to rewrite futures. ",
            "player|If the World was a simulation video game<>' then you<>' would be the Main Player. The future of the World is in your hands.",
            "com|photo-off",
            "thR|......",
            "spR|Hey $$$<>' what do you think?",
            "choice|QA_qa-s006b",
            "thR|......",
            "spR|Okay! I'll do it<>' but only if you are doing this with me<>' $$$.",
            "spL|Great!",
            "shL|Humpty!",
            "player|A giant robot named Humpty slinks towards us from another room... ",
            "com|remove_sao_casual1_right",
            "com|display_mansion_right#com|music-on_robotdance",
            "spC|What do want old man? I was busy making you a 're-awr' sandwich.",
            "spL|Bring these boys the Nanotech Battle Suits.",
            "shC|Okay<>' sandwich assembly terminated.",
            "com|remove_mansion",
            "player|Humpty leaves the room and comes back in a moment.",
            "com|display_mansion_right",
            "spC|These are your Nanotech Battle Suits for the SSCC...",
            "com|photo-on_MansionBelt",
            "player|The robot hands us two black waist belts. We put the belts on unimpressed. ",
            "player|Robot Humpty: Now<>' press your index finger on the blue icon there...",
            "com|photo-off#com|photo-on_MansionSuit",
            "player|The waist belt transforms into a fully body suit instantly! Wow!",
            "player|These Battle Suits were once used in real battles by Blackspears soldiers and they can absorb a reasonable amount of SE damage...",
            "player|We modified them for the SSCC... but please wear them at all time as you can easily run into random street fights in Shambala.",
            "com|photo-off",
            "com|remove_mansion#com|display_sao_battle_right",
            "spR|Man... this look kind of weird.",
            "spR|What about this mask? ",
            "spL|The mask is meant for the Captain. I used to wear one myself.",
            "spR|Ewww... I hate wearing mask. You can wear it<>' $$$!",
            "com|photo-on_MansionMask",
            "player|I put on the mask...",
            "player|Sao: You are looking like a new super hero<>' my friend!",
            "player|Sao: You'll be the Captain<>' $$$! I hate having too many reponsibilites anyway!",
            "com|photo-off",
            "spR|And... what's this pocket for?",
            "player|Sao fiddles with a side pocket on the battle suit.",
            "com|photo-on_MansionPill",
            "player|As I said<>' the battle suits were originally designed for Blackspears soldiers to fight terrorists. ",
            "player|Originally<>' a death pill was stored in that pocket should they fall into the hand of the terrorists... ",
            "player|...our soldiers had the option to commit suicide to avoid terrorist torture.",
            "com|photo-off",
            "spL|We leave it there as a reminder to all SMA fighters in the SSCC. ",
            "spL|War is poison to all men<>' and we use SMA to stop War; not to create them.",
            "spR|I see... so what's next?",
            "spL|According to the game rules<>' we need at least five fighters<>' and ideally three extra substitute fighters to join the SSCC.",
            "spL|My old SSCC team Apollyon was completely wiped out by Rufus last year... ",
            "spL|You will need to rebuild a new team.",
            "spL|My children are all extraordinary SMA practitioners with great potential. ",
            "spL|Unfortunately<>' I was a bad father. The kids left the family one after another<>' except Sirena...",
            "spL|Please... bring them together as a team. If you can unite the Lovemore children<>' the new Apollyon will be invincible!",
            "spR|Okay... it sounds exciting... a question!",
            "spR|Mr. Lovemore<>' it's quite expensive running around in Shambala. How much of a budget do we get?",
            "player|Primero turns around and shuffles towards the balcony. ",
            "com|remove_primero_left#com|remove_sao_battle_right",
            "com|display_mansion_center",
            "shC|Zero!",
            "spC|Unfortunately<>' Mr. Lovemore is now bankrupt. Even this Mansion is now owned by the bank. ",
            "spC|They made an exception and allowed Mr. Lovemore to stay here... ",
            "spC|...but he can't sell or re-finance the property in any way.",
            "player|Nice... so these battle suits are all we get to fight the biggest terrorist boss of all time...",
            "spC|SMA requires one's Spiritual Awakening that cannot be obtained by training routines alone.",
            "spC|Gaining various life experiences are 're-awr' essential to one's Spiritual Awakening.",
            "spC|My advice to you would be to work 're-awr' hard for money! It is also a part of the training.",
            "com|music-off_robotdance",
            "END"
        ]

    }
    private static function s007():Array{

        return ["com|bg_Sky","player|The robot Humpty asked us to talk to Sirena<> our kidnapper<> before approaching the other Lovemore children. We find her at the swimming pool outside of the Mansion.",
            "com|display_sao_casual1_center","spC|Ok! Now we are supposed to gather a team of Lovemore kids to join the SSCC...",
            "spC|Let's begin with Sirena Lovemore!","com|photo-on_MansionSirena#com|music-on_sexy","player|Sirena gracefully steps out of the swimming pool looking like a swimsuit model.",
            "player|Have to admit that my heart skipped a few beats. Wearing a leapard print bikini<> water rolls down her voluptuous body as if her skin was made of silk. ",
            "player|Needless to say<> Sirena Lovemore is drop dead gorgeous.","player|Sao: Hey<> what's up Sirena? Your dad said we should work together as a team...",
            "player|Sirena: Umm<> I don't think that's necessary. You guys do your thing<> I'll do my own. ","player|We will meet up at the SSCC. That's the plan alright?",
            "player|Sao: What the... ","com|photo-off","com|move_sao_casual1_right","com|display_sirena_swimsuit1_left","spR|Your old man asked us to ask you...",
            "thL|Is this guy really the Amagi...? I don't believe so... ","spL|I always work alone; not a big fan of any team spirit.","spR|Well... at least help us convince the rest of the Lovemore children? ",
            "spL|Just warm up to them and become their 'CLOSE FRIENDS'. If they like you they will join. Deep down inside<> they love SMA... ","spL|...but I do have one warning for you. They all think Primero is an asshole<> so try not to use his name as a leverage. ",
            "spL|It'll ONLY make things harder for you.","spR|Well... as hard as you? I hope the other Lovemores are more approachable. ","spL|More tips for you. Number 1<> people like to talk to intelligent people with strong self-image!",
            "spL|Number 2<> try to find out their taste and preference before buying them something.","spR|Ok! Piece of cake!","spR|By the way...<> where can we find them? ",
            "spL|I don't know. I am not their babysitter.","spL|Try to 'LOOK AROUND' at different places. You do need a bit of luck at the beginning. ","spL|Once you become 'FRIENDS' with them<> you can always check their current locations in your 'CONTACTS' app.  ",
            "com|photo-on_MansionFamily","player|Later<> Sirena showed us a family picture of the Lovemore children. ","player|To my surprise<> I've already met all of them during our vacation!! Starting from the left hand side... ","com|photo-on_PlanePickup",
            "player|The stewardess on the first class flight<> Tomoru Lovemore.","com|photo-off#com|photo-on_ClubSalute","player|The police girl stopped our fight with Zack<> Klaire Lovemore.",
            "com|photo-off#com|photo-on_ChangingCat","player|The girl looking for her cat in the changing room<> Ceil Lovemore.","com|photo-off#com|photo-on_GardenGuitar",
            "player|The High Priestess playing guitar in the garden<> Dea Lovemore. ","com|photo-off#com|photo-on_MansionSirena","player|Well and of course... Little Miss S<> aka Sirena Lovemore!",
            "com|photo-off#com|photo-on_MuseumLenus","player|Finally<> the nerdyman at the museum<> Lenus Lovemore. ",
            "com|photo-off#com|music-off_sexy","player|Sirena mentioned that we can only recruit members once we've become close friends with them.",
            "END"]

    }
    private static function s008():Array{
        return ["com|bg_Sky#com|music-on_robotdance","player|Before we left the Lovemore Mansion yesterday<> Humpty asked us to look for Master Akira Kudo. ",
            "com|display_mansion_center","com|photo-on_AcademyIntro","player|Primero used to be the number one SMA Master in the World. Akira Kudo was actually the first student of Primero.",
            "player|Sadly<> after years of depressions<> the man can no longer fight. ","com|photo-off","spC|Akira Kudo is now the Master of the SMA Academy. Go find her! You guys need to learn some SMA asap. ",
            "spC|She is simply the best teacher in town!","com|bg_AcademyScene","com|display_sao_casual1_center","spC|Man<> the King of Street Fighters is here to learn some ass-kicking magic powers!",
            "spC|If I can use this magic thing<> Zack Krieg and his old man will be in big trouble!","com|photo-on_AcademyCeil#com|music-off_robotdance","player|Hi there!",
            "player|A cute girl in martial arts uniform is stepping into the dojo. She is wearing a white belt... probably a beginner like us.  ","player|She's the girl that was looking for her cat in the changing room<> Sirena's little sister<> Ceil Lovemore.",
            "player|She recognized me almost right away and she felt a bit shy.","player|Answer 1: Hey<> I saw your cat Tom Yum near the Garden outside of the Temple...",
            "player|Answer 2: Hi....","com|photo-off#com|move_sao_casual1_right","com|display_ceil_dojo_left","thR|Ceil Lovemore is such a cutie!","shR|Yo! Yo! Yo! I am Sao! ",
            "spL|Oh... nice to meet you<> Sao. I'm Ceil.","player|I asked if Ceil found her cat at the end.","spL|Yes! My sister found him. Thanks the Universe!","player|Her sister must be the High Priestess I met at the Garden<> Dea Lovemore.",
            "spR|How come you guys are talking about her pussy... cat all of a sudden? ","com|remove_sao_casual1_right","com|display_dan_right","shR|ATTEN-------TION!",
            "spL|Shhhh... Master Kudo is coming!","player|Ceil appears to be very nervous. ","com|remove_ceil_dojo_left#com|display_akira_left","shR|MASTER KUDO!! ",
            "spL|...these are the new students?","shR|YES MASTER!","com|remove_dan_right","com|display_sao_casual1_right","spR|Woah! Look at those awesome tattoos... what a hottie!",
            "shL|Listen up!","spL|Rule #1 of the SMA Academy<> you never quit! ","spL|If you quit<> you lose your balls... I will cut them off myself.","spR|Yes please<> hahahaha...",
            "com|swf-on_fxbam","com|photo-on_AcademyStep#com|music-on_sao","player|Akira Kudo: What is your name?","player|Sao: OOOUUUUCCCCCHHHHHHH!!","player|I can't hear you!",
            "player|SSS...AAA...OOO!","com|photo-off","shR|She stepped... on my balls... urrgghh!","spL|I am not an entertainer. If you think this is brutal and inhumane<> do me a favor and quit now.",
            "spL|The SSCC will start in Fall. I will make sure you become strong enough to compete in the tournament.","spL|DO YOU UNDERSTAND? ","shR|YES MADAM!",
            "spL|Let's begin with the basics. ","com|music-off_sao","com|photo-on_AcademyElements#com|music-on_epicbegins","player|Spirit Energy can be transformed into different elemental types - Fire<> Water<> Earth<> Air and Neutral.",
            "player|I will demonstrate these different forms of SE to you. Training bots<> come!!","com|photo-off","com|photo-on_AcademyBots",
            "player|Four dummy robots with big metal shields rush into the dojo and surrounded Akira.","player|Watch carefully! Raid like Fire! Fire focuses on all-out attack and no defense!",
            "com|photo-off#com|photo-on_AcademyFire","com|swf-on_fxzok","player|Akira releases a fiery aura and kicks rampantly onto one of the shields. ",
            "player|DANG! DANG! DANG! DANG! DANG! DANG! DANG! DANG!","player|In a matter of seconds<> Akira lands 30 hits on the shield leaving the shield riddled with serious looking dents. ",
            "player|The robot trying to withstand the pressure<> eventually falls to the floor with broken pieces.","com|photo-off#com|photo-on_AcademyWater",
            "player|Akira: Next<> Water Skills - fast and stealthy<> specially designed for assassinations.","com|swf-on_fxzok",
            "player|Akira bursts into a streak of blue light and reappears behind a robot. ","player|Before the robot realizes it<> Akira uses some kind of technique to cut off its head. ",
            "com|photo-off#com|photo-on_AcademyEarth","player|Akira: Earth SE - the hardest element. Speed is sacrificed for immense damage. For Earth Skills<> POWER becomes everything!",
            "player|A golden aura surrounds Akira... I thought she was turning into Super Akira...","com|swf-on_fxboom","player|She throws a thunderous hand chop into another shield. The impact blows away the robot slamming it into the wall. ",
            "player|The shield was bent into what looked like a mangled folding chair! ","com|photo-off#com|photo-on_AcademyAir","player|And finally<> this is what Air Skills look like.",
            "player|Akira turns green and sprints towards the last standing robot... ","com|swf-on_fxzok","player|Surprisingly<> the air punch looked weak and was very underwhelming.",
            "player|Akira: Air SE attacks aim for internal damage. It can even be considered one of the more lethal skills compared to the other SE arts. ",
            "player|But be aware<> there is a small time lag for the actual damage to be realized.",
            "player|Moments later<> sparks and smokes jolts robot and then collapses like scrap metal. If the robot was a human<> I'm sure his inner organs would be really fucked up. ",
            "com|photo-off#com|music-off_epicbegins","player|Damn! What an awe-inspiring demo! Sao and I were speechless for the first time.",
            "spL|That was about 10% of my SE. Imagine what can happen with 100% of my power...","spR|This... this is... a... A-AWESOME!","shR|Teach me! PLEASE<> MASTER KUDO!",
            "spL|I will<> but you guys are not ready. You need to learn how to release Spirit Energy first. ","spL|Ceil<> send them to your sister. Come back when you can use SE. ",
            "com|remove_akira_left","com|display_ceil_dojo_left","spL|Ok... do you know the Spirit Temple? My sister is actually the High Priestess there. ",
            "spL|She is teaching people how to release SE.","player|Dea Lovemore. Her name card is still in my pocket. We will get there first thing next morning.",
            "END"]

    }
    private static function s009():Array{

        return ["com|bg_SpiritTempleScene","player|Sao and I arrived at the Temple early in the morning. The Spirit Temple looked more like a modern University campus than a traditional temple. ","player|We were a bit late and the SE class had already started. Sao couldn't get up too early.","com|photo-on_TempleYoga#com|music-on_revival","player|The SE Class was held in a room akin to a yoga studio. Dea was guiding a class of about 15 people through basic breathing exercises.","player|She really looked like a yoga instructor. An exceptionally beautiful one. ","player|Sao: Look at her... I have a thing about flexible girls...","player|Sao and I find an empty spot to sit down with the group and join the class without much noise. When her eyes met with mine<> we smiled at each other in recognition.","player|We briefly introduced ourshelves to the class.","com|photo-off","com|display_dea_gym_center","spC|Ok everybody! I know some of you are new here. I will quickly go through the basics again.","com|photo-on_TempleLove","player|Beyond the confinement of time and space<> the Spirit of Love has existed long before the Universe that we understand.","player|The Spirit of Love radiates Spirit Energy. If we look at the Sun as Love<> then the light and heat the sun gives off would be it's Spirit Energy.","player|In modern Science<> Spirit Energy is super-high-frequency electromagnetic waves. We won't go into the details here...","com|photo-off","spC|The Spirit of Love is most profound at the Solar Plexus in the human body. We consider the solar plexus<> the Spirit Energy Generator.","player|Placing her palms in front of her solar plexus<> a mysterious white aura appears...","com|photo-on_TempleDemo","player|This... is Spirit Energy.","player|SE can be transformed into many different forms... Fire<> Water<> Air<> Earth... what I am showing to you now is the original form<> Neutral. ","player|Class<> it is now your turn to try. Place your hands in front of your solar plexus and allow your eyes to close.","player|Breathe slowly<> relax... imagine your body as it's own Solar System and the Sun lives at your solar plexus.","player|Imagine that the Sun growing and beaming stronger... feel the light energy spreading throughout your entire body...","player|While I am trying to follow Dea's instructions<> someone taps my shoulder.","com|photo-off","spC|Shhh... please come with me. I have something important to show you.","com|remove_dea_gym_center","player|I look around and everyone is trying to concentrate with their eyes closed. I follow Dea leaving the room.  ","player|We walked through a long corridor to reach a grand hall.","com|photo-on_TempleElevator","player|At the end of the hall<> a golden elevator illuminates the room. ","player|The elevator doors open and Dea motions for me to get in. ","com|photo-off#com|music-off_revival","com|display_dea_gym_center","spC|Please go on to the next level. I will meet you there in a moment.","com|remove_dea_gym_center","com|photo-on_TempleRising","player|The doors close quickly and the elevator begins to rise. There are only two buttons on the panel: Up and Down. It seems there are only two levels in the building.","player|......","player|About 1 minute passes. The elevator is still rising!","player|I didn't think the Temple was this tall!? This elevator must be moving real slow!","player|Another minute passes<> the elevator is still rising!","player|What the fuck?! This is getting a bit scary. Where am I going? What's going on? There is no signal in the elevator and I can't call anyone.","player|I am getting anxious and really wanted to get out. In panick<> I mash the two buttons and make a commotion. No one is around and the elevator won't stop!","player|After freaking out<> I calm myself down and surrender the thought of escape. Maybe I'm going to Heaven. ","player|A long time passes... maybe an hour. The elevator finally slows to a stop...","com|photo-off#com|bg_School","player|The door opens. The elevator is taking me to a... school corridor I believe...","com|display_mansion_center#com|music-on_foodchase","spC|You're late!","player|......","spC|Please select. Hammer or Sushi?","player|Huh!?","spC|Hammer or Sushi?","player|Hmm... I am not hungry...","com|swf-on_fxbam","com|bg_SpiritTempleScene#com|music-off_foodchase","com|display_dea_gym_center#com|music-on_revival","spC|Hey $$$<> are you doing alright?","player|What happened?!","spC|Congratulations! I think you have just visited the Universe of Spirit Energy.","spC|The space you visited is your very own spiritual realm. ","spC|There<> you will be able to increase your SE speedily.","spC|There are different manifestations of the spiritual reality for everyone. Some see dragons<> some see angels<> some see monsters and even unicorns... ","spC|...the spiritual realm can summon anything that the mind can imagine.","player|I guess I just got lost in my own imagination.","spC|This is amazing<> $$$... you are the first student to reach the realm on the first session. ","spC|I want to give you something...","com|photo-on_TempleCrystal","player|Dea gives me a tiny black crystal ball. ","player|This is made from a meteorite found 6000 years ago in Armenia. ","player|Please keep this near you. They said it can absorb and store the Spirit of Love... and it will bring you a lot of luck.","com|photo-off#com|music-off_revival","com|move_dea_gym_left","com|display_sao_casual1_right#com|music-on_sao","spR|Hey $$$<> I think I just slept with my favorite porn star! It feels so real!","spL|......","spL|Hmm... you guys seem to have an unusually high amount of potential...","spR|I want to get more SE! How do I get there again?","spL|From now on you can visit your realm through 'MEDITATION' here in the Temple...","spL|...but there is a limit for the amount of SE you can have. We like to call it SE Limit sometimes. ","spR|Oh... kind of like the HP or MP Max in rpg games<> right?","spL|Aha... like I said SE is coming from Spirit of Love. If you want to raise your SE Limit<> you need to love more.","spR|Love more? How?","spL|Building strong relationships with other people is a good start.","spR|I see... now I have a new pickup line. Miss<> are you interested in mutually lifting our SE Limit? ","spR|I will go talk to the ladies now<> please excuse me.","com|remove_sao_casual1_right","spL|Ahahaha... Sao<> you're funny.","com|music-off_sao","END"]

    }
    private static function s010():Array{
        return ["com|bg_AcademyScene#com|music-on_crazy","com|display_sao_dojo_center","shC|Akira! We're back!","com|move_sao_dojo_right","com|display_dan_left","shL|Quiet!","spL|My name is Dan. Master Kudo asked me to give you two a few lessons.","player|Dan is the first student of Akira Kudo. He is also among one of the most senior in the SMA Academy.","spL|Now you have some SE... but you still need some SMA skills in order to use SE properly in your fights.","spL|Pay attention. I will show you how.","player|[play battle tutorial]","spL|Do you understand? ","spR|Hhuuuuuuuuoooouuuaaaaa... can we just start fighting? ","spL|......","shL|Ceil<> I want you to fight $$$! Sao<> you'll be next!","com|remove_sao_dojo_right","com|display_ceil_dojo_right","spR|Ehh!? I don't think $$$ is ready for a SE fight...","spL|Ceil has been learning SMA for a while. But sadly<> she is still the weakest student here.","shL|Go Ceil! What're you waiting for?","shR|Yes Sir!","player|I press the blue icon on the waist band and it expands into a full nanotech battle suit.","spR|Umm... sorry $$$...","shL|Stop apologizing! Get started!","com|remove_dan_left","com|move_ceil_dojo_center","player|I desperately try to release my SE... but I still don't really understand how.","shC|Watch out! Here comes an earth punch!","com|swf-on_fxbam","player|OWWW!! Ceil punches me in the arm throwing me off my balance. MY ARM WENT NUMB!! Good thing I have the battle suit on. That attack could have crushed my arm. I awkwardly distance myself from Ceil.","spC|Sorry! Are you okay?","com|move_ceil_dojo_right","com|display_dan_left","shL|STOP apologizing! Finish the fight!","spR|Y-yes... UUUAAAHHHH!!","com|remove_dan_left#com|remove_ceil_dojo_right","player|Ceil closes her eyes and dashes towards me once again... if I don't do something now<> I may actually die!","player|Sao is the 'King of streetfighting'! He's taught me a thing or two about protecting myself in a fight. ","com|swf-on_fxzok","com|photo-on_TutorialTakedown","player|Instinctively<> I execute a double leg takedown on Ceil who was blindly charging towards me.","player|WUMP!","com|swf-on_fxbam","com|photo-off#com|photo-on_TutorialDown","player|I did it! I took Ceil to the floor! She felt soft in all the right places.","player|Sirena did mention that Ceil was her only full biological sister... the other Lovemores are half-siblings. Afterall<> Primero did have 4 wives.","player|No wonder Ceil has such a great body! Good genetics. Now I wonder what Sirena's and Ceil's mom looks like...","player|We continued to fight. Other than that surprise move<> Sao and I got owned by the girl completely. ","com|photo-off#com|music-off_crazy","player|After the first SMA lesson...","com|display_ceil_dojo_left","spL|$$$<> can you teach me how to do a double leg takedown? It's quite... interesting.","player|Answer 1: Sure! Why not?","player|Answer 2: How about a trade?","shL|Alright!","com|display_sao_dojo_right","spR|Hey guys<> the expert is here! You can't do it without me!","spR|By the way<> why don't we all go for a drink sometime and we can talk about things?","thL|......","spL|I am working this Friday Night. Do you guys want to come? ","spL|Well... I am working part-time as a waitress at my brother's pub. ","player|Her brother must be Lenus Lovemore<> the nerdyman we met at the Museum. We will meet Ceil at the Sports Bar.","spL|Okay! See you guys at the bar!","END"]
    }
    private static function s011():Array{

        return ["com|bg_SportsBarScene#com|music-on_bababa","player|We arrived at the Sports Bar. ","com|display_sao_casual1_center","shC|WOOAAH! You're hot dish<> Ceil!","com|move_sao_casual1_right","com|display_ceil_work_left","spL|It's just work uniform... so... just the two of you?","spR|Aren't you gonna join us? ","spL|Sure! After my shift is over. ","com|remove_sao_casual1_right#com|remove_ceil_work_left","player|An hour later<> Ceil joined us. ","com|display_ceil_work_right","spR|Too bad! My brother Lenus is not here today. Otherwise<> I can introduce him to you. ","com|display_sao_casual1_left","spL|Don't worry. I like this place. We'll be back.","spR|By the way... do you guys have any plan? How long are you going to stay in Shambala? ","thL|Maybe it is not the best time to tell her our mission here...","spL|Well... I think we will stay for a bit. We just fell in love with SMA.","spL|The problem is... things are expensive here. I don't think the part-time jobs can support us for a long time.  ","spL|Ceil<> what is the fastest way to make money here?","spR|Fastest way? Hmm... I do know a way...","spR|...I am just not sure if I should tell you...","spL|You know that exactly means you are going to tell us anyway<> right? Come on<> Ceil!","spR|Okay...","spR|Last week one of my sisters<> Klaire<> was here. She is a police officer. ","spR|She said they don't have enough people at the police station. After the War on Terror<> many former Blackspears soldiers are turning into gangsters...","spR|The Shambalian Police are desperately looking for more bounty hunters<> and they are giving out big cash rewards...","shR|But<> wait a sec... it's way too dangerous for you guys. Don't even think about it!","spL|Too late! Haha! Now this is my type of part-time.  ","spL|$$$<> let's send our job applications to Klaire Lovemore!","shR|Nooo! Now I regret telling you! ","com|music-off_bababa","END"]
    }
    private static function s012():Array{

        return ["com|bg_PoliceStationScene#com|music-on_klrMusic","com|display_sao_casual1_left",
            "com|display_klr_work_right","shL|Klaire<> please! We want to become bounty hunters!",
            "spR|Pff... forget it! Most of these criminals are former Blackspears soldiers...","shL|Hey! I am the AMA... ",
            "spR|Well<> any help is better than no help I guess...","spR|Fine! I will just put down your names in the list of registered bounty hunters. ",
            "spR|We have classified the criminals according to their SE levels. 'S' is the highest ranking and 'F' is the lowest. ",
            "spR|Promise me<> stay away from the high-level gangs for now! You don't stand a chance! Pick on the weakest only. ",
            "spL|Meh...","spR|The good news is: if you do encounter the powerful ones<> you can always pay a pizzo instead of fighting them. ",
            "shL|Wait a sec... how to tell if they have high or low SE levels? ","spR|It is impossible for newbies to read SE levels. It requires a lot of experience.",
            "spR|Besides<> good spiriters always know how to hide their SE levels! ","spR|We do have a Criminal Rankings Report updated each morning here at the Police Station. ",
            "spR|If you are serious about Bounty Hunting<> check it out every morning. ","player|It seems that Bounty Hunting is also an efficient way to earn money as well as get us prepared for the coming SSCC. ",
            "com|music-off_klrMusic",
            "END"]

    }
    private static function s013():Array{

        return ["com|bg_PoliceStationScene","com|display_sao_casual1_left","com|display_klr_work_right","spL|I need more challenges! Gimme a criminal at the maniac level...","spR|Alriiiight... I hope you're ready for this because this is gonna be one dark ride.","spR|Like this murder case here...","com|photo-on_FatmanBody#com|music-on_horror","player|Klaire shows us a photo of a deceased body. ","player|This morning we found a body washed-up on our shores. The victim was a 32 year old female tourist named... Jennifer Jenkins. ","player|According to customs<> she just got to Shambala a few days ago...","com|photo-off","shL|Are you sure she died in THIS century?! She looks like a MUMMY!","spR|No wounds were found on the body. But the real wierd part is... ","spR|...all the fat in her body was missing! It's as if she went through some kind of SUPER liposuction.","spL|Woah<> zero fat... she could become a billionare by selling her weight loss secrets to other women... ","spR|Jenny was travelling alone in Shambala. We are still trying to contact her family...","spL|Elementary<> my dear Watson<> I bet we can find some kind of useful information at her hotel room!","com|music-off_horror","END"]
    }
    private static function s014():Array{
        return ["com|bg_Lobby","com|display_sao_casual1_left#com|display_daz_right","spR|Jennifer Jenkins? Yes! I saw her leaving the hotel yesterday afternoon...","spR|Did something happen to her?","spL|Oh yes<> it's a long story...","spL|...any information will be greatly appreciated.","spR|Hmm... now that I think of it<> she did ask me for directions to the National Park.","END"]
    }
    private static function s015():Array{
        return ["com|bg_ParkScene","com|display_park_gal_left#com|display_park_guy_right","spR|You know what? I was making out with my girl here last night and I recorded it... ","spR|...but when I checked the video today<> I noticed something weird!","com|photo-on_FatmanMurder","player|The guy showed us a video hologram from his smart ring. It looked like a woman was struggling under a huge fat figure in the background.","player|Guy: I thought they were just having some fun in the woods if you catch my drift.","com|photo-off","shL|Ewww! This is gross! WTF? Wait a minute<> you recorded us!?","spR|Uh... I just... mmm... honey I...","player|We left the couple to continue their romantic date.","END"]
    }
    private static function s016():Array{
        return ["com|bg_PoliceStationScene#com|music-on_klrMusic","com|display_klr_work_left#com|display_sao_casual1_right","spL|Find anything?","spR|Yes<> I'm sure the suspect is a super fat dude about 500 lbs! Check out the video I got!","spL|......","spL|There aren't many 500 lb men in town. We may be able to broadcast this video and ask the public for information.","player|Shortly after<> the police broadcasted the video and named the suspect 'Fatman'.","com|music-off_klrMusic","END"]
    }
    private static function s017():Array{

        return ["com|bg_PoliceStationScene","com|display_klr_work_left#com|display_sao_casual1_right","spL|Oh crap... we found another fatless body at the solar power plant this morning. ","spL|Norman Haas<> a manager at the plant. His colleague discovered his body as he came in to work this morning.","spL|Again<> no wounds. It's the M.O. as the previous body...","spR|Maybe you should consider renaming Fatman to... Fatassman! Hahaha.","thL|......","com|photo-on_FatmanButton","player|Klaire: I do have some good news<> we found a button at the crime scene. It didn't belong to the victim<> so this may be our first real clue.","player|Sao: Fatassman must've left it! The victim probably ripped it off while fighting off Fatassman... or maybe Fatassman got so fat that buttons popped off! Hahaha!","com|photo-off","spL|Ummm<> hehehe...","shL|Just shut up<> Sao! You're annoying! This is SERIOUS!","spL|That's 2 victims with hyper fat loss... sounds... unnatural to me.","shR|Its gotta be SUPERNATURAL! Alright big moose<> let's get to the Spirit Temple! ","spR|Dea<> the priestess<> should be able to help us with these supernatural things!","END"]
    }
    private static function s018():Array{
        return ["com|bg_SpiritTempleScene#com|music-on_revival","com|display_dea_work_left#com|display_klr_work_right","spL|Fatman... it's all very odd...","spL|Now that we have a button<> I don't think it would be too hard to find the owner.","spL|If it belonged to a 500 lb man<> there aren't too many stores carrying extremely large sized clothes in town.","spR|Actually...<> there's only one custom clothing shop<> and it's at the Shopping Centre!","com|remove_klr_work_right","com|display_sao_casual1_right","shR|Right! Why didn't I think of that! Dea<> you are 'Einstein of the Lovemores'!","spL|Huh?","spR|Don't worry<> you're way prettier than Einstein. Ciao!","com|music-on_revival","END"]
    }
    private static function s019():Array{
        return ["com|bg_ShoppingCentreScene#com|music-on_epicbegins","com|display_klr_work_left#com|display_shoppingmall_right","spR|This button does look familiar... Oh! I remember now! ","spR|A few months ago<> a extra large man came in with a trench coat...","spR|We helped him resize it. We usually take pictures of the clothes to keep record... one moment please.","spL|Thanks ma'am! Take you time...","shR|This one here! The button looks exactly like these!","spR|His name is Robert J. Gordon.","com|remove_shoppingmall_right","com|display_sao_casual1_right","shR|Bingo! Case closed! Easy peasy eh Watson!","thL|......","spL|Sure there smart-ass! Dea is the REAL Sherlock! Hahaha!","com|photo-on_FatmanDecoy","player|The next day<> the Police went to the suspect's house and found the trench coat with one missing button.","player|Robert J. Gordon was arrested. ","player|I feel that something is wrong but I don't know what it is. ","com|music-off_epicbegins","END"]
    }
    private static function s020():Array{
        return ["com|bg_SpiritTempleScene#com|music-on_revival","com|display_dea_work_left#com|display_sao_casual1_right","spL|I... don't think Robert Gordon is the Fatman... we may have gotten the wrong guy.","shR|What're you talking about!?","spL|Fatman tried to get rid of the body with the first victim. ","spL|If the wind didn't change direction on the night of the murder<> we may have never found the body on the shore at all.","spL|But strangely<> after the Police broadcasted the video<> Fatman stopped trying to hide the body.","spL|He just left the second body at the crime scene for someone to discover it.","spL|As if Fatman is trying to mislead the cops...","spR|Dea! Maybe you are thinking too much?","spL|Knowing that the Police was looking for him<> the real Fatman wanted to find a scapegoat. ","spL|I think he took the button from Robert Gordon<> and planted the evidence against him.","spR|......","spL|To definitively solve this case<> we may need to find out how the Fatman took the fat out of the bodies.","spL|We need to do some research...","spR|Research... ugh...","com|music-off_revival","END"]
    }
    private static function s021():Array{
        return ["com|bg_MuseumScene","com|display_sao_casual1_center","spC|Aren't you guys hungry? I'm gonna get you guys something to eat... I'll be back!","com|remove_sao_casual1_center","player|Sao was never really a big contributor in group school projects. Klaire had to get back on duty. Dea and I are left to research on our own. ","com|photo-on_FatmanDea#com|music-on_liberty","player|Dea: $$$<> let's do it!","player|Dea is wearing glasses today. I guess she is planning to spend a long day here doing research. ","player|For some strange reasons<> I find Dea's nerdy school girl look terribly attractive. ","player|Two hours later...","com|photo-off","com|display_dea_casual1_center","spC|Where is Sao? Wasn't he supposed to come back with food hours ago?","spC|Do you think he is alright? Maybe we should give him a call...","player|Don't worry<> he's probably just frolicking around somewhere near... Sao isn't really the studious type.","spC|Well<> I guess so... by the way<> are you hungry?","player|I am fine. ","player|*stomache grumbles*","spC|Actually... I am quite hungry... hehe.","player|I laughed. We took a brief snack break and continued to research...","com|photo-on_FatmanBored","player|Dea was pretty much a robot to me... up to that point. She's intelligent<> kind<> patient<> understanding and polite.","player|Besides<> we're about the same age but she is the High Priestess at the Spirit Temple! She is TOO perfect.","player|I can't say I feel 100% comfortable when I am with her alone...","player|...but after spending these few hours doing research together<> I think she is very down to earth. Beautiful inside out. I even find myself fancying her a bit...","player|A few more hours later...","com|photo-off#com|music-off_liberty","shC|I found something!","spC|About 20 years ago<> Blackspears started creating genetically-engineered soldiers<> also known as Super Soldiers.","spC|They conducted a lot of questionable experiments during the process...","spC|...and they discovered the connection between DNA and Spirit Energy...","com|photo-on_FatmanDna#com|music-on_horror","player|Look at this report... Dr. Soham Banerjee<> the head of Blackspears Genetic Engineering.","player|Dr. Banerjee helped a patient with MDP syndrome. The patient gained the ability to create and dissolve fat cells through the manipulation of his Spirit Energy...","player|In theory<> if one can freely dissolve fat cells with Spirit Energy<> he may be able to kill someone by rapidly removing all the fat in a person's body. ","player|A human brain is composed of 60% fat too! This skill sounds very dangerous.","com|photo-off","spC|The experiment was unique to this man. They failed to reproduce the same results...","com|move_dea_casual1_left","com|display_sao_casual1_right","shR|I'm back guys! Wuddup!","spL|We are going to see Dr. Banerjee now.","spR|Who!?","com|bg_Blackspears","player|We arrived at the Blackspears Genetic Engineering Facility. ","player|It was quiet and there was no guard on duty. Something was wrong. We rushed to Dr. Banerjee's office.","player|We bust into the professor's office. ","com|swf-on_fxzok","com|display_sao_casual1_right","shR|What the HELL is going on?","com|display_dea_casual1_left","shL|Dr. Banerjee!?","com|photo-on_FatmanSoham","player|We found the professor's body lying in a pool of blood. ","player|We browse the office and find out that records were destroyed. Someone got to the professor before us and destroyed all the potential traces of the real Fatman.","com|photo-off","shR|Damn it! We're late! It must be the real Fatman.","spL|Very likely...","com|music-off_horror","END"]
    }
    private static function s022():Array{
        return ["com|bg_PoliceStationScene#com|music-on_epicbegins","com|display_klr_work_right#com|display_dea_casual1_left","spR|So Robert J. Gordon was really set up by the real Fatman... ","spR|I should probably get the papers to release the poor guy then...","shL|No<> Klaire! Please wait!","spL|We aren't sure at the moment. Besides<> if the real Fatman is still out there<>...","spL|...we wouldn't want to give him more information this time. ","spR|I see... a ploy to catch the Fatman off-guard.","com|remove_klr_work_right#com|display_sao_casual1_right","spR|But how can we find the Fatassman<> my dear Dea?","com|remove_dea_casual1_left#com|display_klr_work_left","spL|I've read the report too. The Fatman could use his special ability to create and eliminate fat cells to change his body size quickly.","spL|Through genetic enhancement<> Dr. Banerjee had greatly improved his skin elasticity to support his dramatic weight changes.","spL|In theory<> Fatman can be any guy in any size... it is just impossible to find him without any identity record! ","com|remove_klr_work_left#com|display_dea_casual1_left","spL|I know. We may need to try something unexpected. I just booked us a table at the restaurant tomorrow night.","spR|Isn't it a bit early for celebration...?","spL|It's the perfect time for celebration... for Fatman that is.","spL|If I were Fatman and found out that my scapegoat was being charged<> Dr. Banerjee and the linking identity records were also removed... ","spL|I would be celebrating!","com|remove_sao_casual1_right#com|display_klr_work_right","spR|Wait... would he still be eating when he could just create fat in his body directly?","spL|Human nature is hard to resist. In theory<> he may not need food... ","spL|...but people go fine dining mostly to enjoy taste<> company and atmosphere.","spL|I remember reading that the test subject with MDP syndrome particularily enjoyed fine dining.  ","spL|It would be hard to celebrate without something you love.","spR|Hmmm... I see.","spR|Of course! He will go for the best food experience in town...","com|music-off_epicbegins","END"]
    }
    private static function s023():Array{

        return ["com|bg_RestaurantScene#com|music-on_ironic","com|display_ceil_party_right","com|display_sao_party_left","shL|What a fancy eating place!","spR|I've heard that they just hired a new talented chef...","spL|Oh yeah? Let's see what they have on the menu... ","shL|What? $119 for a piece of meat? ","spL|Is there a finance option? Who could afford that!? Man...","com|remove_ceil_party_right","com|display_klr_party_right","spR|Sao<> remember what we're here for and stop acting like an idiot! ","spR|Fatman can change his body weight so he could be anyone...","spL|Hahaha... I'm just trying to make our time more enjoyable... ","spL|I still don't get it... how do we find the guy when we don't even know how he looks?","com|remove_klr_party_right","com|display_dea_casual1_right","spR|Shh! If you were him<> what would you be eating?  How would you eat your food?  We have to observe and find our own clues.","spL|I give up. I'll leave that to you genius people...","spL|Ceil! What's your favorite here?","com|remove_sao_party_left","com|display_waiter_left","spL|Good evening ladies and gentlemen<> do you have any question at all?","spR|Yes... I do have a rather personal question. May I?","spL|Of course!","spR|You have a nice body. Can you tell me which fitness club you go to?","spL|Haha... I... I just work out at home.","player|The Waiter looked a bit uneasy. He took our food order and left. ","com|remove_waiter_left","com|display_sao_party_left","shL|Woah!","spL|Dea! I didn't know this but you're quite a flirt!","spR|I think our waiter may be Fatman. We know he loves fine dining and would want to be around it. ","spR|I just didn't expect him to be working IN the restaurant.","spL|UUrrhhh?","spR|Look<> the waiter has a model-like body.","spL|So...?","spR|His belt is exceptionally long for his size. The last two holes of the belt were badly stretched as if they were being used frequently.","spR|Either he shares this belt with a man 3 times his size or...","com|remove_sao_party_left","com|display_klr_party_left","spL|Dea<> you are the best investigator ever!","com|bg_Alley#com|music-off_ironic","player|After dinner<> we waited in a nearby area until the end of his shift. We confront the waiter in the back alley of the restaurant. ","com|display_waiter_left#com|display_klr_party_right","spR|Sir! I am from the Shambalian Police Department.","spR|We are investigating a few recent murder cases and would like to get some information from you...","spL|Sorry... I don't have time for that.","com|remove_klr_party_right","com|display_dea_casual1_right#com|music-on_epicbegins","spR|Dr. Banerjee survived. He kept backup copies for all his experiment records... we have your DNA.","thL|What the fuck!? The professor was not dead!?","com|remove_dea_casual1_right#com|display_sao_battle_right","thR|Great job<> Dea!","shR|Show yourself! Fatassman!","com|remove_waiter_left#com|swf-on_fxzok","com|display_fatman_left","shR|What the fuck... he's one big fucking fat elephant!","com|music-off_epicbegins","shL|GGRRRRRRR! I will eat you all!","END"]

    }
    private static function s024():Array{

        return ["com|bg_Alley","player|When we were about to defeat the Fatman<> the chef of the restaurant comes out to the alley for a cigarette break. ",
            "com|display_fatman_left#com|display_restaurant_right","shR|Oh my...","shL|UUURRHHHH!","com|photo-on_FatmanHostage",
            "player|The Fatman takes her as a hostage. ","player|Fatman: Move<> and I'll break her neck like a kits kats!",
            "player|Don't you dare follow me! Gyuhahaha!","player|Sao: Damn! We can't let him get away like this!",
            "player|The girls smile.","com|photo-off#com|swf-on_fxzok","com|photo-on_FatmanHighkick",
            "player|The chef bursts into fire and smashes Fatman in the eye with a Fire Kick. ","com|swf-on_fxbam",
            "player|Fatman: Gyaaaaarrrrgggggghhhh!","player|The chef is an SMA veteran!! With just one kick she easily knocked out the Fatman!",
            "com|photo-off#com|remove_fatman_left","spR|You're fired!","com|display_sao_battle_left","shL|Who's this Super Woman?",
            "com|remove_restaurant_right","com|display_klr_battle_right","spR|She is Tian Ross. ","com|photo-on_FatmanSpears#com|music-on_epicbegins",
            "player|Tian Ross<> Akira Kudo<> Primero Lovemore<> Rufus Krieg and two other men<> were originally called the Six Spearheads of Blackspears.",
            "player|They are most powerful Generals and SMA Masters of Blackspears.","player|Tian had always had a keen interest in culinary arts. ",
            "player|After retiring from the War on Terror<> Tian practiced and perfected her cookery skills and finally became the chef of the most prestigious restaurant in Shambala.",
            "com|photo-off","com|bg_PoliceStationScene","com|display_fatman_center","player|We finally got Fatman! After a long interrogation<> he admits to his crimes as well as a few other murders in the past.  A real serial killer!",
            "player|And his motive for killing... JUSTICE. ","player|Fatman had suffered from MDP syndrome his whole life. Though he was treated normally in society<> Fatman knew that the public despised him and saw him as a defective human being.",
            "player|At least<> that was what he believed. ","player|When the Universe gave him this new ability to produce and remove fat cells<> he decided to take Justice in his own hands...",
            "com|music-off_epicbegins","END"]

    }
    private static function s025():Array{

        return ["com|bg_LobbyNight","player|Outside the Hotel Lobby I ran into that cute air stewardness<> Tomoru Lovemore. ","com|display_tomoru_work_center","spC|Hey... I am heading to Tokyo this time... so excited!","spC|How do you like it in Shambala so far? ","player|answer 1: Not bad. I've been to better places...","player|answer 2: AWESOME! I love it.","spC|Hehe...","spC|Hmm... I think I need to go... I'm getting a bit behind time. I'll see you around!","player|BBEEEEPP!","com|photo-on_FatmanZack#com|music-on_zackMusic","player|A flashy sport car just stopped right in front of us. ","player|Zack: Hey baby! Heading to the Airport? I can give you a ride.","player|Zack turned to me: Oh it's you again? Say hi to Sao for me... if he's still alive.  ","player|Tomoru: ......","player|Zack: Come on<> girl! It's not easy to catch a cab at this time.","player|Primero and Rufus used to be comrades<> so it wasn't a surprise that their children knew each other too. I still asked Tomoru just in case. ","com|photo-off","player|Do you know him? ","spC|Yeah kind of... I actually met him a few times when I was small.","com|move_tomoru_work_left","com|display_zack_casual2_right","spR|Chill! I am a gentleman. Let me help you with the luggage...","spL|......","player|Tomoru hesitated<> but finally got on the car...","shR|Sayonara<> $$$!","com|remove_tomoru_work_left#com|remove_zack_casual2_right","player|Zack stepped on the gas and the car rumbled away...","com|music-off_zackMusic","END"]
    }

    private static function s260():Array{
        return [
            "com|bg_SSCCArenaScene",
            "com|display_arena_center",
            "shC|Ladies and Gentlemen...",
            "shC|Welcome to the finals of the Super Spirit Combat Championships!!",
            "shC|Today! We will witness the best of the best SMA fighters from the tournament... ",
            "shC|...battling for the Championship<> the ulitmate glory and honor of Shambala!",
            "shC|Are you ready to get this started?",
            "shC|I can't hear you... try again!",
            "shC|Let's the final battle begins... ",
            "shC|APOLLYON versus ZEPHON!!!!",
            "END"
        ]
    }

    private static function s261():Array{
        return ["com|bg_SSCCArenaScene","com|display_rufus2_center","spC|......","spC|I am...",
            "shC|THE NEW BLACKSPEARS GENERAL!","player|Not yet...",
            "com|move_rufus2_right#com|display_simman1_left","spR|SimMan?",
            "spL|I am the last player of Team Apollyon. ","spR|Your name is not on the list.",
            "spL|It is. I registered one minute before the game started. ",
            "spL|Primero and I created the game rules together. I know the holes. ",
            "spR|......","shR|Very well! ","spR|I am indestructible!","com|photo-on_FinalsStrike",
            "com|swf-on_fxboom","player|Rufus punched SimMan in the stomach. ",
            "player|!!!!!!","player|Where is your Spirit Energy<> SimMan? ",
            "player|The simple attack almost killed SimMan on the spot. Rufus found that the man has almost no SE!",
            "com|photo-off#com|remove_simman1_left","com|move_rufus2_center",
            "shC|Are you fucking kidding me? ","player|The invincible Black Armor can stop almost all attacks from the outside<> but it also makes Rufus less alert to the environment at the same time...",
            "com|photo-on_FinalsUp","player|Rufus looks up. He finally notices a massive ball of Water SE is floating in the mid air. ",
            "player|SimMan had released all his SE from his body before stepping onto the stage... he left it in the air instead.",
            "com|swf-on_fxzok","com|photo-off#com|photo-on_FinalsSpears",
            "player|The massive amount of Spirit Energy in the air turned into 11 flying Energy Spears! ",
            "com|photo-off#com|photo-on_FinalsKill","com|swf-on_fxzok",
            "player|As if they're guided missiles<> the energy spears striked Rufus perfectly at the center of the forehead at the same time!",
            "player|The ultra-concentrated energy finally pierced through his skull completely!",
            "player|His brain was almost cut in half.","com|photo-off","com|remove_rufus2_center",
            "com|display_simman1_center","spC|......","thC|I expected that it would take all my SE to attack at EXACTLY the same spot and the same time to cut through his armor. ",
            "thC|However it is impossible to execute the plan precisely during a regular fight... ","thC|...hitting him completely off-guard is the only way. ",
            "player|SimMan had actually executed the first strike the day before the game when Rufus was healing his son Zack. It left a small wound on Rufus's forehead. ",
            "player|A very small amount of SimMan's SE was remained hidden in the wound<> and it was served as a target for the rest of his SE spears to hit at.",
            "thC|You've been warned<> Rufus!","spC|......", "player|Suddenly<> SimMan's heart stops beating for 2 seconds. Rufus stands up again!",
            "com|move_simman1_left#com|display_rufus1_right","shL|!!!!!!","spR|That was close<> SimMan! ",
            "spR|You almost got me killed. ","spL|Amazing... ","spL|Now don't tell me there is no brain tissue in your head. ",
            "spR|You did damage my brain. My old one. I just didn't tell you that I have a new brain implanted. ",
            "com|photo-on_FinalsImplant","player|Some years ago I realized that my Spirit was gone. I tried many ways to retrieve my power. One way was an artificial brain implant. ",
            "player|Inside my chest is my 2nd brain. It didn't give me the lost Spirit that I was looking for. But it did save my life this time. ",
            "player|Unless you can destroy this one inside the chest as well... ","com|photo-off",
            "spR|SimMan<> you are like the knife behind my back. You leave me no choice. ","shR|À la prochaine!",
            "com|swf-on_fxbam","player|Rufus knocked SimMan out again. ","com|remove_simman1_left",
            "spR|SimMan<> Primero<> and these kids as well... I don't care if they are the real Amagi...",
            "spR|None of you will want to celebrate the revival of Blackspears anyway. ",
            "com|display_zack_battle_left","shL|Wait! Father!","spL|You don't have to kill them! They are just stupid kids...",
            "spR|Zack<> you are a disgrace to the Kriegs. Step aside or I will kill you first.","spL|......",
            "shL|No! I can't let you kill them. ","shL|You're going crazy<> old man! ","com|swf-on_fxbam",
            "player|Rufus knocked down Zack as well!","com|remove_zack_battle_left#com|move_rufus1_center","spC|What a shame!",
            "player|On the other side of the stage<> $$$ is struggling to get up again...","player|(......)",
            "player|(I am wondering if @@@ is doing alright.)","player|(Even the Master SimMan can't stop Rufus.)",
            "player|(It's hopeless...)","player|(Wait! I can't give up. Rufus can kill me. But not @@@!)",
            "player|(I won't let it happen!)","player|(I still have one last shot - À la prochaine!)",
            "player|(I don't think I have enough SE to use the forbidden skill... but... I have to make it happen no matter what!)",
            "END"]
    }
    public static function s262():Array{

        return [
            "com|bg_SSCCArenaScene",
            "com|display_@@@_battle_center",
            "spC|$$$... let me help... use my energy too. ",
            "player|No<> @@@! You know the consequence... both of us will lose the Spirit of Love! ",
            "player|I can do this by myself! Just let me try again! ",
            "spC|......",
            "spC|It is the same.",
            "spC|If you can never feel love again...<>",
            "thC|I don't need love in a World without yours. ",
            "END"
        ]

    }
    public static function s270():Array{

        return ["com|bg_Sky","player|That day<> Rufus was finally defeated by the forbidden skill À la prochaine. ","player|Our Spirit of Love absorbed all his Dark Energy and disappeared together in the thin air.",
            "player|The Apollyon won the SSCC Championship.","player|Sao and SimMan were sent to the Hospital.","player|Primero was also released. ","player|A few weeks later...",
            "com|bg_PierScene","com|display_@@@_twin_center","spC|......","player|Will you ever come back to Shambala? ","spC|Hm... I don't think so. ","player|Well... I wish you all the best<> as always.",
            "spC|Same here.","player|Give me a call or something...","spC|Nah... we had an agreement<> remember? We just split up and that's it.","spC|Forget everything in the past! That way we can both start a new life<> ok?",
            "player|Okay...","spC|All the best<> $$$.","shC|Time to go! Goodbye!","com|twin-photo-on_Bye@@@","player|(So... that was the last time I saw @@@.)",
            "player|(After losing our Spirit of Love<> both of us cannot feel or experience Love again.)","player|(The feeling is weird. All our memories are intact. We can still remember every little thing happened between us in the past year.)",
            "player|(We just don't feel 'it' anymore.) ","player|(At the end @@@ decided to start fresh somewhere... we honestly thought it was a good idea.)","com|twin-photo-off",
            "player|Another few weeks later<> Sao is fully recovered. He shielded us from Rufus's attack when we were casting the forbidden skill. ","player|SimMan is still in a coma however. ","com|bg_GardenScene",
            "com|display_sao_casual1_center","spC|So you just let @@@ go? ","player|Yeah... what can I do? ","spC|You should at least ask for a phone number or something. ","player|You don't understand the feeling. ",
            "spC|I don't.","spC|So... are you doing alright<> buddy?","player|(I honestly don't know. I am no longer interest in anything. I feel like a walking dead.) ",
            "spC|Well! Just don't give up buddy. I am always on your side... except that one time... haha!","spC|Anyway<> what's your plan now? ","player|I just want to spend some time alone. ",
            "spC|Okay! I will be sticking around. Just let me know!","com|remove_sao_casual1_center","player|Suddenly I want to visit that place again. ","com|bg_SkyNight","com|photo-on_DancePool#com|music-on_precioustime",
            "player|I am not sure why I am here. ","player|Staring at the statue in the fountain<> I feel hopeful somehow.","player|My hand unconsciously reached into the side pocket of my battlesuit waist band. I found something.",
            "com|photo-off#com|photo-on_EndingNecklace","player|Why the black crystal necklace is in my pocket?","player|It looks dark and dull. The Spirit of Love inside is gone. ","com|photo-off","com|display_mia_center","spC|You are lucky<> $$$...",
            "player|Mia? What do you mean? ","spC|You really have no clue...","spC|Do you know why the necklace is in your pocket? ","player|How... wait. Can you read my mind?","spC|That's one of my abilities. Yes. I do can read minds from some people.",
            "spC|To be exact<> when you're thinking your brain is sending out electromagnetic waves and I can interpret them.","spC|We can talk about that later. I think you need to know something about @@@.","com|photo-on_MiaAngel",
            "player|That day<> before you two combined your SE to use the forbidden skill À la prochaine in the final SSCC battle... ","player|Knowing that both of you would lose the Spirit of Love forever<> @@@ had made a decision on the spot. ",
            "com|photo-off#com|photo-on_LoveNecklace","player|At that time the black crystal was filled with the Spirit of Love from both of you.  ","player|@@@ ripped the pendant off and slipped it into your pocket<> when you were hugging each other. ","com|photo-off",
            "spC|After the battle<> both of your had lost your spirits and became 'empty'.","spC|And you absorbed that super tiny portion of your Spirit of Love stored in the pendant!","spC|It seems that<> like a seed<> it is starting to grow inside you<> so that you can at least feel a bit of hope again. ",
            "spC|It is a miracle indeed...","player|......","spC|@@@ chose to give the necklace to you so that you can have a chance to experience LOVE again. ","player|@@@... why? It was your necklace! I gave it to you!","player|Why didn't you tell me your plan? ",
            "spC|@@@ can never feel love again. You two can never fall in love again anyway. ","spC|@@@ actually wants you to forget and move forward<> so that you will have another chance to be in love with someone else.",
            "spC|I shouldn't have told you this. But it's so sad and I just can't help it.","player|Do you know where is @@@? Can you help me to find @@@?","spC|Unfortunately no. To tell you the truth<> I can only read from a source half a mile away at best. ",
            "spC|Well... that's all I can tell you. Enjoy your evening! ","com|remove_mia_center","player|After that night I asked everyone<> but @@@ didn't leave any contact at all. ","player|Now I know the whole story. Logically<> I am supposed to go crazy and travel around the World to look for my lover or something. ",
            "player|But to be frank<> I still don't have too much feelings. The Spirit of Love is growing inside me... but very slowly I guess. ","player|I also got some updates from the boys and girls.",
            "com|end-photo-on_Ceil","player|Ceil went out with Dan at the SMA Academy at the end. ","player|They opened up a new pet store in the downtown area. ","com|end-photo-on_Sirena","player|Sirena continued her psychic business at the SimMan's House. ",
            "player|She had quite a few boyfriends.","com|end-photo-on_Dea","player|Dea wanted to have more exotic experiences. ","player|She left the Temple and she planned to spend 2 years travelling aboard.","com|end-photo-on_Klaire",
            "player|Klaire got a promotion and she became the Chief of Police!","player|It was her dream and she continued to kick asses in Shambala. ","com|end-photo-on_Tomoru","player|Tomoru joined a girl band. The girl can dance and she became quite popular. ",
            "player|I even saw her live performance a couple times at the Arena!","com|end-photo-on_Lenus","player|Lenus went into filming. His first film was a big hit on the island.","player|He even won the best director award that year. ","com|end-photo-on_Zack",
            "player|Zack took over his father's business and became the new King of the Underworld. ","player|Bad boy<> bad boy<> boys will be boys.","com|photo-on_Rufus","player|Rufus lost both his Spirit of Love and his Dark Energy. He became completely powerless but it also gave him peace. ",
            "player|He became a guardian at the Temple and he continued to practice 'normal' martial arts with the other guardians. ","com|photo-on_Sao","player|Now that I've lost pretty much all SE<> Sao became the new Captain of Apollyon. ","player|He is busy recruiting new members for the next SSCC.",
            "player|And finally<> SimMan wakes up from his long coma. ",
            "com|photo-off",

            "com|bg_Sewage","com|display_keir_right","spR|Why did you tell $$$<> my dear?","spR|We can just kill them. ",
            "com|display_mia_left","spL|Psst. Killing the Amagi won't make a damn difference. ",
            "spL|They defeated Lucifer. They killed Jesus. ","spL|But the MORNING STAR will keep coming back. ",
            "spL|We want to keep the Amagi forever in the dark instead. ","spR|So what do we do now?","spL|We'll wait. ",
            "spR|Fine! Just wake me up when you need to kill again.","com|bg_Blackspears",
            "player|I arrived at the Blackspears secret HQ. ","com|display_primero1_center",
            "spC|I've given SimMan an update about your situation. ","spC|SimMan thinks he may be able to help.",
            "com|move_primero1_right","com|display_simman_left","spL|I don't want either of you turning into another Rufus Krieg. ",
            "spL|After all<> I created À la prochaine and it led to all these troubles. ","spL|I will try my best to fix it.",
            "spL|Pack your stuff. We will go search for the lost Spirit<> for you and @@@.","player|Where are we going?",
            "spL|Pamir Mountains - the Roof of the World. ","com|photo-on_Simman","player|According to SimMan<> Pamir was once the home of the oldest Ancient Deities<> aka Heaven. ",
            "player|They first discovered Spirit Energy there over 5000 years ago. ","player|Wait for me @@@...  ",
            "player|We will find a way to love again. No matter how hard it is. I promise. ",
            "END"]

    }
    public static function s9999():Array{
        //simple Game Over
        return [
            "com|bg_Sky#com|music-on_horror",
            "player|Our mission failed.",
            "player|At the end<> Rufus and his team Zephon won the SSCC.",
            "com|photo-on_BadEnding",
            "player|Rufus Krieg became the new Blackspears General. ",
            "player|Both SimMan and Primero were killed. Our team and other anti-war Blackspears members were sent to the concentration camp.",
            "player|A year later<> Blackspears attacked Moscow<> Russia<> the last communist state in the World.",
            "player|Washington<> D.C. was accused of orchestrating the attack behind the scene. ",
            "player|Russia gave up its permanent membership in the United Nations Security Council the next year and invaded Georgia<> Turkey and Ukraine.",
            "player|Finally<> the stage was set for the World War III.",
            "player|GAME OVER",
            "END"
        ]
    }
}
}
