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
        "s026":s026(),"s027":s027(),"s028":s028(),"s029":s029(),"s030":s030(),
        "s031":s031(),"s032":s032(),"s033":s033(),"s034":s034(),"s035":s035(),
        "s036":s036(),"s037":s037(),"s038":s038(),"s039":s039(),"s040":s040(),
        "s041":s041(),"s042":s042(),"s042b":s042b(),"s043":s043(),"s044":s044(),"s045":s045(),
        "s046":s046(),"s046b":s046b(),
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
            "spC|...the one that my mom Annabeth gave me before she passed away. I think I dropped it somewhere in the last couple days. ",
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
            "player|She is quite special to say the least. Who would still be playing an acoustic guitar these days? ",
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
            "player|At the end<> Sao found the necklace given to him by his mom Annabeth. It was lost under the sofa cushion in the hotel room the whole time!",
            "player|He must have been too drunk last night and lost it sleeping on the sofa. ",
            "com|display_sao_casual1_center",
            "spC|Phew! Thanks the Universe. I thought I've lost it!",
            "com|photo-on_GardenNecklace",
            "player|The necklace is important to him. Sao's dad died when he was still a baby. His dad gave this pendant to his mom Annabeth. ",
            "player|A few years ago Annabeth passed away too and gave it to Sao. ",
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
            "player|Have to admit that my heart skipped a few beats. Wearing a leopard print bikini<> water rolls down her voluptuous body as if her skin was made of silk. ",
            "player|Needless to say<> Sirena Lovemore is drop dead gorgeous.","player|Sao: Hey<> what's up Sirena? Your dad said we should work together as a team...",
            "player|Sirena: Umm<> I don't think that's necessary. You guys do your thing<> I'll do my own. ","player|We will meet up at the SSCC. That's the plan alright?",
            "player|Sao: What the... ","com|photo-off","com|move_sao_casual1_right","com|display_sirena_swimsuit1_left","spR|Your old man asked us to ask you...",
            "thL|Is this guy really the Amagi...? I don't believe so... ","spL|I always work alone; not a big fan of any team spirit.","spR|Well... at least help us convince the rest of the Lovemore children? ",
            "spL|Just warm up to them and become their 'CLOSE FRIENDS'. If they like you they will join. Deep down inside<> they love SMA... ","spL|...but I do have one warning for you. They all think Primero is an asshole<> so try not to use his name as a leverage. ",
            "spL|It'll ONLY make things harder for you.","spR|Well... as hard as you? I hope the other Lovemores are more approachable. ","spL|More tips for you. Number 1<> people like to talk to intelligent people with strong self-image!",
            "spL|Number 2<> try to find out their taste and preference before buying them something.","spR|Ok! Piece of cake!","spR|By the way...<> where can we find them? ",
            "spL|I don't know. I am not their babysitter.","spL|Try to 'LOOK AROUND' at different places. You do need a bit of luck at the beginning. ","spL|Once you become 'FRIENDS' with them<> you can always check their current locations in your 'CONTACTS' app.  ",
            "com|photo-on_MansionFamily","player|Later<> Sirena showed us a family picture of the Lovemore children. ","player|To my surprise<> I've already met all of them during our vacation!! Starting from the left hand side... ","com|photo-off#com|photo-on_PlanePickup",
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
            "com|swf-on_fxbam","com|photo-on_AcademyStep#com|music-on_saoMusic","player|Akira Kudo: What is your name?","player|Sao: OOOUUUUCCCCCHHHHHHH!!","player|I can't hear you!",
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

        return ["com|bg_SpiritTempleScene","player|Sao and I arrived at the Temple early in the morning. The Spirit Temple looked more like a modern University campus than a traditional temple. ","player|We were a bit late and the SE class had already started. Sao couldn't get up too early.","com|photo-on_TempleYoga#com|music-on_revival","player|The SE Class was held in a room akin to a yoga studio. Dea was guiding a class of about 15 people through basic breathing exercises.","player|She really looked like a yoga instructor. An exceptionally beautiful one. ","player|Sao: Look at her... I have a thing about flexible girls...","player|Sao and I find an empty spot to sit down with the group and join the class without much noise. When her eyes met with mine<> we smiled at each other in recognition.","player|We briefly introduced ourshelves to the class.","com|photo-off","com|display_dea_gym_center","spC|Ok everybody! I know some of you are new here. I will quickly go through the basics again.","com|photo-on_TempleLove","player|Beyond the confinement of time and space<> the Spirit of Love has existed long before the Universe that we understand.","player|The Spirit of Love radiates Spirit Energy. If we look at the Sun as Love<> then the light and heat the sun gives off would be it's Spirit Energy.","player|In modern Science<> Spirit Energy is super-high-frequency electromagnetic waves. We won't go into the details here...","com|photo-off","spC|The Spirit of Love is most profound at the Solar Plexus in the human body. We consider the solar plexus<> the Spirit Energy Generator.","player|Placing her palms in front of her solar plexus<> a mysterious white aura appears...","com|photo-on_TempleDemo","player|This... is Spirit Energy.","player|SE can be transformed into many different forms... Fire<> Water<> Air<> Earth... what I am showing to you now is the original form<> Neutral. ","player|Class<> it is now your turn to try. Place your hands in front of your solar plexus and allow your eyes to close.","player|Breathe slowly<> relax... imagine your body as it's own Solar System and the Sun lives at your solar plexus.","player|Imagine that the Sun growing and beaming stronger... feel the light energy spreading throughout your entire body...","player|While I am trying to follow Dea's instructions<> someone taps my shoulder.","com|photo-off","spC|Shhh... please come with me. I have something important to show you.","com|remove_dea_gym_center","player|I look around and everyone is trying to concentrate with their eyes closed. I follow Dea leaving the room.  ","player|We walked through a long corridor to reach a grand hall.","com|photo-on_TempleElevator","player|At the end of the hall<> a golden elevator illuminates the room. ","player|The elevator doors open and Dea motions for me to get in. ","com|photo-off#com|music-off_revival","com|display_dea_gym_center","spC|Please go on to the next level. I will meet you there in a moment.","com|remove_dea_gym_center","com|photo-on_TempleRising","player|The doors close quickly and the elevator begins to rise. There are only two buttons on the panel: Up and Down. It seems there are only two levels in the building.","player|......","player|About 1 minute passes. The elevator is still rising!","player|I didn't think the Temple was this tall!? This elevator must be moving real slow!","player|Another minute passes<> the elevator is still rising!","player|What the fuck?! This is getting a bit scary. Where am I going? What's going on? There is no signal in the elevator and I can't call anyone.","player|I am getting anxious and really wanted to get out. In panick<> I mash the two buttons and make a commotion. No one is around and the elevator won't stop!","player|After freaking out<> I calm myself down and surrender the thought of escape. Maybe I'm going to Heaven. ","player|A long time passes... maybe an hour. The elevator finally slows to a stop...","com|photo-off#com|bg_School","player|The door opens. The elevator is taking me to a... school corridor I believe...","com|display_mansion_center#com|music-on_foodchase","spC|You're late!","player|......","spC|Please select. Hammer or Sushi?","player|Huh!?","spC|Hammer or Sushi?","player|Hmm... I am not hungry...","com|swf-on_fxbam","com|bg_SpiritTempleScene#com|music-off_foodchase","com|display_dea_gym_center#com|music-on_revival","spC|Hey $$$<> are you doing alright?","player|What happened?!","spC|Congratulations! I think you have just visited the Universe of Spirit Energy.","spC|The space you visited is your very own spiritual realm. ","spC|There<> you will be able to increase your SE speedily.","spC|There are different manifestations of the spiritual reality for everyone. Some see dragons<> some see angels<> some see monsters and even unicorns... ","spC|...the spiritual realm can summon anything that the mind can imagine.","player|I guess I just got lost in my own imagination.","spC|This is amazing<> $$$... you are the first student to reach the realm on the first session. ","spC|I want to give you something...","com|photo-on_TempleCrystal","player|Dea gives me a tiny black crystal ball. ","player|This is made from a meteorite found 6000 years ago in Armenia. ","player|Please keep this near you. They said it can absorb and store the Spirit of Love... and it will bring you a lot of luck.","com|photo-off#com|music-off_revival","com|move_dea_gym_left","com|display_sao_casual1_right#com|music-on_saoMusic","spR|Hey $$$<> I think I just slept with my favorite porn star! It feels so real!","spL|......","spL|Hmm... you guys seem to have an unusually high amount of potential...","spR|I want to get more SE! How do I get there again?","spL|From now on you can visit your realm through 'MEDITATION' here in the Temple...","spL|...but there is a limit for the amount of SE you can have. We like to call it SE Limit sometimes. ","spR|Oh... kind of like the HP or MP Max in rpg games<> right?","spL|Aha... like I said SE is coming from Spirit of Love. If you want to raise your SE Limit<> you need to love more.","spR|Love more? How?","spL|Building strong relationships with other people is a good start.","spR|I see... now I have a new pickup line. Miss<> are you interested in mutually lifting our SE Limit? ","spR|I will go talk to the ladies now<> please excuse me.","com|remove_sao_casual1_right","spL|Ahahaha... Sao<> you're funny.","com|music-off_sao","END"]

    }
    private static function s010():Array{
        return ["com|bg_AcademyScene#com|music-on_crazy","com|display_sao_dojo_center","shC|Akira! We're back!","com|move_sao_dojo_right","com|display_dan_left","shL|Quiet!","spL|My name is Dan. Master Kudo asked me to give you two a few lessons.","player|Dan is the first student of Akira Kudo. He is also among one of the most senior in the SMA Academy.","spL|Now you have some SE... but you still need some SMA skills in order to use SE properly in your fights.","spL|Pay attention. I will show you how.","player|[play battle tutorial]","spL|Do you understand? ","spR|Hhuuuuuuuuoooouuuaaaaa... can we just start fighting? ","spL|......","shL|Ceil<> I want you to fight $$$! Sao<> you'll be next!","com|remove_sao_dojo_right","com|display_ceil_dojo_right","spR|Ehh!? I don't think $$$ is ready for a SE fight...","spL|Ceil has been learning SMA for a while. But sadly<> she is still the weakest student here.","shL|Go Ceil! What're you waiting for?","shR|Yes Sir!","player|I press the blue icon on the waist band and it expands into a full nanotech battle suit.","spR|Umm... sorry $$$...","shL|Stop apologizing! Get started!","com|remove_dan_left","com|move_ceil_dojo_center","player|I desperately try to release my SE... but I still don't really understand how.","shC|Watch out! Here comes an earth punch!","com|swf-on_fxbam","player|OWWW!! Ceil punches me in the arm throwing me off my balance. MY ARM WENT NUMB!! Good thing I have the battle suit on. That attack could have crushed my arm. I awkwardly distance myself from Ceil.","spC|Sorry! Are you okay?","com|move_ceil_dojo_right","com|display_dan_left","shL|STOP apologizing! Finish the fight!","spR|Y-yes... UUUAAAHHHH!!","com|remove_dan_left#com|remove_ceil_dojo_right","player|Ceil closes her eyes and dashes towards me once again... if I don't do something now<> I may actually die!","player|Sao is the 'King of streetfighting'! He's taught me a thing or two about protecting myself in a fight. ","com|swf-on_fxzok","com|photo-on_TutorialTakedown","player|Instinctively<> I execute a double leg takedown on Ceil who was blindly charging towards me.","player|WUMP!","com|swf-on_fxbam","com|photo-off#com|photo-on_TutorialDown","player|I did it! I took Ceil to the floor! She felt soft in all the right places.","player|Sirena did mention that Ceil was her only full biological sister... the other Lovemores are half-siblings. Afterall<> Primero did have 4 wives.","player|No wonder Ceil has such a great body! Good genetics. Now I wonder what Sirena's and Ceil's mom looks like...","player|We continued to fight. Other than that surprise move<> Sao and I got owned by the girl completely. ","com|photo-off#com|music-off_crazy","player|After the first SMA lesson...","com|display_ceil_dojo_left","spL|$$$<> can you teach me how to do a double leg takedown? It's quite... interesting.","player|Answer 1: Sure! Why not?","player|Answer 2: How about a trade?","shL|Alright!","com|display_sao_dojo_right","spR|Hey guys<> the expert is here! You can't do it without me!","spR|By the way<> why don't we all go for a drink sometime and we can talk about things?","thL|......","spL|I am working this Friday Night. Do you guys want to come? ","spL|Well... I am working part-time as a waitress at my brother's pub. ","player|Her brother must be Lenus Lovemore<> the nerdyman we met at the Museum. We will meet Ceil at the Sports Bar.","spL|Okay! See you guys at the bar!","END"];
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
        return ["com|bg_SpiritTempleScene#com|music-on_revival","com|display_dea_work_left#com|display_klr_work_right","spL|Fatman... it's all very odd...","spL|Now that we have a button<> I don't think it would be too hard to find the owner.","spL|If it belonged to a 500 lb man<> there aren't too many stores carrying extremely large sized clothes in town.","spR|Actually...<> there's only one custom clothing shop<> and it's at the Shopping Centre!","com|remove_klr_work_right","com|display_sao_casual1_right","shR|Right! Why didn't I think of that! Dea<> you are 'Einstein of the Lovemores'!","spL|Huh?","spR|Don't worry<> you're way prettier than Einstein. Ciao!","com|music-off","END"]
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
    private static function s026():Array{

        return ["com|bg_MuseumScene#com|music-on_liberty","player|This morning we got a call from Klaire again. ","com|display_sao_casual1_left#com|display_klr_work_right","spL|What's going on here<> Klaire?","spR|The Museum's staff came in this morning and found out that Primero's statue was gone!","spL|The mega-playboy must have some serious crazy fans<> haha.","spR|Guys<> let's take a walk.","com|bg_Sky#com|music-off_liberty","com|photo-on_HawkFence","player|The Museum is fenced 360 degrees with only one gate at the main entrance. The gatekeeper said he didn't see anything suspicious last night. ","player|We also checked the security camera; no one went in or out after the Museum was closed.","player|The fence is 40 ft tall. Each bar is 1 ft apart from one another. No damage can be found nowhere.","com|photo-off","com|display_sao_casual1_left","spL|So the statue just disappeared? I remember it is huge like 8ft tall?","com|display_klr_work_right","spR|8.53ft without the base to be exact. 138lbs of bronze. ","spR|It is impossible to remove the statue from the Museum without breaking the fence or going through the main gate. ","spR|Even a SMA Master cannot jump over 40ft high with a bronze statue. ","spL|I must say Shambala has better magic shows than Vegas.","player|Klaire picked up a phone call.","spR|......","spR|Guys<> we found the statue!","spR|It is on the Private Island. ","END"];

    }
    private static function s027():Array{

        return ["com|bg_PrivateIslandScene#com|music-on_horror","com|photo-on_HawkStatue","player|They found the statue on a small island about 7 km away from the Museum. We asked Dea to join as well. ","player|The statue is facing the ocean with some kind of red paint running from his eyes down his face<> as if Primero is crying in tears of blood. ","player|The first thing comes to my mind is - the weeping statue of Virgin Mary.","com|photo-off","com|display_klr_work_right#com|display_dea_casual2_left","spL|This is creepy... I don't like it.","spL|Whoever did this is not a big fan of our father. We can start the investigation with his enemies.","spR|Our old man has quite a few enemies for sure!","spR|Like the Krieg family... but I don't think Zack will do something like this. He is too busy with girls.","spL|How about Shinichi Shimizu?","spR|Possible. They said Primero took his right eye in a fight.","com|remove_dea_casual2_left","com|display_sao_casual1_left","spL|Wait girls... do you mind keeping me in the chat group?","spR|Remember the chef? Tian Ross and the Six Spearheads of Blackspears? Shinichi Shimizu is one of the six too.","spR|From what I've heard... Shinichi got into a fight with Primero about 20 years ago.","spR|Shinichi lost his right eye. Every member of Blackspears knows they are not the best friends.","spR|After the end of War<> Shinichi formed his own gang here in Shambala called 'The Black Yakuza'.","spL|Cool! ","spR|Let's split up this time! Dea and Sao will follow Zack Krieg. $$$ and I will handle the Yakuza Boss. How's that sound?","shL|Yes Madam!","shL|I wish Zack was the guy though. I can't wait to put him in jail!","com|music-off_horror","END"];
    }

    private static function s028():Array{

        return ["com|bg_BlackMarketScene","player|According to Klaire's informant<> Shinichi is dining at this hot pot restaurant he owned tonight.",
            "player|The restaurant is closed for the public. We saw a few gangsters entering the restaurant<> however.",
            "com|display_klr_work_center","spC|Members only...","spC|Let's sneak in from the back door...",
            "player|The back door was knocked. Klaire placed her palm on the door lock. A green aura appeared and I heard some light metal clanking sounds... ",
            "player|The lock is broken!","com|bg_Kitchen","player|We broke into the kitchen. We carefully approach the kitchen door; there are two glasses panels on the door so that we can see outside...",
            "com|bg_Hotpot#com|music-on_gangster","player|There are around 50 tough looking men sitting in the restaurant. ",
            "com|display_shinichi_center","player|One man in black suit is sitting alone at a big round table in the middle. He must be the gang boss. ",
            "player|Klaire: That guy with greyish white hair... he's Shinichi. It seems that he is expecting some guests.",
            "com|bg_BlackMarketScene","player|Meanwhile<> a limo arrived and parked in front of the restaurant. ","com|photo-on_HawkSirena",
            "player|The passenger door opens and a gorgeous babe steps out of the limo. ","player|She is Sirena Lovemore!","player|While she is stepping out<> the other passenger in the car slaps her butt from behind. He is a dark-skinned man with blue hair.  ",
            "player|Blue-haired man: Hurry up<> bitch! Our friend is waiting...","player|Sirena turns around and mildly complains...","com|photo-off","com|display_sirena_casual1_center","spC|Hey... stop doing that...",
            "com|move_sirena_casual1_right","com|display_vodka_left","spL|Don't be mad<> baby. I'll make it up to you tonight...",
            "player|The couple entered the hot pot restaurant. ","com|remove_vodka_left#com|remove_sirena_casual1_right","com|bg_Kitchen","com|display_klr_work_center",
            "spC|Gosh! My sister Sirena and... Vodka!?","spC|That guy is Vodka. He was also one of the Six Spearheads of Blackspears. ",
            "spC|He is now the head of another powerful gang - the Shambalian Mafia.","player|The Black Yakuza and the Shambalian Mafia are the two biggest underground gangs here in Shambala.",
            "spC|Hmmm... two big mob bosses are meeting here tonight. What's the occassion<> I wonder...","spC|By the way<> this Vodka has some balls... the Black Yakuza has around 50 people here<> and he came alone...",
            "com|bg_Hotpot","com|display_vodka_left#com|display_shinichi_right","spL|Yoyoyo! Sorry for the wait. My girl needed some time to find a nice dress. I hope you don't mind<> lone wolf!",
            "spR|Ahem...","com|photo-on_HawkCouple","player|Vodka came to the big round table in the middle to join Shinichi. He pulled Sirena in his arms and let her sit on his laps.",
            "player|Vodka rubs himself against her fine ass and sniffs the sweet scent of her long blonde hair. ","player|Meanwhile<> his hand is moving up and down her long and beautiful legs.","com|photo-off",
            "spL|Let's talk about business<> Shinichi! I am not a big fan of hot pot.","spR|Fine...","com|photo-on_HawkSword","player|Shinichi: My katana 'Blood Moon' was stolen a few days ago. Do you know anything about it?",
            "player|Manufactured by the latest Nanotechnology<> Blood Moon is known as the deadliest blade of all time! ","com|photo-off",
            "com|photo-on_HawkShinichi","player|Shinichi used his Blood Moon to claim over a thousand lives during the War on Terror. ",
            "player|The katana is more than just a weapon to Shinichi; it is his soulmate. ","com|photo-off","shL|Wait a second... do you think I am involved?",
            "spR|I was just asking.","shL|Bullshit<> you one-eyed muthafuka! I am a real man and I don't play fruit ninja!","player|Irritated by Vodka's disrepectful comments to their leader<> all Shinichi's henchmen stand up and surround Vodka. ",
            "shL|Now what!?","thR|......","player|Shinichi waves his hand to send his men back to their tables. ","spR|Fair enough<> my old friend... if you happen to hear anything about the katana<> give me a shout?",
            "shL|You bet!","player|Vodka gives Sirena a quick kiss.","spL|Well<> is that all you want from me? I feel like going to a more romantic dining place with my sweet girl...","spL|I don't really enjoy the atmosphere here...",
            "player|Vodka and Sirena left the table and they walked to the main entrance. It was blocked by a security gate.","com|swf-on_fxboom",
            "com|photo-on_HawkSlam","player|Vodka slams hard on the security gate with a powerful hand chop!","player|The gate is cut into two halves immediately<> but the destruction doesn't end there. ",
            "player|Vodka's energy continues to wreak hovac leaving a deep crack on the concrete road outside the restaurant. ","com|photo-off","shL|I've told you! I have no need for weapon! I AM THE WEAPON!",
            "com|remove_vodka_left#com|music-off_gangster","player|No one dares to say anything. The henchmen just look at their boss Shinichi<> who has absolutely no emotion in his face. ","com|remove_shinichi_right#com|bg_Kitchen",
            "com|display_klr_work_center","spC|My Universe... I still can't believe Sirena is dating the Mafia boss...","spC|No wonder he was one of the Six Spearheads. I feel that his Spirit Energy may be on a par with Primero's at his peak...",
            "com|swf-on_fxboom","player|The kitchen's wall collapsed all of a sudden!","com|photo-on_HawkUncover#com|music-on_Mayhem",
            "player|Shinichi: This is a private party and you are not invited<> Madam.","player|Shinichi used his water spear to cut out a big hole in the wall. ","player|Klaire: !!!!!!",
            "player|Klaire: Shinichi! What're you guys doing here?","player|Shinichi: What're YOU two doing here? Like I said we are having a private party<> and there's no excuse for trespassing...",
            "player|Just imagine there is an accident in the kitchen and both of you die tonight... I am sure no one here can see or hear anything<> officer.","com|photo-off","com|move_klr_work_right#com|display_shinichi_left","shR|How dare you threatening a police officer?",
            "spL|That's why I formed the Black Yakuza... ","spL|Well<> I know you. You are Primero's little girl. I will give you a chance to leave my place with your little friend.","spL|I will do one move<> if you can survive it<> both of you can leave.",
            "thR|This guy... grrrrr... I've been practicing so hard these years. Only my father at his best can defeat me with one move.","shR|$$$<> get to the door! NOW!",
            "com|swf-on_fxzok","com|photo-on_HawkShot","player|Klaire charges towards Shinichi! She believes it is her fastest attack ever...","player|...however<> in half a decisecond<> Shinichi's water SE has pierced through Klaire's chest already!",
            "player|GGYYAHHHH!","com|photo-off#com|photo-on_HawkKlaire","player|Klaire collapsed on the floor like a rag doll. No one really saw what happened. ","player|Shinichi: Too slow...","player|Klaire: But I... I'm still alive... Shinichi... I won... ",
            "com|photo-off#com|music-off_Mayhem","thL|......","shL|Guys! Let's go to the night club!","player|Shinichi left the restaurant with his Yakuza boys.",
            "com|remove_shinichi_left","com|photo-on_HawkCarry","player|I held Klaire in my arms... her face was as pale as a ghost.","player|Klaire: I'm lucky... well... maybe he didn't aim for my heart on purpose...",
            "player|$$$<> his SE... is still inside my body... take me to the Temple...",
            "END"];
    }
    private static function s029():Array{

        return ["com|bg_SpiritTempleScene#com|music-on_revival","player|Klaire fainted away shortly afterwards. I carried her to the Spirit Temple.","com|display_dea_work_center","shC|What's happened?","player|Dea placed her hand on Klaire and closed her eyes. ","spC|It's water spirit energy...","spC|Follow me!","player|Dea led us to a chamber in the inner Temple. Then<> she asked me to put Klaire down on a bed surrounded by six torches. ","spC|I need some time to get things going... remove all her clothes<> quick!","com|remove_dea_work_center","player|I can tell the situation is serious. I remove her uniform right away. ","com|photo-on_HawkNude","player|Her body is dead cold<> and her heart is beating unusually slow...","player|I feel that she is slipping away... and I don't know what the fuck to do!","player|I AM freaking out! ","com|photo-off","com|photo-on_HawkClose","player|I hold Klaire tight in my arms... I just feel that keeping her warm may help...","player|Where's Dea!? Where did she go!?","player|Please! Don't give up on me<> Klaire! Don't give up! ","com|photo-off","com|display_dea_work_center","shC|Step aside!","player|When I start paying attention to the surroundings again<> the six torches are all lit up. ","com|photo-on_HawkHealing","player|Dea lifts her hands and forms a ball with Fire SE over Klaire's wound. ","player|Dea: Fire SE is the opposite of Water SE... the opposite elements can neutralize each other...","player|Some Water SE is gradually absorbed from Klaire's body to the Fire ball... ","com|photo-off#com|music-off_revival","spC|This SE is so resilient... one of the most vicious I've ever seen... ","spC|I am afraid it will take me a few hours to neutralize it... who did this to her?","player|I told her what happened in the hot pot restaurant. ","spC|The crying Statue of Primero... Shinichi lost his katana 'Blood Moon'...","spC|I feel that the two events are connected. We may be able to find more clues from the underworld. ","spC|Klaire will be fine with me. Do you mind talking to a few people at the Black Market again?","END"];
    }

    private static function s030():Array{

        return ["com|bg_BlackMarketScene","com|display_blackmarket_center","spC|Yeah<> I know man... the Yakuza are desperate! Every single one of them is looking for the Blood Moon!","spC|Whoever took the sword... may god have mercy on his soul<> haha!","com|remove_blackmarket_center","player|I talked to a few people. No new information. ","com|display_nighthawk_center#com|music-on_sexy","shC|HEY!","spC|I saw you at the nightclub... do you remember me?","player|I recognized her. She is the cage dancer at the nightclub. She seems to be in a hurry.","spC|Hmm... can you help me to keep my bag for a minute? Please?","com|photo-on_HawkBag","player|The dance girl passed me a golf club bag. Somehow I was mesmerised by her and I accepted it. ","com|photo-off","com|move_nighthawk_right","com|display_policestation_left","shL|The bitch is here!","spR|Oh shit! Run! We will meet up later!","com|remove_nighthawk_right","player|The dance girl just ran away! Obviously<> I have no idea what is going on. I am being used as a bait I believe. ","com|move_policestation_center#com|music-off_sexy","shC|So<> you are Nighthawk's partner? You're dead!","com|swf-on_fxzok","shC|GGYYAHHH! Come on<> kid!","com|swf-on_fxbam","shC|Damn it!","com|remove_policestation_center","player|After dispatching the gang<> I opened the golf bag.","com|photo-on_HawkSheath","player|I found a saya<> a katana's sheath. The katana is not there however. There are two Japanese words on the saya: Blood Moon. ","player|The dance girl stole the Blood Moon from the Black Yakuza! I think they called her... 'Nighthawk'.","END"];
    }

    private static function s031():Array{
        return ["com|bg_SpiritTempleScene","com|display_dea_work_center","spC|Klaire just needs some rest and other than that<> she is doing fine. Don't worry.","thC|......","spC|So... you went to the nightclub afterwards<> and no one knows anything about the dance girl. ","spC|Hum... at least we have the saya.","spC|Sirena should be able to help us.","com|move_dea_work_right","com|display_sao_casual1_left","spL|Sirena the kidnapper?","spR|Like her mother<> my little sis Sirena has powerful psychic ability.","spR|If you give her the saya<> she may be able to locate the blade.","spL|Wait! I still don't get it. What is the connection between the lost katana and the crying statue of Primero?","spR|I can't explain too much at this point. Trust me<> finding the katana should be the key to solve this case.","spR|Please meet Sirena at the SimMan House inside the Themed Park. ","END"];
    }

    private static function s032():Array{

        return ["com|bg_TarotreadingScene#com|music-on_TarotReadingMusic","player|There is another SimMan's House inside the Themed Park in Shambala. We found Sirena there.","com|display_sirena_work_center","spC|You want to find the Blood Moon?","thC|......","spC|I can't help you... my boyfriend is Vodka. The Black Yakuza is his enemy. ","spC|I don't want to get involved in any of this. You guys should stay away too. ","com|move_sirena_work_right","com|display_sao_casual1_left","shL|Your sister Klaire was hurt by Shinichi because of this!","shL|We will get to the bottom<> even just for Klaire!","thR|......","spR|Fine!","spR|Here's an offer for you...","com|photo-on_HawkMetal","player|Sirena showed us a picture of a piece of metal knuckles. ","player|Sirena: It used to belong to Primero. He gave it to my mom as a gift. ","player|Someone stole it from her and sold it to the black market. I think Zack Krieg got it at the end.","com|photo-off","spR|Bring it back to me and I will help you to find the katana. ","shL|You've got yourself a deal!","com|music-off_TarotReadingMusic","END"];
    }

    private static function s033():Array{

        return ["com|bg_SportsBarScene","player|We found Zack Krieg at the Sports Bar. ","com|display_ceil_work_left#com|display_zack_casual1_right","spL|Hmmm... I am tired... I probably just want to go home after work.","com|photo-on_BarBadboy#com|music-on_zackMusic","player|Zack: Come on Ceil... just leave now. How much do you guys make a night? ","player|Three grand<> maybe? I give you six grand to shut the door now. Let me talk to your brother Lenus!","player|It seems that Zack is pretty drunk and he is giving Ceil a hard time.","com|photo-off","shR|I'm going to find your boss! I'll be back in a bit. Wait for me<> Ceil.","com|remove_zack_casual1_right","player|Zack stumbled to the back door. ","com|display_sao_casual1_right","spR|Ceil! Are you alright? ","shR|$$$<> go get the Zack-hole. ","com|bg_Alley#com|music-off_zackMusic","player|I followed Zack. He is taking a piss in the alley behind the bar... ","com|display_zack_casual1_center","shC|What're you looking at!? ","spC|Do you want something from me!? Come and get it<> haha!","com|photo-on_BarKiss","com|swf-on_fxzok#com|music-on_bababa","player|!!!!!!","player|It was a surprise attack. I totally didn't expect that.","player|Zack Krieg kissed me in the mouth! Damn it...","player|Answer 1: I WILL KILL HIM! No other option.","player|Answer 2: I hate him...","com|photo-off","player|Before I can react<> Zack gets back into the bar. ","com|remove_zack_casual1_center","com|display_sao_casual1_center","spC|Hey $$$<> you got the knuckles? ","player|No. And... he just kissed me. Damn it!","shC|WHAT THE...?","com|bg_SportsBarScene","com|display_lenus_casual1_left#com|display_zack_casual1_right","spL|Zack! You're not welcomed here!","shR|Fuck you Lenus! That's not the right way to treat a customer. ","spR|No wonder you have shitty business.","spL|Just get the fuck out<> Zack.","spR|Okay easy buddy... I will leave... with your little sis!","com|remove_lenus_casual1_left","com|display_ceil_work_left","shR|Let's go Ceil! ","spL|No... I am not leaving with you...","player|Zack took Ceil's hand and dragged her away with him.","com|music-off_bababa#com|swf-on_fxzok","com|photo-on_BarCeil","player|Ceil lost it<> finally!","player|Her body spinned like a spinning top and she smashed Zack with a hand chop. ","com|swf-on_fxboom","player|And... she still managed to keep in balance the drinks on the silver plate that she was carrying on the other hand.","com|photo-off#com|remove_zack_casual1_right","com|swf-on_fxbam#com|photo-on_BarHammer","player|Zack flied away<> crashed through the door and tumbled on the road outside the bar. ","player|At that moment<> a full-sized Hammer was running towards Zack at 70km/h! ","player|It must be Zack's lucky day! It is not easy to see one of these energy-consumering monsters on the road these days.","com|photo-off#com|bg_Alley","com|display_tyren_center","player|Zack's bodyguard Tyren had been waiting for his boss outside of the bar. His job was well paid<> but it was shitty.","spC|Holy Shit!","com|remove_tyren_center","com|swf-on_fxzok","com|display_gorilla_center#com|music-on_gangster","player|Tyren charged up with SE and his body was inflated 3 times bigger in a split of a second. ","com|photo-on_BarTyren#com|swf-on_fxboom","player|DDOOOOONNGGG!","player|In the next second<> Tyren's fist was burried deep under the hood of the Hammer.","player|The bodyguard had successfully bought a high-speed Hammer to a full stop in front of his boss!","com|photo-off","com|move_gorilla_left#com|display_zack_casual1_right","shR|Grrr... they almost got me killed!","shR|Tyren! Shut down the bar for good!","thL|......","shR|Do it! I will pay off your loans at once!","com|remove_zack_casual1_right#com|move_gorilla_center","player|Like Fatman<> Tyren is also a product of the Super Soldier genetic engineering program. They enhanced his upper body strength with gorilla's DNA.","com|music-off","END"];
    }

    private static function s034():Array{

        return ["com|bg_Alley#com|music-on_saoMusic","com|display_zack_battle_center","thC|Fuck... what the Universe is going on? Sao and $$$ had no SE just a couple months ago...","com|move_zack_battle_right","com|display_sao_battle_left","shL|Ha! Step aside people! I will finish him off all by myself!","shR|Fuck you<> Sao!","player|Zack was running low on SE. He took his metal knuckles out...","player|Sao: Psss Psss! That is what we're looking for<> $$$.","spL|Zack! Let's have a deal. Give us that metal knuckles<> we will let you go...","thR|......","shR|Fine! I don't need this piece of junk anyway!","com|photo-on_HawkMetal","player|Zack tossed the metal knuckles on the ground...","player|Sao picked it up immediately. ","player|Thanks Zack!","com|photo-off_HawkMetal#com|music-off_sao","com|remove_sao_battle_left#com|display_gorilla_left","player|Tyren stood up again. He stayed down only because he didn't enjoy the fight too much.","shR|Tyren! You didn't give your best in the fight... you betrayed me and my father!","spR|My father spared your life... and is that how you return his favor?","thL|......","player|Many years ago Tyren challenged Rufus to a duel. Tyren lost and Rufus made an exception and spared his life. He became a loyal follower of Rufus.","player|He did promise himself. He would fight till death for the Krieg family.","player|He didn't want to fight the kids and he had been limiting himself to around 10000 lbs punch power only.","spL|Fine. I will throw one proper punch... before calling it a night.","com|remove_zack_battle_right#com|remove_gorilla_left","com|display_lenus_battle_left#com|display_ceil_battle_right","spL|Stay behind me...","spR|Lenus...","player|Feeling that the gorilla is getting serious this time<> Lenus steps up and stands in front of Ceil. ","com|remove_lenus_battle_left#com|remove_ceil_battle_right","com|display_gorilla_center","shC|Keep your eyes open<> kid!","player|The bodyguard arched his back and aimed his next attack at Lenus.","com|swf-on_fxzok#com|music-on_danger","player|He throws a punch with 20000 lbs of power this time!","com|remove_gorilla_center#com|photo-on_BarBrother","player|There is no way for Lenus to take on that punch directly. Ceil is standing right behind him so dodging is not an option neither. ","player|At that moment<> he remembered a neutral skill he saw when he was 11. A skill that even his father Primero couldn't master... ","player|...it was demonstrated to him once by Primero's teacher... they called him 'SimMan'.","player|At 11 he was immensely intrigued by the Neutral Skill<> although he was never able to master it. ","player|SimMan told him the skill was called 'True Karmic Principles'!","player|A bright white aura was released from Lenus.","com|swf-on_fxzok","com|photo-off#com|photo-on_BarKarma","player|Lenus made it! The enormous punch was being sped up and redirected...","player|Tyren's giant fist lands on the chest of Zack instead! ","com|swf-on_fxboom","player|Everyone can hear the bone cracking sound... Zack's face turns pale immediately<> his mouth is wide open but he can't scream...","com|photo-off","com|display_lenus_battle_left#com|display_ceil_battle_right","shR|AAAHHHHH!","spL|I did it?","com|remove_lenus_battle_left","shR|Lenus!","player|Lenus consumed all his SE at once and collapsed. ","com|music-off_danger#com|bg_SportsBarScene","player|An hour later.","player|The police just left the pub. Street fights were no uncommon thing in Shambala. The wrecked Hammer was towed. The poor driver had no injury<> thanks to the advanced collision protection system equipped in the $100k car.  ","player|On the other hand<> the massive pain and terror had caused Zack to pass out. After a short moment of bewilderment<> Tyren carried his boss in his huge arms and left.","com|display_lenus_battle_left#com|display_ceil_work_right","spR|How do you feel?","player|Lenus took a sip of spirits.","spL|Much better...","com|remove_ceil_work_right#com|display_sao_casual1_right","spR|Nerdyman<> you have my full respect! What did you do back there?","spL|......","spL|I can't explain it in a few words. It was a neutral skill that can reflect the opponent's attack back to the opponent. ","spL|It kinds of work like Karma.","spR|Poor Zack... I didn't like that guy but man... that must hurt like hell! ","spR|I bet his rib cage is shattered like the towed Hammer.","spL|He should be fine. It was the first time I used the skill and I couldn't redirect all Tyren's power... ","spL|Besides<> at Blackspears they have the best nanotech to heal broken bones.","spL|On average we have 1.5 deadly street fight a day in Shambala. Broken bones is the least concern.","spR|Anyway... ","spR|Now we got the metal knuckles for Sirena. We saved the pub. Let's do a little celebration! What do you say<> Ceil?","com|remove_sao_casual1_right#com|display_ceil_work_right","spR|Ask my boss...","shL|Show them our Shambalian spirits!","shR|Yes Sir!","com|remove_lenus_battle_left#com|music-on_beachparty","player|They had some special 52% drinks in Shambala. Sao and I were no novice in drinking. Lenus was okay... Ceil did surprise us quite a bit. ","shR|Come on! Bottom up! You guys drink like my kitten! ","player|Ceil picked up a shot and guzzled it. It was her 16th shots.","com|display_sao_casual1_left","spL|Woah... the girl can drink!","com|remove_ceil_work_right#com|display_lenus_casual1_right","spR|Save that for her mother Sana Richardson. That's why I never invite her to my pub...","spL|Oh right... you guys have different mothers...except Ceil and Sirena.","spL|They are very different though... Ceil is very approachable<> like the girl next door... and Sirena... HAHA!","com|remove_lenus_casual1_right#com|display_ceil_work_right","shR|What about my sister? She is smart and beautiful. I am proud of her!","spL|Well... I have no comment.","spL|How about you<> Lenus? Why open this drinking place?","player|Lenus seems uneasy.","spR|Awwww... can I tell them? Please! I want to tell them!","com|remove_sao_casual1_left#com|display_lenus_casual1_left","spL|Nah...","spR|PLEASE?","player|Lenus gave in and walked away. He cared about Ceil a lot. I could tell.","com|remove_lenus_casual1_left#com|music-off_beachparty","spR|Yay! The story goes like this...","spR|It was about this young boy... one day he saw a beautiful girl at a 24 hrs fast food drive-thu...","com|photo-on_BarDrivethru#com|music-on_ironic","player|She worked there everyday from midnight to sunrise. ","player|The guy was an introvert. He loved robotics and he spent more time with robots then people. He didn't really know how to start a proper conversation with the drive-thu girl.","player|In order to see the girl he would go there every night; everytime he could just see her for a couple minutes at most... you know basically the girl just passed him the orders and took money from him...","player|He drove by 11 times and didn't have the courage to talk to her... finally at the 12th night...","player|He asked her name and number.","com|photo-off","com|display_sao_casual1_left","spL|Ok the guy is Lenus<> right?","spL|Come on<> he is the son of the Mega-playboy... I think he should be famous here!","spR|You know our father is an asshole... we don't usually talk about our family and we like to stay as detached as possible.","spR|We are not as popular as you think...","spL|...which is a good thing!","shR|Yes!","spR|Anyway... do you want to hear the rest of the story or not?","player|Sao made a gesture to zip his own mouth. ","player|After that night<> Lenus texted her all the time. After a while he asked her out. She agreed and proposed to meet at this pub on a Friday night... at that time this place was owned by someone else.","player|That night Lenus was super nervous... I still remembered he asked me what to wear<> what to say and a bunch of other silly things...","spR|I was the last person to ask... I don't even have a hehe... he was that desperate.","shL|Oh! You never date anyone<> Ceil?","shR|None of your business!","shL|Hahaha... Ceil is a...","shR|SHUT UP!","shL|Wahahahahahahaha...","shR|I am leaving!","spL|No no no no... I am sorry... please... we all want to hear the story. $$$<> right?","spR|$$$ is nice... I have no... freaking idea how you two can get along!","spR|Ok continue... Lenus went to the pub<> here. The girl didn't show up<> however.","spR|Lenus called her but no one answer.","com|photo-on_BarAccident#com|music-off_ironic","player|The next day Lenus went to the drive-thru and learnt that the girl had an accident...","player|The poor girl was hit by a car when she was on the way to the pub... she died at the scene.","com|photo-off","spL|......","spR|It was terrible...","spR|Lenus was devastated. A year later<> he spent all his savings to buy this place...","spR|Somehow... he is still waiting for the girl to come...","shL|What...?","spR|Do you guys believe in... ghost?","spL|Ahahaha... are you serious... NO!","spL|It was a horrible accident<> but he's a dude... he just needs to move on!","spR|Sao... are you afraid of...?","shL|Hell no!","shR|Sao<> she's behind you!","player|Sao jumped from his seat.","com|music-on_sao","shR|Ahahahahaha! Now I know your weakness<> Sao! You'd better behave yourself...","shL|I am NOT afraid of ghost! Whatever! I'm going to take a smoking break...","com|remove_sao_casual1_left","com|move_ceil_work_center","shC|Watch out<> Sao! You never know!","spC|Hehehe...","com|music-off_sao","spC|My brother is a genius... but he knows nothing about girls...","com|remove_ceil_work_center","com|photo-on_BarDrunk#com|music-on_sexy","player|Ceil's voice faded to a whisper suddenly...","player|Ceil: $$$<> are you seeing someone?","player|The thin shade of redness on her face made her exceptionally beautiful... and alluring.","player|Answer1: Not right now.","player|Answer2: I am seeing you...","player|Ceil: Do you remember the first time we met... you were in the changing room... I was looking for Tom Yum. I saw you naked hehe...","player|Ceil is staring at my body...","com|photo-off","com|photo-on_BarSleep","player|Ceil kicks off her shoes and lies down. ","player|After mumbling a few more words Ceil falls asleep. Damn! Can't move my eyes away from her innocent body.","player|Ceil is cute and hot at the same time. It is hard to resist the temptation to...<> and to believe that she hasn't dated anyone before. My guess is... she's being overprotected by Lenus.","player|I have a hard time keeping my butt on the seat...","player|Answer1: I want to touch her a bit...","player|Answer2: It's getting chilly. I should find her a jacket or something...","com|music-off_sexy","END"];
    }

    private static function s035():Array{

        return ["com|bg_HotelScene#com|music-on_horror","com|photo-on_BarSao","player|Sao... ","player|Who are you? What do you want from me?","player|I have something to tell you...","player|Go away! Aaaahhhhhh!","com|photo-off","com|display_sao_swimsuit_center","player|Sao woke up in a cold sweat. ","thC|It's a dream... it's just a dream...","thC|Damn it<> Ceil! She told me that freaking ghost story!","thC|......","shC|Oh shit! I almost forget. ","spC|I am supposed to meet up with $$$ at the SimMan's House.  ","com|bg_TarotreadingScene#com|music-off_horror","com|display_sirena_work_center","spC|Alright! A promise is a promise.","player|Now that we have the knuckles returned to Sirena<> she agreed to help us find the Blood Moon. ","player|Sirena holds the saya<> feels the spirit energy and lays her hands on the crystal ball in front of her.","spC|I found the blade. It is on the private island.","END"];
    }

    private static function s036():Array{
        return ["com|bg_PrivateIslandScene","com|display_sao_casual1_center","spC|What do we do? The island is not small. We need a search dog.","player|Listen!","com|swf-on_fxzok","com|photo-on_HwakFight#com|music-on_epicbegins","player|Nighthawk the dance girl is there! She is fighting with a man... Primero Lovemore!","player|Sao: Look $$$<> she has some kind of blade!","player|Nighthawk notices us and runs.","com|photo-off","spC|Hey lady<> you're not going anywhere...","com|move_sao_casual1_right#com|display_nighthawk_left","com|swf-on_fxbam","com|remove_sao_casual1_right","player|The woman punched him in the face and knocked him down. ","com|move_nighthawk_center","spC|Now do you want to get one too? ","shC|Get out of my way!","com|swf-on_fxzok","com|photo-on_TomoruHawk","player|I hesitantly throw an Air Punch at her. Nighthawk turns around and counters it with a Fire Kick!","player|I missed. Her heel landed firmly on my chest!","player|I didn't miss completely<> however. Her mask comes off. She is -- Tomoru Lovemore!","player|I feel that it is burning inside my chest. My vision goes black soon afterwards...","com|music-off_epicbegins","com|bg_SpiritTempleScene#com|music-on_revival","com|photo-on_TemplePool","player|Where am I?","player|My chest is still burning... ","player|I feel that I am surrounded by cold water.","com|photo-off#com|photo-on_TomoruNude","player|And I saw a naked girl in the water.","player|Dea...?","player|Relax! A voice in my head is talking.","player|I passed out after taking the hit from Nighthawk... Tomoru. She escaped with the blade. Primero and Sao took me back to the Temple. ","com|photo-off#com|photo-on_TomoruHeal","player|Inside a pool<> Dea is using her neutral skill to absorb the violent Fire SE from my body.  ","player|Neutral skills are the hardest. No one can master them like Dea. ","player|Some time later...","com|photo-off#com|bg_GardenScene##com|music-off_revival","com|display_sao_casual1_center","shC|Dude! You are still alive!","com|move_sao_casual1_left#com|display_dea_casual1_right","spR|Don't worry. I am professional. ","spL|By the way<> healing in the water pool is actually kind of cool...","spL|Can I try that too? ","com|remove_dea_casual1_right#com|display_klr_casual1_right","spR|You can<> Sao! But I will have to kick your ass really hard first!","shL|Hey Klaire! ","com|photo-on_TomoruKlaire","player|$$$<> welcome back to the team!","player|Thanks Klaire<> same to you. ","player|It took a much longer time<> but Klaire has finally recovered completely from Shinichi's attack. ","com|photo-off","spR|Let's go. Primero is waiting. ","END"];
    }

    private static function s037():Array{

        return ["com|bg_SpiritTempleScene","player|Klaire leads us to a room to meet Primero. We do have a lot of questions to ask him. ","player|Tomoru cosplaying Nighthawk stole the Blood Moon from the Black Yakuza. Then we found her fighting with Primero on the private island. Why?","com|display_primero_center","spC|You see<> Tomoru is my daughter.","com|photo-on_CasinoPrimero","player|I was busy with war. I was a kid<> barely into my college years<> but here I was running a country. An army. I didn't have time for a wife<> let alone four. ","com|photo-off#com|photo-on_TomoruKid#com|music-on_precioustime","player|When Tomoru was about 10 she was very rebellious. She stole the brass knuckles from Sirena's mother Sana and sold them in the black market. ","player|I got mad and slapped her on the face. Tomoru's mother Tassy was sad. She regretted marrying me and ran away with Tomoru. ","player|I let them go<> figuring they would return sooner or later. Years went by<> and Tassy and Tomoru never called or came home. I even cut off their financial support<> just to see if they would respond.","com|photo-off#com|photo-on_MansionDepressed","player|Later on<> Tomoru left us a message that Tassy passed away... then we lost contact with her completely. ","player|I started to blame myself. Devastated<> I was drunk 90% of the time.","player|Letting them go was the worst mistake I've ever made. ","com|photo-off","com|move_primero_right#com|display_sao_casual1_left","spL|So that's why you had a depression. I guess Tomoru really hates you...","spR|Yes. I was on the private island<> remembering the good old days when she was young and her mother...","spR|Tomoru showed up with the sword and attacked me. ","spL|She seems to be pretty good at SMA. Why stealing the blade from Shinichi?","spR|I think I know...","com|remove_sao_casual1_left#com|display_klr_casual1_left#com|music-off_precioustime","shL|Guys<> we have no time to chitchat!","spL|My colleagues just called me. Every single goon in Shambala is looking for Nighthawk<> Tomoru! ","spL|Shinichi is offering one million in cash for her head and his katana!  ","thR|......","spR|I will have a little talk with Shinichi. ","spR|Guys... please find Tomoru<> NOW! ","END"];
    }

    private static function s038():Array{

       return ["com|bg_Hotpot#com|music-on_epicbegins","com|display_primero_right#com|display_shinichi_left","spR|Shinichi! I want you to stop looking for Nighthawk.","spL|Wait a second... my dear Blackspears General. ","spL|As far as I know the War was over one decade ago. I no longer take orders from no one. ","spR|Let's have a deal.","spR|Give me three days. I shall return you your Blood Moon. ","spL|......","spL|It seems that Nighthawk is an important person to you... ","shL|Guys! Three millions! I want her head on this table in three days!","shR|24 HOURS!","spR|Please... Shinichi<> I know you hate me. I am begging you...","thL|......","spL|What if you fail? ","spR|The Yakuza way. Chop off my little fingers instead. ","com|bg_BlackMarketScene","player|We were waiting for Primero outside of the hot pot restaurant. Klaire received a call from him. ","com|display_klr_work_center","spC|Bad news! We only have 24 hours and Primero has to stay with them.  ","com|move_klr_work_right#com|display_sao_casual1_left","shL|Can't you do something about it? You are a police lady!","spR|You know this Nation is built by mercenaries<> right?","spR|The gangs have way more manpower than the police. That's why we need bounty hunters.  ","spL|Oh shit... 24 hours? What the fuck can we do...","spR|Damn it... oh! I need to call customs at the airport!","com|remove_sao_casual1_left#com|display_dea_casual1_left","spL|Stay cool<> people. ","spL|We can't afford even one misstep now.","spR|What are you thinking<> Dea? ","spL|If I were Tomoru...","com|photo-on_TomoruDea","player|Obviously<> I would be trying to leave Shambala asap.","player|But I wouldn't leave by air... $$$ had already exposed my real identity. As a flight attendent<> it would be almost impossible to make myself unidentifiable at the airport.","player|Well... there are not many ways to leave Shambala. ","com|photo-off#com|music-off_epicbegins","spL|We should be able to catch Tomoru at the pier. ","END"];
    }

    private static function s039():Array{
        return ["com|bg_PierScene","com|display_tomoru_casual2_center","thC|It's not over! I'll come back<> Primero!","com|move_tomoru_casual2_left#com|display_klr_casual3_right","shR|Tomoru!","shL|!!!!!!","com|swf-on_fxzok#com|photo-on_TomoruFight#com|music-on_Mayhem","player|Klaire charges towards Tomoru. Tomoru hastily intercepts Klaire with a Fire Turning Kick. ","player|Klaire: Primero put himself in danger because of you!","player|Tomoru: Yeah? ","player|Klaire has the first-mover advantage. Tomoru's attack is well anticipated. Klaire dodges the attack and firmly grips Tomoru's ankle... ","com|photo-off#com|photo-on_TomoruLock2#com|swf-on_fxbam","player|Klaire uses her body weight to pull her sister down to the floor with her. ","player|Let go of me!","player|Where's the blade!?  ","player|Knowing that her sister is exceptionally skillful at kicking<> Klaire is not going to release the leg lock on her. ","player|Okay! Okay! Do you need the blade? ","player|......","com|photo-off#com|photo-on_TomoruLock#com|swf-on_fxzok","player|Tomoru didn't give in. When Klaire was slightly distracted<> she successfully broke the leg lock.","player|Klaire! You know what Primero did to us! Why are you helping him!?","player|I know! But... at the end he's our father and he's in danger now! Grrr...","player|Hey! Tomoru is HERE!","player|Klaire couldn't free herself from the arm lock. She alerted the team instead. ","com|photo-off","thL|I can't take on all of them at once...","com|remove_tomoru_casual2_left","player|Tomoru runs away! ","com|move_klr_casual3_center","shC|Stop!","com|photo-on_TomoruKick#com|swf-on_fxzok","player|Hhhhaaaa!","player|Desperately trying to get away<> Tomoru uses an advanced Fire skill... ","player|She first kicked her luggage in the air<> and then she sent them flying like wild projectiles towards Klaire. ","player|The SMA skill is known as 'Triple Hellfire'!","player|Klaire managed to shun the long-range attacks<> but she could no longer stop Tomoru from running away. ","com|photo-off#com|photo-on_TomoruBoat","player|Tomoru escaped and got on a yacht. ","player|About 10 years ago<> her mother Tassy left the island with her on this yacht.","com|photo-off","shC|Damn it!","shC|Tomoru is getting away!","shC|Do something<> $$$!","com|remove_klr_casual3_center","com|photo-on_TomoruJet","player|I saw a jet ski nearby...","player|Without a second thought<> I jump on the jet ski and pursue the yacht.","com|photo-off#com|photo-on_TomoruCatch","player|Tomoru's yacht is fast. It took me a while to catch up. When I was getting close enough<> I brought my transportation's speed down to roughly the same as the yacht's.","player|Then I took an action-hero jump...","com|photo-off#com|music-off_Mayhem","com|bg_Yacht","com|photo-on_TomoruBath","player|Tomoru is taking a shower in the bathroom.","player|Hum... hum... hum... hum...","player|Is it a good time to confront her? ","player|Primero's life is hanging by a thread. I don't have a lot of choices. ","com|photo-off","player|play video","com|photo-on_TomoruLegs#com|music-on_crazy","player|What are you doing here!?","player|Trying to save you and your dad. Half the island wants you dead... and Primero went to negotiate with Shinichi...","player|How stupid! I can save my own skin!","player|They gave Primero 24 hours to return the katana... time is running out... they will hurt him. ","com|photo-off","com|display_tomoru_towel_center","thC|......","player|Primero told us the story about you and your mom. He made a terrible mistake<> but he is trying his best to make up...","shC|Too late! My mom is dead! You have NO idea how hard it was for her...","shC|I'll never forgive him!","com|photo-on_TomoruPunish","player|This time I pin Tomoru down on the bed.","player|......","player|We only have a few hours left. I've no time to go through family counseling with you. Where's the blade!?","player|You'll never find it! I've hidden it where you'll never find it. ","com|photo-off#com|photo-on_TomoruMirror","player|I picked up a hand mirror on a night stand. ","player|You are stubborn like my grandma!","com|photo-off#com|photo-on_TomoruPunish","com|swf-on_fxbam","player|I spank her ass hard with the hand mirror! ","player|Tomoru is a naughty girl and should be treated like one.   ","player|Say it! Where is the katana?","player|Grrr... YOU WILL NEVER...","com|swf-on_fxbam","player|I spank her a few more times until the mirror is broken off from the handle. She's not talking. I have to try something else.","com|photo-off","shC|YOU'RE SON OF A BITCH...","com|photo-on_TomoruFeather","player|I saw a feather coming out of the pillow. An idea pops up on top of my head. ","com|photo-off#com|photo-on_TomoruFeet#com|swf-on_fxzok","player|I tease her foot with the feather. Tomoru laughs uncontrollably...","player|Hahaha...hahaha...oh...hahaha...stop...hahahahahahahaha...you...hahahaha...bastard...hahaha!","player|You're putting your whole family in danger! Grow Up<> Already!","player|Hahahaha...FINE...haha...FINE...stop...haha...I'll...hahaha...tell you...hahahaha!","com|photo-off","spC|Haha...","spC|The katana's not here<> though. I will take you there.","com|swf-on_fxzok","com|photo-on_TomoruBite","player|I let her up. She bites my arm really hard as she gets up.","player|OUCH!","player|Bitch!","com|photo-off","shC|It's only fair!","spC|Now don't complain<> if you still want the blade!","com|music-off_crazy","END"];
    }

    private static function s040():Array{
        return ["com|bg_Hotpot#com|music-on_epicbegins","com|display_klr_work_right#com|display_shinichi_left","shR|Shinichi<> here's your Blood Moon!","com|photo-on_HawkSword","player|The Lovemore children returned the katana just in time.","com|photo-off","spR|Let him go!","shL|Primero! Primero! Primero!","spL|I just don't understand...","spL|No matter how many mistakes you've made<> you will always be forgiven at the end.","spL|I am really jealous of you.","com|remove_klr_work_right#com|display_primero_right","spR|......","spR|Shinichi<> it was 20 years ago... let it go.","shL|Hah!","spL|You took Tassy from me and you treated her like shit!","player|When Primero and Shinichi were still in their college years<> they fought each other because of Tassy. Shinichi lost his eye during the fight.","spL|I will never forget that. ","shL|Get the hell out of my place<> NOW!","com|music-off_epicbegins","END"];
    }
    private static function s041():Array{
        return ["com|bg_LovemoreMansionScene","player|The team returned to the Lovemore Mansion.","com|display_mansion_center","shC|Oh my Universe! You look all beat up<> Primero!","spC|Stubborn human will not go to the human repair shop.","com|remove_mansion_center","com|display_primero_left#com|display_tomoru_casual2_right","spR|......","spL|......","player|Say something<> Tomoru.","spR|......","spL|I am so sorry<> Tomoru.","spL|It's all my fault...","spL|I have made a decision. I will leave here shortly<> and go to a secret place to regain my power.","spL|Humpty<> please look after the house and everything for me. $$$<> great job! ","spL|Well...","spL|I will need a good rest. I will see you guys later. ","player|Primero turns around and walks back to his room.","spR|......","com|remove_primero_left","spR|Thanks...","player|I am not sure if Primero could hear her whisper. Tomoru may not be able to forgive her dad completely<> but it is a really good sign.","com|display_sao_casual1_left#com|music-on_ironic","spL|Hi Tomoru slash Nighhawk! ","spL|I am still very curious. What did you do to Primero's statue? Do you mind?","spR|Are you... going to arrest me?","spL|Well... I am not the authority here.","com|remove_sao_casual1_left#com|display_klr_work_left","spL|I checked. The statue is still considered a private property of Primero. He can sue Tomoru for damage. ","spL|I don't think it is going to happen.","com|remove_klr_work_left#com|display_sao_casual1_left","spL|So... Tomoru<> you are all good!","spL|Tell us the story<> please?","spR|Fine...","spR|I stayed away from Shambala until recently. In fact<> that day we met on the plane was my first work flight to Shambala. ","spR|I visited a few old places like the dance club... and at the museum I saw Primero's statue.","spR|I found it disgusting. I wanted Primero to lose face so I came up with a plan...","com|photo-on_TomoruCut","player|First<> I needed something to chop up the statue. I stole the Blood Moon from Shinichi<> as it was one of the few weapons that could withstand my Fire SE. ","player|I used the Blood Moon to cut the statue into small pieces... small enough to go through the gaps of the fence. ","player|After transporting all the pieces of the statue out of the museum<> I threw them away. ","com|photo-off","spL|Oh I see... wait! How did the statue show up at the private island? ","spR|Of course it's not the same statue<> genius!","spR|I recorded the 3D image of the statue in advance. Then I just found a 3D printer to print out the same thing.","com|photo-on_HawkStatue","player|I placed the replica on the private island one day earlier. Put some red paints on his face. Done! ","com|photo-off","spL|Woah... Lovemores<> you sure have one crazy family!","player|After that day<> Primero left Shambala to regain his strength. The Lovemore Mansion became the meeting place for our team. ","com|music-off_ironic","END"];
    }
    private static function s042():Array{
        return ["com|bg_CasinoScene#com|music-on_sirenaMusic","player|Sao said he is going on a date. I came to the Casino alone.","player|I am not really in the mood of playing. I found a seat at the bar instead. ","com|display_sirena_casual2_center","spC|Over here<> $$$! Let's play pool.","player|Sirena looks especially good tonight. Not so sure about her pool skills. ","player|Sure! Why not?","com|photo-on_SirenaPool","player|Sirena: You're not... terrible at this.","player|I am just getting warm up. ","player|Sirena: Humm... let's start a serious game then.","com|photo-off","spC|If I win this next game<> you take off your shirt. ","player|What if I win?","spC|We'll see!","com|photo-on_SirenaPool","player|What does the tattoo on your leg mean? L.I.N.E.?","player|Hmm...","player|She just ignored my question. The 8-ball is pocketed by mistake however. ","com|photo-off","spC|Well<> you win!","player|It seems that she doesn't have anything to take off.","com|photo-on_SirenaPanties#com|swf-on_fxzok","player|Wait... what are you doing!","player|Sirena is stepping out of her panties!","player|You win the game. Fair enough! ","player|She shoved her panties in one of the pool table pockets.","com|photo-off#com|music-off_sirenaMusic","spC|Next game!","com|remove_sirena_casual2_center#com|display_blackmarket_center","thC|What the fuck? Sirena Lovemore is playing strip pool with someone!?","thC|Oh man... I've got to call Vodka. ","com|bg_BlackMarketScene#com|display_vodka_center","shC|What!? Sirena is playing strip pool...","thC|That bitch! She wants revenge for sure!","thC|Damn! We go out for a year and I only cheat on her this one time! ","thC|Why can't she just forgive me! I am a mob boss after all...","com|bg_CasinoScene#com|display_blackmarket_center","spC|Ok boss! I am taking a video...","thC|What the!","com|remove_blackmarket_center#com|photo-on_SirenaKiss#com|swf-on_fxzok","player|Sirena has no more clothes to take off and she offers me a kiss instead... ","player|Wait Sirena... I think you have a boyfriend...","player|Ex-boyfriend!","player|Getting a kiss from the mob boss's woman... this is a really fucking bad idea. I can't resist the temptation however.","com|photo-off#com|display_sirena_casual2_center","spC|Great game. I had fun tonight. See you later!","spC|Oh and if you are still wondering...","spC|Love. Is. Not. Everything.","player|Sirena adjusted her dress and left. I hanged around a bit longer to calm down. Then I decided to leave.","com|bg_Alley","player|I could smell troubles coming my way. What I didn't expect was... it came almost instantaneously.","com|photo-on_SirenaGang#com|music-on_gangster","player|Once I stepped outside of the Casino<> I was surrounded by some 30 men. The leader was Vodka<> Sirena's boyfriend<> or ex-boyfriend according to her.","player|You know what you did! Sirena is my girl.","player|Fight me<> or fight us. You choose.","com|swf-on_fxzok","player|Knowing that a fight is inevitable one way or the other<> I activate my battle suit...","com|photo-off","player|Suddenly a motorbike came round the corner and stopped in front of me!","com|display_klr_work_center","shC|Come now if you want to live. Get on!","com|remove_klr_work_center","com|photo-on_SirenaBike#com|swf-on_fxzok","player|I get on to the back seat and we race away on the bike.","player|How do you know I am in trouble!?","player|I just have this... feeling. I can't explain! ","player|Just shut up and hang tight!","com|photo-off#com|display_vodka_center","shC|FUCK! FUCKING FUCK! GRRR!","player|Vodka makes a phone call.","shC|Hey<> Bloody King! I have a deal for ya!","spC|There's a motorcycle headed your way. Two riders. Stop them. One hundred grand if you do.","com|bg_Carpark#com|display_tiger_center","spC|One hundred grand? Deal! It's boring here anyway.","shC|My Queen Lilith! Let's go for a ride!","com|move_tiger_left#com|display_hooker_right","spR|Where're we going<> my King?","spL|Just take your biggest guns with you. ","com|music-off_gangster","END"];
    }

    private static function s042b():Array{
        return ["com|bg_SkyNight","player|We survived at the end. Klaire pulled over.","com|photo-on_SirenaChest#com|music-on_bababa","player|Klaire took off her helmet. My hand was still gripping tightly on her breast. ","player|Excuse me! Your hand!","player|Opps... I was nervous. Sorrie!","player|You know what? I saved your ass exactly three times!","player|First outside of the night club. Second inside the hot pot restaurant... and this time.","player|You owe me something!","com|music-off_bababa","END"];
    }

    private static function s043():Array{
        return ["com|bg_HotelScene","com|display_sao_casual1_center","shC|Oh no... we have some bad news!","com|photo-on_SirenaRobot","player|Vodka went to the Lovemore mansion this morning. Sirena wasn't there and he started busting things. ","player|Humpty tried to stop him. He left Humpty in a million pieces. ","player|We should go.","END"];
    }

    private static function s044():Array{
        return ["com|bg_LovemoreMansionScene","com|photo-on_SirenaCry","player|When we arrived<> Sirena was sitting besides the broken robot and crying like a little girl.","player|It was a bit of surprise. I didn't know that Sirena has a weak side like this. ","player|Klaire had everyone informed. The other Lovemore members arrived one after another a few short moments later. ","com|photo-off","com|display_tomoru_casual1_left#com|display_sirena_casual3_right","shL|This is all your fault!","shR|Stop blaming me! I didn't want any of this...","shL|Are you stupid? This is what you get for dating a mob boss!","spR|Fine! You're the perfect girl<> Tomoru! Who stole a katana from the Yakuza and got the whole family into a big mess?","spL|You... you're hopeless!","spR|The same to you!","com|remove_tomoru_casual1_left#com|display_dea_casual1_left","thL|......","com|photo-on_SirenaSlap#com|swf-on_fxbam","player|Dea slaps Sirena hard on the face!","player|Enough!","player|Sirena! You never admit your own mistake! ","com|photo-off","spR|I...","com|remove_sirena_casual3_right","player|Sirena rushes out of the door.","thL|......","com|display_lenus_work_right","spR|Well<> ladies...","com|photo-on_SirenaLenus#com|music-on_lenusMusic","player|Lenus finally breaks the moment of silence. ","player|The key to everything that makes Humpty Humpty is in the hard drive. As long as that's not completely damaged<> I can fix him.","player|Lenus removes his glasses and his shirt.","player|Do you guys want to help? Let's do something contributive!","com|music-off_lenusMusic","END"];
    }

    private static function s045():Array{
        return ["com|bg_SpiritTempleScene","com|display_dea_work_left#com|display_ceil_casual1_right","player|As the sun began to fall<> Dea and Ceil were closing up the temple for the night.","spR|Where do you want to go for dinner tonight? ","spL|Up to you. As long as...","spR|No meat! I know you<> Dea. I've called the team to join. Do you mind?","spL|The more the merrier!","com|bg_GardenScene","player|Meanwhile<> outside the Temple...","com|display_temple_center","shC|Hey! You two are not allowed...","com|swf-on_fxbam","com|remove_temple_center","com|display_sana_left#com|display_xenos_right","spL|See what happens when you leave a place this powerful to a child.","spR|Yes<> my love. It is a disgrace.","com|bg_SpiritTempleScene#com|music-on_epicbegins","com|display_sana_left#com|display_xenos_right","player|After defeating all the guards in the garden with ease<> the couple entered the inner Temple.","spL|Hello! Dea Lovemore...","com|remove_sana_left#com|remove_xenos_right","com|display_dea_work_left#com|display_ceil_casual1_right","shR|Mom!?","spL|Sana... is there anything I can do for you?","com|remove_dea_work_left#com|remove_ceil_casual1_right","com|display_sana_left#com|display_xenos_right","player|The woman with short blonde hair turned out to be the biological mother of Sirena and Ceil - Sana Richardson.","player|The man is her current lover called Xenos. ","player|At the same time<> the Supreme Guardian of the Temple<> emerged from the shadows. His name is 'O'<> pronounced as 'Wuji'. ","com|remove_sana_left#com|remove_xenos_right","com|display_o_center","shC|Sana and Xenos! You two are permanently banned from the Temple! ","shC|Leave!","com|remove_o_center","com|display_sana_left#com|display_xenos_right","spL|Xenos<> they say this man is one of the Top 3 SMA Masters in Shambala. Be careful. ","com|remove_sana_left#com|remove_xenos_right","com|swf-on_fxzok#com|music-off","com|display_sana1_left#com|display_xenos1_right","shR|Begone!","com|photo-on_SanaShield#com|swf-on_fxzok#com|music-on_danger","player|Sana and Xenos attack at the same time!","player|O immediately created with his Neutral SE a shield around himself. It absorbs and repels both the Water SE from Sana and the Fire SE from Xenos!","player|Xenos<> we don't have to waste time with him!","player|Ok Sana<> let's do it!","com|photo-off#com|photo-on_SanaTwin","player|Xenos and Sana combined their Spirit Energies together! ","player|Water and Fire merged into one. It turned into a beam of tremendously powerful energy!","player|It is believed that each person's SE is operating in an unique freqency range. In theory<> no two SE can be combined...","com|photo-off#com|swf-on_fxboom","com|photo-on_SanaBeam","player|The combined energy is so massive that it shattered the shield of the Surpreme Guardian completely.","player|In the next moment<> O found himself being pushed 50 meters away from the Temple! ","player|Both Ceil and Dea are shocked to the bone. It is the most powerful SE blast they have ever witnessed.","com|photo-off","spL|Oh dear! I can't imagine we just defeated one of the top SMA Masters like a level-one boss.","spR|Yes... with this twin flames skill<> we are invincible. ","spL|From now on<> this will be the Temple of the Twin Flames. This is OUR Temple! ","com|remove_sana1_left#com|remove_xenos1_right","player|Dea and Ceil were already in battle mode. ","com|display_dea_battle_left#com|display_ceil_battle_right","spL|Sorry Sana! I know our father Primero failed you. ","spL|However<> as the current High Priestess of the Spirit Temple<> I command you to leave!","shR|Mom! Don't make us fight you!","com|remove_dea_battle_left#com|remove_ceil_battle_right","com|display_sana1_center","shC|Hahahahahahaha...","spC|Don't be silly<> girls. You don't stand a chance...","com|move_sana1_right#com|display_ceil_battle_left","thL|$$$<> help me please!","com|photo-on_SanaTakedown#com|swf-on_fxbam#com|music-off","player|Ceil uses a double leg takedown that she learned from $$$ to bring down her mom by surprise. ","player|When they hit the floor<> Ceil immediately throws a hand chop at Sana<> and stops at just an inch away from her neck.  ","com|photo-off#com|photo-on_SanaChop","player|You lose<> Mom!","player|Sana was speechless for a moment. Ceil was always the baby girl to her. She could never see her as an equal opponent. ","com|photo-off","spL|Please<> leave my sister alone!","spR|......","spR|Xenos<> let's go... for now.","spR|Dea<> you have until the end of the tournament to remove all traces of the Lovemore family from the Temple!","com|remove_ceil_battle_left#com|display_dea_battle_left","spL|What if our team win?","spR|Ha!","com|remove_sana1_right","player|Sana smiled<> and then she left the Temple with Xenos.","player|As soon as the couple left<> Ceil burst into tears. Some time later<> the Lovemore team arrived at the Temple.","com|photo-on_SanaSit#com|music-on_precioustime","player|What's wrong<> Ceil?","player|Ceil starts explaining the story of Sana Richardson to Sao and me. ","player|After Tomoru's mom left the family<> Primero became alcoholic. Sana also regretted marrying him and she spent most of the time at the Temple instead.  ","player|She became the first High Priestess of the Spirit Temple. Xenos was the Supreme Guardian at that time. They fell in love. At first Sana tried to fight it and banned Xenos from the Temple. ","com|photo-off#com|photo-on_SanaPast","player|About a year later<> Xenos finally went crazy. One night<> he defeated all the other guards and broke into the Temple. ","player|Something wrong happened. Primero found out later. He kicked both Sana and Xenos out of the Temple. ","player|Sana insisted that Primero had no right removing her status and vowed to return... Dea became the new High Priestess at the end. They finally decided to settle it in the coming SSCC.","com|photo-off","com|display_sao_casual1_right","spR|Man! Rufus<> Shinichi<> Vodka<> Sana and Xenos... the list of Lovemore's enemies has no end! ","spL|We will try our best...","com|remove_dea_battle_left#com|display_o_left","spL|The best is not enough!","shR|Woah! Who's this guy?","spL|I am the Supreme Guardian of the Temple<> O. ","spL|The myth is true. Sana and Xenos are twin flames. It is the only reason why their energies can be perfectly blended into one.","spR|Twin flames... what do you mean? ","com|remove_sao_casual1_right#com|display_dea_battle_right","spR|Twin flames<> also called twin souls<> are literally the other half of our soul.","player|We each have only one twin in this World<> and generally after being split the two went their separate ways to gather human experience. ","player|All other relationships through our lives could be said to be 'practice' for the reunion of twin flames.","spR|Each person's SE is unique. However<> twin flames<> and only twin flames<> are able to combine their SE into one.","spL|Yes. This is also the first time I've encountered the legendary twin flames skill... ","com|music-off","END"];
    }

    private static function s046():Array{

        return ["com|bg_SkyNight#com|music-on_fatmanbattle","com|display_sirena_work_left#com|display_lenus_work_right","spR|Sirena! Why are you taking the damaged hard drive from Humpty? ","spL|Sorry. I can't tell you. ","spR|The drive is the very essence of Humpty. Give it back to me!","com|photo-on_RobotSteal#com|swf-on_fxzok","player|Sirena threw the hard drive up in the air suddenly. Lenus was shocked. ","player|Sirena attacked him with a fast and stealthy Water Skill.","player|The hard drive fell back to her hand. Lenus was out of the way...","com|photo-off","thL|I am sorry...","shL|!!!!","com|swf-on_fxzok#com|photo-on_RobotFight","player|Out of the blue<> an unkindness of ravens emerged from the darkness and attacked the Lovemore siblings. ","player|Without hesitation<> Lenus casted a water barrier to fend off the ravens from Sirena and himself.","com|photo-off#com|photo-on_RobotRob","player|However the ravens are too numerous. One of them successfully took the hard drive from Sirena during the disarray.","player|Sirena: Damn it!","com|photo-off#com|photo-on_RobotGun","player|Sirena pulled out her gun from her cape immediately and fired a few shots at the raven. ","com|swf-on_fxboom","player|She shot down a couple ravens<> but whenever one was down<> another would take the hard drive and fly away.","player|At the end she couldn't stop them from escaping with the hard drive. ","com|photo-off#com|photo-on_RobotRaven","player|When they took a closer look at the bodies on the ground<> they found that the ravens are... robots.","player|It is pretty obvious that someone is controlling these robotic ravens to rob the hard drive. ","com|photo-off","spL|Damn!","spR|Sirena<> what the heck is going on!?","spL|Believe me or not. I have no idea.","spL|Do you have a GPS device at home?","spR|A few. I can also enable the GPS functionality in Humpty...","spL|The last bullet I shot at the bird was a smart one. It is sending out radio signals...","shR|Sweet!","com|remove_sirena_work_right#com|remove_lenus_work_left","player|Half an hour later...","com|display_sao_battle_left#com|display_ceil_battle_right#com|music-off","spL|We're ready for some bird hunting!","spR|Sao<> we are not doing this for fun!","spL|I know... just take it easy.","com|remove_sao_battle_left#com|remove_ceil_battle_right","com|display_klr_battle_left#com|display_dea_battle_right","spL|Robotic ravens hovering all over the city. I don't feel good about this. ","spR|Where did the signal go<> Lenus?","com|remove_klr_battle_left#com|remove_dea_battle_right","com|display_lenus_battle_left#com|display_tomoru_battle_right","spL|Down! There.","shR|Not the sewers!","com|remove_lenus_battle_left#com|remove_tomoru_battle_right","player|Lenus pointed at the undergound sewer system of Shambala. We followed him.","com|bg_Sewage#com|music-on_horror","com|display_sao_battle_left#com|display_lenus_battle_right","shL|Ewwww... this is nasty.","spR|No signal here. This place is huge. Let's search in pairs.","spR|Be very careful guys! We don't know who is controlling the ravens. ","spR|$$$<> please come with me.","com|remove_sao_battle_left#com|remove_lenus_battle_right","player|There are multiple tunnels in the sewage facility. The team split up and go different directions.","player|During the walk in the dark tunnel<> Lenus told me more about Humpty. ","com|photo-on_RobotFamily","player|Lenus made Humpty when he was about 11. The robot was a real family member to them.","player|In fact<> because of the old war<> the Lovemore children spent more time with Humpty than their father Primero.","player|They all feel very close to Humpty. ","com|photo-off#com|display_lenus_battle_center","spC|......","shC|Hey<> look! ","com|photo-on_RobotDoor","player|We found an entrance to a secret room. ","player|Maybe we should tell others first...","player|Let's get in there!","com|photo-off","com|remove_lenus_battle_center","player|Lenus went into the room without hesitation. I followed him.","com|photo-on_RobotComputer","player|Inside the room we found the hard drive! It is connected to a computer.","player|It is running a hacking program. It seems that someone is trying to gain access to a hidden file in the hard drive.","player|Beep... beep... beep... access granted!","player|The hidden file is unlocked. ","player|It is a 100-page confidential document about a forbidden SMA skill named 'À la prochaine'.","com|photo-off","player|Lenus unplugged the hard drive. ","com|display_lenus_battle_center","spC|Let's move. ","com|move_lenus_battle_right#com|music-off","com|display_keir_left#com|music-on_Mayhem","spL|Put down the damn thing.","spR|You must be the robot birds' owner. You have something of mine.","thR|......","player|Lenus charged up with Spirit Energy suddenly. ","com|swf-on_fxzok","spR|Who are you?","spL|They call me THE MASTER OF INSANITY.","spR|Why did you steal the hard drive from us? ","spL|You're talking too much! Leave the hard drive and get the fuck out of here. ","spR|Okay<> okay! We'll leave... one last question<> please.","shL|????","player|The man found that he was surrounded by team Apollyon. Lenus released his SE earlier as a distress signal to the rest of the team.  ","com|remove_keir_left#com|remove_lenus_battle_right#com|music-off","END"];
    }
    private static function s046b():Array{
        return ["com|bg_Sewage","com|display_keir_center","spC|Not bad<> kids!","com|photo-on_RobotSeven#com|music-on_Mayhem","player|I am not in the mood of fighting with toddlers today. Give me the hard drive<> NOW!","player|The insane man held Ceil hostage. He is pointing a needle at her throat. ","player|Sirena took the hard drive from Lenus. ","com|photo-off#com|remove_keir_center","com|display_dea_battle_left#com|display_sirena_battle_right","shR|Leave her alone! You take the disk! ","thL|......","com|swf-on_fxzok","player|Dea uses a Neutral Skill and throws a bright light ball in front of the insane man. ","player|The man has been living in the dark for a long time. The bright light gives him a flash blindness for a couple seconds!","com|remove_dea_battle_left#com|remove_sirena_battle_right","com|photo-on_RobotEye#com|swf-on_fxzok","player|Sirena uses Z-walk to get close to the man instantly and attacks him in the eye!","player|The man takes a step back<> but it doesn't stop him from jabbing the needle towards Ceil!","player|Sirena blocks the needle with her own hand!","com|photo-off#com|photo-on_RobotKick#com|swf-on_fxbam","player|The team know that they only have one shot. ","player|Dea grabbed and locked his wrist. ","player|Tomoru kicks him in the elbow to disarm his weapon almost at the same time!","com|photo-off#com|photo-on_RobotGroup#com|swf-on_fxboom","player|The Master of Insanity takes another two steps backwards. ","player|Lenus<> Ceil<> Klaire and Sao are expecting him. They throw their best skills at him...","player|He was hit by the four SE elements Fire<> Water<> Air and Earth at once!","player|AARRRGGGHHH!","com|photo-off","player|The weird man screamed and disappeared in the dark. ","com|display_sao_battle_left","shL|Where are you going<> crazy man? The fight's not over!","com|display_dea_battle_right","shR|Leave him alone<> Sao! That man is too dangerous. Let's get out of here!","com|music-off","END"];
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
            "com|bg_PierBgDay","com|display_@@@_twin_center","spC|......","player|Will you ever come back to Shambala? ","spC|Hm... I don't think so. ","player|Well... I wish you all the best<> as always.",
            "spC|Same here.","player|Give me a call or something...","spC|Nah... we had an agreement<> remember? We just split up and that's it.","spC|Forget everything in the past! That way we can both start a new life<> ok?",
            "player|Okay...","spC|All the best<> $$$.","shC|Time to go! Goodbye!","com|twin-photo-on_Goodbye@@@","player|(So... that was the last time I saw @@@.)",
            "player|(After losing our Spirit of Love<> both of us cannot feel or experience Love again.)","player|(The feeling is weird. All our memories are intact. We can still remember every little thing happened between us in the past year.)",
            "player|(We just don't feel 'it' anymore.) ","player|(At the end @@@ decided to start fresh somewhere... we honestly thought it was a good idea.)","com|twin-photo-off",
            "player|Another few weeks later<> Sao is fully recovered. He shielded us from Rufus's attack when we were casting the forbidden skill. ","player|SimMan is still in a coma however. ","com|bg_GardenBgDay",
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
            "com|photo-off#com|music-off",

            "com|bg_Sewage","com|display_keir_right","spR|Why did you tell $$$<> my dear?","spR|We can just kill them. ",
            "com|display_mia_left","spL|Psst. Killing the Amagi won't make a damn difference. ",
            "spL|They defeated Lucifer. They killed Jesus. ","spL|But the MORNING STAR will keep coming back. ",
            "spL|We want to keep the Amagi forever in the dark instead. ","spR|So what do we do now?","spL|We'll wait. ",
            "spR|Fine! Just wake me up when you need to kill again.","com|bg_Blackspears#com|music-on_epicbegins",
            "player|I arrived at the Blackspears secret HQ. ","com|display_primero1_center",
            "spC|I've given SimMan an update about your situation. ","spC|SimMan thinks he may be able to help.",
            "com|move_primero1_right","com|display_simman_left","spL|I don't want either of you turning into another Rufus Krieg. ",
            "spL|After all<> I created À la prochaine and it led to all these troubles. ","spL|I will try my best to fix it.",
            "spL|Pack your stuff. We will go search for the lost Spirit<> for you and @@@.","player|Where are we going?",
            "spL|Pamir Mountains - the Roof of the World. ","com|photo-on_Simman","player|According to SimMan<> Pamir was once the home of the oldest Ancient Deities<> aka Heaven. ",
            "player|They first discovered Spirit Energy there over 5000 years ago. ","player|Wait for me @@@...  ",
            "player|We will find a way to love again. No matter how hard it is. I promise. ","com|music-off",
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
