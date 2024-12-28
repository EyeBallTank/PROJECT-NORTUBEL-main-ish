extends Node

onready var animationplayer = $AnimationPlayer

func _ready():
	animationplayer.play("TITLE SEQUENCE")
	VisualServer.set_default_clear_color(Color.darkolivegreen)

func changescene():
	SceneManager.change_scene("level_transition_effect", "res://screens/MainMenu.tscn")
