extends Control

func _ready():
	pass

func _on_Button_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")
