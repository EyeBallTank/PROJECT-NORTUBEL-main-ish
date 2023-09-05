extends Control

onready var menu = $MenuMain
onready var options = $OptionsMenu
onready var password = $PasswordMenu

#1ST LETTERS IN codes NAMES SHOULD BE LOWER CASE AND LETTERS, NOT NUMBERS
#BECAUSE FUNC NAMES CANT START WITH NUMBERS
var codes := [ "gallery",
				"tutor1", "tutor2", "tutor3",
				"c4rr13", "k4tr1n", "m3lv1n",
				"osc4r0", "p33tt3", "ang3l4"]

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
