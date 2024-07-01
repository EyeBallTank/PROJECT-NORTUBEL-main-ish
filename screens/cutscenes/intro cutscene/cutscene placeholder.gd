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

#Carrie: Help, somebody!
#Bonka: WHY IS THIS HAPPENING?
#Odin shows up
#Odin: Now, for a special trick...
#Something happens
#Oscar: We're safe!
#Odin: Bonka, what happened? I thought you wouldn't reach this low!
#Bonka: Odin, I can explained. This wasn't part of the plan? BONKY, WHERE ARE YOU?
#Bonky: Uh, what's going on? I was taking a nap.
#Bonka: You idiot! Don't tell me you slept when I told you to take care of things while I was gone.
#Bonky: ... uuhh... oi, ya know how easy it is for me to get sleepy and-
#Linda: Puff? You're still working for her? Don't you have anything better to do?
#Bonky: Sister, I uh... well, I had that new carrot cake recipy I wanted to try.
#Bonka: Listen, all I wanted to do was humiliate you. I didn't meant to actually hurt you-
#Carrie: THAT'S IT! WE'RE DONE HERE! EVERYONE, LET'S GO!
#Bonky: WAIT, I almost forgot! I did see someone show up in the construction.
#Bonky: I thought it was Bonka but she looked different: She was kinda bald and looked a bit scary.
#Bonky: And I saw 2 kids with her, they looked like Monica and illou but Monica had a pointy tooth and illou was dressed like a scientist.
#Melvin: You mean, like versions of Bonka and those 2 kids from a different universe? Because we also stumbled upon our own doubles.
#Bonka: Maybe that's what happened. Maybe someone that looked like me infiltrated my plan and did this.
#Carrie: I don't care ("Estou me nas tintas"), I wanna leave this place.
#The 6 leave
#Bonka: You gotta believe me... 
#Bonky: Don't worry Bonka, I believe you.
#Odin: Honestly, I believe you too. After all, I believe that beneath a trouble maker clown like you, there's someone that just needs help.
#Odin: But duty is calling me, so I gotta go.
#Odin leave
#Bonka: Grrr Odin, you cheesy, pretentious, annoying...
#Bonka: Big, strong, charming... GAAAHH! ewww
#3 characters were watching all along, behind the bushes
#Bonkette: Well, there goes our plan. Nobody died and we were noticed.
#Monika: Well at least we were only seen by that stupid bunny.
#Dr Ill-Ow: But even the magician superhero believes it and if he believes it, more people will be aware.
#Dr Ill-ow: We better do something about it.
#Bonkette: I'm tired of being in the shadows. Maybe I should face Bonka face to face and turn her world upside down.
#Monika: Yeah. More fun that way.
#Bonkoid: Um, what are you guys talking about? I didn't see anything.
#Back at Nortubel
#Angela: Look at that old lady, is she lost?
#Katrin: Excuse me, but who are you, miss?
#Claudia: My name is Claudia Santamara. I deliver presents to those who are well behaved.
#Claudia: I've been travelling through different worlds ever since I've left Brinkaedea, which unfortunately was destroyed.
#Carrie: But we've left Brinkaedea a short while ago. And we've had to put up with an annoying clown named Bonka.
#Cladia: I don't know who "Bonka" is, but I've met a girl named Bonkette and she is so much trouble. Perhaps, there is another Brinkaedea I've never heard of.
#Carrie: Maybe Bonka is right...
#don't know what else to add

#Claudia: You all behaved nicely, I believe I owe you some presents.
#Melvin: Thank you mam, but the only thing we need is a way back home.
#Melvin shows the box
#Claudia: I see. In fact, I am correct that I owe you all something.
#She gives them a white piece.
#Claudia, now I must go. Perhaps we may meet again.
#She leaves
#Melvin: This piece fits one of these wholes.
#And then a portal to Lahiurn shows up
#The 6 watch planes and explosions, then they overheard a conversation
#Gustav: You know the way out?
#Jerold: We can just keep going North and we'll find the sub base. There has to be some submarines left.
#Jerold: But we must be carefull. I heard they're using a recent prototype of a weapon in this fight.
#Gustav: What kind of weapon?
#Jerold: I heard they were experimenting with bodies of prisoners and turning them into machines. As if they were creating blind followers out of carcasses.

