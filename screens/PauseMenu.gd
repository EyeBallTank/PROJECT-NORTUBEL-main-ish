extends Control

onready var pausemenu = $MenuMain
onready var optionsmenu = $OptionsMenu
onready var extra = $ExtraMenu
onready var password = $PasswordMenu
#onready var save_file = SaveFile.g_data

#1ST LETTERS IN codes NAMES SHOULD BE LOWER CASE AND LETTERS, NOT NUMBERS
#BECAUSE FUNC NAMES CANT START WITH NUMBERS
var codes := ["tutor1", "tutor2", "tutor3",
				"c4rr13", "k4tr1n", "m3lv1n",
				"osc4r0", "p33tt3", "ang3l4"]

func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()

func toggle():
	visible = !visible
	get_tree().paused = visible

func _ready():
	hide()

func _on_UnpauseButton_pressed():
	hide()
	get_tree().paused = false

func _on_QuitButton_pressed():
#	get_tree().quit()
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")

func show_and_hide(first, second):
	first.show()
	second.hide()

func _on_OptionsButton_pressed():
	show_and_hide(optionsmenu, pausemenu)

func _on_BackFromOptions_pressed():
	show_and_hide(pausemenu, optionsmenu)


func _on_Music_value_changed(value):
	volume(1,value)

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, linear2db(value)-30)

func _on_Sound_value_changed(value):
	volume(2,value)

func _on_Fullscreen_toggled(button_pressed):
	OS.window_fullscreen = button_pressed


func _on_EN_setting_pressed():
	TranslationServer.set_locale("en")


func _on_PT_setting_pressed():
	TranslationServer.set_locale("pt")


func _on_BackFromOptions2_pressed():
	show_and_hide(pausemenu, extra)


func _on_ExtraButton_pressed():
	show_and_hide(extra, pausemenu)


func _on_SaveButton_pressed():
#	SaveFile.save_data()
	pass

func _on_LoadButton_pressed():
	pass
#	SceneManager.change_scene("level_transition_effect2", SceneManager.loaded_scene)
#	SaveFile.load_data()
#	SceneManager.load_scene()

func _on_GalleryButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/extra/Gallery.tscn")

func _on_PasswordButton_pressed():
	show_and_hide(password, pausemenu)

func _on_BackFromOptions3_pressed():
	show_and_hide(pausemenu, password)


func _on_LineEdit_text_entered(keyword):
	if !keyword in codes:
		$PasswordMenu/LineEdit.clear()
		return
	$PasswordMenu/LineEdit.clear()
	call(keyword)

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
