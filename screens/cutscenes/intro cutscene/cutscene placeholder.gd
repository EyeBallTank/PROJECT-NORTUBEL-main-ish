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


#Angela: Miss Zarina? Mister Shihiro? What are you-
#Katrin: Not now, Angela. They're busy doing something. They managed to contact Carrie's grandma.
#A portal shows up and moves to pick up the 2
#Zarina: Miss Margareen, it seems the portal worked!
#Shihiro: And we're in your house now.
#Pamela: It seems the portal moved on its own to pick up you 2. Almost like it someone picking up fish with a net.
#Oscar: Grandma, we're here!
#Pamela: Hold on, this portal can only take one person at a time. Shihiro and Zarina could only go at the same time because they were summoning the portal.
#Katrin: Stella, you're closer so you should go first.
#Stella: Alright, here I go!
#Pamela: Good. Carrie, it's your t-
#Something happens, the portal shuts down while the area shakes
#Stella: What happened?
#Pamela: Something caused the portal to close. Perhaps vibrations like it was an earthquake.
#Melvin: The ground is shaking, what's going on?
#The sky spider thing boss shows up

#When the boss is defeated
#Katrin: We did it. We managed to escape. Carrie?
#Carrie: Once more, my grandma couldn't save us... and worse, Shihiro and Zarina aren't here to protect us anymore.
#Melvin: C'mon, Carrie. It's pretty clear your grandma's getting close. And besides, we still have this box.
#Melvin tries the box and opens an portal
#Pete: Hey, look at all those toys. Didn't we see this place before?
#They enter Brinkaedea
#Katrin: I wonder if we'll meet up with Bonka again.
#Monica: Hello, you people are not from here, are you?
#Oscar: Why are you flying?
#Monica: Why aren't you? My name's Monica and flying isn't even my best power.
#Monica: I can make fruits and vegetables of any kind show up out of nowhere. See?
#Angela: How can you do that?
#Monica: When I was a little baby, I felt into a cauldron my mom was using to make soup.
#Shows image of a goofy looking baby inside the cauldron, maybe drawn poorly but acceptable
#Monica: Then I ate all the soup and suddenly got these powers.
#Monica: My friend illou sort of had something similar but instead, he ate crayons and got art powers.
#Also show a goofy drawing of baby illou eating crayons
#illou: "..." while looking disappointed
#Monica: Don't mind illou, he doesn't talk much but he's a great artist.
#Carrie: Do any of you know of a girl named Bonka?
#Monica: We do and her reputation isn't the best. She's known for pulling off prinks and making fun of people.
#Monica: And she isn't always alone while doing it. She has a friend named Puff but she calls him Bonky. Unlike Bonka, Bonky is usually nice and calm.
#Pete: Doesn't seem so nice if he works for a girl that ruins everyone's day.
#Melvin: Maybe Bonka doesn't have any friends except for that guy.
#Katrin: Perhaps she just needs someone to talk. I wonder if Bonky even thought of that.
#Oscar: We saw him before, didn't we Kat? I think he was in that portal before Bonka ran away.
#Katrin: You're right, but we didn't see much of him. Was he a pink rabbit?
#Monica: He is a talking rabbit and much like Bonka, he said he once went to another dimension.
#Monica: He said he went to a planet called "Earth" and a country in it called "Australia".
#Melvin: We are from Earth but I've never heard of Australia.

#Carrie: What is that house? Does Bonka live here?
#Katrin: Aww look at these flowers
#Flowers spray Katrin with water
#Katrin: Aaahh!
#Pete: Well, she is known of pulling off pranks.
#Melvin: That's pretty basic as far as pranks go.
#Oscar: Look at that TV
#Animated TV, stylish presentation and comic style panels, maybe Bonka is dancing
#Bonka: Good morning, ladies and gentleman. It's everyone's favorite prankster and improviser, Bonka Millette!
#Bonka: Today's special guests, if they managed to show up, are a group of 6, all from a countr called "Nortubel"!
#Bonka: Where is Nortubel, you may ask? I don't know and I don't even care.
#Bonka: But after a rather unpleasent time I've had with them, I feel I owe them an apology.
#Bonka: So if you're watching this and you happen to be that group... please! Come inside! I've got plenty of surprises for you!
#Bonka: Bye bye *the tv shuts down*
#Carrie: Alright, let's give her the benefit of the doubt and she what's going on!

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
#Carrie: I don't care, I wanna leave this place.
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
