extends Area2D

#Should probably make it so endlevel doors and such require both player and companion to end level

var player = false
var companion = false

func _ready():
	pass 


func _on_Door_body_entered(body):
	player = body
	player = true
	SceneManager.change_scene("level_transition_effect", "res://src/levels/LevelTemplate3.tscn")
