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
#Leon: But before you leave, let me give you this: This is a transdimensional translator, it'll help you better communicate with beings from other worlds.
#Melvin: Thanks, maybe we could see you again.
#The 6 leave and Borhr turns to Leon and Otto
#Borhr: I believe I understand better who is behind this. It's possibly a machine of hate and suffering, one that wants to bring pain accross other worlds. But besides that, there might be other threats putting realities at risk, as previous worlds I've visited no longer exist. We must do something.
#At Nortubel-ish, the 6 notice a portal
#Carrie: Grandma?
#Pamela: Carrie, is that you? Hold on, let me just-
#The portal vanishes
#Pamela: Not again, I was close this time!
#Bernard: So where exactly are they again? How far is this place?
#Shelly: A different reality isn't the same as a different location. The better way to explain it is by using TV channels as an example.
#Carrie: Guess we gotta find the way out on our own again
#
#
#Cutscene 4
#Katrin: Look at the signs, the text is flipped
#Melvin: Guys, you might wanna see this
#An anatomy book showing "mirrored" anatomy
#Then alt Angela shows up
#Alt Angela: Hey, we've finally found our doubles
#Melvin: Uh, who are you?
#Alt Angela: I'm your sister, and this is you. Guess the ages in each of our groups are different
#The characters compare themselves to their doubles
#Angela mentions alt Oscar/Pete being athletic, this is when the race part beigns
#
#Cutscene 5
#Alt Oscar: Yeah, this was fun but I'm kinda tired
#Alt Pete: Have fun in that journey of yours
#The alt 6 even have their own magic box
#Melvin: Well, might as well try the box again
#Suddenly, the portal takes them to a prison cell
#
#
#Cutscene 6
#Angela: I'm not liking this place
#Creepy guy: Hey you, come here!
#Suddenly the creepy guy is taken down by Booker
#Booker: You better come with me if you want to live
#Booker's van in the road
#Booker: My name is Booker Vincent and I'm one of the few sane people in this rotten town. I've been doing my best keeping these streets clean from human waste, even if it meant doing things the hard way. No point in trusting the cops. I know because I used to be one of them
#Art showing Booker's warehouse/hideout and stuff inside
#Stella: Katrin, Pete, it's me!
#Katrin hugs Stella
#Katrin: Stella, where have you been?
#Stella: I ended up here after stepping on some weird wooden box. This city is scary but thanks to Booker, I'm safe.
#Booker: You two know each other? That's nice. But know that things are rough in the outside and unfortunately, Stella did see some horrors.
#Pete looks at some photos.
#Pete: Hey, who is this gold headed guy?
#Booker: That's "The Bullet". One of the most disgusting freaks I've yet to put down for good. You don't wanna know more.
#Carrie: Mister, do you have a family?
#Booker: I used to have a wonderful wife and daughter, but-
#Angela: MISTER LOOK! THERE'S A GUY BEHIND YOU!
#Booker catches the guy
#Booker: WHAT THE HELL ARE YOU DOING HERE? 
#Guy: Listen, Booker! It's Phineas, he knows you're here and he brought his pack with him!
#Booker looks up a window to see Phineas and some of his men, coming out of cars
#Phineas: Yeah, he better be here. 150 men should be enough to turn this guy into an unrecognizable pile of flesh
#Booker pushes a box
#Booker: You 6 better get here. This place will serve as a escape path while I handle Phinea's men out there
#Booker: And in case some of them are in there, Stella knows out to use the traps I've set up
