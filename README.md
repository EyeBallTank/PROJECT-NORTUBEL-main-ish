# PROJECT-NORTUBEL-main

The game I want to make, under Godot 3.5 Win32; GLES3 sort of.

You can play a demo of it here https://eyeballtank.itch.io/project-nortubel make sure to give me feedback.

Code was taken from GDQuest's platformer tutorial series (In which i did finish from the 3 videos, so in a way i still wrote that code), Gonkee's "Jared AI" project and the Cubio demo. I plan to soon try and do my own code and improve on skills when using Godot's tools.

Both main actors have gravity but only one is playable by moving left/right and jumping, while the other can follow you around at a certain distance. The test level is very basic.

All art is placeholder and was made on MSPaint (As of writing this, i'm working on the main characters' sprites and may even show them on other sites that i use).

So far, i want to try and do things on my own, even if i take stuff from somewhere else. I may end up asking for help and assistance, even if that should be done later. Honestly, any help is appreciated and i'm trying to take this in a fun/hobby route as opposed to professionalism. I plan to make this game free.

# What exactly IS Project Nortubel?
A game where the player controls a character, who has to watch out for their younger sibling as they traverse through levels that should be fun and interesting. 

The actual story revolves around a group of 6 friends that get lost in some strange places and as they try to escape or even explore them, they encounter other people.

In general, it's based on a personal project https://www.diffchecker.com/t7GS8iEi/ where i thought of a bunch of characters and ideas, so this game will be centered around elements from the project. Whether or not this becomes a series based around that project and how far it'll grow depends.

