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
#Carrie: And the city had so many cameras and security.
#Oscar: We also found this thing (Shows book)
#Charles: Wait a second, gimme that. Do you know how big this is? We might have confidential information here.
#Charles: First thing I'm seeing here is information about prisoners... some marked as dead, others as alive...
#Charles: Edwarda Hollenstud... this one's in the unknown category...
#Jerold: That's my mother... she could be alive somewhere.
#Angela: You're the man we saw in the war.
#Pete: I guess we gotta thank you for how we got here.
#Gustav: I don't feel proud that anyone heard our talk in the first place. It means we gotta be more carefull.
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
#Namylea: Well, let me see...
#Namylea: AAHHH!!!
#Melvin: Miss Matdur, are you alright?
#Namylea: MY BACKPACK, OPEN IT UP AND FIND THE FIRST AID KIT! I'LL HANDLE THE REST!!
#Namylea is then seen without her suit, showing her with bandages on her arm.
#Namylea: I'm fine now. But it seems these are voodoo dolls. What I got here now is a knife wound.
#Namylea: I remember interviewing someone from a tribe that made such dolls.
#Namylea: According to him, a way to make sure these dolls won't affect you any longer is to protect them.
#Carrie: How do we do that? Is it just a matter of not hurting the dolls directly?
#Namylea: More than that. If means preventing something else from attacking it.
#Katrin: This place tends to have weird monsters, does that mean we gotta stop them from hurting the dolls?
#Namylea: Could be. If you prevent those monsters from attacking the dolls, maybe the dolls will no longer be connected to you.


#Namylea: It seems the dolls aren't active anymore. We could be safe now.
#Oscar: There's at least one broken doll. Turns out we didn't save someone.
#Carrie: Hey, that's the guy tied to the traffic light back in Krimb-Stone. Poor guy, though I figured he'd be gone already. 
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
#MAKE MOON FROM HERRKOLEVEL4 SKY SHOW UP IN CUTSCENE AND SHOW THE ISLAND

#Katrin: Here is is, another piece. Thank you miss Uulga.
#Katrin: I guess we can go now, though it's a bit soon.
#Uulga: I must go back home. How about another trip on my ship before you all leave?
#Oscar: Yay, that'd be cool.
#On the ship
#Carrie: Miss Uulga... how did you lose your eye.
#Uulga: A few years back, I was fishing and then a sword-shark attacked me.
#Uulga: He stabbed my eye but then I ripped apart his blade and fought him back.
#Uulga: Made myself a nice meal out of what's left of him. But I still had to adapt to my eye loss.
#Pete: Cool, did you keep the blade?
#Uulga: I kept it in the ship's bedroom, above the bed.
#Ship returns to Herrko
#Melvin: Miss Uulga, thank you for helping us. Hope we get to see you again after we return home.
#Uulga: No problem, I gotta thank you all as well. I wouldn't have gone to that island if not for you.
#Angela: Really, but why?
#Uulga: They say that place has some dark secrets that could change everything about this world.
#Uulga: But you kids are outsiders who needed some help. Maybe focusing on that helped.
#Carrie: Well, most of us were scared when we got lost. But after everything we've been through, we realized we don't need fear to hold us back.
#Uulga: Exactly. I could tell there's something in you.
#Katrin: Maybe  we could go. Miss Uulga is there anything you'd like us to do before we leave?
#Uulga: Yes. Come here.
#Uulga hugs them
#Uulga: Go back home safely. I'm sure you kids can do it.
#The 6 leave
#Uulga: I know it won't be the last time I'll ever be in that island.
#Uulga: Still, I can't let fear conquer me.
#Uulga: Besides... I'd like to be a mother some day.
#Nort part 6
#The six could be arguing about their parents before meeting the alt versions
#Oscar: Carrie, is dad alright? Why would mom do something like that?
#Carrie: Oscar, like I said: Mom lost it. Even if she knows it, it's too late.
#Pete: Is that why dad doesn't want to talk with me? Is my entire life wrong?
#Katrin: Pete, don't say that. You have nothing to do with uncle. We stil love you and you love us back. You deserve to be happy and decide your fate.
#Angela: Why didn't you save dad? You could've done something.
#Melvin: Dad's the reason why you barely got to be with mom. He always wanted to go out anyway. Besides, uncle will take care of us.
#Carrie: Uh? What are you guys doing? 
#Alt Angela: This world is becoming less stable, though it was bound to happen.
#Alt Angela: We've been here for longer yet even we don't know what it is.
#Alt Angela: But someone told us that only some could ever return home. Because if 2 universes are too close to each other, one must go.
#Katrin: What are you guys talking about?
#Alt Oscar: It's either your group or ours. At least according to Knoe.
#Alt Oscar: I wish we all got along, we could've forgive you for what happened to Amalia.
#Alt Oscar: But now we got a chance to return home and we're getting desperate.
#Melvin: But we're the ones who have this box.
#Alt Angela: We've also had ours and it's more advanced. In truth, these objects do more than transdimensional travel.
#Alt Angela: They can affect reality too and yours, being an inferior object, might as well be causing issues around you.
#Alt Angela: It could erase you 6 without even knowing. But in our case, we can decide whether or not you get to return home.
#Carrie: You're insane! There's no way any of that is true. Can't you at least wait until my grandma saves my group?
#Alt Angela: The clock is ticking. You're all far behind, as you always were. Goodbye.
#Alt 6 vanish
#Oscar: I don't wanna die, sis! I don't wanna die.
#Katrin: We must figure something quick! Mel!
#Melvin: Hold on, the box is shaking, it seems to be moving towards somewhere.
#Melvin: Whatever it is, we should follow it.