#Carrie: Are we getting somewhere?
#Melvin: We gotta keep going. This whole has some light at the other end. Uh?
#Buellarock soldier: Hold it there? Who do you work for?
#Melvin: Wait, we can explain.
#Some time later
#Charles: Alright, let's get this started. Who do you work for? And what orders did they gave you?
#Katrin: Nobody, we're just finding our way home. We're not even from this universe.
#Buellarock soldier: Sir, we examined some of their stuff but find no clue of any ties to either Lahiurn or Eygzouhl.
#Charles: What country are they from? Any document in any language someone might recognize?
#Soldier: We found some books in this weird language. I thought I recognize the language but they don't seem to be from Dahrgrinde.
#Charles: Maybe the "blue" girl is right. What kinda God made you kids?
#Melvin: We're not even sure. We were in a threehouse and then were brought to a weird place that only looked like our home.
#Melvin: We even saw a girl that came from a different universe and then we found this box and it brought us to different worlds. Including this one.
#Charles: Alright, I'm trying to make sense of this. How did you brats even get to our base? For how long were you in world?
#Carrie: At first, we were in a battlefield full of soldiers dressed in either blue or yellow. But we heard a conversation of 2 guys wanting to escape and they said something about submarines.
#Carrie: We managed to get to a submarine but Melvin accidently touched something and the submarine moved to a place close to a city.
#Carrie: And the city had so many cameras and security, we were only lucky because we stumbled upon someone's book with hints of hidden routes.
#Jerold: That notebook could be my mother's. Something must have happened to her.
#Angela: You're the man we saw in the war.
#Pete: I guess we gotta thank you for how we got here.
#Gustav: I don't feel proud that anyone heard our talk in the first place. It means we gotta be more carefull.
#Oscar: We also found this thing (Shows golden book)
#Charles: Wait a second, gimme that. Do you know how big this is? We might have confidential information here.
#Jerold: Cpt Kendery, I can help you translate some of those documents. Just give me some time and I can do it.
#Charles: Sure thing. Anyway, how can we tank you kids?
#Carrie: Just let us go home! Give us some space and we can open a portal with the device, so we can leave.
#Charles: Alright, go ahead and show me... Jesus Christ! *portal closes*
#Charles: I must admit. I feel jealous, but we have things to focus on. Maybe those Laihurn freaks might've something similar with their technology, who knows.
#Gustav: You believe your mother's still alive?
#Jerold: I hope she is, after losing Rosetta. If not, I'll get to Lomeshtin and kill him myself.
#Back at Nortubel
#Oscar: Someone seems lost, what's with the big suit?
#Melvin: Looks like a diver. Hello, who are you?
#takes off helmet
#Namylea: Hello, my name is Namylea Matdur and I'm an reporter and explorer.
#Namylea: I'm from Dahrgrinde and am part of an organization whose works relate to history, science and archeology.
#Carrie: How did you get here?
#Namylea: A blue portal showed up and, due to my curiosity, I simply walked through it.
#Katrin: It might be from this device we use to travel through worlds. Maybe we could help you get back home.
#Melvin: I remember the combination to her place, but we're never sure exactly where it takes us. For what we know, we could end up back in that battlefield.
#Namylea: Either way, I at least have an opportunity to explore this place.

#Namylea: Who are those kids there? Do you know them? They look like you.
#Carrie: They're like us but different... things didn't work out between our group and theirs.
#Katrin: They look like they're talking about something.
#Melvin: Does it really matter? We don't have much do to with them anyway.
#Namylea: And what about those dolls?
#Carrie: What dolls? Huh? They look like us.. but how?
#Namylea: In fact, one even looks like me... are we being watched?
#Pete: It gets weirder, some look like people we've met before.
#Angela: Yeah, that one looks like the blue cat.
#Oscar: And I see mister Yiegour over there.
#Namylea: Well, let me test something.
#Melvin: OUCH, did something-
#Namylea: My suspicion was correct. These are voodoo dolls.
#Namylea: I remember interviewing someone from a tribe that made such dolls.
#Namylea: According to him, a way to make sure these dolls won't affect you any longer is to protect them.
#Carrie: How do we do that? Is it just a matter of not hurting the dolls directly?
#Namylea: More than that. If means preventing something else from attacking it.
#Katrin: This place tends to have weird monsters, does that mean we gotta stop them from hurting the dolls?
#Namylea: Could be. If you prevent those monsters from attacking the dolls, maybe the dolls will no longer be connected to you.

#Namylea: It seems the dolls aren't active anymore. We could be safe now.
#Melvin: By the way, I reconfigered this device back to your place. At least I hope I did it.
#Namylea: No, you got it right! Thank you all. it was a great honor being here with you kids.
#Namylea leaves
#Melvin: Anyway, going back to our journey.
#Melvin: Looks like some kinda forest.
#Carrie: What's with the floor?
#Pete: I think it's a bunch of tree branches.
#Tree branches break, characters fall
#Everyone: Aaaaaah!
#Weird vines show up
#Katrin: We're safe!
#Ivan: Are you alright?
#Katrin: Ooh, uh... yes, thank you!
#Ivan: I hope so, it'd be a tragedy if a princess were to even get such a small injury in this place.
#Melvin: Who is this jerk?
#Ivan: My name is Ivan Ros, the prince of Tsuvookut.
#Pebble: Oh, hello there Ivan. Who are these people and why are their ears small?
#Oscar: Our ears aren't small, why are yours big? And your arms too.
#Pebble: I'm a Ghalbeen. You're in the country of Herrko and this is our village.
#Carrie: We came from a different world. We're trying to find our way home.
#Pebble: Well, I'm not sure if I can help you with that.
#Katrin: It's okay, you don't have to help. Least we can do is explore this place before we go back to the main focus.

#Euloria: Who are these kids and how did they get there? Do you know how grave of a crime it is to trespass in my castle?
#Dirlindu: Don't raise that ire any longer, Euloria. I can see these young travellers are looking for something.
#Dirlindu: In fact, I believe it's a piece made for that artifact they seek.
#Dirlindu: Somewhere in that island, there lays a strange white object, made only for that artifact.
#Melvin: You know about this box? And where is that island?
#Dirlindu: The island is a long way from here and many travellers did not return.
#Dirlindu: Some say the island drove many of once strong warriors of Herrko mad. With knowledge.
#Uulga: I'll take them there.
#Dirlindu: You may suffer the same fate as the others, my dear. There might be an awful truth lying in that place.. and I only know half of it.
#Uulga: Those men were driven mad because they came with the intention of searching for a dark secret.
#Uulga: But this is not about that. It is about these 6 kids wanting to return home.
#Uulga: I just have to ignore the path that all the others took and I could be safe.
#Uulga: Besides, none of those men were confirmed to be an Horg. I could be the first of my species to get there.
#Dirlindu: Indeed, but you're still at risk. Even if these kids are not as strong as you here, there will be a good reason why they won't suffer that safe.
#Pebble: Uulga, please be safe!
#Uulga: Don't worry, Pebble. I'll come back safely. Now, you 6 come with me.