Note: In the cutscene placeholder script, you can see planned lines that could show up in cutscenes or at least show hints of the story.
I also have this file with plans for the game in general: https://rentry.co/nortubel-story-plans
# A few current goals (Or rather wishes, to be honest; Will definitely need help) are/were:
Done (Even if it could be better):
* MAIN/PAUSE MENU'S: They exist and have basic features (Start/resume the game, quit game, fullscreen/window options and sound/music settings); Both still need work because of either missing features or needing tweaks and fixes; Aesthetic/art style is also worth considering.
* CHECKPOINT SYSTEM: It works on both characters; It essentially "drags" a character to the right spot. Had to create "spawn" scenes as well so the characters have somewhere else to respawn when it's not a checkpoint.
* SCENE CHANGER: Levels/scenes can change and there's an animation when the transition happens; The end level Door also has an export var for the next level instead of using a specific script.
* BASIC PLAYER MOVEMENT: You can move left/right and jump; Even got a "jump buffer" kinda.
* COMPANION "COMMAND" SYSTEM: Now you hold Q and then press left/down/right to command the Companion into their states (This system in general could be better).
* COMPANION FOLLOWER STATE: It can chase the player with basic AI/platformer movement; If they're close enough to the Player, they can simply stop; Their running speed is slower than the Player's.
* COMPANION JUMP INPUT: You press a specific input (Currently "Z") to make them jump, since it's a safer option than making them automatically jump with conditions like "if on a lower position than the Player's Y axis".
* COMPANION IDLE STATE: In case you want the Companion to stand still; It also has gravity physics.
* COMPANION "RUN AWAY" STATE: Opposite of "Followme" where the Companion runs at the opposite directions.
* COMPANION "INTERACT" COMMAND (THAT IS ALSO USED TO MAKE THEM JUMP): A command where the Companion can have special interactions with certain things; So far, you can make them attach to ladders (If they're touchign them, at least).
* COMPANION CRAWL STATES: The idea is that the Companion would crawl and go to places that the Player can't go to; It could be useful for some scenarios where both characters cooperate while seperate.
* HEALTH: Both characters have Health, can lose health/die and gain health from a pickup (NOT at the same time); Player has more health than Companion (Or at least receives less damage); Both have basic "pain/iframe" animations.
* JUMP PADS: Work on both characters.
* KEYS AND LOCKED DOORS: 3 colored key/door system; Player picks up a key and can make the responding solid door disappear; When changing scene, the Player doesn't carry the key from the previous level which should be good news; Companion can't interact with these yet.
* SWITCHES: Blue for permanent effects, 2 Green switches for "binary" effects and Yellow for "timed" effects; Both characters can interact with switches because they're simply activated by being touched upon.
* LADDERS: Player can climb ladders as you'd expect; Companion can attach to ladders if you press their special interaction command; Companion can also follow/avoid the Player when climbing on ladder, meaning their climbing states have equivalents to the main ones.
* SWIMMING: Basic swimming controls for Player; Companion can swim and even has idle/follow/avoid states under water; Companion's swimming is still odd in some ways but i might fix later; There's also an oxygen system where both characters can die if the oxygen reaches 0 and the meter resets if they leave water but it's not well implemented because i just wrote "oxygen -= 1" in the code and neither Timer nodes or even yield statements are used (Maybe i could improve this in the future).
* PUSHABLE OBJECT: An object that both characters can push with their movement; It also has gravity, so it falls.
* SWINGABLE ROPE: The feature technically works as the Player automatically attaches to it by touch and can quit by jumping; Originally i wanted to add a grappling hook but dropped the idea for something more simple.
* MOVING PLATFORMS: Basic element that works; Some are related to the switches.
* FALLING PLATFORM: It works as you'd expect, even with the use of AnimationPlayer; Only the Player can make it fall, meaning the Companion is not as heavy.
* CONVEYOR FLOOR: As you'd expect, it drags the characters to a direction.
* JUMP-THROUGH PLATFORM: A basic platform concept that exists.
* PORTALS: You go through one and teleport to another.
* ICE FLOOR: Player has icy physics and even carries a somewhat "icy jump" before landing on normal floors; Companion has some icy physics too.
* SLOW FLOOR: Both characters are affected by this and move slowly; Like a reverse to ice floors kinda.
* HEALTH PICKUP: Can heal the Player and Companion but not at the same time.
* SCORE PICKUP: Just a basic coin that adds an int number to the score counter on the screen; Both characters can pick it up and a certain amount of coins adds a new life.
* POWER UPS: So far, there's a temporary invulnerability item that affects both characters at the same time if one picks it up; The floater ring shows above the Player/Companion like an halo to indicate it's active; Tried to fix some bugs so hope they don't still get in the way.
* ENEMIES: So far its a Gecko lizard that moves left and right and simply hurts the characters by touching them; It can also be killed instantly because it has no health.
* LEVEL HAZARDS: There is at least one: A Manowar that simply stays still underwater and harms the characters.
* COMBAT: Player has a basic melee knife attack and the ability to kick a soccer ball that acts as a projectile with physics (And after a while it disappears; This ball also has a limit of uses).
* SOCCER GOAL NET: If the soccer ball enters the net, the net disappears; It's a level object that could have special roles in level design.
* VERY BASIC NPC: So far, it's just characters simply standing and when you're near them, a basic dialogue text box pops up; May or may not have some interactions.
* BACKGROUND: Just a basic sky with clouds.
* MULTIPLE LANGUAGES: Still early but it uses a CSV file (Had to set to UTF 8 but fixed the mixing characters now) and you can switch between English and Portuguese.
* OFF-SCREEN COMPANION INDICATOR/WAYPOINT: When the Companion is off-screen, an Astrolabe shows up pointing at their direction; It looks a bit off so far but i tried my best (And with tricky methods too).
* LIVE SYSTEM: Both characters share the lives meaning if one dies, so does the other; Besides the game-over screen, i also made it so collecting a certain amount of coins adds a new life.
* CUTSCENES: So far it's a "studio intro" basic thing and a placeholder with dialogue but no images but technically got a template with lots of potential.
* PASSWORD SYSTEM: In case i don't get a proper Save/Load system, this will do.
* SPACE/GRAVITY ELEMENTS: At least one level is planned to have this.
* NPC'S AND SIDE CHARACTERS: They're basic but I figured out some good enough stuff.
* INGAME TEXTS: Yellow and brown objects you interact to read stuff.
* INGAME GALLERY: Similar to above.


Not yet:
* SAVE/LOAD: Need to understand clearly how it can work and avoid the least amount of problems.
* LEVEL SELECT/HUB: Not sure exactly how level selection would work.
* "SADNESS" STATE: The idea is that when a character dies, the other is in a "sad state"; This is just a way to "lock" one character when the other is dead, so both respawn when a life is lost.
* HUD/UI DESIGN: Is barely there/needs to be developed and with a proper style.
* SPRITES: Every art here is placehoder art so "real sprites" aren't used yet; The game has 6 main characters being 3 older siblings and 3 younger siblings, so their current sprites reflect that even if they could've been better (They also have the same gameplay); Each level has 2 characters and i use an export var to change the characters on each level.
* BOSS FIGHTS: Will probably be a very complex inclusion.
* DIALOGUE SYSTEM: Will i use the Dialogic addon? Not sure.
* COLLECTABLES: Special objects to be collected for fun is something i'd like to try, like "lore texts" or art gallery stuff.
* NICE VISUALS: It's not just about pretty visuals for the sake of it, things like feedback could be important.
* BACKGROUNDS AND DECORATIONS: Oh yeah, i guess i could add this to the list.
* UNIMPORTANT INTERACTIONS BETWEEN MAIN CHARACTERS: One of those nice little touches like getting the siblings to play a game or read a book etc.
* SOUND/MUSIC: Nothing except for basic sounds for some objects; I do not want voice acting at all, at least.
* BETTER ORGANIZATION BEHIND THE SCENES: Like methods to make the game's inner workings more flexible or supportive of some stuff; It depends if certain stuff is that mandatory and if i can get away with some other methods.
* ALTERNATE/SECRET LEVELS: Ideally, these levels could be an excuse for me to show characters and settings from different worlds.
* SECRETS IN LEVELS: Maybe some could be easy stuff like things hidden behind walls but more interesting secrets need work and thinking.
* BONUS STAGES: I'd also make them timed/optional; An idea i had was top down minigame levels inspired by Binary Land and Chip's Challenge where the player controls 2 characters (With opposite horizontal movement) and face some level design challenges/features but the implementation shouldn't be overly complex; Maybe some fishing minigame could work.
* RIVAL CHARACTERS: Most ambitious idea, because "rivals" in videogames are special ideas that need to be done well and in what is essentially a 2D puzzle game based around escort missions, it might be something really hard; In terms of story, these characters are "alternate dimension" versions of the protagonists.
* VEHICLES: Maybe doesn't have to happen; It'd be a gimmicky, simple thing but i thought of things like Madeira's Toboggan couch/basket/sled hybrids, Paddle boats or even on-rail handcars; I see it as something mechanically simple that it could work for a minigame.

I may end up changing this goal list as well.
Meanwhile, here's some plans for the main story of the game:
https://rentry.co/nortubel-story-plans
https://docs.google.com/document/d/1Ua-ShLy6Z346w-tCx2dfHLl5o2VNHW3KdFtUMO6fTlw/edit#heading=h.4ic3gl7eie3a
SPOILERS, i guess.

# DEFINITELY NEED TO CHANGE/IMPROVE (EVEN IF I NEED HELP FROM OTHERS):
* I tried implementing a Save/Load system but it doesn't work; If you're interested in helping me, you may want to know more about my game's structure and the way i did things since Save/Load stuff is still alien to me.
* The new method of commands (Pressing Q + left/down/right) isn't perfect but it's the alternative to having more buttons to press (One issue it has is if you press Q + left/right when on ice, it stops the sliding like the ball kick attack).
* The current Pause Menu scene isn't AutoLoad/"universal" because it's set as a node under a CanvasLayer scene in each level, so i may have to make this as an actual recurring game scene.
* The Pause Menu doesn't pause the SceneManager's scene changing animation: Therefore the scene changing animation still plays and changes the scene (And i only didn't make the Pause Menu AutoLoad because i don't know how to make it unavailable in certain scenes like the Main Menu).
* If the Player is on a different state type (Like swimming) from the Companion (Like walking normally on floor), then you'll get weird movement from the Companion.
* CHANGED (But maybe could be done better): Current health bars are attached to the main characters but i used CanvasLayer nodes to put them on the screen like a HUD/UI system.
* Small things like how when a Falling Platform disappears or when pushing a Pushable object the Player and Companion have small/subtle physics differences that just look weird.
* I guess the Companion's swimming could be slightly better though right now it doesn't bother me that much. It's okay at least.
* Maybe the Water scene in general is a bit messy.
* There may be a subtle bug on Companion during "Pushing" animation where it returns to "Running" while on PUSHRUN state i guess.
* Level design in general since even if i get enough working/functional mechanics, i need to use them well, make the game fun and be creative.
* Art in general because even if some art here is placeholder/test based, my art skills are still a mess and i try to get creative with weird methods like tracing over 3D models.
* Visuals in general are weird because of the resolution, so the game looks like it has pixels moving/changing on their own; I'm not sure if it has to do with the camera, window or the art (And this issue may get even more complicated to fix because of small details and overlooked things to consider).
* Controls/Inputs need to be better and not feel annoying.
* The soccer ball's bouncing sound may still feel weird, at least based on how many times it should play its sound.
* The sound for the Pushable vase doesn't loop in the way i'd like to, even if it technically works.
* Player and Companion's collision shapes change size when on some states (Like Swimming) which can bring some weird things, specially with swimming.
* The off-screen pointer for the Companion is placed weirdly but i did all i could do based on my knowledge. 
* HerrkoLevel4 has 2 scenes representing a switch and a scene that spawns arrow if said switch is pressed: It technically works but Godot gives red error text for some reason.
* The enemy HerrkoRedGhalbeen has a weird problem where he keeps running right/to a wall instead of actually switching to the left/properly flip based on wall detection.
* I didn't find a way to make HerrkoRedGhalbeen summon GhalbeenArrow probably and have the latter proberly chase the Player as a homing projectile.
* When BrinkRedJester summons BrinkGreenJester, the debugger sends red code about there not being an animation called "abouttosummon" even though it's no where in the code or the nodes used, unless I'm overlooking something.

# Current controls/Inputs:
This is an area that needs to be improved:
* ESC for the Pause Menu.
* Left movement: Left arrow key/A.
* Right movement: Right arrow key/D.
* Jumping and Climbing/Swimming upwards/Quitting ball kick attack: Up arrow key/W.
* Climbing/Swimming downwards/Ball kick attack: Down arrow key.
* "Follow me": Q + Right arrow key.
* "Stand still": Q + Down arrow key.
* "Run away" which is almost opposite to FOLLOWME: Q + Left arrow key.
* Companion jumping and "interactions" like attaching to the Ladder: Z.
* Melee attack: E.

# Credits and shout outs:

Because i either have help from others or take stuff from somewhere, i don't do this alone.

Even if someone isn't directly involved with this or any project, they still had an impact somewhere.

From tutorials and assets or software related to Godot, to stuff around other programs and art tutorial/practice methods.

* Godot demo projects like the "2D Platformer Demo (KinematicBody)" one and the now gone "Cubio" project (One was the source for the Soccer Ball attack and the other was the source for player physics, some used in the ICE state).
* GDQuest (Made a platform tutorial series, in which i made the practice game and took some stuff from it; Did a lot of other tutorial videos and applications)
* HeartBeast (Similar to above, such as how i implemented ladders)
* GameDev With Drew (Godot tutorial videos).
* Samsface (Same as above)
* Jon Topielski (Same as above)
* Gonkee (Again, but also because of the Jared AI project that i took code from)
* Israel Ruiz (Copied code from scene changing tutorial)
* TebyTheCat (Suggesting the use of a Finite State Machine in the code; Feedback that resulted in some updates)
* TheDex (Mod from Godot's Discord)
* TutsByKai (Software tutorials)
* Kenney.nl (Made free assets that were used as reference)
* FreeSound (Good resource for sounds)
* fesliyanstudios (Bullet sound effect)
* ChipTone by SFBGames (Used to make sounds)
* Gluk, font designer from Fontspace (Used the Mikodacs font from there)
* nickkarvounis, Unsplash (Used a real photo for the image used in the game over screen)
* 16BitDev (Used the Main Menu tutorial video as reference, hence the options menu)
* hellofellowjell-0186 (Used a tutorial video to make the jump pad work)
* Dicode1q (Used video and article to improvise player jump physics)
* gamedevwithdrew (Used tutorial videos on adding the health bars)
* strangehorizon on Freesound (Source of Gong sound effect)
* uEffects on Freesound (Source of Soccer Ball Bag sound effect)
* egolessdub on FreeSound (Source for key pickup sound)
* VKProduktion on FreeSound (Source for switch sound)
* SeanSecret on FreeSound (Source for door unlocking sound)
* robbeman on FreeSound (Coin sound effect source)
* frosthardr on FreeSound (Floater ring sound effect source)
* amiga-mark on FreeSound (Health pickup sound effect source)
* magnuswaker on FreeSound (Jumppad sound effect source)
* gt.torre on FreeSound (Soccer net sound source)
* sunflora on FreeSound (Ball bounce sound source)
* nilbul on FreeSound (Water splash sound source)
* Wdomino on FreeSound (Vase push sound source)
* deleted_user_10023915 (Yes) on FreeSound (Player/Companion landing sound source)
* Tissman on FreeSound (Hirdrih NPC sound).
* 00bpp00 on FreeSound (Some sound).
* JuhaniSankari on FreeSound (Road sound for van prefab)
* Jaz_the_MAN_2 on FreeSound (Piano key sound)
* passllooll on FreeSound (Bell sound)
* sunfiredragon on FreeSound (Electric trap sound)
* szpury on FreeSound (Police car sound effect)
* irinairinafomicheva/pixabay (Camera sound)
* imagery2 on FreeSound (Alarm sound)
* lluiset7 on FreeSound (Train horn sound)
* LeMudCrab on FreeSound (Grenade Launcher sound)
* Aegersum on FreeSound (Flamethrower sound)
* AbuNijmeh on FreeSound (Shotgun sound)
* pgi on FreeSound (Minigun sound)
* Xiko__ on FreeSound (Zhark soldier alarm sound)
* Pixabay (Explosion sound)
* decipher8996 (Used tutorial video to make jump-through-platform)
* DevWorm (Used tutorial video on "Top Down AI Enemy Movement" to fix the SWIMMING states for Companion)
* Nkzar (Gave me tips on fixing collision/animation related stuff)
* BrastenXBL (Helping me fix a Timer node situation with the black chicken enemy)
* According-Code-4772 (Helping me with a RigidBody related issue for the grenade dispenser bot)
* soxxoxsmox (Helping me with the Scalper enemy to fix its physics and AI)
* NancokALT (For trying to help me with the Save/Load situation even if we got nowhere)
* SimonKazehaya (Helped me fix a life subtraction issue)
* Armanlex (Assumed that levels were tilted and turns out they were)
* Pigdev (Used tutorial video on moving platform)
* mjbolt (Used tutorial video on Pushable object)
* luke_rs (Used tutorial video on the Swingable Rope)
* useyourillusion_ (Used tutorial video on moving background)
* jeanmakesgames (Used tutorial video on level portals)
* matinator9185/MateuSai (Used tutorial video on the checkpoint system)
* arithmetic1938 (Used tutorial video on Hirdrio enemy's bouncing physics)
* kidscancode (Used an article of theirs as reference for implementing Comp4's ice physics)
* piratechipgames (Used tutorial video on how to implement sounds for the Soccer Ball)
* GameEndeavor (Used tutorial video on Companion off-screen pointer)
* FinePointCGI (Tutorial video about localization)
* clecioespindolagamedev (Used tutorial video on how i could export my game)
* GlitchedCode (Used tutorial video on Password system)
* horbror (Feedback, also for adding a Nortubel reference to his game Dreams of Joy Departed which in turn lead to this game referencing DOJD)
* Slapson/Slapsoff (Faygo cameo)
* MakeHuman/MPFB2 and Posemaniacs (References/resources for art)
* Krita (Main art software i use)
* Various art tutorials from certain channels and artists (Taco1704, Start_yujil, Mikeymegamega, Marc Brunet, ProkoTV, Akihito Yoshitomi, Chommang, Mmmmonexx, tbchoi5020, hodraw_official, Manga_Materials and more)
* FreeDoom, OTEX/ukiro (Used as reference/inspiration for Greklovick)
* Any help i can get from r/Godot, Discord and /agdg/.
* Various media and stuff i took inspiration from and copied.
* Blender and related addons, 3D software and certain models i used even in 2D art.

# ALSO: Feel free to give me Github and Godot related tips in general.
I'm still a newcomer at this because of my complicated schedule, so i'm a bit behind.
Let's hope 2023 will be a more productive year.