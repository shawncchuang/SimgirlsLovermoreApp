/**
 * Created by shawnhuang on 2016-01-15.
 */
package data {
public class TwinDAO {
    private static var access:Array=new Array();
    private static var container:Object={"t001":t001(),"t002":t002()};
    public static function switchTwinDAO(id:String) {

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

        return ["com|bg_RestaurantScene#com|music-on_precioustime",
            "com|display_@@@_twin_center","spC|Hey... thanks for surprise. I am so not prepared.",
            "player|There is another surprise I want to give you tonight.","com|photo-on_LoveNecklace",
            "player|I showed @@@ a necklace I made. ","player|Oh my Universe! I thought you dropped it at the fountain... ",
            "player|I found it. I just didn't tell you. And I turned it into this necklace. ",
            "player|The black crystal ball is glowing in white light.","player|Let me help you.",
            "com|photo-off#com|twin-photo-on_Love@@@",
            "player|The black crystal is now filled with our Spirit of Love. I think it is the best gift for you. ",
            "player|It looks perfect on you<> @@@!","player|......",
            "player|Will you marry me<> @@@?","player|Waaaa...",
            "com|twin-photo-off","com|remove_@@@_twin_center#com|display_@@@kiss_center",
            "player|@@@ nodded. We kissed. ","player|For a short moment<> we feel that our spirit energies are blended into one. ",
            "player|And they said only Twin Flames can perfectly combine their energies. ","player|Finally<> we've found the other half of the soul...",
            "player|It comes out from nowhere<> but suddenly<> I also have a bad feeling about this.",
            "END"]
    }

}
}
