extends Control


func _ready():
	Signals.lives = 3
	Signals.score = 0
#This one seems to work



func _on_QuitButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")
