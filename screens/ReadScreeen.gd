extends Control

func _ready():
	pass

func _on_TextureButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")


func _on_TextureButton2_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/cutscenes/cutscene 34 nortubel credits/cutscene 34 nortubel credits.tscn")

