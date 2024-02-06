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

#Stella: We made it!
#Carrie: Feels weird that we took the lives of others, even if they were bad people.
#Stella: Well, I felt the same way. Even I still feel weird about it.
#Katrin: Booker, are you alright?
#Booker: I got almost all of them... except for that coward Phineas. Of course he ran away.
#Booker: Unfortunately, this once abandoned warehouse got compromised. Need to find a new place again.
#Melvin: By the way, Stella, we could get you out of here.
#Melvin: See this box? It's how we got here and it could get us out!
#A portal shows up.
#Stella: So this must be the same box from before.
#Stella: Will we go back to Nortubel?
#Pete: It looks like Nortubel but it's a weird place.
#Oscar: Yeah, there's flying buildings and giant geckos.
#Melvin: But Carrie's grandma could be getting close to take us back home!
#Stella: Well, if that's what you say...
#Booker: You should go.
#Stella: Booker, but why?
#Booker: Girl, I can still you're still not used to this Hellscape and maybe it's for the best.
#Booker: If you get to used to things here, you might lose it and stumble upon a worse fate than death.
#Booker: Even I wonder if it could happen to me, but you have a chance to return to a better place.
#Stella: Is it wrong that I hope to see you again?
#Booker: I warned you not to love me too much... but you did bring back a part of me I thought died years ago.
#(Shows animatedsprite of flashbacks to Booker's past
#Booker: Somewhere in heaven, a man could rejoin his loved ones... had he not became a shadow participating on a war against demons.
#Stella: Well, I'll miss you Booker. Thank you for everything.
#She leaves with the 6 others.
#Booker: Maybe if Veronica was still alive, you 2 could be friends. In fact, she could have been much older. How time passes...
#Booker: Where was i?
#Booker returns to his base, while Benjamin is tied to a chair. Booker prepares for a violent interrogation.
#Meanwhile at Nortubel
#Stella: What happened to our home?
#Katrin: We're not even sure if it is Nortubel. For what we know, this could be a world someone created based on our home.
#Zarina: But it's not just your country that has its own copy dimensions.
#Katrin: Who are you, miss?
#Zarina: My name is Zarina Liefdei and I'm a sorceress from Auliswaria, but I moved to Nortubel some time.
#Oscar: Are you lost like us, miss?
#Zarina: At first I thought I wasn't, but it seems my powers aren't working as of now.
#Carrie: I recognize you. You've met my grandma before, right?
#Zarina: I'm a friend of Pamela and I heard she's trying to you all back home.
#Melvin: That's true. We also got this magic box that bring us to other worlds.
#Angela: We got to meet robots and a guy that kills bad people.
#Zarina: I've heard of such device. You can unlock new worlds if you find its missing pieces, specially when you consider the rotation of each knob.
#Zarina: But even then, there could be more to that box that is missing.


#Oscar: Look at that animal, he looks cute.
#Carrie: Oscar be carefull.
#Oscar: But he's not hurting me, he just wants to play.
#Katrin: But what is he? He looks like a lion and a dog mixed together.
#???: That's a guardian lion. He's friendly but he's also a great fighter.
#Zarina: I had a feeling I'd find you again, Shihiro.
#Shihiro: So far, there's no exit to this strange world but I managed to built a place of my own. Took a while but I believe what I came up with can handle at least ten people.
#Zarina: Really? That's great to hear. 2 of these kids are Pamela's grandchildren and they've been on their own journey to return home.
#Melvin: Mister Shihiro, my name's Melvin and a while back, we found this weird object that allowed us to go through different worlds.
#Katrin: And miss Zarina even said the object might be incomplete, as if there could be more to it.
#Shihiro: Yes, I've heard of this. A few missing pieces for the holes in each knob. But this box itself could've been attached to something bigger.
#Shihiro: We're still not sure what it is, though.
#Pete: Sir, miss Zarina said she was a sorceress. Are you a sorcerer too?
#Shihiro: I've got powers too, specially related to combat. And I also teach martial arts and help those practice their combat skills, even if they don't have powers themselves.
#(Shows an animation of a muscular Shihiro with purple energy)
#Carrie: Well, we managed to get around by what we got. Melvin brought a knife with him.
#Panel showing Melvin's knife
#Shihiro:  I see. If you don't mind, I'd like to test your combat skills.


