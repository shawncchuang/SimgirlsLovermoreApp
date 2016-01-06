/**
 * Created by shawnhuang on 2016-01-04.
 */
package data {
public class StoryDAO {
    private static var access:Array=new Array();
    private static var container:Object={"s001":s001(),"s002":s002(),"s003":s003(),
    "s004":s004(),"s005":s005(),"s006a":s006a(),"s006b":s006b()};
    public static function switchStory(id:String):Array {

        access=container[id];
        return access;
    }

    private static function s001():Array{

        return [
            "com|bg_HotelScene,com|display_daz_center",
            "spC|Aloha! Welcome to the Hotel Shambala.",
            "spC|While we are getting your room ready, let me explain a bit about ACTION POINTS or simply AP.",
            "spC|AP determines how many things you can do in a given time period. Most activities will consume your AP.",
            "spC|When your AP is running out, you can regain AP by taking a rest in our hotel.",
            "spC|Just so you know I am always here seven days a week. Whenever you need me, you just have to LOOK AROUND.",
            "spC|Workaholic? We are Shambalians! We enjoy our work. See you around!",
            "END"
        ]

    }
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
            "spC|It’s Saturday night<> the only decision you need to make is bottle or glass. See ya around okay!?",
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
            "com|photo-off#com|music-off_zackMusic",
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
            "player|There's cat in the bush. It looks vaguely familiar. Oh! It must be that cute girl's... the cat from the picture I saw in the changing room! ",
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
            "player|The girl gave me a business card. She is an instructor teaching a Spirit Energy class at the Temple.",
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

}
}