#Katrin: Pete? What are you looking at?
#Pete: It's that thing... what is that?
#Melvin: Looks like a tree trunk... but is that a bone on the side?
#Carrie: Is that a lightning bolt? What's that behind?
#Pete: Looks like one of those transparent pool floaters.. but there's stuff inside.
#Katrin: Is it like those types of fish and sea life, that are transparents and weird looking?
#Angela: It has teeth too. Are those teeth?
#Oscar: He looks creepy... or is it a girl?
#HHGHH: HHHGHHH HHHGGGHHHGHGHG GGHHHH
#Melvin: What is that noise? Let's just get out of here!

#Melvin: Another piece. Let's see if it can help.
#Haunted house shows up
#Oscar: Carrie, I'm scared.
#Pete: This place looks scary. Did we die?
#??????: What difference does it make, when even the dead aren't free from this turmoil?
#Carrie: WHAT WAS THAT?
#??????: Teeheeheheheheheheheheheheee
#Katrin: Knock it off! We know someone's out there!
#??????: Poor souls....
#??????: Never did they know...
#??????: What hit them...
#??????: and it hit them so....
#Melvin: Who are you? I can tell by your voices you're just a bunch of kids.
#??????: Correct, we shall reveal ourselves.
#Kalub and Aliss show up
#Kalub: We are indeed kids.
#Aliss: As we've always been.
#Both: For centuries.
#Katrin: Why are you two blue? What happened?
#Kalub: We don't remember who we were before death...
#Aliss: Only that we might've been humans... like you...
#Angela: Whose house is this? Was it yours?
#Kalub: It's not just a house...
#Aliss: There's a lot more than that...

#Kalub and Aliss: Our group has been captured! Their souls are in danger.
#Melvin: What's going on?
#Kalub: It appears to be a strange ritual taking advantage of the undead.
#Aliss: And we can't interfere, for it is being manipulated by exorcists from the living world.
#Carrie: We're alive, you think you can save them?
#Kalub: We shall be grateful...
#Aliss: And we shall help back in return...

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
#Nort part 9
#Angela: What's going on? Are we coming back to those places?
#Carrie: What if they were right? Reality is falling apart.
#??????: But these effects are temporary. Normalcy can be achieved once again.
#Katrin: Who are you.
#AB-YZ: A simple enough name for me is AB-YZ. My real name can't be translated by your translation device of Hirdrih.
#AB-YZ: I've been watching you ever since you got lost. Oscar even saw me under the from of a red crystal.
#AB-YZ: The device you've used to come across worlds is indeed causing issues, as entities and elements from different worlds are being dragged here.
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
#Avietta: I think Leon and Otto might want to know what's goin on.








