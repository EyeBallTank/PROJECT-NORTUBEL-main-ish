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
#CUTSCENE_3_TALK_1/ Look, they have games. Can we try some of them?/ Olha, eles têm jogos. Podemos experimentar alguns deles?
#CUTSCENE_3_TALK_2/ Oscar, we're leaving./ Oscar, nós vamos embora.
#CUTSCENE_3_TALK_3/ I Apologize for the current situation but please, consider a second visit when things are better./ Peço desculpa pela situação atual, mas por favor, considerem uma segunda visita quando as coisas melhorarem.
#CUTSCENE_3_TALK_4/ But before you leave, let me give you this: This is a transdimensional translator, it'll help you better communicate with beings from other worlds./ Mas antes de partirem, deixem-me dar uma coisa: Isto é um tradutor transdimensional, que vos ajudará a comunicar melhor com seres de outros mundos.
#CUTSCENE_3_TALK_5/Thanks, maybe we could see you again./Obrigado, talvez podemos o ver outra vez.
#CUTSCENE_3_TALK_6/I believe I understand better who is behind this. It's possibly a machine of hate and suffering, one that wants to bring pain accross other worlds./Acredito que precebo quem é responsavel. Pode ser uma máquina de ódio e suferimento, que quer trazer miséria para outros mundos.
#CUTSCENE_3_TALK_7/But besides that, there might be other threats putting realities at risk, as previous worlds I've visited no longer exist. We must do something./Mas além disso, pode haver outras ameaças que coloquem realidades em risco, já que mundos anteriores que visitei já mão existem. Nós devemos fazer algo.
#CUTSCENE_3_TALK_8/Grandma?/Avó?
#CUTSCENE_3_TALK_9/Carrie, is that you? Hold on, let me just-/Carrie, estás ai? Espera, deixa-me-
#CUTSCENE_3_TALK_10/Not again, I was close this time!/Outra vez não, estava mais perto desta vez!
#CUTSCENE_3_TALK_11/So where exactly are they again? How far is this place?/Mas onde é que eles estão, mais uma vez? Será tão longe este lugar?
#CUTSCENE_3_TALK_12/A different reality isn't the same as a different location. The better way to explain it is by using TV channels as an example./Uma realidade diferente não é a mesma coisa que um lugar diferente. É melhor fazer a comparação com canais de televisão.
#CUTSCENE_3_TALK_13/A cooking show only runs on channel 2 and is not available in channel 3. If you switched to channel 3, it's as if the cooking show never existed./Um programa de cozinha só aparece no canal 2 e não no 3. Se mudasses para o canal 3, é como se o programa nunca existiu.
#CUTSCENE_3_TALK_14/But one day, the show no longer shows up in channel 2 and is now on 3. Therefore it exists in a different dimension, unrelated to place or time./Mas um dia, o programa para de aparecer no canal 2 e agora está no 3. Por isso, existe numa dimensão diferente, tendo nada a haver com lugar ou tempo.
#CUTSCENE_3_TALK_15/Guess we gotta find the way out on our own again./Parece que temos que encontrar a saída sozinhos. mais uma vez.


#CUTSCENE_4_TALK_1/Look at the signs, the text is flipped./Olhem para os sinais, o texto está virado.
#CUTSCENE_4_TALK_2/Guys, you might wanna see this./Pessoal, é melhor vocês verem isto.
#CUTSCENE_4_TALK_3/You think we're gonna meet people like this?/Acham que vamos conhecer pessoas assim?
#CUTSCENE_4_TALK_4/Yuck, this looks nasty!/Yuck, isso é nojento!
#CUTSCENE_4_TALK_5/You guys afraid of basic anatomy?/Vocês têm medo de anatomia básica ou quê?
#CUTSCENE_4_TALK_6/Hey, we've finally found our doubles. My group and I saw you a couple times./Hey, finalmente encontramos os nossos duplos. O meu grupo e eu vimos você algumas vezes.
#CUTSCENE_4_TALK_7/Uh, who are you?/Uh, quem é você?
#CUTSCENE_4_TALK_8/I'm your sister and you must be Melvin. Guess the ages in each of our groups are different/Eu sou a tua irmã e tu deves ser o Melvin. Acho que as idades em cada um dos nossos grupos são diferentes
#CUTSCENE_4_TALK_9/You know, my Oscar and Pete are very atheletic. I wonder about you, Mel./Sabias que o meu Oscar e Pete são muito atléticos? Gostava de saber se tu também és, Mel.


#CUTSCENE_5_TALK_1/Wait, you guys are leaving already?/Vocês já vão embora?
#CUTSCENE_5_TALK_2/We're on a journey to return home. Maybe we could meet again but we have things to take care of./Estamos numa viajem de volta á casa. Talvez podemos voltar a ver mas temos assuntos para tratar.
#CUTSCENE_5_TALK_3/Alright! Have fun in that journey of yours./Tudo bem! Divirtam-se na vossa viagem.
#CUTSCENE_5_TALK_4/Wonder why this new place looks so dark./Porque é que este sítio é tão escuro?


