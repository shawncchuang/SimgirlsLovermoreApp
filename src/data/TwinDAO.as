/**
 * Created by shawnhuang on 2016-01-15.
 */
package data {
public class TwinDAO {
    private static var access:Array=new Array();
    private static var container:Object={"t001":t001(),"t002":t002(),"t003":t003()};
    public static function switchTwinDAO(id:String):Array {

        access=container[id];
        return access;
    }
    private static function t001():Array{

        return ["com|bg_Sky","player|Wandering around downtown aimlessly<> I can't get @@@ out of my mind.",
            "player|I finally stopped at a coffee shop.","com|photo-on_CoffeeShop",
            "player|It is quiet in the late afternoon. I bought a coffee and sit down by the window. ",
            "player|I think I should talk to Sao. At the end<> it is up to @@@ to decide. ",
            "player|Sigh...","player|Someone is sitting behind me. I turn around...",
            "com|photo-off#com|twin-photo-on_Coffee@@@","player|Oh hi!!","player|What are you doing here<> @@@?",
            "player|I am... waiting for Sao. He begged me to meet him here and he's late!",
            "player|I see...","player|$$$<> don't get me wrong... hmm... I only see Sao as a normal friend. I am actually seeing someone...",
            "player|@@@'s voice trailed off. Speechless. We just looked at each other for almost 10 seconds.",
            "com|twin-photo-off#com|twin-photo-on_Kiss@@@","com|music-on_tomoruMusic","player|Hum!?","player|I kissed @@@. ",
            "player|It was... magical. No word can describe and no word is needed to describe. ","com|twin-photo-off#com|photo-on_KissSao",
            "player|Sao arrived the coffee shop at the perfect timing. ","player|Sao: What the...",
            "player|Sao: All these people you could have<> $$$. Why @@@? Some friend you are.",
            "com|photo-off","player|Sao didn't want confrontations. He ran away. ",
            "com|bg_Carpark","com|display_sao_casual1_center#com|music-off_tomoruMusic",
            "spC|DAMN IT! FUCK! WHY?","spC|I was going to give this to you<> @@@!",
            "player|Sao ripped his necklace off the neck and threw it on the ground<> hard enough to crack the pendant open.",
            "com|swf-on_fxbam","com|photo-on_KissAna#com|music-on_horror","player|A misty hologram of Sao's mother<> Annabeth<> rose from the pendant.",
            "player|Sao<> it's mom. I'm guessing that you are old enough to understand this message.","player|Your father's real name was Rayden Black. ",
            "com|photo-off#com|photo-on_MiaSimMan","player|Many years ago<> I was training under a Martial Arts Master called SimMan in Shambala. ",
            "player|SimMan had 3 other students: your father Rayden<> Rufus Krieg<> and an asshole called Primero Lovemore!","com|photo-off#com|photo-on_KissRayden",
            "player|Both Rayden and Primero fell in love with me. Of course I chose your father Rayden at the end. Primero was very upset. ",
            "player|Rayden and I loved each other very much. Later on I got pregnant. It was you<> Sao.  ",
            "com|photo-off#com|photo-on_KissDuel","player|Primero must be very jealous. One day he had a practice fight with Rayden. Primero killed your father! ",
            "player|He said it was an accident. He lied! It was jealousy!","player|Our family was ruined by Primero Lovemore. I left Shambala. I didn't want to tell you because Primero is too powerful. ",
            "com|photo-off#com|photo-on_KissPrimero","player|He is the leader of a private military group. I don't want you to mess with him. ",
            "player|But... this hidden hatred in my heart is torturing me everyday. What can I do? I... I really want to die.","com|photo-off#com|photo-on_KissAna",
            "player|I will lock this message up forever. I love your father. I love you<> Sao. ","player|Keep love in your heart<> son. Avoid those who would tear that away.",
            "player|Goodbye...","com|photo-off","thC|......","spC|Well<> Mom... I won't let them do it...",
            "spC|$$$... and Primero!","spC|Now I know why Primero chose me. He just want to get me killed by Rufus Krieg!",
            "com|music-off_horror",
            "END"]

    }
    private static function t002():Array{
        return ["com|bg_BlackMarketScene","com|display_sao_casual1_center","spC|Hey buddy<> I want you to meet my new friends. Come here.","com|photo-on_CheatCouple","player|This is Bunny and Jim. ","player|Why don't we have a wild party tonight? The four of us... ","player|......","com|photo-off","spC|Oh come on<> $$$! Just chill for an hour or so! ","com|remove_sao_casual1_center#com|bg_HotelBgNight","player|At the end we went back to Sao's hotel room. Everyone got drunk except me. ","com|photo-on_CheatPhoto","player|Bunny and Jim started making out in front of us. ",
            "player|Sao: Let's join them!","player|...........","player|Have fun guys... I will go for a walk.","com|photo-off#com|display_sao_casual1_center","thC|......","spC|Fine! Later!",
            "com|music-on_rainfall","com|bg_Rain","player|It is raining very hard outside...","com|display_@@@_twin_center",
            "spC|Hey...","com|twin-photo-on_Rain@@@","player|@@@ is standing soaking wet in the rain...","player|Oh dear... what are you doing here?","player|I've been looking for you all night<> $$$.",
            "player|Why didn't you just call...","player|Oh shit... I just noticed my phone is dead.","player|I am... sorry<> @@@.","com|twin-photo-off","spC|It's alright. I finally found it...","com|music-off_rainfall",
            "com|photo-on_TempleCrystal","com|music-on_precioustime","player|@@@ shows me the black crystal ball I dropped at the water fountain...","com|photo-off","spC|It took me a little while...",
            "spC|But I think this is quite important for us... hehe.","player|I pull @@@ into my arms.","com|photo-on_Rain","player|Rain falls like it means to wash us away.","player|The gusting wind carrying it in wild vortices one moment and in diagonal sheets the next.",
            "player|As it runs down my face as a thin layer...","player|...I secretly make a promise to myself.","player|I won't be able to fix all problems<> but I will never let @@@ face them all alone.",
            "com|music-off_precioustime","END"]

    }
    private static function t003():Array{

        return ["com|bg_RestaurantScene#com|music-on_precioustime",
            "com|display_@@@_twin_center","spC|Hey... thanks for surprise. I am so not prepared.",
            "player|There is another surprise I want to give you tonight.","com|photo-on_LoveNecklace",
            "player|I showed @@@ a necklace I made. ",
            "player|I turned the black crystal ball into this necklace. ",
            "player|The black crystal ball is glowing in white light.","com|photo-off","spC|Oh my...","player|Let me help you.",
            "com|twin-photo-on_Love@@@",
            "player|The black crystal is now filled with our SOL<> Spirit of Love. ",
            "player|I think it is the best gift for @@@. ",
            "player|It looks perfect on you<> @@@!","player|......",
            "player|Will you marry me<> @@@?","player|Waaaa...",
            "com|twin-photo-off","com|remove_@@@_twin_center#com|display_@@@kiss_center",
            "player|@@@ nodded. We kissed. ","player|For a short moment<> we feel that our spirit energies are blended into one. ",
            "player|And they said only Twin Flames can perfectly combine their energies. ","player|Finally<> we've found the other half of the soul...",
            "player|It comes out from nowhere<> but suddenly<> I also have a bad feeling about this.","com|music-off_precioustime",
            "END"]
    }

}
}
