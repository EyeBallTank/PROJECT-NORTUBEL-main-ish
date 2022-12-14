extends Control

onready var pausemenu = $MenuMain
onready var optionsmenu = $OptionsMenu

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
	get_tree().quit()

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
