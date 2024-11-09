extends Node

onready var animationplayer = $AnimationPlayer
export var nextscene = "res://src/levels/LevelTutorial1.tscn"


#maybe i should work on this later because i need to consider:
#* HOW MODULAR WILL THESE TYPE OF SCENE BE IN OTHER INSTANCES/USES
#* NUMBER OF SLIDE IMAGES AND DIALOGUE TEXTS
#* HOW LONG CERTAIN IMAGES STAY, SINCE THERE WILL ALWAYS BE MUCH MORE TEXT TO CHANGE
#* AND PROBABLY MORE

#DIALOGUE LINES/CHAR NAMES COULD AROUND 2 SECONDS

func _ready():
	animationplayer.play("intro cutscene")
	animationplayer.set_speed_scale(1.0)


func _process(_delta):
	if Input.is_action_just_pressed("kickball"):
		SceneManager.change_scene("level_transition_effect", nextscene)
	if Input.get_action_strength("interactcomp"):
		animationplayer.set_speed_scale(2.5)
	elif Input.get_action_strength("stellajump"):
		animationplayer.set_speed_scale(0.4)
	else:
		animationplayer.set_speed_scale(1.0)


func cutscene_over():
	SceneManager.change_scene("level_transition_effect", nextscene)

#POSSIBLE DIALOGUE FOR THE FOLLOWING CUTSCENES


#Cornelius: We're free!
#Taaf: This putrid torture is over!
#Marcus: Hahahahaha! Not this time!
#Maikouto: Feels good to be back, doesn't?
#Beatrice: My children, where have you been?
#Kalub: These mortals were the ones that saved you.
#Aliss: We couldn't interfere, though it seems the ritual wasn't prevending outsiders that were alive.
#Kalub: Speaking of, how may we repay you?
#Katrin: No need to, honestly. We must leave and return home.
#Kalub: Ís it so?... *gets closer to Oscar* (could be a seperate panel on his own)
#Beatrice: Kalub! What did I say about taking blood from living children like him?
#Kalub: There's something about his blood... it has a familiar smell.
#Beatrice: How so?
#Beatrice: I see.. you two... share some blood with me?
#Carrie: How? Are we related?
#Beatrice: My name is Beatrice Margareen, which is one of the few things I remember from my past life.
#Beatrice: During that life, I might've had a family that went on by generations without me.
#Carrie: Margareen is my grandma's surname. But she never told that much about past family members.
#Beatrice: Did my family forget about me? And if so... was it unintentionally?
#Carrie: Maybe I could talk with my grandma about it. And that is if we return home.
#Melvin: We will, Carrie. That's why we must go. Whether we see anyone here again comes later.
#Carrie: Okay. Well, we must go. Good bye.
#Beatrice: Farewell, children. Live well, for as we undead had our living memories taken from us.
#Marcus: Who knows... maybe there's good reasons why we forgot everything except our names.
#Taaf: Some day... we shall all know our lost truths... it'll come at a price.
#Maikouto: If so... I hope it doesn't shatter our group.
#Cornelius: There's the Vimana! We still got a long journey along the way.
#Nort part 9
#Angela: What's going on? Are we coming back to those places?
#Carrie: What if they were right? Reality is falling apart.
#??????: But these effects are temporary. Normalcy can be achieved once again.
#Katrin: Who are you.
#AB-YZ: A simple enough name for me is AB-YZ. My real name can't be translated by your translation device of Hirdrih.
#AB-YZ: I've been watching you ever since you got lost. Oscar even saw me under the from of a red crystal.
#AB-YZ: The device you've used to come across worlds is indeed causing issues, as entities and elements from different worlds are being dragged here.
#AB-YZ: If you recall what Zarina Liefdei said, your device is part of a bigger object: One that can do more than just allow travelling through realities.
#AB-YZ: However, what the group of 6 from universe 5353 said about "close universes hurting each other" is false.
#AB-YZ: It is a fabrication of one named Knoe. Entities from similar universes can coexist.
#Carrie: So those others will get us killed based on a lie? And what do you mean by universe 53.. whatever that number is?
#AB-YZ: In my language, numbers are more complicated but I used familiar ones to simplify things. Your universe is 5356.
#AB-YZ: I category universes with specific numbers during my travels. But a majority of them are disappearing due to an unknown threat.
#AB-YZ: Meanwhile, the current effects we are witnessing can be stopped by your actions. You need to find one more piece to gain full control of that device.
#Carrie: I have another question. What exactly is this world that looks like Nortubel?
#AB-YZ: Unfortunately, many answers could be truth: It could be built from dreams of the people of Nortubel as it could be a copycat dimension, either build by some entity or out of nowhere, with no true creator or rules.
#AB-YZ: Some parts could be created, others could be directly borrowed from your world. This phenomenon applies to other worlds, even those you've visited.


