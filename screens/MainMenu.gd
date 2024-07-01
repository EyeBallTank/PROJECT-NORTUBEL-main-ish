extends Control

onready var menu = $MenuMain
onready var options = $OptionsMenu
onready var password = $PasswordMenu
onready var manualmenu = $ManualMenu

#1ST LETTERS IN codes NAMES SHOULD BE LOWER CASE AND LETTERS, NOT NUMBERS
#BECAUSE FUNC NAMES CANT START WITH NUMBERS
var codes := [ "gallery",
				"tutor1", "tutor2", "tutor3",
				"c4rr13", "k4tr1n", "m3lv1n",
				"osc4r0", "p33tt3", "ang3l4",
				"l3300n", "oott00", "b0rhrr",
				"p4m3l4", "sh3lly", "b3rn4d",
				"b00k3r", "r1c0t0", "phn34s",
				"st3ll4", "z4r1n4", "sh1hr0",
				"h0lm3s", "mcshry", "jol1t4",
				"b4rn3y", "k4rl44",
				"l13fd1", "x444ng", "am4l14",
				"y13g0r", "clr1ty", "kl3rrr",
				"tf00r1", "zrkv1l",
				"d3c4rd", "fl3nnn", "brkstn",
				"m0nic4", "ill0uu", "b0nkyy",
				"b0nk44",
				"cl4ud1", "b0nk3t", "dr1l0u",
				"j3r0ld", "chrl3s", "lmshtn"]

#SOME PASSWORDS TAKE YOU TO CUTSCENES THAT YOU CAN EASILY SKIP
#THIS IS BECAUSE THEY HAPPEN BEFORE CERTAIN LEVELS
#AND IT'S HOW YOU CAN SEE MOST CONTENT
#EXCEPTION FOR THIS IS TUTOR1
#IT TAKES YOU TO THE LEVEL ITSELF BECAUSE
#THE FIRST CUTSCENE IS EASILY AVAILABLE AT THE START BUTTON

func _ready():
	TranslationServer.set_locale("en")

func _on_StartButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/intro cutscene/cutscene placeholder.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()


func show_and_hide(first, second):
	first.show()
	second.hide()

func _on_OptionsButton_pressed():
	show_and_hide(options, menu)


func _on_BackFromOptions_pressed():
	show_and_hide(menu, options)


func _on_Music_value_changed(value):
	volume(1,value)

func _on_Sound_value_changed(value):
	volume(2,value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, linear2db(value)-30)

func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_EN_setting_pressed():
	TranslationServer.set_locale("en")


func _on_PT_setting_pressed():
	TranslationServer.set_locale("pt")


func _on_ReadButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/ReadScreeen.tscn")


func _on_PasswordButton_pressed():
	show_and_hide(password, menu)


func _on_BackFromOptions3_pressed():
	show_and_hide(menu, password)


func _on_LineEdit_text_entered(keyword):
	if !keyword in codes:
		$PasswordMenu/LineEdit.clear()
		return
	$PasswordMenu/LineEdit.clear()
	call(keyword)

func gallery():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/Gallery.tscn")

func tutor1():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTutorial1.tscn")

func tutor2():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTutorial2.tscn")

func tutor3():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTutorial3.tscn")

func c4rr13():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate.tscn")

func k4tr1n():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate2.tscn")

func m3lv1n():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate3.tscn")

func osc4r0():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate4.tscn")

func p33tt3():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate5.tscn")

func ang3l4():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate6.tscn")

func l3300n():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 2 nort hird/Cutscene 2 Nort Hird.tscn")

func oott00():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/hirdrih/HirdrihLevel2.tscn")

func b0rhrr():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/hirdrih/HirdrihLevel3.tscn")


func _on_CreditsButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/CreditsScreeen.tscn")

func p4m3l4():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 3 hird norttwo/Cutscene 3 Hird Nort Two.tscn")

func sh3lly():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/nortubelparttwo/NortPartTwoLevel2.tscn")

func b3rn4d():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 4 norttwo race/cutscene 4 norttwo race.tscn")

func b00k3r():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 5 norttwo krimb/cutscene 5 norttwo krimb.tscn")

func r1c0t0():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/krimbstone/KrimbLevel2.tscn")

func phn34s():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 6 krimb stella/cutscene 6 krimb stella.tscn")

func st3ll4():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 7 krimb nortpartthree/Cutscene 7 Krimb Nortpartthree.tscn")

func z4r1n4():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/nortubelpartthree/NortPartThreeLevel2.tscn")

func sh1hr0():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 8 nortpartthree shihiro/Cutscene 8 Nortpartthree Shihiro.tscn")

func h0lm3s():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 9 nortpartthree massag/Cutscene 9 Nortpartthree Massag.tscn")

func mcshry():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/massagcoav/MassagLevel2.tscn")

func jol1t4():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/massagcoav/MassagLevel3.tscn")

func b4rn3y():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/massagcoav/MassagLevel4.tscn")

func k4rl44():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 10 massag karla/Cutscene 10 Massag Karla.tscn")

func l13fd1():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 11 massag nortpartfour/cutscene 11 massag nortpartfour.tscn")

func x444ng():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/nortubelpartfour/NortPartFourLevel2.tscn")

func am4l14():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 12 nortpartfour amalia/cutscene 12 nortpartfour amalia.tscn")

func y13g0r():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 13 nortpartfour grek/cutscene 13 nortpartfour grek.tscn")

func clr1ty():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/greklovick/GrekLevel2.tscn")

func kl3rrr():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/greklovick/GrekLevel3.tscn")

func tf00r1():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/greklovick/GrekLevel4.tscn")

func zrkv1l():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 14 grek zharkovil/cutscene 14 grek zharkovil.tscn")


func _on_ManualButton_pressed():
		show_and_hide(manualmenu, menu)

func _on_Manual_Quitbutton_pressed():
	show_and_hide(menu, manualmenu)

func d3c4rd():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 15 grek nortpartfive/cutscene 15 grek nortpartfive.tscn")

func fl3nnn():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/nortubelpartfive/NortPartFiveLevel2.tscn")

func brkstn():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 16 nortpartfive spider/cutscene 16 nortpartfive spider.tscn")

func m0nic4():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 17 nortpartfive brink/cutscene 17 nortpartfive brink.tscn")

func ill0uu():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/brinkaedea/BrinkLevel2.tscn")

func b0nkyy():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/brinkaedea/BrinkLevel25.tscn")

func b0nk44():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 18 brink bonkafunhouse/cutscene 18 brink bonkafunhouse.tscn")







