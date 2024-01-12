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

#Karla: Maybe it's because we haven't seen any soccer action in years but you did good.
#Carrie: Well, Mel, you did enough to show off your kicks. Can we go home now?
#Melvin: Alright, carrot. Let me just say good bye first.
#McSherry: Holmes? Where the heck are ya?
#Holmes: Oh hey, McSher, looking for another bottle of whiskey?
#McSherry: No, you idiot! I need to tell you something. It's about Marlon.
#Holmes: Marlon Valentinou? What has he been up to? (Shows an image of Marlon)
#McSherry: Heard he was looking for some artifacts. Something to do with the god Mluto.
#Holmes: Has he gone mad?
#Barney: 

