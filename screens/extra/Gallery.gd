extends Control

#In case i get lots of art that could fill this gallery
#And i learn how to do a proper "slide" style of mechanism to switch between images

func _ready():
	pass

func _on_QuitButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")
