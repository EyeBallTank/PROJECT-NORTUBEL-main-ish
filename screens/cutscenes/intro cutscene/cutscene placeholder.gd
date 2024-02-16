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
#Carrie: What is this place?
#Shihiro: It's a beach, almost like any other. I come here by sometimes.
#Shihiro: Sometimes, this place doesn't seem that bad. There are famliar things in this world.
#Katrin: Maybe we could try and have fun here, while nothing happens.
#Katrin: After all, we're in good company. And Carrie's grandma could be close to getting us back.
#Carrie: Sure. Maybe a break here can't be that bad. There's even that empty store with clothes and stuff.


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