#Shihiro: Not bad, I knew you got something in you.
#Melvin: Really? I feel tired already!
#Melvin: It's been a while, any of you wanna try another trip with this thing?
#Katrin: Sure, Stella you wanna come along?
#Stella: Not really, I'd rather stay here with Zarina.
#Stella: But promise me you'll be safe.
#Katrin: Don't worry, I'm sure the next place we could visit could be safe.
#Holmes: So... you still haven't got word about your husband?
#Fernaanda: No. At this point I'm losing hope.
#The 6 show up
#Holmes: Uh, who are you people?
#Oscar: Wow look, a talking cat.
#Holmes: Something's off about these kids. What are they?
#Barney: I knew it! My theory was true. There is such thing as a multiverse!
#Barney: And there is something weird about these 6 specimen.
#Carrie: We're humans, a civilized species from Earth.
#Melvin: In our world, humans are technically a relative to monkeys.
#Barney: How is it you know what a monkey is? And why did that boy called Holmes a cat?
#Pete: Our world has animals of all sorts. Some kinda look like you guys.
#Barney: Mmmm, this is wonderfull. A different universe that might have its own diverse ecosystem.
#Holmes: Well, what brings you kids here anyway?
#Katrin: We've been travelling through different worlds in hopes to find our home. But so far, we're still lost.
#Holmes: Well, the good news is that Massag-Coav is a wonderfull place, I'm sure you guys can find a lot of fun to be had here.
#Fernaanda: Holmes, didn't you see the news lately? There was a crysis at the zoo and some animals escaped.
#Holmes: C'mon, Fern. There can't be that many.
#Feelix: Mom, can I play with these new kids?
#Angela: Why do you wear that thing, anyway?
#Feelix: I was born with one eye. My mom has 2 eyes but they got worse over time, so she wears something to retain her vision.
#Fernaanda: Well if you kids treat my son nicely, I could make something for you all like a cake. But it can't be chocolate.
#Holmes: But for now, let us introduce our world to these 6 guests, shall we?

#Melvin: By the way, you guys have that sports center, right? Is soccer a thing there?
#Holmes: I guess. Better ask Karla about it.
#Karla: Uh? Sure, you guys can have fun here. Just make sure to sign your name here... and here... and...
#Touni: I almost forgot we had a soccer division. Interest has been down lately, but this is why we welcome new blood in the first place.
#Karoline: Dad, do you and mom have any idea what these people are?
#Touni: Dr Barney said they're "humans" and in their world, could be related to monkeys. If that's true, they can't be that out of the ordinary.

#Cheerleaders: WOOOOOW!
#Karla: Maybe it's because we haven't seen any soccer action in years but you did good.
#Carrie: Well, Mel, you did enough to show off your kicks. Can we go home now?
#Melvin: Alright, carrot. Let me just say good bye first.
#McSherry: Holmes? Where the Hell were ya?
#Holmes: Oh hey, McSher, looking for another bottle of whiskey?
#McSherry: No, you idiot! I need to tell you something. It's about Marlon.
#Holmes: Marlon Valentinou? What has he been up to? (Shows an image of Marlon)
#McSherry: Heard he was looking for some artifacts. Something to do with the god Mluto. (Image of Mluto)
#Holmes: Has he gone mad?
#Barney: I know exactly what he's looking for.
#Barney: And I think I know who could also be involved.
#Later
#Carrie: Sometimes, this place doesn't seem bad. There's still things we're familiar with.
#Katrin: That place looks like a beach. And in that direction, there's a clothes shop.
#Katrin: Maybe we could try and have fun here, while nothing happens. After all, it didn't took too long to find Stella and someone your grandma knows.
#Carrie: Sure. How about you Mel?
#Melvin: Might as well tell the others.


#Carrie: So, what have you guys been up to?
#Alt Angela: We've wanted to show you a friend we've made in a while. We call her Amalia
#Amalia hsows up
#Katrin: What is that? Is that a house?
#Alt Angela: It's alive.
#Stella: HELP!!!
#Katrin: STELLA! WE GOTTA DO SOMETHING!

#Shihiro helps defeat Amalia
#Pete: Stella, are you okay?
#Stella: Mmmm
#Zarina: I'll take care of her. With enough time, her injuries will heal.
#Melvin: WHAT IS WRONG WITH YOU GUYS?
#Alt Carrie: IT'S YOUR FRIEND'S FAULT. AMALIA WAS CALM AND YOUR FRIEND PROBABLY SCARED HER.
#Alt Katrin: AND NOW SHE'S GONE BECAUSE OF YOU.
#Alt Angela: I know what it is. We've been here longer than your group, so you don't really undestand how things work here.
#Melvin: And maybe I don't want to. This place might've been driving you mad and that's why we wanna go home in the first place.
#Some time later
#Stella: I'm better now. I didn't know those guys were different versions of you.
#Carrie: And we're probably not gonna be in good terms any longer.
#Carrie: Mel, should we continue exploring places?
#Melvin: It seems everyone's fine now, so sure!
#Portal shows Grek:
#Isaac: Wait, I'm detacting something. A portal but it's not from my machine!
#Katrin: What place is this? The air feels so...
#Clarity: FREEZE, I MUST DO A QUICK ANALYSIS.... NO SIGNS OF RADIATION FOUND
#Clarity's screen with info shows up
#Clarity: Excuse me, my name is Clarity and this is the Greklovick Mercenary Force's Headquaters. The year is 2219.
#Oscar: What kind of place is this?
#Yiegour: Here at the Grek base, we do all sorts of well armed works. Hence we rival even the main Grek army and police forces.
#Yiegour: Name's Yiegour Sarvotsky, but some friends call me "B-Man".
#Yiegour: Feel free to explore this place but do be carefull. Lot of things around here are designed to kill and some security systems are activated.