#Pete: Who is that guy? He looks alien... is he from...
#Tfoorie: ???
#Pete: Uh... you're not gonna hurt us are you?
#Tfoorie: No. None of you are worthy. I seek true fighters.
#Lahiurn soldier: What's this weapon? Is it from the future? Perhaps we can study its technolo-
#Grek Multigun: WARNING. SECURITY SYTEM ACTIVE!
#Lahiurn soldier: AAAARRGH!
#Joolietta on the phone: Marlou? Are you there? I told you it'd happen...
#Joolietta on the phone: Uh? What do you mean the artifact isn't doing anything? Then how come?
#Matysha: Rico, you see this?
#Ricotto: Yes. You think the world is ending?
#Matysha: I always had moments I felt that. Whatever it is, we should still fight for our survival.
#Ivan and Lahrn surrounded by Scorbrions
#Ivan: There's more to come. How many did you got so far?
#Lahrn: We're almost on the same score. But I'm getting sick of these creatures. There has to be some other pest woth exterminating.
#Maikouto: You boys were obviously distracted. I got the highest score.
#Krahq: Hey boss.. see the look of those freaks? Even I wanna get dirty on them.
#Bullet: Oohhh, Krahq, I'm feeling it... but I have a suspicion these might be a little difficult to handle. i don't wanna take any chances this time.
#Lomeshtin: My beautiful city... this can't be happening!!!
#Grek soldier: Sir, we're being attacked by unidentified beings. Should be fight back?
#Simo: Don't worry... I believe one of our best is already taking good care of this... 
#Galaghar: Hm. Whatever it is, I don't think Lakk could pull this off.
#Reptile: I wonder if this has anything to do with that guy cut in half from the other day.
#Avietta: I think Leon and Otto might want to know what's goin on.
#Hangelica: Not yet... the end of times will not arrive soon...
#Odin: Hope you learned your lesson. This better theaches you to-
#Shotgun and reload sound
#Odin: AH- WHAT THE-
#Booker: These guys never learn, kid! Just make sure other punks watched and they get the idea.
#Bonky: Hello lady. You look pretty cute. Are you a goblin?
#Pebble: Goblin? What's that? It's pronounced "Ghalbeen". Where did you get "Goblin" from?
#Leon: Um? Somethings going on with those 2. Seems their world has strange color related anomalies.
#Leon: Wait, that clown... 


#Alt Angela: Oh... it's you... what do you want?
#Carrie: Same thing as you... and what happened to your box?
#Alt Angela: It seemingly stopped working. Perhaps its power ran out like any machine would.
#Carrie: You sure it's not because it could have flaws... like ours has?
#Alt Angela: It's not our box that's causing what's happening around us. And like I said... we were here first.
#Carrie: So... you still believe that nonsense?
#Alt Angela: I don't want to... but if it means our lives are at risk, then we have no choice.
#AB-YZ: You must be from the other group. I must inform you tha-a-a-a-a-a-a-a-
#Katrin: ABYZ!!!!
#Knoe: Cease!
#Alt Oscar: Knoe warned us about these oddities. He says their mere existence causes holes in reality.
#Angela: Look... what is that?
#Melvin: It looks like a portal... but it's different from the others.
#Alt Pete: It could be coming from a more stable device. Better than either of ours.
#Alt Katrin: And it's closing.
#Alt Angela: We better run... how about one last race, "brother"?
#Melvin: Everyone, stay close. We gotta make sure all of us get there!
#Mevlin: We've been through a lot and I promise this time.. we'll also go through this.
#Melvin: Maybe we can see our families again.
#Pete: But we're not sure what's in that portal... is it really home?
#Melvin: We don't know for sure... but we might as well try.

