extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Signals.lives = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_QuitButton_pressed():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")
