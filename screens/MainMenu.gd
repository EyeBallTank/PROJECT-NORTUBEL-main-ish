extends Control

onready var menu = $MenuMain
onready var options = $OptionsMenu

func _on_StartButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate.tscn")


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
