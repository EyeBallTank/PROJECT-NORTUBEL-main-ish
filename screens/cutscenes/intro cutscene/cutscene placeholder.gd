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

func _process(_delta):
	if Input.is_action_just_pressed("kickball"):
		SceneManager.change_scene("level_transition_effect", nextscene)

func cutscene_over():
	SceneManager.change_scene("level_transition_effect", nextscene)

#POSSIBLE DIALOGUE FOR THE FOLLOWING CUTSCENES

#Stella: We made it!
#Carrie: Feels weird that we took the lives of others, even if they were bad people.
#Stella: Well, I felt the same way. Even I still feel weird about it.
#Katrin: Booker, are you alright?
#Booker: I got almost all of them... except for that coward Phineas. Of course he ran away.
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
#Katrin: But what is he? He looks like he has a human nose.
#???: That's a guardian lion. He's friendly but he's also a great fighter.
#Zarina: I had a feeling I'd find you again, Shihiro.
#Shihiro: So far, there's no exit to this strange world but I managed to built a place of my own. Took a while but I believe what I came up with can handle at least ten people.
#Zarina: Really? That's great to hear. 2 of these kids are Pamela's grandchildren and they've been on their own journey to return home.
#Melvin: Mister Shihiro, my name's Melvin and a while back, we found this weird object that allowed us to go through different worlds.
#Katrin: And miss Zarina even said the object might be incomplete, as if there could be more to it.
#Shihiro: Yes, I've heard of this. A few missing pieces for the holes in each knob. But this box itself could've been attached to something bigger.
#Shihiro: We're still not sure what it is, though.
#Pete: Sir, miss Zarina said she was a sorceress. Are you a sorcerer too?
#Shihiro: I've got some powers too, though they more likely relate to combat.