#Carrie: The air keeps getting worse.
#Grek police: Hold still, I need your ID's.
#Melvin: But we don't have any.
#Grek police: So you're trespassing? Then come with me quick before I-
#Yiegour: Let them go! They're under my custody.
#Grek police: Yiegour? Mh, sure.
#Pete: Are you mad at us for going too far?
#Yiegour: I'm rather impressed. Somehow you're still alive. 
#Some time later
#Yiegour: And what's in your mind?
#Melvin: I'm just thinking about my dad and all. We've all been having some family trouble and it's why we ran from home, but now we're trying to get back.
#Yiegour: I've had my family troubles too. And it was Hell. My older brother couldn't take it anymore, so he found a quick way out.
#Yiegour: And my old man barely loved me. My mother died when I was born. After my brother's death, I ended up confronting my father and it was the first time I ever pulled a trigger.
#Yiegour: Ran from home and didn't took long enough before Qubritz gave me a different life.
#Yiegour: He says I've became his best man in the field. That can be either good or bad news depending on how you look at it. But-
#Something happens.
#Yiegour: CLARITY WHAT'S GOING ON?
#Shows Yiegour's face with HUD/UI
#Clarity shows up in AI FORM
#Clarity: Someone's attacking the base. It must be Zharkovil. I'm fine and so are Bolt and Isaac but some of the mercs aren't responding.
#Yiegour: I need to know what happened to those 6 kids.
#The 6 are shown somewhat lost and they spot a device beeping, Melvin picks it up
#Melvin: Who is this?
#Yiegour: MELVIN, IS THAT YOU? LISTEN, OUR BASE IS UNDER ATTACK BY ZHARKOVIL. HE'S THE FAT COMMANDER HOVERING WITH A CHAINGUN.
#Zharkovil: BURN, ALL OF YOU! I'LL BRING THIS WHOLE BASE TO HELL!
#Yiegour: According to Clarity, he's using an energy shield but you can destroy the machines generating it.
#Yiegour: Find the shield generators and smash them! While his shield is down, I can attack him. But it may not last that long.
#Clarity: YOU MAY HAVE TO TURN OFF THE GENERATORS FROM TIME TO TIME. EVEN WITHOUT HIS SHIELD, ZHARKOVIL MAY TAKE A WHILE TO BE ELEMINATED.

#Yiegour: This is B-Man, Zharkovil has been elimated. And I didn't do it alone.
#Zharkovil: Grrr glargh...  Curse you... Greks...
#Yiegour: You kids did good. Thanks.I know you're not used to this and I promise you won't do it again.
#Katrin: We've been through some trouble before but you're welcome. 
#Some time later, Yiegour interacts with holographic UI
#Yiegour: And here and... GRR wrong button again! I hate these things. Clarity, can you help me out?
#Clairty: Sure.
#Bolt: Your hat looks dirty, would you mind that I clean it off?
#Angela: I can do that later.
#Isaac: Alright, I think I've seen enough of this artifact, so I'll give it back to you.
#Melvin: Was nice meeting you, mister Sarvotsky. Bye.
#Yiegour: Have a pleasant joutney.
#Sergei: Yiegour, we got some bad news at the Venus station. One of the specimen escaped containment.
#Sergei: 15 of the crew there was killed and 19 were injured. We have footage of the specimen
#Shows Tfoorie.
#Yiegour: On my way.
#Back at Nortubel
#Shihiro: So, why did you ran from home?
#Carrie: In my case, I had a terrible arguement with my mom and I took Oscar with me. It's because she thought dad was cheating on her.
#Carrie: My dad played guitar in a band and he was popular in the town. I never believed he'd hit on other women.
#Melvin: I always had a complicated relationship with my dad. Even to this day, he blames himself for what happened to mom.
#Melvin: Last time I saw him, he was in his chair, looking really tired, with a bottle on the floor. Like he was attempting suicide.
#Melvin: So I took Angela with me in case he'd be too late to save him.
#Katrin: Both my parents were fine but it's my uncle that made things rough. Truth is that he might be Pete's real father, so Pete would be both Stella's and my half-brother.
#Katrin: At some point, my uncle started to threatnen my parents and it was my dad so told me to take Pete and run to a safer place.
#Katrin: It makes sense why Stella liked Booker so much. I guess he was a better father figure and he was once a father too
#Shows image of Booker, with no black/white colors because no character is aware of that except maybe Leon/Otto, so they address that part of Krimb-Stone as an anomaly