#CUTSCENE_6_TALK_1/I'm not liking this place./Não gosto deste lugar.
#CUTSCENE_6_TALK_2/I think I heard someone!/Acho que ouvi alguém!
#CREEPY_GUY_NAME/Creepy guy/Homem assustador
#CUTSCENE_6_TALK_3/Hey boys and girls! How about each one of you give this old man a good time, huh?/Hey, rapazes e raparigas! E que tal cada um de vocês dar alguma diversão a este velho, huh?
#ARRGH! Uhhhh...
#CUTSCENE_6_TALK_4/Any of you alright? You're not from here, are you?/Estão todos bem? Não são daqui, pois não?
#CUTSCENE_6_TALK_5/Either way, let me take you to somewhere safer./De qualquer maneira, deixam me levar vos para um lugar seguro.
#CUTSCENE_6_TALK_6/My name is Booker Vincent and I'm one of the few sane people in this rotten town. I've been doing my best keeping these streets clean from human waste, even if it meant getting my hands dirty./O meu nome é Booker Vincent e sou uma das poucas pessoas sãs nesta cidade amaldiçoada. Fiz o meu melhor para manter estas ruas limpas de lixo humano, mesmo enquanto sugar as minhas mãos.
#CUTSCENE_6_TALK_7/No point in trusting the cops. I know because I used to be one of them./Não vale a penar confiar nos policias. Sei disto porque era um deles.
#CUTSCENE_6_TALK_8/Katrin, Pete, it's me!/Katrin, Pete, sou eu!
#CUTSCENE_6_TALK_9/Stella, where have you been?/Stella, onde é que estiveste?
#CUTSCENE_6_TALK_10/I ended up here after stepping on some weird wooden box. This city is scary but thanks to Booker, I'm safe./Aterrei aqui depois de tropeçar numa caixa de madeira qualquer. Esta cidade é assustadora mas graças ao Booker, estou segura.
#CUTSCENE_6_TALK_11/You two know each other? That's nice. But know that things are rough in the outside and unfortunately, Stella did see some horrors./Vocês conhecem-se? Isso é bom. Mas lembrem que o mundo lá fora é uma selvajaria e infelizmente, a Stella viu alguns horrores.
#CUTSCENE_6_TALK_12/Hey, who is this gold headed guy?/Hey, quem é este homem dourado?
#CUTSCENE_6_TALK_13/That's "The Bullet". One of the most disgusting freaks I've yet to hunt down. You don't wanna know more./Ele é o "Bala". Um dos monstros mais nojentos que ainda não cacei. Não queres saber mais.
#CUTSCENE_6_TALK_14/Mister, do you have a family?/Senhor, você tem uma família?
#CUTSCENE_6_TALK_15/I used to have a wonderful wife and daughter, but-/Eu tinha uma mulher e fila maravilhosas, mas-
#CUTSCENE_6_TALK_16/MISTER LOOK! THERE'S A GUY BEHIND YOU!/SENHOR, OLHA! ESTÁ AI UM HOMEM ATRÁS DE SI!
#CUTSCENE_6_TALK_17/Benjamin McCormen! Never expected you to try and find me again. Talk, it'll be the last time you can ever be use to anyone./Benjamim McCormen! Nunca esperei que tu tentasses me encontrar novamente. Fala, será a última vez que poderás ser útil para alguém.
#CUTSCENE_6_TALK_18/Listen, Booker! It's Phineas, he knows you're here and he brought his pack with him!/Ouve, Booker! É o Phineas, ele sabe que estás aqui e trouxe a sua malta com ele!
#Uh?
#CUTSCENE_6_TALK_19/So this is where you're hiding, you miserable prick. 600 men should be enough to send you straight to Hell./Então é aqui que te escondeste, seu idiota miserável. 600 homens devem ser suficientes para mandár-te direto para o Inferno.
#CUTSCENE_6_TALK_20/Everybody, listen up! This path leads to an escape route that should keep you safe while I take care of Phineas' men./Malta, ouvem! Este caminho leva a uma rota de fuga que deverá manter-vos seguros enquanto eu cuido dos homens de Phineas.
#CUTSCENE_6_TALK_21/But in case there's a few rats in the sewers, Stella should inform you about the traps I've set up./Mas em caso que haja alguns ratos nos esgotos, Stella deve informar-vos sobre as armadilhas que montei.
#CUTSCENE_6_TALK_22/Don't worry, Booker. We can handle this situation./Não te preocupes, Booker. Nós podemos lidar com esta situação.


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