#NOTE: Part where Leon uses his powers and there's an arrow and computer UI related stuff
#Melvin: Come on, everyone, we're getting close.
#Melvin: Angela, grab my hand!
#Carrie: Oscar, grab mine.
#Katrin: Pete!
#Bonka: Everybody, grab these! (Bonka shows up with some rope ladders)
#Carrie: Bonka? HOLD ON!
#the portal closes, the characters fall to some place and seperate from the other 6
#Melvin: Unf, is everyone okay?
#Carrie: Yes, but... we failed!
#Melvin: THE BOX! IT'S BROKEN!
#Bonka: *start crying* NOOOO, THIS CAN'T BE HAPPENING!
#Bonka: I'm sorry! I wanted to help but... why didn't it work?
#Bonka: I finally did something good for once but in the end, it didn't work out.
#Katrin: Bonka...
#Bonka: I just wanted to make fun of people, you know... I never meant to hurt anybody... 
#Carrie: You know what? I actually believe you know. It wasn't you who tried getting us killed. According to a lady named Claudia, it could be someone named Bonkette.
#Bonka: Claudia? I think I heard of that name... 
#Carrie: But she might be from a different version of your world... like how those other kids are from a universe similar to ours...
#Bonka: And they will outlive you because of me... I'm sorry.
#Carrie: Bonka, it's alright... I forgive you... and I'm also sorry.
#Carrie: Guys? I love you all.
#Katrin: I love you too Carrie. And as much as I love Mel.
#Melvin: I love you both too... I really can't choose.
#Carrie: Oscar, you know you're the most precious thing in my life. Even if we never see our parents again, we have each other.
#Katrin: And Pete, you know I'd say the same about you. 
#Melvin: It's why we ran from home, Angela. We always had the feeling we'd be away from our parents sooner than expected. But we got each other.
#Pete: You know what? I may never know who my real dad is... but maybe I don't need to. I'm glad I live, so I could be with you all. Specially you Kat.
#Angela: I never got to see mom... but I at least have you, Mel.
#Oscar: Carrie, you're the best. Even if we also never see Grandma again... I hope I still have you.
#Pete: Oscar, Angela... I'm glad we got to meet even if any of our dreams for the future are gone now...
#Angela: Me too... I don't think I've appreciated our friendship enough...
#the group hugs
#something breaks, the group notices something... a silhouette of a familiar figure
#Yiegour: B-Man to Grek base... found the "Nortubese" kids... and the girl Leon talked about.
#Carrie: MISTER YIEGOUR! LEON?
#Leon: HELLO WORLD! Sadly, my brother isn't here with me but he's also helping with this situation.
#Leon: He even kept giving people translation devices without them even knowing. At least people could have a chance to understand each other in a rather confusing situation.
#Katrin: How did you found us?
#Leon: It's that box of yours! Portals kept showing up and we got access to some places that you've visited.
#Leon: But believe it or not, Bonka once stepped into our world for a short period of time... and she didn't notice but I put in a translation device in her pocket, just in case she'd stumble to someone with different languages.
#Bonka: Is that why I got to understand what these guys were saying? 
#Melvin: How didn't you notice you had a strange object in your pocket?
#Bonka: I sometimes don't take off my clothes. *sniff* Now I smell worse than Bonky.
#Leon: Though another piece of information worth bringing up: I got in contact with Carrie and Oscar's Grandmother. This time, there's a chance for all of you to return.
#Yiegour: Not only that, this little guy says even other universes can be fixed and we've already helped some people.
#Yiegour: But in other cases, we also faced challenges... and you all might know how I fixed some.
#Leon: Though you still haven't killed or found that alien you kept talking about. In any case, we better get going.


