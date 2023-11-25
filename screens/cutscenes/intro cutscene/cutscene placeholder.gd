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
#Cutscene 3
#Oscar: Look, they have games. Can we try some of them?
#Carrie: Oscar, we're leaving.
#Borhr: I Apologize for the current situation but please, consider a second visit when things are better
#Borhr: But before you leave, let me give you this: This is a transdimensional translator, it'll help you better communicate with beings from other worlds.
#Melvin: Thanks, maybe we could see you again.

#Borhr: I believe I understand better who is behind this. It's possibly a machine of hate and suffering, one that wants to bring pain accross other worlds. But besides that, there might be other threats putting realities at risk, as previous worlds I've visited no longer exist. We must do something.

#Carrie: Grandma?
#Pamela: Carrie, is that you? Hold on, let me just-

#Pamela: Not again, I was close this time!
#Bernard: So where exactly are they again? How far is this place?
#Shelly: A different reality isn't the same as a different location. The better way to explain it is by using TV channels as an example.
#Carrie: Guess we gotta find the way out on our own again
#
#
#Cutscene 4
#Katrin: Look at the signs, the text is flipped
#Melvin: Guys, you might wanna see this

#Carrie: You think we're gonna meet people like this?
#Angela: Yuck, this looks nasty!

#???: You guys afraid of basic anatomy?
#Alt Angela: Hey, we've finally found our doubles. My group and I saw you a couple times.
#Melvin: Uh, who are you?
#Alt Angela: I'm your sister and you must be Melvin. Guess the ages in each of our groups are different

#Alt Angela: You know, my Oscar and Pete are very atheletic. I wonder about you, Mel.
#
#Cutscene 5
#Alt Oscar: Wait, you guys are leaving already?
#Melvin: We're on a journey to return home. Maybe we could meet again but we have things to take care of.
#Alt Pete: Alright! Have fun in that journey of yours.
#Melvin: Wonder why this new placel looks so dark.

#
#
#Cutscene 6
#Angela: I'm not liking this place
#Oscar: I think i heard someone
#CREEPY_GUY_NAME/Creepy guy/Homem assustador: Hey boys and girls! How about each one of you give this old man a good time, huh?
#CREEPY_GUY_NAME: ARRGH! Uhhhh.

#Booker: Any of you alright? You're not from here, are you?
#Booker: Either way, let me take you to somewhere safer.

#Booker: My name is Booker Vincent and I'm one of the few sane people in this rotten town. I've been doing my best keeping these streets clean from human waste, even if it meant getting my hands dirty. No point in trusting the cops. I know because I used to be one of them

#Stella: Katrin, Pete, it's me!
#Katrin: Stella, where have you been?
#Stella: I ended up here after stepping on some weird wooden box. This city is scary but thanks to Booker, I'm safe.
#Booker: You two know each other? That's nice. But know that things are rough in the outside and unfortunately, Stella did see some horrors.

#Pete: Hey, who is this gold headed guy?
#Booker: That's "The Bullet". One of the most disgusting freaks I've yet to hunt down. You don't wanna know more.
#Carrie: Mister, do you have a family?
#Booker: I used to have a wonderful wife and daughter, but-
#Angela: MISTER LOOK! THERE'S A GUY BEHIND YOU!

#Booker: Benjamin McCormen! Never expected you to try and find me again. Talk, it'll be the last time you can ever be use to anyone.
#Benjamin: Listen, Booker! It's Phineas, he knows you're here and he brought his pack with him!
#Booker: Uh?
#Phineas: So this is where you're hiding, you miserable prick. 600 men should be enough to send you straight to Hell.

#Booker: Everybody, listen up! This path leads to an escape route that should keep you safe while I take care of Phineas' men.
#Booker: But in case there's a few rats in the sewers, Stella should inform you about the traps I've set up.
#Stella: Don't worry, Booker.