#HERE'S THE OTHER CUTSCENE
#the 9 go to a journey and find a portal to Nortubel
#Carrie: This looks like home... you guys wanna come?
#Leon: I wouldn't mind... what about you 2?
#Bonka: Sure, maybe Nortubel can't be that bad of a place as I said it was.
#Yiegour: Maybe next time. I have work to do. Besides, I've met an amazing woman.
#Katrin: That's nice, mister Sarvotsky. What's her name?
#Yiegour: She's a tall, gorgeous powerfull warrior. Doesn't seem to be human but she's close enough.
#Katrin: ...is her name Uulga?
#Yiegour: She talked about you. Even hopes to see you again... and so do I.
#he leaves.
#Oscar: Grandma!
#Pamela: Oscar! Carrie! (they hug)
#Stella: Kat! Pete!
#Bernard: Melvin! Angela! Welcome back!
#Shelly: It's so good to see you.
#Zarina: We're glad you're all safe.
#Shihiro: We never lost hope.
#Bao Bao: Arf Arf!
#Carrie: Oh and by the way. This is Bonka and Leon.
#Leon: Hello world! I'm from Hirdrih, a world of robots.
#Bonka: And I'm from Brinkaedea. I'm a clown... an actual clown...
#Stella: How about we introduce our place to you? There's a lot of nice stuff here.
#Leon: That'd be nice, because we hope to show you stuff from our worlds too.
#Pamela: Carrie, you know we're going to have to talk about your parents. Even your friends' parents.
#Carrie: I know, there's stuff to take care of, right?
#Pamela: But I know you kids went through a lot. So we could leave that for another occasion.
#Pamela: First, we should celebrate your return home.
#at a small party
#Katrin: The food here is nice.
#Oscar: Yeah, I'm glad I get to eat something cool.
#Katrin: Well, it's not like Nortubese food itself is bad...
#Carrie: That reminds me. Stella, did you have any issues with Booker's language?
#Stella: Kinda but his country was a bit similar to one in our world. Even my language reminded him of a country from his world.
#Stella: He told me this story about that place being affected by a horrible plague where people were covered in gold and went crazy.
#Carrie: Really? Guess there's more to Krimb-stone than I thought.
#Bonka: Not bad, this Nortubel place. Though someone already got to that cake before I did.
#Leon: If you want, I could bring you to your world so you can take some candy there and bring it here. In fact, I could even invite more people.
#Bonka: Why didn't you say that before? 
#Leon: I was busy enjoying the party. It's not like it'll end soon.
#Bonka: Yeah, you're right.
#Pete: Oscar, feels good to be home, doesn't it.
#Oscar: Yes! Hey Angela, wanna play hide and seek?
#Angela: Sure, but can Pete be the one looking? He always picks the weirdest hiding places.
#Melvin: So, how you girls feel abo-
#the 2 both kiss Mel's face
#Melvin: I... uh.. Thanks
#Carrie: Mel, like you said: Nobody wants to choose. Ain't that right Ka-
#Katrin kisses Carrie
#Carrie: Kat! Your mouth is full!
#Katrin: NOM oops, sorry... did some bits of food got into your mouth... I wanna see
#Carrie: Kat... come on...
#Melvin: After all of those places we've been, I wonder if we could see them again. Yiegour, Uulga, Booker, Kalub, Holmes... how are they doing?
#Melvin: In fact, what about those 6?
#Pamela: Mel? I just wanted to tell you that we've fixed the box. But we're keeping it in a safe place for now.
#Melvin: Alright. I get why. Now that I'm home again, I should take a break from going to all these places.... maybe next time.
#meanwhile in a strange place, the alt 6 are in a boat
#Alt Melvin with a telescope: Look there, I see something.
#Alt Angela: That's a ship, we need to get close.
#the ship opens up and with its advanced tech, picks up the group
#Alt Carrie: We're inside. Wow, it looks huge...
#Alt Oscar: Look at this stuff... is it from the future?
#Someone: Welcome aboard. 
#Said someone is using his hands on holographic screens
#Alt Pete: Thanks, sir but... why did you save us?
#Someone: Because we have important thigns to do... I know who you are...
#Alt Angela: Who are you, mister?
#Someone: You can call me Yiegour Sarvotsky.
#one of his holographic screens shows our main Yiegour listed as a potential target for this Yiegour



